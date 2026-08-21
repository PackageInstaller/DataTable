-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\Share\\SocialShareTW.lua

local SocialShareBase = require("SDK/Plugin/Share/SocialShareBase")
local SocialShareTW = Class("SocialShareTW", SocialShareBase)
local SDKConst = require("SDK/SDKConst")
local AttName = SDKConst.AttName
local Platform = {
	TWITTER_WITH_CONTENT = 1101,
	FACEBOOK_WITH_CONTENT = 1001,
	TWITTER_WITH_IMAGE = 1102,
	FACEBOOK_WITH_IMAGE = 1002
}

function SocialShareTW:getShareConfig()
	local config = {
		[Platform.FACEBOOK_WITH_IMAGE] = {
			false
		},
		[Platform.TWITTER_WITH_IMAGE] = {
			true
		}
	}

	return config
end

function SocialShareTW:getSharePlatforms()
	local sharePlatforms = {}
	local platform1 = {
		spriteName = "BtnFacebook",
		filePath = "Atlas/ArAtlas",
		platform = Platform.FACEBOOK_WITH_IMAGE
	}

	table.insert(sharePlatforms, platform1)

	return sharePlatforms
end

function SocialShareTW:sharePicture(platform, picPath, text)
	local data = {}

	data[AttName.SHARE_ID] = platform
	data[AttName.SHARE_IMG_LOCAL_URL] = picPath
	text = text or Lang.get(30002)
	data[AttName.SHARE_INFO_CONTENT] = text

	SDKAgent.share(data)
end

function SocialShareTW:shareWebpage(platform, contentType, title, text, comment, url, imageUrl, picPath, enableEditor)
	local data = {}

	data[AttName.SHARE_ID] = platform
	data[AttName.SHARE_TARGET_URL] = url
	data[AttName.SHARE_INFO_CONTENT] = text

	SDKAgent.share(data)
end

function SocialShareTW:onShareFinish(ret, data)
	local result = tonumber(data[AttName.RESULT]) == 1
	local msg

	if result then
		msg = Lang.get(29999)
	else
		msg = Lang.get(30000)
	end

	MsgManager.notice(msg)
end

return SocialShareTW
