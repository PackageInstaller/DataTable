-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timeserverpetgain/view/ZhiHuiJiaZuHudViewPresentor.lua

module("logic.extensions.timeserverpetgain.view.ZhiHuiJiaZuHudViewPresentor", package.seeall)

local ZhiHuiJiaZuHudViewPresentor = class("ZhiHuiJiaZuHudViewPresentor", ViewPresentor)

function ZhiHuiJiaZuHudViewPresentor:ctor()
	ZhiHuiJiaZuHudViewPresentor.super.ctor(self)
end

function ZhiHuiJiaZuHudViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZhiHuiJiaZuHudViewPresentor:dependWhatResources()
	local key = self.viewName
	local data = OperationSummaryConfig.instance:getSummaryStartUpData(key)

	if data == nil then
		printError(string.format("key错误,无法读到正确配置.( key = %s )", key))
	end

	local viewprefab = data.viewPrefab

	return {
		"ui/views/operationsummary/" .. viewprefab .. ".prefab"
	}
end

function ZhiHuiJiaZuHudViewPresentor:buildViews()
	return {
		ZhiHuiJiaZuHudView.New()
	}
end

return ZhiHuiJiaZuHudViewPresentor
