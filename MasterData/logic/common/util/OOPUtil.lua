-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/OOPUtil.lua

module("logic.common.util.OOPUtil", package.seeall)

local OOPUtil = {}

function OOPUtil.isInstanceOf(instance, class)
	local instanceClass = instance.class

	return OOPUtil.isChildClassOf(instanceClass, class)
end

function OOPUtil.isChildClassOf(childClass, parentClass)
	if childClass == parentClass then
		return true
	end

	local supers = rawget(childClass, "__supers")

	if not supers then
		return false
	end

	for _, super in ipairs(supers) do
		if OOPUtil.isChildClassOf(super, parentClass) then
			return true
		end
	end

	return false
end

function OOPUtil.getClassName(class)
	return class.__cname
end

return OOPUtil
