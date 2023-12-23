###�m��1�G�]�m��L�ͤƽ誺���ҳW�h
#�ЦP�ǧ����U�C���ܡA�L�̳���Q�ί��ި�ư���
#�ЦU��P�ǿ�1�ӥͤƽ�A�ì��L�]�m�s���ܶ������ҳW�h
#�ЦP���ˬdStage�PMDRD.GFR�����Y�O�_�����~
#Stage�PGFR�����Y�G1 - 90�H�W�B2 - 60��90�B3 - 30��60�B4 - 15��30�B5 - 15�H�U
#��z����A�бN����ɮ׿�X�A�øյۦbExcel���ݬݦۤv��쪺���`???
#�`�N�A�о�z�ۤv���{���X�A�W�[�L���iŪ�ʡA�o�˥��Ӥ~���h��󰵪����|

###�m��1����
#²���z���o�˪��榡�G
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