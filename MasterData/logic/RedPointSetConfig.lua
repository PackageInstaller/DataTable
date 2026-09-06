-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemsetting/config/RedPointSetConfig.lua

module("logic.extensions.systemsetting.config.RedPointSetConfig", package.seeall)

local RedPointSetConfig = class("RedPointSetConfig", BaseConfig)

function RedPointSetConfig:onInit()
	RedPointSetConfig.super.onInit(self)
end

function RedPointSetConfig:getNames()
	return {
		"red_point_set_view",
		"red_point_set_command"
	}
end

function RedPointSetConfig:handleConfig(name, content)
	if name == "red_point_set_view" then
		self._rdsViewCfg = content
	elseif name == "red_point_set_command" then
		self._rdsCommandCfg = content

		self:_handleCommandCfgOfType(content.dataList)
		self:_handleCommandCfgOfHudParam(content.dataList)
	end
end

function RedPointSetConfig:getRdsViewDataList()
	return self._rdsViewCfg.dataList
end

function RedPointSetConfig:getRdsViewData(detailId)
	return self._rdsViewCfg[detailId]
end

function RedPointSetConfig:_handleCommandCfgOfType(dataList)
	self._rdsCommandCfgOfType = {}

	for _, data in ipairs(dataList) do
		if self._rdsCommandCfgOfType[data.commandType] == nil then
			self._rdsCommandCfgOfType[data.commandType] = {}
		end

		table.insert(self._rdsCommandCfgOfType[data.commandType], data)
	end
end

function RedPointSetConfig:_handleCommandCfgOfHudParam(dataList)
	self._rdsCommandCfgOfHudParam = {}

	for _, data in ipairs(dataList) do
		if data.commandType == RedPointSetEnum.CommandTypes_MainHud then
			if data.params then
				if not string.nilorempty(data.params) then
					if self._rdsCommandCfgOfHudParam[data.params] == nil then
						self._rdsCommandCfgOfHudParam[data.params] = {}
					end

					table.insert(self._rdsCommandCfgOfHudParam[data.params], data)
				end
			end
		end
	end
end

function RedPointSetConfig:getRdsCommandDataList()
	return self._rdsCommandCfg.dataList
end

function RedPointSetConfig:getRdsCommandDataListByType(commandType)
	return self._rdsCommandCfgOfType[commandType]
end

function RedPointSetConfig:getRdsCommandDataListByHudParam(mainuiArea)
	return self._rdsCommandCfgOfHudParam[mainuiArea]
end

function RedPointSetConfig:getRdsCommandData(commandId)
	return self._rdsCommandCfg[commandId]
end

RedPointSetConfig.instance = RedPointSetConfig.New()

return RedPointSetConfig
