-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/social/view/SocialPresentor.lua

module("logic.extensions.social.view.SocialPresentor", package.seeall)

local SocialPresentor = class("SocialPresentor", ViewPresentor)

function SocialPresentor:ctor()
	SocialPresentor.super.ctor(self)
end

function SocialPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SocialPresentor:dependWhatResources()
	return {
		"ui/views/mail/mailview.prefab"
	}
end

function SocialPresentor:buildViews()
	local views = {}
	local view = NewMailView.New()

	table.insert(views, view)

	return views
end

return SocialPresentor
