-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin1View.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin1View", package.seeall)

local ExteriorOtherSkin1View = class("ExteriorOtherSkin1View", ExteriorSkin1View)

function ExteriorOtherSkin1View:ctor()
	ExteriorOtherSkin1View.super.ctor(self)
end

function ExteriorOtherSkin1View:unbindEvents()
	ExteriorOtherSkin1View.super.unbindEvents(self)
end

function ExteriorOtherSkin1View:bindEvents()
	ExteriorOtherSkin1View.super.bindEvents(self)
	self:addClickEvent(self._btnInfo, function()
		self:_OnClickAnyFunc(ViewName.OtherCardInfoStackView)
	end)
	self:addClickEvent(self.btnAdd, function()
		self:onAddFriend()
	end)
	self:addClickEvent(self.btnReport, function()
		self:onReport()
	end)
	self:addClickEvent(self._btnExterior, function()
		self:_OnClickAnyFunc(ViewName.OtherExteriorView)
	end)
	self:addClickEvent(self._btnSticker, function()
		self:_OnClickAnyFunc(ViewName.ImpressionStickersView)
	end)
	self:addClickEvent(self.btnFlower, function()
		self:onFlower()
	end)
end

function ExteriorOtherSkin1View:buildUI()
	ExteriorOtherSkin1View.super.buildUI(self)

	self.btnAdd = self:getGo("Nego_Left/btnAdd")
	self.btnReport = self:getGo("Nego_Left/btnReport")
end

function ExteriorOtherSkin1View:onExit()
	ExteriorOtherSkin1View.super.onExit(self)
end

function ExteriorOtherSkin1View:onEnter()
	ExteriorOtherSkin1View.super.onEnter(self)
	self:_OnClickAnyFunc(ViewName.OtherCardInfoStackView)

	self.curMo = RoleModel.instance.curCardInfo
end

function ExteriorOtherSkin1View:initData()
	self.STACK_LIST = {
		[ViewName.OtherCardInfoStackView] = self._btnInfo,
		[ViewName.CardInfoPetSkinShowView] = self._btnSkin,
		[ViewName.OtherExteriorView] = self._btnExterior,
		[ViewName.ImpressionStickersView] = self._btnSticker
	}
end

function ExteriorOtherSkin1View:_initFuncState(name)
	local btn = self.STACK_LIST[name]

	GameUtil.SetActive(goutil.findChild(self._btnInfo, "select"), btn == self._btnInfo)
	GameUtil.SetActive(goutil.findChild(self._btnSkin, "select"), btn == self._btnSkin)
	GameUtil.SetActive(goutil.findChild(self._btnExterior, "select"), btn == self._btnExterior)
	GameUtil.SetActive(goutil.findChild(self._btnSticker, "select"), btn == self._btnSticker)
end

function ExteriorOtherSkin1View:_onClickClose()
	ExteriorController.instance:setCurrOpenViewName(nil)

	if self._isLoadingSpine then
		return
	end

	UIStateManager.instance:popByName(ViewName.OtherCardView)
end

function ExteriorOtherSkin1View:onAddFriend()
	self.curMo = RoleModel.instance:getCardInfoMo(RoleModel.CardBelong.Other)

	if self.curMo then
		FriendController.instance:addFriend(self.curMo.userId)
	end
end

function ExteriorOtherSkin1View:onReport()
	FloatWordMgr.instance:show(lang("已举报成功，官方会尽快核查并进行处理"))
end

function ExteriorOtherSkin1View:onFlower()
	FloatWordMgr.instance:show(ConstString.NotRelease)
end

return ExteriorOtherSkin1View
