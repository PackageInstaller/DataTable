-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AILog.lua

module("logic.extensions.ai.impl.action.AILog", package.seeall)

local AILog = class("AILog", AINode)

function AILog:ctor(context)
	AILog.super.ctor(self, context)

	self._logConent = ""
	self._isLogWarn = false
end

function AILog:initFromConfig(aiConfigData)
	AILog.super.initFromConfig(self, aiConfigData)

	self._logConent = aiConfigData.content
	self._isLogWarn = aiConfigData.isLogWarn
end

function AILog:onStart()
	AILog.super.onStart(self)

	if self._isLogWarn then
		printWarn("[ai log]", self._logConent)
	else
		print("[ai log]", self._logConent)
	end

	return self:onEnd(AIConst.AIStatus.SUCCESS)
end

function AILog:onRecycle()
	AILog.super.onRecycle(self)

	self._logConent = ""
	self._isLogWarn = false
end

function AILog:onDestroy()
	AILog.super.onDestroy(self)

	self._logConent = nil
	self._isLogWarn = nil
end

return AILog
