-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/data/NPGMotionMo.lua

module("logic.extensions.numberpuzzlegame.view.data.NPGMotionMo", package.seeall)

local NPGMotionMo = class("NPGMotionMo")

function NPGMotionMo:ctor()
	self:onReset()
end

function NPGMotionMo:onDispose()
	return
end

function NPGMotionMo:onReset()
	self._recordId = nil
	self._motionId = nil
	self._motionType = nil
	self._param = nil
end

function NPGMotionMo:onInit(recordId, motionId)
	self._recordId = recordId
	self._motionId = motionId
end

function NPGMotionMo:getRecordId()
	return self._recordId
end

function NPGMotionMo:getMotionId()
	return self._motionId
end

function NPGMotionMo:getMotionType()
	return self._motionType
end

function NPGMotionMo:getParam()
	return self._param
end

function NPGMotionMo:setParam(motionType, param)
	self._motionType = motionType
	self._param = param
end

return NPGMotionMo
