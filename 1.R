###第一節：驗證規則設定-1(1)
#在拿到一筆資料時，第一件事情應該是做資料清理(或稱品質控制)。我們需要先把資料中不應該出現的值給去除，接著再進行分析。
#一般來說，資料進來以後我們會設定驗證規則，如果不符合此一規則就刪除或重新檢視。
#驗證規則主要分為下列幾種：
#不正確的數據(Incorrect data)：如年齡>130歲
#不準確的數據(Inaccurate data)：如年齡實際為50歲的人，被紀錄為60歲
#重複的數據(Duplicate data)：如重複key-in的問卷
#不完整的數據(Incomplete data)：不該遺漏而遺漏的數據
#不一致的數據(Inconsistent data)：如洗腎患者腎絲球過濾率卻有90 ml/min/1.73m2
#違反規則(Rule violations)：如收案日期為2010年以前，卻出現2013年的資料
#在某些領域中，一間公司能否賺錢的重點並非使用多新的統計分析，其最重要的核心價值可能是在資料清理。這時候若你的驗證規則設定的夠仔細，這樣出錯的機率就較低。

#驗證規則設定-1(2)
#我們現在使用一個CKD門診衛教計劃的範例資料，請下載範例資料 “data4_1.csv”。
#這個資料是由門診護理師Key-in填入，按照計劃目標，所有病人每3個月追蹤一次(低於3個月不能給補助)。
#現在你是腎臟醫學會核發衛教補助的承辦人員，你希望了解一下哪些紀錄是有問題的，而找到這些紀錄後你將要通知該醫院的門診護理師，請他再查閱紙本資料後重新Key-in
#一樣，我們先讀檔進來
dat = read.csv("data4_1.csv", header = TRUE, fileEncoding = 'CP950') 
head(dat)

#驗證規則設定-1(3)
#首先第一步，我們先檢查日期格式，在R裡面剛讀進來的檔案中，日期的格式通常最開始被設定為「因子向量」，這時候是很難檢查的。比較簡單的做法是直接將這個變項轉變為「日期向量」，它需要用到函數「as.Date()」：
class(dat[,"Date"])

dat$Date = as.Date(dat[,"Date"])
#這個步驟可以確保所有內容都成為「日期格式」，如果有非正確的日期，這時候R就會提出警告，詳見下列範例：
test.date = c("2011/01/05", "2011/09/31", "2011/02/29", "2016/02/29")
test.date = as.Date(test.date)
test.date

#因此，在轉換完成後，我們只要確定轉換後的值是否有產生missing value就可以了，我們可以使用函數「is.na()」：
dat$Wrong.Date = is.na(dat$Date)
#所以，現在日期格式錯誤的被紀錄起來了，我們可以透過索引函數叫出錯誤的列讓我們看看
dat[dat$Wrong.Date == TRUE,]
##  [1] Patient       Date          MDRD.GFR      Stage         WBC          
##  [6] RBC           HB            Hct           MCV           Urea.Nitrogen
## [11] Creatinine    Uric.Acid     Na            K             Albumin      
## [16] Wrong.Date   
## <0 列> (或零長度的 row.names)
#在這筆資料中，沒有錯誤的日期格式。（同學可以試試看隨便把原始檔中某一天的日期改成錯誤的，再用同樣的程式碼看看會不會抓到）
#我們稍微整理一下規則1的程式碼，老師會把這串程式碼整理成這樣

dat = read.csv("data4_1.csv", header = TRUE, fileEncoding = 'CP950') 

#Rule 1: check date-format
dat$Date = as.Date(dat[,"Date"])
dat$Wrong.Date = is.na(dat$Date)
#dat[dat$Wrong.Date == TRUE,]

#Rule 2: ...

#驗證規則設定-1(4)
#接著，我們需要檢查各變項的範圍，我們先從類別變項開始。變項『Stage』是指CKD的期別，共有5個期別，所以我們的第二條規則是先確定是否有錯誤的數???
#可以利用之前學過的函數「%in%」，還記得怎麼用嗎?
#下面是精簡的程式碼，函數「!」可以把所有TRUE與FALSE互相調換，所以Wrong.Stage為TRUE的就變成是「不屬於1至5的」
dat$Wrong.Stage = !dat$Stage %in% 1:5



