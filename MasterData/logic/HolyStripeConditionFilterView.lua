-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeConditionFilterView.lua

module("logic.extensions.holystripe.view.HolyStripeConditionFilterView", package.seeall)

local HolyStripeConditionFilterView = class("HolyStripeConditionFilterView", ViewComponent)
local maxSelectCount = 5

function HolyStripeConditionFilterView:buildUI()
	HolyStripeConditionFilterView.super.buildUI(self)

	self._customInput = UICustomInput.Get(self:getGo("levelFitlerRoot"))
	self._tableview = self:getGo("levelFitlerRoot/tableview")
	self._tableCell = self:getGo("levelFitlerRoot/cell")
end

function HolyStripeConditionFilterView:bindEvents()
	HolyStripeConditionFilterView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function HolyStripeConditionFilterView:unbindEvents()
	HolyStripeConditionFilterView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function HolyStripeConditionFilterView:onEnter()
	HolyStripeConditionFilterView.super.onEnter()

	self._scrollerList = ScrollerList.create(self._tableview, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._selectSort = self:getFirstParam()
	self._selectMap = {}
	self._selectCount = 0

	for i, v in ipairs(self._selectSort) do
		self._selectMap[v] = true
		self._selectCount = self._selectCount + 1
	end

	self:_refreshView()
end

function HolyStripeConditionFilterView:onExit()
	HolyStripeConditionFilterView.super.onExit()
	self._scrollerList:dispose()
end

function HolyStripeConditionFilterView:_refreshView()
	local list = HolyStripeConfig.instance:getFilterList()

	self._scrollerList:reloadData(list)
end

function HolyStripeConditionFilterView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local uiChangeGroup = go:GetComponent("UIChangeGroup")
	local text = goutil.findChildTextComponent(go, "txt")
	local btn = goutil.findChild(go, "raycast")

	if self._selectMap[data.id] == true then
		uiChangeGroup:SetState(1)
	else
		uiChangeGroup:SetState(0)
	end

	local showtext = ""

	showtext = data.value == HolyStripeModel.NotAttrSort[-1] and lang("已镶嵌") or data.value == HolyStripeModel.NotAttrSort[-2] and lang("入手时间") or data.value == HolyStripeModel.NotAttrSort[-3] and lang("等级") or data.value == HolyStripeModel.NotAttrSort[-4] and lang("品质") or ConstString.HolyStripeAttr[GameEnum.HolyStripeAttrType[data.id]]

	if not string.nilorempty(showtext) then
		text.text = showtext
	end

	GameUtil.addClickHandler(btn, function()
		self:_onClickItem(data.id)
	end)
end

function HolyStripeConditionFilterView:_clearCell(cell)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(goutil.findChild(go, "raycast"))

	btn:RemoveClickListener()
end

function HolyStripeConditionFilterView:_onClickItem(conditionId)
	local maxSelectCount = self:_getMaxSelectCount()

	if self._selectMap[conditionId] == true then
		self._selectMap[conditionId] = false
		self._selectCount = self._selectCount - 1
	elseif maxSelectCount <= self._selectCount then
		FloatWordMgr.instance:show(langPara("最多同时筛选%s条属性哦！", maxSelectCount))

		return
	else
		self._selectMap[conditionId] = true
		self._selectCount = self._selectCount + 1
	end

	table.clear(self._selectSort)

	for i, v in pairs(self._selectMap) do
		if v == true then
			table.insert(self._selectSort, i)
		end
	end

	GlobalDispatcher:dispatch(HolyStripeController.On_Select_ConditionFilter, self._selectSort)
	self:_refreshView()
end

function HolyStripeConditionFilterView:_getMaxSelectCount()
	return maxSelectCount
end

function HolyStripeConditionFilterView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

return HolyStripeConditionFilterView
