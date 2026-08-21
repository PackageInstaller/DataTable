-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Item\\OpenChoose\\OpenGiftBoxChooseDlg.lua

local AwardState = {
	Sel = 2,
	Nml = 1,
	Picked = 3
}
local OpenGiftBoxChooseDlgCell = Class("OpenGiftBoxChooseCell", UIControls.Child)

function OpenGiftBoxChooseDlgCell:ctor()
	self:initUI()
end

function OpenGiftBoxChooseDlgCell:initUI()
	self.btnConfirm = UIControls.Button(self, "BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirm)

	self.pickedImg = UIControls.Image(self, "SelectImage")
	self.selectedImg = UIControls.Image(self, "ImgSelect")
end

function OpenGiftBoxChooseDlgCell:onBtnConfirm()
	self.mParent:onChooseAward(self)
end

function OpenGiftBoxChooseDlgCell:setData(cellData)
	self.cellData = cellData
	self.itemID = cellData.itemID
	self.grids = {}

	ClientUtils.CreateBonusGrid(self, self.grids, "GridItem", cellData.award_id, true, nil, true)
	self:setVisible(true)
end

function OpenGiftBoxChooseDlgCell:setState(state)
	self.state = state

	self:refreshState()
end

function OpenGiftBoxChooseDlgCell:refreshState()
	local isGet = self.state == AwardState.Nml

	self.btnConfirm:setVisible(not isGet)

	for index, grid in pairs(self.grids) do
		grid:setState(isGet, isGet, isGet)
	end

	self.selectedImg:setVisible(isGet)
	self.pickedImg:setVisible(self.state == AwardState.Picked)
end

local strClassName = "OpenGiftBoxChooseDlg"
local OpenGiftBoxChooseDlg = Class(strClassName, UIControls.Window)

function OpenGiftBoxChooseDlg:ctor()
	self.itemPath = "BGPanel/ItemList/Content"
	self.itemPrefabPath = "System/Common/Grid/GridBoxAwardItem"
	self.selected = nil
	self.grids = {}

	self:initUI()
end

function OpenGiftBoxChooseDlg:initUI()
	self.panelBg = UIControls.Panel(self, "BGPanel")
	self.btnConfirm = UIControls.Button(self, "BGPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirm)

	self.txtTitle = UIControls.Label(self, "BGPanel/TextTitle")
	self.panelTimes = UIControls.Panel(self, "BGPanel/TextTime")
	self.txtTimes = UIControls.Label(self, "BGPanel/TextTime/Text")
	self.chooseGrids = {}
	self.textDesc = UIControls.Label(self, "BGPanel/BgTextDes/TextDes")
	self.panelDesc = UIControls.Panel(self, "BGPanel/BgTextDes")
end

function OpenGiftBoxChooseDlg:setData(data)
	if self.grids ~= nil then
		for key, grid in pairs(self.grids) do
			grid:destroy()
		end
	end

	self.items = data.items
	self.states = data.itemStates
	self.callback = data.callback

	self.txtTitle:setText(data.title)

	for index, item in ipairs(self.items) do
		local grid = OpenGiftBoxChooseDlgCell(self, self.itemPath, self.itemPrefabPath)

		grid:setData(item)
		table.insert(self.grids, grid)
	end

	for index, grid in ipairs(self.grids) do
		if self.states[index] then
			grid:setState(AwardState.Nml)
		else
			grid:setState(AwardState.Sel)
		end
	end
end

function OpenGiftBoxChooseDlg:checkBagEnough(item)
	if item.grids and #item.grids >= 1 then
		local itemType = item.grids[1].object.itemType

		if itemType == Const.ITEM_TYPE_HERO and CurAvatar:getHeroRemainBlankNum() <= 0 then
			CurAvatar:confirmBagAdd(Const.BAG_TYPE_HERO)

			return false
		end

		if itemType == Const.ITEM_TYPE_EQUIP and CurAvatar:getEquipRemainBlankNum() <= 0 then
			CurAvatar:confirmBagAdd(Const.BAG_TYPE_EQUIP)

			return false
		end

		if itemType == Const.ITEM_TYPE_ARTIFACT and CurAvatar:getArtifactRemainBlankNum() <= 0 then
			CurAvatar:confirmBagAdd(Const.BAG_TYPE_ARTIFACT)

			return false
		end

		if itemType == Const.ITEM_TYPE_PET_GEM and CurAvatar:getPetGemRemainBlankNum() <= 0 then
			CurAvatar:confirmBagAdd(Const.BAG_TYPE_PET_GEM)

			return false
		end
	end

	return true
end

function OpenGiftBoxChooseDlg:onBtnConfirm()
	if self.selected ~= nil then
		if self:checkBagEnough(self.selected) then
			self.callback(self.selected.cellData)
			self:setVisible(false)
		else
			self:setVisible(false)
		end
	else
		MsgManager.notice(Lang.get(30500))
	end
end

function OpenGiftBoxChooseDlg:onChooseAward(selected)
	if self.selected ~= nil then
		self.selected:setState(AwardState.Sel)
	end

	self.selected = selected

	selected:setState(AwardState.Picked)
end

function OpenGiftBoxChooseDlg:OnClose()
	OpenGiftBoxChooseDlg.super.OnClose(self)

	for index, item in ipairs(self.grids) do
		item:destroy()
	end

	self.selected = nil
end

return OpenGiftBoxChooseDlg
