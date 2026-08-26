-- chunkname: @modules/logic/versionactivity2_2/tianshinana/model/TianShiNaNaMapNodeCo.lua

module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaMapNodeCo", package.seeall)

local TianShiNaNaMapNodeCo = pureTable("TianShiNaNaMapNodeCo")

function TianShiNaNaMapNodeCo:init(node)
	self.x = node[1]
	self.y = node[2]
	self.nodeType = node[3]
	self.collapseRound = node[4]
	self.nodePath = node[5]
	self.walkable = node[6]
end

function TianShiNaNaMapNodeCo:isCollapse()
	if not self.collapseRound or self.collapseRound == 0 or self.collapseRound > TianShiNaNaModel.instance.nowRound then
		return false
	end

	return true
end

return TianShiNaNaMapNodeCo
