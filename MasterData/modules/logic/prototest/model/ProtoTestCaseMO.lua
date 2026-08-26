-- chunkname: @modules/logic/prototest/model/ProtoTestCaseMO.lua

module("modules.logic.prototest.model.ProtoTestCaseMO", package.seeall)

local ProtoTestCaseMO = pureTable("ProtoTestCaseMO")

function ProtoTestCaseMO:ctor()
	self.cmd = nil
	self.time = nil
	self.struct = nil
	self.value = nil
end

function ProtoTestCaseMO:initFromProto(cmd, protoMsg)
	self.cmd = cmd
	self.time = ServerTime.now()
	self.struct = protoMsg.__cname
	self.value = ProtoParamHelper.buildProtoParamsByProto(protoMsg)
end

function ProtoTestCaseMO:initFromJson(jsonTable)
	return
end

function ProtoTestCaseMO:clone()
	local mo = ProtoTestCaseMO.New()

	mo.cmd = self.cmd
	mo.time = ServerTime.now()
	mo.struct = self.struct
	mo.value = {}

	for _, paramMO in ipairs(self.value) do
		table.insert(mo.value, paramMO:clone())
	end

	return mo
end

function ProtoTestCaseMO:buildProtoMsg()
	local moduleCmd = LuaSocketMgr.instance:getCmdSetting(self.cmd)

	if not moduleCmd then
		logError("module not exist, cmd = " .. self.cmd)

		return
	end

	local pbName = moduleCmd[1] .. "Module_pb"
	local pbTable = getGlobal(pbName) or addGlobalModule("modules.proto." .. pbName, pbName)

	if not pbTable then
		logError(string.format("pb not exist: %s.%s", pbName, self.struct))

		return
	end

	local msgStruct = pbTable[self.struct]
	local protoMsg = msgStruct()

	for _, paramMO in ipairs(self.value) do
		paramMO:fillProtoMsg(protoMsg)
	end

	return protoMsg
end

function ProtoTestCaseMO:serialize()
	local jsonTable = {}

	jsonTable.cmd = self.cmd
	jsonTable.time = self.time
	jsonTable.struct = self.struct
	jsonTable.value = {}

	for _, paramMO in ipairs(self.value) do
		table.insert(jsonTable.value, paramMO:serialize())
	end

	return jsonTable
end

function ProtoTestCaseMO:deserialize(jsonTable)
	self.cmd = jsonTable.cmd
	self.time = jsonTable.time
	self.struct = jsonTable.struct
	self.value = {}

	for _, paramJsonTable in ipairs(jsonTable.value) do
		local paramMO = ProtoTestCaseParamMO.New()

		paramMO:deserialize(paramJsonTable)
		table.insert(self.value, paramMO)
	end
end

return ProtoTestCaseMO
