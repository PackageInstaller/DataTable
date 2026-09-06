-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/config/FormTeamConfig.lua

module("logic.extensions.formteam.config.FormTeamConfig", package.seeall)

local FormTeamConfig = class("FormTeamConfig", BaseConfig)

function FormTeamConfig:onInit()
	FormTeamConfig.super.onInit(self)
end

function FormTeamConfig:getNames()
	return {
		"form_team_type",
		"form_team_tier",
		"form_team_zdl_option",
		"form_team_common_config",
		"form_team_quick_chat",
		"fetter_team_buff"
	}
end

function FormTeamConfig:handleConfig(name, content)
	if name == "form_team_type" then
		self._tabCfgs = content
	elseif name == "form_team_tier" then
		self._groupCfgs = content
		self._teamCfgs = {}

		for k, v in ipairs(content.dataList) do
			self._teamCfgs[v.typeId] = self._teamCfgs[v.typeId] or {}
			self._teamCfgs[v.typeId][v.tier] = v
		end
	elseif name == "form_team_quick_chat" then
		self._qulickChatCfgs = content
	elseif name == "form_team_zdl_option" then
		self._ZDLOptionCfgs = content
	elseif name == "form_team_common_config" then
		self._commonCfgs = content
	elseif name == "fetter_team_buff" then
		self._fetterBuffCfgs = {}

		for k, v in ipairs(content.dataList) do
			self._fetterBuffCfgs[v.functionId] = self._fetterBuffCfgs[v.functionId] or {}

			table.insert(self._fetterBuffCfgs[v.functionId], v)
		end
	end
end

function FormTeamConfig:getTabCfgs()
	return self._tabCfgs
end

function FormTeamConfig:getTabCfgByTabId(tabId)
	return self._tabCfgs[tabId]
end

function FormTeamConfig:getTeamCfgByGroupId(groupId)
	return self._groupCfgs[groupId]
end

function FormTeamConfig:getTeamCfgsByTabId(tabId)
	return self._teamCfgs[tabId]
end

function FormTeamConfig:getZDLOptionCfgs()
	return self._ZDLOptionCfgs
end

function FormTeamConfig:getCommonValue(key)
	if self._commonCfgs[key] then
		return self._commonCfgs[key].value
	end
end

function FormTeamConfig:getChatCfgs()
	return self._qulickChatCfgs
end

function FormTeamConfig:getChatCfgById(chatId)
	return self._qulickChatCfgs[chatId]
end

function FormTeamConfig:getFetterBuffById(id)
	return self._fetterBuffCfgs[id]
end

FormTeamConfig.instance = FormTeamConfig.New()

return FormTeamConfig
