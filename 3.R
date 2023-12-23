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
