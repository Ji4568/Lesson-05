###練習1：設置其他生化質的驗證規則
#請同學完成下列指示，他們都能利用索引函數做到
#請各位同學選1個生化質，並為他設置連續變項的驗證規則
#請同學檢查Stage與MDRD.GFR之關係是否有錯誤
#Stage與GFR之關係：1 - 90以上、2 - 60至90、3 - 30至60、4 - 15至30、5 - 15以下
#整理完後，請將整個檔案輸出，並試著在Excel中看看自己找到的異常???
#注意，請整理自己的程式碼，增加他的可讀性，這樣未來才有多方協做的機會

###練習1答案
#簡單整理成這樣的格式：
#Read data
dat = read.csv("data4_1.csv", header = TRUE, fileEncoding = 'CP950') 

#Rule 1: check date-format
dat$Date = as.Date(dat[,"Date"])
dat$Wrong.Date = is.na(dat$Date)

#Rule 2: check WBC
dat$Wrong.WBC[dat$WBC < 4 | dat$WBC > 9] = TRUE
dat$Wrong.WBC[dat$WBC >= 4 & dat$WBC <= 9] = FALSE

#Rule 3: check Stage & MDRD.GFR
dat$my.Stage[dat$MDRD.GFR >= 90] = 1
dat$my.Stage[dat$MDRD.GFR >= 60 & dat$MDRD.GFR < 90] = 2
dat$my.Stage[dat$MDRD.GFR >= 30 & dat$MDRD.GFR < 60] = 3
dat$my.Stage[dat$MDRD.GFR >= 15 & dat$MDRD.GFR < 30] = 4
dat$my.Stage[dat$MDRD.GFR < 15] = 5
dat$Wrong.Stage = (dat$my.Stage != dat$Stage)
