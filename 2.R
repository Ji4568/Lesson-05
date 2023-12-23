###第二節：驗證規則設定-2(1)
#接著我們要設定比較複雜的驗證規則。剛剛有說到同一個人每3個月才能申報一次，如果有人太密集了，那就要把他挑出來。
#先想步驟，好好思考該怎樣做?
  
#驗證規則設定-2(2)
#首先，我們需要先創造一個邏輯向量，長度為個案數，填入TRUE或FALSE表示這個人是否需要被Highlight。
#還記得怎樣了解個案數嗎?可以透過函數「levels()」以及函數「length()」的組合，但在最開始的時候我們要先確定變數『Patient』是否為因子，若不是則必須先轉換為因子

class(dat$Patient)

levels.Patient = levels(as.factor(dat$Patient))
n.Patient = length(levels.Patient)
n.Patient

x = rep(NA, n.Patient)
#接著，我們可以透過迴圈函數，檢查每個人所有的申報日期
#還記得上一節課如何教大家寫迴圈函數嗎?先令『i = 1』之後再開始
#我們先抓出第一個病患的data
#需要特別注意的是，『levels.Patient』是文字向量，而『dat$Patient』則是整數向量，雖然在這個案例中直接檢索是可以的，但最好還是先轉換成同樣的屬性比較不會出錯
#由於整數轉文字比較不會出錯，所以最好是把『dat$Patient』轉成文字再比較
i = 1
subdat = dat[dat$Patient==levels.Patient[i],]
subdat

#驗證規則設定-2(3)
#接著，我們要比對日期了，我們可以先排序日期後，再透過後減前計算差距，並把結果儲存成另外一個向量(這裡也可以再做個迴圈)
#如果個案僅申報一筆資料就不用繼續了，所以必須加入條件判斷

i = 1
subdat = dat[dat$Patient==levels.Patient[i],]
n.date = length(subdat$Date)
if (n.date>1) {
  dif = rep(NA, n.date-1)
  for (k in 1:(n.date-1)) {
    dif[k] = subdat$Date[k+1] - subdat$Date[k]
  }
}
dif
#上述這斷程式碼其實可以透過函數「diff()」獲得同樣的結果，但同學必須了解，即使我們不知道有這個函數，還是能透過迴圈暴力完成他
i = 1
subdat = dat[dat$Patient==levels.Patient[i],]
n.date = length(subdat$Date)
if (n.date>1) {
  dif = diff(subdat$Date)
}
dif
## Time differences in days


