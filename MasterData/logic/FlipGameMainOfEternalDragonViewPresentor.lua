-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/view/copy/FlipGameMainOfEternalDragonViewPresentor.lua

module("logic.extensions.dreamteam.view.FlipGameMainOfEternalDragonViewPresentor", package.seeall)

local FlipGameMainOfEternalDragonViewPresentor = class("FlipGameMainOfEternalDragonViewPresentor", FlipGameMainViewPresentor)

function FlipGameMainOfEternalDragonViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteam/smallgame/flipgamemainofeternaldragonview.prefab"
	}
end

function FlipGameMainOfEternalDragonViewPresentor:buildViews()
	return {
		FlipGameMainOfEternalDragonView.New()
	}
end

return FlipGameMainOfEternalDragonViewPresentor
