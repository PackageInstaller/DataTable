-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\Share\\SocialShareJP.lua

local SDKConst = require("SDK/SDKConst")
local AttName = SDKConst.AttName
local Analytics = require("SDK/Analytics")
local SocialShareBase = require("SDK/Plugin/Share/SocialShareBase")
local DeviceHelper = require("Helper/DeviceHelper")
local VersionUtils = require("System/VersionUtils")
local SDKCore = require("SDK/SDKCore")
local SocialShareJP = Class("SocialShareJP", SocialShareBase)
local GMShareContentType = {
	GMShareContentTypeImage = 1,
	GMShareContentTypeWebPage = 3,
	GMShareContentTypeText = 0,
	GMShareContentTypeVideo = 4
}

SocialShareJP.sharePlatform = {
	GMUGShareSourceKakao = 12,
	GMUGShareSourceTiktok = 13,
	GMUGShareSourceLine = 11,
	GMUGShareSourceQQZone = 1,
	GMUGShareSourceWhatsApp = 10,
	GMUGShareSourceMessenger = 8,
	GMUGShareSourceWeChatTimeLine = 4,
	GMUGShareSourceWeChatFriend = 3,
	GMUGShareSourceInstagram = 9,
	GMUGShareSourceWeibo = 5,
	GMUGShareSourceSystem = 15,
	GMUGShareSourceFacebook = 7,
	GMUGShareSourceAweIM = 16,
	GMUGShareSourceNone = 0,
	GMUGShareSourceAwe = 6,
	GMUGShareSourceTwitter = 14,
	GMUGShareSourceQQFriend = 2
}

local idx2Platform = {
	"GMUGShareSourceNone",
	"GMUGShareSourceQQZone",
	"GMUGShareSourceQQFriend",
	"GMUGShareSourceWeChatFriend",
	"GMUGShareSourceWeChatTimeLine",
	"GMUGShareSourceWeibo",
	"GMUGShareSourceAwe",
	"GMUGShareSourceFacebook",
	"GMUGShareSourceMessenger",
	"GMUGShareSourceInstagram",
	"GMUGShareSourceWhatsApp",
	"GMUGShareSourceLine",
	"GMUGShareSourceKakao",
	"GMUGShareSourceTiktok",
	"GMUGShareSourceTwitter",
	"GMUGShareSourceSystem",
	"GMUGShareSourceAweIM"
}

function SocialShareJP:getShareConfig()
	return nil
end

function SocialShareJP:getSharePlatforms()
	local sharePlatforms = {}

	return sharePlatforms
end

function SocialShareJP:shareText(platform, title)
	local shareData = {}

	shareData[AttName.SHARE_TYPE] = GMShareContentType.GMShareContentTypeText
	shareData[AttName.SHARE_PLATFORM] = platform
	shareData[AttName.SHARE_INFO_TITLE] = title

	SDKAgent.share(shareData)
end

function SocialShareJP:sharePicture(platform, picPath, text)
	if VersionUtils.getEngineVersion() <= 152097 then
		local platformData = SDKCore.getPlatformData()

		if platformData and platformData.phone_model and string.find(platformData.phone_model, "iPad") then
			UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(8), "現在iPadでTwiiterへのシェアはサポートできない仕様となっております、スマートフォンにて操作してください。")

			return
		end
	end

	local shareData = {}

	shareData[AttName.SHARE_TYPE] = GMShareContentType.GMShareContentTypeImage
	shareData[AttName.SHARE_PLATFORM] = platform
	shareData[AttName.SHARE_IMG_LOCAL_URL] = picPath
	shareData[AttName.SHARE_INFO_TITLE] = text

	SDKAgent.share(shareData)
	self:sendByteShareLog(platform)
end

function SocialShareJP:sendByteShareLog(platform)
	if CurAvatar then
		local data = Analytics.getByteSendLogPubParameter()

		data.page_id = idx2Platform[platform + 1]

		Analytics.sendLogByted("page_flow", ClientUtils.table2String(data))
	end
end

function SocialShareJP:shareWebpage(platform, contentType, title, text, comment, url, imageUrl, picPath, enableEditor)
	local shareData = {}

	shareData[AttName.SHARE_TYPE] = GMShareContentType.GMShareContentTypeWebPage
	shareData[AttName.SHARE_PLATFORM] = platform
	shareData[AttName.SHARE_TARGET_URL] = url
	shareData[AttName.SHARE_INFO_CONTENT] = text
	shareData[AttName.SHARE_INFO_TITLE] = title

	SDKAgent.share(shareData)
end

function SocialShareJP:shareVideo(platform, videoUrl, videoLocal)
	local shareData = {}

	shareData[AttName.SHARE_TYPE] = GMShareContentType.GMShareContentTypeVideo
	shareData[AttName.SHARE_PLATFORM] = platform
	shareData[AttName.SHARE_VIDEO_LOCAL_URL] = videoLocal

	SDKAgent.share(shareData)
end

function SocialShareJP:onShareFinish(ret, data)
	if DeviceHelper.isIOS() then
		local result = tonumber(data[AttName.RESULT]) == 1
		local msg

		if result then
			msg = Lang.get(29999)
		else
			msg = Lang.get(30000)
		end

		MsgManager.notice(msg)
	elseif DeviceHelper.isAndroid() then
		local errorCode = tonumber(data.code)

		if VersionUtils.isOldVersionSDK_jp() then
			if errorCode == 10014 then
				errorCode = -410002
			elseif errorCode == 10000 then
				errorCode = 0
			end
		end

		if errorCode == 0 then
			MsgManager.notice(Lang.get(29999))
		elseif errorCode == -410002 then
			MsgManager.notice("シェア失敗しました。Twitterをインストールしてください。")
		else
			MsgManager.notice(Lang.get(30000))
		end
	end
end

return SocialShareJP
