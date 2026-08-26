-- chunkname: @modules/logic/rouge/model/RougeNewReddotNOMO.lua

module("modules.logic.rouge.model.RougeNewReddotNOMO", package.seeall)

local RougeNewReddotNOMO = pureTable("RougeNewReddotNOMO")

function RougeNewReddotNOMO:init(info)
	self.type = info.type
	self.idNum = #info.ids
	self.idMap = {}

	for i, v in ipairs(info.ids) do
		self.idMap[v] = v
	end
end

function RougeNewReddotNOMO:removeId(id)
	if id == 0 then
		self.idMap = {}
		self.idNum = 0
	end

	if self.idMap[id] then
		self.idMap[id] = nil
		self.idNum = self.idNum - 1
	end
end

return RougeNewReddotNOMO
