-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/OneKeyPutonEquipViewPresentor.lua

module("logic.extensions.starequipment.view.OneKeyPutonEquipViewPresentor", package.seeall)

local OneKeyPutonEquipViewPresentor = class("OneKeyPutonEquipViewPresentor", ViewWithGuidePresentor)

function OneKeyPutonEquipViewPresentor:ctor()
	OneKeyPutonEquipViewPresentor.super.ctor(self)
end

function OneKeyPutonEquipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OneKeyPutonEquipViewPresentor:dependWhatResources()
	return {
		"ui/views/starequipment/onekeyputonequipview.prefab"
	}
end

function OneKeyPutonEquipViewPresentor:buildViews()
	return {
		OneKeyPutonEquipView.New()
	}
end

return OneKeyPutonEquipViewPresentor
