-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/core/decorator/AINot.lua

module("logic.extensions.ai.core.decorator.AINot", package.seeall)

local AINot = class("AINot", AIParentNode)

function AINot:ctor(context)
	AINot.super.ctor(self, context)
end

function AINot:onStart()
	AINot.super.onStart(self)

	return self:getFirstChild():onStart()
end

function AINot:onChildEnd(child)
	if child:getStatus() == AIConst.AIStatus.FAILD then
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	else
		return self:onEnd(AIConst.AIStatus.FAILD)
	end
end

function AINot:onReset()
	AINot.super.onReset(self)
end

function AINot:onReuse(context)
	AINot.super.onReuse(self, context)
end

function AINot:onRecycle()
	AINot.super.onRecycle(self)
end

function AINot:onDestroy()
	AINot.super.onDestroy(self)
end

return AINot
