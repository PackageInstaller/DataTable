-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroShowRoomInfoPanel.lua

local MAX_SCALE = 1.3
local MIN_SCALE = 0.8
local GridHeroShowRoom = require("UI/Hero/GridHeroShowRoom")
local ShowRoomLineItem = require("UI/Hero/ShowRoomLineItem")
local ShowRoomTeamItem = require("UI/Hero/ShowRoomTeamItem")
local ResRoomGroupShow = require("ClientData/ResRoomGroupShow")
local strClassName = "HeroShowRoomInfoPanel"
local HeroShowRoomInfoPanel = Class(strClassName, UIControls.Child)

function HeroShowRoomInfoPanel:ctor()
	self:initUI()
end

function HeroShowRoomInfoPanel:initUI()
	self.heroCells = {}
	self.lineItemList = {}
	self.groupItemList = {}
	self.groupLineList = {}
	self.panelDrag = UIControls.DragClickPanel(self, "ScrollMainInfoPanel/Content/HeroPanel/DragBg")

	self.panelDrag:setPinchFunc(Slot(self.onPinchFunc, self))

	self.panelContent = UIControls.Panel(self, "ScrollMainInfoPanel/Content")
	self.panelHero = UIControls.Panel(self, "ScrollMainInfoPanel/Content/HeroPanel")
end

function HeroShowRoomInfoPanel:onPinchFunc(delta)
	local scaleAdd = delta.x * 10
	local curScale = self.panelContent:getScale()
	local finalScale = math.min(curScale.x + scaleAdd, MAX_SCALE)

	finalScale = math.max(finalScale, MIN_SCALE)

	self.panelContent:setScaleXYZ(finalScale, finalScale, curScale.z)
end

function HeroShowRoomInfoPanel:refreshHintShow()
	if self.heroCells then
		for _, heroCell in pairs(self.heroCells) do
			heroCell:refreshHintShow()
		end
	end
end

local POS_RELATED = {
	{
		-1,
		1
	},
	{
		0,
		1
	},
	{
		1,
		1
	},
	{
		-1,
		0
	},
	{
		1,
		0
	},
	{
		-1,
		-1
	},
	{
		0,
		-1
	},
	{
		1,
		-1
	}
}

function HeroShowRoomInfoPanel:setRoomHeros(roomHeros)
	self.roomHeros = roomHeros
	self.roomHeroDic = {}
	self.roomGroup = {}

	for idx, hero in ipairs(self.roomHeros) do
		if not self.heroCells[idx] then
			self.heroCells[idx] = GridHeroShowRoom(self, "ScrollMainInfoPanel/Content/HeroPanel", "System/HeroShowRoom/GridHeroShowRoom", 0, 0, true)
		end

		self.heroCells[idx]:setRoomHero(hero)

		self.roomHeroDic[hero.id] = self.heroCells[idx]

		if hero.roomInfo.group_id then
			if not self.roomGroup[hero.roomInfo.group_id] then
				self.roomGroup[hero.roomInfo.group_id] = {}
			end

			table.insert(self.roomGroup[hero.roomInfo.group_id], self.heroCells[idx])
		end
	end

	for i = #self.roomHeros + 1, #self.heroCells do
		self.heroCells[i]:destroy()

		self.heroCells[i] = nil
	end

	self.lineItemInfo = {}

	for hero_id, gridHero in pairs(self.roomHeroDic) do
		if gridHero.roomHero.roomInfo.relate_hero_ids then
			for idx, heroId in ipairs(gridHero.roomHero.roomInfo.relate_hero_ids) do
				if self.roomHeroDic[heroId] and gridHero.roomHero.roomInfo.relate_desc and gridHero.roomHero.roomInfo.relate_desc[idx] and gridHero.roomHero.roomInfo.start_pos and gridHero.roomHero.roomInfo.end_pos then
					local pos1 = gridHero:getPosition()
					local pos2 = self.roomHeroDic[heroId]:getPosition()
					local startPosIdx = gridHero.roomHero.roomInfo.start_pos[idx]
					local endPosIdx = gridHero.roomHero.roomInfo.end_pos[idx]
					local size = gridHero:getRectSize()
					local newPos1 = {
						x = pos1.x + size.width / 2 * POS_RELATED[startPosIdx][1],
						y = pos1.y + size.height / 2 * POS_RELATED[startPosIdx][2]
					}
					local newPos2 = {
						x = pos2.x + size.width / 2 * POS_RELATED[endPosIdx][1],
						y = pos2.y + size.height / 2 * POS_RELATED[endPosIdx][2]
					}
					local distance = utils.getDistance2D(newPos1.x, newPos1.y, newPos2.x, newPos2.y)
					local linedesc = gridHero.roomHero.roomInfo.relate_desc[idx]
					local position = {
						(newPos1.x + newPos2.x) / 2,
						(newPos1.y + newPos2.y) / 2
					}
					local angel = 0
					local highPos, lowPos

					if newPos1.y > newPos2.y then
						highPos = newPos1
						lowPos = newPos2
					elseif newPos1.y < newPos2.y then
						highPos = newPos2
						lowPos = newPos1
					end

					if highPos and lowPos then
						angel = math.deg(math.asin(math.abs(highPos.y - lowPos.y) / distance))

						if highPos.x <= lowPos.x and newPos1.y < newPos2.y then
							angel = -angel
						end
					end

					if gridHero.roomHero.roomInfo.two_way[idx] == 0 and newPos1.x < newPos2.x then
						angel = angel - 180
					end

					local relationTxtVisible = self.roomHeroDic[heroId].roomHero.isGeted and gridHero.roomHero.isGeted

					table.insert(self.lineItemInfo, {
						dis = distance,
						desc = linedesc,
						rotate = angel,
						pos = position,
						txtVisible = relationTxtVisible,
						twoWay = gridHero.roomHero.roomInfo.two_way[idx]
					})
				end
			end
		end
	end

	for i, itemInfo in ipairs(self.lineItemInfo) do
		if not self.lineItemList[i] then
			self.lineItemList[i] = ShowRoomLineItem(self, "ScrollMainInfoPanel/Content/LinePanel", "System/HeroShowRoom/ShowRoomLineItem", 0, 0, true)
		end

		self.lineItemList[i]:setLineItemInfo(itemInfo)
	end

	for i = #self.lineItemInfo + 1, #self.lineItemList do
		self.lineItemList[i]:destroy()

		self.lineItemList[i] = nil
	end

	self.groupItemInfo = {}

	for i, group in pairs(self.roomGroup or {}) do
		local minX, minY, maxX, maxY, gridSize

		for j, gridHero in pairs(group or {}) do
			local pos = gridHero:getPosition()

			gridSize = gridSize or gridHero:getRectSize()

			if not minX or minX > pos.x then
				minX = pos.x
			end

			if not minY or minY > pos.y then
				minY = pos.y
			end

			if not maxX or maxX < pos.x then
				maxX = pos.x
			end

			if not maxY or maxY < pos.y then
				maxY = pos.y
			end
		end

		local leftX = minX - gridSize.width / 2 - 16
		local leftY = maxY + gridSize.height / 2 + 16
		local rightX = maxX + gridSize.width / 2 + 16
		local rightY = minY - gridSize.height / 2 - 16
		local position = {
			x = (leftX + rightX) / 2,
			y = (leftY + rightY) / 2
		}
		local size = {
			width = math.abs(rightX - leftX),
			height = math.abs(rightY - leftY)
		}
		local title = ResRoomGroupShow[i] and ResRoomGroupShow[i].group or ""

		table.insert(self.groupItemInfo, {
			pos = position,
			size = size,
			title = title,
			groupId = i
		})
	end

	self.groupItemDic = {}

	for i, groupItem in ipairs(self.groupItemInfo or {}) do
		if not self.groupItemList[i] then
			self.groupItemList[i] = ShowRoomTeamItem(self, "ScrollMainInfoPanel/Content/TeamPanel", "System/HeroShowRoom/ShowRoomTeamItem", 0, 0, true)
		end

		self.groupItemList[i]:setGroupItemInfo(groupItem)

		self.groupItemDic[groupItem.groupId] = groupItem
	end

	for i = #self.groupItemInfo + 1, #self.groupItemList do
		self.groupItemList[i]:destroy()

		self.groupItemList[i] = nil
	end

	self.groupLineInfo = {}

	for i, group in pairs(self.groupItemDic or {}) do
		if ResRoomGroupShow[group.groupId] and ResRoomGroupShow[group.groupId].relate_group_id then
			for idx, related_id in pairs(ResRoomGroupShow[group.groupId].relate_group_id) do
				if self.groupItemDic[related_id] then
					local pos1 = group.pos
					local pos2 = self.groupItemDic[related_id].pos
					local startPosIdx = ResRoomGroupShow[group.groupId].start_pos[idx]
					local endPosIdx = ResRoomGroupShow[group.groupId].end_pos[idx]
					local size1 = group.size
					local size2 = self.groupItemDic[related_id].size
					local newPos1 = {
						x = pos1.x + size1.width / 2 * POS_RELATED[startPosIdx][1],
						y = pos1.y + size1.height / 2 * POS_RELATED[startPosIdx][2]
					}
					local newPos2 = {
						x = pos2.x + size2.width / 2 * POS_RELATED[endPosIdx][1],
						y = pos2.y + size2.height / 2 * POS_RELATED[endPosIdx][2]
					}
					local distance = utils.getDistance2D(newPos1.x, newPos1.y, newPos2.x, newPos2.y)
					local linedesc = ResRoomGroupShow[group.groupId].relate_desc[idx]
					local position = {
						(newPos1.x + newPos2.x) / 2,
						(newPos1.y + newPos2.y) / 2
					}
					local angel = 0
					local highPos, lowPos

					if newPos1.y > newPos2.y then
						highPos = newPos1
						lowPos = newPos2
					elseif newPos1.y < newPos2.y then
						highPos = newPos2
						lowPos = newPos1
					end

					if highPos and lowPos then
						angel = math.deg(math.asin(math.abs(highPos.y - lowPos.y) / distance))

						if highPos.x < lowPos.x then
							angel = -angel
						end
					end

					if ResRoomGroupShow[group.groupId].two_way[idx] == 0 and newPos1.x < newPos2.x then
						angel = angel - 180
					end

					table.insert(self.groupLineInfo, {
						dis = distance,
						desc = linedesc,
						rotate = angel,
						pos = position,
						twoWay = ResRoomGroupShow[group.groupId].two_way[idx]
					})
				end
			end
		end
	end

	for i, itemInfo in ipairs(self.groupLineInfo) do
		if not self.groupLineList[i] then
			self.groupLineList[i] = ShowRoomLineItem(self, "ScrollMainInfoPanel/Content/LinePanel", "System/HeroShowRoom/ShowRoomLineItem", 0, 0, true)
		end

		self.groupLineList[i]:setLineItemInfo(itemInfo, true)
	end

	for i = #self.groupLineInfo + 1, #self.groupLineList do
		self.groupLineList[i]:destroy()

		self.groupLineList[i] = nil
	end
end

function HeroShowRoomInfoPanel:revertOriShowStatus()
	self.panelContent:setScale(0.85)
	self.panelContent:setPosition(0, 0)
end

function HeroShowRoomInfoPanel:showAndHideLine(isShow)
	for _, line in pairs(self.lineItemList or {}) do
		line:setVisible(isShow)
	end

	for _, line in pairs(self.groupLineList or {}) do
		line:setVisible(isShow)
	end
end

return HeroShowRoomInfoPanel
