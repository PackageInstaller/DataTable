-- chunkname: @modules/logic/sodache/model/rpcmo/SodachePanelMo.lua

module("modules.logic.sodache.model.rpcmo.SodachePanelMo", package.seeall)

local SodachePanelMo = pureTable("SodachePanelMo")

function SodachePanelMo:init(data)
	self.uid = data.uid
	self.type = data.type
	self.unitUid = data.unitUid
	self.options = data.options
	self.selectLinkIds = data.selectLinkIds

	local arr = GameUtil.splitString2(data.optionId2result, true, "&", ":") or {}

	self.optionId2result = {}

	for i, v in ipairs(arr) do
		self.optionId2result[v[1]] = v[2]
	end

	if self._unitMo and self._unitMo.uid ~= self.unitUid then
		self._unitMo = nil
	end

	self.isClose = false
end

function SodachePanelMo:getUnitMo()
	if not self._unitMo then
		local insideMo = SodacheModel.instance:getInsideMo()

		self._unitMo = insideMo.unitBox.unitsMap[self.unitUid]
	end

	return self._unitMo
end

function SodachePanelMo:clear()
	self.uid = "0"
	self.type = 0
	self.unitUid = "0"
	self.options = {}
	self.isClose = true
end

return SodachePanelMo
