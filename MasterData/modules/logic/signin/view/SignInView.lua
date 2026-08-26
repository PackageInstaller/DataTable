-- chunkname: @modules/logic/signin/view/SignInView.lua

module("modules.logic.signin.view.SignInView", package.seeall)

local SignInView = class("SignInView", BaseView)
local csAnimatorPlayer = SLFramework.AnimatorPlayer

function SignInView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._imageweek = gohelper.findChildImage(self.viewGO, "bg/#image_week")
	self._goroleitem = gohelper.findChild(self.viewGO, "bg/#go_roleitem")
	self._simagetopicon = gohelper.findChildSingleImage(self.viewGO, "bg/#go_roleitem/#simage_topicon")
	self._goicontip = gohelper.findChild(self.viewGO, "bg/#go_roleitem/#go_icontip")
	self._txtbirtime = gohelper.findChildText(self.viewGO, "bg/#go_roleitem/#txt_birtime")
	self._txtlimit = gohelper.findChildText(self.viewGO, "bg/#go_roleitem/#txt_limit")
	self._goget = gohelper.findChild(self.viewGO, "rightContent/#go_get")
	self._gonoget = gohelper.findChild(self.viewGO, "rightContent/#go_noget")
	self._gomonthdetail = gohelper.findChild(self.viewGO, "rightContent/monthdetail")
	self._txtdesc = gohelper.findChildText(self.viewGO, "scroll_desc/Viewport/Content/#txt_desc")
	self._txtday = gohelper.findChildText(self.viewGO, "leftContent/#txt_day")
	self._txtdayfestival = gohelper.findChildText(self.viewGO, "leftContent/#txt_day_festival")
	self._txtmonth = gohelper.findChildText(self.viewGO, "leftContent/#txt_month")
	self._txtdate = gohelper.findChildText(self.viewGO, "leftContent/#txt_date")
	self._gorewarditem = gohelper.findChild(self.viewGO, "leftBottomContent/#go_rewarditem")
	self._simageorangebg = gohelper.findChildSingleImage(self._gorewarditem, "#simage_orangebg")
	self._godayrewarditem = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem")
	self._gorewardbg = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#simage_rewardbg")
	self._simagerewardbg = gohelper.findChildSingleImage(self._gorewarditem, "#go_dayrewarditem/#simage_rewardbg")
	self._gototalreward = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward")
	self._txtdaycount = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/monthtitle/#txt_daycount")
	self._gomonth1 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1")
	self._monthreward1Click = gohelper.getClick(self._gomonth1)
	self._gomonthmask1 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1")
	self._month1canvasGroup = self._gomonthmask1:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._gorewardmark1 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#go_rewardmark1")
	self._txtmonthquantity1 = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#txt_monthquantity1")
	self._txtrewardcount1 = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#txt_count1")
	self._gomonthtip1 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthtip1")
	self._gomonthget1 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthget1")
	self._gomonthgetlightanim1 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthget1/vxeffect")
	self._gonomonthget1 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_nomonthget1")
	self._gogetmonthbg1 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#go_getbg1")
	self._simagemonthicon1 = gohelper.findChildSingleImage(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#simage_monthicon1")
	self._month1Ani = self._simagemonthicon1.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._gomonth2 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2")
	self._monthreward2Click = gohelper.getClick(self._gomonth2)
	self._gomonthmask2 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2")
	self._month2canvasGroup = self._gomonthmask2:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._gorewardmark2 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#go_rewardmark2")
	self._txtmonthquantity2 = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#txt_monthquantity2")
	self._txtrewardcount2 = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#txt_count2")
	self._gomonthtip2 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthtip2")
	self._gomonthget2 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthget2")
	self._gomonthgetlightanim2 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthget2/vxeffect")
	self._gonomonthget2 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_nomonthget2")
	self._gogetmonthbg2 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#go_getbg2")
	self._simagemonthicon2 = gohelper.findChildSingleImage(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#simage_monthicon2")
	self._month2Ani = self._simagemonthicon2.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._gomonth3 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3")
	self._monthreward3Click = gohelper.getClick(self._gomonth3)
	self._gomonthmask3 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3")
	self._month3canvasGroup = self._gomonthmask3:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._gorewardmark3 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#go_rewardmark3")
	self._txtmonthquantity3 = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#txt_monthquantity3")
	self._txtrewardcount3 = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#txt_count3")
	self._gomonthtip3 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthtip3")
	self._gomonthget3 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthget3")
	self._gomonthgetlightanim3 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthget3/vxeffect")
	self._gonomonthget3 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_nomonthget3")
	self._gogetmonthbg3 = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#go_getbg3")
	self._simagemonthicon3 = gohelper.findChildSingleImage(self._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#simage_monthicon3")
	self._month3Ani = self._simagemonthicon3.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._gocurrentreward = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward")
	self._gonormal = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal")
	self._gonormaldayreward = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/")
	self._gonormalday = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday")
	self._normaldayClick = gohelper.getClick(self._gonormalday)
	self._gonormalday_gold = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday")
	self._normaldayClick_gold = gohelper.getClick(self._gonormalday_gold)
	self._simagenormaldayrewardicon = gohelper.findChildSingleImage(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday/#simage_normaldayrewardicon")
	self._txtnormaldayrewardcount = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday/#simage_normaldayrewardicon/#txt_normaldayrewardcount")
	self._txtnormaldayrewardname = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday/#txt_normaldayrewardname")
	self._gonormaldaysigned = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normaldaysigned")
	self._gonormaldayget = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normaldaysigned/#go_normaldayget")
	self._gonormaldaynoget = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normaldaysigned/#go_normaldaynoget")
	self._normaldayrewardAni = self._simagenormaldayrewardicon.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._gonormaldayreward_gold = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2")
	self._simagenormaldayrewardicon_gold = gohelper.findChildSingleImage(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday/#simage_normaldayrewardicon")
	self._txtnormaldayrewardcount_gold = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday/#simage_normaldayrewardicon/#txt_normaldayrewardcount")
	self._txtnormaldayrewardname_gold = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday/#txt_normaldayrewardname")
	self._gonormaldaysigned_gold = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normaldaysigned")
	self._gonormaldayget_gold = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normaldaysigned/#go_normaldayget")
	self._gonormaldaynoget_gold = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normaldaysigned/#go_normaldaynoget")
	self._normaldayrewardAni_gold = self._simagenormaldayrewardicon_gold.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._gomonthcard = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard")
	self._gomonthcarddayreward = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward")
	self._gomonthcardday = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday")
	self._monthcarddayClick = gohelper.getClick(self._gomonthcardday)
	self._gomonthcardday_gold = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday")
	self._monthcarddayClick_gold = gohelper.getClick(self._gomonthcardday_gold)
	self._txtmonthcarddayrewardname = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday/#txt_monthcarddayrewardname")
	self._simagemonthcarddayrewardicon = gohelper.findChildSingleImage(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday/#simage_monthcarddayrewardicon")
	self._txtmonthcarddayrewardcount = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday/#simage_monthcarddayrewardicon/#txt_monthcarddayrewardcount")
	self._gomonthcarddaysigned = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcarddaysigned")
	self._gomonthcarddayget = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcarddaysigned/#go_monthcarddayget")
	self._gomonthcarddaynoget = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcarddaysigned/#go_nomonthcarddayget")
	self._gomonthcarddayreward_gold = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2")
	self._txtmonthcarddayrewardname_gold = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday/#txt_monthcarddayrewardname")
	self._simagemonthcarddayrewardicon_gold = gohelper.findChildSingleImage(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday/#simage_monthcarddayrewardicon")
	self._txtmonthcarddayrewardcount_gold = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday/#simage_monthcarddayrewardicon/#txt_monthcarddayrewardcount")
	self._gomonthcarddaysigned_gold = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcarddaysigned")
	self._gomonthcarddayget_gold = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcarddaysigned/#go_monthcarddayget")
	self._gomonthcarddaynoget_gold = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcarddaysigned/#go_nomonthcarddayget")
	self._gomonthcardreward = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward")
	self._gomonthcardrewarditem = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem")
	self._txtmonthcardname = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem/#txt_monthcardname")
	self._simagemonthcardicon = gohelper.findChildSingleImage(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem/#simage_monthcardicon")
	self._monthcardClick = gohelper.getClick(self._gomonthcardrewarditem.gameObject)
	self._gomonthcardpowerrewarditem = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem")
	self._txtmonthcardcount = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem/#simage_monthcardicon/#txt_monthcardcount")
	self._txtmonthcardpowername = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem/#txt_monthcardname")
	self._simagemonthcardpowericon = gohelper.findChildSingleImage(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem/#simage_monthcardicon")
	self._monthcardpowerClick = gohelper.getClick(self._gomonthcardpowerrewarditem.gameObject)
	self._txtmonthcardpowercount = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem/#simage_monthcardicon/#txt_monthcardcount")
	self._gopowerlimittime = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_powerlimittime")
	self._golimittime = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime")
	self._txtlimittime = gohelper.findChildText(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime/#txt_limittime")
	self._gonormallimittimebg = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime/normalbg")
	self._goredlimittimebg = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime/redbg")
	self._gomonthcardsigned = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned")
	self._gomonthcardget = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned/#go_monthcardget")
	self._gomonthcardnoget = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned/#go_monthcardnoget")
	self._gomonthcardpowernoget = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned/#go_monthcardpowernoget")
	self._gobirthdayrewarditem = gohelper.findChild(self._gorewarditem, "#go_birthdayrewarditem")
	self._simagebirthdaybg = gohelper.findChildSingleImage(self._gorewarditem, "#go_birthdayrewarditem/#simage_birthdaybg")
	self._simagebirthdaybg2 = gohelper.findChildSingleImage(self._gorewarditem, "#go_birthdayrewarditem/#simage_birthdaybg2")
	self._gobirthday = gohelper.findChild(self._gorewarditem, "#go_birthdayrewarditem/#go_birthday")
	self._gobirthdayHeroContent = gohelper.findChild(self._gorewarditem, "#go_birthdayrewarditem/#go_birthday/scroll_icon/Viewport/Content")
	self._gobirthdayHeroIcon = gohelper.findChild(self._gorewarditem, "#go_birthdayrewarditem/#go_birthday/scroll_icon/Viewport/Content/#go_icon")
	self._btngift = gohelper.findChildButtonWithAudio(self._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#btn_gift")
	self._gogiftget = gohelper.findChild(self._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#btn_gift/#go_get")
	self._gogiftnoget = gohelper.findChild(self._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#btn_gift/#go_noget")
	self._gogiftreddot = gohelper.findChild(self._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#btn_gift/#go_reddot")
	self._gobirthdayrewarddetail = gohelper.findChild(self._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail")
	self._gocontentSize = gohelper.findChild(self._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize")
	self._trstitle = gohelper.findChild(self._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/bg/title").transform
	self._txtrewarddetailtitle = gohelper.findChildText(self._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/title/#txt_rewarddetailtitle")
	self._gorewardContent = gohelper.findChild(self._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/Scroll View/Viewport/Content")
	self._goclickarea = gohelper.findChild(self._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/Scroll View/Viewport/Content/#go_rewardContent/#go_clickarea")
	self._gorewarddetailitem = gohelper.findChild(self._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/Scroll View/#go_rewarddetailItem")
	self._txtdeco = gohelper.findChildText(self._gorewarditem, "#go_birthdayrewarditem/#go_birthday/ScrollView/Viewport/#txt_deco")
	self._simagesignature = gohelper.findChildSingleImage(self._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#simage_signature")
	self._btnqiehuan = gohelper.findChildButtonWithAudio(self.viewGO, "leftBottomContent/#btn_qiehuan")
	self._goqiehuan = gohelper.findChild(self.viewGO, "leftBottomContent/#btn_qiehuan/#qiehuan")
	self._gosupplement = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_yuekapatch")
	self._gosupplementicon = gohelper.findChild(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_yuekapatch/itemicon")
	self._btnyueka = gohelper.findChildButtonWithAudio(self._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_yuekapatch/#btn_yueka")

	local guideGMNode = GMController.instance:getGMNode("signinview", gohelper.findChild(self.viewGO, "leftContent"))

	if guideGMNode then
		self._gogmhelp = gohelper.findChild(guideGMNode, "#go_gmhelp")
		self._inputheros = gohelper.findChildTextMeshInputField(guideGMNode, "#go_gmhelp/#input_heros")
		self._droptimes = gohelper.findChildDropdown(guideGMNode, "#go_gmhelp/#drop_times")
		self._gochangedate = gohelper.findChild(guideGMNode, "#go_changedate")
		self._inputdate = gohelper.findChildTextMeshInputField(guideGMNode, "#go_changedate/#input_date")
		self._btnchangedateright = gohelper.findChildButtonWithAudio(guideGMNode, "#go_changedate/#btn_changedateright")
		self._btnchangedateleft = gohelper.findChildButtonWithAudio(guideGMNode, "#go_changedate/#btn_changedateleft")
		self._btnswitchdecorate = gohelper.findChildButtonWithAudio(guideGMNode, "#go_gmhelp/#_btns_switchdecorate")
	end

	self._gomonth = gohelper.findChild(self.viewGO, "#go_month")
	self._scrollmonth = gohelper.findChildScrollRect(self.viewGO, "#go_month/#scroll_month")
	self._gomonthlayout = gohelper.findChild(self.viewGO, "#go_month/#scroll_month/#go_monthlayout")
	self._gomonthitem = gohelper.findChild(self.viewGO, "#go_month/#scroll_month/#go_monthlayout/#go_monthitem")
	self._gosigninmonthitem = gohelper.findChild(self.viewGO, "#go_month/#scroll_month/#go_monthlayout/#go_monthitem/#go_signinmonthitem")
	self._gomonthleftline = gohelper.findChild(self.viewGO, "#go_month/leftline")
	self._gomonthrightline = gohelper.findChild(self.viewGO, "#go_month/rightline")
	self._gomonthanim = gohelper.findChild(self.viewGO, "#go_month"):GetComponent(typeof(UnityEngine.Animator))
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_switch")
	self._imageswitchicon = gohelper.findChildImage(self.viewGO, "#btn_switch/#image_switchicon")
	self._gonodes = gohelper.findChild(self.viewGO, "#go_nodes")
	self._gonodeitem = gohelper.findChild(self.viewGO, "#go_nodes/node")
	self._btnrewarddetailclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_rewarddetailclose")
	self._viewAnimPlayer = csAnimatorPlayer.Get(self.viewGO)
	self._viewAniEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	self._gofestivaldecorationbg = gohelper.findChild(self.viewGO, "bg/#go_festivalDecorationBg")
	self._gofestivaldecorationright = gohelper.findChild(self.viewGO, "bg/#go_festivaldecorationright")
	self._gofestivaldecorationleft = gohelper.findChild(self.viewGO, "#go_festivaldecorationleft")
	self._gofestivaldecorationtop = gohelper.findChild(self.viewGO, "bg/#simage_bg/#go_festivaldecorationtop")
	self._godayrewarditem_festivaldecorationtop = gohelper.findChild(self._godayrewarditem, "#go_festivaldecorationtop")
	self._godayrewarditem_gofestivaldecorationleft2 = gohelper.findChild(self._godayrewarditem, "#go_festivaldecorationleft2")
	self._gorewardicon = gohelper.findChild(self.viewGO, "bg/#go_rewardicon")
	self._imgbias = gohelper.findChildImage(self.viewGO, "leftContent/#image_bias")
	self._goeffect = gohelper.findChild(self.viewGO, "#go_effect")
	self._bgeffect = gohelper.findChild(self.viewGO, "bg_effect")
	self._goLifeCircle = gohelper.findChild(self.viewGO, "#go_LifeCircle")
	self._gobtnchange = gohelper.findChild(self.viewGO, "#go_btnchange")
	self._btnchange = gohelper.findChildButtonWithAudio(self._gobtnchange, "#btn_change")
	self._btnchange2 = gohelper.findChildButtonWithAudio(self._gobtnchange, "#btn_change2")
	self._gochange = gohelper.findChild(self._gobtnchange, "#go_change")
	self._gobtnchange_gofestivaldecoration = gohelper.findChild(self._gobtnchange, "#go_festivaldecoration")
	self._goLifeCircleRed = gohelper.findChild(self._gobtnchange, "#go_LifeCircleRed")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SignInView:addEvents()
	self._btnswitch:AddClickListener(self._onBtnSwitch, self)
	self._btnqiehuan:AddClickListener(self._btnqiehuanOnClick, self)
	self._btngift:AddClickListener(self._onBtnGift, self)
	self._btnyueka:AddClickListener(self._onBtnBuQian, self)
	self._btnrewarddetailclose:AddClickListener(self._onBtnRewardDetailClick, self)

	if self._droptimes then
		self._droptimes:AddOnValueChanged(self._onTimesValueChanged, self)
	end

	if self._inputheros then
		self._inputheros:AddOnValueChanged(self._onInputValueChanged, self)
	end

	if self._inputdate then
		self._inputheros:AddOnValueChanged(self._onInputDateChange, self)
	end

	if self._btnchangedateleft then
		self._btnchangedateleft:AddClickListener(self._onBtnChangeDateLeftClick, self)
	end

	if self._btnchangedateright then
		self._btnchangedateright:AddClickListener(self._onBtnChangeDateRightClick, self)
	end

	if self._btnswitchdecorate then
		self._btnswitchdecorate:AddClickListener(self._onBtnChangeDecorate, self)
	end

	self._btnchange:AddClickListener(self._btnchangeOnClick, self)
	self._btnchange2:AddClickListener(self._btnchangeOnClick, self)
end

function SignInView:removeEvents()
	self._btnswitch:RemoveClickListener()
	self._btnqiehuan:RemoveClickListener()
	self._btngift:RemoveClickListener()
	self._btnyueka:RemoveClickListener()
	self._btnrewarddetailclose:RemoveClickListener()

	if self._droptimes then
		self._droptimes:RemoveOnValueChanged()
	end

	if self._inputheros then
		self._inputheros:RemoveOnValueChanged()
	end

	if self._inputdate then
		self._inputdate:RemoveOnValueChanged()
	end

	if self._btnchangedateright then
		self._btnchangedateright:RemoveClickListener()
	end

	if self._btnchangedateleft then
		self._btnchangedateleft:RemoveClickListener()
	end

	if self._btnswitchdecorate then
		self._btnswitchdecorate:RemoveClickListener()
	end

	self._btnchange:RemoveClickListener()
	self._btnchange2:RemoveClickListener()
end

SignInView.MaxTipContainerHeight = 420
SignInView.EveryTipItemHeight = 135
SignInView.TipVerticalInterval = 25

local kBlockKeySwitchLifeCircleAnsSignIn = "SignInView:_switchLifeCircleAnsSignIn"

function SignInView:_onTimesValueChanged(index)
	local inputValue = self:_getTextInputheros()

	if not inputValue or inputValue == "" then
		return
	end

	local birthdayHeros = string.splitToNumber(inputValue, "|")

	if not birthdayHeros or #birthdayHeros < 1 then
		return
	end

	gohelper.setActive(self._btnqiehuan.gameObject, true)
end

function SignInView:_onInputDateChange()
	return
end

function SignInView:_onBtnBuQian()
	local currencyParam = {}
	local item = {
		isHideAddBtn = true,
		id = StoreEnum.SupplementMonthCardItemId,
		type = MaterialEnum.MaterialType.SpecialExpiredItem
	}

	table.insert(currencyParam, item)
	SignInController.instance:showPatchpropUseView(MessageBoxIdDefine.SupplementMonthCardUseTip, MsgBoxEnum.BoxType.Yes_No, currencyParam, self._useSupplementMonthCard, nil, nil, self, nil, nil, SignInModel.instance:getCanSupplementMonthCardDays())
end

function SignInView:_useSupplementMonthCard()
	SignInRpc.instance:sendSupplementMonthCardRequest()
end

function SignInView:_onBtnChangeDateLeftClick()
	self:_refreshGMDateContent(1)
end

function SignInView:_onBtnChangeDateRightClick()
	self:_refreshGMDateContent(-1)
end

function SignInView:_onBtnChangeDecorate()
	if self._isActiveLifeCircle then
		GameFacade.showToast(ToastEnum.IconId, "生命签界面是常驻界面，无法切换氛围！")

		return
	end

	self:_switchFestivalDecoration(not self._haveFestival)
	self:_setPropItems()
end

function SignInView:_refreshGMDateContent(changeNum)
	local date = string.splitToNumber(self._inputdate:GetText(), "-")

	if not date or #date ~= 3 then
		logError("请按照正确的格式输入日期！")

		return
	end

	local datets = TimeUtil.timeToTimeStamp(date[1], date[2], date[3], 1, 1, 1) + 86400 * changeNum
	local week = os.date("%w", datets)

	UISpriteSetMgr.instance:setSignInSprite(self._imageweek, "date_" .. tostring(week))

	self._txtdesc.text = SignInConfig.instance:getSignDescByDate(datets)

	ZProj.UGUIHelper.RebuildLayout(self._txtdesc.gameObject.transform)
	gohelper.setActive(self._txtdesc.gameObject, false)
	gohelper.setActive(self._txtdesc.gameObject, true)

	local dayStr = string.format("%02d", os.date("%d", datets))

	self:_setDayTextStr(dayStr)

	self._txtmonth.text = string.format("%02d", os.date("%m", datets))
	self._txtdate.text = string.format("%s.%s", string.upper(string.sub(os.date("%B", datets), 1, 3)), os.date("%Y", datets))

	local timeTxt = TimeUtil.timestampToString1(datets)

	self._inputdate:SetText(timeTxt)
end

function SignInView:_onInputValueChanged()
	local inputValue = self:_getTextInputheros()

	if inputValue ~= "" then
		gohelper.setActive(self._btnqiehuan.gameObject, true)

		return
	end

	local birthdayHeros = SignInModel.instance:getSignBirthdayHeros(self._targetDate[1], self._targetDate[2], self._targetDate[3])

	gohelper.setActive(self._btnqiehuan.gameObject, #((self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] or nil) and SignInModel.instance:getCurDayBirthdayHeros()) > 0)
end

function SignInView:_onBtnSwitch()
	SignInModel.instance:setNewSwitch(true)

	local showBirthday = SignInModel.instance:isShowBirthday()

	SignInModel.instance:setShowBirthday(not showBirthday)
	SignInController.instance:dispatchEvent(SignInEvent.SwitchBirthdayState)
	self:_setTitleInfo()
end

function SignInView:_btnqiehuanOnClick()
	local birthdayHeros = SignInModel.instance:getSignBirthdayHeros(self._targetDate[1], self._targetDate[2], self._targetDate[3])

	if self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] then
		birthdayHeros = SignInModel.instance:getCurDayBirthdayHeros()
	end

	local inputValue = self:_getTextInputheros()

	self._index = (self._index + 1) % (#((inputValue ~= "" or nil) and string.splitToNumber(inputValue, "|")) + 1)

	UIBlockMgr.instance:startBlock("signshowing")
	TaskDispatcher.runDelay(self._onQiehuanFinished, self, 0.85)

	if self._index == 1 then
		self:_setRewardItems()
		self:_playAnim("tobirthday")
	elseif self._index > 1 then
		self:_playAnim("birhtobirth")
	else
		self:_playAnim("tonormal")
	end
end

function SignInView:_onQiehuanFinished()
	UIBlockMgr.instance:endBlock("signshowing")
end

function SignInView:_onBtnGift()
	local birthdayHeros = SignInModel.instance:getSignBirthdayHeros(self._targetDate[1], self._targetDate[2], self._targetDate[3])

	if self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] then
		birthdayHeros = SignInModel.instance:getCurDayBirthdayHeros()

		local inputValue = self:_getTextInputheros()
		local heroId = ((inputValue ~= "" or nil) and string.splitToNumber(inputValue, "|"))[self._index]
		local giftGet = SignInModel.instance:isHeroBirthdayGet(heroId)

		if not giftGet then
			self._startGetReward = true

			SignInRpc.instance:sendGetHeroBirthdayRequest(heroId)

			return
		end
	end

	self:_showBirthdayRewardDetail()
end

function SignInView:_onBtnRewardDetailClick()
	gohelper.setActive(self._btnrewarddetailclose.gameObject, false)
	gohelper.setActive(self._gobirthdayrewarddetail, false)
end

function SignInView:_addCustomEvent()
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
	SignInController.instance:registerCallback(SignInEvent.CloseSignInView, self._onEscapeBtnClick, self)
	PlayerController.instance:registerCallback(PlayerEvent.OnDailyRefresh, self._onDailyRefresh, self)
	SignInController.instance:registerCallback(SignInEvent.OnReceiveSupplementMonthCardReply, self._refreshSupplement, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function SignInView:_removeCustomEvent()
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
	SignInController.instance:unregisterCallback(SignInEvent.CloseSignInView, self._onEscapeBtnClick, self)
	PlayerController.instance:unregisterCallback(PlayerEvent.OnDailyRefresh, self._onDailyRefresh, self)
	SignInController.instance:unregisterCallback(SignInEvent.OnReceiveSupplementMonthCardReply, self._refreshSupplement, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function SignInView:_onEscapeBtnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_close)
	self:_playAnim("out")
	TaskDispatcher.runDelay(self._waitCloseView, self, 0.2)
end

function SignInView:_onDayRewardClick()
	MaterialTipController.instance:showMaterialInfo(self._curDayRewards[1], self._curDayRewards[2])
end

function SignInView:_onDayGoldRewardClick()
	MaterialTipController.instance:showMaterialInfo(self._goldReward[1], self._goldReward[2])
end

function SignInView:_onMonthCardRewardClick()
	MaterialTipController.instance:showMaterialInfo(self._curmonthCardRewards[1], self._curmonthCardRewards[2])
end

function SignInView:_onMonthCardPowerRewardClick()
	MaterialTipController.instance:showMaterialInfo(self._curmonthCardPower[1], self._curmonthCardPower[2])
end

function SignInView:_onChangeToBirthday()
	gohelper.setSiblingBefore(self._godayrewarditem, self._gobirthdayrewarditem)
end

function SignInView:_onChangeToNormal()
	self:_setRewardItems()
	gohelper.setSiblingBefore(self._gobirthdayrewarditem, self._godayrewarditem)
end

function SignInView:_onChangeBirthdayToBirthday()
	self:_setRewardItems()
end

function SignInView:_onGetSignInInfo()
	self:_setMonthView()
end

function SignInView:_onGetSignInReply()
	self:_setMonthView()
end

function SignInView:_onGetHeroBirthday()
	local birthdayHeros = SignInModel.instance:getSignBirthdayHeros(self._targetDate[1], self._targetDate[2], self._targetDate[3])

	if self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] then
		birthdayHeros = SignInModel.instance:getCurDayBirthdayHeros()
	end

	local inputValue = self:_getTextInputheros()
	local hasBirthdayRewards = false

	for _, v in pairs((inputValue ~= "" and self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] or nil) and string.splitToNumber(inputValue, "|")) do
		local giftGet = SignInModel.instance:isHeroBirthdayGet(v)

		if not giftGet then
			hasBirthdayRewards = true
		end
	end

	gohelper.setActive(self._goqiehuan, hasBirthdayRewards)
	gohelper.setActive(self._gogiftnoget, false)
	gohelper.setActive(self._gogiftget, true)
end

function SignInView:_closeViewEffect()
	self._clickMonth = true
	self._index = 0

	self:_playAnim("idel")
	self:_setMonthView()
	gohelper.setSiblingBefore(self._gobirthdayrewarditem, self._godayrewarditem)
end

function SignInView:onClickModalMask()
	self:_onEscapeBtnClick()
end

function SignInView:_waitCloseView()
	SignInController.instance:openSignInDetailView(self.viewParam)
	self:closeThis()
end

function SignInView:_editableInitView()
	gohelper.addUIClickAudio(self._btnqiehuan.gameObject, AudioEnum.UI.play_ui_sign_in_qiehuan)
	gohelper.addUIClickAudio(self._btnswitch.gameObject, AudioEnum.UI.play_ui_sign_in_switch)

	self._clickMonth = false

	gohelper.setActive(self._gomonthleftline, false)
	gohelper.setActive(self._gomonthrightline, false)
	gohelper.setActive(self._gomonthget1, false)
	gohelper.setActive(self._gonomonthget1, false)
	gohelper.setActive(self._gomonthget2, false)
	gohelper.setActive(self._gonomonthget2, false)
	gohelper.setActive(self._gomonthget3, false)
	gohelper.setActive(self._gonomonthget3, false)
	gohelper.setActive(self._gomonthcardsigned, false)
	gohelper.setActive(self._gomonthcarddaysigned, false)
	gohelper.setActive(self._gomonthcarddaysigned_gold, false)
	gohelper.setActive(self._gonormaldaysigned, false)
	gohelper.setActive(self._gonormaldaysigned_gold, false)
	self._normaldayrewardAni:Play("none")
	self._normaldayrewardAni_gold:Play("none")
	self:_playAnim("go_view_in2")

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
	self._simagebg:LoadImage(ResUrl.getSignInBg("bg_white2"))
	self._simagebg1:LoadImage(ResUrl.getSignInBg("bg_zs"))
	self._simageorangebg:LoadImage(ResUrl.getSignInBg("img_bcard3"))
	self._simagerewardbg:LoadImage(ResUrl.getSignInBg("img_di"))

	self._rewardTipItems = {}
	self._nodeItems = {}
	self._monthItemTabs = self:getUserDataTb_()
	self._monthgetlightanimTab = self:getUserDataTb_()
	self._delayAnimTab = self:getUserDataTb_()
	self._monthRewards = self:getUserDataTb_()

	table.insert(self._monthgetlightanimTab, self._gomonthgetlightanim1)
	table.insert(self._monthgetlightanimTab, self._gomonthgetlightanim2)
	table.insert(self._monthgetlightanimTab, self._gomonthgetlightanim3)

	for k, v in ipairs(self._monthgetlightanimTab) do
		gohelper.setActive(v, false)
	end

	self._btnchangeGo = self._btnchange.gameObject
	self._btnchange2Go = self._btnchange2.gameObject
	self._festivalAtmosphereComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, FestivalAtmosphereComp, self)

	self:_setActive_LifeCicle(false)
	RedDotController.instance:addRedDot(self._goLifeCircleRed, RedDotEnum.DotNode.LifeCircleNewConfig, nil, self._checkLifeCircleRed, self)
end

function SignInView:onOpen()
	self._index = 0
	self._checkSignIn = true

	SignInModel.instance:setShowBirthday(self.viewParam.isBirthday)
	self:_addCustomEvent()
	self:_setMonthView(true)
	self:_setRedDot()

	if self._gogmhelp then
		gohelper.setActive(self._gogmhelp, GMController.instance:isOpenGM())
	end

	if self._gochangedate then
		gohelper.setActive(self._gochangedate, GMController.instance:isOpenGM())
	end

	SignInModel.instance:setNewShowDetail(true)
	NavigateMgr.instance:addEscape(ViewName.SignInView, self._onEscapeBtnClick, self)
	self:_refreshFestivalDecoration()

	if self.viewParam.isActiveLifeCicle then
		self:_setActive_LifeCicle(true)
	end
end

function SignInView:_initIndex()
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

	local inputValue = self:_getTextInputheros()

	for k, v in ipairs((inputValue ~= "" and self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] or nil) and string.splitToNumber(inputValue, "|")) do
		local giftGet = SignInModel.instance:isHeroBirthdayGet(v)

		if not giftGet then
			gohelper.setSiblingBefore(self._godayrewarditem, self._gobirthdayrewarditem)

			self._index = k

			return
		end
	end
end

function SignInView:_onDailyRefresh()
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
	gohelper.setActive(self._gomonthcarddayget, false)
	gohelper.setActive(self._gomonthcarddayget_gold, false)
	gohelper.setActive(self._gomonthcardget, false)
	gohelper.setActive(self._gonormaldaynoget, false)
	gohelper.setActive(self._gomonthcarddaynoget, false)
	gohelper.setActive(self._gomonthcarddaynoget_gold, false)
	gohelper.setActive(self._gomonthcardnoget, false)
	gohelper.setActive(self._gomonthcardpowernoget, false)
	gohelper.setActive(self._goget, false)
	gohelper.setActive(self._gonoget, true)
	gohelper.setActive(self._goget, false)
	gohelper.setActive(self._gonoget, false)
	self:_setMonthView()
	self:_onChangeToNormal()
end

function SignInView:_onChangeItemClick()
	self._index = 0

	self:_playAnim("idel")
	self:_setMonthView()
	gohelper.setSiblingBefore(self._gobirthdayrewarditem, self._godayrewarditem)
end

function SignInView:_setMonthView(open)
	self:_setSignInData()

	if open then
		self:_playOpenAudio()
		self:_initIndex()
	end

	self:_setTitleInfo()
	self:_setRewardItems()
	self:_setMonthViewRewardTips()
	self:_setPropItems()
	self:_setMonthItems()
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
		gohelper.setActive(self._gomonthcarddayget, true)
		gohelper.setActive(self._gomonthcarddayget_gold, true)
		gohelper.setActive(self._gomonthcardget, true)
		gohelper.setActive(self._gonormaldaynoget, false)
		gohelper.setActive(self._gomonthcarddaynoget, false)
		gohelper.setActive(self._gomonthcarddaynoget_gold, false)
		gohelper.setActive(self._gomonthcardnoget, false)
		gohelper.setActive(self._gomonthcardpowernoget, false)
		gohelper.setActive(self._goget, false)
		gohelper.setActive(self._gonoget, true)
		self._normaldayrewardAni:Play("none")
		self._normaldayrewardAni_gold:Play("none")
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
		gohelper.setActive(self._goget, true)
		gohelper.setActive(self._gonoget, false)
		ZProj.UGUIHelper.SetColorAlpha(self._txtnormaldayrewardcount, 0.7)

		if self._gonormaldayget.activeSelf then
			self._normaldayrewardAni:Play("none")
			self._normaldayrewardAni_gold:Play("none")
		else
			gohelper.setActive(self._gomonthcarddayget, false)
			gohelper.setActive(self._gomonthcarddayget_gold, false)
			gohelper.setActive(self._gomonthcardget, false)
			gohelper.setActive(self._gomonthcardnoget, true)
			gohelper.setActive(self._gomonthcardpowernoget, true)
			gohelper.setActive(self._gomonthcarddaynoget, true)
			gohelper.setActive(self._gomonthcarddaynoget_gold, true)
			self._normaldayrewardAni:Play("lingqu")
			self._normaldayrewardAni_gold:Play("lingqu")
		end
	end
end

function SignInView:_setSignInData()
	self._curDate = SignInModel.instance:getCurDate()
	self._targetDate = SignInModel.instance:getSignTargetDate()
	self._curDayRewards = SignInModel.instance:getSignRewardsByDate(self._curDate)
	self._rewardGetState = SignInModel.instance:isSignDayRewardGet(self._targetDate[3])
	self._isCurDayRewardGet = SignInModel.instance:isSignDayRewardGet(self._curDate.day)
end

function SignInView:_playOpenAudio()
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

function SignInView:_setTitleInfo()
	local datets = TimeUtil.timeToTimeStamp(self._targetDate[1], self._targetDate[2], self._targetDate[3], TimeDispatcher.DailyRefreshTime, 1, 1)
	local week = os.date("%w", datets)

	UISpriteSetMgr.instance:setSignInSprite(self._imageweek, "date_" .. tostring(week))

	self._txtdesc.text = SignInConfig.instance:getSignDescByDate(datets)

	ZProj.UGUIHelper.RebuildLayout(self._txtdesc.gameObject.transform)
	gohelper.setActive(self._txtdesc.gameObject, false)
	gohelper.setActive(self._txtdesc.gameObject, true)
	self:_setDayTextStr(string.format("%02d", self._targetDate[3]))

	self._txtmonth.text = string.format("%02d", self._targetDate[2])
	self._txtdate.text = string.format("%s.%s", string.upper(string.sub(os.date("%B", datets), 1, 3)), self._targetDate[1])

	local switchicon = SignInModel.instance:isShowBirthday() and "switch_icon1" or "switch_icon2"

	UISpriteSetMgr.instance:setSignInSprite(self._imageswitchicon, switchicon)

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

function SignInView:_setDayTextStr(dayStr)
	self._txtday.text = dayStr
	self._txtdayfestival.text = dayStr
end

function SignInView:_setRewardItems()
	local birthdayHeros = SignInModel.instance:getSignBirthdayHeros(self._targetDate[1], self._targetDate[2], self._targetDate[3])

	if self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] then
		birthdayHeros = SignInModel.instance:getCurDayBirthdayHeros()
	end

	local inputValue = self:_getTextInputheros()

	if inputValue ~= "" and self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] then
		birthdayHeros = string.splitToNumber(inputValue, "|")
	end

	if self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] then
		if self._index > 0 then
			RedDotController.instance:addRedDot(self._gogiftreddot, RedDotEnum.DotNode.SignInBirthReward, birthdayHeros[self._index])
		end
	else
		RedDotController.instance:addRedDot(self._gogiftreddot, 0)
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

	for _, v in pairs(self._nodeItems) do
		gohelper.setActive(v.go, false)
	end

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

function SignInView:_showNoBirthdayRewardItem()
	gohelper.setActive(self._btnqiehuan.gameObject, false)
	gohelper.setActive(self._simageorangebg.gameObject, false)
	gohelper.setActive(self._gobirthdayrewarditem, false)
end

function SignInView:_showDayRewardItem()
	gohelper.setActive(self._gobirthday, false)
	gohelper.setActive(self._btnqiehuan.gameObject, true)
	gohelper.setActive(self._simageorangebg.gameObject, true)
	gohelper.setActive(self._gobirthdayrewarditem, true)
	self._simagebirthdaybg:LoadImage(ResUrl.getSignInBg("img_bcard1"))
	self._simagebirthdaybg2:LoadImage(ResUrl.getSignInBg("img_bcard1"))
end

function SignInView:_showBirthdayRewardItem()
	gohelper.setActive(self._gobirthday, true)
	gohelper.setActive(self._btnqiehuan.gameObject, true)
	gohelper.setActive(self._simageorangebg.gameObject, true)
	gohelper.setActive(self._gobirthdayrewarditem, true)
	self._simagebirthdaybg:LoadImage(ResUrl.getSignInBg("img_bcard1"))
	self._simagebirthdaybg2:LoadImage(ResUrl.getSignInBg("img_bcard1"))
	self:_setBirthdayInfo()
end

function SignInView:_delaySignInRequest()
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
	gohelper.setActive(self._goget, true)
	gohelper.setActive(self._gonoget, false)
	self._normaldayrewardAni:Play("lingqu")
	self._normaldayrewardAni_gold:Play("lingqu")
	ZProj.UGUIHelper.SetColorAlpha(self._txtnormaldayrewardcount, 0.7)
	UIBlockMgr.instance:endBlock("signshowing")

	if self._startGetReward then
		return
	end

	LifeCircleController.instance:sendSignInRequest()

	self._startGetReward = true
end

function SignInView:_onCloseViewFinish(viewName)
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

function SignInView:_onWaitSwitchBirthFinished()
	UIBlockMgr.instance:endBlock("switchshowing")
end

function SignInView:_onCloseMonthRewardDetailClick()
	gohelper.setActive(self._gomonthrewarddetail, false)
end

function SignInView:_onMonthRewardClick(id)
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

function SignInView:_showGetRewards()
	if self._targetid then
		gohelper.setActive(self._gomonthgets[self._targetid], false)
		gohelper.setActive(self._gonomonthgets[self._targetid], true)
		SignInRpc.instance:sendSignInAddupRequest(self._targetid)

		self._targetid = nil
	end
end

function SignInView:_setBirthdayInfo()
	local birthdayHeros = SignInModel.instance:getSignBirthdayHeros(self._targetDate[1], self._targetDate[2], self._targetDate[3])

	if self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] then
		birthdayHeros = SignInModel.instance:getCurDayBirthdayHeros()
	end

	local inputValue = self:_getTextInputheros()
	local heroId = ((inputValue ~= "" or nil) and string.splitToNumber(inputValue, "|"))[self._index]

	self._birthdayHeroIconList = {}

	local heroIdWithSPList = HeroConfig.instance:getSPHeroIdList(heroId, true)

	gohelper.CreateObjList(self, self._onCreateBirthdayHeroIcon, heroIdWithSPList, self._gobirthdayHeroContent, self._gobirthdayHeroIcon)

	local birthdayCount = SignInModel.instance:getHeroBirthdayCount(heroId)
	local index = birthdayCount

	if self._curDate.month == self._targetDate[2] then
		local birthdayGet = SignInModel.instance:isHeroBirthdayGet(heroId)

		index = self._curDate.year == self._targetDate[1] and (birthdayGet and birthdayCount or birthdayCount + 1) or birthdayGet and birthdayCount - 1 or birthdayCount
	end

	if inputValue ~= "" then
		index = self._droptimes:GetValue() + 1
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

function SignInView:_onCreateBirthdayHeroIcon(obj, data, index)
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

function SignInView:_setMonthViewRewardTips()
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
		ZProj.UGUIHelper.SetColorAlpha(self._txtrewardcount1, 0.5)
	else
		gohelper.setActive(self._gomonthget1, false)
		gohelper.setActive(self._gonomonthget1, false)
		self._month1Ani:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(self._txtmonthquantity1, 1)
		ZProj.UGUIHelper.SetColorAlpha(self._txtrewardcount1, 1)
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
		ZProj.UGUIHelper.SetColorAlpha(self._txtrewardcount2, 0.5)
	else
		gohelper.setActive(self._gomonthget2, false)
		gohelper.setActive(self._gonomonthget2, false)
		self._month2Ani:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(self._txtmonthquantity2, 1)
		ZProj.UGUIHelper.SetColorAlpha(self._txtrewardcount2, 1)
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
		ZProj.UGUIHelper.SetColorAlpha(self._txtrewardcount3, 0.5)
	else
		gohelper.setActive(self._gomonthget3, false)
		gohelper.setActive(self._gonomonthget3, false)
		self._month3Ani:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(self._txtmonthquantity3, 1)
		ZProj.UGUIHelper.SetColorAlpha(self._txtrewardcount3, 1)
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

function SignInView:_setGoldRewards(targetdate)
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

function SignInView:_showMonthRewardInfo(index)
	local o = {}

	o.rewardCo = SignInConfig.instance:getSignMonthReward(index)
	o.rewards = string.split(o.rewardCo.signinBonus, "|")
	o.reward = string.split(o.rewards[1], "#")

	local config, icon = ItemModel.instance:getItemConfigAndIcon(o.reward[1], o.reward[2])

	self["_simagemonthicon" .. index]:LoadImage(icon)

	self["_txtmonthquantity" .. index].text = o.rewardCo.signinaddup
	self["_txtrewardcount" .. index].text = string.format("%s%s", luaLang("multiple"), o.reward[3])

	table.insert(self._monthRewards, index, o)
end

function SignInView:_setPropItems()
	local timestamp = os.time({
		day = 0,
		year = self._targetDate[1],
		month = self._targetDate[2] + 1
	})
	local dayAmount = os.date("%d", timestamp)
	local co = {}
	local wdayTimeStamp = TimeUtil.timeToTimeStamp(self._targetDate[1], self._targetDate[2], 1, TimeDispatcher.DailyRefreshTime, 1, 1)
	local wday = TimeUtil.getTodayWeedDay(os.date("*t", wdayTimeStamp))

	for i = 1, wday - 1 do
		table.insert(co, {
			isEmpty = 0
		})
	end

	for i = 1, tonumber(dayAmount) do
		local gift = SignInConfig.instance:getSignRewardBouns(wday)
		local o = {}

		o.materilType = gift[1]
		o.materilId = gift[2]
		o.quantity = gift[3]
		o.isIcon = true
		o.parent = self
		o.day = i
		o.wday = wday

		table.insert(co, o)

		wday = wday + 1

		if wday > 7 then
			wday = 1
		end
	end

	SignInListModel.instance:setPropList(co)
end

function SignInView:_setMonthItems()
	local monthCo = SignInModel.instance:getShowMonthItemCo()

	self:_onCloneSigninMonthItem(monthCo)
end

function SignInView:_onCloneSigninMonthItem(co)
	for k, v in ipairs(co) do
		local signinmonthItem = self._monthItemTabs[k]

		if not signinmonthItem then
			signinmonthItem = {
				go = gohelper.clone(self._gosigninmonthitem, self._gomonthitem, "item" .. k)
			}
			signinmonthItem.anim = gohelper.findChild(signinmonthItem.go, "obj"):GetComponent(typeof(UnityEngine.Animator))
			signinmonthItem.anim.enabled = false

			gohelper.setActive(signinmonthItem.go, false)

			signinmonthItem.monthitem = MonoHelper.addNoUpdateLuaComOnceToGo(signinmonthItem.go, SignInMonthListItem, self)

			table.insert(self._monthItemTabs, signinmonthItem)
		end

		signinmonthItem.monthitem:init(signinmonthItem.go)
		signinmonthItem.monthitem:onUpdateMO(v)
	end

	self:_showSigninMonthItemEffect(co)
end

function SignInView:_showSigninMonthItemEffect(co)
	for i = 1, #co do
		local function func()
			self:_showMonthItem(i)
		end

		TaskDispatcher.runDelay(func, self, i * 0.03)
		table.insert(self._delayAnimTab, func)
	end

	TaskDispatcher.runDelay(self._onLineAniStart, self, (#co + 1) * 0.1)
end

function SignInView:_showMonthItem(i)
	gohelper.setActive(self._monthItemTabs[i].go, true)

	self._monthItemTabs[i].anim.enabled = true
end

function SignInView:_showBirthdayRewardDetail()
	gohelper.setActive(self._gobirthdayrewarddetail, true)
	gohelper.setActive(self._btnrewarddetailclose.gameObject, true)

	local birthdayHeros = SignInModel.instance:getSignBirthdayHeros(self._targetDate[1], self._targetDate[2], self._targetDate[3])

	if self._curDate.year == self._targetDate[1] and self._curDate.month == self._targetDate[2] and self._curDate.day == self._targetDate[3] then
		birthdayHeros = SignInModel.instance:getCurDayBirthdayHeros()
	end

	local inputValue = self:_getTextInputheros()
	local heroId = ((inputValue ~= "" or nil) and string.splitToNumber(inputValue, "|"))[self._index]
	local birthdayCount = SignInModel.instance:getHeroBirthdayCount(heroId)
	local index = birthdayCount

	if self._curDate.month == self._targetDate[2] then
		local birthdayGet = SignInModel.instance:isHeroBirthdayGet(heroId)

		index = self._curDate.year == self._targetDate[1] and (birthdayGet and birthdayCount or birthdayCount + 1) or birthdayGet and birthdayCount - 1 or birthdayCount
	end

	if inputValue ~= "" then
		index = self._droptimes:GetValue() + 1
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

			o.go = gohelper.clone(self._gorewarddetailitem, self._gorewardContent, "item" .. k)

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

function SignInView:_hideAllRewardTipsItem()
	for _, item in ipairs(self._rewardTipItems) do
		gohelper.setActive(item.go, false)
	end
end

function SignInView:_computeRewardsTipsContainerHeight(itemCount)
	local titleHeight = recthelper.getHeight(self._trstitle)
	local itemHeight = recthelper.getHeight(self._gorewarddetailitem.transform)
	local height = titleHeight + itemCount * itemHeight - 10

	recthelper.setHeight(self._gocontentSize.transform, height)
end

function SignInView:_onLineAniStart()
	gohelper.setActive(self._gomonthleftline, true)
	gohelper.setActive(self._gomonthrightline, true)
end

function SignInView:_setRedDot()
	RedDotController.instance:addRedDot(self._gomonthtip1, RedDotEnum.DotNode.SignInMonthTab, 1)
	RedDotController.instance:addRedDot(self._gomonthtip2, RedDotEnum.DotNode.SignInMonthTab, 2)
	RedDotController.instance:addRedDot(self._gomonthtip3, RedDotEnum.DotNode.SignInMonthTab, 3)
end

function SignInView:_switchFestivalDecoration(haveFestival)
	if self._haveFestival == haveFestival then
		return
	end

	self._haveFestival = haveFestival

	self:_refreshFestivalDecoration()
end

function SignInView:_refreshFestivalDecoration()
	local haveFestival = self:haveFestival()

	gohelper.setActive(self._gofestivaldecorationbg, haveFestival)
	gohelper.setActive(self._gofestivaldecorationright, haveFestival)
	gohelper.setActive(self._gofestivaldecorationleft, haveFestival)
	gohelper.setActive(self._gofestivaldecorationtop, haveFestival)
	gohelper.setActive(self._gorewardicon, not haveFestival)
	gohelper.setActive(self._goeffect, haveFestival)
	gohelper.setActive(self._bgeffect, haveFestival)
	gohelper.setActive(self._godayrewarditem_festivaldecorationtop, haveFestival)
	gohelper.setActive(self._godayrewarditem_gofestivaldecorationleft2, haveFestival)
	gohelper.setActive(self._gobtnchange_gofestivaldecoration, haveFestival)
	gohelper.setActive(self._gochange, not haveFestival)
	gohelper.setActive(self._txtday, not haveFestival)
	gohelper.setActive(self._txtdayfestival, haveFestival)
	self:_setFestivalColor(self._txtmonth, "#48606C")
	self:_setFestivalColor(self._imgbias, "#48606C")
	self:_setFestivalColor(self._txtday)
	self:_setFestivalColor(self._txtdate)
	self._simagebg:LoadImage(ResUrl.getSignInBg(haveFestival and "act_bg_white2" or "bg_white2"))
	self._simagerewardbg:LoadImage(ResUrl.getSignInBg(haveFestival and "act_img_di" or "img_di"))
	self._festivalAtmosphereComp:setFestival(haveFestival)
end

function SignInView:onClose()
	TaskDispatcher.cancelTask(self._setActive_LifeCircle, self)
	TaskDispatcher.cancelTask(self._onSwitchRewardAnim, self)
	UIBlockHelper.instance:endBlock(kBlockKeySwitchLifeCircleAnsSignIn)

	if self._lifeCircleSignView then
		self._lifeCircleSignView:onClose()
	end

	self:_removeCustomEvent()
end

function SignInView:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_lifeCircleSignView")
	UIBlockMgr.instance:endBlock("signshowing")
	SignInModel.instance:setNewSwitch(false)
	SignInListModel.instance:clearPropList()
	TaskDispatcher.cancelTask(self._setView1Effect, self)
	TaskDispatcher.cancelTask(self._onLineAniStart, self)
	TaskDispatcher.cancelTask(self._delaySignInRequest, self)
	TaskDispatcher.cancelTask(self._showGetRewards, self)
	TaskDispatcher.cancelTask(self._onWaitSwitchBirthFinished, self)

	for k, v in pairs(self._delayAnimTab) do
		TaskDispatcher.cancelTask(v, self)
	end

	self._simagebg:UnLoadImage()
	self._simagemonthicon1:UnLoadImage()
	self._simagemonthicon2:UnLoadImage()
	self._simagemonthicon3:UnLoadImage()
	self._simagenormaldayrewardicon:UnLoadImage()
	self._simageorangebg:UnLoadImage()
	self._simagerewardbg:UnLoadImage()
	self._simagebirthdaybg:UnLoadImage()
	self._simagebirthdaybg2:UnLoadImage()

	if self._birthdayHeroIconList then
		for _, iconItem in ipairs(self._birthdayHeroIconList) do
			iconItem.icon:UnLoadImage()
		end
	end

	if self._festivalAtmosphereComp then
		self._festivalAtmosphereComp:onDestroy()
	end

	if self.viewParam and self.viewParam.callback then
		self.viewParam.callback(self.viewParam.callbackObj)
	end
end

function SignInView:closeThis()
	SignInView.super.closeThis(self)
end

function SignInView:_getTextInputheros()
	if self._inputheros then
		return self._inputheros:GetText()
	end

	return ""
end

function SignInView:haveFestival(isReset)
	if self._haveFestival == nil or isReset then
		self._haveFestival = SignInModel.instance.checkFestivalDecorationUnlock()
	end

	return self._haveFestival
end

function SignInView:_setFestivalColor(textOrImg, festColor)
	festColor = festColor or "#12141C"

	local hexColor = self:haveFestival() and festColor or "#222222"

	SLFramework.UGUI.GuiHelper.SetColor(textOrImg, hexColor)
end

function SignInView:_btnchangeOnClick()
	self:_setActive_LifeCicle(not self._isActiveLifeCircle)
end

function SignInView:_setActive_LifeCicle(isActive)
	gohelper.setActive(self._gomonth, not isActive)

	if self._isActiveLifeCircle == isActive then
		return
	end

	self._isActiveLifeCircle = isActive

	if isActive then
		self:_refreshLifeCircleView()
	end

	if self._lifeCircleSignView then
		self:_switchLifeCircleAnsSignIn(isActive)
	else
		self:_setActive_LifeCircle(isActive)
	end
end

function SignInView:_refreshLifeCircleView()
	local view = self._lifeCircleSignView

	if not view then
		view = LifeCircleSignView.New({
			parent = self,
			baseViewContainer = self.viewContainer
		})

		local go = self.viewContainer:getResInst(SignInEnum.ResPath.lifecirclesignview, self._goLifeCircle)

		view:init(go)
		view:onOpen()

		self._lifeCircleSignView = view
	else
		view:onUpdateParam()
	end
end

function SignInView:_switchLifeCircleAnsSignIn(isSwitchToLifeCircleView)
	TaskDispatcher.cancelTask(self._setActive_LifeCircle, self)
	UIBlockHelper.instance:endBlock(kBlockKeySwitchLifeCircleAnsSignIn)

	if isSwitchToLifeCircleView then
		self:_playAnim("switch_reward")
		TaskDispatcher.runDelay(self._onSwitchRewardAnim, self, 0.16)
	else
		UIBlockHelper.instance:startBlock(kBlockKeySwitchLifeCircleAnsSignIn, 2, self.viewName)
		self:_playAnim("switch_main")
		TaskDispatcher.runDelay(self._setActive_LifeCircle, self, 0.16)
	end
end

function SignInView:_setActive_LifeCircle(isActive)
	gohelper.setActive(self._goLifeCircle, isActive and true or false)
	gohelper.setActive(self._btnchangeGo, isActive)
	gohelper.setActive(self._btnchange2Go, not isActive)

	if isActive then
		self:_switchFestivalDecoration(false)
	else
		local oldV = self._haveFestival
		local newV = self:haveFestival(true)

		if oldV ~= newV then
			self:_refreshFestivalDecoration()
		end

		UIBlockHelper.instance:endBlock(kBlockKeySwitchLifeCircleAnsSignIn)
	end
end

function SignInView:_checkLifeCircleRed(redDotIcon)
	redDotIcon.show = LifeCircleController.instance:isShowRed()

	redDotIcon:showRedDot(RedDotEnum.Style.Normal)
end

function SignInView:_onSwitchRewardAnim()
	self:_setActive_LifeCircle(true)
end

function SignInView:_playAnim(animName, cb, cbObj)
	self._viewAnimPlayer:Play(animName, cb or function()
		return
	end, cbObj)
end

function SignInView:_refreshSupplement()
	local showBtn = SignInModel.instance:getCanSupplementMonthCardDays() > 0

	gohelper.setActive(self._gosupplement, showBtn)

	if not self._supplementItem then
		self._supplementItem = IconMgr.instance:getCommonItemIcon(self._gosupplementicon)

		self._supplementItem:setMOValue(MaterialEnum.MaterialType.SpecialExpiredItem, StoreEnum.SupplementMonthCardItemId, 1)
		self._supplementItem:setCanShowDeadLine(false)
	end
end

return SignInView
