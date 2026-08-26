-- chunkname: @modules/logic/prototest/core/ProtoTestMgr.lua

module("modules.logic.prototest.core.ProtoTestMgr", package.seeall)

local ProtoTestMgr = class("ProtoTestMgr")

function ProtoTestMgr:ctor()
	self.isShowFiles = false
	self._isRecording = false
	self._preSender = ProtoTestPreSender.New()

	LuaEventSystem.addEventMechanism(self)
end

function ProtoTestMgr:startRecord()
	self._isRecording = true

	LuaSocketMgr.instance:registerPreSender(self._preSender)
end

function ProtoTestMgr:endRecord()
	self._isRecording = false

	LuaSocketMgr.instance:unregisterPreSender(self._preSender)
end

function ProtoTestMgr:isRecording()
	return self._isRecording
end

function ProtoTestMgr:readFromFile(fileName)
	SLFramework.FileHelper.EnsureDir(ProtoFileHelper.DirPath)

	local fullPath = ProtoFileHelper.getFullPathByFileName(fileName)
	local jsonStr = SLFramework.FileHelper.ReadText(fullPath)
	local jsonTable = cjson.decode(jsonStr)
	local list = {}

	for _, paramJsonTable in ipairs(jsonTable) do
		local testCaseMO = ProtoTestCaseMO.New()

		testCaseMO:deserialize(paramJsonTable)
		table.insert(list, testCaseMO)
	end

	return list
end

function ProtoTestMgr:saveToFile(fileName, testCaseMOList)
	SLFramework.FileHelper.EnsureDir(ProtoFileHelper.DirPath)

	local fullPath = ProtoFileHelper.getFullPathByFileName(fileName)
	local tempList = {}

	for _, testCaseMO in ipairs(testCaseMOList) do
		table.insert(tempList, testCaseMO:serialize())
	end

	local jsonStr = cjson.encode(tempList)

	SLFramework.FileHelper.WriteTextToPath(fullPath, jsonStr)
end

ProtoTestMgr.instance = ProtoTestMgr.New()

return ProtoTestMgr
