-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingofradiantgoldclg/view/KingOfRadiantGoldClgStageViewPresentor.lua

module("logic.extensions.kingofradiantgoldclg.view.KingOfRadiantGoldClgStageViewPresentor", package.seeall)

local KingOfRadiantGoldClgStageViewPresentor = class("KingOfRadiantGoldClgStageViewPresentor", ViewPresentor)

function KingOfRadiantGoldClgStageViewPresentor:ctor()
	KingOfRadiantGoldClgStageViewPresentor.super.ctor(self)
end

function KingOfRadiantGoldClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingOfRadiantGoldClgStageViewPresentor:dependWhatResources()
	local list = {}

	table.insert(list, "ui/views/kingofradiantgoldclg/kingofradiantgoldclgstageview.prefab")

	local params = self:getOpenParam() or {}
	local activityId = checknumber(params[1])
	local cfgs = KingOfRadiantGoldClgConfig.instance:getStageCfgs(activityId)

	if cfgs then
		local dic = {}

		for _, cfg in ipairs(cfgs) do
			for _, data in ipairs(cfg) do
				dic[data.conPath] = true
			end
		end

		for path, _ in pairs(dic) do
			local spriteName = GameUrl.getBigbgPngUrl(path)

			table.insert(list, spriteName)
		end
	end

	return list
end

function KingOfRadiantGoldClgStageViewPresentor:buildViews()
	return {
		KingOfRadiantGoldClgStageView.New()
	}
end

return KingOfRadiantGoldClgStageViewPresentor
