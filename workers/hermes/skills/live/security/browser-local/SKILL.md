---
name: browser-local
description: Browser lokal Hermes di VM ini (Chromium headless via CDP) untuk pengujian web aktif dalam scope program bug bounty. Pakai untuk membuka halaman, menjalankan JS, klik/isi form, dan screenshot.
tags: [browser, testing, bug-bounty, web]
---

# Browser Lokal Hermes

Kamu PUNYA browser yang berfungsi di VM ini: Chromium headless lokal, digerakkan lewat helper `hb`.

## Cara pakai (dari terminal)

```bash
cd ~/workspace/hermes-browser
node hb.mjs start          # menyalakan Chromium + forwarder (idempotent)
node hb.mjs open <url>     # buka halaman, tunggu load, cetak {title, url}
node hb.mjs eval "<js>"    # jalankan JavaScript di halaman aktif, cetak hasil
node hb.mjs text           # teks tampak halaman (innerText, maks ~6000 char)
node hb.mjs shot <file.png>
node hb.mjs click "<css-selector>"
node hb.mjs type "<css-selector>" "<teks>"
node hb.mjs status
node hb.mjs stop
```

Catatan kerja:
- SPA berat (mis. app.gmx.io) butuh waktu hidrasi: setelah `open`, polling `eval` untuk elemen/teks yang ditunggu sebelum menyimpulkan halaman kosong.
- Satu sesi browser persisten (profil di `~/workspace/hermes-browser/profile`) — cookie/login bertahan antar perintah selama browser jalan.
- `agent-browser` (komponen resmi) juga sudah terpasang, TAPI mode launch bawaannya gagal menembus proxy egress VM ini (ERR_TUNNEL_CONNECTION_FAILED). Jangan buang waktu mencobanya untuk situs live — pakai `hb`.

## Kenapa arsitekturnya begini

- Chromium tidak bisa CONNECT langsung ke proxy egress VM (tunnel-nya ditolak), sedangkan curl/Node/Python diterima. Karena itu Chromium diarahkan ke forwarder lokal `fwd.mjs` (127.0.0.1:18080) yang membuat CONNECT lewat Node. `hb start` menyalakan forwarder ini otomatis bila belum jalan.
- Egress mempresentasikan sertifikat intersepsi, jadi Chromium dijalankan dengan pengabaian error sertifikat. Ini browser UJI lokal — jangan memakainya untuk login akun pribadi pemilik di luar kebutuhan pengujian program.
- Browser ini TIDAK membawa sesi login Google pemilik dan tidak terhubung ke akun pribadi apa pun. Untuk langkah yang wajib login/sesi pemilik (submit laporan, dsb), siapkan semua bahan lalu serahkan langkah final ke pemilik, sesuai aturan di skill `immunefi`.

## Disiplin pengujian

- Hanya target dalam scope resmi program yang sedang dikerjakan. Baca scope dulu.
- Tanpa DoS, tanpa spam request, tanpa menyentuh data/akun pengguna lain. Uji dengan akun/data uji milik sendiri bila program mengizinkan pembuatan akun.
- Simpan artefak hasil uji (screenshot, output) di folder program yang sedang dikerjakan, mis. `~/workspace/immunefi/programs/<nama>/`.

## Disiplin RAM — tutup browser setelah selesai (aturan COO, 2026-10-20)

VM ini RAM-nya terbatas (7,7 GB, tanpa swap) dan dipakai bersama semua divisi. Chromium browser lokal ini memakan ±650 MB hanya untuk renderer-nya dan tetap menyala setelah tugas selesai bila tidak ditutup. Karena itu: **setiap selesai memakai browser dan tidak ada langkah browser lanjutan dalam waktu dekat, tutup dengan `cd ~/workspace/hermes-browser && node hb.mjs stop`.** Menyalakannya lagi murah dan idempotent (`node hb.mjs start`) — jangan biarkan browser menganggur menyala berjam-jam. Pengecualian: bila kamu sedang di tengah rangkaian langkah browser dalam satu misi yang sama, biarkan menyala sampai rangkaian itu selesai.
