###練習3：把剛剛學到的推廣到GFR的變化量
#GFR在短時間內有劇烈變化很有可能是因為住院的關係，因此該筆紀錄是可以被刪除的。
#因此請透過類似的方法找出GFR的異常值，如果出現短時間內變化過大的值請把它找出來，之後在檢查時請忽略它！
#注意到剛剛的迴圈耗時非常久了吧，一定要使用進度條函數才能掌握你的進度喔！

###練習3答案
#這題沒有想像中簡單，需要注意錯誤訊息：
#Read data
dat = read.csv("data4_1.csv", header = TRUE, fileEncoding = 'CP950') 

#Rule 1: check date-format
dat$Date = as.Date(dat[,"Date"])
dat$Wrong.Date = is.na(dat$Date)
dat = dat[dat$Wrong.Date == FALSE,]

#Rule 2: check eGFR change
levels.Patient = levels(as.factor(dat$Patient))
n.Patient = length(levels.Patient)
dat$Wrong.eGFR_change = NA

pb = txtProgressBar(max = n.Patient, style=3)

for (i in 1:n.Patient) {
  dat[dat$Patient==levels.Patient[i], "Wrong.eGFR_change"][1] = FALSE
  n.date = length(dat[dat$Patient==levels.Patient[i],"Date"])
  if (n.date>1) {
    for (k in 2:n.date) {
      false.dates = dat[dat$Patient==levels.Patient[i] & dat$Wrong.eGFR_change == FALSE & !is.na(dat$Wrong.eGFR_change),"Date"]
      last.date = false.dates[length(false.dates)]
      diff_date = dat[dat$Patient==levels.Patient[i],"Date"][k] - last.date
      diff_date = as.numeric(diff_date, units = 'days') # 注意要轉成數字，否則無法相除
      
      false.eGFRs = dat[dat$Patient==levels.Patient[i] & dat$Wrong.eGFR_change == FALSE & !is.na(dat$Wrong.eGFR_change),"MDRD.GFR"]
      last.eGFR = false.eGFRs[length(false.eGFRs)]
      diff_eGFR = dat[dat$Patient==levels.Patient[i],"MDRD.GFR"][k] - last.eGFR
      
      slope = diff_eGFR / diff_date * 30
      
      dat[dat$Patient==levels.Patient[i],"Wrong.eGFR_change"][k] = abs(slope) > 2
    }
  }
  setTxtProgressBar(pb, i)
}

close(pb)

