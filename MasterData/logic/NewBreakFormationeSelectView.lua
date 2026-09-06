-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbreakformation/view/NewBreakFormationeSelectView.lua

module("logic.extensions.newbreakformation.view.NewBreakFormationeSelectView", package.seeall)

local NewBreakFormationeSelectView = class("NewBreakFormationeSelectView", ViewComponent)

function NewBreakFormationeSelectView:ctor()
	NewBreakFormationeSelectView.super.ctor(self)
end

function NewBreakFormationeSelectView:unbindEvents()
	NewBreakFormationeSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSelect)
end

function NewBreakFormationeSelectView:bindEvents()
	NewBreakFormationeSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSelect, self._onClickSelect, self)
end

function NewBreakFormationeSelectView:buildUI()
	NewBreakFormationeSelectView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSelect = self:getGo("btnSelect")
	self._allBuffTableView = self:getGo("allTableview")
	self._uniqueBuffTableView = self:getGo("uniqueTableview")
	self._buffCell = self:getGo("buffCell")
	self._txtSelectCount = self:getTxt("txtSelectCount")
end

function NewBreakFormationeSelectView:onExit()
	NewBreakFormationeSelectView.super.onExit(self)
end

function NewBreakFormationeSelectView:onEnter()
	NewBreakFormationeSelectView.super.onEnter(self)

	self._allBuffTableList = ScrollerList.create(self._allBuffTableView, self._buffCell, GameUtil.handler(self._updateAllCell, self), GameUtil.handler(self._clearAllCell, self))
	self._uniqueBuffTableList = ScrollerList.create(self._uniqueBuffTableView, self._buffCell, GameUtil.handler(self._updateUniqueCell, self), GameUtil.handler(self._clearUniqueCell, self))

	local params = self:getOpenParam()

	self._seasonId = params[1]
	self._tabId = params[2]
	self._periodId = params[3]
	self._stageId = params[4]

	local buffMap = NewBreakFormationModel.instance:getBuffMap(self._tabId)

	self._allBuffId = nil
	self._uniqueBuffId = nil

	if buffMap and buffMap[self._stageId] then
		self._allBuffId = buffMap[self._stageId].allBuffId
		self._uniqueBuffId = buffMap[self._stageId].uniqueBuffId
	end

	local tabCfg = NewBreakFormationConfig.instance:getTabCfg(self._seasonId, self._tabId)
	local periodCfg = NewBreakFormationConfig.instance:getPeriodCfg(tabCfg.periodPlanId, self._periodId)

	self._stageCfg = NewBreakFormationConfig.instance:getStageCfg(periodCfg.stagePlanId, self._stageId)

	self:_refreshView()
end

function NewBreakFormationeSelectView:_refreshView()
	local stageInfo = NewBreakFormationModel.instance:getStageInfo(self._seasonId, self._tabId, self._periodId, self._stageId)
	local allBuffCfgs = NewBreakFormationConfig.instance:getBuffCfgs(self._stageCfg.allPetBuffPlan) or {}
	local allBuffList = {}
	local uniqueBuffCfgs = NewBreakFormationConfig.instance:getBuffCfgs(self._stageCfg.specialBuffPlan) or {}
	local uniqueBuffList = {}

	if stageInfo and stageInfo.buffInfo then
		for i, v in ipairs(stageInfo.buffInfo.allPetBuffIds) do
			table.insert(allBuffList, allBuffCfgs[v])
		end

		for i, v in ipairs(stageInfo.buffInfo.specialBuffIds) do
			table.insert(uniqueBuffList, uniqueBuffCfgs[v])
		end
	else
		for i, v in ipairs(allBuffCfgs) do
			table.insert(allBuffList, v)
		end

		for i, v in ipairs(uniqueBuffCfgs) do
			table.insert(uniqueBuffList, v)
		end
	end

	self._allBuffTableList:reloadData(allBuffList)
	self._uniqueBuffTableList:reloadData(uniqueBuffList)

	local count = 0

	if checknumber(self._allBuffId) > 0 then
		count = count + 1
	end

	if checknumber(self._uniqueBuffId) > 0 then
		count = count + 1
	end

	self._txtSelectCount.text = langPara("已选择增益  <color=#21B273FF>%d/2</color>", count)
end

function NewBreakFormationeSelectView:_updateAllCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "buffCon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local btnSelect = goutil.findChild(go, "btn")
	local selectGo = goutil.findChild(go, "selectGo")

	uGuiUtil.clearImage(con)
	uGuiUtil.setSpriteToImage(con, nil, data.buffResName)

	txtDesc.text = data.buffDesc
	txtName.text = data.name

	GameUtil.SetActive(selectGo, data.buffId == self._allBuffId)
	GameUtil.rmClickHandler(btnSelect)
	GameUtil.addClickHandler(btnSelect, function()
		self:_onClickAllBuff(data.buffId)
	end)
end

function NewBreakFormationeSelectView:_clearAllCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "buffCon")
	local btnSelect = goutil.findChild(go, "btn")

	uGuiUtil.clearImage(con)
	GameUtil.rmClickHandler(btnSelect)
end

function NewBreakFormationeSelectView:_updateUniqueCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "buffCon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local btnSelect = goutil.findChild(go, "btn")
	local selectGo = goutil.findChild(go, "selectGo")

	uGuiUtil.clearImage(con)
	uGuiUtil.setSpriteToImage(con, nil, data.buffResName)

	txtDesc.text = data.buffDesc
	txtName.text = data.name

	GameUtil.SetActive(selectGo, data.buffId == self._uniqueBuffId)
	GameUtil.rmClickHandler(btnSelect)
	GameUtil.addClickHandler(btnSelect, function()
		self:_onClickUniqueBuff(data.buffId)
	end)
end

function NewBreakFormationeSelectView:_clearUniqueCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "buffCon")
	local btnSelect = goutil.findChild(go, "btn")

	uGuiUtil.clearImage(con)
	GameUtil.rmClickHandler(btnSelect)
end

function NewBreakFormationeSelectView:_onClickAllBuff(buffId)
	self._allBuffId = buffId

	self:_refreshView()
end

function NewBreakFormationeSelectView:_onClickUniqueBuff(buffId)
	self._uniqueBuffId = buffId

	self:_refreshView()
end

function NewBreakFormationeSelectView:_onClickClose()
	self:close()
end

function NewBreakFormationeSelectView:_onClickSelect()
	if self._allBuffId and self._uniqueBuffId then
		NewBreakFormationModel.instance:setBuffMap(self._tabId, self._stageId, self._allBuffId, self._uniqueBuffId)
		GlobalDispatcher:dispatch(GlobalNotify.NewBreakFormationeSelectBuff)
		self:close()
	else
		FloatWordMgr.instance:show(lang("必须选择两个增益效果"))
	end
end

return NewBreakFormationeSelectView
