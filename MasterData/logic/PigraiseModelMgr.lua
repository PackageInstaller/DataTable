-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/controller/PigraiseModelMgr.lua

module("logic.extensions.pigraise.controller.PigraiseModelMgr", package.seeall)

local PigraiseModelMgr = class("PigraiseModelMgr")

function PigraiseModelMgr:ctor()
	self:onReset()
end

function PigraiseModelMgr:onReset()
	self:_resetPhotoEffect()
end

function PigraiseModelMgr:_resetPhotoEffect()
	removetimer(self._clearPhotoEffect, self)

	self._vieWithModelList = {}
	self._imgGo = nil
	self._img = nil
	self._photoEff = nil
	self._modelGo = nil
	self._photoIsReady = false

	self:_removeAvatarPet()
end

function PigraiseModelMgr:preLoadPhotoEffect()
	if not self._photoIsReady then
		self._imgGo = UnityEngine.GameObject.New("rawImg")

		Framework.GameObjectUtil.SetLayerRecursively(self._imgGo, SceneLayer.UI_Value)
		goutil.setActive(self._imgGo, false)

		self._img = goutil.addComponentOnce(self._imgGo, ComponentType.RawImage)
		self._photoEff = PhotoEffect.Get(self._imgGo)

		Game.ImageUtil.SetRawImageAlpha(self._img, 0)

		self._resetMat = true

		self:_createAvatarPet()

		self._photoIsReady = true
	end
end

function PigraiseModelMgr:_createRTMat(_call_back)
	if self._matRes then
		return
	end

	self._matResLoader = MultiResLoader.New()
	self._matResourcesList = {}

	table.insert(self._matResourcesList, "post/materials/ui_clip_rt.mat")
	self._matResLoader:setResPaths(self._matResourcesList)
	self._matResLoader:load(function()
		self._matRes = {}

		for i = 1, #self._matResourcesList do
			self._matRes[i] = self._matResLoader:getResource(self._matResourcesList[i])
		end

		if _call_back then
			_call_back()
		end
	end, nil, self)
end

function PigraiseModelMgr:_clearRTMatRes()
	if self._matResLoader then
		GameUtil.unloadMultiResLoaderResource(self._matResLoader)

		self._matResLoader = nil
	end

	if self._matRes then
		for i = 1, #self._matRes do
			if self._matRes[i] ~= nil then
				self._matRes[i] = nil
			end
		end

		self._matRes = nil
	end
end

function PigraiseModelMgr:_createAvatarPet()
	if not self._avatarPet then
		self._avatarPet = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Pig)

		self._avatarPet:addListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
	end
end

function PigraiseModelMgr:_removeAvatarPet()
	if self._avatarPet then
		self._avatarPet:removeListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
		AvatarsMgrNew.instance:removeAvatar(self._avatarPet)

		self._avatarPet = nil
		self._avatarPetGo = nil
	end
end

function PigraiseModelMgr:_onAvatarLoaded(avatarPet)
	if avatarPet == self._avatarPet then
		self._avatarPetGo = self._avatarPet:getGameObject()

		Framework.TransformUtil.SetLocalScale(self._avatarPetGo.transform, 5, 5, 5)
		self._photoEff:showEffectsFullScreenWithTarget(self._avatarPetGo, true, 1280, 720)
		self._avatarPet:setLayer(Framework.LayerUtil.NameToLayer(SceneLayer.UI3D))
		self._photoEff:setCameraPosition(0, 2, -10)
		self._photoEff:setCameraRotation(0, 0, 0)

		local camera = self._photoEff._photo.producer.rtCamera

		camera.orthographic = true

		if self._resetMat then
			self._img.material = nil
			self._resetMat = false
		end

		self:SetRTImgMat(camera)
		self._img:SetNativeSize()
		Game.ImageUtil.SetRawImageAlpha(self._img, 1)

		if self._vieWithModelList then
			if self._vieWithModelList then
				if not self._vieWithModelList.rotationY then
					local rotationY = 0

					self:setModelRotationY(rotationY)
					goutil.setActive(self._imgGo, true)
					GlobalDispatcher:dispatch(GlobalNotify.PigRaiseModelUpdate)
				end
			end
		end
	end
end

function PigraiseModelMgr:SetRTImgMat(camera, _adjustParam)
	if not camera or not camera.targetTexture then
		return
	end

	_adjustParam = _adjustParam or {
		w = 0.5,
		z = 1,
		x = 1,
		y = 1
	}

	self:_createRTMat(function()
		if not self._matRes or not self._matRes[1] then
			return
		end

		self._img.material = self._matRes[1]:GetMainAsset()

		self._img.material:SetTexture("_MainTex", camera.targetTexture)
		self._img.material:SetVector("_AdjustParam", Vector4.New(_adjustParam.x, _adjustParam.y, _adjustParam.z, _adjustParam.w))
	end)
end

function PigraiseModelMgr:pushViewWithModel(go, viewname, localscale, localRotationY)
	if not go.transform then
		return
	end

	local scale = localscale or 1
	local viewWithModel = {}

	viewWithModel.go = go
	viewWithModel.name = viewname
	viewWithModel.scale = scale
	viewWithModel.rotationY = localRotationY or 0

	table.insert(self._vieWithModelList, viewWithModel)

	if not self._photoIsReady then
		self:preLoadPhotoEffect()
	end

	local avatarPetMo = PigraiseModel.instance:getPigAvatarMo()

	self._avatarPet:updateByMo(avatarPetMo)
	self._imgGo.transform:SetParent(go.transform)
	Framework.TransformUtil.SetLocalScale(self._imgGo.transform, scale, scale, scale)
	Framework.TransformUtil.SetLocalPos(self._imgGo.transform, 0, 0, 0)

	if self._avatarPetGo then
		local avatarPetMo = PigraiseModel.instance:getPigAvatarMo()

		self._avatarPet:updateByMo(avatarPetMo)
		goutil.setActive(self._imgGo, true)
	end

	local tem = self._vieWithModelList[#self._vieWithModelList]

	if tem then
		if not tem.rotationY then
			local rotationY = 0

			self:setModelRotationY(rotationY)
			removetimer(self._clearPhotoEffect, self)
		end
	end
end

function PigraiseModelMgr:popViewWithModel(viewname)
	goutil.setActive(self._imgGo, false)

	local index = 0

	for i = 1, #self._vieWithModelList do
		if self._vieWithModelList[i].name == viewname then
			index = i
		end
	end

	if index == 0 then
		goutil.setActive(self._imgGo, true)

		return
	end

	table.remove(self._vieWithModelList, index)

	local listLength = #self._vieWithModelList

	if listLength > 0 then
		self._imgGo.transform:SetParent(self._vieWithModelList[listLength].go.transform)

		local scale = self._vieWithModelList[listLength].scale
		local rotationY = self._vieWithModelList[listLength].rotationY

		Framework.TransformUtil.SetLocalScale(self._imgGo.transform, scale, scale, scale)
		Framework.TransformUtil.SetLocalPos(self._imgGo.transform, 0, 0, 0)
		goutil.setActive(self._imgGo, true)
		self:setModelRotationY(rotationY)
	else
		self._imgGo.transform:SetParent(nil)
		settimer(5, self._clearPhotoEffect, self)
	end
end

function PigraiseModelMgr:_clearPhotoEffect()
	self:_clearRTMatRes()
	self._photoEff:clear()
	goutil.destroy(self._imgGo)
	self:_resetPhotoEffect()
end

function PigraiseModelMgr:setModelRotationY(rotationY)
	local localRotationY = rotationY or 180

	if self._avatarPetGo then
		Framework.TransformUtil.SetLocalRotation(self._avatarPetGo.transform, 0, localRotationY, 0)
	end
end

function PigraiseModelMgr:onModelTrun(deltaX)
	if self._avatarPetGo then
		local localRotation = Quaternion.Euler(0, -0.5 * deltaX * 1, 0) * self._avatarPetGo.transform.localRotation
		local eulerAngles = localRotation.eulerAngles

		self:setModelRotationY(eulerAngles.y)
	end
end

function PigraiseModelMgr:getModelInfo()
	local hair, tail, skin = 1, 1, 1

	if self._avatarPet then
		local skinInfo = self._avatarPet.avatarmo:getDataByType(4)

		skin = skinInfo % 10

		local tailInfo = self._avatarPet.avatarmo:getDataByType(110)

		tail = tailInfo % 10
	end

	return hair, tail, skin
end

function PigraiseModelMgr:getAvatarPet()
	if self._avatarPet then
		return self._avatarPet
	end

	return nil
end

PigraiseModelMgr.instance = PigraiseModelMgr.New()

return PigraiseModelMgr
