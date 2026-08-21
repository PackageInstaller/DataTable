-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/constconfig/GraphicTextConfig.lua

module("logic.extensions.common.constconfig.GraphicTextConfig", package.seeall)

local M = class("GraphicTextConfig", BaseConfig)

function M:onInit()
	self._cfgData = false
	self._cfgRegexText2IconMap = {}
end

function M:getNames()
	return {
		ConfigName.GraphicText
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.GraphicText then
		self._cfgData = content

		for _, v in pairs(self._cfgData.dataList) do
			self._cfgRegexText2IconMap[v.regexTxt] = v.name
		end
	end
end

function M:getInfo(id)
	return self._cfgData[id]
end

function M:getIconByRegexTxt(regexTxt)
	return self._cfgRegexText2IconMap[regexTxt] or regexTxt
end

M.instance = M.New()

return M
