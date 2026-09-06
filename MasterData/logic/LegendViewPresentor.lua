-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/LegendViewPresentor.lua

module("logic.extensions.legend.view.LegendViewPresentor", package.seeall)

local LegendViewPresentor = class("LegendViewPresentor", ViewWithGuidePresentor)

function LegendViewPresentor:ctor()
	LegendViewPresentor.super.ctor(self)
end

function LegendViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LegendViewPresentor:dependWhatResources()
	return {
		"ui/views/legend/legendview.prefab"
	}
end

function LegendViewPresentor:getTempResources()
	local challengeId = self:getFirstParam()
	local legendChallengeCfg = LegendConfig.instance:getLegendChallengeCfg(challengeId)
	local petCo = CharacterConfig.instance:getPetCo(legendChallengeCfg.raceId)
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(legendChallengeCfg.raceId)
	local resName = LegendModel.instance:getTexNameByRaceTypes(skinCfg.elementAttr)
	local idx, resPath = CharacterConfig.instance:GetCharacterResIdx(petCo.faceIds, true)

	return {
		string.format("ui/bigbg/legend/%s.png", resName),
		resPath
	}
end

function LegendViewPresentor:buildViews()
	return {
		LegendView.New()
	}
end

return LegendViewPresentor
