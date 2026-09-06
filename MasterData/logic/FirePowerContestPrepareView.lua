-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/view/FirePowerContestPrepareView.lua

module("logic.extensions.firepowercontest.view.FirePowerContestPrepareView", package.seeall)

local FirePowerContestPrepareView = class("FirePowerContestPrepareView", ViewComponent)

function FirePowerContestPrepareView:ctor()
	FirePowerContestPrepareView.super.ctor(self)
end

function FirePowerContestPrepareView:unbindEvents()
	FirePowerContestPrepareView.super.unbindEvents(self)
end

function FirePowerContestPrepareView:bindEvents()
	FirePowerContestPrepareView.super.bindEvents(self)
end

function FirePowerContestPrepareView:buildUI()
	FirePowerContestPrepareView.super.buildUI(self)

	self._txtCountDownGo = self:getGo("txtCountDown")
	self._txtCountDown = self._txtCountDownGo:GetComponent(goutil.Type_UIText)
	self._ready = self:getGo("ready")
	self._txtReady = self:getTxt("ready/tip/txt")
	self._txtRivalName = self:getTxt("item_1/Txt_Name")
	self._txtMyName = self:getTxt("item_2/Txt_Name")
	self._imgRivalIcon = self:getGo("item_1/Img_Head")
	self._imgMyIcon = self:getGo("item_2/Img_Head")
	self._myPoster = self:getGo("item_2/poster")
	self._rivalPoster = self:getGo("item_1/poster")
	self._mainEffectGo = self:getGo("effect")
	self._readyEffectGo = self:getGo("readyEffect")
end

function FirePowerContestPrepareView:onExit()
	FirePowerContestPrepareView.super.onExit(self)
	self:removeTimer()
	HeadItemController.instance:resetHeadCell(self._imgRivalIcon)
	HeadItemController.instance:resetHeadCell(self._imgMyIcon)
	self:_removeMainEffect()
	self:_removeReadyEffect()
	RoleObjectPool.instance:removeRole(self._myRole)

	self._myRole = nil

	RoleObjectPool.instance:removeRole(self._rivalRole)

	self._rivalRole = nil
end

function FirePowerContestPrepareView:onEnter()
	FirePowerContestPrepareView.super.onEnter(self)
	goutil.setActive(self._ready, false)

	if FirePowerContestConfig.debugClient then
		FirePowerContestModel.instance:reqStartGame()
	end

	local MaxPrepareTimeSec = checknumber(FirePowerContestConfig.instance:getCommonValue("MaxPrepareTime"))
	local MaxReadyTimeSec = checknumber(FirePowerContestConfig.instance:getCommonValue("MaxReadyTime"))
	local activityConf = FirePowerContestConfig.instance:getGameActivityConf()

	self._tickPhase1StartTime = UnityEngine.Time.realtimeSinceStartup + MaxPrepareTimeSec
	self._tickPhase2Second = MaxReadyTimeSec

	local data = FirePowerContestModel.instance.handler.data

	self._txtRivalName.text = data.rivalUserInfo.userName
	self._txtMyName.text = RoleModel.instance:getUserName()

	HeadItemController.instance:setHeadCellByInfo(self._imgRivalIcon, data.rivalUserInfo)
	HeadItemController.instance:setMyHeadCell(self._imgMyIcon)

	local function getModelId(info)
		local iconType = data:getIconType(info.userId)

		return activityConf[string.format("raceId_%d", iconType)]
	end

	self._myRole = RoleObjectPool.instance:addRoleToParent(self._myRole, getModelId(data.myUserInfo), self._myPoster, 1, nil, false)
	self._rivalRole = RoleObjectPool.instance:addRoleToParent(self._rivalRole, getModelId(data.rivalUserInfo), self._rivalPoster, 1, nil, false)

	self:addTimer()
	self:_tick()
	self:_addMainEffect()
end

function FirePowerContestPrepareView:_removeMainEffect()
	if self._mainEffect then
		UIEffectManager.instance:stopEffect(self._mainEffect)

		self._mainEffect = nil
	end
end

function FirePowerContestPrepareView:onEnterFinished()
	FirePowerContestPrepareView.super.onEnterFinished(self)
	UIStateManager.instance:popByName(ViewName.FirePowerContestMainView)
	UIStateManager.instance:popByName(ViewName.FirePowerContestMatchView)
	UIStateManager.instance:popByName(ViewName.FirepowerContestMainCopyView)
end

function FirePowerContestPrepareView:_addMainEffect()
	self:_removeMainEffect()

	local eff = UIEffectManager.instance:playEffect(self, FirePowerContestConfig.instance:getEffectUrl("fx_ui_hyll_guangshu"), self._mainEffectGo.transform, 0, 0, true)

	eff:setParent(self._mainEffectGo.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._mainEffect = eff
end

function FirePowerContestPrepareView:_removeReadyEffect()
	if self._readyEffect then
		UIEffectManager.instance:stopEffect(self._readyEffect)

		self._readyEffect = nil
	end
end

function FirePowerContestPrepareView:_addReadyEffect()
	if not self._readyEffect then
		local eff = UIEffectManager.instance:playEffect(self, FirePowerContestConfig.instance:getEffectUrl("fx_ui_hyll_daojishi"), self._readyEffectGo.transform, 0, 0, true)

		eff:setParent(self._readyEffectGo.transform)
		eff:setScale(1)
		eff:setLocalPos(0, 0, 0)

		self._readyEffect = eff
	end
end

function FirePowerContestPrepareView:removeTimer()
	removetimer(self._tick, self)
end

function FirePowerContestPrepareView:addTimer()
	settimer(0.2, self._tick, self)
end

function FirePowerContestPrepareView:_tick()
	local delta = self._tickPhase1StartTime - UnityEngine.Time.realtimeSinceStartup
	local sec = math.ceil(delta)

	if sec >= 0 then
		self._txtCountDown.text = langPara("FirePowerContestPrepareView__1", sec)
	end

	if sec <= self._tickPhase2Second then
		goutil.setActive(self._ready, true)

		self._txtReady.text = ""

		self:_addReadyEffect()
	end

	if sec <= 0 then
		self:removeTimer()

		if not FirePowerContestConfig.debugClient then
			UIStateManager.instance:push(ViewName.FirePowerContestGameView)
		end
	end
end

return FirePowerContestPrepareView
