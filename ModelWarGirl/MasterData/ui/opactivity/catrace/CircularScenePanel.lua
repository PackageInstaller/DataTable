-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\CatRace\\CircularScenePanel.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local AnimatorType = typeof(UnityEngine.Animator)
local strClassName = "CircularScenePanel"
local CircularScenePanel = Class(strClassName, UIBaseControl)
local DOTweenComponent = typeof(Framework.EffectSystem.DOTweenComponent)

function CircularScenePanel:ctor(parent, path)
	self.panel = UIControls.Panel(parent, path)
end

function CircularScenePanel:getAnimator()
	if self.animCom == nil then
		local obj = self:getComObj()

		if obj then
			local anim = obj.transform:GetComponent(AnimatorType)

			if anim then
				self.animCom = anim
			end
		end
	end

	return self.animCom
end

function CircularScenePanel:changeSpeed(speedScale)
	local anim = self:getAnimator()

	if anim ~= nil then
		anim.speed = speedScale
	end
end

return CircularScenePanel
