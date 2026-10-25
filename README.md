# โปรเจกต์ Bioinformatics ของ *Clostridium beijerinckii*

Repository วิเคราะห์ข้อมูลทางชีวสารสนเทศของแบคทีเรีย *Clostridium beijerinckii* แบ่งออกเป็น 2 ส่วน

1. **BLASTN Pipeline** — สคริปต์ Bash สำหรับค้นหาความคล้ายของลำดับ DNA
2. **การวิเคราะห์ยีน dnaA** — การจัดเรียงลำดับ DNA และสร้าง phylogenetic tree ด้วย MAFFT และ IQ-TREE

## 1. BLASTN Pipeline

สคริปต์สำหรับค้นหาความคล้ายคลึงของลำดับ DNA โดยใช้โปรแกรม BLAST+ จาก NCBI

### จีโนมอ้างอิง

- **สิ่งมีชีวิต:** *Clostridium beijerinckii* NCIMB 8052
- **NCBI accession:** [NC_009617.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_009617.1)

### โปรแกรมที่ใช้

- Linux หรือ WSL
- NCBI BLAST+ ได้แก่ `makeblastdb`, `blastn` และ `blastdbcmd`
- Bash

### วิธีใช้

1. สร้างฐานข้อมูล BLAST

   ```bash
   bash scripts/build_db.sh
   ```

2. วางไฟล์ลำดับ DNA ในรูปแบบ FASTA ไว้ในโฟลเดอร์ `query_seq/`
3. เริ่มค้นหาด้วยคำสั่ง

   ```bash
   bash scripts/run_blast.sh
   ```

4. ผลการค้นหาจะถูกบันทึกไว้ใน `results/result_blast_loop/`

### ค่าเปอร์เซ็นต์ความเหมือนที่ใช้

สคริปต์กำหนดค่าเปอร์เซ็นต์ความเหมือนขั้นต่ำ (percent identity) ไว้ที่ 50, 60, 70, 80 และ 90 เปอร์เซ็นต์ เพื่อเปรียบเทียบผลการค้นหาภายใต้เกณฑ์ที่ต่างกัน

### ข้อจำกัด

ฐานข้อมูลปัจจุบันมีจีโนมอ้างอิงเพียงหนึ่งจีโนม และลำดับ query ที่ใช้ทดสอบเป็นส่วนหนึ่งของจีโนมอ้างอิงเดียวกัน จึงคาดว่าจะพบผลที่มีความเหมือน 100% การทดสอบนี้มีจุดประสงค์เพื่อตรวจสอบการทำงานของ pipeline ไม่ใช่การค้นพบทางชีววิทยา

## 2. การวิเคราะห์สายวิวัฒนาการของยีน dnaA

ส่วนนี้เปรียบเทียบลำดับยีน `dnaA` ของ *Clostridium beijerinckii* จำนวน 4 สายพันธุ์ และสร้าง phylogenetic tree จากลำดับที่จัดเรียงแล้ว

### ข้อมูลลำดับ DNA

| สายพันธุ์ | Accession |
|---|---|
| NCIMB 8052 | CP000721.1 |
| ATCC 35702 | NZ_CP006777.1 |
| NRRL B-598 | NZ_CP011966.3 |
| NCIMB 14988 | NZ_CP010086.2 |

แต่ละลำดับมีความยาว 1,350 bp

### ขั้นตอนวิเคราะห์

1. เตรียมและรวมลำดับยีน `dnaA` ในรูปแบบ FASTA
2. ใช้ MAFFT จัดเรียงลำดับ DNA (multiple sequence alignment)
3. ใช้ IQ-TREE สร้าง phylogenetic tree ด้วยวิธี Maximum Likelihood
4. ใช้ ModelFinder เพื่อเลือกแบบจำลองการแทนที่นิวคลีโอไทด์
5. ประเมินการสนับสนุนของกลุ่มบนต้นไม้ด้วย ultrafast bootstrap จำนวน 1,000 รอบ

แบบจำลองที่ได้รับเลือกตามค่า BIC คือ HKY+F

### ผลวิเคราะห์

![Phylogenetic tree ของยีน dnaA](results/figures/dnaA_phylogenetic_tree.png)

เปรียบเทียบพบว่า NCIMB 8052 และ ATCC 35702 มีลำดับยีน `dnaA` เหมือนกัน 100% ส่วน NRRL B-598 และ NCIMB 14988 อยู่ในกลุ่มเดียวกันบน phylogenetic tree โดยมีค่า ultrafast bootstrap support เท่ากับ 100

การวิเคราะห์นี้ใช้ข้อมูลเพียง 4 sequences จากยีนเดียว ผลจึงเหมาะสำหรับเปรียบเทียบลำดับยีน `dnaA` ที่นำมาศึกษา และยังไม่เพียงพอที่จะใช้สรุปความสัมพันธ์ทางวิวัฒนาการของจีโนมทั้งหมด

### โปรแกรมที่ใช้

- **NCBI** — ค้นหาและดาวน์โหลดข้อมูลลำดับพันธุกรรม
- **MAFFT** — จัดเรียงลำดับ DNA
- **IQ-TREE** — สร้าง phylogenetic tree และประเมิน bootstrap support
- **Ubuntu / WSL** — ใช้รันคำสั่งและจัดการไฟล์
- **Conda** — จัดการ environment สำหรับโปรแกรม Bioinformatics

## การทำซ้ำการวิเคราะห์

สำหรับงาน BLAST สามารถเรียกใช้สคริปต์ที่อยู่ในโฟลเดอร์ `scripts/` ได้ตามขั้นตอนข้างต้น

สำหรับงานวิเคราะห์ยีน `dnaA` ไฟล์ FASTA ที่เตรียมไว้ใช้เป็นข้อมูลตั้งต้นในการจัดเรียงลำดับและสร้างต้นไม้ ส่วนรูปต้นไม้ที่นำมาแสดงใน README ถูกบันทึกไว้ที่ `results/figures/dnaA_phylogenetic_tree.png`
