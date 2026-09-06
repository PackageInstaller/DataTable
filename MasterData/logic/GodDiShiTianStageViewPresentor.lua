-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddishitian/view/GodDiShiTianStageViewPresentor.lua

module("logic.extensions.goddishitian.view.GodDiShiTianStageViewPresentor", package.seeall)

local GodDiShiTianStageViewPresentor = class("GodDiShiTianStageViewPresentor", ViewPresentor)

function GodDiShiTianStageViewPresentor:ctor()
	GodDiShiTianStageViewPresentor.super.ctor(self)
end

function GodDiShiTianStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodDiShiTianStageViewPresentor:dependWhatResources()
	return {
		"ui/views/goddishitian/goddishitianstageview.prefab"
	}
end

function GodDiShiTianStageViewPresentor:buildViews()
	return {
		GodDiShiTianStageView.New()
	}
end

function GodDiShiTianStageViewPresentor:getTempResources()
	local stageType = self:getFirstParam()
	local cfg = GodDiShiTianConfig.instance:getStageTypeCfg(stageType)
	local paths = {}

	if cfg then
		table.insert(paths, GameUrl.getBigbgPngUrl(cfg.bgPath))
	end

	return paths
end

return GodDiShiTianStageViewPresentor
