-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\PanelSuitFurniture.lua

local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local GridHouseAttrCell = require("UI/RearHouse/GridHouseAttrCell")
local strClassName = "PanelSuitFurniture"
local PanelSuitFurniture = Class(strClassName, UIControls.Child)

function PanelSuitFurniture:ctor(...)
	self:initUI()
end

function PanelSuitFurniture:initUI(...)
	self.txtRule = UIControls.Label(self, "TextRule")
	self.txtSuitAttrs = {}

	for i = 1, 3 do
		local path = "AttrPanel/SuitAttr" .. i
		local panel = UIControls.Panel(self, path)
		local txtNum = UIControls.Label(self, path .. "/TextNum")
		local txtAttr = UIControls.Label(self, path .. "/TextAttr")

		table.insert(self.txtSuitAttrs, {
			panel,
			txtNum,
			txtAttr
		})
	end

	self.gridCells = {}
end

function PanelSuitFurniture:setData(mid)
	local data = RearHouseCommon.getAttrInfoByMid(mid)
	local _ids = utils.copyTable(data.model_ids)
	local putedMap = RearHouseCommon.getFurniturePutedMap()
	local ownMap = {}
	local totalOwnNum = 0

	for _, mid in ipairs(_ids) do
		ownMap[mid] = CurAvatar:getItemNumById(mid)
		totalOwnNum = totalOwnNum + ownMap[mid]
	end

	table.sort(_ids, function(v1, v2)
		if putedMap[v1] == putedMap[v2] then
			local own1 = ownMap[v1]
			local own2 = ownMap[v2]

			if own1 > 0 and own2 > 0 or own1 == own2 then
				return v1 < v2
			else
				return own1 > 0
			end
		else
			return not putedMap[v2]
		end
	end)

	for i = 1, math.max(#_ids, #self.gridCells) do
		local cell = self.gridCells[i]

		if _ids[i] then
			if not cell then
				cell = GridHouseAttrCell(self, "FurniturePanel/GridPanel", "System/Backyard/GridFurnitureAttr")

				table.insert(self.gridCells, cell)
			end

			cell:setVisible(true)
			cell:setData(_ids[i])
			cell:setShopMode(ownMap)
		elseif cell then
			cell:setVisible(false)
		end
	end

	self.txtRule:setText(string.format(Lang.get(30545), totalOwnNum))

	local effectNumInfos = RearHouseCommon.getSuitAttrDescs(data)

	if effectNumInfos then
		for i = 1, math.max(#effectNumInfos, #self.txtSuitAttrs) do
			local child = self.txtSuitAttrs[i]

			if effectNumInfos[i] then
				child[1]:setVisible(true)
				child[2]:setText(string.format(Lang.get(30546), effectNumInfos[i].num))
				child[3]:setText(effectNumInfos[i].desc)
			elseif child then
				child[1]:setVisible(false)
			end
		end
	end
end

return PanelSuitFurniture
