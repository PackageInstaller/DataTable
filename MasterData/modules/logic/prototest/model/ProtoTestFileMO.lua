-- chunkname: @modules/logic/prototest/model/ProtoTestFileMO.lua

module("modules.logic.prototest.model.ProtoTestFileMO", package.seeall)

local ProtoTestFileMO = pureTable("ProtoTestFileMO")

function ProtoTestFileMO:ctor()
	self.id = nil
	self.fileName = nil
	self.filePath = nil
end

return ProtoTestFileMO
