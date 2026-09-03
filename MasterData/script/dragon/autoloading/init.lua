-- chunkname: @/tmp/or_script/lua_compile/dragon/autoloading/init.lua

if not _G.DRAGON_ENABLE_AUTOLOADING then
	return
end

local _G = _G
local require = require
local rawget = rawget
local setmetatable = setmetatable

local function debuglog(...)
	return
end

local pcall = pcall

module(...)

if not _G.DRAGON_AUTOLOADING_CONFIG then
	local config_module = "autoloading_config"
	local autoloading_config

	pcall(function()
		autoloading_config = require(config_module)
	end)

	if autoloading_config == nil and _PACKAGE ~= "" then
		pcall(function()
			autoloading_config = require(_PACKAGE .. config_module)
		end)
	end

	if autoloading_config == nil then
		return
	end

	local __loadingvars = {}

	setmetatable(_G, {
		__index = function(t, name)
			if __loadingvars[name] == true then
				debuglog(name .. " is in loading")

				return nil
			end

			local varinfo = autoloading_config[name]

			if not varinfo then
				return nil
			end

			__loadingvars[name] = true

			debuglog("try loading " .. name .. " from '" .. varinfo.url .. "'")
			require(varinfo.url)

			__loadingvars[name] = nil

			return rawget(t, name)
		end
	})
end
