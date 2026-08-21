-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/datadef/extend/SignAmountExtend.lua

module("logic.common.datadef.extend.SignAmountExtend", package.seeall)

local SignAmountExtend = {}

function SignAmountExtend.extend()
	return
end

function SignalAmount:addUnique(key)
	if not self:hasKey(key) then
		self:add(key)
	end
end

function SignalAmount:setKeyEnable(key, enable)
	if enable then
		self:addUnique(key)
	else
		self:remove(key)
	end
end

return SignAmountExtend
