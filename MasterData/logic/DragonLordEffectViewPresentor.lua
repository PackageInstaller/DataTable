-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/DragonLordEffectViewPresentor.lua

module("logic.extensions.dragonlords.view.DragonLordEffectViewPresentor", package.seeall)

local DragonLordEffectViewPresentor = class("DragonLordEffectViewPresentor", ViewPresentor)

function DragonLordEffectViewPresentor:ctor()
	DragonLordEffectViewPresentor.super.ctor(self)
end

function DragonLordEffectViewPresentor:attachToWhichRoot()
	return
end

function DragonLordEffectViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/dragoneffectview.prefab"
	}
end

function DragonLordEffectViewPresentor:buildViews()
	return {
		DragonLordEffectView.New()
	}
end

function DragonLordEffectViewPresentor:getTempResources()
	local effs = {}
	local qualities = DrogonLordsModel.instance:getLastDrawQuas()

	if qualities then
		for i = 1, #qualities do
			local qualityEff = DragonLordsController.EquipEffsByQuality[qualities[i]]

			if not string.nilorempty(qualityEff) then
				local effPath = UIEffectManager.instance:getEffectPath(qualityEff)

				if not table.indexof(effs, effPath) then
					table.insert(effs, effPath)
				end
			end
		end
	end

	table.insert(effs, UIEffectManager.instance:getEffectPath(DragonLordsController.drawEffectsConfig.effectPath))

	return effs
end

function DragonLordEffectViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DragonLordEffectViewPresentor
