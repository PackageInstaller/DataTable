-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityChallengeView.lua

module("logic.extensions.guardcity.view.GuardCityChallengeView", package.seeall)

local GuardCityChallengeView = class("GuardCityChallengeView", ViewComponent)

GuardCityChallengeView.ChallengeMode_Nomal = 1
GuardCityChallengeView.ChallengeMode_Powerful = 2

function GuardCityChallengeView:ctor()
	GuardCityChallengeView.super.ctor(self)
end

function GuardCityChallengeView:buildUI()
	GuardCityChallengeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnList = self:getBtn("btnList")
	self._teamViewsGo = self:getGo("enemy/tableview")
	self._teamGo = self:getGo("enemy/item")
	self._rewardViewsGo = self:getGo("scoreReward/tableview")
	self._rewardGo = self:getGo("scoreReward/item")
	self._winRewardViewsGo = self:getGo("winReward/tableview")
	self._winRewardGo = self:getGo("winReward/item")
	self._imgNumberTxtPetPower = goutil.findChildComponent(self.mainGO, "power/imgRecZdl", "UIImgNumeralText")
	self._txtStar = self:getTxt("imgStar/txt")
	self._txtWinCondition = self:getTxt("txtWinCondition")
	self._uiChangeNomalMode = goutil.findChildComponent(self.mainGO, "btnNomal/select", "UIImageSpriteChange")
	self._uiChangePowerfulMode = goutil.findChildComponent(self.mainGO, "btnPowerful/select", "UIImageSpriteChange")
	self._txtTili = self:getTxt("btnChallenge/txtTili")
	self._btnNomal = self:getBtn("btnNomal")
	self._btnPowerful = self:getBtn("btnPowerful")
	self._btnChallenge = self:getBtn("btnChallenge")
end

function GuardCityChallengeView:bindEvents()
	GuardCityChallengeView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnNomal, self._onClickNomal, self)
	GameUtil.addClickHandler(self._btnPowerful, self._onClickPowerful, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnList, self._onClickList, self)
end

function GuardCityChallengeView:unbindEvents()
	GuardCityChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnNomal)
	GameUtil.rmClickHandler(self._btnPowerful)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnList)
end

function GuardCityChallengeView:onEnter()
	GuardCityChallengeView.super.onEnter(self)

	self._teamScrollList = ScrollerList.create(self._teamViewsGo, self._teamGo, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))
	self._rewardScrollList = ScrollerList.create(self._rewardViewsGo, self._rewardGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._winRewardScrollList = ScrollerList.create(self._winRewardViewsGo, self._winRewardGo, GameUtil.handler(self._updateWinRewardCell, self), GameUtil.handler(self._clearWinRewardCell, self))

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._masterUniqueId = params[2]
	self._masterInfo = GuardCiytModel.instance:getMasterInfo(self._masterUniqueId)
	self._actCfg = GuardCityConfig.instance:getActivityCfg(self._activityId)

	local creeps = GuardCityConfig.instance:getCreepsCfg(self._masterInfo.creepsMasterId)
	local list = {}

	for k, v in pairs(creeps) do
		local mo = FightingPowerPetMo.New()

		mo:fromChallengeCreepCo(v, creeps)
		table.insert(list, {
			mo = mo,
			index = v.creepsId
		})
	end

	self._teamScrollList:reloadData(list)

	local attrRes = {}

	for i, v in ipairs(creeps) do
		local attrs = FightingPowerFormula.instance:parseAttrValues(v.extproperties) or {}

		attrRes = AttrMo.addSameAttrs(attrs, attrRes)
	end

	local bossMaxHp = checknumber(attrRes[FightingPowerFormula.instance:getAttrTypeByName("生命")])
	local damagePrizeCfg

	for i, v in ipairs(GuardCityConfig.instance:getDamagePrizeCfgs(self._actCfg.damagePrizePlanId)) do
		if bossMaxHp > v.damage then
			damagePrizeCfg = v
		end
	end

	if damagePrizeCfg then
		damagePrizeList = string.split(damagePrizeCfg.prize, "#")

		self._rewardScrollList:reloadData(damagePrizeList)
	end

	local masterCfg = GuardCityConfig.instance:getMonsterCfg(self._actCfg.masterPlanId, self._masterInfo.creepsMasterId)
	local starCfg = GuardCityConfig.instance:getStarCfg(self._actCfg.starPlanId, masterCfg.star)

	if starCfg then
		local winPrizeList = string.split(starCfg.defeatPrize, "#")

		self._winRewardScrollList:reloadData(winPrizeList)
	end

	self._imgNumberTxtPetPower:SetNum(masterCfg.recommendZdl)

	self._txtStar.text = masterCfg.star
	self._txtWinCondition.text = masterCfg.ruleDesc
	self._challengeMode = GuardCityChallengeView.ChallengeMode_Nomal

	self:_refreshBtn()
end

function GuardCityChallengeView:onExit()
	GuardCityChallengeView.super.onExit(self)
	self._teamScrollList:dispose()
	self._rewardScrollList:dispose()
	self._winRewardScrollList:dispose()
end

function GuardCityChallengeView:_updateTeamCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local hpSlider = Framework.SliderAdapter.GetFrom(go, "hpSlider")
	local isDead = false

	if self._masterInfo.enemyStage[data.index] then
		GameUtil.SetActive(hpSlider, true)

		if self._masterInfo.enemyStage[data.index] <= 0 then
			isDead = true

			GameUtil.SetActive(hpSlider, false)
		end

		hpSlider:SetValue(self._masterInfo.enemyStage[data.index] * 0.0001)
	else
		GameUtil.SetActive(hpSlider, false)
	end

	local proxy = MaterialMgr.setCellByMo(data.mo, con)

	if proxy then
		proxy.binder:setCallBack(function()
			CommonTipsMgr.instance:showPetTips(data.mo)
		end)

		if isDead == true then
			proxy.binder:SetGray(true)
		else
			proxy.binder:SetGray(false)
		end
	end
end

function GuardCityChallengeView:_clearTeamCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function GuardCityChallengeView:_updateRewardCell(view, cell, data, tag)
	MaterialMgr.resetAll(cell.gameObject)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function GuardCityChallengeView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function GuardCityChallengeView:_updateWinRewardCell(view, cell, data, tag)
	MaterialMgr.resetAll(cell.gameObject)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function GuardCityChallengeView:_clearWinRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function GuardCityChallengeView:_refreshBtn()
	local cost = GuardCityConfig.instance:getCommonValue("CHALLENGE_STRENGTH_COST", true)

	if self._challengeMode == GuardCityChallengeView.ChallengeMode_Nomal then
		self._uiChangeNomalMode:SetState(1)
	else
		self._uiChangeNomalMode:SetState(0)
	end

	if self._challengeMode == GuardCityChallengeView.ChallengeMode_Powerful then
		cost = cost * GuardCityConfig.instance:getCommonValue("STRONG_CHALLENGE_COST_MULTIPLE", true)

		self._uiChangePowerfulMode:SetState(1)
	else
		self._uiChangePowerfulMode:SetState(0)
	end

	self._txtTili.text = langPara("%d", cost)
end

function GuardCityChallengeView:_onClickNomal()
	self._challengeMode = GuardCityChallengeView.ChallengeMode_Nomal

	self:_refreshBtn()
end

function GuardCityChallengeView:_onClickPowerful()
	self._challengeMode = GuardCityChallengeView.ChallengeMode_Powerful

	self:_refreshBtn()
end

function GuardCityChallengeView:_onClickChallenge()
	local isPowerful = self._challengeMode == GuardCityChallengeView.ChallengeMode_Powerful
	local cost = GuardCityConfig.instance:getCommonValue("CHALLENGE_STRENGTH_COST", true)

	if isPowerful == true then
		cost = cost * GuardCityConfig.instance:getCommonValue("STRONG_CHALLENGE_COST_MULTIPLE", true)
	end

	if cost <= GuardCiytModel.instance:getCurStrength() then
		local fmtMo = GuardCiytModel.instance:getFmtMo()
		local masterInfo = GuardCiytModel.instance:getMasterInfo(self._masterUniqueId)

		if masterInfo then
			fmtMo:initParams(self._activityId, masterInfo, isPowerful, RoleModel.instance:getUserId())
			CustomFmtController.instance:showMissionView(fmtMo)
		else
			FloatWordMgr.instance:show(lang("敌人不存在"))
		end

		self:close()
	else
		FloatWordMgr.instance:show(lang("疲劳不足"))
	end
end

function GuardCityChallengeView:_onClickList()
	UIStateManager.instance:push(ViewName.GuardCityChallengeRewardView, self._actCfg.damagePrizePlanId)
end

return GuardCityChallengeView
