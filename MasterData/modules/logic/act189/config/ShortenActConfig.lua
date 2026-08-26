-- chunkname: @modules/logic/act189/config/ShortenActConfig.lua

module("modules.logic.act189.config.ShortenActConfig", package.seeall)

local sf = string.format
local ShortenActConfig = class("ShortenActConfig", BaseConfig)

function ShortenActConfig:reqConfigNames()
	return {
		"activity189_shortenact",
		"activity189_shortenact_style"
	}
end

function ShortenActConfig:onConfigLoaded(configName, configTable)
	if configName == "activity189_shortenact" then
		self:__init_activity189_shortenact(configTable)
	end
end

function ShortenActConfig:__init_activity189_shortenact(configTable)
	local sb

	if isDebugBuild then
		local source = sf("[logError] 189_运营改版活动.xlsx.xlsx - export_版本缩期活动_设置")

		sb = ConfigsCheckerMgr.instance:createStrBuf(source)
	end

	local version = GameBranchMgr.instance:VHyphenA()

	if not configTable.configList then
		local list = {}

		for i = #list, 1, -1 do
			local CO = list[i]

			if CO.version == version then
				self._setting = CO

				return
			end
		end

		if isDebugBuild then
			sb:appendLine(sf("%s版本未上线版本缩期运营活动", version))
			sb:logWarnIfGot()
		end

		self._setting = {
			activityId = 12607,
			style = 1
		}
	end
end

function ShortenActConfig:getSettingId()
	return self._setting.settingId
end

function ShortenActConfig:getSettingCO()
	return Activity189Config.instance:getSettingCO(self:getSettingId())
end

function ShortenActConfig:getActivityId()
	local activityId = self._setting.activityId

	if activityId then
		return activityId
	end

	local settingCO = self:getSettingCO()

	return settingCO.activityId
end

function ShortenActConfig:getStyleCO()
	return lua_activity189_shortenact_style.configDict[self._setting.style]
end

function ShortenActConfig:getBonusList()
	return Activity189Config.instance:getBonusList(self:getSettingId())
end

function ShortenActConfig:getTaskCO_ReadTask()
	return Activity189Config.instance:getTaskCO_ReadTask(self:getActivityId())
end

function ShortenActConfig:getTaskCO_ReadTask_Tag(eActivity189Enum_TaskTag)
	return Activity189Config.instance:getTaskCO_ReadTask_Tag(self:getActivityId(), eActivity189Enum_TaskTag)
end

function ShortenActConfig:getTaskCO_ReadTask_Tag_TaskId(eActivity189Enum_TaskTag, taskId)
	return Activity189Config.instance:getTaskCO_ReadTask_Tag(self:getActivityId(), eActivity189Enum_TaskTag, taskId)
end

ShortenActConfig.instance = ShortenActConfig.New()

return ShortenActConfig
