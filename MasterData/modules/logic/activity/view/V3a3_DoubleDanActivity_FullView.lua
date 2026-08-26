-- chunkname: @modules/logic/activity/view/V3a3_DoubleDanActivity_FullView.lua

module("modules.logic.activity.view.V3a3_DoubleDanActivity_FullView", package.seeall)

local V3a3_DoubleDanActivity_FullView = class("V3a3_DoubleDanActivity_FullView", V3a3_DoubleDanActivityViewImpl)

function V3a3_DoubleDanActivity_FullView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageRole = gohelper.findChildSingleImage(self.viewGO, "Left/characterSpine/#go_skincontainer/#simage_Role")
	self._simagel2d = gohelper.findChildSingleImage(self.viewGO, "Left/characterSpine/#go_skincontainer/#simage_l2d")
	self._gospinecontainer = gohelper.findChild(self.viewGO, "Left/characterSpine/#go_skincontainer/#go_spinecontainer")
	self._gospine = gohelper.findChild(self.viewGO, "Left/characterSpine/#go_skincontainer/#go_spinecontainer/#go_spine")
	self._txtcharacterName = gohelper.findChildText(self.viewGO, "Left/#txt_characterName")
	self._txtskinNameEn = gohelper.findChildText(self.viewGO, "Left/#txt_characterName/#txt_skinNameEn")
	self._txtskinName = gohelper.findChildText(self.viewGO, "Left/#txt_skinName")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_switch")
	self._txtswitch = gohelper.findChildText(self.viewGO, "Left/#btn_switch/#txt_switch")
	self._btnGo = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_Go")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/LimitTime/#txt_LimitTime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/#txt_Descr")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "Right/RawardPanel/#btn_Claim")
	self._btnClaimed = gohelper.findChildButtonWithAudio(self.viewGO, "Right/RawardPanel/#btn_Claimed")
	self._btnUnopen = gohelper.findChildButtonWithAudio(self.viewGO, "Right/RawardPanel/#btn_Unopen")
	self._scrollTaskTabList = gohelper.findChildScrollRect(self.viewGO, "Right/Tab/#scroll_TaskTabList")
	self._goradiotaskitem = gohelper.findChild(self.viewGO, "Right/Tab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	self._goreddot = gohelper.findChild(self.viewGO, "Right/Tab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem/#go_reddot")
	self._goClaim = gohelper.findChild(self.viewGO, "Right/RawardPanel/#go_Claim")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a3_DoubleDanActivity_FullView:addEvents()
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
	self._btnGo:AddClickListener(self._btnGoOnClick, self)
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
	self._btnClaimed:AddClickListener(self._btnClaimedOnClick, self)
	self._btnUnopen:AddClickListener(self._btnUnopenOnClick, self)
end

function V3a3_DoubleDanActivity_FullView:removeEvents()
	self._btnswitch:RemoveClickListener()
	self._btnGo:RemoveClickListener()
	self._btnClaim:RemoveClickListener()
	self._btnClaimed:RemoveClickListener()
	self._btnUnopen:RemoveClickListener()
end

function V3a3_DoubleDanActivity_FullView:ctor(...)
	V3a3_DoubleDanActivity_FullView.super.ctor(self, ...)
end

function V3a3_DoubleDanActivity_FullView:_editableInitView()
	V3a3_DoubleDanActivity_FullView.super._editableInitView(self)
end

function V3a3_DoubleDanActivity_FullView:onDestroyView()
	V3a3_DoubleDanActivity_FullView.super.onDestroyView(self)
end

return V3a3_DoubleDanActivity_FullView
