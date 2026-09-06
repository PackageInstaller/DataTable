-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/swordstorm/view/SwordStormRuleView.lua

module("logic.extensions.swordstorm.view.SwordStormRuleView", package.seeall)

local SwordStormRuleView = class("SwordStormRuleView", ViewComponent)

function SwordStormRuleView:ctor()
	SwordStormRuleView.super.ctor(self)
end

function SwordStormRuleView:unbindEvents()
	SwordStormRuleView.super.unbindEvents(self)
end

function SwordStormRuleView:bindEvents()
	SwordStormRuleView.super.bindEvents(self)
end

function SwordStormRuleView:buildUI()
	SwordStormRuleView.super.buildUI(self)

	self._txtRuleDesc = self:getTxt("ruleBase/scrollList/Viewport/Content/txtRuleDesc")
	self._tableview = self:getGo("rulePerfect/tableview")
	self._tablecell = self:getGo("rulePerfect/tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateRuleCell, self), GameUtil.handler(self._clearRule, self))
	self._itemCell = self:getGo("itemCell")
end

function SwordStormRuleView:onExit()
	SwordStormRuleView.super.onExit(self)
	self._tableList:dispose()

	for k, v in pairs(self._itemListDir) do
		v:dispose()
	end

	self._itemListDir = {}
end

function SwordStormRuleView:onEnter()
	SwordStormRuleView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[5])
	self._phaseId = checknumber(params[6])
	self._stageId = checknumber(params[7])
	self._itemListDir = {}

	self:refreshView()
end

function SwordStormRuleView:refreshView()
	local stageCfg = SwordStormConfig.instance:getStageCfg(self._activityId, self._phaseId, self._stageId)
	local scoreCfg = SwordStormConfig.instance:getConditionPlanCfgs(stageCfg.conditionPlanId)

	self._tableList:reloadData(scoreCfg)

	local cfgEnemy = SwordStormConfig.instance:getTeamCfg(stageCfg.creepsMasterId)

	self._txtRuleDesc.text = cfgEnemy.ruleDesc
end

function SwordStormRuleView:_updateRuleCell(view, cell, data, i)
	local go = cell.gameObject
	local rule = goutil.findChildTextComponent(go, "txtDesc")
	local itemTableview = goutil.findChild(go, "itemTableview")
	local starChange = goutil.findChildComponent(go, "star", ComponentType.UIImageSpriteChange)

	rule.text = SwordStormController.instance:getConditionDesc(data.conditionPlanId, data.conditionId)

	local isComplete = SwordStormModel.instance:getConditionComplete(self._activityId, self._phaseId, self._stageId, data.conditionId)
	local itemTableList = self._itemListDir[go]

	if not itemTableList then
		itemTableList = ScrollerList.create(itemTableview, self._itemCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
		self._itemListDir[go] = itemTableList
	end

	local prizeList = {}
	local prizeArray = string.split(data.prize, "#")

	for i, v in ipairs(prizeArray) do
		table.insert(prizeList, {
			prize = v,
			isComplete = isComplete
		})
	end

	itemTableList:reloadData(prizeList)

	if isComplete == true then
		starChange:SetState(0)
	else
		starChange:SetState(1)
	end
end

function SwordStormRuleView:_clearRule(cell)
	local go = cell.gameObject

	if self._itemListDir[go] then
		self._itemListDir[go]:dispose()

		self._itemListDir[go] = nil
	end
end

function SwordStormRuleView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local gain = goutil.findChild(go, "gain")

	MaterialMgr.setCellByCfg(data.prize, con)
	GameUtil.SetActive(gain, data.isComplete)
end

function SwordStormRuleView:_clearItemCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

return SwordStormRuleView
