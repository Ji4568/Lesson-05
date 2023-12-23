###練習2：檢查GFR的變化量
#變數『MDRD.GFR』是病人的腎功能指標，一般來說變化不會太大，請你現在把追蹤過程中變化過大的人找出來
#在計算變化量的時候，同時要注意追蹤時間間格
#請找出追蹤間格中有平均一個月變化超過2的人，把他找出來並增加一個新的變數『Wrong.GFR_interval』
#另外，現在這種極長的迴圈最好使用進度條，上節課教的函數「txtProgressBar()」以及函數「setTxtProgressBar()」不要忘記喔：

n = 100
pb = txtProgressBar(max = n, style=3)
for(i in 1:n) {
  Sys.sleep(0.1)
  setTxtProgressBar(pb, i)
}
close(pb)
###練習2答案
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
x = rep(NA, n.Patient)

pb = txtProgressBar(max = n, style = n.Patient)
for (i in 1:n.Patient) {
  subdat = dat[dat$Patient==levels.Patient[i],]
  n.date = length(subdat$Date)
  if (n.date>1) {
    diff_eGFR = diff(subdat$MDRD.GFR)
    diff_date = as.numeric(diff(subdat$Date), units = 'days') # 注意要轉成數字，否則無法相除
    slope = diff_eGFR / diff_date * 30
    check = (slope < -2 | slope > 2) # 也可以用「check = abs(slope) > 2」
    x[i] = TRUE %in% check
  } else {
    x[i] = FALSE
  }
  setTxtProgressBar(pb, i)
}
close(pb)

dat$Wrong.eGFR_change = dat$Patient %in% levels.Patient[x]