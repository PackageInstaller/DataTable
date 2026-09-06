-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkageintroduction/config/LinkageConfig.lua

module("logic.extensions.linkageintroduction.config.LinkageConfig", package.seeall)

local LinkageConfig = class("LinkageConfig", BaseConfig)

function LinkageConfig:onInit()
	LinkageConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function LinkageConfig:getNames()
	return {
		"linkageintroduction"
	}
end

function LinkageConfig:handleConfig(name, content)
	if name == "linkageintroduction" then
		self._linkageintroduction = content
	end
end

function LinkageConfig:getCfgById(id)
	return self._linkageintroduction[id]
end

function LinkageConfig:getCfgByTab(id, tabId)
	return self._linkageintroduction[id][tabId]
end

LinkageConfig.instance = LinkageConfig.New()

return LinkageConfig
