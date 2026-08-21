-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/config/multiple_drop/MultipleDropConfig.lua

module("logic.extensions.welfare.config.multiple_drop.MultipleDropConfig", package.seeall)

local M = class("MultipleDropConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.MultipleDrop
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.MultipleDrop then
		self._content = content
	end
end

function M:getInfoByCode(code)
	return self._content[code]
end

M.instance = M.New()

return M
