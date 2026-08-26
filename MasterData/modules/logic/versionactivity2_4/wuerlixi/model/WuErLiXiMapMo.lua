-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/model/WuErLiXiMapMo.lua

module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapMo", package.seeall)

local WuErLiXiMapMo = pureTable("WuErLiXiMapMo")

function WuErLiXiMapMo:ctor()
	self.mapId = 0
	self.mapOffset = {}
	self.actUnitDict = {}
	self.nodeDict = {}
end

function WuErLiXiMapMo:init(mapCo)
	self.mapId = tonumber(mapCo[1])
	self.mapOffset = mapCo[2]
	self.actUnitDict = self._toActUnits(mapCo[3])
	self.nodeDict = self._toNodes(mapCo[5])
	self.lineCount = self:_getLineCount()
	self.rowCount = self:_getRowCount()

	self:_setNodeUnits(mapCo[4])
end

function WuErLiXiMapMo._toActUnits(str)
	local dict = {}
	local actUnitCos = string.split(str, "|")

	for _, actUnitStr in ipairs(actUnitCos) do
		local actUnitMo = WuErLiXiMapActUnitMo.New()

		actUnitMo:init(actUnitStr)
		table.insert(dict, actUnitMo)
	end

	return dict
end

function WuErLiXiMapMo._toNodes(nodeCos)
	local dict = {}

	for _, node in ipairs(nodeCos) do
		local nodeMo = WuErLiXiMapNodeMo.New()

		nodeMo:init(node)

		dict[nodeMo.y] = dict[nodeMo.y] or {}
		dict[nodeMo.y][nodeMo.x] = nodeMo
	end

	return dict
end

function WuErLiXiMapMo:_setNodeUnits(unitCos)
	for _, unit in ipairs(unitCos) do
		self.nodeDict[unit[3]][unit[2]]:setUnit(unit)

		local unitMo = self.nodeDict[unit[3]][unit[2]]:getNodeUnit()

		if unitMo.unitType == WuErLiXiEnum.UnitType.SignalMulti then
			if unitMo.dir == WuErLiXiEnum.Dir.Up or unitMo.dir == WuErLiXiEnum.Dir.Down then
				self.nodeDict[unit[3]][unit[2] - 1]:setUnit(unit)
				self.nodeDict[unit[3]][unit[2] + 1]:setUnit(unit)
			else
				self.nodeDict[unit[3] - 1][unit[2]]:setUnit(unit)
				self.nodeDict[unit[3] + 1][unit[2]]:setUnit(unit)
			end
		end
	end
end

function WuErLiXiMapMo:_getLineCount()
	local count = 0

	for index, _ in pairs(self.nodeDict) do
		count = count < index and index or count
	end

	return count
end

function WuErLiXiMapMo:_getRowCount()
	local count = 0

	for index, _ in pairs(self.nodeDict[1]) do
		count = count < index and index or count
	end

	return count
end

function WuErLiXiMapMo:getNodeMo(x, y)
	if not self.nodeDict[x] then
		return
	end

	return self.nodeDict[x][y]
end

return WuErLiXiMapMo
