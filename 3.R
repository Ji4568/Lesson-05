###�ĤT�`�G���ҳW�h�]�w-3(1)
#�ڭ̵o�{��������D���H��b�Ӧh�F�A�{�b�ڭ̥u�Q�n�⦳���D�������X�ӡA�o�ɭԧڭ̸ӫ簵�O?
#�����A���гy�@�ӷs�ܶ��A�b�o�̧ڭ̬O�������ª��ܼơyWrong.Date_interval�z�����~��

dat$Wrong.Date_interval = NA
#���ۡA�ڭ̥��B�z�Ĥ@�ӤH�C���s�X��ƨӡA�����ڭ̨ä��@�w�n����Ĥ@�ӤH����Ʀs�X�ӡA�i�H�z�L���ި�ƪ����@�~�A�o�ˤ]�i�H������Wrong.Date_interval��
#�ڭ̥���Ӯ״�����123�ӤH�A�]���L���ܤƤ���j

i = 123
dat[dat$Patient==levels.Patient[i],c("Patient", "Date", "Wrong.Date_interval")]

#�b�{�b���W�h���A�Ĥ@������O���T���A�G�������N�Ĥ@����JFALSE�A�ѤU���A�Q��k
i = 123
dat[dat$Patient==levels.Patient[i],"Wrong.Date_interval"][1] = FALSE
dat[dat$Patient==levels.Patient[i],c("Patient", "Date", "Wrong.Date_interval")]

#���ҳW�h�]�w-3(2)
#�z�L�j��A�ڭ̯���q�ĤG���}�l�ˬd�L�O�_���椣���C
#�ȱo�`�N���O�A�o��f�w�b�y2007-06-26�z�B�y2007-07-23�z�B�y2007-09-26�z�o�T�Ѥ��O�Q�ӳ��A�䶡����O�O27�P65�A���M�y2007-07-23�z�����Q�֧R�A���Ҽ{��R���o�ѫ�A�y2007-09-26�z�P�y2007-06-26�z�N�۶Z92�ѡA�o�O�@�ӥi�H����������A�ҥH�ڭ̥����Q�@�U�A�ӫ��ѨM�o��ơC
#�ڭ̥i�H�b�j��i��ɡA��M�yWrong.Date_interval�z��FALSE���̫�@���X�ӡA����åH�L���аO���۴�
#�O�o�קK��|�ȡI

i = 123
dat[dat$Patient==levels.Patient[i],"Wrong.Date_interval"][1] = FALSE
n.date = length(dat[dat$Patient==levels.Patient[i],"Date"])

k = 2
false.dates = dat[dat$Patient==levels.Patient[i] & dat$Wrong.Date_interval == FALSE & !is.na(dat$Wrong.Date_interval),"Date"]
last.date = false.dates[length(false.dates)]
dif = dat[dat$Patient==levels.Patient[i],"Date"][k] - last.date
dat[dat$Patient==levels.Patient[i],"Wrong.Date_interval"][k] = dif < 90

dat[dat$Patient==levels.Patient[i],c("Patient", "Date", "Wrong.Date_interval")]
