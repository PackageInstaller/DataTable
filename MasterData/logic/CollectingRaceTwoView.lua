-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingrace/view/CollectingRaceTwoView.lua

module("logic.extensions.collectingrace.view.CollectingRaceTwoView", package.seeall)

local CollectingRaceTwoView = class("CollectingRaceTwoView", CollectingRaceView)

function CollectingRaceTwoView:_setQualityCell(cell, data)
	local goSkinquality = goutil.findChild(cell.gameObject, "container/skinquality")

	MaterialMgr.setCell(MatType.PetSkin_Rare, data.skinId, goSkinquality)
end

return CollectingRaceTwoView
