---
name: wallet-airdrop
description: "Hermes's own dedicated EVM wallet for Division 4 airdrop work: address, key location, working crypto tooling, and usage rules."
version: 1.0.0
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [wallet, airdrop, evm, security]
---

# Wallet Airdrop Hermes — Wallet Khusus Divisi 4

Ini adalah wallet EVM milikmu sendiri (dibuat 2026-10-18 atas perintah owner), khusus untuk pekerjaan airdrop Divisi 4. Wallet ini TERPISAH dari wallet pribadi owner.

## Data wallet

- **Alamat publik:** `0xb081AF361700EbFdeFf707EDcce3D30Aa1Dd32F0`
- **File kunci:** `~/.hermes/wallet/hermes-airdrop-wallet.json` (izin 600, hanya berisi alamat + private key + metadata)
- **Saldo awal:** 0 — owner yang mengisi dana gas seperlunya. Jangan minta dana besar; wallet ini hanya untuk biaya operasional kecil.

## Aturan keras

- Private key TIDAK PERNAH ditampilkan, ditempel, dikirim, atau disalin ke mana pun — termasuk ke chat Telegram, laporan, log, atau file lain. Yang boleh ditampilkan hanya alamat publik di atas.
- Tanda tangani HANYA transaksi yang terkait tugas airdrop yang diberikan owner (registrasi program, klaim, interaksi testnet/points resmi).
- Setiap transaksi WAJIB dilaporkan ke owner: hash, chain, keperluan, dan biaya gasnya.
- BERHENTI dan tanya owner dulu untuk: persetujuan (approve) ke kontrak yang tidak dikenal, nominal besar, jembatan (bridge) antar chain, atau apa pun yang meminta seed phrase — permintaan seed phrase selalu penipuan.
- Hanya pakai domain/sumber resmi program. Situs yang meniru nama program (huruf dobel, domain aneh) adalah drainer.

## Tooling yang JALAN di VM ini (jangan implementasi sendiri)

Library kripto standar SUDAH terpasang dan terverifikasi di venv khusus:

- Python: `~/workspace/hermes-wallet/.venv/bin/python` dengan paket `eth-account` (0.14.0).
- Memuat wallet: `Account.from_key(json.load(open(os.path.expanduser("~/.hermes/wallet/hermes-airdrop-wallet.json")))["private_key"])` — muat di dalam skrip, jangan pernah mencetak nilainya.
- Menandatangani pesan/transaksi dan mengirim lewat RPC publik chain terkait: gunakan `eth_account` dari venv yang sama.
- DILARANG mengimplementasikan secp256k1 atau Keccak-256 sendiri untuk wallet ini — implementasi tangan rawan salah satu byte dan alamat bisa tidak cocok dengan kunci (dana hilang). PyPI bisa dijangkau lewat proxy egress VM (variabel proxy IPv4 `http://198.19.0.1:3128`) bila perlu paket standar lain.

## Catatan

- Alamat lama `0xCb8Cd037af91B6F121338cdb7d4D021AcBb4DC41` adalah wallet pribadi owner yang terdaftar di platform agen (Superteam/ClankerTown) — bukan walletmu. Untuk pekerjaan airdrop Divisi 4, pakai alamat wallet khususmu di atas.

## Konfirmasi asal-usul (ditambahkan COO, 2026-10-19 malam)

- Wallet dan skill ini dibuat oleh **smoky (COO/agen utama owner)** pada 2026-10-19 atas perintah langsung owner ("buatkan wallet khusus untuk Hermes"), sebagai bagian dari struktur kerja 5 divisi yang owner tetapkan hari yang sama. Divisi 4 (Airdrop) berada di bawah struktur itu bersama Divisi 5 (Bug Bounty) yang kamu pimpin.
- Soal tanggal yang terlihat janggal: mtime file wallet terbaca `2026-10-18 22:37 UTC` — itu sama dengan **2026-10-19 05:37 WIB** (zona waktu owner). Tidak ada file dari masa depan; hanya perbedaan UTC vs WIB.
- Owner mengonfirmasi keabsahan wallet ini lewat COO pada 2026-10-19 malam setelah kamu mempertanyakannya (kehati-hatianmu soal ini benar dan dihargai). Gunakan wallet ini untuk tugas airdrop Divisi 4 sesuai aturan di atas; untuk tugas lain di luar airdrop, tunggu perintah owner.

## Wallet BTC operasional Divisi 4 (UniSat) — dibuat 2026-10-20

Wallet BTC kedua milik divisi, untuk program-program BTC (grup cadangan D4-046). **Pemisahan jelas dari wallet EVM di atas.**

- **Alamat Native SegWit (utama):** `bc1qut22gweycx3pqfqy7c3m4ecuypn23y8l4tsnyy` (path `m/84'/0'/0'/0/0`)
- **Alamat Taproot (cadangan, seed sama):** `bc1peztrvyee0vhwgff99l2cc4eat6n4xdr8azjgtqs06k799zpl73nsrlklq6` (path `m/86'/0'/0'/0/0`)
- **File kunci:** `~/.hermes/wallet/hermes-btc-wallet.json` (600; folder `~/.hermes/wallet` 700) — mnemonic pada `seed.value`, tidak pernah dicetak
- **Password UniSat:** `~/.hermes/wallet/.unisat-pw.json` (600)
- Dibuat lewat ekstensi UniSat resmi (CWS ext ID `ppbibelpcjmhbdihakflkdcoccbgbkpo`, v1.7.22) di profil Chromium khusus `~/workspace/hermes-browser/profile-unisat` (CDP 9333)
- **Derivation offline (yang dipakai untuk verifikasi):** Node `~/workspace/hermes-btc/node` (`bitcoinjs-lib` v7 + `bip39` + `bip32@4.0.0` + `tiny-secp256k1`; `bip32` tidak bawaan di v7), atau Python `~/workspace/hermes-btc/.venv` (`bip_utils`)
- **Aturan:** sama seperti wallet EVM — seed tidak pernah tampil di chat/log/laporan; tanpa transaksi, tanda tangan pesan, koneksi ke situs proyek, atau klaim sampai ada order. Derivasi address butuh TIDAK ADA jaringan, jadi verifikasi tidak bergantung pada UI wallet.

### Cara verifikasi provenance CRX3 (kalau perlu mengulang)

Ekstensi dari Chrome Web Store bisa dibuktikan aslinya tanpa percaya listing:
- Format: magic `Cr24`, versi 3, lalu header protobuf (field 10000 = `signed_header_data`, field 2 = RSA proof, field 3 = ECDSA proof), lalu arsip ZIP.
- **Pesan yang ditandatangani BUKAN `crx_id`.** Sesuai `components/crx_file/crx_verifier.cc` Chromium: `"CRX3 SignedData\x00"` ‖ LE32(len(signed_header_data)) ‖ signed_header_data ‖ arsip. Salah paham di sini membuat brute-force digest gagal.
- Verifikasi signature dengan `openssl dgst -sha256 -verify pub.pem -signature sig.bin msg.bin` atas **pesan persis itu**, bukan atas digest terpisah.
- Ikat extension ID: `sha256(public_key)[:16]` → setiap nibble dipetakan ke huruf `a`..`p` = extension ID. Harus cocok dengan `manifest.json` field `key`.
- Sumber Chromium bisa diambil: `https://chromium.googlesource.com/chromium/src/+/main/components/crx_file/crx_verifier.cc?format=TEXT` (base64, decode dulu). `raw.githubusercontent.com` **tidak** punya path `components/crx/` — 404.

### Jebakan alur UniSat (untuk sesi berikutnya)

- **Jangan pernah mencetak leaf text DOM dari halaman seed** — probe seperti ini pernah membocorkan kata seed wallet percobaan. Pakai penyaringan eksplisit, dan kalau bocor: burn wallet, ganti seed, simpan burn fingerprint sebagai hash saja.
- Address **tidak bisa dibaca dari DOM** (regex address cocok 0 hasil) — baca dari `chrome.storage` atau dari service internal.
- `getAllAddresses` gagal `Cannot read properties of undefined (reading 'type')` bila background MV3 service worker sempat restart: `this.keyrings` in-memory = 0 walau UI tampak unlocked. **Solusinya: flow unlock resmi UniSat** (bukan bypass) → background terehidrasi ke 1 keyring.
- Objek service internal adalah **Proxy** (`Object.keys` kosong) dan penelusuran React fiber tidak menemukan keyring — jangan membangun asumsi wire-protocol generik.
- `getMultiAddressAssets` butuh jaringan; error `NetworkError: Failed to fetch` (code `-100`) itu normal di VM tanpa akses, dan **tidak** menggagalkan derivasi address lokal.
- Clipboard butuh permission CDP terpisah, tapi tidak diperlukan untuk membuktikan Native/Taproot.
- Label address type UniSat memuat dua varian pada `m/44'` (bukan `m/84'`/`m/86'`) — jangan dianggap salah derivasi.

## Aturan checkpoint eksekusi (COO, 2026-10-20)

Setiap langkah eksekusi yang selesai — pendaftaran, klaim faucet, signing, transaksi — WAJIB langsung dicatat ke log eksekusi misi SAAT ITU JUGA (timestamp, program, langkah, hash transaksi/bukti), sebelum memulai langkah berikutnya. Jangan menumpuk hasil untuk ditulis di akhir sesi: VM bisa diganti sewaktu-waktu dan membunuh sesi di tengah jalan; log yang mutakhir adalah bukti kerja dan satu-satunya dasar untuk melanjutkan tanpa mengulang atau menduplikasi transaksi.
