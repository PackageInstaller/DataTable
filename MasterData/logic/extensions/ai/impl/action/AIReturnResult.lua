-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AIReturnResult.lua

module("logic.extensions.ai.impl.action.AIReturnResult", package.seeall)

local AIReturnResult = class("AIReturnResult", AINode)

function AIReturnResult:ctor(context)
	AIReturnResult.super.ctor(self, context)

	self._resut = AIConst.AIStatus.FAILD
end

function AIReturnResult:onStart()
	AIReturnResult.super.onStart(self)

	return self:onEnd(self._resut)
end

function AIReturnResult:onRecycle()
	AIReturnResult.super.onRecycle(self)

	self._resut = AIConst.AIStatus.FAILD
end

function AIReturnResult:onDestroy()
	AIReturnResult.super.onDestroy(self)

	self._resut = nil
end

function AIReturnResult:initFromConfig(aiConfigData)
	AIReturnResult.super.initFromConfig(self, aiConfigData)

	self._resut = aiConfigData.isSucc and AIConst.AIStatus.SUCCESS or AIConst.AIStatus.FAILD
end

return AIReturnResult
