-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\SocialShare.lua

local SocialShareCN = require("SDK/Plugin/Share/SocialShareCN")
local SocialShareJP = require("SDK/Plugin/Share/SocialShareJP")
local SocialShareTW = require("SDK/Plugin/Share/SocialShareTW")
local SocialShareKR = require("SDK/Plugin/Share/SocialShareKR")
local SocialShareSEA = require("SDK/Plugin/Share/SocialShareSEA")
local Analytics = require("SDK/Analytics")
local SocialShare = {}

function SocialShare.setStrategy(newStrategyNo)
	if RegionUtils.isCurrentRegion(RegionConst.REGION_CN) then
		SocialShare.shareImp = SocialShareCN.new()
	elseif RegionUtils.isCurrentRegion(RegionConst.REGION_JP) then
		SocialShare.shareImp = SocialShareJP.new()
	elseif RegionUtils.isCurrentRegion(RegionConst.REGION_TW) then
		SocialShare.shareImp = SocialShareTW.new()
	elseif RegionUtils.isCurrentRegion(RegionConst.REGION_KR) then
		SocialShare.shareImp = SocialShareKR.new()
	elseif RegionUtils.isSEA() then
		SocialShare.shareImp = SocialShareSEA()
	else
		SocialShare.shareImp = SocialShareCN.new()
	end

	SocialShare.shareImp:setStrategy(newStrategyNo)
end

function SocialShare.init(strategyNo)
	SocialShare.shareImp:init(strategyNo)
end

function SocialShare.getShareConfig()
	return SocialShare.shareImp:getShareConfig()
end

function SocialShare.getSharePlatforms()
	return SocialShare.shareImp:getSharePlatforms()
end

function SocialShare.getPhotoResolution()
	SocialShare.shareImp:getPhotoResolution()
end

function SocialShare.shareText(platform, title)
	SocialShare.shareImp:shareText(platform, title)
	Analytics.onShare(platform, nil)
end

function SocialShare.sharePicture(platform, picPath, text)
	SocialShare.shareImp:sharePicture(platform, picPath, text)
	Analytics.onShare(platform, nil)
end

function SocialShare.shareWebpage(platform, contentType, title, text, comment, url, imageUrl, picPath, enableEditor)
	SocialShare.shareImp:shareWebpage(platform, contentType, title, text, comment, url, imageUrl, picPath, enableEditor)
end

function SocialShare.shareVideo(platform, videoUrl, videoLocal)
	SocialShare.shareImp:shareVideo(platform, videoUrl, videoLocal)
end

function SocialShare.shareWebpageJson(platform, contentType, title, text, comment, url, imageUrl, picPath, enableEditor)
	SocialShare.shareImp:shareWebpageJson(platform, contentType, title, text, comment, url, imageUrl, picPath, enableEditor)
end

function SocialShare.onGetEvent(eventType, ret, arg1, arg2)
	SocialShare.shareImp:onGetEvent(eventType, ret, arg1, arg2)
end

function SocialShare.onShareFinish(ret, resultJson)
	SocialShare.shareImp:onShareFinish(ret, resultJson)
end

return SocialShare
