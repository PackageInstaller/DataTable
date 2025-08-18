-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridMultiContainerMixin.lua

local UIControls = UIControls
local GridMultiContainerMixin = {}

function GridMultiContainerMixin:ctorMixin()
	self:initUI()
end

function GridMultiContainerMixin:initUI()
	self.btnRemove = UIControls.Button(self, "Btn")

	self.btnRemove:addEventClick(self.onBtnRemoveClick)

	self.txtSelectNum = UIControls.Label(self, "TextNum2")
	self.txtTotalNum = UIControls.Label(self, "TextNum1")
	self.panelRec = UIControls.Panel(self, "IconRec1")
	self.panelArtifactBreak = UIControls.Panel(self, "IconRec2")
end

function GridMultiContainerMixin:setObj(clientItem)
	local gridPrefab = UIControls.getGridPanelPrefab(clientItem)

	if gridPrefab ~= self.nowGridPrefab then
		self.nowGridPrefab = gridPrefab

		if self.grid then
			self.grid:destroy()
		end

		local gridType = UIControls.getGridPanelType(clientItem, "Child")

		self.grid = gridType(self, "GridBox", self.nowGridPrefab)

		self.grid:setVisible(true)
	end

	self.grid:setObj(clientItem)

	self.grid.mEnableTips = false
	self.grid.mEventClick = Slot(self.selectItem, self)

	self.grid.textNum:setVisible(ClientUtils.getMoney(self.grid.object.id) ~= 0)
	self.grid.textNum:setText(self.grid.object:getNumStr())
	self:clearSelect()
end

function GridMultiContainerMixin:onBtnRemoveClick()
	if self.selectNum and self.selectNum > 0 then
		self.selectNum = self.selectNum - 1

		self:refreshSelectShow()
		self:playCallBack(false)
	end
end

function GridMultiContainerMixin:selectItem(sender)
	if self.grid.object.num <= 0 then
		MsgManager.clientNotice(184)

		return
	end

	local maxSelect = math.min(self.selMaxNum or 9999, self.grid.object.num or 1)

	if not self.selectNum then
		self.selectNum = 1

		self:playCallBack(true)
	elseif maxSelect > self.selectNum then
		self.selectNum = self.selectNum + 1

		self:playCallBack(true)
	else
		MsgManager.clientNotice(185)
	end

	self:refreshSelectShow()
end

function GridMultiContainerMixin:forceSetNum(selectNum)
	self.selectNum = selectNum

	self:refreshSelectShow()
end

function GridMultiContainerMixin:refreshSelectShow()
	self.grid.textNum:setVisible(self.selectNum <= 0)
	self.txtTotalNum:setVisible(self.selectNum > 0)
	self.btnRemove:setVisible(self.selectNum > 0)
	self.grid.imgSelect:setVisible(self.selectNum > 0)
	self.txtSelectNum:setText(self.selectNum)
	self.txtTotalNum:setText(self.grid.object.num)
end

function GridMultiContainerMixin:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function GridMultiContainerMixin:clearSelect()
	self.selectNum = 0

	self:refreshSelectShow()
end

function GridMultiContainerMixin:playCallBack(isAdd)
	if self.grid and self.selectCallback then
		self.selectCallback(self, isAdd)
	end
end

return GridMultiContainerMixin
