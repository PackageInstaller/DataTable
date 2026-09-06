-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/timedpointracemode/TimedPointRaceModeBuffEnterView.lua

module("logic.extensions.timelimitedchallenge.view.timedpointracemode.TimedPointRaceModeBuffEnterView", package.seeall)

local TimedPointRaceModeBuffEnterView = class("TimedPointRaceModeBuffEnterView", ViewComponent)

function TimedPointRaceModeBuffEnterView:buildUI()
	TimedPointRaceModeBuffEnterView.super.buildUI(self)

	self._btnClose = self:getBtn("Nego_Main/BtnClose")
	self._btnSure = self:getBtn("Nego_Main/BtnSure")
	self._btnCancel = self:getBtn("Nego_Main/BtnCancel")
	self._txtTitle = self:getTxt("Nego_Main/txtTitle")
	self._txtDesc = self:getTxt("Nego_Main/txtDesc")
	self._txtEffect1 = self:getTxt("Nego_Main/txtEffect1")
	self._txtEffect2 = self:getTxt("Nego_Main/txtEffect2")
	self._petName = ""
end

function TimedPointRaceModeBuffEnterView:bindEvents()
	TimedPointRaceModeBuffEnterView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnCancel:AddClickListener(self.close, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function TimedPointRaceModeBuffEnterView:unbindEvents()
	TimedPointRaceModeBuffEnterView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function TimedPointRaceModeBuffEnterView:onEnter()
	TimedPointRaceModeBuffEnterView.super.onEnter(self)

	local params = self:getOpenParam()

	self._challengeId = checkint(params[1])
	self._buffChallengeCfg = params[2]
	self._buffCfg = TimedPointRaceModeConfig.instance:getBuffCfgs(self._buffChallengeCfg.buffId)
	self._curInfo = TimedPointRaceModeModel.instance:getInfo(self._challengeId)

	if not self._buffChallengeCfg or not self._curInfo then
		printError("限时挑战buff挑战传参出错")

		return
	end

	self._commonCfg = TimedPointRaceModeConfig.instance:getCommonCfg(self._challengeId)
	self._txtTitle.text = langPara("%s%s级", self._buffChallengeCfg.buffName, self._buffChallengeCfg.buffLv)

	GlobalDispatcher:addListener(GlobalNotify.TimedPointRaceModeDailyFresh, self._getInfoDaily, self)
	GlobalDispatcher:addListener(GlobalNotify.TimedPointRaceModeError, self._onError, self)

	self._txtDesc.text = self._buffChallengeCfg.challengeDesc
	self._txtEffect1.text = self._buffCfg.buffDes
	self._txtEffect2.text = langPara("挑战%s积分减少<color=#eb4642>%s%%</color>", self._petName, math.abs(self._buffChallengeCfg.scoreEffect / 100))
end

function TimedPointRaceModeBuffEnterView:onExit()
	TimedPointRaceModeBuffEnterView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TimedPointRaceModeDailyFresh, self._getInfoDaily, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimedPointRaceModeError, self._onError, self)
end

function TimedPointRaceModeBuffEnterView:_onClickSure()
	local isAble, isTimeAble, isDateAble = TimedPointRaceModeConfig.instance:isTimeAbleToChallenge(self._challengeId)

	if isAble then
		self:close()

		local creepCfg = TimedPointRaceModeConfig.instance:getCreepCfgById(self._challengeId, self._buffChallengeCfg.creepsMasterId)

		UIStateManager.instance:push(ViewName.TimedPointRaceModeMissionView, creepCfg, self._challengeId, self._buffChallengeCfg)
	else
		if isDateAble then
			TipsFacade.instance:openCommonTips(langPara("%s不可挑战", self._commonCfg.closeRange))
		else
			TipsFacade.instance:openCommonTips("当前挑战允许日期已过")
		end

		self:close()
	end
end

function TimedPointRaceModeBuffEnterView:_getInfoDaily()
	TipsFacade.instance:openCommonTips("今日挑战已重置")
	self:close()
end

function TimedPointRaceModeBuffEnterView:_onError(status)
	self:close()
end

return TimedPointRaceModeBuffEnterView
