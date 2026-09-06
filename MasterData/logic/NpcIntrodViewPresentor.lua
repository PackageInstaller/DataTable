-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petintroduction/view/NpcIntrodViewPresentor.lua

module("logic.extensions.petintroduction.view.NpcIntrodViewPresentor", package.seeall)

local NpcIntrodViewPresentor = class("NpcIntrodViewPresentor", ViewPresentor)

function NpcIntrodViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NpcIntrodViewPresentor:dependWhatResources()
	return {
		"ui/views/petintroduction/npcintroductionview.prefab"
	}
end

function NpcIntrodViewPresentor:buildViews()
	return {
		NpcIntrodView.New()
	}
end

function NpcIntrodViewPresentor:getTempResources()
	return {
		PetIntroductionConfig.instance:getNpcIntrodModelPathById(self:getFirstParam())
	}
end

return NpcIntrodViewPresentor
