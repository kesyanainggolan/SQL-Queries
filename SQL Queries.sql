#---DATABASES---

#MEMBUAT DATABASES
create database tutorial_mysql_yt;

#MELIHAT SEMUA DATABASES YANG ADA DI MYSQL
show databases;

#MENGAKTIFKAN DATABASES YANG AKAN DIGUNAKAN
use tutorial_mysql_yt;

#---TABEL---

#MEMBUAT ATRIBUT TABEL
create table barang
(
	kode int,
    nama varchar(100),
    harga int,
    jumlah int
);

#MELIHAT SEMUA TABEL YANG ADA DI DATABASES
show tables;

#DESKRIPSI TABEL
desc barang;
describe barang;

#MELIHAT CODINGAN SQL UNTUK MEMBUAT TABEL
show create table barang;

#MENGUBAH TABEL

#--menambah kolom
alter table barang
add column deskripsi text;
alter table barang
add column salah text;

#--menghapus kolom
alter table barang
drop column salah;

#--ubah posisi dan nambah digit varchar
alter table barang
modify nama varchar(200) after deskripsi;

alter table barang
modify nama varchar(200) first;

#NOT NULL VALUE (BIASANYA UNTUK PRIMARY KEY)
#notes: karena default kolom boleh null, maka dialter dulu yang ID gaboleh null

alter table barang 
modify kode int not null;

alter table barang 
modify nama varchar(200) not null;

show create table barang;

#MEMBUAT DEFAULT VALUE
alter table barang
modify harga int not null default 0,
modify jumlah int not null default 0;

desc barang;

#default value timestamp
alter table barang
add column waktu_dibuat timestamp not null default current_timestamp;

#MEMASUKKAN VALUE KE TABEL
insert into barang (nama, kode) values ('Jammie', 1);

select * from barang;

#MENGHAPUS TABEL
drop table barang;

#MENGHAPUS VALUE DI DALAM TABEL (TANPA MENGHAPUS TABELNYA)
truncate barang;

#---MEMASUKKAN VALUE KE TABEL---

#--membuat atribut tabel
create table produk(
	id varchar(100) not null,
    nama varchar(100) not null,
    deskripsi text,
    harga int unsigned not null,
    jumlah int unsigned not null default 0,
    dibuat_pada timestamp not null default current_timestamp
);

desc produk;

#--memasukkan satu nilai
insert into produk (id, nama, harga, jumlah) 
values ('P001', 'Mie Ayam Original', 15000, 100);

select * from produk;

insert into produk (id, nama, deskripsi, harga, jumlah)
values ('P002', 'Mie Ayam Bakso Tahu', 'Mie Ayam Original + Bakso Tahu', 20000, 100);

select * from produk;

#--memasukkan beberapa nilai sekaligus
insert into produk (id, nama, harga, jumlah)
values ('P003', 'Mie Ayam Ceker', 20000, 100),
		('P004', 'Mie Ayam Spesial', 25000, 100),
        ('P005', 'Mie Ayam Yamin', 15000, 100);
        
select * from produk;

#---SELECT DATA---

#--semua kolom
select * from produk;

#--memilih beberapa kolom saja
select nama, harga from produk;

#---PRIMARY KEY---

#--membuat primary key dari awal
create table produk(
	id varchar(100) not null,
    nama varchar(100) not null,
    deskripsi text,
    harga int unsigned not null,
    jumlah int unsigned not null default 0,
    dibuat_pada timestamp not null default current_timestamp.
    primary key (id)
);

#--menambahkan primary key pada tabel yang belum ada primary key
alter table produk
add primary key (id);

desc produk;

#--syntax ini akan menghasilkan error karena id adalah kolom primary key tidak boleh ada duplikat
insert into produk (id, nama, harga, jumlah) 
values ('P001', 'Mie Ayam Original', 15000, 300);

#---WHERE CLAUSE---

select * from produk
where nama = 'mie ayam yamin';

select * from produk
where harga = 15000;

select * from produk 
where harga = 15000 or nama = 'mie ayam ceker';

#menambah kolom kategori
alter table produk 
add column kategori enum('Makanan','Minuman','Lain-Lain')
after nama;

#---UPDATE DATA---

SELECT * FROM PRODUK;

#--update 1 baris, menambah value satu kolom 
update produk
set kategori = 'Makanan'
where id = 'P001';

#--update beberapa baris
update produk
set kategori = 'Makanan'
where id in ('P002','P003','P004','P005');


#--mengubah value kolom
update produk
set harga = harga + 5000
where id = 'P005';


#---DELETE VALUE/ROWS---
insert into produk (id, nama, harga, jumlah, kategori) 
values ('P007', 'Es Teh', 5000, 300,'Minuman');

delete from produk
where id ='p007';

#---ALIANSING/AS---

#--menambah alias di kolom
select id as kode, nama from produk;

#menambah alias di tabel (kayak gini nanti banyak kepake di join)
select p.id as 'Kode',
		p.nama as 'Menu',
        p.kategori as 'Jenis'
from produk as p;

#nambah data aja
insert into produk (id, kategori, nama, harga, jumlah) 
values ('P006', 'Makanan', 'Bakso Rusuk', 25000, 200),
		('P007', 'Minuman', 'Es Jeruk', 10000, 300),
        ('P008', 'Minuman', 'Es Campur', 15000, 500),
        ('P009', 'Minuman', 'Es Teh Manis', 5000, 400),
        ('P0010', 'Lain-Lain', 'Kerupuk', 2500, 1000),
        ('P0011', 'Lain-Lain', 'Keripik Udang', 10000, 300),
		('P0012', 'Lain-Lain', 'Es Krim', 5000, 200),
        ('P0013', 'Makanan', 'Mie Ayam Jamur', 20000, 50),
        ('P0014', 'Makanan', 'Bakso Telor', 20000, 150),
        ('P0015', 'Makanan', 'Bakso Jando', 25000, 300);
        
select * from produk;

#---WHERE OPERATOR---

#--perbandingan
select * from produk where jumlah >= 200;
select * from produk where kategori != 'Makanan';

#--logika (and or not)
select * from produk where jumlah > 100 and harga > 15000;
select * from produk where kategori = 'makanan' and harga < 20000;
select * from produk where jumlah >200 or harga > 200000;

#--prioritas dengan parantheses
select * from produk where (kategori = 'Makanan' or harga > 200000) and jumlah > 100;

#notes: defaut and prioritas dulu baru or
select * from produk where kategori = 'Makanan' or harga > 200000 and jumlah > 100;
select * from produk where kategori = 'Makanan' or (harga > 200000 and jumlah > 100);

#like operator
select * from produk where nama like '%mie%';
select * from produk where nama like '%mie';

#null operator (untuk mencari nilai null)
select * from produk where deskripsi is null;
select * from produk where deskripsi is  not null;

#between operator
select * from produk where harga between 10000 and 20000;
select * from produk where harga not between 10000 and 20000;

#in operator (untuk filter satu kolom lebih dari satu value)
select * from produk where kategori in ('makanan','minuman');
select * from produk where kategori not in ('makanan','minuman');
#notes: logika in sama kayak pake operator or
select * from produk where kategori = 'makanan' or kategori = 'minuman';

#---ORDER BY---

SELECT * FROM PRODUK;

#--satu kolom
select * from produk order by kategori;

#--dua kolom (urutan nulis kolom berarti urutin kategori dulu baru harga)
select * from produk order by kategori asc, harga desc; 

#---LIMIT---

#-- limit tanpa ngilangin data di awal (kedua syntax sama aja)
select * from produk order by harga desc limit 5;
select * from produk order by harga desc limit 0,5;

#-- skip beberapa baris query, limit dengan ngilangin 3 data di awal dan ambil 2 data setelahnya
select * from produk order by harga desc limit 3,2;

#---SELECT DISTINCT DATA---

#--satu kolom
select distinct kategori from produk;

#--dua kolom 
select distinct kategori, harga from produk;

#---NUMERIC FUNCTION---

#--mathematical operator
select 10+20 as hasil;
select nama, harga, harga div 1000 as 'Harga (Ribuan)' from produk;

#--mathematical functions
select sin(harga) as 'sin(harga)' from produk;

#---AUTO INCREMENT---

create table data_admin (
	kode int not null auto_increment,
    first_name varchar(200),
    last_name varchar(200),
    primary key(kode)
);

insert into data_admin (first_name, last_name)
values ('Arya', 'Stark'),
		('Peater', 'Bellish'),
        ('Jammie', 'Lannister');
	
select * from data_admin;

#--melihat id data terakhir yang dimasukkan
insert into data_admin(first_name, last_name) values ('Sansa','Stark');
select * from data_admin;
select last_insert_id();

#---STRING FUNCTIONS---
#selengkapnya liat di documentation
select * from produk;
select id, lower(nama) as 'Nama (Huruf Kecil)' from produk;
select id, upper(nama) as 'Nama (Huruf Besar)' from produk;

#--regexp
#mencari kolom nama yang diawali huruf m maupun k
select * from produk where nama regexp '^[mk]';

##mencari kolom nama yang huruf kedua mengandung i atau s
select * from produk where nama regexp '^.[is]';

#mencari kolom nama yang huruf akhir adalah n, k, atau r
select * from produk where nama regexp '[nkr]$';

#mencari kolom nama yang huruf akhir adalah n atau k
select * from produk where nama regexp 'n$|k$';

#mencari kolom nama yang huruf terakhir keduanya u atau i
select * from produk where nama regexp '[ui].$';

#mencari kolom nama yang mungkin (ya/tidak) mengandung huruf e
select * from produk where nama regexp 'e?';

#mencari kolom nama yang mengandung satu atau lebih huruf e
select * from produk where nama regexp 'e+';

#mencari kolom nama yang mengandung satu atau lebih huruf k atau s dalam kata 'B...o'
select * from produk where nama regexp 'B.[ks]+o';

#mencari kolom nama yang mengandung tidak atau satu kali huruf a dan n dalam kata 'Bakso ...'
select * from produk where nama regexp 'Bakso .[an]*';

#mencari kolom nama yang mengandung kata ayam
select * from produk where nama regexp 'ayam';

#mencari kolom nama yang mengandung satu atau tidak huruf L dalam kata 'Te...r'
select * from produk where nama regexp 'Tel*.r'

#DATETIME FUNCTION

#kayanya gaada fungsi extract di mysql versi ini
select id, dibuat_pada, EXTRACT(year from dibuat_pada) as tahun, extract(month from dibuat_pada) as bulan from produk;
desc produk;

#pake fungsi year and month 
select id, year(dibuat_pada) as Tahun, month(dibuat_pada) as Bulan from produk;
select id, date(dibuat_pada) as 'Tanggal' from produk;

#---CONTROL FLOW---

#--case
select id, nama, 
case kategori
	when 'Makanan' then 'Enak'
    when 'Minuman' then 'Segar'
    else 'Tidak Terdefinisi'
    END AS 'Gimana rasanya?'
from produk;

#--if
select id, nama,
	if(harga <=15000, 'Murah', if(harga <=20000, 'Mahal', 'Mahal Banget')) as 'Mahal ga?'
from produk;

select id, nama,
	if(kategori='Makanan', 'Enak', if(kategori='Minuman', 'Segar', 'Tidak Terdefinisi')) as 'Gimana Rasanya?'
from produk;

#--ifnull
select id, nama, ifnull(deskripsi, 'Tidak ada keterangan') as Deskripsi2 from produk;

#---AGGREGATE FUNCTIONS

#--count
#fungsi count itu yang duplicate juga diitung makanya hasil syntax dibawah sama2 15, padahal kan kalo ngitung unik yang kategori cuma 3
select count(id) as 'Total Produk' from produk;
select count(kategori) as 'Total Kategori' from produk;

#ini meskipun hasilnya ga error tapi hasilnya salah karena kolom nama yang harusnya hasil 15 baris jd cuma 1 baris
select count(id) as 'Total Produk', nama from produk;

#--min
select min(harga) as 'Harga Termurah' from produk;

#--max
select max(harga) as 'Harga Termahal' from produk;

#--average
select avg(harga) as 'Rata-Rata Harga' from produk;

#--sum
select sum(jumlah) as 'Total Stok' from produk;

#--count distinct
select count(distinct kategori) from produk;

#---GROUP BY---

select kategori, avg(harga) as 'Rata-Rata Harga' from produk group by kategori;
select kategori, sum(jumlah) as 'Total Stok' from produk group by kategori;

#---HAVING---
select kategori, count(id) as 'Total Produk' from produk group by kategori;
select kategori, count(id) from produk group by kategori having count(id) > 5;

#---CONSTRAINT---
create table customer(
			id int auto_increment not null,
            email varchar(200) not null,
            first_name varchar(200) not null,
            last_name varchar(200),
            primary key (id),
            unique key email_unique(email)
);

desc customer;

#--menambahkan unique key
alter table customer
add constraint email_unique unique (email);

#--menghapus unique key
alter table customer
drop constraint email_unique; 

#--check constraint
#misal lu udah input seluruh data tapi lupa masukkin constraint maka nanti pas mau add constraint dia gabisa kalo ada data ga memenuhi
# kalo udah masukkin constraint di awal dari pas buat tabel maka data yang ga memenuhi gabisa masuk.

#add check constraint
alter table produk
add constraint batas_harga check (harga>500);

desc produk;
select * from produk;
show create table produk;

#data ini gabisa dimasukkin karena ga memenuhi constraint
insert into produk (id, nama, kategori, harga, jumlah)
values ('P0016','Es Milo', 'Minuman', '450', '100');

#drop check constraint
alter table produk
drop constraint batas_harga;

#setelah constraint udah didrop coba masukkin data yang sama lagi tadi

#1. data ini gabisa dimasukkin meskipun constrain udh di drop karena tadi ID nya udah kegenerate pas data gagal masuk jd ganti id baru
insert into produk (id, nama, kategori, harga, jumlah)
values ('P0016','Es Milo', 'Minuman', '450', '100');

#2. data ini udah bisa dimasukkin karena udah pake id baru
insert into produk (id, nama, kategori, harga, jumlah)
values ('P0017','Es Milo', 'Minuman', '350', '100');

#---STRING FUNCTIONS: CONCAT---
select * from produk;
select harga*jumlah as penjualan from produk;
select concat(harga,'x',jumlah,'=', harga*jumlah) as perhitungan_penjualan
        from produk;

select ifnull(nama, 'NULL'),kategori from produk group by kategori;

SHOW TABLES;

#---FOREIGN KEY---

desc produk;

create table wishlist
(
id int not null auto_increment,
id_produk varchar(10) not null,
deskripsi text,
primary key (id),
constraint fk_wishlist_produk
	foreign key (id_produk) references produk (id)
);

desc wishlist;

select * from produk;

#--behaviour  foreign key
insert into wishlist (id_produk, deskripsi) 
values ('P001', 'Makanan Kesukaan');

select * from wishlist;

#--default: retrict
#row di tabel produk yang punya id = P001 gabisa dihapus karena dia udh jadi foreign key di tabel wishlist.
delete from produk where id = 'P001';

#--cascade
insert into produk (id, nama, harga, jumlah, deskripsi) 
values ('Pxxx', 'Indomie Soto', 3500, 20, 'Makanan Kesukaan');
select * from produk;
desc produk;
show create table produk;

insert into wishlist (id_produk, deskripsi) 
values ('Pxxx', 'Makanan Kesukaan');
select * from wishlist;

#cara drop constraint foreign key
alter table wishlist
	drop foreign key fk_wishlist_produk;

show create table wishlist;

desc wishlist;

alter table wishlist
	add constraint fk_wishlist_produk
		foreign key (id_produk) references produk (id)
			on delete cascade on update cascade;

show create table wishlist;

select * from wishlist;
select * from produk;

#kehapus baik di tabel produk maupun wishlist
delete from produk where id = 'Pxxx';

#---JOIN PRODUK---

#--join dengan 1 tabel
#semua kolom
select * from wishlist join produk on (wishlist.id_produk = produk.id);

#beberapa kolom dan alias
select 
	w.id_produk as 'id_barang', 
    w.deskripsi as 'deskripsi', 
    p.nama as 'nama produk', 
    p.harga as 'harga produk'
from wishlist as w 
	join produk as p on (w.id_produk = p.id);

select * from customer;

#--join lebih dari 1 tabel
desc customer;
select * from wishlist;
insert into customer(id, email, first_name, last_name) values (1, 'jonsnow@gmail.com', 'Jon', 'Snow');
select * from wishlist;

alter table wishlist
	add column customer_id int;

alter table wishlist
	add constraint fk_wishlist_customer
		foreign key (customer_id) references customer (id);

desc wishlist;
select * from wishlist;
select*from produk;
select * from customer;

update wishlist
set customer_id = 1 
where id=1;

select * from wishlist
	join produk on (w.id_produk = p.id)
    join customer on (w.customer_id = c.id);


select w.id_produk, c.first_name, p.nama from wishlist as w
	join produk as p on (w.id_produk = p.id)
    join customer as c on (w.customer_id = c.id);

#---TABLE RELATIONS---

#--ONE TO ONE
#ingin join tabel customer dan wallet
#pastikan foreign key penghubung harus unique supaya jadi one to one
#untuk join tabel wallet (pusat) ke customer

desc customer;
#id di tabel cust adalah primary key jadi udah pasti unique

#membuat tabel wallet yang memastikan one-to-one
create table wallet (
	id int not null auto_increment,
    id_customer int not null,
    balance int not null default 0,
    primary key (id),
    unique key fk_id_customer_unique (id_customer), #syntax yang memastikan one-to-one
    constraint fk_customer_wallet 
		foreign key (id_customer) references customer (id)
);

#join one to one
#untuk join tabel wallet (pusat) dan customer 
select * from wallet;
select * from customer;
desc wallet;
insert into wallet (id_customer,balance) values (1, 1000000);

select c.first_name, w.balance from wallet as w
join customer as c on (w.id_customer = c.id);

#--ONE TO MANY
#untuk join tabel produk (utama) dengan kategori

create table kategori (
	id varchar(10) not null,
    nama varchar(100) not null,
    primary key(id)
);

insert into kategori (id, nama)
values ('C001', 'Makanan'),
		('C002', 'Minuman'),
        ('C003', 'Lain-Lain');
        
select * from kategori;

select * from produk;

alter table produk
add column id_kategori varchar(10);

update produk
set id_kategori = 'C001'
where id in ('P001', 'P0013', 'P0014', 'P0015', 'P002', 'P003', 'P004', 'P005','P006');

update produk
set id_kategori = 'C002'
where id in ('P0017', 'P007', 'P008', 'P009');

update produk
set id_kategori = 'C003'
where id in ('P0010', 'P0011','P0012');

select * from produk;

#menambah foreign key di tabel produk
alter table produk
add constraint fk_produk_kategori
	foreign key (id_kategori) references kategori(id);
#notes: foreign key tanpa unique key jadinya bisa one (kategori) to many (produk)
    
desc produk;
select * from kategori;
#join one to many
select * from produk
join kategori on (produk.id_kategori = kategori.id);

select p.id as 'produk_id', p.nama as 'nama produk', k.id as 'kategori_id', k.nama as 'nama kategori' from produk as p
join kategori as k on (p.id_kategori = k.id);

#JENIS JOIN

#--cross join

create table numbers (
	idn int not null auto_increment,
    primary key (idn)
    );

select * from numbers;
insert into numbers values (1), (2), (3);

#membuat tabel perkalian

select * from numbers as num1 cross join numbers as num2;

select num1.idn, num2.idn, (num1.idn * num2.idn) as result from numbers as num1 cross join numbers as num2 
order by num1.idn, num2.idn;
