-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpStageViewPresentor.lua

module("logic.extensions.stknexp.view.StKnExpStageViewPresentor", package.seeall)

local StKnExpStageViewPresentor = class("StKnExpStageViewPresentor", ViewPresentor)

function StKnExpStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StKnExpStageViewPresentor:dependWhatResources()
	local resList = {}

	table.insert(resList, "ui/views/stknexp/stknexpstageview.prefab")

	local params = self:getOpenParam() or {}
	local activityId = checknumber(params[1])
	local zoneId = checknumber(params[2])
	local data = StKnExpConfig.instance:getZoneData(activityId, zoneId)

	if data then
		for _, field in ipairs(StKnExpEnum.StageBgFields) do
			local bgName = data[field]

			if not string.nilorempty(bgName) then
				local url = string.format("ui/bigbg/%s.png", bgName)

				table.insert(resList, url)
			end
		end
	end

	return resList
end

function StKnExpStageViewPresentor:buildViews()
	return {
		StKnExpStageView.New()
	}
end

function StKnExpStageViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StKnExpStageViewPresentor
