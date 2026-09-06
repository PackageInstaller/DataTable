-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timecapsule/config/TimeCapsuleConfig.lua

module("logic.extensions.timecapsule.config.TimeCapsuleConfig", package.seeall)

local TimeCapsuleConfig = class("TimeCapsuleConfig", BaseConfig)

function TimeCapsuleConfig:onInit()
	TimeCapsuleConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function TimeCapsuleConfig:getNames()
	return {
		"time_capsule_progress_prize",
		"time_capsule_common",
		"time_capsule_note",
		"time_capsule_dialog"
	}
end

function TimeCapsuleConfig:handleConfig(name, content)
	if name == "time_capsule_progress_prize" then
		self._progress_prize = content
	elseif name == "time_capsule_common" then
		self._common = content
	elseif name == "time_capsule_note" then
		self._note = content
	elseif name == "time_capsule_dialog" then
		self._dialog = content
	end
end

function TimeCapsuleConfig:getProgressPrize()
	return self._progress_prize
end

function TimeCapsuleConfig:getProgressPrizeById(id)
	return self._progress_prize[id]
end

function TimeCapsuleConfig:getCommonValue(key)
	if self._common[key] then
		if not string.nilorempty(self._common[key].value2) then
			return self._common[key].value2
		else
			return self._common[key].value
		end
	end
end

function TimeCapsuleConfig:getNote()
	return self._note
end

function TimeCapsuleConfig:getNoteById(id)
	return self._note[id]
end

function TimeCapsuleConfig:getDialog()
	return self._dialog
end

TimeCapsuleConfig.instance = TimeCapsuleConfig.New()

return TimeCapsuleConfig
