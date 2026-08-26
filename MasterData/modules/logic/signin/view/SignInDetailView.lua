-- chunkname: @modules/logic/signin/view/SignInDetailView.lua

module("modules.logic.signin.view.SignInDetailView", package.seeall)

local SignInDetailView = class("SignInDetailView", BaseView)

function SignInDetailView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._imagesignature = gohelper.findChildImage(self.viewGO, "bg/signature/#image_signature")
	self._goroleitem = gohelper.findChild(self.viewGO, "bg/#go_roleitem")
	self._simagetopicon = gohelper.findChildSingleImage(self.viewGO, "bg/#go_roleitem/#simage_topicon")
	self._goicontip = gohelper.findChild(self.viewGO, "bg/#go_roleitem/#go_icontip")
	self._txtbirtime = gohelper.findChildText(self.viewGO, "bg/#go_roleitem/#txt_birtime")
	self._txtlimit = gohelper.findChildText(self.viewGO, "bg/#go_roleitem/#txt_limit")
	self._txtmonth = gohelper.findChildText(self.viewGO, "content/#txt_month")
	self._txtday = gohelper.findChildText(self.viewGO, "content/#txt_day")
	self._txtdayfestival = gohelper.findChildText(self.viewGO, "content/#txt_day_festival")
	self._imageweek = gohelper.findChildImage(self.viewGO, "content/#image_week")
	self._txtdesc = gohelper.findChildText(self.viewGO, "content/scroll_desc/Viewport/Content/#txt_desc")
	self._simageorangebg = gohelper.findChildSingleImage(self.viewGO, "content/reward/#simage_orangebg")
	self._gobirthdayrewarditem = gohelper.findChild(self.viewGO, "content/reward/#go_birthdayrewarditem")
	self._simagebirthdaybg = gohelper.findChildSingleImage(self.viewGO, "content/reward/#go_birthdayrewarditem/#simage_birthdaybg")
	self._simagebirthdaybg2 = gohelper.findChildSingleImage(self.viewGO, "content/reward/#go_birthdayrewarditem/#simage_birthdaybg2")
	self._gobirthday = gohelper.findChild(self.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday")
	self._gobirthdayHeroContent = gohelper.findChild(self.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/scroll_icon/Viewport/Content")
	self._gobirthdayHeroIcon = gohelper.findChild(self.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/scroll_icon/Viewport/Content/#go_icon")
	self._btngift = gohelper.findChildButtonWithAudio(self.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#btn_gift")
	self._gogiftnoget = gohelper.findChild(self.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#btn_gift/#go_noget")
	self._gogiftget = gohelper.findChild(self.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#btn_gift/#go_get")
	self._goreddot = gohelper.findChild(self.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#btn_gift/#go_reddot")
	self._txtdeco = gohelper.findChildText(self.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/ScrollView/Viewport/#txt_deco")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#simage_signature")
	self._gobirthdayrewarddetail = gohelper.findChild(self.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail")
	self._gocontentSize = gohelper.findChild(self.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize")
	self._trstitle = gohelper.findChild(self.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/bg/title").transform
	self._txtrewarddetailtitle = gohelper.findChildText(self.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/bg/title/#txt_rewarddetailtitle")
	self._gorewardcontent = gohelper.findChild(self.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/Scroll View/Viewport/Content")
	self._gorewarddetailitem = gohelper.findChild(self.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/Scroll View/#go_rewarddetailItem")
	self._godayrewarditem = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem")
	self._simagerewardbg = gohelper.findChildSingleImage(self.viewGO, "content/reward/#go_dayrewarditem/#simage_rewardbg")
	self._gototalreward = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward")
	self._txtdaycount = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/monthtitle/#txt_daycount")
	self._gomonth1 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1")
	self._monthreward1Click = gohelper.getClick(self._gomonth1)
	self._gomonthmask1 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1")
	self._month1canvasGroup = self._gomonthmask1:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._gogetmonthbg1 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#go_getmonthbg1")
	self._gorewardmark1 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#go_rewardmark1")
	self._simagemonthicon1 = gohelper.findChildSingleImage(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#simage_monthicon1")
	self._month1Ani = self._simagemonthicon1.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._txtmonthquantity1 = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#txt_monthquantity1")
	self._txtmonthrewardcount1 = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#txt_monthrewardcount1")
	self._gomonthtip1 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthtip1")
	self._gomonthget1 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthget1")
	self._gonomonthget1 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_nomonthget1")
	self._gomonth2 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2")
	self._monthreward2Click = gohelper.getClick(self._gomonth2)
	self._gomonthmask2 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2")
	self._month2canvasGroup = self._gomonthmask2:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._gogetmonthbg2 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#go_getmonthbg2")
	self._gorewardmark2 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#go_rewardmark2")
	self._simagemonthicon2 = gohelper.findChildSingleImage(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#simage_monthicon2")
	self._month2Ani = self._simagemonthicon2.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._txtmonthquantity2 = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#txt_monthquantity2")
	self._txtmonthrewardcount2 = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#txt_monthrewardcount2")
	self._gomonthtip2 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthtip2")
	self._gomonthget2 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthget2")
	self._gonomonthget2 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_nomonthget2")
	self._gomonth3 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3")
	self._monthreward3Click = gohelper.getClick(self._gomonth3)
	self._gomonthmask3 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3")
	self._month3canvasGroup = self._gomonthmask3:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._gogetmonthbg3 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#go_getmonthbg3")
	self._gorewardmark3 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#go_rewardmark3")
	self._simagemonthicon3 = gohelper.findChildSingleImage(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#simage_monthicon3")
	self._month3Ani = self._simagemonthicon3.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._txtmonthquantity3 = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#txt_monthquantity3")
	self._txtmonthrewardcount3 = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#txt_monthrewardcount3")
	self._gomonthtip3 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthtip3")
	self._gomonthget3 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthget3")
	self._gonomonthget3 = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_nomonthget3")
	self._gocurrentreward = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward")
	self._gonormal = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal")
	self._gonormaldayreward = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward")
	self._gonormalday = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday")
	self._normaldayClick = gohelper.getClick(self._gonormalday)
	self._gonormalday_gold = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday")
	self._normaldayClick_gold = gohelper.getClick(self._gonormalday_gold)
	self._txtnormaldayrewardname = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday/#txt_normaldayrewardname")
	self._simagenormaldayrewardicon = gohelper.findChildSingleImage(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday/#simage_normaldayrewardicon")
	self._normaldayrewardAni = self._simagenormaldayrewardicon.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._txtnormaldayrewardcount = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday/#simage_normaldayrewardicon/#txt_normaldayrewardcount")
	self._gonormaldaysigned = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normaldaysigned")
	self._gonormaldayget = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normaldaysigned/#go_normaldayget")
	self._gonormaldaynoget = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normaldaysigned/#go_normaldaynoget")
	self._gonormaldayreward_gold = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2")
	self._txtnormaldayrewardname_gold = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday/#txt_normaldayrewardname")
	self._simagenormaldayrewardicon_gold = gohelper.findChildSingleImage(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday/#simage_normaldayrewardicon")
	self._normaldayrewardAni_gold = self._simagenormaldayrewardicon_gold.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._txtnormaldayrewardcount_gold = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday/#simage_normaldayrewardicon/#txt_normaldayrewardcount")
	self._gonormaldaysigned_gold = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normaldaysigned")
	self._gonormaldayget_gold = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normaldaysigned/#go_normaldayget")
	self._gonormaldaynoget_gold = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normaldaysigned/#go_normaldaynoget")
	self._normaldayrewardAni_gold = self._simagenormaldayrewardicon_gold.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._gomonthcard = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard")
	self._gomonthcarddayreward = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward")
	self._gomonthcardday = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday")
	self._monthcarddayClick = gohelper.getClick(self._gomonthcardday)
	self._gomonthcardday_gold = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday")
	self._monthcarddayClick_gold = gohelper.getClick(self._gomonthcardday_gold)
	self._txtmonthcarddayrewardname = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday/#txt_monthcarddayrewardname")
	self._simagemonthcarddayrewardicon = gohelper.findChildSingleImage(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday/#simage_monthcarddayrewardicon")
	self._monthcarddayrewardAni = self._simagemonthcarddayrewardicon.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._txtmonthcarddayrewardcount = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday/#simage_monthcarddayrewardicon/#txt_monthcarddayrewardcount")
	self._gomonthcarddaysigned = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcarddaysigned")
	self._gomonthcarddayget = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcarddaysigned/#go_monthcarddayget")
	self._gomonthcarddaynoget = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcarddaysigned/#go_monthcarddaynoget")
	self._gomonthcarddayreward_gold = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2")
	self._txtmonthcarddayrewardname_gold = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday/#txt_monthcarddayrewardname")
	self._simagemonthcarddayrewardicon_gold = gohelper.findChildSingleImage(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday/#simage_monthcarddayrewardicon")
	self._monthcarddayrewardAni_gold = self._simagemonthcarddayrewardicon_gold.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._txtmonthcarddayrewardcount_gold = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday/#simage_monthcarddayrewardicon/#txt_monthcarddayrewardcount")
	self._gomonthcarddaysigned_gold = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcarddaysigned")
	self._gomonthcarddayget_gold = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcarddaysigned/#go_monthcarddayget")
	self._gomonthcarddaynoget_gold = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcarddaysigned/#go_monthcarddaynoget")
	self._gomonthcardreward = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward")
	self._gomonthcardrewarditem = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem")
	self._txtmonthcardname = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem/#txt_monthcardname")
	self._simagemonthcardicon = gohelper.findChildSingleImage(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem/#simage_monthcardicon")
	self._monthcardClick = gohelper.getClick(self._gomonthcardrewarditem.gameObject)
	self._gomonthcardpowerrewarditem = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem")
	self._txtmonthcardcount = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem/#simage_monthcardicon/#txt_monthcardcount")
	self._txtmonthcardpowername = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem/#txt_monthcardname")
	self._simagemonthcardpowericon = gohelper.findChildSingleImage(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem/#simage_monthcardicon")
	self._monthcardpowerClick = gohelper.getClick(self._gomonthcardpowerrewarditem.gameObject)
	self._txtmonthcardpowercount = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem/#simage_monthcardicon/#txt_monthcardcount")
	self._golimittime = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime/#txt_limittime")
	self._gonormallimittimebg = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime/normalbg")
	self._goredlimittimebg = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime/redbg")
	self._gomonthcardsigned = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned")
	self._gomonthcardget = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned/#go_monthcardget")
	self._gomonthcardnoget = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned/#go_monthcardnoget")
	self._gomonthcardpowernoget = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned/#go_monthcardpowernoget")
	self._btnqiehuan = gohelper.findChildButtonWithAudio(self.viewGO, "content/#btn_qiehuan")
	self._goqiehuan = gohelper.findChild(self.viewGO, "content/#btn_qiehuan/#qiehuan")
	self._btncalendar = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_calendar")
	self._btncalendarfestival = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_calendar_festival")
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")
	self._gonodes = gohelper.findChild(self.viewGO, "#go_nodes")
	self._gonodeitem = gohelper.findChild(self.viewGO, "#go_nodes/#go_nodeitem")
	self._btnrewarddetailclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_rewarddetailclose")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gofestivaldecorationtop = gohelper.findChild(self.viewGO, "bg/#go_festivalDecorationTop")
	self._gofestivaldecorationBg = gohelper.findChild(self.viewGO, "bg/#go_festivalDecorationBg")
	self._gofestivaldecorationbottom = gohelper.findChild(self.viewGO, "content/#go_festivalDecorationBottom")
	self._gorewardicon = gohelper.findChild(self.viewGO, "bg/#go_rewardicon")
	self._imgbias = gohelper.findChildImage(self.viewGO, "content/#image_bias")
	self._gosupplement = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_yuekapatch")
	self._gosupplementicon = gohelper.findChild(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_yuekapatch/itemicon")
	self._btnyueka = gohelper.findChildButtonWithAudio(self.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_yuekapatch/#btn_yueka")
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._viewAniEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	self._goeffect = gohelper.findChild(self.viewGO, "#go_effect")
	self._gobgeffect = gohelper.findChild(self.viewGO, "bg_effect")

	local guideGMNode = GMController.instance:getGMNode("signindetailview", gohelper.findChild(self.viewGO, "content"))

	if guideGMNode then
		self._btnswitchdecorate = gohelper.findChildButtonWithAudio(guideGMNode, "#_btns_switchdecorate")
	end

	self._godayrewarditem_image3 = gohelper.findChild(self._godayrewarditem, "image3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SignInDetailView:addEvents()
	self._btngift:AddClickListener(self._btngiftOnClick, self)
	self._btnqiehuan:AddClickListener(self._btnqiehuanOnClick, self)
	self._btnrewarddetailclose:AddClickListener(self._onBtnRewardDetailClick, self)
	self._btncalendar:AddClickListener(self._btncalendarOnClick, self)
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)

	if self._btnswitchdecorate then
		self._btnswitchdecorate:AddClickListener(self._onBtnChangeDecorate, self)
	end

	self._btncalendarfestival:AddClickListener(self._btncalendarOnClick, self)
	self._btnyueka:AddClickListener(self._onBtnBuQian, self)
end

function SignInDetailView:removeEvents()
	self._btngift:RemoveClickListener()
	self._btnqiehuan:RemoveClickListener()
	self._btnrewarddetailclose:RemoveClickListener()
	self._btncalendar:RemoveClickListener()
	self._btncloseview:RemoveClickListener()

	if self._btnswitchdecorate then
		self._btnswitchdecorate:RemoveClickListener()
	end

	self._btncalendarfestival:RemoveClickListener()
	self._btnyueka:RemoveClickListener()
end

function SignInDetailView:_onBtnChangeDecorate()
	self:_switchFestivalDecoration(not self._haveFestival)
end

function SignInDetailView:_onBtnBuQian()
	local currencyParam = {}
	local item = {
		isHideAddBtn = true,
		id = StoreEnum.SupplementMonthCardItemId,
		type = MaterialEnum.MaterialType.SpecialExpiredItem
	}

	table.insert(currencyParam, item)
	SignInController.instance:showPatchpropUseView(MessageBoxIdDefine.SupplementMonthCardUseTip, MsgBoxEnum.BoxType.Yes_No, currencyParam, self._useSupplementMonthCard, nil, nil, self, nil, nil, SignInModel.instance:getCanSupplementMonthCardDays())
end

function SignInDetailView:_useSupplementMonthCard()
	SignInRpc.instance:sendSupplementMonthCardRequest()
end

function SignInDetailView:_btngiftOnClick()
	local birthdayHeros = SignInModel.instance:getSignBirthdayHeros(self._targetDate[1], self._targetDate[2], self._targetDate[3])

	if self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] then
		local heroId = SignInModel.instance:getCurDayBirthdayHeros()[self._index]
		local giftGet = SignInModel.instance:isHeroBirthdayGet(heroId)

		if not giftGet then
			self._startGetReward = true

			SignInRpc.instance:sendGetHeroBirthdayRequest(heroId)

			return
		end
	end

	self:_showBirthdayRewardDetail()
end

function SignInDetailView:_showBirthdayRewardDetail()
	gohelper.setActive(self._gobirthdayrewarddetail, true)
	gohelper.setActive(self._btnrewarddetailclose.gameObject, true)

	local birthdayHeros = SignInModel.instance:getSignBirthdayHeros(self._targetDate[1], self._targetDate[2], self._targetDate[3])
	local heroId = ((self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] or nil) and SignInModel.instance:getCurDayBirthdayHeros())[self._index]
	local birthdayCount = SignInModel.instance:getHeroBirthdayCount(heroId)
	local index = birthdayCount

	if self._curDate.month == self._targetDate[2] then
		local birthdayGet = SignInModel.instance:isHeroBirthdayGet(heroId)

		index = self._curDate.year == self._targetDate[1] and (birthdayGet and birthdayCount or birthdayCount + 1) or birthdayGet and birthdayCount - 1 or birthdayCount
	end

	if not index or index == 0 then
		index = 1
	end

	local rewardStr = string.split(HeroConfig.instance:getHeroCO(heroId).birthdayBonus, ";")[index]
	local rewards = string.split(rewardStr, "|")

	self:_hideAllRewardTipsItem()

	for k, itemCo in ipairs(rewards) do
		local item = self._rewardTipItems[k]

		if not item then
			local o = {}

			o.go = gohelper.clone(self._gorewarddetailitem, self._gorewardcontent, "item" .. k)

			local icon = gohelper.findChild(o.go, "icon")

			o.icon = IconMgr.instance:getCommonItemIcon(icon)

			table.insert(self._rewardTipItems, o)
		end

		gohelper.setActive(self._rewardTipItems[k].go, true)

		local splitCo = string.split(itemCo, "#")
		local config, icon = ItemModel.instance:getItemConfigAndIcon(splitCo[1], splitCo[2])

		self._rewardTipItems[k].icon:setMOValue(splitCo[1], splitCo[2], splitCo[3], nil, true)
		self._rewardTipItems[k].icon:setScale(0.6)
		self._rewardTipItems[k].icon:isShowQuality(false)
		self._rewardTipItems[k].icon:isShowCount(false)

		gohelper.findChildText(self._rewardTipItems[k].go, "name").text = config.name
		gohelper.findChildText(self._rewardTipItems[k].go, "name/quantity").text = luaLang("multiple") .. splitCo[3]
	end

	self:_computeRewardsTipsContainerHeight(#rewards)
end

function SignInDetailView:_hideAllRewardTipsItem()
	for _, item in ipairs(self._rewardTipItems) do
		gohelper.setActive(item.go, false)
	end
end

function SignInDetailView:_computeRewardsTipsContainerHeight(itemCount)
	local titleHeight = recthelper.getHeight(self._trstitle)
	local itemHeight = recthelper.getHeight(self._gorewarddetailitem.transform)
	local height = titleHeight + itemCount * itemHeight - 10

	recthelper.setHeight(self._gocontentSize.transform, height)
end

function SignInDetailView:_btnqiehuanOnClick()
	local birthdayHeros = SignInModel.instance:getSignBirthdayHeros(self._targetDate[1], self._targetDate[2], self._targetDate[3])

	self._index = (self._index + 1) % (#((self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] or nil) and SignInModel.instance:getCurDayBirthdayHeros()) + 1)

	UIBlockMgr.instance:startBlock("signshowing")
	TaskDispatcher.runDelay(self._onQiehuanFinished, self, 0.85)

	if self._index == 1 then
		self:_setRewardItems()
		self._viewAnim:Play("tobirthday", 0, 0)
	elseif self._index > 1 then
		self._viewAnim:Play("birthtobirth", 0, 0)
	else
		self._viewAnim:Play("tonormal", 0, 0)
	end
end

function SignInDetailView:_onQiehuanFinished()
	UIBlockMgr.instance:endBlock("signshowing")
end

function SignInDetailView:_btncalendarOnClick()
	self._viewAnim:Play("out")
	TaskDispatcher.runDelay(self._waitOpenSignInView, self, 0.2)
end

function SignInDetailView:_waitOpenSignInView()
	SignInController.instance:openSignInView(self.viewParam)
	self:closeThis()
end

function SignInDetailView:_btncloseviewOnClick()
	self:_onEscapeBtnClick()
end

function SignInDetailView:_onBtnRewardDetailClick()
	gohelper.setActive(self._btnrewarddetailclose.gameObject, false)
	gohelper.setActive(self._gobirthdayrewarddetail, false)
end

function SignInDetailView:_addCustomEvent()
	self._monthreward1Click:AddClickListener(self._onMonthRewardClick, self, 1)
	self._monthreward2Click:AddClickListener(self._onMonthRewardClick, self, 2)
	self._monthreward3Click:AddClickListener(self._onMonthRewardClick, self, 3)
	self._normaldayClick:AddClickListener(self._onDayRewardClick, self)
	self._monthcarddayClick:AddClickListener(self._onDayRewardClick, self)
	self._normaldayClick_gold:AddClickListener(self._onDayGoldRewardClick, self)
	self._monthcarddayClick_gold:AddClickListener(self._onDayGoldRewardClick, self)
	self._monthcardClick:AddClickListener(self._onMonthCardRewardClick, self)
	self._monthcardpowerClick:AddClickListener(self._onMonthCardPowerRewardClick, self)
	self._viewAniEventWrap:AddEventListener("changetobirthday", self._onChangeToBirthday, self)
	self._viewAniEventWrap:AddEventListener("changetonormal", self._onChangeToNormal, self)
	self._viewAniEventWrap:AddEventListener("birthdaytobirthday", self._onChangeBirthdayToBirthday, self)
	SignInController.instance:registerCallback(SignInEvent.GetSignInInfo, self._onGetSignInInfo, self)
	SignInController.instance:registerCallback(SignInEvent.GetSignInReply, self._onGetSignInReply, self)
	SignInController.instance:registerCallback(SignInEvent.GetSignInAddUp, self._setMonthView, self)
	SignInController.instance:registerCallback(SignInEvent.SignInItemClick, self._onChangeItemClick, self)
	SignInController.instance:registerCallback(SignInEvent.ClickSignInMonthItem, self._closeViewEffect, self)
	SignInController.instance:registerCallback(SignInEvent.GetHeroBirthday, self._onGetHeroBirthday, self)
	SignInController.instance:registerCallback(SignInEvent.CloseSignInDetailView, self._onEscapeBtnClick, self)
	PlayerController.instance:registerCallback(PlayerEvent.OnDailyRefresh, self._onDailyRefresh, self)
	SignInController.instance:registerCallback(SignInEvent.OnReceiveSupplementMonthCardReply, self._refreshSupplement, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function SignInDetailView:_removeCustomEvent()
	self._monthreward1Click:RemoveClickListener()
	self._monthreward2Click:RemoveClickListener()
	self._monthreward3Click:RemoveClickListener()
	self._normaldayClick:RemoveClickListener()
	self._monthcarddayClick:RemoveClickListener()
	self._normaldayClick_gold:RemoveClickListener()
	self._monthcarddayClick_gold:RemoveClickListener()
	self._monthcardClick:RemoveClickListener()
	self._monthcardpowerClick:RemoveClickListener()
	self._viewAniEventWrap:RemoveAllEventListener()
	SignInController.instance:unregisterCallback(SignInEvent.GetSignInInfo, self._onGetSignInInfo, self)
	SignInController.instance:unregisterCallback(SignInEvent.GetSignInReply, self._onGetSignInReply, self)
	SignInController.instance:unregisterCallback(SignInEvent.GetSignInAddUp, self._setMonthView, self)
	SignInController.instance:unregisterCallback(SignInEvent.SignInItemClick, self._onChangeItemClick, self)
	SignInController.instance:unregisterCallback(SignInEvent.ClickSignInMonthItem, self._closeViewEffect, self)
	SignInController.instance:unregisterCallback(SignInEvent.GetHeroBirthday, self._onGetHeroBirthday, self)
	SignInController.instance:unregisterCallback(SignInEvent.CloseSignInDetailView, self._onEscapeBtnClick, self)
	PlayerController.instance:unregisterCallback(PlayerEvent.OnDailyRefresh, self._onDailyRefresh, self)
	SignInController.instance:unregisterCallback(SignInEvent.OnReceiveSupplementMonthCardReply, self._refreshSupplement, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function SignInDetailView:_onEscapeBtnClick()
	self._viewAnim:Play("out")
	TaskDispatcher.runDelay(self.clickCloseView, self, 0.2)
end

function SignInDetailView:clickCloseView()
	if self.viewParam and self.viewParam.callback then
		self.viewParam.callback(self.viewParam.callbackObj)
	end

	self:closeThis()
end

function SignInDetailView:_editableInitView()
	gohelper.addUIClickAudio(self._btnqiehuan.gameObject, AudioEnum.UI.play_ui_sign_in_qiehuan)
	gohelper.setActive(self._gomonthget1, false)
	gohelper.setActive(self._gonomonthget1, false)
	gohelper.setActive(self._gomonthget2, false)
	gohelper.setActive(self._gonomonthget2, false)
	gohelper.setActive(self._gomonthget3, false)
	gohelper.setActive(self._gonomonthget3, false)
	gohelper.setActive(self._gonormaldaysigned, false)
	gohelper.setActive(self._gonormaldaysigned_gold, false)
	gohelper.setActive(self._gomonthcarddaysigned, false)
	gohelper.setActive(self._gomonthcarddaysigned_gold, false)
	gohelper.setActive(self._gomonthcardsigned, false)
	self._normaldayrewardAni:Play("none")
	self._normaldayrewardAni_gold:Play("none")
	self._monthcarddayrewardAni:Play("none")
	self._monthcarddayrewardAni_gold:Play("none")

	self._gogetmonthbgs = self:getUserDataTb_()

	table.insert(self._gogetmonthbgs, self._gogetmonthbg1)
	table.insert(self._gogetmonthbgs, self._gogetmonthbg2)
	table.insert(self._gogetmonthbgs, self._gogetmonthbg3)

	self._gomonthmasks = self:getUserDataTb_()

	table.insert(self._gomonthmasks, self._gomonthmask1)
	table.insert(self._gomonthmasks, self._gomonthmask2)
	table.insert(self._gomonthmasks, self._gomonthmask3)

	self._gomonthgets = self:getUserDataTb_()

	table.insert(self._gomonthgets, self._gomonthget1)
	table.insert(self._gomonthgets, self._gomonthget2)
	table.insert(self._gomonthgets, self._gomonthget3)

	self._gonomonthgets = self:getUserDataTb_()

	table.insert(self._gonomonthgets, self._gonomonthget1)
	table.insert(self._gonomonthgets, self._gonomonthget2)
	table.insert(self._gonomonthgets, self._gonomonthget3)
	self._simagebg:LoadImage(ResUrl.getSignInBg("bg_white"))
	self._simageorangebg:LoadImage(ResUrl.getSignInBg("img_bcard3"))
	self._simagerewardbg:LoadImage(ResUrl.getSignInBg("img_di"))

	self._rewardTipItems = {}
	self._nodeItems = {}
	self._monthgetlightanimTab = self:getUserDataTb_()
	self._delayAnimTab = self:getUserDataTb_()
	self._monthRewards = self:getUserDataTb_()

	table.insert(self._monthgetlightanimTab, self._gomonthgetlightanim1)
	table.insert(self._monthgetlightanimTab, self._gomonthgetlightanim2)
	table.insert(self._monthgetlightanimTab, self._gomonthgetlightanim3)

	for k, v in ipairs(self._monthgetlightanimTab) do
		gohelper.setActive(v, false)
	end

	self._festivalAtmosphereComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, FestivalAtmosphereComp, self)
end

function SignInDetailView:onOpen()
	if self.viewParam.back then
		self._viewAnim:Play("AutoIn")
	else
		self._viewAnim:Play("NormalIn")
	end

	self._index = 0
	self._checkSignIn = true

	self:_setMonthView(true)
	self:_setRedDot()
	self:_addCustomEvent()
	NavigateMgr.instance:addEscape(ViewName.SignInDetailView, self._onEscapeBtnClick, self)
	self:_refreshFestivalDecoration()
end

function SignInDetailView:_onDailyRefresh()
	self._index = 0
	self._checkSignIn = true

	gohelper.setActive(self._gomonthget1, false)
	gohelper.setActive(self._gonomonthget1, false)
	gohelper.setActive(self._gomonthget2, false)
	gohelper.setActive(self._gonomonthget2, false)
	gohelper.setActive(self._gomonthget3, false)
	gohelper.setActive(self._gonomonthget3, false)
	gohelper.setActive(self._gonormaldaysigned, false)
	gohelper.setActive(self._gonormaldaysigned_gold, false)
	gohelper.setActive(self._gomonthcarddaysigned, false)
	gohelper.setActive(self._gomonthcarddaysigned_gold, false)
	gohelper.setActive(self._gomonthcardsigned, false)
	gohelper.setActive(self._gonormaldayget, false)
	gohelper.setActive(self._gonormaldayget_gold, false)
	gohelper.setActive(self._gomonthcardget, false)
	gohelper.setActive(self._gomonthcarddayget, false)
	gohelper.setActive(self._gomonthcarddayget_gold, false)
	gohelper.setActive(self._gonormaldaynoget, false)
	gohelper.setActive(self._gomonthcardnoget, false)
	gohelper.setActive(self._gomonthcardpowernoget, false)
	gohelper.setActive(self._gomonthcarddaynoget, false)
	gohelper.setActive(self._gomonthcarddaynoget_gold, false)
	self:_setMonthView()
end

function SignInDetailView:_onChangeItemClick(itemMo)
	self.currentSelectMaterialType = itemMo.materilType
	self.currentSelectMaterialId = itemMo.materilId

	if tonumber(itemMo.materilType) == MaterialEnum.MaterialType.Equip then
		local config, icon = ItemModel.instance:getItemConfigAndIcon(itemMo.materilType, itemMo.materilId, true)
	end
end

function SignInDetailView:_onMonthCardRewardClick()
	MaterialTipController.instance:showMaterialInfo(self._curmonthCardRewards[1], self._curmonthCardRewards[2])
end

function SignInDetailView:_onMonthCardPowerRewardClick()
	MaterialTipController.instance:showMaterialInfo(self._curmonthCardPower[1], self._curmonthCardPower[2])
end

function SignInDetailView:_onChangeToBirthday()
	gohelper.setSiblingBefore(self._godayrewarditem, self._gobirthdayrewarditem)
end

function SignInDetailView:_onChangeToNormal()
	self:_setRewardItems()
	gohelper.setSiblingBefore(self._gobirthdayrewarditem, self._godayrewarditem)
end

function SignInDetailView:_onChangeBirthdayToBirthday()
	self:_setRewardItems()
end

function SignInDetailView:_onGetSignInInfo()
	self:_setMonthView()
end

function SignInDetailView:_onGetSignInReply()
	self:_setMonthView()
end

function SignInDetailView:_onGetHeroBirthday()
	local birthdayHeros = SignInModel.instance:getSignBirthdayHeros(self._targetDate[1], self._targetDate[2], self._targetDate[3])
	local hasBirthdayRewards = false

	for _, v in pairs((self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] or nil) and SignInModel.instance:getCurDayBirthdayHeros()) do
		local giftGet = SignInModel.instance:isHeroBirthdayGet(v)

		if not giftGet then
			hasBirthdayRewards = true
		end
	end

	gohelper.setActive(self._goqiehuan, hasBirthdayRewards)
	gohelper.setActive(self._gogiftnoget, false)
	gohelper.setActive(self._gogiftget, true)
end

function SignInDetailView:_closeViewEffect()
	self._clickMonth = true
	self._index = 0

	self._viewAnim:Play("idel")
	self:_setMonthView()
	gohelper.setSiblingBefore(self._gobirthdayrewarditem, self._godayrewarditem)
end

function SignInDetailView:_setMonthView(open)
	self:_setSignInData()

	if open then
		self:_playOpenAudio()
		self:_initIndex()
	end

	self:_setTitleInfo()
	self:_setRewardItems()
	self:_setMonthViewRewardTips()
	self:_refreshSupplement()

	if not self._checkSignIn then
		return
	end

	if not self._isCurDayRewardGet then
		gohelper.setActive(self._gonormaldaysigned, true)
		gohelper.setActive(self._gonormaldaysigned_gold, true)
		gohelper.setActive(self._gomonthcarddaysigned, true)
		gohelper.setActive(self._gomonthcarddaysigned_gold, true)
		gohelper.setActive(self._gomonthcardsigned, true)
		gohelper.setActive(self._gonormaldayget, true)
		gohelper.setActive(self._gonormaldayget_gold, true)
		gohelper.setActive(self._gomonthcardget, true)
		gohelper.setActive(self._gomonthcarddayget, true)
		gohelper.setActive(self._gomonthcarddayget_gold, true)
		gohelper.setActive(self._gonormaldaynoget, false)
		gohelper.setActive(self._gomonthcardnoget, false)
		gohelper.setActive(self._gomonthcardpowernoget, false)
		gohelper.setActive(self._gomonthcarddaynoget, false)
		gohelper.setActive(self._gomonthcarddaynoget_gold, false)
		self._normaldayrewardAni:Play("none")
		self._normaldayrewardAni_gold:Play("none")
		self._monthcarddayrewardAni:Play("none")
		self._monthcarddayrewardAni_gold:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(self._txtnormaldayrewardcount, 1)

		self._checkSignIn = false

		UIBlockMgr.instance:startBlock("signshowing")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_dailyrewards)
		TaskDispatcher.runDelay(self._delaySignInRequest, self, 1.3)
	else
		gohelper.setActive(self._gonormaldaysigned, true)
		gohelper.setActive(self._gonormaldaysigned_gold, true)
		gohelper.setActive(self._gomonthcarddaysigned, true)
		gohelper.setActive(self._gomonthcarddaysigned_gold, true)
		gohelper.setActive(self._gomonthcardsigned, true)
		gohelper.setActive(self._gonormaldayget, false)
		gohelper.setActive(self._gonormaldayget_gold, false)
		gohelper.setActive(self._gomonthcarddayget, false)
		gohelper.setActive(self._gomonthcarddayget_gold, false)
		gohelper.setActive(self._gomonthcardget, false)
		gohelper.setActive(self._gonormaldaynoget, true)
		gohelper.setActive(self._gomonthcarddaynoget, true)
		gohelper.setActive(self._gomonthcarddaynoget_gold, true)
		gohelper.setActive(self._gomonthcardnoget, true)
		gohelper.setActive(self._gomonthcardpowernoget, true)
		gohelper.setActive(self._gomonthcardpowernoget_gold, true)
		ZProj.UGUIHelper.SetColorAlpha(self._txtnormaldayrewardcount, 0.7)

		if self._gonormaldayget.activeSelf then
			self._normaldayrewardAni.enabled = true
			self._normaldayrewardAni_gold.enabled = true
			self._monthcarddayrewardAni.enabled = true
			self._monthcarddayrewardAni_gold.enabled = true

			self._normaldayrewardAni:Play("none")
			self._normaldayrewardAni_gold:Play("none")
			self._monthcarddayrewardAni:Play("none")
			self._monthcarddayrewardAni_gold:Play("none")
		else
			gohelper.setActive(self._gomonthcarddayget, false)
			gohelper.setActive(self._gomonthcarddayget_gold, false)
			gohelper.setActive(self._gomonthcardget, false)

			self._normaldayrewardAni.enabled = true
			self._normaldayrewardAni_gold.enabled = true
			self._monthcarddayrewardAni.enabled = true
			self._monthcarddayrewardAni_gold.enabled = true

			if not self._clickMonth then
				gohelper.setActive(self._gomonthcardnoget, true)
				gohelper.setActive(self._gomonthcardpowernoget, true)
				gohelper.setActive(self._gomonthcarddaynoget, true)
				gohelper.setActive(self._gomonthcarddaynoget_gold, true)
				self._monthcarddayrewardAni:Play("lingqu")
				self._monthcarddayrewardAni_gold:Play("lingqu")
			else
				self._monthcarddayrewardAni:Play("none")
				self._monthcarddayrewardAni_gold:Play("none")
				gohelper.setActive(self._gomonthcardnoget, true)
				gohelper.setActive(self._gomonthcardpowernoget, true)
				gohelper.setActive(self._gomonthcarddaynoget, true)
				gohelper.setActive(self._gomonthcarddaynoget_gold, true)
			end

			self._normaldayrewardAni:Play("lingqu")
			self._normaldayrewardAni_gold:Play("lingqu")
			self._monthcarddayrewardAni:Play("lingqu")
			self._monthcarddayrewardAni_gold:Play("lingqu")
		end
	end
end

function SignInDetailView:_setSignInData()
	self._curDate = SignInModel.instance:getCurDate()
	self._targetDate = SignInModel.instance:getSignTargetDate()
	self._curDayRewards = SignInModel.instance:getSignRewardsByDate(self._curDate)
	self._rewardGetState = SignInModel.instance:isSignDayRewardGet(self._targetDate[3])
	self._isCurDayRewardGet = SignInModel.instance:isSignDayRewardGet(self._curDate.day)
end

function SignInDetailView:_playOpenAudio()
	local monthCardId = SignInModel.instance:getValidMonthCard(self._curDate.year, self._curDate.month, self._curDate.day)

	if not self._isCurDayRewardGet and monthCardId then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_menology)

		return
	end

	local hasTotalRewardCouldGet = false

	for i = 1, 3 do
		local get = SignInModel.instance:isSignTotalRewardGet(i)
		local unlock = SignInModel.instance:getTotalSignDays() >= tonumber(SignInConfig.instance:getSignMonthReward(i).signinaddup)

		if not get and unlock then
			hasTotalRewardCouldGet = true
		end
	end

	if hasTotalRewardCouldGet then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_special)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_general)
end

function SignInDetailView:_initIndex()
	if not self._isCurDayRewardGet then
		return
	end

	for i = 1, 3 do
		local rewardget = SignInModel.instance:isSignTotalRewardGet(i)
		local unlock = SignInModel.instance:getTotalSignDays() >= tonumber(SignInConfig.instance:getSignMonthReward(i).signinaddup)

		if not rewardget and unlock then
			return
		end
	end

	local birthdayHeros = SignInModel.instance:getSignBirthdayHeros(self._targetDate[1], self._targetDate[2], self._targetDate[3])

	if self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] then
		birthdayHeros = SignInModel.instance:getCurDayBirthdayHeros()
	end

	local inputValue = self._inputheros:GetText()

	for k, v in ipairs((inputValue and inputValue ~= "" and self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] or nil) and string.splitToNumber(inputValue, "|")) do
		local giftGet = SignInModel.instance:isHeroBirthdayGet(v)

		if not giftGet then
			self._index = k

			gohelper.setSiblingBefore(self._gobirthdayrewarditem, self._godayrewarditem)

			return
		end
	end
end

function SignInDetailView:_setTitleInfo()
	local datets = TimeUtil.timeToTimeStamp(self._targetDate[1], self._targetDate[2], self._targetDate[3], TimeDispatcher.DailyRefreshTime, 1, 1)
	local week = os.date("%w", datets)

	UISpriteSetMgr.instance:setSignInSprite(self._imageweek, "date_" .. tostring(week))

	self._txtdesc.text = SignInConfig.instance:getSignDescByDate(datets)

	local dayStr = string.format("%02d", self._targetDate[3])

	self._txtday.text = dayStr
	self._txtdayfestival.text = dayStr
	self._txtmonth.text = string.format("%02d", self._targetDate[2])

	local advanceHero, day = SignInModel.instance:getAdvanceHero()

	if advanceHero == 0 then
		gohelper.setActive(self._goroleitem, false)
	else
		gohelper.setActive(self._goroleitem, true)

		local heroMo = HeroModel.instance:getByHeroId(advanceHero)

		if heroMo then
			if not heroMo.skin then
				local skin = HeroConfig.instance:getHeroCO(advanceHero).skinId

				self._simagetopicon:LoadImage(ResUrl.getHeadIconSmall(skin))

				self._txtbirtime.text = day
				self._txtlimit.text = day > 1 and "Days Later" or "Day Later"
			end
		end
	end
end

function SignInDetailView:_setRewardItems()
	local birthdayHeros = SignInModel.instance:getSignBirthdayHeros(self._targetDate[1], self._targetDate[2], self._targetDate[3])

	if self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] then
		birthdayHeros = SignInModel.instance:getCurDayBirthdayHeros()
	end

	if self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] then
		if self._index > 0 then
			RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.SignInBirthReward, birthdayHeros[self._index])
		end
	else
		RedDotController.instance:addRedDot(self._goreddot, 0)
	end

	for _, v in pairs(self._nodeItems) do
		gohelper.setActive(v.go, false)
	end

	local hasBirthdayRewards = false

	if self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] then
		for _, v in pairs(birthdayHeros) do
			local giftGet = SignInModel.instance:isHeroBirthdayGet(v)

			if not giftGet then
				hasBirthdayRewards = true
			end
		end
	end

	gohelper.setActive(self._goqiehuan, hasBirthdayRewards)

	if #birthdayHeros > 0 then
		for i = 1, #birthdayHeros + 1 do
			if not self._nodeItems[i] then
				self._nodeItems[i] = self:getUserDataTb_()
				self._nodeItems[i].go = gohelper.cloneInPlace(self._gonodeitem, "node" .. tostring(i))
				self._nodeItems[i].on = gohelper.findChild(self._nodeItems[i].go, "on")
				self._nodeItems[i].off = gohelper.findChild(self._nodeItems[i].off, "off")
			end

			gohelper.setActive(self._nodeItems[i].go, true)
			gohelper.setActive(self._nodeItems[i].on, self._index == i - 1)
			gohelper.setActive(self._nodeItems[i].off, self._index ~= i - 1)
		end

		gohelper.setActive(self._gonodes, true)

		if self._index == 0 then
			self:_showDayRewardItem()
		else
			self:_showBirthdayRewardItem()
		end
	else
		gohelper.setActive(self._gonodes, false)
		self:_showNoBirthdayRewardItem()
	end
end

function SignInDetailView:_showNoBirthdayRewardItem()
	gohelper.setActive(self._btnqiehuan.gameObject, false)
	gohelper.setActive(self._simageorangebg.gameObject, false)
	gohelper.setActive(self._gobirthdayrewarditem, false)
end

function SignInDetailView:_showDayRewardItem()
	gohelper.setActive(self._gobirthday, false)
	gohelper.setActive(self._btnqiehuan.gameObject, true)
	gohelper.setActive(self._simageorangebg.gameObject, true)
	gohelper.setActive(self._gobirthdayrewarditem, true)
	self._simagebirthdaybg:LoadImage(ResUrl.getSignInBg("img_bcard1"))
	self._simagebirthdaybg2:LoadImage(ResUrl.getSignInBg("img_bcard1"))
end

function SignInDetailView:_showBirthdayRewardItem()
	gohelper.setActive(self._gobirthday, true)
	gohelper.setActive(self._btnqiehuan.gameObject, true)
	gohelper.setActive(self._simageorangebg.gameObject, true)
	gohelper.setActive(self._gobirthdayrewarditem, true)
	self._simagebirthdaybg:LoadImage(ResUrl.getSignInBg("img_bcard1"))
	self._simagebirthdaybg2:LoadImage(ResUrl.getSignInBg("img_bcard1"))
	self:_setBirthdayInfo()
end

function SignInDetailView:_setBirthdayInfo()
	local birthdayHeros = SignInModel.instance:getSignBirthdayHeros(self._targetDate[1], self._targetDate[2], self._targetDate[3])
	local heroId = ((self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] or nil) and SignInModel.instance:getCurDayBirthdayHeros())[self._index]

	self._birthdayHeroIconList = {}

	local heroIdWithSPList = HeroConfig.instance:getSPHeroIdList(heroId, true)

	gohelper.CreateObjList(self, self._onCreateBirthdayHeroIcon, heroIdWithSPList, self._gobirthdayHeroContent, self._gobirthdayHeroIcon)

	local birthdayCount = SignInModel.instance:getHeroBirthdayCount(heroId)
	local index = birthdayCount

	if self._curDate.month == self._targetDate[2] then
		local birthdayGet = SignInModel.instance:isHeroBirthdayGet(heroId)

		index = self._curDate.year == self._targetDate[1] and (birthdayGet and birthdayCount or birthdayCount + 1) or birthdayGet and birthdayCount - 1 or birthdayCount
	end

	if not index or index == 0 then
		index = 1
	end

	self._txtdeco.text = string.split(HeroConfig.instance:getHeroCO(heroId).desc, "|")[index]

	ZProj.UGUIHelper.RebuildLayout(self._txtdeco.gameObject.transform)
	gohelper.setActive(self._txtdeco.gameObject, false)
	gohelper.setActive(self._txtdeco.gameObject, true)
	self._simagesignature:LoadImage(ResUrl.getSignature(tostring(heroId)))

	local giftGet = true

	if self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] then
		giftGet = SignInModel.instance:isHeroBirthdayGet(heroId)
	end

	gohelper.setActive(self._gogiftnoget, not giftGet)
	gohelper.setActive(self._gogiftget, giftGet)
end

function SignInDetailView:_onCreateBirthdayHeroIcon(obj, data, index)
	local iconItem = self:getUserDataTb_()

	iconItem.go = obj
	iconItem.icon = gohelper.findChildSingleImage(obj, "#simage_icon")

	local heroMo = HeroModel.instance:getByHeroId(data)

	if heroMo then
		if not heroMo.skin then
			local skin = HeroConfig.instance:getHeroCO(data).skinId

			iconItem.icon:LoadImage(ResUrl.getHeadIconSmall(skin))
		end
	end
end

function SignInDetailView:_delaySignInRequest()
	gohelper.setActive(self._gomonthcarddaysigned, true)
	gohelper.setActive(self._gomonthcarddaysigned_gold, true)
	gohelper.setActive(self._gonormaldaysigned, true)
	gohelper.setActive(self._gonormaldaysigned_gold, true)
	gohelper.setActive(self._gomonthcardsigned, true)
	gohelper.setActive(self._gonormaldayget, false)
	gohelper.setActive(self._gonormaldayget_gold, false)
	gohelper.setActive(self._gomonthcarddayget, false)
	gohelper.setActive(self._gomonthcarddayget_gold, false)
	gohelper.setActive(self._gomonthcardget, false)
	gohelper.setActive(self._gonormaldaynoget, true)
	gohelper.setActive(self._gomonthcarddaynoget, true)
	gohelper.setActive(self._gomonthcarddaynoget_gold, true)
	gohelper.setActive(self._gomonthcardnoget, true)
	gohelper.setActive(self._gomonthcardpowernoget, true)
	self._normaldayrewardAni:Play("lingqu")
	self._normaldayrewardAni_gold:Play("lingqu")
	self._monthcarddayrewardAni:Play("lingqu")
	self._monthcarddayrewardAni_gold:Play("lingqu")
	UIBlockMgr.instance:endBlock("signshowing")

	if self._startGetReward then
		return
	end

	LifeCircleController.instance:sendSignInRequest()

	self._startGetReward = true
end

function SignInDetailView:_setRedDot()
	RedDotController.instance:addRedDot(self._gomonthtip1, RedDotEnum.DotNode.SignInMonthTab, 1)
	RedDotController.instance:addRedDot(self._gomonthtip2, RedDotEnum.DotNode.SignInMonthTab, 2)
	RedDotController.instance:addRedDot(self._gomonthtip3, RedDotEnum.DotNode.SignInMonthTab, 3)
end

function SignInDetailView:onClose()
	self:_removeCustomEvent()
end

function SignInDetailView:_onCloseMonthRewardDetailClick()
	gohelper.setActive(self._gomonthrewarddetail, false)
end

function SignInDetailView:onClickModalMask()
	self:_onEscapeBtnClick()
end

function SignInDetailView:_onMonthRewardClick(id)
	local rewardget = SignInModel.instance:isSignTotalRewardGet(id)
	local unlock = SignInModel.instance:getTotalSignDays() >= tonumber(SignInConfig.instance:getSignMonthReward(id).signinaddup)

	gohelper.setActive(self._gogetmonthbgs[id], unlock)

	if not rewardget and unlock then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_receive)
		gohelper.setActive(self._gomonthgets[id], true)
		gohelper.setActive(self._monthgetlightanimTab[id], true)

		self._targetid = id

		TaskDispatcher.runDelay(self._showGetRewards, self, 1.2)
	else
		MaterialTipController.instance:showMaterialInfo(tonumber(self._monthRewards[id].reward[1]), tonumber(self._monthRewards[id].reward[2]))
	end
end

function SignInDetailView:_showGetRewards()
	if self._targetid then
		gohelper.setActive(self._gomonthgets[self._targetid], false)
		gohelper.setActive(self._gonomonthgets[self._targetid], true)
		SignInRpc.instance:sendSignInAddupRequest(self._targetid)

		self._targetid = nil
	end
end

function SignInDetailView:_onDayRewardClick()
	MaterialTipController.instance:showMaterialInfo(self._curDayRewards[1], self._curDayRewards[2])
end

function SignInDetailView:_onDayGoldRewardClick()
	MaterialTipController.instance:showMaterialInfo(self._goldReward[1], self._goldReward[2])
end

function SignInDetailView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		if not self._startGetReward then
			return
		end

		self._startGetReward = false

		local showHeros = SignInModel.instance:getCurDayBirthdayHeros()

		if self._index >= #showHeros then
			return
		end

		self:_btnqiehuanOnClick()
	end
end

function SignInDetailView:_showMonthRewardInfo(index)
	local o = {}

	o.rewardCo = SignInConfig.instance:getSignMonthReward(index)
	o.rewards = string.split(o.rewardCo.signinBonus, "|")
	o.reward = string.split(o.rewards[1], "#")

	local config, icon = ItemModel.instance:getItemConfigAndIcon(o.reward[1], o.reward[2])

	self["_simagemonthicon" .. index]:LoadImage(icon)

	self["_txtmonthquantity" .. index].text = o.rewardCo.signinaddup
	self["_txtmonthrewardcount" .. index].text = string.format("%s%s", luaLang("multiple"), o.reward[3])

	table.insert(self._monthRewards, index, o)
end

function SignInDetailView:_setMonthViewRewardTips()
	self._txtdaycount.text = SignInModel.instance:getTotalSignDays()

	local monthRewards = SignInConfig.instance:getSignMonthRewards()

	for i = 1, 3 do
		self:_showMonthRewardInfo(i)
	end

	local month1get = SignInModel.instance:isSignTotalRewardGet(1)
	local unlock1 = SignInModel.instance:getTotalSignDays() >= tonumber(SignInConfig.instance:getSignMonthReward(1).signinaddup)

	gohelper.setActive(self._gorewardmark1, not month1get and unlock1)
	gohelper.setActive(self._gogetmonthbg1, unlock1)

	if month1get then
		gohelper.setActive(self._gomonthget1, self._gomonthget1.activeSelf)
		gohelper.setActive(self._gonomonthget1, not self._gomonthget1.activeSelf)
		self._month1Ani:Play("lingqu")
		ZProj.UGUIHelper.SetColorAlpha(self._txtmonthquantity1, 0.5)
		ZProj.UGUIHelper.SetColorAlpha(self._txtmonthrewardcount1, 0.5)
	else
		gohelper.setActive(self._gomonthget1, false)
		gohelper.setActive(self._gonomonthget1, false)
		self._month1Ani:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(self._txtmonthquantity1, 1)
		ZProj.UGUIHelper.SetColorAlpha(self._txtmonthrewardcount1, 1)
	end

	local month2get = SignInModel.instance:isSignTotalRewardGet(2)
	local unlock2 = SignInModel.instance:getTotalSignDays() >= tonumber(SignInConfig.instance:getSignMonthReward(2).signinaddup)

	gohelper.setActive(self._gorewardmark2, not month2get and unlock2)
	gohelper.setActive(self._gogetmonthbg2, unlock2)

	if month2get then
		gohelper.setActive(self._gomonthget2, self._gomonthget2.activeSelf)
		gohelper.setActive(self._gonomonthget2, not self._gomonthget2.activeSelf)
		self._month2Ani:Play("lingqu")
		ZProj.UGUIHelper.SetColorAlpha(self._txtmonthquantity2, 0.5)
		ZProj.UGUIHelper.SetColorAlpha(self._txtmonthrewardcount2, 0.5)
	else
		gohelper.setActive(self._gomonthget2, false)
		gohelper.setActive(self._gonomonthget2, false)
		self._month2Ani:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(self._txtmonthquantity2, 1)
		ZProj.UGUIHelper.SetColorAlpha(self._txtmonthrewardcount2, 1)
	end

	local month3get = SignInModel.instance:isSignTotalRewardGet(3)
	local unlock3 = SignInModel.instance:getTotalSignDays() >= tonumber(SignInConfig.instance:getSignMonthReward(3).signinaddup)

	gohelper.setActive(self._gorewardmark3, not month3get and unlock3)
	gohelper.setActive(self._gogetmonthbg3, unlock3)

	if month3get then
		gohelper.setActive(self._gomonthget3, self._gomonthget3.activeSelf)
		gohelper.setActive(self._gonomonthget3, not self._gomonthget3.activeSelf)
		self._month3Ani:Play("lingqu")
		ZProj.UGUIHelper.SetColorAlpha(self._txtmonthquantity3, 0.5)
		ZProj.UGUIHelper.SetColorAlpha(self._txtmonthrewardcount3, 0.5)
	else
		gohelper.setActive(self._gomonthget3, false)
		gohelper.setActive(self._gonomonthget3, false)
		self._month3Ani:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(self._txtmonthquantity3, 1)
		ZProj.UGUIHelper.SetColorAlpha(self._txtmonthrewardcount3, 1)
	end

	local date = SignInModel.instance:getSignTargetDate()

	self:_setGoldRewards(date)

	self._curDayRewards = SignInModel.instance:getSignRewardsByDate(date)

	local config, icon = ItemModel.instance:getItemConfigAndIcon(self._curDayRewards[1], self._curDayRewards[2], true)

	self._txtnormaldayrewardcount.text = luaLang("multiple") .. tostring(self._curDayRewards[3])
	self._txtmonthcarddayrewardcount.text = luaLang("multiple") .. tostring(self._curDayRewards[3])

	self._simagenormaldayrewardicon:LoadImage(icon)
	self._simagemonthcarddayrewardicon:LoadImage(icon)

	if tonumber(self._curDayRewards[1]) == MaterialEnum.MaterialType.Equip then
		self._simagenormaldayrewardicon:LoadImage(ResUrl.getPropItemIcon(config.icon))
		self._simagemonthcarddayrewardicon:LoadImage(ResUrl.getPropItemIcon(config.icon))
	end

	local monthCardId = SignInModel.instance:getValidMonthCard(date[1], date[2], date[3])

	gohelper.setActive(self._gomonthcard, monthCardId)
	gohelper.setActive(self._gonormal, not monthCardId)

	if monthCardId then
		local dailyBonus = string.split(StoreConfig.instance:getMonthCardConfig(monthCardId).dailyBonus, "|")

		self._curmonthCardRewards = string.splitToNumber(dailyBonus[1], "#")
		self._curmonthCardPower = string.splitToNumber(dailyBonus[2], "#")
		self._txtmonthcardcount.text = luaLang("multiple") .. tostring(self._curmonthCardRewards[3])
		self._txtmonthcardpowercount.text = luaLang("multiple") .. tostring(self._curmonthCardPower[3])

		local config, icon = ItemModel.instance:getItemConfigAndIcon(self._curmonthCardRewards[1], self._curmonthCardRewards[2], true)

		self._simagemonthcardicon:LoadImage(icon)

		local powerconfig, powericon = ItemModel.instance:getItemConfigAndIcon(self._curmonthCardPower[1], self._curmonthCardPower[2], true)

		self._simagemonthcardpowericon:LoadImage(powericon)
		gohelper.setActive(self._gopowerlimittime, false)

		if powerconfig.expireTime then
			gohelper.setActive(self._gopowerlimittime, true)
		end

		local monthCardInfo = StoreModel.instance:getMonthCardInfo()

		if monthCardInfo then
			local remaintime = monthCardInfo:getRemainDay()

			if remaintime > 0 then
				gohelper.setActive(self._golimittime.gameObject, true)

				if remaintime <= StoreEnum.MonthCardStatus.NotEnoughThreeDay then
					gohelper.setActive(self._goredlimittimebg, true)
					gohelper.setActive(self._gonormallimittimebg, false)
				else
					gohelper.setActive(self._goredlimittimebg, false)
					gohelper.setActive(self._gonormallimittimebg, true)
				end

				self._txtlimittime.text = formatLuaLang("remain_day", remaintime)
			else
				gohelper.setActive(self._golimittime.gameObject, false)
			end
		end

		local isToday = self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3]
		local showGet = isToday and not self._rewardGetState

		gohelper.setActive(self._gomonthcardget, showGet)
		gohelper.setActive(self._gomonthcarddayget, showGet)
		gohelper.setActive(self._gomonthcarddayget_gold, showGet)
		gohelper.setActive(self._gomonthcardnoget, not showGet)
		gohelper.setActive(self._gomonthcardpowernoget, not showGet)
		gohelper.setActive(self._gomonthcarddaynoget, not showGet)
		gohelper.setActive(self._gomonthcarddaynoget_gold, not showGet)
	end
end

function SignInDetailView:_setGoldRewards(targetdate)
	local isOpen = SignInModel.instance:checkIsGoldDay(targetdate)

	if isOpen then
		local reward = SignInModel.instance:getTargetDailyAllowanceBonus(targetdate)

		gohelper.setActive(self._gonormaldayreward_gold, reward)
		gohelper.setActive(self._gomonthcarddayreward_gold, reward)

		if reward then
			local rewards = string.split(reward, "#")

			self._goldReward = rewards

			local config, icon = ItemModel.instance:getItemConfigAndIcon(rewards[1], rewards[2], true)

			self._txtnormaldayrewardcount_gold.text = luaLang("multiple") .. tostring(rewards[3])
			self._txtmonthcarddayrewardcount_gold.text = luaLang("multiple") .. tostring(rewards[3])

			self._simagenormaldayrewardicon_gold:LoadImage(icon)
			self._simagemonthcarddayrewardicon_gold:LoadImage(icon)

			if tonumber(rewards[1]) == MaterialEnum.MaterialType.Equip then
				self._simagenormaldayrewardicon_gold:LoadImage(ResUrl.getPropItemIcon(config.icon))
				self._simagemonthcarddayrewardicon_gold:LoadImage(ResUrl.getPropItemIcon(config.icon))
			end
		end
	else
		gohelper.setActive(self._gonormaldayreward_gold, false)
		gohelper.setActive(self._gomonthcarddayreward_gold, false)
	end
end

function SignInDetailView:_switchFestivalDecoration(haveFestival)
	if self._haveFestival == haveFestival then
		return
	end

	self._haveFestival = haveFestival

	self:_refreshFestivalDecoration()
end

function SignInDetailView:_refreshFestivalDecoration()
	local haveFestival = self:haveFestival()

	gohelper.setActive(self._gofestivaldecorationBg, haveFestival)
	gohelper.setActive(self._gofestivaldecorationtop, haveFestival)
	gohelper.setActive(self._gofestivaldecorationbottom, haveFestival)
	gohelper.setActive(self._gorewardicon, not haveFestival)
	gohelper.setActive(self._goeffect, haveFestival)
	gohelper.setActive(self._gobgeffect, haveFestival)
	gohelper.setActive(self._godayrewarditem_image3, haveFestival)
	gohelper.setActive(self._btncalendarfestival, haveFestival)
	gohelper.setActive(self._btncalendar, not haveFestival)
	gohelper.setActive(self._txtday, not haveFestival)
	gohelper.setActive(self._txtdayfestival, haveFestival)
	self:_setFestivalColor(self._txtmonth)
	self:_setFestivalColor(self._imgbias)
	self:_setFestivalColor(self._txtday)
	self._simagebg:LoadImage(ResUrl.getSignInBg(haveFestival and "act_bg_white" or "bg_white"))
	self._simagerewardbg:LoadImage(ResUrl.getSignInBg(haveFestival and "act_img_di" or "img_di"))
	SLFramework.UGUI.GuiHelper.SetColor(self._imagesignature, haveFestival and "#CD1F1B" or "#C97327")
	self._festivalAtmosphereComp:setFestival(haveFestival)
end

function SignInDetailView:onDestroyView()
	UIBlockMgr.instance:endBlock("signshowing")
	TaskDispatcher.cancelTask(self._setView1Effect, self)
	TaskDispatcher.cancelTask(self._onLineAniStart, self)
	TaskDispatcher.cancelTask(self._calendarBtnEffect, self)
	TaskDispatcher.cancelTask(self._delaySignInRequest, self)
	TaskDispatcher.cancelTask(self._showGetRewards, self)

	for k, v in pairs(self._delayAnimTab) do
		TaskDispatcher.cancelTask(v, self)
	end

	self._simagebg:UnLoadImage()
	self._simagerewardbg:UnLoadImage()
	self._simagemonthicon1:UnLoadImage()
	self._simagemonthicon2:UnLoadImage()
	self._simagemonthicon3:UnLoadImage()

	if self._birthdayHeroIconList then
		for _, iconItem in ipairs(self._birthdayHeroIconList) do
			iconItem.icon:UnLoadImage()
		end
	end

	if self._festivalAtmosphereComp then
		self._festivalAtmosphereComp:onDestroy()
	end
end

function SignInDetailView:closeThis()
	SignInDetailView.super.closeThis(self)
	MailController.instance:showOrRegisterEvent()
end

function SignInDetailView:haveFestival()
	if self._haveFestival == nil then
		self._haveFestival = SignInModel.instance.checkFestivalDecorationUnlock()
	end

	return self._haveFestival
end

function SignInDetailView:_setFestivalColor(textOrImg)
	local hexColor = self:haveFestival() and "#48606C" or "#222222"

	SLFramework.UGUI.GuiHelper.SetColor(textOrImg, hexColor)
end

function SignInDetailView:_refreshSupplement()
	local showBtn = SignInModel.instance:getCanSupplementMonthCardDays() > 0

	gohelper.setActive(self._gosupplement, showBtn)

	if not self._supplementItem then
		self._supplementItem = IconMgr.instance:getCommonItemIcon(self._gosupplementicon)

		self._supplementItem:setMOValue(MaterialEnum.MaterialType.SpecialExpiredItem, StoreEnum.SupplementMonthCardItemId, 1)
	end
end

return SignInDetailView
