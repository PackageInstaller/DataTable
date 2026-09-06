-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/config/FriendConfig.lua

module("logic.extensions.friend.config.FriendConfig", package.seeall)

local FriendConfig = class("FriendConfig", BaseConfig)

function FriendConfig:onInit()
	self._maxCount = nil
	self._gainMaxCount = 0
end

function FriendConfig:getNames()
	return {
		"buddy_common_config",
		"good_evil_value",
		"fetter_common",
		"fetter_skip_time",
		"fetter_welfare",
		"fetter_type"
	}
end

function FriendConfig:handleConfig(name, content)
	if name == "buddy_common_config" then
		self._commonCfg = content

		self:_InitMaxCount(content.MAX_BUDDY_GROUP_COUNT.value)
	elseif name == "good_evil_value" then
		self._goodEvilCfg = content
	elseif name == "fetter_common" then
		self._fetterCommonCfgs = content
	elseif name == "fetter_skip_time" then
		self._skipTimeCfgs = content
	elseif name == "fetter_welfare" then
		self._fetterWelfareCfgs = content
	elseif name == "fetter_type" then
		self._fetteLimitCfgs = content
	end
end

function FriendConfig:getCommonValue(key, isToNumber)
	local str = ""

	if self._commonCfg and self._commonCfg[key] then
		str = self._commonCfg[key].value
	end

	if isToNumber then
		str = tonumber(str)
	end

	return str
end

function FriendConfig:_InitMaxCount(str)
	self._maxCount = string.splitToNumber(str, ",")
end

function FriendConfig:GetMaxCount(group)
	return self._maxCount[group] or 0
end

function FriendConfig:GetGainMaxCount()
	return self._gainMaxCount
end

function FriendConfig:GetGoodEvil()
	return self._goodEvilCfg.dataList
end

function FriendConfig:getFetterCommonValue(key)
	if self._fetterCommonCfgs[key] then
		return self._fetterCommonCfgs[key].value
	end
end

function FriendConfig:getFetterLimitByType(type)
	local cfg = self._fetteLimitCfgs[type]

	return cfg and cfg.dailyLimit
end

function FriendConfig:getSkipTimeByFetter(fetter)
	local curValue = checkint(fetter)
	local curSkipTime = 15

	for k, v in ipairs(self._skipTimeCfgs) do
		if curValue >= v.fetter then
			curSkipTime = v.skipTime
		end
	end

	return curSkipTime
end

function FriendConfig:getFetterWelfareCfgs()
	return self._fetterWelfareCfgs
end

FriendConfig.instance = FriendConfig.New()

return FriendConfig
