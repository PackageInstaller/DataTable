-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/test/Debug.lua

module("logic.extensions.test.Debug", package.seeall)

local testModules = {}
local testExtensionIds = {}
local testPattern = {}
local saveModelDatas = {}
local excludeFile = {
	["logic.extensions.test.Debug"] = true
}
local excludePattern = {
	"UIDUtil"
}
local includeFile = {
	"logic.extensions.test.TestActivity"
}

local function isInExcludePattern(value)
	for i, v in ipairs(excludePattern) do
		if string.gsub(value, v, "") ~= value then
			return true
		end
	end

	return false
end

local function subString(str, k)
	local ts = string.reverse(str)
	local a, i = string.find(ts, k)

	return string.sub(str, -(i - 1))
end

local function clearPackage(key)
	package.loaded[key] = nil

	local reverseStr = subString(key, "%.")

	if reverseStr then
		_G.module_tables[reverseStr] = nil

		setglobal(reverseStr, nil)

		for n, m in pairs(_G.module_tables) do
			if rawget(m, reverseStr) then
				m[reverseStr] = nil
			end
		end
	end

	print("reload: ", key, reverseStr)
end

function reloadLua()
	for _, v in ipairs(testModules) do
		ViewMgr.instance:close(v)

		ViewMgr.instance._views[v] = nil
	end

	local cloneTempData = {}

	for k, v in pairs(saveModelDatas) do
		if v.getData and v:getData() then
			cloneTempData[k] = clone(v:getData())
		end
	end

	for k, v in pairs(testExtensionIds) do
		ExtensionMgr.instance:_resetExtension(v)
	end

	for k, v in pairs(package.loaded) do
		for _, pattern in ipairs(testPattern) do
			if not excludeFile[k] and not isInExcludePattern(k) and string.find(k, pattern) then
				clearPackage(k)

				break
			end
		end
	end

	for k, v in ipairs(includeFile) do
		LuaResLoader.ReplaceLuaScript(v)
		clearPackage(v)
	end

	for k, v in pairs(testExtensionIds) do
		ExtensionMgr.instance:_initExtension(v)
		ExtensionMgr.instance:_lateInitExtension(v)
	end

	for k, v in pairs(saveModelDatas) do
		if v.setData then
			v:setData(cloneTempData[k])
		end
	end

	TestActivity.create()
end
