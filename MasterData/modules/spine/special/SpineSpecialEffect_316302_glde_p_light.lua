-- chunkname: @modules/spine/special/SpineSpecialEffect_316302_glde_p_light.lua

module("modules.spine.special.SpineSpecialEffect_316302_glde_p_light", package.seeall)

local SpineSpecialEffect_316302_glde_p_light = class("SpineSpecialEffect_316302_glde_p_light", BaseSpineSpecialEffect)

function SpineSpecialEffect_316302_glde_p_light:_onInit()
	self.animator = gohelper.onceAddComponent(self._spine:getSpineGo(), gohelper.Type_Animator)
	self.hasLoaded = false

	self:loadRes()
end

function SpineSpecialEffect_316302_glde_p_light:loadRes()
	self._animPath = "ui/animations/dynamic/v4a0_316302_glde_p_light_controller.controller"

	if not self._loader then
		self._loader = MultiAbLoader.New()

		self._loader:addPath(self._animPath)
		self._loader:startLoad(self._loadFinished, self)
	end
end

function SpineSpecialEffect_316302_glde_p_light:_loadFinished()
	self.hasLoaded = true

	local assetItem = self._loader:getAssetItem(self._animPath)
	local animatorInst = assetItem:GetResource(self._animPath)

	if self.animator then
		self.animator.runtimeAnimatorController = animatorInst
	end

	if self.waitForLoadData then
		self:playAnim(self.waitForLoadData.name, self.waitForLoadData.replay)
	end
end

function SpineSpecialEffect_316302_glde_p_light:_onBodyChange(prevBodyName, curBodyName)
	if curBodyName == "b_yincang" then
		self:playAnim("visible", true)
	else
		self:playAnim("exit_visible")
	end
end

function SpineSpecialEffect_316302_glde_p_light:playAnim(name, replay)
	if not self.hasLoaded then
		self.waitForLoadData = {
			name = name,
			replay = replay
		}

		return
	end

	self.waitForLoadData = nil

	if replay then
		self.animator:Play(name, 0, 0)
	else
		self.animator:Play(name)
	end
end

function SpineSpecialEffect_316302_glde_p_light:onDestroy()
	return
end

return SpineSpecialEffect_316302_glde_p_light
