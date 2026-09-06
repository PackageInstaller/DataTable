-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/view/FirepowerContestMainCopyView.lua

module("logic.extensions.firepowercontest.view.FirepowerContestMainCopyView", package.seeall)

local FirepowerContestMainCopyView = class("FirepowerContestMainCopyView", ViewComponent)

function FirepowerContestMainCopyView:ctor()
	FirepowerContestMainCopyView.super.ctor(self)
end

function FirepowerContestMainCopyView:unbindEvents()
	FirepowerContestMainCopyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
end

function FirepowerContestMainCopyView:bindEvents()
	FirepowerContestMainCopyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
end

function FirepowerContestMainCopyView:buildUI()
	FirepowerContestMainCopyView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txtTime")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnStart = self:getBtn("bottomright/btnStart")
	self._btnTip = self:getBtn("leftTop/txtTitle/btnTip")
	self._txtCount = self:getTxt("bottomright/count/txt")
	self._mainEffectGo = self:getGo("effect")
end

function FirepowerContestMainCopyView:onExit()
	FirepowerContestMainCopyView.super.onExit(self)
	FirePowerContestController.instance:unregisterLocalNotify(FirePowerContestController.AfterGetInfoResponse, self._updatePrizes, self)
	self:_removeMainEffect()
end

function FirepowerContestMainCopyView:onEnter()
	FirepowerContestMainCopyView.super.onEnter(self)
	FirePowerContestController.instance:registerLocalNotify(FirePowerContestController.AfterGetInfoResponse, self._updatePrizes, self)
	FirePowerContestController.instance:setIsTourArenaMode(true)

	self._activityId = FirePowerContestConfig.instance:getActId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show(lang("FirePowerContestMainView__2"))
		self:close()

		return
	end

	self._activityConf = FirePowerContestConfig.instance:getGameActivityConf(self._activityId)
	self._txtTitle.text = self._activityConf.gameName

	FirePowerContestAgent.instance:sendPM_GetFirePowerContestInfoReq(self._activityId)
	self:_addMainEffect()
	self:_updatePrizes()
end

function FirepowerContestMainCopyView:_removeMainEffect()
	if self._mainEffect then
		UIEffectManager.instance:stopEffect(self._mainEffect)

		self._mainEffect = nil
	end
end

function FirepowerContestMainCopyView:_addMainEffect()
	self:_removeMainEffect()

	local eff = UIEffectManager.instance:playEffect(self, FirePowerContestConfig.instance:getEffectUrl("fx_ui_hyll_fenwen"), self._mainEffectGo.transform, 0, 0, true)

	eff:setParent(self._mainEffectGo.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._mainEffect = eff
end

function FirepowerContestMainCopyView:_updatePrizes()
	local remianGameCount = FirePowerContestModel.instance:getRemainGameCount(self._activityConf.times)

	self._txtCount.text = langPara("FirePowerContestMainView__3", remianGameCount, self._activityConf.times)
end

function FirepowerContestMainCopyView:_onClickStart()
	if self._activityConf then
		local model = FirePowerContestModel.instance
		local remianGameCount = model:getRemainGameCount(self._activityConf.times)

		if remianGameCount > 0 then
			if model:isInMatchCD() then
				FloatWordMgr.instance:show(langPara("FirePowerContestMainView__4", model:getMatchCDSec()))
			else
				FirePowerContestController.instance:reqStartGame()
			end
		else
			FloatWordMgr.instance:show(lang("FirePowerContestMainView__1"))
		end
	end
end

function FirepowerContestMainCopyView:_onClickTip()
	if self._activityConf then
		UIStateManager.instance:push(ViewName.RulesView, self._activityConf.rulesKey)
	end
end

return FirepowerContestMainCopyView
