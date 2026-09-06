-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatartool/AvatarPhotoShow.lua

module("logiccommon.common.avatar.new.avatartool.AvatarPhotoShow", package.seeall)

local AvatarPhotoShow = class("AvatarPhotoShow")

function AvatarPhotoShow:ctor(container)
	self._go = container.gameObject
	self._rawImg = container:GetComponent(typeof(UnityEngine.UI.RawImage)) or container:AddComponent(typeof(UnityEngine.UI.RawImage))

	Game.ImageUtil.SetRawImageAlpha(self._rawImg, 0)

	self._rawImg.raycastTarget = false
	self._photoEffect = PhotoEffect.Get(self._go)

	self._photoEffect._photo:TurnOn()

	self._showAvatars = nil
	self._isFirstShow = true
	self._camLocPos = {
		z = 0,
		x = 0,
		y = 0
	}
	self._camLocRotate = {
		z = 0,
		x = 0,
		y = 0
	}
	self._rtAdjust = {
		w = 0.5,
		z = 1,
		x = 1,
		y = 1
	}
	self._camSize = 3
	self._isOrthographic = true
	self._width = 1280
	self._height = 720
	self._setRawImgNativeSize = true
	self._multiLoader = MultiResLoader.New()
	self._resMat = nil
	self._resMatPath = "post/materials/ui_clip_rt.mat"
end

function AvatarPhotoShow:setRawWidthAndHeight(w, h)
	self._width = checknumber(w)
	self._height = checknumber(h)
end

function AvatarPhotoShow:setRawImgNativeSize(setNativeSize)
	self._setRawImgNativeSize = setNativeSize
end

function AvatarPhotoShow.Get(go)
	local component = Framework.LuaComponentContainer.Get(go, AvatarPhotoShow)

	component = component or Framework.LuaComponentContainer.Add(go, AvatarPhotoShow)

	return component
end

function AvatarPhotoShow:_onMatLoaded(res)
	if res.ResPath == self._resMatPath and res.IsSuccess then
		self._resMat = res:GetAsset(nil, nil)
		self._rawImg.material = self._resMat

		self:resetRTImgMat()
	end
end

function AvatarPhotoShow:addShowAvatarEffect(avatar, isNotLoad)
	self._showAvatars = self._showAvatars or {}

	if not table.keyof(self._showAvatars, avatar) then
		table.insert(self._showAvatars, avatar)
	end

	if not self._resMat then
		self._multiLoader:addResPath(self._resMatPath, true)
		self._multiLoader:load(nil, self._onMatLoaded, self)
	end

	avatar:setLayer(SceneLayer.UI3D_Value)

	local avatarGo = avatar:getGameObject()

	if avatarGo then
		self:showAvatarGoEff(avatar)
	else
		avatar:addListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
		avatar:addListener(AvatarNotify.OnMountLoaded, self._onMountLoaded, self)

		if not isNotLoad then
			avatar:updateState()
		end
	end
end

function AvatarPhotoShow:setFirstAddParent(avatarLoadedhandle, avatarLoadedhandleObj)
	self._avatarLoadedhandle = avatarLoadedhandle
	self._avatarLoadedhandleObj = avatarLoadedhandleObj
end

function AvatarPhotoShow:_onAvatarLoaded(avatar)
	self:showAvatarGoEff(avatar)

	if self._avatarLoadedhandle then
		if self._avatarLoadedhandleObj then
			self._avatarLoadedhandle(self._avatarLoadedhandleObj)
		else
			self._avatarLoadedhandle()
		end
	end
end

function AvatarPhotoShow:_onMountLoaded(mount)
	if mount then
		::label_9_0::

		local var_9_0 = mount._ctrl

		if mount._ctrl then
			local avatar = mount._ctrl._avatar

			if avatar then
				self:showAvatarGoEff(avatar)
			end
		end
	end
end

function AvatarPhotoShow:setCameraPosition(x, y, z)
	self._camLocPos.x = checknumber(x)
	self._camLocPos.y = checknumber(y)
	self._camLocPos.z = checknumber(z)

	self:resetCamPos()
end

function AvatarPhotoShow:resetCamPos()
	if self._isFirstShow then
		return
	end

	self._photoEffect:setCameraPosition(self._camLocPos.x, self._camLocPos.y, self._camLocPos.z)
end

function AvatarPhotoShow:setCameraRotation(x, y, z)
	self._camLocRotate.x = checknumber(x)
	self._camLocRotate.y = checknumber(y)
	self._camLocRotate.z = checknumber(z)

	self:resetCamRotate()
end

function AvatarPhotoShow:resetCamRotate()
	if self._isFirstShow then
		return
	end

	self._photoEffect:setCameraRotation(self._camLocRotate.x, self._camLocRotate.y, self._camLocRotate.z)
end

function AvatarPhotoShow:setCamSize(size)
	local setSize = checknumber(size)

	if setSize > 0 then
		self._camSize = setSize

		self:resetCamSize()
	end
end

function AvatarPhotoShow:resetCamSize()
	if self._isFirstShow then
		return
	end

	self._photoEffect:setCameraSize(self._camSize)
end

function AvatarPhotoShow:setCamOrthographicState(isOrthographic)
	self._isOrthographic = checkbool(isOrthographic)

	self:resetCamOrthographicState()
end

function AvatarPhotoShow:resetCamOrthographicState()
	if self._isFirstShow then
		return
	end

	local camera = self._photoEffect._photo.producer.rtCamera

	camera.orthographic = self._isOrthographic
end

function AvatarPhotoShow:setTargetContainerLocalRotation(x, y, z)
	if self._photoEffect and self._photoEffect._photo and self._photoEffect._photo.producer and self._photoEffect._photo.producer.targetContainer then
		Framework.TransformUtil.SetLocalRotation(self._photoEffect._photo.producer.targetContainer.transform, x, y, z)
	end
end

function AvatarPhotoShow:getTargetContainerLocalRotation()
	if self._photoEffect and self._photoEffect._photo and self._photoEffect._photo.producer and self._photoEffect._photo.producer.targetContainer then
		return self._photoEffect._photo.producer.targetContainer.transform.localRotation
	end
end

function AvatarPhotoShow:showAvatarGoEff(avatar)
	local avatarGo = avatar:getGameObject()

	self._photoEffect:showEffectsFullScreenWithTarget(avatarGo, true, self._width, self._height)

	local parent = avatarGo.transform.parent
	local curParent = avatar:getParent()

	if not curParent and parent then
		avatar:setParent(parent)
		GameUtil.setLocalRotation(parent, 0, 180, 0)

		if avatar:getAvatarCreateType() == AvatarCreateType.Player then
			avatar.mountCtrl:_updateMountState()
		end
	end

	if self._setRawImgNativeSize then
		self._rawImg:SetNativeSize()
	end

	if self._isFirstShow then
		self._rawImg.material = self._resMat

		Game.ImageUtil.SetRawImageAlpha(self._rawImg, 1)

		self._isFirstShow = false
	end

	self:resetCamPos()
	self:resetCamRotate()
	self:resetCamOrthographicState()
	self:resetCamSize()
	self:resetRTImgMat()
end

function AvatarPhotoShow:setRTAdjust(x, y, z, w)
	self._rtAdjust.x = checknumber(x)
	self._rtAdjust.y = checknumber(y)
	self._rtAdjust.z = checknumber(z)
	self._rtAdjust.w = checknumber(w)

	self:resetRTImgMat()
end

function AvatarPhotoShow:resetRTImgMat()
	if self._photoEffect and self._photoEffect._photo and self._photoEffect._photo.producer then
		local camera = self._photoEffect._photo.producer.rtCamera

		if not camera or not camera.targetTexture then
			return
		end

		if self._resMat then
			self._resMat:SetTexture("_MainTex", camera.targetTexture)
			self._resMat:SetVector("_AdjustParam", Vector4.New(self._rtAdjust.x, self._rtAdjust.y, self._rtAdjust.z, self._rtAdjust.w))
		end
	end
end

function AvatarPhotoShow:clear()
	self._avatarLoadedhandle = nil
	self._avatarLoadedhandleObj = nil
	self._isFirstShow = true

	if self._showAvatars then
		for _, v in pairs(self._showAvatars) do
			v:removeListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
			v:removeListener(AvatarNotify.OnMountLoaded, self._onMountLoaded, self)
			v:reset(true)
		end
	end

	self._photoEffect:clear()
	GameUtil.unloadMultiResLoaderResource(self._multiLoader)
	self._multiLoader:clear()

	self._resMat = nil
	self._showAvatars = nil
end

return AvatarPhotoShow
