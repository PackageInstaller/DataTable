-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/timedpointracemode/TimedPointRaceModeBossEnterView.lua

module("logic.extensions.timelimitedchallenge.view.timedpointracemode.TimedPointRaceModeBossEnterView", package.seeall)

local TimedPointRaceModeBossEnterView = class("TimedPointRaceModeBossEnterView", ViewComponent)

function TimedPointRaceModeBossEnterView:buildUI()
	TimedPointRaceModeBossEnterView.super.buildUI(self)

	self._btnClose = self:getBtn("Nego_Main/BtnClose")
	self._btnSure = self:getBtn("Nego_Main/BtnSure")
	self._btnCancel = self:getBtn("Nego_Main/BtnCancel")
	self._txtTitle = self:getTxt("Nego_Main/txtTitle")
	self._txtDescs = {}

	for i = 1, 4 do
		self._txtDescs[i] = self:getTxt("Nego_Main/desc/txtDesc" .. i)
	end

	self._txtEffects = {}

	for i = 1, 6 do
		self._txtEffects[i] = self:getTxt("Nego_Main/effect/txtEff" .. i)
	end
end

function TimedPointRaceModeBossEnterView:bindEvents()
	TimedPointRaceModeBossEnterView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnCancel:AddClickListener(self.close, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function TimedPointRaceModeBossEnterView:unbindEvents()
	TimedPointRaceModeBossEnterView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function TimedPointRaceModeBossEnterView:onEnter()
	TimedPointRaceModeBossEnterView.super.onEnter(self)

	local params = self:getOpenParam()

	self._challengeId = checkint(params[1])
	self._commonCfg = TimedPointRaceModeConfig.instance:getCommonCfg(self._challengeId)
	self._curInfo = TimedPointRaceModeModel.instance:getInfo(self._challengeId)

	if not self._commonCfg or not self._curInfo then
		printError("限时挑战buff挑战传参出错")

		return
	end

	self:refreshView()
	GlobalDispatcher:addListener(GlobalNotify.TimedPointRaceModeDailyFresh, self._getInfoDaily, self)
	GlobalDispatcher:addListener(GlobalNotify.TimedPointRaceModeError, self._onError, self)
end

function TimedPointRaceModeBossEnterView:onExit()
	TimedPointRaceModeBossEnterView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TimedPointRaceModeDailyFresh, self._getInfoDaily, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimedPointRaceModeError, self._onError, self)
end

function TimedPointRaceModeBossEnterView:refreshView()
	if not self._commonCfg.bossWithBuffs then
		local bossBuffs = {}

		for i = 1, 4 do
			self._txtDescs[i].text = ""

			local buffId = bossBuffs[i]
			local buffCfg = TimedPointRaceModeConfig.instance:getBuffCfgs(buffId)

			if buffCfg then
				self._txtDescs[i].text = buffCfg.buffDes
			end
		end

		local withBuffs = self._curInfo.withBuffs
		local showBuffs = {}
		local scoreEff = 0

		for k, v in ipairs(withBuffs) do
			local buffChallengeCfg = TimedPointRaceModeConfig.instance:getBuffChallengeCfgs(self._challengeId, k, v)
			local buffId = buffChallengeCfg and buffChallengeCfg.buffId
			local buffCfg = TimedPointRaceModeConfig.instance:getBuffCfgs(buffId)

			if buffCfg then
				scoreEff = scoreEff + buffChallengeCfg.scoreEffect

				table.insert(showBuffs, buffCfg.buffDes)
			end
		end

		self._isWithBuff = false

		if scoreEff ~= 0 then
			local showTip = langPara("获得积分减少<color=#eb4642>%s%%</color>", math.abs(scoreEff / 100))

			table.insert(showBuffs, showTip)

			self._isWithBuff = true
		end

		for i = 1, 6 do
			self._txtEffects[i].text = ""

			if showBuffs[i] then
				self._txtEffects[i].text = showBuffs[i]
			end
		end
	end
end

function TimedPointRaceModeBossEnterView:_onClickSure()
	local isAble, isTimeAble, isDateAble = TimedPointRaceModeConfig.instance:isTimeAbleToChallenge(self._challengeId)

	if isAble then
		if not self._isWithBuff then
			TipsFacade.instance:openPopupWindow(lang("提示"), langPara("秩序龙挑战难度较大，是否坚持无需BUFF挑战本体?"), function()
				self:close()

				local creepCfg = TimedPointRaceModeConfig.instance:getCreepCfgById(self._challengeId, self._commonCfg.bossId)

				UIStateManager.instance:push(ViewName.TimedPointRaceModeMissionView, creepCfg, self._challengeId)
			end, nil, lang("坚持挑战"), lang("返回界面"))
		else
			self:close()

			local creepCfg = TimedPointRaceModeConfig.instance:getCreepCfgById(self._challengeId, self._commonCfg.bossId)

			UIStateManager.instance:push(ViewName.TimedPointRaceModeMissionView, creepCfg, self._challengeId)
		end
	else
		if isDateAble then
			TipsFacade.instance:openCommonTips(langPara("%s不可挑战", self._commonCfg.closeRange))
		else
			TipsFacade.instance:openCommonTips("当前挑战允许日期已过")
		end

		self:close()
	end
end

function TimedPointRaceModeBossEnterView:_getInfoDaily()
	TipsFacade.instance:openCommonTips("今日挑战已重置")
	self:close()
end

function TimedPointRaceModeBossEnterView:_onError(status)
	self:close()
end

return TimedPointRaceModeBossEnterView
