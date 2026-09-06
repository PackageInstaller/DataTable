-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/DragonEffectViewPresentor.lua

module("logic.extensions.lottery.view.DragonEffectViewPresentor", package.seeall)

local DragonEffectViewPresentor = class("DragonEffectViewPresentor", ViewPresentor)

function DragonEffectViewPresentor:attachToWhichRoot()
	return
end

function DragonEffectViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/dragoneffectview.prefab"
	}
end

function DragonEffectViewPresentor:buildViews()
	return {
		DragonEffectView.New()
	}
end

function DragonEffectViewPresentor:getTempResources()
	local times = self:getFirstParam()
	local effs = {}
	local qualities = DragonController.instance:getLastDrawQualities()

	if qualities then
		for i = 1, #qualities do
			local qualityEff = DragonController.EquipEffsByQuality[qualities[i]]

			if not string.nilorempty(qualityEff) then
				local effPath = UIEffectManager.instance:getEffectPath(qualityEff)

				if not table.indexof(effs, effPath) then
					table.insert(effs, effPath)
				end
			end
		end
	end

	table.insert(effs, UIEffectManager.instance:getEffectPath(DragonController.drawEffectsConfig.effectPath))

	return effs
end

function DragonEffectViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DragonEffectViewPresentor
