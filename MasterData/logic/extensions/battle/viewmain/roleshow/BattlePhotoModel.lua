-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/roleshow/BattlePhotoModel.lua

module("logic.extensions.battle.viewmain.roleshow.BattlePhotoModel", package.seeall)

local M = class("BattlePhotoModel")

function M.Get(go)
	return Astral.LuaComponentContainer.Add(go, M)
end

function M:ctor(container)
	self._go = container.gameObject
	self._transform = self._go.transform
	self._photo = Astral.PhotoBase.Add(self._go)
	self._preLoader = BattleUnitPrefabLoader.Get(self._go)

	self._preLoader:setLoadAnimationStatus(false)
	self._preLoader:setParentAfterLoad(false)

	self._modelsLoadedHandler = Handler.New()
	self._photoCreateHandler = Handler.New()
	self._defaultAnimName = nil
	self._modelContainer = false
	self._producerPosX = false
	self._preloadAnimations = {}
end

function M:showModel(resPath, animations)
	self:_addAppearAnimation(animations)
	goutil.setActive(self._go, true)
	self:_clearResource()
	table.insertto(self._preloadAnimations, animations)
	self._preLoader:load(resPath, self._onModelLoaded, self)
end

function M:_addAppearAnimation(animations)
	for i, v in ipairs(animations) do
		if v == "battle_appear_idle" then
			table.insert(animations, "battle_appear")
			table.insert(animations, "battle_appear_face")
		elseif v == "battle_react_idle" then
			table.insert(animations, "battle_react")
			table.insert(animations, "battle_react_face")
		end
	end
end

function M:turnOnCamera()
	goutil.setActive(self._go, true)

	local textureFormat = UnityEngine.RenderTextureFormat.ARGB32
	local size, antiAliasing = self:_getRTSizeAndAA()

	self._photo:TurnOn(size, size, textureFormat, antiAliasing)

	local x, y, z = TransformUtils.GetPosition(self._photo.producer.producerContainer.gameObject.transform, 0, 0, 0)

	self._producerPosX = x

	TransformUtils.SetPosition(self._photo.producer.producerContainer.gameObject.transform, 0, 0, 0)
	self._photoCreateHandler:call()
	goutil.setActive(self._go, false)
end

function M:_getRTSizeAndAA()
	local rtQuality = GfxModel.instance:getRTQuality()
	local rtSize, antiAliasing = 0, 1

	if rtQuality == GfxConst.RTQuality.Low then
		rtSize = PhotoCacheMgr.SIZE_L_BLOCK
		antiAliasing = 1
	elseif rtQuality == GfxConst.RTQuality.Middle then
		rtSize = PhotoCacheMgr.SIZE_M_BLOCK
		antiAliasing = 1
	elseif rtQuality == GfxConst.RTQuality.High then
		rtSize = PhotoCacheMgr.SIZE_M_BLOCK
		antiAliasing = 4
	end

	return rtSize, antiAliasing
end

function M:setCameraPosition(x, y, z)
	self._photo:SetCameraPosition(x, y, z)
end

function M:getCamera()
	return self._photo:GetCamera()
end

function M:getPhoto()
	return self._photo
end

function M:_onModelLoaded()
	self._preLoader:loadAnimations(self._preloadAnimations, self._onAnimationLoaded, self)
end

function M:_onAnimationLoaded(res)
	local inst = res:getInst()
	local materialSetter = BatchMaterialSetter.Get(inst)

	materialSetter:TurnOnLayerMask(RenderingLayerMask.Layer4)
	materialSetter:TurnOffLayerMask(RenderingLayerMask.Layer5)

	local container = goutil.create("modelContainer", false)

	self._modelContainer = container.transform

	goutil.addChildToParent(inst, container)
	self._photo:ShowTarget(container, true)

	self._goInst = inst
	self._animationPlayer = AnimationPlayer.Get(self._goInst)

	self._animationPlayer:SetListener(self._onAnimationEvent, self)
	goutil.setActive(container, true)
	self._modelsLoadedHandler:call()
end

function M:setModelsLoadedCallback(callback, callbackObj)
	self._modelsLoadedHandler:setListener(callback, callbackObj)
end

function M:setPhotoCreateCallBack(callback, callbackObj)
	self._photoCreateHandler:setListener(callback, callbackObj)
end

function M:playAnimation(aniName)
	local animationPlayer = self._animationPlayer

	if not animationPlayer then
		return
	end

	self._loopAnimation = aniName

	animationPlayer:SetMixDuration(0)

	if aniName == "battle_appear_idle" then
		animationPlayer:PlayAnimation("battle_appear", false, true)

		local faceAnimState = "battle_appear_face"

		if animationPlayer:ContainsAnimation(faceAnimState) then
			animationPlayer:PlayFaceAnimation(faceAnimState, false)
		end
	elseif aniName == "battle_react_idle" then
		animationPlayer:PlayAnimation("battle_react", false, true)

		local faceAnimState = "battle_react_face"

		if animationPlayer:ContainsAnimation(faceAnimState) then
			animationPlayer:PlayFaceAnimation(faceAnimState, false)
		end
	else
		animationPlayer:PlayAnimation(aniName, true, true)
	end
end

function M:_onAnimationEvent(animName)
	if animName ~= self._loopAnimation then
		self._animationPlayer:SetMixDuration(0.1)
		self._animationPlayer:PlayAnimation(self._loopAnimation, true, true)
	end
end

function M:getModelInst()
	return self._goInst
end

function M:setCameraCullingMask(cullingMask)
	local cam = PhotoBaseExtension.GetCamera(self._photo)

	cam.cullingMask = cullingMask
end

function M:setCameraTag(tag)
	PhotoBaseExtension.SetCameraTag(self._photo, tag)
end

function M:getModelContainer()
	return self._modelContainer
end

function M:setCameraPostProcessing(renderPostProcessing, volumeLayerMask)
	PhotoBaseExtension.SetCameraPostProcessing(self._photo, renderPostProcessing, volumeLayerMask)
end

function M:_clearResource()
	if self._animationPlayer then
		self._animationPlayer:RemoveListener()

		self._animationPlayer = false
	end

	if self._photo and not goutil.isNil(self._photo.producer) then
		self._photo:RemoveAllTargets()
	end

	self._preLoader:clear()

	self._modelContainer = false
	self._goInst = false

	table.clear(self._preloadAnimations)
end

function M:clearResource()
	self:_clearResource()
end

function M:forceUpdate()
	if self._animationPlayer then
		self._animationPlayer:Evaluate()
	end
end

function M:clear()
	if self._photo.producer then
		TransformUtils.SetPosition(self._photo.producer.producerContainer.gameObject.transform, self._producerPosX, 0, 0)
	end

	self:_clearResource()
	self._photo:TurnOff()
	goutil.setActive(self._go, false)
end

function M:destroy()
	self:clear()

	self._go = nil
	self._transform = nil
	self._photo = nil
	self._preLoader = nil

	self._modelsLoadedHandler:clear()

	self._modelsLoadedHandler = nil

	self._photoCreateHandler:clear()

	self._photoCreateHandler = nil
	self._defaultAnimName = nil
end

return M
