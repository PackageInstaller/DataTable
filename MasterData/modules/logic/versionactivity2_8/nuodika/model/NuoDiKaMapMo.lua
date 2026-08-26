-- chunkname: @modules/logic/versionactivity2_8/nuodika/model/NuoDiKaMapMo.lua

module("modules.logic.versionactivity2_8.nuodika.model.NuoDiKaMapMo", package.seeall)

local NuoDiKaMapMo = pureTable("NuoDiKaMapMo")

function NuoDiKaMapMo:ctor()
	self.mapId = 0
	self.lineCount = 0
	self.rowCount = 0
	self.passType = NuoDiKaEnum.MapPassType.ClearEnemy
	self.mapBg = ""
	self.nodeDict = {}
end

function NuoDiKaMapMo:init(mapCo)
	self.mapId = mapCo[1]
	self.lineCount = mapCo[2]
	self.rowCount = mapCo[3]
	self.taskValue = mapCo[4]
	self.passType = mapCo[5]
	self.mapBg = mapCo[6]
	self.nodeDict = self._toNodes(mapCo[7])
end

function NuoDiKaMapMo._toNodes(nodeCos)
	local dict = {}

	for _, node in ipairs(nodeCos) do
		local nodeMo = NuoDiKaMapNodeMo.New()

		nodeMo:init(node)

		dict[nodeMo.id] = nodeMo
	end

	table.sort(dict, function(a, b)
		return a.id < b.id
	end)

	return dict
end

function NuoDiKaMapMo:getNodeMo(id)
	if not self.nodeDict[id] then
		return
	end

	return self.nodeDict[id]
end

return NuoDiKaMapMo
