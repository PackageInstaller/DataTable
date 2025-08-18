-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\Share\\SocialShareBase.lua

local SocialShareBase = Class("SocialShareBase")
local SDKConst = require("SDK/SDKConst")

SocialShareBase.AttName = SDKConst.AttName

function SocialShareBase:ctor()
	return
end

function SocialShareBase:setStrategy(newStrategyNo)
	return
end

function SocialShareBase:init(strategyNo)
	return
end

function SocialShareBase:getShareConfig()
	return nil
end

function SocialShareBase:getSharePlatforms()
	return {}
end

function SocialShareBase:getPhotoResolution()
	return nil
end

function SocialShareBase:shareText(platform, title)
	return
end

function SocialShareBase:sharePicture(platform, picPath, text)
	return
end

function SocialShareBase:shareWebpage(platform, contentType, title, text, comment, url, imageUrl, picPath, enableEditor)
	return
end

function SocialShareBase:shareVideo(platform, videoUrl, videoLocal)
	return
end

function SocialShareBase:shareWebpageJson(platform, contentType, title, text, comment, url, imageUrl, picPath, enableEditor)
	return
end

function SocialShareBase:onGetEvent(eventType, ret, arg1, arg2)
	return
end

function SocialShareBase:onShareFinish(ret, resultJson)
	return
end

return SocialShareBase
