-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/SmallLuyngardeMainView.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.SmallLuyngardeMainView", package.seeall)

local SmallLuyngardeMainView = class("SmallLuyngardeMainView", SkslmainView)

function SmallLuyngardeMainView:ctor()
	SmallLuyngardeMainView.super.ctor(self)
end

function SmallLuyngardeMainView:unbindEvents()
	SmallLuyngardeMainView.super.unbindEvents(self)
end

function SmallLuyngardeMainView:bindEvents()
	SmallLuyngardeMainView.super.bindEvents(self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "luyinjiademainview_rule")
	end, self)
end

function SmallLuyngardeMainView:_getActivityId()
	return ShikongshenglongController.instance:getActivityId(ShikongshenglongModel.SLYJDChallenge)
end

function SmallLuyngardeMainView:_getPetRaceId()
	return 15033
end

function SmallLuyngardeMainView:_getDifficultyView()
	return ViewName.SmallluyngardedifficultyView
end

return SmallLuyngardeMainView
