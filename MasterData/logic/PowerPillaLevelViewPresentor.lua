-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/PowerPillaLevelViewPresentor.lua

module("logic.extensions.maintainpowerpilla.view.PowerPillaLevelViewPresentor", package.seeall)

local PowerPillaLevelViewPresentor = class("PowerPillaLevelViewPresentor", ViewPresentor)

PowerPillaLevelViewPresentor.PrefixPath = "ui/icon/game/powerpilla/"
PowerPillaLevelViewPresentor.Entrance = PowerPillaLevelViewPresentor.PrefixPath .. "icon_05.png"
PowerPillaLevelViewPresentor.Exit = PowerPillaLevelViewPresentor.PrefixPath .. "icon_04.png"
PowerPillaLevelViewPresentor.Battle = PowerPillaLevelViewPresentor.PrefixPath .. "icon_07.png"
PowerPillaLevelViewPresentor.Trap = PowerPillaLevelViewPresentor.PrefixPath .. "icon_06.png"
PowerPillaLevelViewPresentor.Box = PowerPillaLevelViewPresentor.PrefixPath .. "icon_10.png"
PowerPillaLevelViewPresentor.Branch = PowerPillaLevelViewPresentor.PrefixPath .. "board_icon_02.png"

function PowerPillaLevelViewPresentor:ctor()
	PowerPillaLevelViewPresentor.super.ctor(self)
end

function PowerPillaLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PowerPillaLevelViewPresentor:dependWhatResources()
	local list = {}

	table.insert(list, "ui/views/maintainpowerpilla/powerpillalevelview.prefab")

	local activityId = PowerPillaModel.instance:getActivityId()

	if activityId > 0 then
		local resMap = {}
		local dataList = PowerPillaConfig.instance:getStageListById(activityId)

		for _, data in ipairs(dataList) do
			if not string.nilorempty(data.mapPath) then
				resMap[data.mapPath] = GameUrl.getBigbgFolderUrl("game/powerpilla", data.mapPath)
			end
		end

		for _, v in pairs(resMap) do
			table.insert(list, v)
		end
	end

	return list
end

function PowerPillaLevelViewPresentor:buildViews()
	return {
		PowerPillaLevelView.New()
	}
end

function PowerPillaLevelViewPresentor:getTempResources()
	return {
		"ui/bigbg/game/powerpilla/bg_whlz_02.png",
		PowerPillaLevelViewPresentor.Entrance,
		PowerPillaLevelViewPresentor.Exit,
		PowerPillaLevelViewPresentor.Battle,
		PowerPillaLevelViewPresentor.Trap,
		PowerPillaLevelViewPresentor.Box,
		PowerPillaLevelViewPresentor.PrefixPath .. "icon_01.png",
		PowerPillaLevelViewPresentor.PrefixPath .. "icon_02.png",
		PowerPillaLevelViewPresentor.PrefixPath .. "icon_03.png"
	}
end

return PowerPillaLevelViewPresentor
