-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawequipments/view/DrawEquipmentEffViewPresentor.lua

module("logic.extensions.drawequipments.view.DrawEquipmentEffViewPresentor", package.seeall)

local DrawEquipmentEffViewPresentor = class("DrawEquipmentEffViewPresentor", ViewPresentor)

function DrawEquipmentEffViewPresentor:attachToWhichRoot()
	return
end

function DrawEquipmentEffViewPresentor:dependWhatResources()
	return {
		"ui/views/drawequipments/drawequipmenteffview.prefab"
	}
end

function DrawEquipmentEffViewPresentor:buildViews()
	return {
		DrawEquipmentEffView.New()
	}
end

function DrawEquipmentEffViewPresentor:getTempResources()
	local times = self:getFirstParam()
	local effConfig = DrawEquipmentsController.drawEffectsConfig[times]
	local effs = {}
	local qualities = DrawEquipmentsController.instance:getDrawQualities()

	if qualities then
		for i = 1, #qualities do
			local qualityEff = DrawEquipmentsController.EquipEffsByQuality[qualities[i]]

			if not string.nilorempty(qualityEff) then
				local effPath = UIEffectManager.instance:getEffectPath(qualityEff)

				if not table.indexof(effs, effPath) then
					table.insert(effs, effPath)
				end
			end
		end
	end

	table.insert(effs, UIEffectManager.instance:getEffectPath(effConfig.effectPath))

	return effs
end

function DrawEquipmentEffViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DrawEquipmentEffViewPresentor
