###�m��2�G�ˬdGFR���ܤƶq
#�ܼơyMDRD.GFR�z�O�f�H���ǥ\����СA�@��ӻ��ܤƤ��|�Ӥj�A�ЧA�{�b��l�ܹL�{���ܤƹL�j���H��X��
#�b�p���ܤƶq���ɭԡA�P�ɭn�`�N�l�ܮɶ�����
#�Ч�X�l�ܶ��椤�������@�Ӥ��ܤƶW�L2���H�A��L��X�ӨüW�[�@�ӷs���ܼơyWrong.GFR_interval�z
#�t�~�A�{�b�o�ط������j��̦n�ϥζi�ױ��A�W�`�ұЪ���ơutxtProgressBar()�v�H�Ψ�ơusetTxtProgressBar()�v���n�ѰO��G

n = 100
pb = txtProgressBar(max = n, style=3)
for(i in 1:n) {
  Sys.sleep(0.1)
  setTxtProgressBar(pb, i)
}
close(pb)
###�m��2����
#�o�D�S���Q����²��A�ݭn�`�N���~�T���G
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
    diff_date = as.numeric(diff(subdat$Date), units = 'days') # �`�N�n�ন�Ʀr�A�_�h�L�k�۰�
    slope = diff_eGFR / diff_date * 30
    check = (slope < -2 | slope > 2) # �]�i�H�Ρucheck = abs(slope) > 2�v
    x[i] = TRUE %in% check
  } else {
    x[i] = FALSE
  }
  setTxtProgressBar(pb, i)
}
close(pb)

dat$Wrong.eGFR_change = dat$Patient %in% levels.Patient[x]