-- chunkname: @modules/logic/rouge/map/model/rpcmo/RougeMapInfoMO.lua

module("modules.logic.rouge.map.model.rpcmo.RougeMapInfoMO", package.seeall)

local RougeMapInfoMO = pureTable("RougeMapInfoMO")

function RougeMapInfoMO:init(info)
	self.mapType = info.mapType
	self.layerId = info.layerId
	self.middleLayerId = info.middleLayerId
	self.curStage = info.curStage
	self.curNode = info.curNode
	self.nodeInfo = GameUtil.rpcInfosToList(info.nodeInfo, RougeNodeInfoMO)
	self.skillInfo = GameUtil.rpcInfosToList(info.mapSkill, RougeMapSkillMO)
end

return RougeMapInfoMO
