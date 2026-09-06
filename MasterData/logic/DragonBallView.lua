-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/DragonBallView.lua

module("logic.extensions.dragonlords.view.DragonBallView", package.seeall)

local DragonBallView = class("DragonBallView", ViewComponent)

function DragonBallView:ctor()
	DragonBallView.super.ctor(self)
end

function DragonBallView:unbindEvents()
	DragonBallView.super.unbindEvents(self)
	self._btnClick:RemoveClickListener()
end

function DragonBallView:bindEvents()
	DragonBallView.super.bindEvents(self)
	self._btnClick:AddClickListener(self._ballOnClick, self)
end

function DragonBallView:onExit()
	DragonBallView.super.onExit(self)
	removetimer(self._stopBallEffect, self)
	UIEffectManager.instance:stopEffect(self._fuseEff)

	self._fuseEff = nil
end

function DragonBallView:buildUI()
	DragonBallView.super.buildUI(self)

	self._ball = self:getGo("btnClick/ball")
	self._effectObj = self:getGo("con")
	self._btnClick = self:getBtn("btnClick")
	self._txtTip = self:getTxt("txtTip")
end

function DragonBallView:onEnter()
	DragonBallView.super.onEnter(self)

	self._handle = self:getFirstParam()
	self._growSpeed = checknumber(DragonLordsConfig.instance:getCommonCfg("ONCLICK_GROW_SPEED"))
	self._waitTime = checknumber(DragonLordsConfig.instance:getCommonCfg("BALLVIEW_WAIT_TIME"))
	self._onClickTimes = checknumber(DragonLordsConfig.instance:getCommonCfg("ONCLICK_MAX_NUM"))
	self._curOnClickTimes = 0
	self._txtTip.text = DragonLordsConfig.instance:getCommonCfg("ONCLICK_BALL_TPIS_TEXT")

	settimer(self._waitTime, self._stopBallEffect, self, false)
	self:_ballEffect()
end

function DragonBallView:_ballOnClick()
	local curScale = GameUtil.getLocalScale(self._ball)
	local curX = self._growSpeed * curScale.x
	local curY = self._growSpeed * curScale.y
	local curZ = self._growSpeed * curScale.z

	GameUtil.setLocalScale(self._ball, curX, curY, curZ)

	self._curOnClickTimes = self._curOnClickTimes + 1

	if self._curOnClickTimes >= self._onClickTimes then
		self:_stopBallEffect()
	end
end

function DragonBallView:_waitCloseView()
	self:close()

	if self._handle then
		GameUtil.callBack(self._handle)
	end

	GameUtil.setLocalScale(self._ball, 1, 1, 1)
end

function DragonBallView:_ballEffect()
	self._ballEff = UIEffectManager.instance:playEffect(self, "20220930/longzuntiaozhan/fx_longzuntiaozhan_qiu.prefab", self._ball.transform, 0, 0, true)

	self._ballEff:setParent(self._ball.transform)
	self._ballEff:setScale(1)
	self._ballEff:setLocalPos(0, 0, 0)
end

function DragonBallView:_stopBallEffect()
	if not self._ballEff then
		return
	end

	UIEffectManager.instance:stopEffect(self._ballEff)

	self._ballEff = nil

	local function func()
		self:_waitCloseView()
	end

	self._fuseEff = UIEffectManager.instance:playEffect(self, "20220930/longzuntiaozhan/fx_ui_loongzuntiaozhan_pm.prefab", self._effectObj.transform, 0, 0, false, false, func)

	self._fuseEff:setParent(self._effectObj.transform)
	self._fuseEff:setScale(1)
	self._fuseEff:setLocalPos(0, 0, 0)
end

return DragonBallView
