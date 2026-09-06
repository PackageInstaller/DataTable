-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GoddesscollectorpetskinsView.lua

module("logic.extensions.goddesscollector.view.GoddesscollectorpetskinsView", package.seeall)

local GoddesscollectorpetskinsView = class("GoddesscollectorpetskinsView", GoddesscollectorpetsView)

function GoddesscollectorpetskinsView:ctor()
	GoddesscollectorpetskinsView.super.ctor(self)

	self._viewType = GoddesscollectorpetsView.ViewType.PetSkins
end

function GoddesscollectorpetskinsView:_getViewDatas()
	return GoddesscollectorConfig.instance:getSkinCfgs(self._acfg.skinPlanId)
end

function GoddesscollectorpetskinsView:_isGainPrize(prizeId)
	return GoddesscollectorModel.instance:isGainSkinCollectPrize(prizeId)
end

function GoddesscollectorpetskinsView:_isCanGainPrize(prizeId)
	return GoddesscollectorModel.instance:isCanGainSkinCollectPrize(prizeId)
end

function GoddesscollectorpetskinsView:_getRewardCfgs()
	return GoddesscollectorConfig.instance:getPrizeCfgs(self._acfg.skinPrizePlanId)
end

function GoddesscollectorpetskinsView:_getCurrCollectScore()
	return GoddesscollectorModel.instance:getSkinCollectScore()
end

function GoddesscollectorpetskinsView:_getPrizeType()
	return GameEnum.GoddessCollector_PrizeType.SKIN_PRIZE
end

return GoddesscollectorpetskinsView
