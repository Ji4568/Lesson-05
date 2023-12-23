###�m��3�G����Ǩ쪺���s��GFR���ܤƶq
#GFR�b�u�ɶ������@�P�ܤƫܦ��i��O�]�����|�����Y�A�]���ӵ������O�i�H�Q�R�����C
#�]���гz�L��������k��XGFR�����`�ȡA�p�G�X�{�u�ɶ����ܤƹL�j���ȽЧ⥦��X�ӡA����b�ˬd�ɽЩ������I
#�`�N���誺�j��ӮɫD�`�[�F�a�A�@�w�n�ϥζi�ױ���Ƥ~��x���A���i�׳�I

###�m��3����
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
      diff_date = as.numeric(diff_date, units = 'days') # �`�N�n�ন�Ʀr�A�_�h�L�k�۰�
      
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
