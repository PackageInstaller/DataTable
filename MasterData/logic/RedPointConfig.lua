-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redpoint/config/RedPointConfig.lua

module("logic.extensions.redpoint.config.RedPointConfig", package.seeall)

local RedPointConfig = class("RedPointConfig", BaseConfig)

function RedPointConfig:onInit()
	return
end

function RedPointConfig:onReset()
	return
end

function RedPointConfig:getNames()
	return {
		"redPoint"
	}
end

function RedPointConfig:handleConfig(name, content)
	if name == "redPoint" then
		self._cfgs = content
	end
end

function RedPointConfig:getCfgById(id)
	if self._cfgs then
		return self._cfgs[id]
	end

	return nil
end

RedPointConfig.instance = RedPointConfig.New()

return RedPointConfig
