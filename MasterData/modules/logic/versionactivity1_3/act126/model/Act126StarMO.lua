-- chunkname: @modules/logic/versionactivity1_3/act126/model/Act126StarMO.lua

module("modules.logic.versionactivity1_3.act126.model.Act126StarMO", package.seeall)

local Act126StarMO = pureTable("Act126StarMO")

function Act126StarMO:init(info)
	self.starId = info.starId
	self.num = info.num
end

return Act126StarMO
