-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/moyan/MoyanbattleView.lua

module("logic.extensions.timelimitedchallenge.view.moyan.MoyanbattleView", package.seeall)

local MoyanbattleView = class("MoyanbattleView", ViewComponent)

function MoyanbattleView:ctor()
	MoyanbattleView.super.ctor(self)
end

function MoyanbattleView:unbindEvents()
	MoyanbattleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnRule)
end

function MoyanbattleView:bindEvents()
	MoyanbattleView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnRule, self._onClickRule, self)
end

function MoyanbattleView:buildUI()
	MoyanbattleView.super.buildUI(self)

	self._challengeId = 20
	self.btnClose = self:getGo("topleft/btnClose")
	self.btnRule = self:getGo("topleft/btnRule")
	self._txtLeftTime = self:getTxt("txtLeftTime")
	self._con = self:getGo("con")
	self.items = {}

	for i = 1, 3 do
		local go = self:getGo("challenges/challenge_" .. i)

		table.insert(self.items, go)

		local btnStart = goutil.findChild(go, "btnStart")
		local btnSweep = goutil.findChild(go, "btnSweep")

		GameUtil.addClickHandler(btnStart, GameUtil.handler(self.onClickStart, self, i))
		GameUtil.addClickHandler(btnSweep, GameUtil.handler(self.onClickSweep, self, i))
	end
end

function MoyanbattleView:onExit()
	MoyanbattleView.super.onExit(self)
	removetimer(self._onTick, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_MOYAN_GETINFORES, self.onRefreshUI, self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	UIEffectManager.instance:stopEffect(self._pmEff)
	UIEffectManager.instance:stopEffect(self._pmEff2)
	UIEffectManager.instance:stopEffect(self._pmEff3)
	UIEffectManager.instance:stopEffect(self._pmEff4)
end

function MoyanbattleView:onEnter()
	MoyanbattleView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_MOYAN_GETINFORES, self.onRefreshUI, self)
	MoyanController.instance:getGetBattleEnterInfo(self._challengeId)
	self:onRefreshUI()

	self._challengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	local skinId = self._challengeCfg.raceId
	local displayBagOffset = CharactorFacade.instance:getPetBagModelUIPosAndScale(skinId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, x, y)

	self:_onTick()
	settimer(1, self._onTick, self)

	local effPath = "fx_ui_moyantiaozhan/fx_ui_zhumianban_common.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setScale(1)

	local effPath = "fx_ui_moyantiaozhan/fx_ui_anniu01.prefab"

	self._pmEff2 = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, -388, -31, true, nil, nil, nil, self)

	self._pmEff2:setParent(self.mainGO.transform)
	self._pmEff2:setScale(1)

	local effPath = "fx_ui_moyantiaozhan/fx_ui_anniu01.prefab"

	self._pmEff3 = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, -1, -101, true, nil, nil, nil, self)

	self._pmEff3:setParent(self.mainGO.transform)
	self._pmEff3:setScale(1)

	local effPath = "fx_ui_moyantiaozhan/fx_ui_anniu01.prefab"

	self._pmEff4 = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 390, -33, true, nil, nil, nil, self)

	self._pmEff4:setParent(self.mainGO.transform)
	self._pmEff4:setScale(1)
end

function MoyanbattleView:_onTick()
	if self._challengeId == nil or not TLChallengeController.instance:isInOpenTime(self._challengeId) then
		if self._txtLeftTime then
			self._txtLeftTime.text = ""
		end

		local text = lang("moyanbattleview__1")

		TipsFacade.instance:openTipWindowNoX(lang("tip"), text, function()
			self:close()
		end)
		removetimer(self._onTick, self)
	else
		local leftTimeFormat = TLChallengeController.instance:getLeftTimeFormat(self._challengeId)

		if self._txtLeftTime then
			self._txtLeftTime.text = langPara("moyanbattleview__2", leftTimeFormat)
		end
	end
end

function MoyanbattleView:_onClickRule()
	local baseCfg = MoyanConfig.instance:getBaseConfig(self._challengeId) or {}

	UIStateManager.instance:open(ViewName.RulesView, baseCfg.ruleKey)
end

function MoyanbattleView:onClickStart(idx)
	if self.battleInfoMap then
		if not self.battleInfoMap[idx] then
			local cfg = MoyanConfig.instance:getPlanCfg(self.planId, idx)
			local max = checknumber(cfg.dailyMaxScore)

			if max <= checknumber(self.battleInfoMap[idx].tdGainedScore) then
				TipsFacade.instance:openCommonTips(lang("moyanbattleview__3"))
			else
				UIStateManager.instance:push(cfg.viewName)
			end
		end
	end
end

function MoyanbattleView:onClickSweep(idx)
	if self.battleInfoMap then
		MoyanController.instance:sendSweep(self._challengeId, idx)
	end
end

function MoyanbattleView:onRefreshUI(cid)
	self.battleInfoMap = {}

	local obj = MoyanModel.instance:getBattleInfo(self._challengeId)

	if obj.baseInfos then
		for i, v in ipairs(obj.baseInfos) do
			local challengeType = v.challengeType

			self.battleInfoMap[challengeType] = v
		end
	end

	local baseCfg = MoyanConfig.instance:getBaseConfig(self._challengeId) or {}

	self.planId = baseCfg.challengePlan

	for i, go in ipairs(self.items) do
		local cfg = MoyanConfig.instance:getPlanCfg(self.planId, i)
		local max = checknumber(cfg.dailyMaxScore)
		local data = self.battleInfoMap[i]

		if data ~= nil then
			GameUtil.SetActive(go, true)

			local btnStart = goutil.findChild(go, "btnStart")
			local btnSweep = goutil.findChild(go, "btnSweep")
			local get = goutil.findChild(go, "get")
			local txtGet = goutil.findChildTextComponent(go, "get/txtGet")
			local pass = goutil.findChild(go, "pass")

			GameUtil.SetActive(btnSweep, data.everPassAllStage)
			GameUtil.SetActive(pass, max <= checknumber(data.tdGainedScore))

			txtGet.text = langPara("moyanbattleview__4", checknumber(data.tdGainedScore), max)
		else
			GameUtil.SetActive(go, false)
		end
	end
end

return MoyanbattleView
