###第三節：驗證規則設定-3(1)
#我們發現日期有問題的人實在太多了，現在我們只想要把有問題的日期找出來，這時候我們該怎做呢?
#首先，先創造一個新變項，在這裡我們是直接把舊的變數『Wrong.Date_interval』直接洗掉

dat$Wrong.Date_interval = NA
#接著，我們先處理第一個人。先叫出資料來，但其實我們並不一定要先把第一個人的資料存出來，可以透過索引函數直接作業，這樣也可以直接把Wrong.Date_interval填完
#我們先把個案換成第123個人，因為他的變化比較大

i = 123
dat[dat$Patient==levels.Patient[i],c("Patient", "Date", "Wrong.Date_interval")]

#在現在的規則中，第一筆絕對是正確的，故直接先將第一筆填入FALSE，剩下的再想辦法
i = 123
dat[dat$Patient==levels.Patient[i],"Wrong.Date_interval"][1] = FALSE
dat[dat$Patient==levels.Patient[i],c("Patient", "Date", "Wrong.Date_interval")]

#驗證規則設定-3(2)
#透過迴圈，我們能夠從第二筆開始檢查他是否間格不夠。
#值得注意的是，這位病患在『2007-06-26』、『2007-07-23』、『2007-09-26』這三天分別被申報，其間格分別是27與65，雖然『2007-07-23』必須被核刪，但考慮到刪除這天後，『2007-09-26』與『2007-06-26』就相距92天，這是一個可以接受的日期，所以我們必須想一下，該怎麼解決這件事。
#我們可以在迴圈進行時，找尋『Wrong.Date_interval』為FALSE的最後一筆出來，之後並以他為標記做相減
#記得避免遺漏值！

i = 123
dat[dat$Patient==levels.Patient[i],"Wrong.Date_interval"][1] = FALSE
n.date = length(dat[dat$Patient==levels.Patient[i],"Date"])

k = 2
false.dates = dat[dat$Patient==levels.Patient[i] & dat$Wrong.Date_interval == FALSE & !is.na(dat$Wrong.Date_interval),"Date"]
last.date = false.dates[length(false.dates)]
dif = dat[dat$Patient==levels.Patient[i],"Date"][k] - last.date
dat[dat$Patient==levels.Patient[i],"Wrong.Date_interval"][k] = dif < 90

dat[dat$Patient==levels.Patient[i],c("Patient", "Date", "Wrong.Date_interval")]

