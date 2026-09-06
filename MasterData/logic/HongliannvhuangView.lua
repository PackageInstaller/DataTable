-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/moyan/HongliannvhuangView.lua

module("logic.extensions.timelimitedchallenge.view.moyan.HongliannvhuangView", package.seeall)

local HongliannvhuangView = class("HongliannvhuangView", ViewComponent)

function HongliannvhuangView:ctor()
	HongliannvhuangView.super.ctor(self)
end

function HongliannvhuangView:unbindEvents()
	HongliannvhuangView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnRule)
	GameUtil.rmClickHandler(self.btnAdd)
	GameUtil.rmClickHandler(self.btnChallenge)
end

function HongliannvhuangView:bindEvents()
	HongliannvhuangView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self.btnAdd, self.onClickAdd, self)
	GameUtil.addClickHandler(self.btnChallenge, self.onClickStart, self)
end

function HongliannvhuangView:buildUI()
	HongliannvhuangView.super.buildUI(self)

	self._challengeId = 20
	self._type = MoyanModel.TYPE_3
	self.btnRule = self:getGo("btnTip")
	self.btnClose = self:getGo("btnClose")
	self.btnChallenge = self:getGo("btnChallenge")
	self.txt = self:getTxt("remain/txt")
	self.btnAdd = self:getGo("remain/btnAdd")
	self.txtDesc = self:getTxt("rule/txtDesc")
	self.txtLeftTime = self:getGo("txtLeftTime")

	GameUtil.SetActive(self.txtLeftTime, false)

	self._con = self:getGo("con")
	self.txtNum = self:getTxt("Slider/txtNum")
	self.Slider = self:getSlider("Slider")
	self.items = {}

	for i = 1, 7 do
		local cell = self:getGo("Slider/phase_" .. i)

		table.insert(self.items, cell)
	end
end

function HongliannvhuangView:onExit()
	HongliannvhuangView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_MOYAN_GETINFORES, self.onRefreshUI, self)
	UIEffectManager.instance:stopEffect(self._pmEff)
	UIEffectManager.instance:stopEffect(self._pmEff2)
end

function HongliannvhuangView:onEnter()
	HongliannvhuangView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_MOYAN_GETINFORES, self.onRefreshUI, self)
	MoyanModel.instance:getSingleChanllengeInfo(self._challengeId, self._type)
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

	local effPath = "fx_ui_moyantiaozhan/fx_ui_zhumianban_common.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setScale(1)

	local effPath = "fx_ui_moyantiaozhan/fx_ui_zhumianban_anniu.prefab"

	self._pmEff2 = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 488.4, -279, true, nil, nil, nil, self)

	self._pmEff2:setParent(self.mainGO.transform)
	self._pmEff2:setScale(1)
end

function HongliannvhuangView:onRefreshUI()
	local baseCfg = MoyanConfig.instance:getBaseConfig(self._challengeId) or {}
	local cfg = MoyanConfig.instance:getPlanCfg(baseCfg.challengePlan, self._type)
	local damageScorePlan = cfg.damageScorePlan
	local freeDailyTimes = cfg.freeDailyTimes
	local mo = MoyanModel.instance:getSingleInfo(self._challengeId, self._type)

	if not mo.bossDamageTypeInfo then
		local bossDamageTypeInfo = {}
		local tdChallengeTimes = checknumber(bossDamageTypeInfo.tdChallengeTimes)
		local tdChallengeBuyTimes = checknumber(bossDamageTypeInfo.tdChallengeBuyTimes)
		local bossMaxHp = checknumber(bossDamageTypeInfo.bossMaxHp)
		local bossCurHp = checknumber(bossDamageTypeInfo.bossCurHp)
		local bossDamage = bossMaxHp - bossCurHp
		local left = tdChallengeBuyTimes + freeDailyTimes - tdChallengeTimes

		self.txt.text = langPara("hongliannvhuangview__1", left, freeDailyTimes)
		self.txtDesc.text = cfg.desc
		self.txtNum.text = langPara("造成伤害：%s", bossDamage)

		local valueStepArr = {
			0
		}
		local scoreList = MoyanConfig.instance:getScoreCfgList(damageScorePlan)

		for i, cell in ipairs(self.items) do
			local item = goutil.findChild(cell, "item")
			local received = goutil.findChild(cell, "received")
			local txt = goutil.findChildTextComponent(cell, "txt")
			local txtNum = goutil.findChildTextComponent(cell, "txtNum")
			local sCfg = scoreList[i]

			if sCfg then
				GameUtil.SetActive(cell, true)

				local num = bossMaxHp * (sCfg.needDamageWanPercent / 10000)

				txtNum.text = langPara("hongliannvhuangview__2", math.ceil(num / 10000))
				txt.text = "x" .. sCfg.score

				GameUtil.SetActive(received, num <= bossDamage)
				table.insert(valueStepArr, num)
			else
				GameUtil.SetActive(cell, false)
			end
		end

		GameUtil.setProgress(self.Slider, bossDamage, valueStepArr, {
			0,
			0.143,
			0.286,
			0.429,
			0.571,
			0.714,
			0.857,
			1
		})
	end
end

function HongliannvhuangView:_onClickRule()
	local baseCfg = MoyanConfig.instance:getBaseConfig(self._challengeId) or {}
	local cfg = MoyanConfig.instance:getPlanCfg(baseCfg.challengePlan, self._type)

	UIStateManager.instance:open(ViewName.RulesView, cfg.ruleKey)
end

function HongliannvhuangView:onClickAdd()
	if self:checkHasTime() then
		TipsFacade.instance:openCommonTips(lang("hongliannvhuangview__3"))
	else
		self:sendAddTimes()
	end
end

function HongliannvhuangView:onClickStart()
	if self:checkHasTime() then
		local mo = MoyanModel.instance:getSingleInfo(self._challengeId, self._type)

		if not mo.bossDamageTypeInfo then
			local bossDamageTypeInfo = {}
			local bossMaxHp = checknumber(bossDamageTypeInfo.bossMaxHp)
			local bossCurHp = checknumber(bossDamageTypeInfo.bossCurHp)

			if bossCurHp > 0 then
				local params = {}

				params.challengeId = self._challengeId
				params.type = self._type
				params.stageId = 1

				UIStateManager.instance:push(ViewName.MoyanMissionView, params)
			else
				TipsFacade.instance:openCommonTips(lang("hongliannvhuangview__4"))
			end
		end
	else
		self:sendAddTimes()
	end
end

function HongliannvhuangView:checkHasTime()
	local mo = MoyanModel.instance:getSingleInfo(self._challengeId, self._type)

	if not mo.bossDamageTypeInfo then
		local bossDamageTypeInfo = {}
		local tdChallengeTimes = checknumber(bossDamageTypeInfo.tdChallengeTimes)
		local tdChallengeBuyTimes = checknumber(bossDamageTypeInfo.tdChallengeBuyTimes)
		local baseCfg = MoyanConfig.instance:getBaseConfig(self._challengeId) or {}
		local cfg = MoyanConfig.instance:getPlanCfg(baseCfg.challengePlan, self._type)
		local freeDailyTimes = cfg.freeDailyTimes
		local left = tdChallengeBuyTimes + freeDailyTimes - tdChallengeTimes

		return left > 0
	end
end

function HongliannvhuangView:sendAddTimes()
	local baseCfg = MoyanConfig.instance:getBaseConfig(self._challengeId) or {}
	local cfg = MoyanConfig.instance:getPlanCfg(baseCfg.challengePlan, self._type)
	local buyTimesPlanId = cfg.buyTimesPlanId
	local buyList = MoyanConfig.instance:getBuyCfgList(buyTimesPlanId)
	local limit = #buyList
	local mo = MoyanModel.instance:getSingleInfo(self._challengeId, self._type)

	if not mo.bossDamageTypeInfo then
		local bossDamageTypeInfo = {}
		local tdChallengeBuyTimes = checknumber(bossDamageTypeInfo.tdChallengeBuyTimes)

		if tdChallengeBuyTimes < limit then
			local left = limit - tdChallengeBuyTimes
			local idx = tdChallengeBuyTimes + 1
			local consume

			if buyList[idx] then
				local matType, cfgId, num = MaterialMgr.getMatParams(buyList[idx].consume)
				local iconContent = MaterialMgr.getContentMatCfg(matType, cfgId, 30, -5, MaterialMgr.ICON_TYPE_ICON)
				local content = langPara("hongliannvhuangview__5", num, iconContent, limit, left)

				TipsFacade.instance:openPopupCostMatViewNew(matType, cfgId, num, content, function()
					MoyanController.instance:sendBuyTimes(self._challengeId, self._type)
				end)
			end
		else
			TipsFacade.instance:openCommonTips(lang("hongliannvhuangview__6"))
		end
	end
end

return HongliannvhuangView
