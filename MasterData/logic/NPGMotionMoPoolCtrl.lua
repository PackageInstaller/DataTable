-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/data/NPGMotionMoPoolCtrl.lua

module("logic.extensions.numberpuzzlegame.view.data.NPGMotionMoPoolCtrl", package.seeall)

local NPGMotionMoPoolCtrl = class("NPGMotionMoPoolCtrl")

function NPGMotionMoPoolCtrl:ctor()
	self._moPool = self:_creatMoPool()
	self._motionRecords = {}
end

function NPGMotionMoPoolCtrl:onReset()
	self:clearAllMotionRecord()
	self._moPool:clear()
end

function NPGMotionMoPoolCtrl:onDestroy()
	self._motionRecords = nil
	self._moPool = nil
end

function NPGMotionMoPoolCtrl:getMotionCount(recordId)
	return (self._motionRecords[recordId] or nil) and #self._motionRecords[recordId]
end

function NPGMotionMoPoolCtrl:getMotionRecord(recordId)
	return self._motionRecords[recordId]
end

function NPGMotionMoPoolCtrl:getMotionMo(recordId, motionId)
	if self._motionRecords[recordId] == nil then
		self._motionRecords[recordId] = {}
	end

	if self._motionRecords[recordId][motionId] == nil then
		local mo = self:fetchFmtMo()

		mo:onInit(recordId, motionId)

		self._motionRecords[recordId][motionId] = mo
	end

	return self._motionRecords[recordId][motionId]
end

function NPGMotionMoPoolCtrl:clearMotionMo(recordId, motionId)
	if self._motionRecords[recordId] then
		if self._motionRecords[recordId] then
			self:returnFmtMo(self._motionRecords[recordId])

			self._motionRecords[recordId][motionId] = nil
		end
	end
end

function NPGMotionMoPoolCtrl:clearMotionRecord(recordId)
	if self._motionRecords[recordId] == nil then
		return
	end

	for _, motionMo in pairs(self._motionRecords[recordId]) do
		self:clearMotionMo(motionMo:getRecordId(), motionMo:getMotionId())
	end

	self._motionRecords[recordId] = nil
end

function NPGMotionMoPoolCtrl:clearAllMotionRecord()
	for recordId, _ in pairs(self._motionRecords) do
		self:clearMotionRecord(recordId)
	end
end

function NPGMotionMoPoolCtrl:fetchFmtMo()
	return self._moPool:fetchObject()
end

function NPGMotionMoPoolCtrl:returnFmtMo(mo)
	self._moPool:returnObject(mo)
end

function NPGMotionMoPoolCtrl:_creatMoPool()
	local function createFunc()
		return NPGMotionMo.New()
	end

	local function disposeFunc(obj)
		obj:onDispose()
	end

	local function resetFunc(obj)
		obj:onReset()
	end

	return ObjectPool.New(200, createFunc, disposeFunc, resetFunc)
end

return NPGMotionMoPoolCtrl
