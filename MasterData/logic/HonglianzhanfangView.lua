-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/moyan/HonglianzhanfangView.lua

module("logic.extensions.timelimitedchallenge.view.moyan.HonglianzhanfangView", package.seeall)

local HonglianzhanfangView = class("HonglianzhanfangView", ViewComponent)

function HonglianzhanfangView:ctor()
	HonglianzhanfangView.super.ctor(self)
end

function HonglianzhanfangView:unbindEvents()
	HonglianzhanfangView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnSure)
end

function HonglianzhanfangView:bindEvents()
	HonglianzhanfangView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnSure, self.onClickReset, self)
end

function HonglianzhanfangView:buildUI()
	HonglianzhanfangView.super.buildUI(self)

	self._challengeId = 20
	self._type = MoyanModel.TYPE_2
	self.btnClose = self:getGo("btnClose")
	self.btnSure = self:getGo("btnSure")
	self.txtDesc = self:getTxt("rule/txtDesc")
	self.txtDescBuff = self:getTxt("tip/txtDesc")
	self.items = {}

	for i = 1, 5 do
		local cell = self:getGo("btn_" .. i)

		table.insert(self.items, cell)
	end
end

function HonglianzhanfangView:onExit()
	HonglianzhanfangView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_MOYAN_GETINFORES, self.onRefreshUI, self)
	UIEffectManager.instance:stopEffect(self._pmEff)
	UIEffectManager.instance:stopEffect(self._pmEff2)
	UIEffectManager.instance:stopEffect(self._pmEff3)
	UIEffectManager.instance:stopEffect(self._pmEff4)
	UIEffectManager.instance:stopEffect(self._pmEff5)
	UIEffectManager.instance:stopEffect(self._pmEff6)
end

function HonglianzhanfangView:onEnter()
	HonglianzhanfangView.super.onEnter(self)
	self:initView()
	GlobalDispatcher:addListener(GlobalNotify.PM_MOYAN_GETINFORES, self.onRefreshUI, self)
	MoyanModel.instance:getSingleChanllengeInfo(self._challengeId, self._type)
	self:onRefreshUI()

	local effPath = "fx_ui_moyantiaozhan/fx_ui_zhumianban_common.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setScale(1)

	local effPath = "fx_ui_moyantiaozhan/fx_ui_anniu01.prefab"

	self._pmEff2 = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 188, 213, true, nil, nil, nil, self)

	self._pmEff2:setParent(self.mainGO.transform)
	self._pmEff2:setScale(1)

	local effPath = "fx_ui_moyantiaozhan/fx_ui_anniu01.prefab"

	self._pmEff3 = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 342, -6, true, nil, nil, nil, self)

	self._pmEff3:setParent(self.mainGO.transform)
	self._pmEff3:setScale(1)

	local effPath = "fx_ui_moyantiaozhan/fx_ui_anniu01.prefab"

	self._pmEff4 = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, -138, true, nil, nil, nil, self)

	self._pmEff4:setParent(self.mainGO.transform)
	self._pmEff4:setScale(1)

	local effPath = "fx_ui_moyantiaozhan/fx_ui_anniu01.prefab"

	self._pmEff5 = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, -359, -9, true, nil, nil, nil, self)

	self._pmEff5:setParent(self.mainGO.transform)
	self._pmEff5:setScale(1)

	local effPath = "fx_ui_moyantiaozhan/fx_ui_anniu01.prefab"

	self._pmEff6 = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, -198, 210, true, nil, nil, nil, self)

	self._pmEff6:setParent(self.mainGO.transform)
	self._pmEff6:setScale(1)
end

function HonglianzhanfangView:initView()
	local baseCfg = MoyanConfig.instance:getBaseConfig(self._challengeId) or {}
	local cfg = MoyanConfig.instance:getPlanCfg(baseCfg.challengePlan, self._type)
	local stagePlan = cfg.stagePlan

	self.txtDesc.text = cfg.desc

	for i, go in ipairs(self.items) do
		local txt = goutil.findChildTextComponent(go, "txt")
		local temp = MoyanConfig.instance:getMonsterCfg(stagePlan, i) or {}

		txt.text = temp.name

		GameUtil.addClickHandler(go, GameUtil.handler(self.onClickStart, self, i))
	end
end

function HonglianzhanfangView:onClickStart(idx)
	local baseCfg = MoyanConfig.instance:getBaseConfig(self._challengeId) or {}
	local cfg = MoyanConfig.instance:getPlanCfg(baseCfg.challengePlan, self._type)
	local mo = MoyanModel.instance:getSingleInfo(self._challengeId, self._type)

	if table.indexof((mo.randomSelfPetTypeInfo or nil) and (mo.randomSelfPetTypeInfo.tdPassedStages or {}), idx) == false then
		local params = {}

		params.challengeId = self._challengeId
		params.type = self._type
		params.stageId = idx

		UIStateManager.instance:push(ViewName.MoyanMissionView, params)
	else
		TipsFacade.instance:openCommonTips(lang("hongliannvhuangview__4"))
	end
end

function HonglianzhanfangView:onRefreshUI()
	local baseCfg = MoyanConfig.instance:getBaseConfig(self._challengeId) or {}
	local cfg = MoyanConfig.instance:getPlanCfg(baseCfg.challengePlan, self._type)
	local stagePlan = cfg.stagePlan
	local buffPlan = cfg.buffPlan
	local mo = MoyanModel.instance:getSingleInfo(self._challengeId, self._type)
	local tdPassedStages = {}

	if mo.randomSelfPetTypeInfo then
		tdPassedStages = mo.randomSelfPetTypeInfo.tdPassedStages or {}
	end

	if #tdPassedStages == 0 then
		self.txtDescBuff.text = lang("honglianzhanfangview__1")
	else
		local buffCfg = MoyanConfig.instance:getBuffCfg(buffPlan, #tdPassedStages)

		self.txtDescBuff.text = buffCfg.des
	end

	GameUtil.SetActive(self.btnSure, false)

	for i, go in ipairs(self.items) do
		local pass = goutil.findChild(go, "pass")

		GameUtil.SetActive(pass, false)

		local temp = MoyanConfig.instance:getMonsterCfg(stagePlan, i)

		if table.indexof(tdPassedStages, i) ~= false then
			GameUtil.SetActive(pass, true)
			GameUtil.SetActive(self.btnSure, true)
		end
	end
end

function HonglianzhanfangView:onClickReset()
	local baseCfg = MoyanConfig.instance:getBaseConfig(self._challengeId) or {}
	local cfg = MoyanConfig.instance:getPlanCfg(baseCfg.challengePlan, self._type)
	local resetChallengeCost = cfg.resetChallengeCost
	local matType, cfgId, num = MaterialMgr.getMatParams(resetChallengeCost)
	local name = MaterialMgr.getMaterialsName(matType, cfgId)
	local content = string.format("确定花费%s%s重新挑战吗？\n将重置本关所有进度！", num, name)

	local function func()
		MoyanController.instance:sendResetChallenge(self._challengeId, self._type)
	end

	TipsFacade.instance:openPopupCostMatViewNew(matType, cfgId, num, content, func)
end

return HonglianzhanfangView
