-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/view/HolyDragonFieldStageViewPresentor.lua

module("logic.extensions.holydragonfield.view.HolyDragonFieldStageViewPresentor", package.seeall)

local HolyDragonFieldStageViewPresentor = class("HolyDragonFieldStageViewPresentor", ViewPresentor)

function HolyDragonFieldStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyDragonFieldStageViewPresentor:dependWhatResources()
	local resList = {
		"ui/views/holydragonfield/holydragonfieldstageview.prefab"
	}
	local params = self:getOpenParam() or {}
	local activityId = checknumber(params[1])
	local fieldId = checknumber(params[2])

	if activityId <= 0 then
		activityId = HolyDragonFieldController.instance:getActivityId()
	end

	local fieldData = activityId > 0 and fieldId > 0 and HolyDragonFieldConfig.instance:getFieldData(activityId, fieldId) or nil

	if fieldData and not string.nilorempty(fieldData.bgUrl) then
		table.insert(resList, GameUrl.getBigbgPngUrl(fieldData.bgUrl))
	end

	return resList
end

function HolyDragonFieldStageViewPresentor:buildViews()
	return {
		HolyDragonFieldStageView.New()
	}
end

return HolyDragonFieldStageViewPresentor
