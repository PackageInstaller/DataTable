-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/Firstcharge2024ViewPresentor.lua

module("logic.extensions.firstcharge.view.Firstcharge2024ViewPresentor", package.seeall)

local Firstcharge2024ViewPresentor = class("Firstcharge2024ViewPresentor", ViewPresentor)

function Firstcharge2024ViewPresentor:ctor()
	Firstcharge2024ViewPresentor.super.ctor(self)
end

function Firstcharge2024ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Firstcharge2024ViewPresentor:dependWhatResources()
	return {
		"ui/views/firstcharge/firstchargeview.prefab"
	}
end

function Firstcharge2024ViewPresentor:getTempResources()
	local cfg = CharacterConfig.instance:getModelCo(checknumber(10309))
	local activityId = FirstChargePlusModel.instance:getCurActivityId()
	local bgRes = FirstChargePlusModel.instance:getTemResByActcfg(activityId)

	table.insert(bgRes, GameUrl.getLihuiSpineUrl(cfg.bustName))

	return bgRes
end

function Firstcharge2024ViewPresentor:buildViews()
	return {
		Firstcharge2024View.New()
	}
end

return Firstcharge2024ViewPresentor
