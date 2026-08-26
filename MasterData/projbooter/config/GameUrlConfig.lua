-- chunkname: @projbooter/config/GameUrlConfig.lua

module("projbooter.config.GameUrlConfig", package.seeall)

local GameUrlConfig = _M

GameUrlConfig.ServerType = {
	Develop = 1,
	OutDevelop = 2,
	OutRelease = 4,
	OutExperience = 5,
	OutPreview = 3
}

function GameUrlConfig.getLoginUrls(bak)
	local curConfig = UrlConfig.getConfig()
	local review = VersionValidator.instance:isInReviewing()
	local httpLoginUrl

	if review then
		httpLoginUrl = bak and curConfig.loginReviewBackup or curConfig.loginReview
	end

	if bak then
		if not curConfig.loginBackup then
			do
				local httpLoginUrlInfo = curConfig.login

				if type(httpLoginUrlInfo) == "table" then
					local channelId = tostring(SDKMgr.instance:getChannelId()) or "100"

					httpLoginUrl = httpLoginUrlInfo[channelId]

					if not httpLoginUrlInfo[channelId] then
						for cid, url in pairs(httpLoginUrlInfo) do
							httpLoginUrl = url

							logError(string.format("httpLoginUrl not exist, bak=%s, channelId=%s\nuse %s:%s", bak and "true" or "false", channelId, cid, url or "nil"))

							break
						end
					end
				else
					httpLoginUrl = httpLoginUrlInfo
				end
			end

			local getSessionIdUrl = httpLoginUrl .. "/login0.jsp"
			local httpWebLoginUrl = httpLoginUrl .. "/login.jsp"
			local getServerListUrl = httpLoginUrl .. "/loadzone.jsp"
			local startGameUrl = httpLoginUrl .. "/startgame.jsp"

			return httpLoginUrl, getSessionIdUrl, httpWebLoginUrl, getServerListUrl, startGameUrl
		end
	end
end

function GameUrlConfig.getHotUpdateUrl()
	local curConfig = UrlConfig.getConfig()

	return curConfig.hotUpdate, curConfig.hotUpdateBackup
end

function GameUrlConfig.getOptionalUpdateUrl()
	local curConfig = UrlConfig.getConfig()

	return curConfig.optionalUpdate, curConfig.optionalUpdateBackup
end

function GameUrlConfig.getMassHotUpdateUrl()
	local curConfig = UrlConfig.getConfig()

	return curConfig.massHotUpdate, curConfig.massHotUpdateBackup
end

function GameUrlConfig.getNoticeUrl()
	local curConfig = UrlConfig.getConfig()

	return curConfig.notice
end

function GameUrlConfig.getLogReportUrl()
	local curConfig = UrlConfig.getConfig()

	return curConfig.logReport
end

return GameUrlConfig
