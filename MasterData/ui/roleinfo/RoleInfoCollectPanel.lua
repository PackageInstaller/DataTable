-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RoleInfo\\RoleInfoCollectPanel.lua

local ResHero = require("ClientData/ResHero")
local ResVowContent = require("ClientData/ResVowContent")
local UserData = require("Helper/UserData")
local strClassName = "CollectItem"
local CollectItem = Class(strClassName, UIControls.Child)
local REPLACE = 1
local SWITCH_REPLACE = 2
local SWITCH = 3
local SWITH_DEFAULT = 1
local SWITH_ALL = 2

function CollectItem:ctor()
	self:initUI()
end

function CollectItem:initUI()
	self.unHave = UIControls.Panel(self, "UnHave")
	self.btnHavePanel = UIControls.Button(self, "HavePanel")

	self.btnHavePanel:addEventClick(self.onHavePanelClick)

	self.icon = UIControls.Image(self, "HavePanel/Icon")
	self.efxSel = UIControls.Panel(self, "HavePanel/Icon/EfxSel")
	self.bgTextName = UIControls.Label(self, "HavePanel/BgTextName/TextName")
	self.btnSwitch = UIControls.Button(self, "HavePanel/BtnSwitch")

	self.btnSwitch:addEventClick(self.onSwitchClick)

	self.btnReplace = UIControls.Button(self, "HavePanel/BtnReplace")

	self.btnReplace:addEventClick(self.onReplaceClick)
end

function CollectItem:setItemData(data, isSwitch)
	if data then
		local heroId = data.HeroInfo.heroid
		local name = ResHero[heroId].hero_name

		self.bgTextName:setText(name)

		local signData = ResVowContent[heroId]

		self.icon:setImage(signData.sign_path, signData.sign_name)

		local panel = self.mParent.mParent

		if panel.curState == SWITH_ALL then
			self.btnReplace:setVisible(not isSwitch)
		else
			self.btnReplace:setVisible(false)
		end

		self:onSelectState(isSwitch)
	end

	self.data = data

	self.unHave:setVisible(not data)
	self.btnHavePanel:setVisible(not not data)
end

function CollectItem:onHavePanelClick()
	local panel = self.mParent.mParent

	if not panel.editState then
		return
	end

	if panel.curState ~= SWITH_ALL and panel.curIndex ~= self.data.Index then
		self.mParent.mParent:setSelectHero(self.data.Index)
		self:onSelectState(true)
	end
end

function CollectItem:onSwitchClick()
	local panel = self.mParent.mParent

	if panel.curState == SWITH_ALL then
		panel:setAllCellBtnState(SWITCH_REPLACE, false)
	else
		panel:setAllCellBtnState(REPLACE, true, self.data)
	end
end

function CollectItem:onReplaceClick()
	self.mParent.mParent:swithItem(self)
end

function CollectItem:onSelectState(isSwitch)
	self.btnSwitch:setVisible(isSwitch)
	self.efxSel:setVisible(isSwitch)
end

function CollectItem:setVisibleBtnByType(ctrBtnType, isShow)
	if ctrBtnType == SWITCH_REPLACE then
		self:onSelectState(isShow)
		self.btnReplace:setVisible(isShow)
	elseif ctrBtnType == REPLACE then
		self.btnReplace:setVisible(isShow)
	else
		self:onSelectState(isShow)
	end
end

local strClassName = "CollectCell"
local CollectCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function CollectCell:ctor()
	self:initUI()
end

function CollectCell:initUI()
	self.cellItems = {}

	for i = 1, 4 do
		self.cellItems[i] = CollectItem(self, nil, "System/PlayerInfor/CollectItem", 0, 0, true)
	end
end

function CollectCell:setCellData(datas, index)
	self.cellData = datas

	for i = 1, 4 do
		local curData = datas[i]

		if curData then
			self.cellItems[i]:setItemData(curData, index == curData.Index)
		else
			self.cellItems[i]:setItemData()
		end
	end
end

function CollectCell:setAllItemBtnState(ctrBtnType, isShow, exHeroId)
	if not self.cellData then
		return
	end

	for i, v in ipairs(self.cellData) do
		if v ~= exHeroId then
			self.cellItems[i]:setVisibleBtnByType(ctrBtnType, isShow)
		end
	end
end

function CollectCell:getItemByIndex(index)
	if not self.cellData then
		return
	end

	for i, v in ipairs(self.cellData) do
		if index and v.Index == index then
			return self.cellItems[i]
		end
	end
end

local strClassName = "RoleInfoCollectPanel"
local RoleInfoCollectPanel = Class(strClassName, UIControls.Panel)
local MINLINE = 2

function RoleInfoCollectPanel:ctor()
	self:initUI()
end

function RoleInfoCollectPanel:initUI()
	self.scrollCollect = UIControls.ScrollViewLoopV(self, self.mPath .. "/CollectListPanel", 0, self.onCollectCellChanged)

	self.scrollCollect:addEventValueChanged(self.onScrollValueChanged)

	self.arrowNext = UIControls.Panel(self, self.mPath .. "/CollectListPanel/ArrowNext")
	self.collects = {}

	UserData.saveCommonDataInt(CurAvatar.uid .. "new_vow_sign", 0)
	RedDotManager.setKeyState(UIConst.RD_HINT_SIGN, false)
end

function RoleInfoCollectPanel:setEditState(isCanEdit)
	self.editState = isCanEdit
end

function RoleInfoCollectPanel:setVowData(vow)
	self.vowList = vow

	local length = #self.vowList

	self.dataCount = length

	local count = math.ceil(length / 4)

	count = count > MINLINE and count or MINLINE

	self.scrollCollect:setTotalCount(count)

	if MINLINE > 2 then
		self.isScroll = true

		self.arrowNext:setVisible(true)
	end
end

function RoleInfoCollectPanel:setSelectHero(index)
	local curItem = self:getCollectItemByIndex(self.curIndex)

	if curItem then
		curItem:setVisibleBtnByType(SWITCH, false)
	end

	self.curIndex = index
end

function RoleInfoCollectPanel:setAllCellBtnState(ctrBtnType, isShow, exHeroId)
	self.curState = isShow and SWITH_ALL or SWITH_DEFAULT

	for i, cell in pairs(self.collects) do
		cell:setAllItemBtnState(ctrBtnType, isShow, exHeroId)
	end

	if ctrBtnType == SWITCH_REPLACE and not isShow then
		self.curIndex = nil
	end
end

function RoleInfoCollectPanel:getCollectItemByIndex(index)
	for i, cell in pairs(self.collects) do
		local curItem = cell:getItemByIndex(index)

		if curItem then
			return curItem
		end
	end
end

function RoleInfoCollectPanel:swithItem(newItem)
	self.newItem = newItem

	local oldData = self.vowList[self.curIndex]
	local newData = newItem.data.HeroInfo
	local swithVowMap = {}

	table.insert(swithVowMap, {
		index = oldData.index,
		heroid = newData.heroid
	})
	table.insert(swithVowMap, {
		index = newData.index,
		heroid = oldData.heroid
	})
	RPC.roleCommEditVowHero(swithVowMap)
end

function RoleInfoCollectPanel:refreshSignData()
	local newItem = self.newItem
	local newIndex = newItem.data.Index
	local oldData = self.vowList[self.curIndex]

	self.vowList[newIndex] = oldData

	local newData = newItem.data.HeroInfo

	self.vowList[self.curIndex] = newItem.data.HeroInfo
	self.vowList[newIndex].index = newIndex
	self.vowList[self.curIndex].index = self.curIndex

	local curItem = self:getCollectItemByIndex(self.curIndex)

	if curItem then
		curItem:setItemData(newItem.data)
	end

	newItem:setItemData({
		Index = self.curIndex,
		HeroInfo = oldData
	})
	self:setAllCellBtnState(SWITCH_REPLACE, false)
	self:refreshCellData()
end

function RoleInfoCollectPanel:onCollectCellChanged(sender, targetCell, newIndex)
	if targetCell == nil then
		targetCell = CollectCell(sender, "System/PlayerInfor/CollectCell", newIndex, 0, 0)
	else
		self.collects[targetCell.mIndex] = nil
		targetCell.mIndex = newIndex
	end

	self.collects[newIndex] = targetCell

	self:setTargetCellData(newIndex)
end

function RoleInfoCollectPanel:onScrollValueChanged()
	if not self.isScroll then
		return
	end

	local barValue = self.scrollCollect:getVerticalValue()

	if barValue == self.oldBarValue then
		return
	end

	self.oldBarValue = barValue

	if barValue == 1 then
		self.arrowNext:setVisible(false)
	else
		self.arrowNext:setVisible(true)
	end
end

function RoleInfoCollectPanel:setTargetCellData(newIndex)
	local curHeros = {}
	local endCount = newIndex * 4

	endCount = endCount < self.dataCount and endCount or self.dataCount

	for i = (newIndex - 1) * 4 + 1, endCount do
		table.insert(curHeros, {
			Index = i,
			HeroInfo = self.vowList[i]
		})
	end

	if next(curHeros) then
		self.collects[newIndex]:setCellData(curHeros, self.curIndex)
	end
end

function RoleInfoCollectPanel:refreshCellData()
	for index, v in pairs(self.collects) do
		self:setTargetCellData(index)
	end
end

return RoleInfoCollectPanel
