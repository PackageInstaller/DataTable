-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/InvitationcardViewPresentor.lua

module("logic.extensions.activitypopup.view.InvitationcardViewPresentor", package.seeall)

local InvitationcardViewPresentor = class("InvitationcardViewPresentor", ViewPresentor)

function InvitationcardViewPresentor:ctor()
	InvitationcardViewPresentor.super.ctor(self)
end

function InvitationcardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function InvitationcardViewPresentor:dependWhatResources()
	self.activityId = checknumber(self:getOpenParam()[1])

	if self.activityId == 17003 then
		return {
			"ui/views/activitypopup/invitationcardnuoyaview.prefab"
		}
	else
		return {
			"ui/views/activitypopup/invitationcardview.prefab"
		}
	end
end

function InvitationcardViewPresentor:buildViews()
	return {
		InvitationCardView.New()
	}
end

return InvitationcardViewPresentor
