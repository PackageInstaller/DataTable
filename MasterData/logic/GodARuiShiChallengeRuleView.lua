-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godaruishichallenge/view/GodARuiShiChallengeRuleView.lua

module("logic.extensions.godaruishichallenge.view.GodARuiShiChallengeRuleView", package.seeall)

local GodARuiShiChallengeRuleView = class("GodARuiShiChallengeRuleView", ViewComponent)

function GodARuiShiChallengeRuleView:buildUI()
	GodARuiShiChallengeRuleView.super.buildUI(self)

	self._nomalRule = self:getGo("nomalRule")
	self._bossRule = self:getGo("bossRule")
	self._imgNomal = self:getGo("nomalRule/imgType")
	self._txtBuffDesc = self:getTxt("nomalRule/desc")
	self._txtNomalTitle = self:getTxt("nomalRule/title")
	self._nomalAnimator = self._nomalRule:GetComponent("Animator")
	self._effect = self:getGo("effect")
	self._ruleItem = self:getGo("bossRule/rulePerfect/scrollList/Viewport/Content/txtgroup")
	self._ruleGroupGo = self:getGo("bossRule/rulePerfect/scrollList/Viewport/Content")
	self._ruleGroup = ItemGroup.New(self._ruleGroupGo, self._ruleItem)
	self._scoreRule = self:getTxt("bossRule/rulePerfect/scrollList/Viewport/Content/txtgroup/txtScoreRule")
	self._damageRule = self:getTxt("bossRule/rulePerfect/scrollList/Viewport/Content/txtgroup/txtDamageRule")
end

function GodARuiShiChallengeRuleView:bindEvents()
	GodARuiShiChallengeRuleView.super.bindEvents(self)
end

function GodARuiShiChallengeRuleView:unbindEvents()
	GodARuiShiChallengeRuleView.super.unbindEvents(self)
end

function GodARuiShiChallengeRuleView:onEnter()
	GodARuiShiChallengeRuleView.super.onEnter(self)

	local params = self:getOpenParam()

	self._isBoss = params[5]
	self._stageId = params[6]
	self._challengeId = params[7]

	GameUtil.SetActive(self._nomalRule, not self._isBoss)
	GameUtil.SetActive(self._bossRule, self._isBoss)

	if self._isBoss then
		GodARuiShiChallengeModel.instance:saveReadBossRule()
		self:refreshBossUI()
	else
		local stageCfg = GodARuiShiChallengeConfig.instance:getStageInfo(self._challengeId, self._stageId)

		self._stageTypeCfg = GodARuiShiChallengeConfig.instance:getStageTypeInfo(stageCfg.type)

		self:refreshNomalUI()
	end

	local isShowRuleEffect = GodARuiShiChallengeModel.instance:getTempShowRuleEffect()

	self._nomalAnimator.enabled = isShowRuleEffect

	if isShowRuleEffect and not self._isBoss then
		self:_playRuleEffectStart()
	end
end

function GodARuiShiChallengeRuleView:onExit()
	GodARuiShiChallengeRuleView.super.onExit(self)
	GodARuiShiChallengeModel.instance:setTempShowRuleEffect(false)
	GlobalDispatcher:dispatch(GlobalNotify.GodARuiShiChallengeCloseRuleView, self._isBoss, self._stageId, self._challengeId)
	uGuiUtil.clearImage(self._imgNomal)
	self._ruleGroup:dispose(self._clearBossRule, self)
	UIEffectManager.instance:stopEffect(self._showEffectHandler)
	UIEffectManager.instance:stopEffect(self._disappearEffectHandler)
end

function GodARuiShiChallengeRuleView:refreshBossUI()
	local scoreCfg = GodARuiShiChallengeConfig.instance:getScoreCfg(self._challengeId, self._stageId)
	local dataList = {}

	if scoreCfg then
		local damageList = {}

		for i, v in pairs(scoreCfg) do
			table.insert(damageList, i)
		end

		table.sort(damageList)

		local lowDamage, highDamage

		for i = 1, #damageList do
			table.insert(dataList, {
				lowDamage = damageList[i],
				highDamage = damageList[i + 1],
				score = scoreCfg[damageList[i]].score
			})
		end
	end

	self._ruleGroup:updateWithMoArray(dataList, self._updateBossRuleCell, self)
end

function GodARuiShiChallengeRuleView:refreshNomalUI()
	local stageCfg = GodARuiShiChallengeConfig.instance:getStageInfo(self._challengeId, self._stageId)
	local creepCfg = GodARuiShiChallengeConfig.instance:getTeam(stageCfg.creepsMasterId)

	self._txtBuffDesc.text = creepCfg.description
	self._txtNomalTitle.text = self._stageTypeCfg.name

	uGuiUtil.clearImage(self._imgNomal)

	if not string.nilorempty(self._stageTypeCfg.rulePath) then
		uGuiUtil.setSpriteToImage(self._imgNomal, nil, GameUrl.getIconFolderUrl("familytech", self._stageTypeCfg.rulePath))
	end
end

function GodARuiShiChallengeRuleView:_updateBossRuleCell(item, data, i)
	local go = item.mainGO
	local damageRule = goutil.findChildTextComponent(go, "txtDamageRule")
	local scoreRule = goutil.findChildTextComponent(go, "txtScoreRule")

	damageRule.text = data.highDamage == nil and langPara("%d以上", data.lowDamage) or langPara("%d-%d", data.lowDamage, data.highDamage)

	local itemCon = goutil.findChild(go, "img")

	uGuiUtil.clearImage(itemCon)

	if self._challengeId == GodARuiShiChallengeConfig.instance:getChallengeEvolveChallengeId() then
		uGuiUtil.setSpriteToImage(itemCon, nil, GameUrl.getItemIconUrl("icon_shengmingjinghua"))
	else
		uGuiUtil.setSpriteToImage(itemCon, nil, GameUrl.getItemIconUrl("icon_sqarssp"))
	end

	scoreRule.text = langPara("%d", data.score)
end

function GodARuiShiChallengeRuleView:_clearBossRule(item)
	local go = item.mainGO
	local itemCon = goutil.findChild(go, "img")

	MaterialMgr.resetAll(itemCon)
	uGuiUtil.clearImage(itemCon)
end

function GodARuiShiChallengeRuleView:_playRuleEffectStart()
	local showEffectPath = "20220902/shenqiaruisi/" .. self._stageTypeCfg.effectRuleShow .. ".prefab"

	self._showEffectHandler = UIEffectManager.instance:playEffect(self, showEffectPath, nil, 0, 0, false, nil, GameUtil.handler(self._playRuleEffectEnd, self))

	self._showEffectHandler:setParent(self._effect.transform)
	self._showEffectHandler:setLocalPos(0, 0, 0)
	self._showEffectHandler:setScale(1)
end

function GodARuiShiChallengeRuleView:_playRuleEffectEnd()
	GameUtil.SetActive(self._nomalRule, false)

	local disappearEffectPath = "20220902/shenqiaruisi/" .. self._stageTypeCfg.effectRuleEnd .. ".prefab"

	self._disappearEffectHandler = UIEffectManager.instance:playEffect(self, disappearEffectPath, nil, 0, 0, false, nil, GameUtil.handler(self.close, self))

	self._disappearEffectHandler:setParent(self._effect.transform)
	self._disappearEffectHandler:setLocalPos(0, 0, 0)
	self._disappearEffectHandler:setScale(1)
end

return GodARuiShiChallengeRuleView
