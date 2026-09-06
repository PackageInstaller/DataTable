-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/publicity/PublicityMainConfig.lua

module("logic.extensions.publicity.PublicityMainConfig", package.seeall)

local PublicityMainConfig = class("PublicityMainConfig", BaseConfig)

function PublicityMainConfig:onInit()
	PublicityMainConfig.super.onInit(self)

	self._allTableCfgs = nil
	self._allTaskCfgs = nil
end

function PublicityMainConfig:getNames()
	return {
		"publicity_view_table",
		"publicity_view_task"
	}
end

function PublicityMainConfig:handleConfig(name, content)
	if name == "publicity_view_table" then
		self._allTableCfgs = content
	elseif name == "publicity_view_task" then
		self._allTaskCfgs = content
	end
end

function PublicityMainConfig:getAllPublicityTableCfgs()
	return self._allTableCfgs
end

function PublicityMainConfig:getPublicityTableCfg(tabId)
	tabId = checknumber(tabId)

	if self._allTableCfgs == nil or self._allTableCfgs[tabId] == nil then
		return nil
	end

	return self._allTableCfgs[tabId]
end

function PublicityMainConfig:getPublicityTaskCfgs(planId)
	planId = checknumber(planId)

	if self._allTaskCfgs == nil or self._allTaskCfgs[planId] == nil then
		return nil
	end

	return self._allTaskCfgs[planId]
end

PublicityMainConfig.instance = PublicityMainConfig.New()

return PublicityMainConfig
