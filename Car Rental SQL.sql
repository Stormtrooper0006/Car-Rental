CREATE DATABASE PeminjamanMobil
USE PeminjamanMobil

CREATE TABLE Penyewa(
	[No KTP] CHAR(14) PRIMARY KEY,
	Nama VARCHAR(50) NOT NULL,
	[No Telepon] VARCHAR(20) NOT NULL
)

CREATE TABLE Mobil(
	[No Polisi] CHAR(10) PRIMARY KEY,
	[Jenis Mobil] VARCHAR(25) NOT NULL,
	[Harga Sewa] INT NOT NULL
)

CREATE TABLE Kwitansi(
	[No Kwitansi] CHAR(4) PRIMARY KEY,
	[Uang Sejumlah] VARCHAR(20),
	[Tanggal Pinjam] DATE NOT NULL,
	[Tanggal Kembali] DATE NOT NULL,
	[Jam Sewa] CHAR(5) NOT NULL,
	[Jam Kembali] CHAR(5) NOT NULL,
	[Total Biaya] INT,
	[No KTP] CHAR(14) FOREIGN KEY REFERENCES Penyewa([No KTP])
)

ALTER TABLE Kwitansi
ADD CONSTRAINT nokwit CHECK([No Kwitansi] LIKE 'KW[0-9][0-9]')

CREATE TABLE DetailKwitansi (
	[Waktu Sewa] INT NOT NULL,
	[No Polisi] CHAR(10) FOREIGN KEY REFERENCES Mobil([No Polisi]),
	[No Kwitansi] CHAR(4) FOREIGN KEY REFERENCES Kwitansi([No Kwitansi])
)

UPDATE Kwitansi
SET [Total Biaya] = [Harga Sewa]*[Waktu Sewa]
FROM DetailKwitansi, Mobil

INSERT INTO Penyewa VALUES
('0087856433100','Benyamin Gonzales','08956443255632'),
('0056334559611','Alfredo Yeremia','0821334465432'),
('0344007652123','Sakaw Gaming','081234556780'),
('0944355266789','Merlin Ayunda','089677843256'),
('0000432567812','Shakira Himalaya','081233590032')

INSERT INTO Mobil VALUES
('B 2335 ALM','Toyota Fortuner', 900000),
('B 1788 RYM','Toyota Innova', 400000),
('B 2445 MPL','Toyota Avanza',280000),
('B 1188 ADG','Nissan March', 200000),
('B 1339 TYM','Mitsubishi Expander', 400000)

INSERT INTO Kwitansi VALUES
('KW01','600000','2021-01-08','2021-01-10','09.00','09.00','','0944355266789'),
('KW02','1600000','2021-01-13','2021-01-17','11.30','11.30','','0000432567812'),
('KW03','2000000','2021-02-19','2021-02-28','06.30','06.30','','0087856433100'),
('KW04','475000','2021-02-23','2021-02-24','16.00','16.00','','0344007652123'),
('KW05','11270000','2021-03-01','2021-03-11','18.30','18.30','','0056334559611')

INSERT INTO DetailKwitansi VALUES
(1,'B 1339 TYM','KW04'),
(2,'B 2445 MPL','KW01'),
(4,'B 1788 RYM','KW02'),
(9,'B 1188 ADG','KW03'),
(10,'B 2335 ALM','KW05')

CREATE VIEW [Data Penyewa] AS
	SELECT * FROM Penyewa

CREATE VIEW [Data Mobil] AS
	SELECT * FROM Mobil

CREATE VIEW [Data Kwitansi] AS
	SELECT k.[No Kwitansi], 
		   k.[No KTP] ,
		   m.[No Polisi], 
		   m.[Jenis Mobil],
		   k.[Tanggal Pinjam], 
		   k.[Tanggal Kembali], 
		   k.[Jam Sewa], 
		   k.[Jam Kembali],
		   k.[Uang Sejumlah], 
		   kw.[Waktu Sewa], 
		   m.[Harga Sewa], 
		   [Total Biaya]
	FROM Kwitansi k join DetailKwitansi kw ON
	k.[No Kwitansi] = kw.[No Kwitansi] join Mobil m ON
	kw.[No Polisi] = m.[No Polisi]