-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/PetPhotoShow.lua

module("logic.extensions.bag.view.PetPhotoShow", package.seeall)

local PetPhotoShow = class("PetPhotoShow")

PetPhotoShow.BloomEffect = false

function PetPhotoShow.Get(go)
	local component = Framework.LuaComponentContainer.Get(go, PetPhotoShow)

	component = component or Framework.LuaComponentContainer.Add(go, PetPhotoShow)

	return component
end

function PetPhotoShow.CalcFullScreenSize(rectWidth, rectHeight)
	local ratio = UnityEngine.Screen.height / 720
	local targetWidth = rectWidth * ratio
	local targetHeight = rectHeight * ratio
	local maxWidth = UnityEngine.Screen.width
	local maxHeight = UnityEngine.Screen.height

	if maxWidth < targetWidth or maxHeight < targetHeight then
		local ratioWidth = maxWidth / targetWidth
		local ratioHeight = maxHeight / targetHeight
		local scaleRatio = (ratioWidth + ratioHeight) * 0.7

		scaleRatio = math.min(scaleRatio, math.max(ratioWidth, ratioHeight))
		targetWidth = targetWidth * scaleRatio
		targetHeight = targetHeight * scaleRatio
	end

	return targetWidth, targetHeight
end

function PetPhotoShow:ctor(container)
	self._go = container.gameObject
	self._rawImg = container:GetComponent(typeof(UnityEngine.UI.RawImage))
	self._showShadow = false
	self._preAnim = nil
	self._photoEffect = PhotoEffect.Get(self._go)

	self._photoEffect:setEffectLoadedCallback(self._onEffLoaded, self)

	self._rectTrans = self._rawImg:GetComponent(typeof(UnityEngine.RectTransform))
end

function PetPhotoShow:Awake()
	return
end

function PetPhotoShow:showShadow(showShadow)
	self._showShadow = showShadow
end

function PetPhotoShow:changeShadow(showShadow)
	self:showShadow(showShadow)
	self:_showSpineShadow()
end

function PetPhotoShow:showPetPoster(posterId, isChange)
	self:_checkPhotoEffect()

	self._cameraSize = 3
	self._raceId = posterId

	local cfg = PetSkinConfig.instance:getPosterModelCo(checknumber(posterId))
	local url = GameUrl.getPosterSpineUrl(cfg.resName)

	if isChange and not string.nilorempty(cfg.resNameExt) then
		url = GameUrl.getPosterSpineUrl(cfg.resNameExt)
	end

	self._showLihui = true

	local scale = 1
	local x = 0
	local y = 0
	local displayBagOffset = cfg.bag

	if displayBagOffset then
		x = displayBagOffset[1] or 0
		y = displayBagOffset[2] or 0
		scale = displayBagOffset[3] or 1
	end

	self._offset = Vector3.New(x, y, scale)

	print(">>>>>>>>>>>>>>>>>>>>>>> PetPhotoShow:showPetPoster(go) ", posterId, self._offset.x, self._offset.y)
	self:_showPetFullScreen(url, nil)
end

function PetPhotoShow:switchState(isLihui)
	self:showPetEffect(self._raceId, isLihui)
end

function PetPhotoShow:showPetEffect(raceId, isLihui, cameraSize, modelConfigName)
	self:_checkPhotoEffect()

	self._cameraSize = checknumber(cameraSize)
	self._modelConfigName = modelConfigName

	if self._cameraSize <= 0 then
		self._cameraSize = 3
	end

	self._raceId = raceId
	self._cfg = CharacterConfig.instance:getModelCo(checknumber(raceId))

	local url, showLihui = self:_getSpineResUrl(raceId, isLihui)

	self._showLihui = showLihui
	self._offset = self:_getSpineOffset(raceId, self._showLihui)

	self:_showPetFullScreen(url)
end

function PetPhotoShow:_showPetFullScreen(url)
	if self._url ~= url then
		GameUtil.callBack(self._callBackOnEffUnloadBefore, self)
		self:clear()

		self._url = url

		local rect = self._rectTrans.rect
		local targetWidth, targetHeight = PetPhotoShow.CalcFullScreenSize(rect.width, rect.height)

		self._photoEffect:showEffectsFullScreen({
			self._url
		}, targetWidth, targetHeight)
		self._photoEffect:setCameraPosition(0, 4.07, -1)
		self._photoEffect:setCameraSize(self._cameraSize)

		self._photoCam = self._photoEffect._photo.producer.rtCamera
		self._photoCam.orthographic = true

		Game.ImageUtil.SetRawImageAlpha(self._rawImg, 1)

		self._rawImg.material = nil

		self:setActivate(true)
	else
		GameUtil.callBack(self._callBackOnEffUnloadBefore, self)
		GameUtil.callBack(self._callBackOnEffLoadedAfter, self)
		self:setActivate(true)
	end
end

function PetPhotoShow:_checkPhotoEffect()
	if self._photoEffect == nil then
		self._photoEffect = PhotoEffect.Get(self._go)

		self._photoEffect:setEffectLoadedCallback(self._onEffLoaded, self)
	end
end

function PetPhotoShow:_onEffLoaded(go)
	Framework.TransformUtil.SetLocalScale(go.transform, self._offset.z, math.abs(self._offset.z), 1)
	Framework.TransformUtil.SetLocalPos(go.transform, self._offset.x, self._offset.y, 0)
	print(">>>>>>>>>>>>>>>>>>>>>>> PetPhotoShow:_onEffLoaded(go) ", self._offset.x, self._offset.y)
	print(">>>>>>>>>>>>>>>>>>>>>>>>Lily：offest", self._offset.x, self._offset.y)

	self._role = go
	self._curShowAnim = go:GetComponent("SkeletonAnimation")
	self._curShowSpine = StorySpinePlayer.New()

	self._curShowSpine:setSpine(self._curShowAnim)
	GoUtil.PlaySpineAnim(go, "idle", true, true)
	self:_showSpineShadow()
	self:_playPreAnim()
	GameUtil.callBack(self._callBackOnEffLoadedAfter, self)
end

function PetPhotoShow:setPetLocalPosAndScale(locX, locY, scaleZ)
	if self._offset then
		self._offset.x = checknumber(locX)
		self._offset.y = checknumber(locY)

		if scaleZ then
			self._offset.z = checknumber(scaleZ)
		end

		if self._role then
			GameUtil.setLocalScale(self._role, self._offset.z, math.abs(self._offset.z))
			GameUtil.setLocalPos(self._role, self._offset.x, self._offset.y, 0)
		end
	end
end

function PetPhotoShow:_getSpineOffset(raceId, isLihui)
	local object = CharactorFacade.instance
	local displayBagOffset

	if self._modelConfigName then
		local offset = CharacterConfig.instance:getModelUIPosAndScale(self._modelConfigName, raceId)
		local lihuiOffset = CharacterConfig.instance:getModelUIPosAndScale(self._modelConfigName .. "lihui", raceId)

		displayBagOffset = lihuiOffset.x == 0 and lihuiOffset.y == 0 and lihuiOffset.z == 1 and offset or isLihui and lihuiOffset or offset
	else
		displayBagOffset = isLihui and object:getPetBagLihuiModelUIPosAndScale(raceId) or object:getPetBagModelUIPosAndScale(raceId)
	end

	local scale = 1
	local x = 0
	local y = 0

	if displayBagOffset then
		x = displayBagOffset[1] or 0
		y = displayBagOffset[2] or 0
		scale = displayBagOffset[3] or 1
	end

	x = x / 360
	y = y / 360

	return Vector3.New(x, y, scale)
end

function PetPhotoShow:_getSpineResUrl(raceId, isLihui)
	local cfg = CharacterConfig.instance:getModelCo(checknumber(raceId))

	if isLihui == nil then
		isLihui = true
	end

	if cfg then
		if isLihui and not string.nilorempty(cfg.bustName) then
			return GameUrl.getLihuiSpineUrl(cfg.bustName), true
		else
			return GameUrl.getSpineUrl(cfg.resName), false
		end
	end
end

function PetPhotoShow:clear()
	if self._amPlayer then
		self._amPlayer:Stop()
	end

	if self._photoEffect then
		self._photoEffect:clear()
	end

	self._hasPhotoEffect = false
	self._amPlayer = nil
	self._cfg = nil
	self._role1 = nil
	self._role2 = nil

	if self._curShowSpine ~= nil then
		self._curShowSpine:stop()
	end

	self._curShowSpine = nil
	self._curShowAnim = nil
	self._url = nil
end

function PetPhotoShow:destroy()
	self:clear()

	self._showShadow = false
	self._photoEffect = nil
	self._raceId = nil
	self._role = nil
	self._callBackOnEffLoadedAfter = nil
	self._callBackOnEffUnloadBefore = nil
end

function PetPhotoShow:_showSpineShadow()
	return
end

function PetPhotoShow:setCallBackOnEffLoadedAfter(callBack)
	self._callBackOnEffLoadedAfter = callBack
end

function PetPhotoShow:setCallBackOnEffUnloadBefore(callBack)
	self._callBackOnEffUnloadBefore = callBack
end

function PetPhotoShow:setPreAnim(animName)
	self._preAnim = animName
end

function PetPhotoShow:_playPreAnim()
	if self._preAnim and self._curShowSpine then
		self._curShowSpine:setSpine(self._curShowAnim, {
			self._preAnim
		})

		self._preAnim = nil
	end
end

function PetPhotoShow:playShowAnim()
	if self._showLihui == true or self._curShowAnim == nil or self._cfg == nil then
		return
	end

	local petInfoCo = CharacterConfig.instance:getPetInfoCo(self._cfg.id)

	if petInfoCo then
		local animName = petInfoCo.action

		if not string.nilorempty(animName) then
			local sk = self._curShowAnim.skeletonDataAsset
			local data = sk:GetAnimationStateData()
			local skd = data.SkeletonData
			local ani = skd:FindAnimation(animName)

			if ani ~= nil then
				self._curShowSpine:setSpine(self._curShowAnim, {
					animName,
					"idle"
				})
			end
		end
	end
end

function PetPhotoShow:setScale(scale)
	local scaleX, scaleY, scaleZ = Framework.TransformUtil.GetLocalScale(self._role.transform, 0, 0, 0)

	Framework.TransformUtil.SetLocalScale(self._role.transform, scaleX, scaleY, scaleZ)
end

function PetPhotoShow:_onActiveEffect(go)
	local camera = go:GetComponent("Camera")

	if camera ~= nil then
		local w, h = PhotoCacheMgr.instance:getFullScreenTextureSize()
		local rt = UnityEngine.RenderTexture.GetTemporary(w, h)

		camera.targetTexture = rt
		self._rawImg.texture = rt

		goutil.setActive(self._rawImg.gameObject, true)
		Game.ImageUtil.SetRawImageAlpha(self._rawImg, 1)

		self._amRt = rt
	end
end

function PetPhotoShow:doTargetContainerScaleTween(scale, duration)
	duration = duration or 0

	if self._photoEffect then
		self._photoEffect:doTargetContainerScaleTween(scale, duration)
	end
end

function PetPhotoShow:doTargetContainerPosTween(x, y, duration)
	x = x or 0
	y = y or x
	duration = duration or 0

	if self._photoEffect then
		self._photoEffect:doTargetContainerPosTween(x, y, duration)
	end
end

function PetPhotoShow:setActivate(isActive)
	if self._photoEffect then
		local go = self._photoEffect:getGo()

		GameUtil.SetActive(go, isActive)
	end
end

return PetPhotoShow
