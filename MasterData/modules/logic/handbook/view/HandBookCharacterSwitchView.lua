-- chunkname: @modules/logic/handbook/view/HandBookCharacterSwitchView.lua

module("modules.logic.handbook.view.HandBookCharacterSwitchView", package.seeall)

local HandBookCharacterSwitchView = class("HandBookCharacterSwitchView", BaseView)

function HandBookCharacterSwitchView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagecentericon = gohelper.findChildSingleImage(self.viewGO, "#simage_centericon")
	self._simagelefticon = gohelper.findChildSingleImage(self.viewGO, "#simage_lefticon")
	self._simagerighticon = gohelper.findChildSingleImage(self.viewGO, "#simage_righticon")
	self._simagerighticon2 = gohelper.findChildSingleImage(self.viewGO, "#simage_righticon2")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_mask")
	self._gocharacterswitch = gohelper.findChild(self.viewGO, "#go_characterswitch")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#simage_line")
	self._simageswitchbg1 = gohelper.findChildSingleImage(self.viewGO, "#go_characterswitch/#simage_switchbg1")
	self._simageswitchbg2 = gohelper.findChildSingleImage(self.viewGO, "#go_characterswitch/#simage_switchbg2")
	self._simageswitchbg3 = gohelper.findChildSingleImage(self.viewGO, "#go_characterswitch/#simage_switchbg3")
	self._simageswitchbg4 = gohelper.findChildSingleImage(self.viewGO, "#go_characterswitch/#simage_switchbg4")
	self._simageswitchbg5 = gohelper.findChildSingleImage(self.viewGO, "#go_characterswitch/#simage_switchbg5")
	self._simageswitchbg6 = gohelper.findChildSingleImage(self.viewGO, "#go_characterswitch/#simage_switchbg6")
	self._simageswitchbg7 = gohelper.findChildSingleImage(self.viewGO, "#go_characterswitch/#simage_switchbg7")
	self._btncharacter1 = gohelper.findChildClick(self.viewGO, "#go_characterswitch/#simage_switchbg1/clickarea")
	self._btncharacter2 = gohelper.findChildClick(self.viewGO, "#go_characterswitch/#simage_switchbg2/clickarea")
	self._btncharacter3 = gohelper.findChildClick(self.viewGO, "#go_characterswitch/#simage_switchbg3/clickarea")
	self._btncharacter4 = gohelper.findChildClick(self.viewGO, "#go_characterswitch/#simage_switchbg4/clickarea")
	self._btncharacter5 = gohelper.findChildClick(self.viewGO, "#go_characterswitch/#simage_switchbg5/clickarea")
	self._btncharacter6 = gohelper.findChildClick(self.viewGO, "#go_characterswitch/#simage_switchbg6/clickarea")
	self._btncharacter7 = gohelper.findChildClick(self.viewGO, "#go_characterswitch/#simage_switchbg7/clickarea")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._btncollection = gohelper.findChildButtonWithAudio(self.viewGO, "#go_characterswitch/#btn_collection")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandBookCharacterSwitchView:addEvents()
	self._btncharacter1:AddClickListener(self._btncharacter1OnClick, self)
	self._btncharacter2:AddClickListener(self._btncharacter2OnClick, self)
	self._btncharacter3:AddClickListener(self._btncharacter3OnClick, self)
	self._btncharacter4:AddClickListener(self._btncharacter4OnClick, self)
	self._btncharacter5:AddClickListener(self._btncharacter5OnClick, self)
	self._btncharacter6:AddClickListener(self._btncharacter6OnClick, self)
	self._btncollection:AddClickListener(self._btncollectionOnClick, self)
	self._btncharacter7:AddClickListener(self._btncharacter7OnClick, self)
end

function HandBookCharacterSwitchView:removeEvents()
	self._btncharacter1:RemoveClickListener()
	self._btncharacter2:RemoveClickListener()
	self._btncharacter3:RemoveClickListener()
	self._btncharacter4:RemoveClickListener()
	self._btncharacter5:RemoveClickListener()
	self._btncharacter6:RemoveClickListener()
	self._btncollection:RemoveClickListener()
	self._btncharacter7:RemoveClickListener()
end

function HandBookCharacterSwitchView:_btncollectionOnClick()
	self:_openSubCharacterView(HandbookEnum.HeroType.AllHero)
end

function HandBookCharacterSwitchView:_btncharacter1OnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	self:_openSubCharacterView(3)
end

function HandBookCharacterSwitchView:_btncharacter2OnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	self:_openSubCharacterView(2)
end

function HandBookCharacterSwitchView:_btncharacter3OnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	self:_openSubCharacterView(1)
end

function HandBookCharacterSwitchView:_btncharacter4OnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	self:_openSubCharacterView(5)
end

function HandBookCharacterSwitchView:_btncharacter5OnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	self:_openSubCharacterView(4)
end

function HandBookCharacterSwitchView:_btncharacter6OnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	self:_openSubCharacterView(6)
end

function HandBookCharacterSwitchView:_btncharacter7OnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	self:_openSubCharacterView(7)
end

function HandBookCharacterSwitchView:_openSubCharacterView(heroType)
	HandbookController.instance:dispatchEvent(HandbookController.EventName.OnShowSubCharacterView, heroType)
end

function HandBookCharacterSwitchView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	self._simagecentericon:LoadImage(ResUrl.getCharacterDataIcon("bg_2_ciecle.png"))
	self._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	self._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	self._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	self._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	self._simageline:LoadImage(ResUrl.getHandbookCharacterIcon("line"))
	self._simageswitchbg1:LoadImage(SLFramework.LanguageMgr.Instance:GetLangPathFromAssetPath(ResUrl.getHandbookCharacterImage("zz3")))
	self._simageswitchbg2:LoadImage(SLFramework.LanguageMgr.Instance:GetLangPathFromAssetPath(ResUrl.getHandbookCharacterImage("zz1")))
	self._simageswitchbg3:LoadImage(SLFramework.LanguageMgr.Instance:GetLangPathFromAssetPath(ResUrl.getHandbookCharacterImage("zz2")))
	self._simageswitchbg4:LoadImage(SLFramework.LanguageMgr.Instance:GetLangPathFromAssetPath(ResUrl.getHandbookCharacterImage("zz4")))
	self._simageswitchbg5:LoadImage(SLFramework.LanguageMgr.Instance:GetLangPathFromAssetPath(ResUrl.getHandbookCharacterImage("zz5")))
	self._simageswitchbg6:LoadImage(SLFramework.LanguageMgr.Instance:GetLangPathFromAssetPath(ResUrl.getHandbookCharacterImage("zz6")))
	self._simageswitchbg7:LoadImage(SLFramework.LanguageMgr.Instance:GetLangPathFromAssetPath(ResUrl.getHandbookCharacterImage("zz7")))
end

function HandBookCharacterSwitchView:_playViewOpenAnim()
	self._anim:Play(UIAnimationName.Open, 0, 0)
end

function HandBookCharacterSwitchView:onUpdateParam()
	return
end

function HandBookCharacterSwitchView:onOpen()
	self.addEventCb(self, HandbookController.instance, HandbookController.EventName.PlayCharacterSwitchOpenAnim, self._playViewOpenAnim, self)
end

function HandBookCharacterSwitchView:onClose()
	return
end

function HandBookCharacterSwitchView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagecentericon:UnLoadImage()
	self._simagelefticon:UnLoadImage()
	self._simagerighticon:UnLoadImage()
	self._simagerighticon2:UnLoadImage()
	self._simagemask:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simageswitchbg1:UnLoadImage()
	self._simageswitchbg2:UnLoadImage()
	self._simageswitchbg3:UnLoadImage()
	self._simageswitchbg4:UnLoadImage()
	self._simageswitchbg5:UnLoadImage()
	self._simageswitchbg6:UnLoadImage()
	self._simageswitchbg7:UnLoadImage()
	self.removeEventCb(self, HandbookController.instance, HandbookController.EventName.PlayCharacterSwitchOpenAnim, self._playViewOpenAnim, self)
end

return HandBookCharacterSwitchView
