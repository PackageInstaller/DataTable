-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatetrial/view/UltimateTrialMainViewPresentor.lua

module("logic.extensions.ultimatetrial.view.UltimateTrialMainViewPresentor", package.seeall)

local UltimateTrialMainViewPresentor = class("UltimateTrialMainViewPresentor", ViewPresentor)

function UltimateTrialMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateTrialMainViewPresentor:dependWhatResources()
	local list = {}

	table.insert(list, "ui/views/ultimatetrial/ultimatetrialmainview.prefab")

	local params = self:getOpenParam() or {}
	local activityId = checknumber(params[1])

	if activityId <= 0 then
		activityId = UltimateTrialController.instance:getActivityId()
	end

	local isInTime = UltimateTrialController.instance:isInActivityTime(activityId)

	if isInTime then
		local dic = {}
		local mainCfg = UltimateTrialConfig.instance:getMainCfg(activityId) or {}

		for _, data in ipairs(mainCfg) do
			if not string.nilorempty(data.bgPath) then
				dic[data.bgPath] = true
			end

			if not string.nilorempty(data.tabPath) then
				dic[data.tabPath] = true
			end
		end

		for path, _ in pairs(dic) do
			local spriteName = GameUrl.getBigbgPngUrl(path)

			table.insert(list, spriteName)
		end
	end

	return list
end

function UltimateTrialMainViewPresentor:buildViews()
	return {
		UltimateTrialMainView.New()
	}
end

return UltimateTrialMainViewPresentor
