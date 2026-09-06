-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/HandbookView.lua

module("logic.extensions.handbook.view.HandbookView", package.seeall)

local HandbookView = class("HandbookView", ViewComponent)
local groupName = {
	[GameEnum.HandbookTab.PetFiles] = "精灵档案",
	[GameEnum.HandbookTab.PetOverall] = "精灵总览",
	[GameEnum.HandbookTab.PetPoster] = "精灵海报"
}
local cellSize = 200
local cellSpacing = 150

function HandbookView:ctor()
	HandbookView.super.ctor(self)
end

function HandbookView:destroyUI()
	HandbookView.super.destroyUI(self)
end

function HandbookView:onExitFinished()
	HandbookView.super.onExitFinished(self)
end

function HandbookView:onEnterFinished()
	HandbookView.super.onEnterFinished(self)
end

function HandbookView:unbindEvents()
	HandbookView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._petrelationBtn:RemoveClickListener()
end

function HandbookView:bindEvents()
	HandbookView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._petrelationBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.PetrelationView)
	end)
end

function HandbookView:onExit()
	HandbookView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._refreshRedPoint, self)
end

function HandbookView:buildUI()
	HandbookView.super.buildUI(self)

	self._closeButton = self:getBtn("topleft/btnClose")
	self._container = self:getGo("scrollrect/content/container")

	local cloneCell = goutil.findChild(self._container, "cell")
	local rectTrans = self._container:GetComponent("RectTransform")
	local cellNums = #groupName

	self._cells = {}

	for i = 1, cellNums do
		local cell = {}
		local go = i == 1 and cloneCell or goutil.cloneAndSetParent(cloneCell, self._container.transform)

		go.name = "cell_" .. tostring(i)

		Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)
		Framework.TransformUtil.SetLocalPos(go.transform, (i - 1) * (cellSize + cellSpacing), 0, 0)

		cell.mainGO = go
		cell.btn = Framework.ButtonAdapter.GetFrom(go, "btnClick")
		cell.imgTitle = goutil.findChildComponent(go, "btnClick/imgTitle", "UIImageSpriteChange")

		cell.btn:AddClickListener(function()
			self:_onClickTab(i)
		end)
		cell.imgTitle:SetState(i - 1)

		cell.redPoint = goutil.findChild(cell.btn.gameObject, "redPoint")

		table.insert(self._cells, cell)
	end

	Framework.TransformUtil.SetLocalPos(self._container.transform, -0.5 * (cellNums - 1) * (cellSpacing + cellSize), 0, 0)

	local sizeDelta = rectTrans.sizeDelta

	sizeDelta.x = cellSize * cellNums + cellSpacing * (cellNums - 1)
	rectTrans.sizeDelta = sizeDelta
	self._petrelationBtn = self:getBtn("petrelationBtn")
end

function HandbookView:onEnter()
	HandbookView.super.onEnter(self)
	self:_refreshRedPoint()
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._refreshRedPoint, self)
	print("enter book view")
end

function HandbookView:_refreshRedPoint()
	for i = 1, 3 do
		local cell = self._cells[i]

		if i == GameEnum.HandbookTab.PetPoster then
			goutil.setActive(cell.redPoint, RedPointModel.instance:isActive(RedPointModel.ID_PETPOSTER))
		elseif i == GameEnum.HandbookTab.PetFiles then
			goutil.setActive(cell.redPoint, RedPointModel.instance:isActive(67))
		elseif i == GameEnum.HandbookTab.PetOverall then
			goutil.setActive(cell.redPoint, false)
		end
	end
end

function HandbookView:_onClickClose()
	self:close()
end

function HandbookView:_onClickTab(i)
	local funId

	if i == GameEnum.HandbookTab.PetFiles then
		funId = 102
	elseif i == GameEnum.HandbookTab.PetPoster then
		funId = 103
	elseif i == GameEnum.HandbookTab.PetOverall then
		funId = 104
	end

	if funId then
		FuncOpenController.instance:openFunc(funId)
	end
end

return HandbookView
