-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawequipments/view/DrawEquipPreviewViewPresentor.lua

module("logic.extensions.drawequipments.view.DrawEquipPreviewViewPresentor", package.seeall)

local DrawEquipPreviewViewPresentor = class("DrawEquipPreviewViewPresentor", ViewPresentor)

function DrawEquipPreviewViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DrawEquipPreviewViewPresentor:dependWhatResources()
	return {
		"ui/views/drawequipments/drawequipmentspreviewview.prefab"
	}
end

function DrawEquipPreviewViewPresentor:buildViews()
	return {
		DrawEquipPreviewView.New()
	}
end

return DrawEquipPreviewViewPresentor
