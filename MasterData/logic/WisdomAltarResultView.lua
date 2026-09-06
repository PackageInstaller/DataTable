-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomaltar/view/WisdomAltarResultView.lua

module("logic.extensions.wisdomaltar.view.WisdomAltarResultView", package.seeall)

local WisdomAltarResultView = class("WisdomAltarResultView", ViewComponent)

function WisdomAltarResultView:buildUI()
	self._btnClose = self:getBtn("container/btnClose")
	self._tableview = self:getGo("container/listView/ScrollView"):GetComponent("UITableview")
	self._tableCell = self:getGo("container/listView/Cell")
	self._singleLayout = self:getGo("container/listView/SingleLines"):GetComponent(ComponentType.UILayoutSingleLine)
	self._singleCell = self:getGo("container/listView/CellLine")
	self._title = self:getGo("container/Title"):GetComponent(typeof(UIImageSpriteChange))
	self._container = self:getGo("container")

	self._tableCell:SetActive(false)
	self._singleCell:SetActive(false)
end

function WisdomAltarResultView:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._tableview:RegisterCallback(self._numInView, nil, self._cellAtIndex, self)
	self._tableview:RegisterUpdateCellCallback(self._onCellUpdate)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish)
end

function WisdomAltarResultView:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
end

function WisdomAltarResultView:onEnter()
	WisdomAltarResultView.super.onEnter(self)

	local oneMode = self:getFirstParam()

	self._curViewDatas = self:getOpenParam()[2]
	self._callback = self:getOpenParam()[3]

	local useSingleLine = #self._curViewDatas <= 7

	self._singleLayout.gameObject:SetActive(useSingleLine)

	if useSingleLine then
		self:_fillSingleLianes()
	else
		self._tableview:SetOffsetWithoutRefresh(0)
		self._tableview:ReloadData()
	end

	self._title:SetState(oneMode - 1)
	UnityTweens.UITweenFadeIn.StartTween(self._container, 0.5, UnityTweens.EaseType.easeOutSine)
end

function WisdomAltarResultView:onExitFinished()
	WisdomAltarResultView.super.onExitFinished(self)

	self._callback = nil

	self._tableview:Travel(function(cell)
		ItemPet.Remove(cell.gameObject)
	end, nil)

	local childCount = self._singleLayout.transform.childCount

	for i = 1, childCount do
		local go = self._singleLayout.transform:GetChild(i - 1).gameObject

		ItemPet.Remove(go)
	end
end

function WisdomAltarResultView:_numInView()
	if not self._curViewDatas then
		return 0
	end

	return #self._curViewDatas
end

function WisdomAltarResultView:_cellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[idx + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function WisdomAltarResultView:_onCellUpdate(view, cell)
	local idx = cell.index
	local data = self._curViewDatas[idx + 1]

	self:_updateCell(view, cell, data)
end

function WisdomAltarResultView:_updateCell(view, cell, data)
	local component = ItemPet.AddOnce(cell.gameObject)

	component:Init(data.petData)
	component:setSelected(false)
	component:SetInTeam(false)
end

function WisdomAltarResultView:_fillSingleLianes()
	local childCount = self._singleLayout.transform.childCount
	local cnt = #self._curViewDatas

	while childCount < cnt do
		childCount = childCount + 1

		UGUIToolHelper.AddChild(self._singleLayout.gameObject, self._singleCell)
	end

	for i = 1, cnt do
		local data = self._curViewDatas[i]
		local go = self._singleLayout.transform:GetChild(i - 1).gameObject

		go:SetActive(true)

		local icon = goutil.findChild(go, "Icon")
		local itemPet = ItemPet.AddOnce(icon)

		itemPet:Init(data.petData)
		itemPet:setSelected(false)
		itemPet:SetInTeam(false)
	end

	for i = cnt + 1, childCount do
		local go = self._singleLayout.transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	self._singleLayout:Layout()
end

function WisdomAltarResultView:_onClickClose()
	local callback = self._callback

	self:close()

	if callback then
		callback()
	end
end

return WisdomAltarResultView
