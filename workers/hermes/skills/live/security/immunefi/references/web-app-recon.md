# Recon aset web/app (referensi)

Prosedur dari aset web in-scope (mis. `app.gmx.io`) sampai bahan analisis siap. Semua langkah pasif: curl/DNS/crt.sh plus analisis statis bundle.

## 1. Peta host & subdomain
- Ekstrak daftar aset in-scope dari halaman program (curl + `User-Agent` browser pada `/bug-bounty/<slug>/scope/`). Catat hanya host yang tercantum; host lain yang muncul di kode = catatan saja.
- Subdomain via certificate transparency: `curl -sS "https://crt.sh/?q=%25.<domain>&output=json"` → parse `name_value`, buang wildcard, dedupe, lalu simpan.
- Ambil juga `robots.txt`, `sitemap.xml`, dan header respons (server, CF, redirect) untuk host utama.

## 2. Bundle & enumerasi chunk
- `curl -L` halaman utama dengan UA browser → grep `src="...js"` untuk entry point.
- Vite: entry berukuran kecil dan hanya meng-`import` bootstrap + preload-helper. Unduh keduanya, lalu grep `"\./[A-Za-z0-9_-]+\.js"` pada seluruh JS yang sudah diunduh untuk mendapatkan daftar chunk; unduh semuanya ke `chunks/`. Hitungan wajar ~50–150 file — simpan daftar chunk ke file agar langkah ini bisa diulang.

## 3. Source map → kode sumber asli
- Cek `<nama-chunk>.js.map`. Balasan 200 berarti source map tidak dimatikan dan `sourcesContent` memuat kode TS asli.
- Ekstrak menjadi SATU file teks gabungan dengan delimiter `//=== FILE: <source> ===`, bukan satu file per sumber: puluhan MB source map jadi mudah digrep dan selesai dalam hitungan detik.
- Tulis indeks path sumber non-`node_modules` ke file terpisah untuk grep cepat.

## 4. Pola grep produktif
- Rahasia: `sk_live|pk_live|AIza|ghp_|api[_-]?key|secret|access_token`, plus `NEXT_PUBLIC_*` / `VITE_*`.
- Endpoint & host: `https?://`, `wss://`, `"/api/`, host backend internal (appspot, domain API sendiri), `localhost:<port>`, `.vercel.app` / `.netlify.app`.
- Rute tersembunyi: definisi router (`path:`, `to=`), `/debug`, `/test`, `/admin`, `/internal`, dan path yang hanya muncul di bundle.
- Alur auth & transaksi: endpoint SIWE/session/MFA/passkey/recovery/OAuth, verifikasi signature, `/route/build`, `/scan/transaction`, konstruksi argumen transaksi.

## 5. Menafsirkan hasil
- Source map publik = praktik buruk, umumnya bukan bounty kecuali isinya membocorkan rahasia nyata. Laporkan sebagai catatan recon.
- Rute debug di build produksi: cek responsnya. Shell SPA identik (ukuran sama dengan rute biasa) = bukan temuan; bukti perlu respons berbeda atau kebocoran data.
- Host backend yang dipakai frontend tetapi tidak tercantum sebagai aset in-scope: catat saja. Kirim hanya kalau dampaknya bisa dipetakan ke aset in-scope.

## 6. Kendala perintah (pernah memakan waktu)
- Perintah shell yang sangat panjang (heredoc besar atau one-liner raksasa) diblokir parser terminal. Tulis skrip ke file dengan write_file, lalu jalankan `python3 skrip.py`.
- Skrip ekstraksi harus cepat dan efisien; kalau prosesnya berjalan menit-menitan, perintah bisa berakhir tanpa persetujuan. Satu file gabungan jauh lebih cepat daripada ratusan file kecil.
- Simpan hasil di `~/workspace/immunefi/programs/<slug>/recon/`, bukan di `/tmp` — direktori /tmp tidak bertahan antar sesi.
