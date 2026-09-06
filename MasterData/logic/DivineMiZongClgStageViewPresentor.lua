-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemizongclg/view/DivineMiZongClgStageViewPresentor.lua

module("logic.extensions.divinemizongclg.view.DivineMiZongClgStageViewPresentor", package.seeall)

local DivineMiZongClgStageViewPresentor = class("DivineMiZongClgStageViewPresentor", ViewPresentor)

function DivineMiZongClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiZongClgStageViewPresentor:dependWhatResources()
	local resList = {}

	table.insert(resList, "ui/views/divinemizongclg/divinemizongclgstageview.prefab")

	local params = self:getOpenParam() or {}
	local activityId = checknumber(params[1])
	local data = DivineMiZongClgConfig.instance:getActData(activityId)

	if data then
		for _, field in ipairs(DivineMiZongClgEnum.StageBgFields) do
			local bgName = data[field]

			if not string.nilorempty(bgName) then
				local url = string.format("ui/bigbg/%s.png", bgName)

				table.insert(resList, url)
			end
		end
	end

	return resList
end

function DivineMiZongClgStageViewPresentor:buildViews()
	return {
		DivineMiZongClgStageView.New()
	}
end

return DivineMiZongClgStageViewPresentor
