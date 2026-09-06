-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challengecommunity/view/ChallengeCommunityView.lua

module("logic.extensions.challengecommunity.view.ChallengeCommunityView", package.seeall)

local ChallengeCommunityView = class("ChallengeCommunityView", ViewComponent)

function ChallengeCommunityView:buildUI()
	ChallengeCommunityView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnKingRoad = self:getBtn("btnKingRoad")
	self._btnLegend = self:getBtn("btnLegend")
	self._btnJiuGong = self:getBtn("btnJiuGong")
	self._imgRed = self:getGo("btnLegend/imgRed")
	self.kingwayRed = self:getGo("btnKingRoad/kingwayRed")
	self.jiuGongRed = self:getGo("btnJiuGong/red")
	self._legendLock = self:getGo("btnLegend/locked")
	self._kingwayLock = self:getGo("btnKingRoad/locked")
	self._jiuGongLock = self:getGo("btnJiuGong/locked")
end

function ChallengeCommunityView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnKingRoad:AddClickListener(self._onClickKingRoad, self)
	self._btnLegend:AddClickListener(self._onClickLegend, self)
	self._btnJiuGong:AddClickListener(self._onClickJiuGong, self)
end

function ChallengeCommunityView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnKingRoad:RemoveClickListener()
	self._btnLegend:RemoveClickListener()
	self._btnJiuGong:RemoveClickListener()
end

function ChallengeCommunityView:onEnter()
	GlobalDispatcher:addListener(NinePlaceModel.GetNinePlaceProcessInfoRes, self._checkJiuGongRedDot, self)
	NinePlaceController.instance:sendPM_GetNinePlaceProcessInfoReq()
	self:_checkJiuGongRedDot()

	local isLegendOpen = FuncOpenModel.instance:getFuncIsOpen(61)
	local isKingwayOpen = FuncOpenModel.instance:getFuncIsOpen(67)
	local isJiuGongOpen = FuncOpenModel.instance:getFuncIsOpen(97)

	goutil.setActive(self._imgRed, isLegendOpen and LegendController.instance:isActiveRedPoint())
	goutil.setActive(self.kingwayRed, KingWayModel.instance:GetKingViewRedPoint())
	goutil.setActive(self._legendLock, not isLegendOpen)
	goutil.setActive(self._kingwayLock, not isKingwayOpen)
	goutil.setActive(self._jiuGongLock, not isJiuGongOpen)
	self:_loadEffect()
end

function ChallengeCommunityView:onExit()
	GlobalDispatcher:removeListener(NinePlaceModel.GetNinePlaceProcessInfoRes, self._checkJiuGongRedDot, self)
	self:_removeEffect()
end

function ChallengeCommunityView:_onClickClose()
	self:close()
end

function ChallengeCommunityView:_onClickKingRoad()
	FuncOpenController.instance:openFuncByViewName(ViewName.KingWay)
end

function ChallengeCommunityView:_onClickLegend()
	FuncOpenController.instance:openFuncByViewName(ViewName.LegendmapView)
end

function ChallengeCommunityView:_onClickJiuGong()
	FuncOpenController.instance:openFuncByViewName(ViewName.NinePlaceMainView)
end

function ChallengeCommunityView:_checkJiuGongRedDot()
	local isJiuGongOpen = FuncOpenModel.instance:getFuncIsOpen(97)

	goutil.setActive(self.jiuGongRed, false)
end

function ChallengeCommunityView:_loadEffect()
	local path = "fx_ui_chuanshuotiaozhan/fx_ui_chuanshuotiaozhan_smoke.prefab"
	local effect = UIEffectManager.instance:playEffect(self, path, self.mainGO.transform, 0, 0, true, false)

	effect:setParent(self.mainGO.transform)
	effect:setScale(1)
	effect:setLocalPos(0, 0, 0)

	self._effect = effect
end

function ChallengeCommunityView:_removeEffect()
	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end
end

return ChallengeCommunityView
