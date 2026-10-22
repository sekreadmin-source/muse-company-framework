# Seleksi Program Immunefi (referensi)

## Field yang diambil dari daftar publik
| Field | Arti |
| slug | Identifier program; juga URL /bug-bounty/<slug>/ |
| project | Nama proyek |
| maxBounty | Reward maksimum (USD) |
| totalPaidAmount | Total sudah dibayar (indikasi reputasi payout) |
| medianResponseTimeInMinutes | Waktu median tanggap tim proyek |
| kyc | Wajib KYC untuk payout |
| isPayToSubmit | Bayar fee untuk submit |
| pausedAt | Program dijeda (null = aktif) |
| proofOfConceptType | required / optional |
| programType | Smart Contract / Websites and Applications / Blockchain/DLT |

## Eksklusi default
- pausedAt != null → lewati (program dijeda)
- isPayToSubmit = true → lewati, kecuali secara sengaja diminta
- proofOfConceptType = required → siapkan PoC sebelum submit

## Urutan prioritas
1. Aktif (pausedAt null) dan tidak pay-to-submit.
2. maxBounty tinggi (urut menurun).
3. totalPaidAmount tinggi dan respons cepat → reputasi payout baik.

## Tabel reward (baca dari halaman masing-masing, jangan di-hardcode)
- Websites and Applications: Critical / High / Medium — flat atau range, lihat halaman program.
- Smart Contract: Critical sering berbasis persen dana langsung tertumpas dengan cap maksimal; High/Medium fixed range.

## Cara ambil daftar
Gunakan curl dengan `User-Agent` browser pada https://immunefi.com/bug-bounty/ . Beberapa halaman publik memblokir user-agent pengambil web; ambil HTML mentah dan parse payload yang dirender server-side, jangan mengandalkan struktur DOM dari ekstraktor.
