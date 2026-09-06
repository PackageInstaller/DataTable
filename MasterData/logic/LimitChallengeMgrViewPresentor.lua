-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/limit/LimitChallengeMgrViewPresentor.lua

module("logic.extensions.legend.view.limit.LimitChallengeMgrViewPresentor", package.seeall)

local LimitChallengeMgrViewPresentor = class("LimitChallengeMgrViewPresentor", ViewPresentor)

function LimitChallengeMgrViewPresentor:ctor()
	LimitChallengeMgrViewPresentor.super.ctor(self)
end

function LimitChallengeMgrViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LimitChallengeMgrViewPresentor:dependWhatResources()
	return {
		"ui/views/legend/limit/limitchallengemgrview.prefab"
	}
end

function LimitChallengeMgrViewPresentor:getTempResources()
	local id = self:getFirstParam()
	local cfg = TimeLimitedConfig.instance:getCfgById(id)
	local result = {}

	if cfg and not string.nilorempty(cfg.viewName) then
		local url = "ui/views/legend/limit/" .. cfg.viewName .. ".prefab"

		table.insert(result, url)
	end

	return result
end

function LimitChallengeMgrViewPresentor:buildViews()
	return {
		LimitChallengeMgrView.New()
	}
end

return LimitChallengeMgrViewPresentor
