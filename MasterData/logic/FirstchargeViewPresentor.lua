-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/FirstchargeViewPresentor.lua

module("logic.extensions.firstcharge.view.FirstchargeViewPresentor", package.seeall)

local FirstchargeViewPresentor = class("FirstchargeViewPresentor", ViewPresentor)

function FirstchargeViewPresentor:ctor()
	FirstchargeViewPresentor.super.ctor(self)
end

function FirstchargeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FirstchargeViewPresentor:dependWhatResources()
	return {
		"ui/views/firstcharge/firstchargeview.prefab"
	}
end

function FirstchargeViewPresentor:getTempResources()
	local cfg = CharacterConfig.instance:getModelCo(checknumber(10309))
	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.FirstCharge)
	local bgRes = FirstChargeModel.instance:getTemResByActcfg(actCfg)

	table.insert(bgRes, GameUrl.getLihuiSpineUrl(cfg.bustName))

	return bgRes
end

function FirstchargeViewPresentor:buildViews()
	return {
		FirstchargeView.New()
	}
end

return FirstchargeViewPresentor
