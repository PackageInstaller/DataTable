-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\ModelEffectManager.lua

local strClassName = "ModelEffectManager"
local ModelEffectManager = Class(strClassName)
local DOTweenComponent = Framework.EffectSystem.DOTweenComponent
local CueDataBank = require("System/CueDataBank")

function ModelEffectManager:ctor()
	assert(ModelEffectManager._instance == nil, "[ERROR] The ModelEffectManager instance is created already!")
	self:init()
end

local EffectType = {
	ChangeMotion = 3,
	AddMaterial = 2,
	Hide = 1,
	ChangeModel = 4,
	Scale = 0,
	Transparency = 5
}

function ModelEffectManager:init()
	self.effectStayDict = {
		[EffectType.Scale] = {},
		[EffectType.Hide] = {},
		[EffectType.AddMaterial] = {},
		[EffectType.ChangeMotion] = {},
		[EffectType.ChangeModel] = {},
		[EffectType.Transparency] = {}
	}
	self.modelEffectTimer = {
		[EffectType.Scale] = {},
		[EffectType.Hide] = {},
		[EffectType.AddMaterial] = {},
		[EffectType.ChangeMotion] = {},
		[EffectType.ChangeModel] = {},
		[EffectType.Transparency] = {}
	}
	self.recoverFuncMap = {
		[EffectType.Scale] = self.recoverModelScale,
		[EffectType.Hide] = self.recoverModelHide,
		[EffectType.AddMaterial] = self.recoverModelMaterial,
		[EffectType.ChangeMotion] = self.recoverModelMotion,
		[EffectType.ChangeModel] = self.recoverModelChange,
		[EffectType.Transparency] = self.recoverModelTransparency
	}
end

function ModelEffectManager:destroy()
	self:stopAllTimer()
end

function ModelEffectManager:stopAllTimer()
	for timerType, entityDict in pairs(self.modelEffectTimer) do
		for entityId, timerDict in pairs(entityDict) do
			for effectId, timer in pairs(timerDict) do
				timer:Stop()

				timer = nil
			end
		end
	end
end

function ModelEffectManager:playModelEffect(actor, effectId, effectData)
	if not actor or not effectData then
		return
	end

	local effectType = effectData.type

	if effectType == EffectType.Scale then
		local scaleParam = effectData.modelScale

		if scaleParam then
			local scale = scaleParam.scale
			local mode = scaleParam.mode
			local duration = effectData.fadeIn

			self:playModelScale(actor, scale, duration, mode)
		end
	elseif effectType == EffectType.Hide then
		local hideParam = effectData.modelHide

		if hideParam then
			local hideHpLogo = hideParam.hideHpLogo
			local hideDamageNum = hideParam.hideDamageNum
			local skipHideModel = hideParam.skipHideModel

			self:playModelHide(actor, hideHpLogo, hideDamageNum, skipHideModel)
		end
	elseif effectType == EffectType.AddMaterial then
		local materialParam = effectData.modelAddMaterial

		if materialParam then
			local partStr = materialParam.part
			local materialPath = materialParam.materialPath

			self:playAddMaterial(actor, materialPath)
		end
	elseif effectType == EffectType.ChangeMotion then
		local motionParam = effectData.modelChangeMotion

		if motionParam then
			local oldStateName = motionParam.oldStateName
			local newStateName = motionParam.newStateName

			self:playChangeMotion(actor, oldStateName, newStateName)
		end
	elseif effectType == EffectType.ChangeModel then
		local modelParam = effectData.modelChangeAll

		if modelParam then
			local commonModelId = modelParam.commonModelId
			local animator = modelParam.animator
			local defaultAnim = modelParam.defaultAnim

			self:playChangeModelAll(actor, commonModelId, animator, defaultAnim)
		end
	elseif effectType == EffectType.Transparency then
		local transparentParam = effectData.modelTransparency

		if transparentParam then
			local duration = effectData.fadeIn
			local alpha = transparentParam.alpha

			self:playModelTransparency(actor, alpha, duration)
		end
	end

	local howToPlay = effectData.howToPlay
	local length = effectData.length
	local entityId = actor.entityId

	if length > 0 then
		if not self.modelEffectTimer[effectType][entityId] then
			self.modelEffectTimer[effectType][entityId] = {}
		end

		if self.modelEffectTimer[effectType][entityId][effectId] then
			self.modelEffectTimer[effectType][entityId][effectId]:Stop()

			self.modelEffectTimer[effectType][entityId][effectId] = nil
		end

		self.modelEffectTimer[effectType][entityId][effectId] = Timer.New(Functor(self.recoverModelEffect, self, actor, effectId), length, 1, true)

		self.modelEffectTimer[effectType][entityId][effectId]:Start()
	else
		if not self.effectStayDict[effectType][entityId] then
			self.effectStayDict[effectType][entityId] = {}
		end

		self.effectStayDict[effectType][entityId][effectId] = true
	end
end

function ModelEffectManager:recoverModelEffect(actor, effectId)
	local cueData = CueDataBank.getCueData(effectId)

	if not cueData then
		return
	end

	if not actor then
		return
	end

	local effectData = cueData.ModelEffect
	local effectType = effectData.type
	local length = effectData.length
	local entityId = actor.entityId

	if self.modelEffectTimer[effectType][entityId] and self.modelEffectTimer[effectType][entityId][effectId] then
		self.modelEffectTimer[effectType][entityId][effectId]:Stop()

		self.modelEffectTimer[effectType][entityId][effectId] = nil
	end

	if not actor.gameObject then
		return
	end

	if length > 0 then
		if not self.effectStayDict[effectType][entityId] or not self.effectStayDict[effectType][entityId][effectId] then
			self.recoverFuncMap[effectType](self, actor, effectId, effectData)
		end
	else
		self.recoverFuncMap[effectType](self, actor, effectId, effectData)

		if self.effectStayDict[effectType][entityId] then
			self.effectStayDict[effectType][entityId][effectId] = nil
		end
	end
end

function ModelEffectManager:clearEntityModelEffect(actor)
	if not actor or not actor.gameObject or not actor.entityId then
		return
	end

	local entityId = actor.entityId

	for effectType, entityDict in pairs(self.effectStayDict) do
		local effectDict = entityDict[entityId]

		if effectDict then
			for effectId, _ in pairs(effectDict) do
				self:recoverModelEffect(actor, effectId)
			end
		end
	end

	for effectType, entityDict in pairs(self.modelEffectTimer) do
		local timerDict = entityDict[entityId]

		if timerDict then
			for effectId, timer in pairs(timerDict) do
				if timer then
					timer:Invoke()
				end
			end
		end
	end
end

local DOTweenComponentType = typeof(DOTweenComponent)

function ModelEffectManager:playModelScale(actor, scaleRate, duration, mode)
	local dotCompoent = actor.gameObject:GetComponent(DOTweenComponentType)

	dotCompoent = dotCompoent or actor.gameObject:AddComponent(DOTweenComponentType)

	dotCompoent:Scale(scaleRate, duration, mode)
end

function ModelEffectManager:recoverModelScale(actor, effectId)
	local dotCompoent = actor.gameObject:GetComponent(DOTweenComponentType)

	dotCompoent = dotCompoent or actor.gameObject:AddComponent(DOTweenComponentType)

	local originalScale = 1
	local cueData = CueDataBank.getCueData(effectId)

	if not cueData then
		dotCompoent:Scale(originalScale, 1, 0)

		return
	end

	local effectData = cueData.ModelEffect
	local fadeOut = effectData.fadeOut
	local mode = effectData.modelScale.mode

	dotCompoent:Scale(originalScale, fadeOut, mode)
end

function ModelEffectManager:playModelHide(actor, hideHp, hideDamageNum, skipHideModel)
	if not skipHideModel and actor.setModelVisible then
		actor:setModelVisible(false)
	end

	if hideHp and actor.setLogoVisible then
		actor:setLogoVisible(false)
	end

	if hideDamageNum then
		actor.showDamageNum = false
	end
end

function ModelEffectManager:recoverModelHide(actor, effectId)
	local cueData = CueDataBank.getCueData(effectId)

	if not cueData then
		return
	end

	local effectData = cueData.ModelEffect

	if effectData then
		local hideParam = effectData.modelHide

		if not hideParam.skipHideModel and actor and actor.modelObject then
			actor:setModelVisible(true)
		end

		if hideParam.hideHpLogo then
			actor:refreshLogoVisible()
		end

		if hideParam.hideDamageNum then
			actor.showDamageNum = true
		end
	end
end

function ModelEffectManager:playAddMaterial(actor, path)
	actor:addMaterial(path)
end

function ModelEffectManager:recoverModelMaterial(actor, effectId, effectData)
	if not effectData then
		return
	end

	local materialParam = effectData.modelAddMaterial

	if materialParam then
		local materialPath = materialParam.materialPath

		actor:delMaterial(materialPath)
	end
end

function ModelEffectManager:playChangeMotion(actor, oldStateName, newStateName)
	actor:changeMotion(oldStateName, newStateName)
end

function ModelEffectManager:recoverModelMotion(actor, effectId)
	local cueData = CueDataBank.getCueData(effectId)

	if not cueData then
		return
	end

	local effectData = cueData.ModelEffect
	local effectType = effectData.type

	if effectType ~= 3 then
		return
	end

	local oldState = effectData.modelChangeMotion.oldStateName
	local newState = effectData.modelChangeMotion.newStateName

	actor:recoverMotion(oldState)
end

function ModelEffectManager:playChangeModelAll(actor, commonModelId, animator, defaultAnim)
	actor:modelTransform(commonModelId, animator, defaultAnim)
end

function ModelEffectManager:recoverModelChange(actor)
	actor:recoverModelTransform()
end

function ModelEffectManager:playModelTransparency(actor, alpha, duration)
	actor:fadeInTransparency(alpha, duration)
end

function ModelEffectManager:recoverModelTransparency(actor, effectId, effectData)
	if not effectData then
		return
	end

	local duration = effectData.fadeOut
	local transparentParam = effectData.modelTransparency
	local alpha = 0

	if transparentParam then
		alpha = transparentParam.alpha
	end

	actor:fadeOutTransparency(alpha, duration)
end

return ModelEffectManager
