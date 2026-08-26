-- chunkname: @modules/logic/social/config/SocialConfig.lua

module("modules.logic.social.config.SocialConfig", package.seeall)

local SocialConfig = class("SocialConfig", BaseConfig)

function SocialConfig:ctor()
	return
end

function SocialConfig:reqConfigNames()
	return {
		"chat_check"
	}
end

function SocialConfig:onConfigLoaded(configName, configTable)
	return
end

function SocialConfig:getSocialMessageFields()
	return {
		portrait = 5,
		recipientId = 9,
		senderId = 3,
		msgType = 10,
		sendTime = 7,
		channelType = 2,
		content = 6,
		extData = 11,
		senderName = 4,
		msgId = 1,
		level = 8
	}
end

function SocialConfig:getMessageUnreadKey()
	local playerInfo = PlayerModel.instance:getPlayinfo()

	return (string.format("%s&userId=%s", PlayerPrefsKey.SocialMessageUnread, playerInfo.userId))
end

function SocialConfig:getSocialMessagesKey(channelType, id)
	local playerInfo = PlayerModel.instance:getPlayinfo()

	return (string.format("%s&userId=%s&channelType=%s&id=%s", PlayerPrefsKey.SocialMessage, playerInfo.userId, channelType, id))
end

function SocialConfig:getStatusText(time)
	time = tonumber(time)

	if time == 0 then
		return luaLang("social_online")
	else
		local leftSec = ServerTime.now() - time / 1000
		local day = math.floor(leftSec / TimeUtil.OneDaySecond)

		if day >= 1 then
			return string.format(luaLang("time_lastday"), day)
		else
			local hour = math.max(1, math.floor(leftSec / TimeUtil.OneHourSecond))

			return string.format(luaLang("time_lasthour"), hour)
		end
	end
end

function SocialConfig:getRequestTimeText(time)
	time = tonumber(time)
	time = time / 1000

	if time == 0 then
		return string.format("<color=#008c00>%s</color>", luaLang("social_recent"))
	else
		local nowTime = ServerTime.now()
		local diffTime = nowTime - time

		if diffTime < TimeUtil.OneHourSecond then
			return string.format("<color=#008c00>%s</color>", luaLang("social_recent"))
		elseif diffTime < TimeUtil.OneDaySecond then
			local hour = diffTime / TimeUtil.OneHourSecond

			return string.format(luaLang("time_lasthour"), math.max(math.floor(hour), 1))
		else
			local day = diffTime / TimeUtil.OneDaySecond

			return string.format(luaLang("time_lastday"), math.floor(day))
		end
	end
end

function SocialConfig:getMaxFriendsCount()
	return CommonConfig.instance:getConstNum(ConstEnum.SocialMaxFriendsCount)
end

function SocialConfig:getMaxRequestCount()
	return CommonConfig.instance:getConstNum(ConstEnum.SocialMaxRequestCount)
end

function SocialConfig:getMaxBlackListCount()
	return CommonConfig.instance:getConstNum(ConstEnum.SocialMaxBlackListCount)
end

function SocialConfig:isMsgViolation(msg)
	for _, co in ipairs(lua_chat_check.configList) do
		if string.find(msg, co.value, 1, true) then
			return true
		end
	end

	return false
end

SocialConfig.instance = SocialConfig.New()

return SocialConfig
