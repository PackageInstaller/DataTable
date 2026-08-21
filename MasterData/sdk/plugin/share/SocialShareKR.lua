-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\Share\\SocialShareKR.lua

local DeviceHelper = require("Helper/DeviceHelper")
local SocialShareBase = require("SDK/Plugin/Share/SocialShareBase")
local SocialShareKR = Class("SocialShareKR", SocialShareBase)
local SDKAppUtils = require("SDK/SDKAppUtils")
local SDKConst = require("SDK/SDKConst")
local AttName = SDKConst.AttName
local VersionUtils = require("System/VersionUtils")
local Platform = {
	TWITTER_WITH_CONTENT = 1101,
	FACEBOOK_WITH_CONTENT = 1001,
	TWITTER_WITH_IMAGE = 1102,
	FACEBOOK_WITH_IMAGE = 1002
}

function SocialShareKR:getShareConfig()
	local config = {
		[Platform.FACEBOOK_WITH_IMAGE] = {
			false
		},
		[Platform.TWITTER_WITH_IMAGE] = {
			false
		}
	}

	return config
end

function SocialShareKR:getSharePlatforms()
	local sharePlatforms = {}

	return sharePlatforms
end

function SocialShareKR:sharePicture(platform, picPath, text)
	local data = {}

	data[AttName.SHARE_ID] = platform
	data[AttName.SHARE_IMG_LOCAL_URL] = picPath
	text = text or " "
	data[AttName.SHARE_INFO_CONTENT] = text

	SDKAgent.share(data)
end

function SocialShareKR:shareWebpage(platform, contentType, title, text, comment, url, imageUrl, picPath, enableEditor)
	local data = {}

	data[AttName.SHARE_ID] = platform
	data[AttName.SHARE_TARGET_URL] = url
	data[AttName.SHARE_INFO_CONTENT] = text

	SDKAgent.share(data)
end

function SocialShareKR:onShareFinish(ret, data)
	local result = tonumber(data[AttName.RESULT]) == 1
	local msg

	if result then
		msg = Lang.get(29999)
	else
		msg = Lang.get(30000)

		if DeviceHelper.isIOS() then
			local reason = ClientUtils.string2Table(data[AttName.REASON])

			if reason then
				local code = reason.code

				if code then
					code = tonumber(code)

					if code == -201 then
						msg = "공유 취소"
					elseif code == -202 then
						msg = "Facebook을 먼저 다운 받아주세요."
					end
				end
			end
		end
	end

	MsgManager.notice(msg)
end

return SocialShareKR
