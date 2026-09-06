-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeConditionSortView.lua

module("logic.extensions.holystripe.view.HolyStripeConditionSortView", package.seeall)

local HolyStripeConditionSortView = class("HolyStripeConditionSortView", ViewComponent)

function HolyStripeConditionSortView:buildUI()
	HolyStripeConditionSortView.super.buildUI(self)

	self._customInput = UICustomInput.Get(self:getGo("levelFitlerRoot"))
	self._tableview = self:getGo("levelFitlerRoot/tableview")
	self._tableCell = self:getGo("levelFitlerRoot/cell")
end

function HolyStripeConditionSortView:bindEvents()
	HolyStripeConditionSortView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function HolyStripeConditionSortView:unbindEvents()
	HolyStripeConditionSortView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function HolyStripeConditionSortView:onEnter()
	HolyStripeConditionSortView.super.onEnter()

	self._scrollerList = ScrollerList.create(self._tableview, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._selectSort = self:getFirstParam()

	self:_refreshView()
end

function HolyStripeConditionSortView:onExit()
	HolyStripeConditionSortView.super.onExit()
	self._scrollerList:dispose()
end

function HolyStripeConditionSortView:_refreshView()
	local list = {}
	local headList = {}

	for i, v in pairs(HolyStripeModel.NotAttrSort) do
		table.insert(headList, {
			id = i,
			value = v
		})
	end

	table.sort(headList, function(a, b)
		return a.id > b.id
	end)

	for i = #headList, 1, -1 do
		table.insert(list, 1, headList[i])
	end

	self._scrollerList:reloadData(list)
end

function HolyStripeConditionSortView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local uiChangeGroup = go:GetComponent("UIChangeGroup")
	local text = goutil.findChildTextComponent(go, "txt")
	local btn = GameUtil.asBtn(goutil.findChild(go, "raycast"))

	if data.id == self._selectSort then
		uiChangeGroup:SetState(1)
	else
		uiChangeGroup:SetState(0)
	end

	local showtext = ""

	showtext = data.value == HolyStripeModel.NotAttrSort[-1] and lang("已镶嵌") or data.value == HolyStripeModel.NotAttrSort[-2] and lang("入手时间") or data.value == HolyStripeModel.NotAttrSort[-3] and lang("等级") or data.value == HolyStripeModel.NotAttrSort[-5] and lang("弃置") or data.value == HolyStripeModel.NotAttrSort[-4] and lang("品质") or ConstString.HolyStripeAttr[GameEnum.HolyStripeAttrType[data.id]]

	if not string.nilorempty(showtext) then
		text.text = showtext
	end

	btn:AddClickListener(function()
		self:_onClickItem(data.id)
	end)
end

function HolyStripeConditionSortView:_clearCell(cell)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(goutil.findChild(go, "raycast"))

	btn:RemoveClickListener()
end

function HolyStripeConditionSortView:_onClickItem(conditionId)
	if self._selectSort == conditionId then
		self._selectSort = -1

		GlobalDispatcher:dispatch(HolyStripeController.On_Select_ConditionSort, self._selectSort)
	else
		GlobalDispatcher:dispatch(HolyStripeController.On_Select_ConditionSort, conditionId)
	end

	self:close()
end

function HolyStripeConditionSortView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

return HolyStripeConditionSortView
