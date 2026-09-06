-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingCostView.lua

module("logic.extensions.liyangking.view.LiYangKingCostView", package.seeall)

local LiYangKingCostView = class("LiYangKingCostView", ViewComponent)

function LiYangKingCostView:ctor()
	LiYangKingCostView.super.ctor(self)
end

function LiYangKingCostView:unbindEvents()
	LiYangKingCostView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function LiYangKingCostView:bindEvents()
	LiYangKingCostView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function LiYangKingCostView:buildUI()
	LiYangKingCostView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("main/btnSure")
	self._content = self:getTxt("main/content")
	self._imgMy = self:getGo("main/imgMyDiamond/img")
	self._imgCost = self:getGo("main/imgCostDiamond/img")
	self._txtNumCost = self:getTxt("main/imgCostDiamond/txtNum")
	self._txtNumMy = self:getTxt("main/imgMyDiamond/txtNum")
end

function LiYangKingCostView:onExit()
	LiYangKingCostView.super.onExit(self)
	MaterialMgr.clearIcon(self._imgMy)
	MaterialMgr.clearIcon(self._imgCost)
end

function LiYangKingCostView:onEnter()
	LiYangKingCostView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangUnlockBuildingRes, self._onUnlockBuildingRes, self)

	local params = self:getFirstParam() or {}

	self._activityId = checknumber(params.activityId)
	self._firstBuildCost = checknumber(params.firstBuildCost)
	self._matName = params.matName

	local buildNameArr = string.split(params.buildName, "\n")
	local buildName = buildNameArr[1] .. buildNameArr[2]

	self._hasScoreNum = checknumber(params.hasScoreNum)
	self._buildId = checknumber(params.buildId)

	local actCfg = LiYangKingConfig.instance:getActCfg(self._activityId)

	if self._activityId <= 0 then
		self._activityId = 509001
	end

	self._content.text = string.format("是否花费%d%s解锁%s", self._firstBuildCost, self._matName, buildName)
	self._txtNumCost.text = self._firstBuildCost
	self._txtNumMy.text = self._hasScoreNum

	MaterialMgr.setIcon(self._imgMy, MatType.ACTIVITY_ITEM, actCfg.itemId)
	MaterialMgr.setIcon(self._imgCost, MatType.ACTIVITY_ITEM, actCfg.itemId)
end

function LiYangKingCostView:_onClickBtnSure()
	if self._firstBuildCost > self._hasScoreNum then
		FloatWordMgr.instance:show(string.format("%s不足", self._matName))

		return
	end

	LiYangKingController.instance:sendPM_PrinceLiyangUnlockBuildingReq(self._activityId, self._buildId)
end

function LiYangKingCostView:_onUnlockBuildingRes()
	FloatWordMgr.instance:show("成功解锁建筑！")
	self:close()
end

return LiYangKingCostView
