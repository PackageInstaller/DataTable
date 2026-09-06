-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/dreamteam/DreamTeamHudGiftView.lua

module("logic.extensions.operationsummary.view.dreamteam.DreamTeamHudGiftView", package.seeall)

local DreamTeamHudGiftView = class("DreamTeamHudGiftView", ViewComponent)

function DreamTeamHudGiftView:buildUI()
	DreamTeamHudGiftView.super.buildUI(self)

	self._btnBuySingle = self:getBtn("btnBuySingle")
	self._btnBuyPack = self:getBtn("btnBuyPack")
	self._markSingle = self:getGo("btnBuySingle/mark")
	self._markPack = self:getGo("btnBuyPack/mark")
	self._goodIdSingle = 511
	self._goodIdPack = 521
end

function DreamTeamHudGiftView:onEnter()
	DreamTeamHudGiftView.super.onEnter(self)
	DreamTeamHudController.instance:setRDInfo(RedPointModel.ID_DREAMTEAMHUD_FOURTH, DreamTeamHudController.UserDataSaveType.First)
end

function DreamTeamHudGiftView:onExit()
	DreamTeamHudGiftView.super.onExit(self)
end

function DreamTeamHudGiftView:bindEvents()
	DreamTeamHudGiftView.super.bindEvents(self)
	self._btnBuySingle:AddClickListener(self._onClickBuySingle, self)
	self._btnBuyPack:AddClickListener(self._onClickBuyPack, self)
end

function DreamTeamHudGiftView:unbindEvents()
	DreamTeamHudGiftView.super.unbindEvents(self)
	self._btnBuySingle:RemoveClickListener()
	self._btnBuyPack:RemoveClickListener()
end

function DreamTeamHudGiftView:_refreshview()
	local isPay = PayShopModel.instance:getMibaoTotalBuyTimesById(self._goodIdSingle) ~= 0

	goutil.setActive(self._markSingle, isPay)

	isPay = PayShopModel.instance:getMibaoTotalBuyTimesById(self._goodIdPack) ~= 0

	goutil.setActive(self._markPack, isPay)
end

function DreamTeamHudGiftView:_onClickBuySingle()
	GotoMgr.gotoByString("func#191#108")
end

function DreamTeamHudGiftView:_onClickBuyPack()
	return
end

return DreamTeamHudGiftView
