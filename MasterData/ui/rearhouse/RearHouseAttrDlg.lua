-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseAttrDlg.lua

local RearHouseModelCenter = require("Logic/RearHouse/RearHouseModelCenter")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local RearHouseDragCenter = require("Logic/RearHouse/RearHouseDragCenter")
local ResColor = require("ClientData/ResColor")
local GridHouseAttrCell = require("UI/RearHouse/GridHouseAttrCell")
local HouseAttrDescCell = Class("HouseAttrDescCell", UIControls.Child)

function HouseAttrDescCell:ctor(...)
	self:initUI()
end

function HouseAttrDescCell:initUI(...)
	self.txtAttr = UIControls.Label(self, "TextAttr")
	self.txtNum = UIControls.Label(self, "TextNum")
	self.imgBg = UIControls.Image(self, "")
end

function HouseAttrDescCell:setData(info)
	self.txtAttr:setText(info.desc)
	self.txtNum:setText(string.format(Lang.get(30671), info.num))
end

function HouseAttrDescCell:setValid(isValid)
	if isValid then
		self.txtAttr:setFontColor(ResColor.ORANGEBTN)
		self.txtNum:setFontColor(ResColor.ORANGEBTN)
		self.imgBg:setImage("Atlas/BackyardAtlas/BackyardAtlas", "BgGetBottom")
	else
		self.txtAttr:setFontColor(ResColor.GREYLIGHT)
		self.txtNum:setFontColor(ResColor.GREYLIGHT)
		self.imgBg:setImage("Atlas/BackyardAtlas/BackyardAtlas", "BgGrey")
	end
end

local SINGLE_DESC_HEIGHT = 26
local SUIT_DESC_HEIGHT = 46
local HouseAttrCell = Class("HouseAttrCell", UIControls.ScrollViewLoopCell)

function HouseAttrCell:ctor(...)
	self:initUI()
end

function HouseAttrCell:initUI(...)
	self.txtRule = UIControls.Label(self, "BgRule/TextRule")
	self.panelSingle = UIControls.Panel(self, "SinglePanel")
	self.panelSuit = UIControls.Panel(self, "SuitPanel")
	self.gridCellsSingle = {}
	self.gridCellsMore = {}
	self.descCells = {}
end

function HouseAttrCell:setData(wrapData)
	local data = wrapData.baseData
	local height = 0
	local descNum = 0

	if wrapData.single == true then
		self.panelSingle:setVisible(true)
		self.panelSuit:setVisible(false)
		self.txtRule:setText(Lang.get(30544))
		table.sort(data, function(v1, v2)
			local id1, id2 = v1.model_ids[1], v2.model_ids[1]

			if self.mWindow.putedMap[id1] == self.mWindow.putedMap[id2] then
				if RearHouseModelCenter.isInMode(Const.REARHOUSE_CREATE_MODE.MINE) then
					local own1 = CurAvatar:getItemNumById(id1)
					local own2 = CurAvatar:getItemNumById(id2)

					if own1 > 0 and own2 > 0 or own1 == own2 then
						return id1 < id2
					else
						return own1 > 0
					end
				else
					return id1 < id2
				end
			else
				return not self.mWindow.putedMap[id2]
			end
		end)

		for i = 1, math.max(#data, #self.gridCellsSingle) do
			local cell = self.gridCellsSingle[i]

			if data[i] then
				if not cell then
					cell = GridHouseAttrCell(self, "SinglePanel", "System/Backyard/GridFurnitureAttr")

					table.insert(self.gridCellsSingle, cell)
				end

				cell:setVisible(true)
				cell:setData(data[i].model_ids[1])
				cell:setHouseMode(self.mWindow.putedMap, RearHouseModelCenter.isInMode(Const.REARHOUSE_CREATE_MODE.MINE))

				cell.clickCallBack = self.mWindow.slotItemClick
				descNum = math.max(descNum, cell:getDescNum())
			elseif cell then
				cell:setVisible(false)
			end
		end

		height = SINGLE_DESC_HEIGHT * (descNum - 1) + 314
	else
		self.panelSingle:setVisible(false)
		self.panelSuit:setVisible(true)
		self.txtRule:setText(Lang.get(30672))

		local _ids = utils.copyTable(data.model_ids)

		table.sort(_ids, function(v1, v2)
			if self.mWindow.putedMap[v1] == self.mWindow.putedMap[v2] then
				if RearHouseModelCenter.isInMode(Const.REARHOUSE_CREATE_MODE.MINE) then
					local own1 = CurAvatar:getItemNumById(v1)
					local own2 = CurAvatar:getItemNumById(v2)

					if own1 > 0 and own2 > 0 or own1 == own2 then
						return v1 < v2
					else
						return own1 > 0
					end
				else
					return v1 < v2
				end
			else
				return not self.mWindow.putedMap[v2]
			end
		end)

		for i = 1, math.max(#_ids, #self.gridCellsMore) do
			local cell = self.gridCellsMore[i]

			if _ids[i] then
				if not cell then
					cell = GridHouseAttrCell(self, "SuitPanel/FurniturePanel", "System/Backyard/GridFurnitureAttr")

					table.insert(self.gridCellsMore, cell)
				end

				cell:setVisible(true)
				cell:setData(_ids[i])
				cell:setHouseMode(self.mWindow.putedMap, RearHouseModelCenter.isInMode(Const.REARHOUSE_CREATE_MODE.MINE))

				cell.clickCallBack = self.mWindow.slotItemClick
			elseif cell then
				cell:setVisible(false)
			end
		end

		local effectNumInfos = RearHouseCommon.getSuitAttrDescs(data)

		if effectNumInfos then
			descNum = #effectNumInfos

			for i = 1, math.max(#effectNumInfos, #self.descCells) do
				local cell = self.descCells[i]

				if effectNumInfos[i] then
					if not cell then
						cell = HouseAttrDescCell(self, "SuitPanel/SuitAttrPanel", "System/Backyard/FurnitureSuitAttrCell")

						table.insert(self.descCells, cell)
					end

					cell:setVisible(true)
					cell:setData(effectNumInfos[i])

					local valid = effectNumInfos[i].num <= self.mWindow:getValidAttrNum(data)

					cell:setValid(valid)
				elseif cell then
					cell:setVisible(false)
				end
			end
		end

		height = (math.ceil(descNum * 0.5) - 1) * SUIT_DESC_HEIGHT + 324
	end

	self:setLayoutSize(nil, height)
end

local strClassName = "RearHouseAttrDlg"
local RearHouseAttrDlg = Class(strClassName, UIControls.Window)

function RearHouseAttrDlg:ctor(...)
	self:initUI()
end

function RearHouseAttrDlg:initUI(...)
	self.scrollView = UIControls.ScrollViewLoopV(self, "Bg/AttrList", 0, self.onCellChanged)
	self.slotItemClick = Slot(self.onFurnitureItemCilck, self)
end

function RearHouseAttrDlg:onOpen(...)
	RearHouseAttrDlg.super.onOpen(self)
	self:show()
end

function RearHouseAttrDlg:show(...)
	self:_initOwnMap()

	local singleAttrInfos = RearHouseCommon.getCurSingleAttrInfos()
	local curSuitAttrInfos = RearHouseCommon.getCurSuitAttrInfos()

	self.datas = {}

	for _, infos in pairs(singleAttrInfos) do
		table.insert(self.datas, {
			single = true,
			baseData = infos
		})
	end

	for _, info in ipairs(curSuitAttrInfos) do
		table.insert(self.datas, {
			baseData = info
		})
	end

	self.scrollView:setTotalCount(#self.datas)
end

function RearHouseAttrDlg:_initOwnMap(...)
	local houseData = RearHouseModelCenter.getCurShowData()

	self.putedMap = RearHouseCommon.getFurniturePutedMap(houseData)
end

function RearHouseAttrDlg:getValidAttrNum(attrInfo)
	local count = 0

	for i, mid in ipairs(attrInfo.model_ids) do
		if self.putedMap[mid] then
			count = count + 1
		end
	end

	return count
end

function RearHouseAttrDlg:onFurnitureItemCilck(mid)
	if not self.putedMap[mid] and RearHouseModelCenter.isInMode(Const.REARHOUSE_CREATE_MODE.MINE) and CurAvatar:getItemNumById(mid) > 0 then
		local result, wallIndex = RearHouseCommon.canPut(mid)

		if result then
			local function yesFunc(...)
				local curIndex = RearHouseDragCenter.getCurZoneId()

				if curIndex ~= wallIndex then
					local state = GameFsm.getState(Const.STATE_MAIN_REAR_HOUSE)

					if state then
						state:changeWall(wallIndex, true)
					end

					coroutine.start(function(...)
						coroutine.wait(0.8)
						UIManager.getUI("rearHouseEditDlg", true):jumpToMid(mid)
					end)
				else
					UIManager.getUI("rearHouseEditDlg", true):jumpToMid(mid)
				end

				self:setVisible(false)
			end

			local content = Lang.get(30673)

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, yesFunc, nil, nil)
		end
	elseif not self.putedMap[mid] then
		UIManager.getUI("itemTips"):showObj(self, BaseObject.GetObject(mid), {
			CloseSrcWindow = 1,
			AutoOpenGuide = 1
		})
	end
end

function RearHouseAttrDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = HouseAttrCell(sender, "System/Backyard/FurnitureAttrPanel", newIdx, 0, 0)
	end

	targetCell.index = newIdx

	targetCell:setData(self.datas[newIdx])
end

return RearHouseAttrDlg
