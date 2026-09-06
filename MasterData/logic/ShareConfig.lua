-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/share/config/ShareConfig.lua

module("logic.extensions.share.config.ShareConfig", package.seeall)

local ShareConfig = class("ShareConfig", BaseConfig)

ShareConfig.DAILY = "daily"
ShareConfig.WEEKLY = "weekly"
ShareConfig.ALLTIME = "allTime"

function ShareConfig:onInit()
	ShareConfig.super.onInit(self)
end

function ShareConfig:getNames()
	return {
		"share_link"
	}
end

function ShareConfig:handleConfig(name, content)
	if name == "share_link" then
		self._share = content
	end
end

function ShareConfig:getShareById(id)
	id = checknumber(id)

	return self._share[id]
end

ShareConfig.instance = ShareConfig.New()

return ShareConfig
