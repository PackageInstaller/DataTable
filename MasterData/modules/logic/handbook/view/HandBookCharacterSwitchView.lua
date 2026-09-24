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
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._btncollection = gohelper.findChildButtonWithAudio(self.viewGO, "#go_characterswitch/#btn_collection")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandBookCharacterSwitchView:addEvents()
	self._btncollection:AddClickListener(self._btncollectionOnClick, self)
end

function HandBookCharacterSwitchView:removeEvents()
	self._btncollection:RemoveClickListener()
end

function HandBookCharacterSwitchView:_btncollectionOnClick()
	self:_openSubCharacterView(HandbookEnum.HeroType.AllHero)
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

	local idxToIdMap = {
		3,
		2,
		1,
		5,
		4
	}
	local idxToIconMap = {
		3,
		1,
		2,
		4,
		5
	}

	self._itemTbList = {}

	local LanguageMgrIns = SLFramework.LanguageMgr.Instance

	for _, cfg in ipairs(lua_handbook_character.configList) do
		local idx = cfg.id

		if not idxToIconMap[idx] then
			local childPath = "#go_characterswitch/#simage_switchbg" .. idx
			local go = gohelper.findChild(self.viewGO, childPath)

			if not gohelper.isNil(go) then
				local tb = self:getUserDataTb_()

				tb.btn = gohelper.findChildClick(self.viewGO, childPath .. "/clickarea")
				tb.heroType = idxToIdMap[idx] or cfg.id
				tb.hbcView = self
				tb.simage = gohelper.findChildSingleImage(self.viewGO, childPath)

				table.insert(self._itemTbList, tb)
				tb.btn:AddClickListener(HandBookCharacterSwitchView._tbOnClick, tb)
				tb.simage:LoadImage(LanguageMgrIns:GetLangPathFromAssetPath(ResUrl.getHandbookCharacterImage("zz" .. idxToIconMap[idx])))
			end
		end
	end
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

function HandBookCharacterSwitchView._tbOnClick(itemTb)
	if itemTb and itemTb.hbcView then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
		itemTb.hbcView:_openSubCharacterView(itemTb.heroType)
	end
end

function HandBookCharacterSwitchView:_disposeItemTbList()
	if self._itemTbList then
		for _, tb in ipairs(self._itemTbList) do
			if tb.btn then
				tb.btn:RemoveClickListener()
			end

			if tb.simage then
				tb.simage:UnLoadImage()
			end

			tb.hbcView = nil
		end

		self._itemTbList = nil
	end
end

function HandBookCharacterSwitchView:onClose()
	self:_disposeItemTbList()
end

function HandBookCharacterSwitchView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagecentericon:UnLoadImage()
	self._simagelefticon:UnLoadImage()
	self._simagerighticon:UnLoadImage()
	self._simagerighticon2:UnLoadImage()
	self._simagemask:UnLoadImage()
	self._simageline:UnLoadImage()
	self:_disposeItemTbList()
	self.removeEventCb(self, HandbookController.instance, HandbookController.EventName.PlayCharacterSwitchOpenAnim, self._playViewOpenAnim, self)
end

return HandBookCharacterSwitchView
