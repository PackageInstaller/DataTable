-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSuitConditionSortView.lua

module("logic.extensions.holystripe.view.HolyStripeSuitConditionSortView", package.seeall)

local HolyStripeSuitConditionSortView = class("HolyStripeSuitConditionSortView", HolyStripeConditionSortView)

HolyStripeSuitConditionSortView.NotAttrSort = {
	[-2] = "gainTime"
}

function HolyStripeSuitConditionSortView:_refreshView()
	local list = HolyStripeConfig.instance:getFilterList()
	local headList = {}

	for i, v in pairs(HolyStripeSuitConditionSortView.NotAttrSort) do
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

function HolyStripeSuitConditionSortView:_updateCell(view, cell, data, tag)
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

	showtext = data.value == HolyStripeModel.NotAttrSort[-1] and lang("已镶嵌") or data.value == HolyStripeModel.NotAttrSort[-2] and lang("默认") or data.value == HolyStripeModel.NotAttrSort[-3] and lang("等级") or data.value == HolyStripeModel.NotAttrSort[-4] and lang("品质") or ConstString.HolyStripeAttr[GameEnum.HolyStripeAttrType[data.id]]

	if not string.nilorempty(showtext) then
		text.text = showtext
	end

	btn:AddClickListener(function()
		self:_onClickItem(data.id)
	end)
end

return HolyStripeSuitConditionSortView
