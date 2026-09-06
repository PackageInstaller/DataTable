-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/controller/CutePetModelMgr.lua

module("logic.extensions.cutepet.controller.CutePetModelMgr", package.seeall)

local CutePetModelMgr = class("CutePetModelMgr")

function CutePetModelMgr:ctor()
	self:onReset()
end

function CutePetModelMgr:onReset()
	self._avatarPet = {}
	self._avatarPetGo = {}

	self:_resetPhotoEffect()
end

function CutePetModelMgr:_resetPhotoEffect()
	removetimer(self._clearPhotoEffect, self)

	self._vieWithModelList = {}
	self._imgGo = {}
	self._img = {}
	self._photoEff = {}
	self._modelGo = {}
	self._needShowPetMap = {}
	self._photoIsReady = false

	self:_removeAvatarPet()
end

function CutePetModelMgr:_createRTMat(_call_back)
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

function CutePetModelMgr:_clearRTMatRes()
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

function CutePetModelMgr:_createAvatarPet(index)
	if not self._avatarPet[index] then
		self._avatarPet[index] = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Pig)

		self._avatarPet[index]:addListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
	end
end

function CutePetModelMgr:_removeAvatarPet()
	for index, v in pairs(self._avatarPet or {}) do
		self._avatarPet[index]:removeListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
		AvatarsMgrNew.instance:removeAvatar(self._avatarPet[index])

		self._avatarPet[index] = nil
		self._avatarPetGo[index] = nil
	end
end

function CutePetModelMgr:_onAvatarLoaded(avatarPet)
	for i, v in ipairs(self._avatarPet) do
		if avatarPet == v then
			self._avatarPetGo[i] = v:getGameObject()

			self._photoEff[i]:showEffectsFullScreenWithTarget(self._avatarPetGo[i], true, 1280, 720)
			v:setLayer(Framework.LayerUtil.NameToLayer(SceneLayer.UI3D))
			self._photoEff[i]:setCameraPosition(0, 2, -10)
			self._photoEff[i]:setCameraRotation(0, 0, 0)

			local camera = self._photoEff[i]._photo.producer.rtCamera

			camera.orthographic = true

			local tem = self._vieWithModelList[#self._vieWithModelList]
			local offset = {
				scale = 1,
				z = 0,
				x = 0,
				y = 0
			}

			if tem then
				tem.offset = tem.offset or {}
				offset = tem.offset and tem.offset[i] or {
					scale = 1,
					z = 0,
					x = 0,
					y = 0
				}
			end

			self:setOffset(i, offset)

			self._img[i].material = nil

			self:SetRTImgMat(camera, self._img[i])
			self._img[i]:SetNativeSize()
			Game.ImageUtil.SetRawImageAlpha(self._img[i], 1)

			if self._vieWithModelList then
				local tem = self._vieWithModelList[#self._vieWithModelList]

				if tem then
					if not tem.rotationY then
						local rotationY = 180

						self:setModelRotationY(rotationY, i)
						goutil.setActive(self._imgGo[i], true)

						if self._needShowPetMap[i] then
							self._img[i].enabled = true
							self._needShowPetMap[i] = nil
						end

						GlobalDispatcher:dispatch(GlobalNotify.CutePetAvatarLoaded)

						break
					end
				end
			end
		end
	end
end

function CutePetModelMgr:SetRTImgMat(camera, img, _adjustParam)
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

		img.material = self._matRes[1]:GetMainAsset()

		img.material:SetTexture("_MainTex", camera.targetTexture)
		img.material:SetVector("_AdjustParam", Vector4.New(_adjustParam.x, _adjustParam.y, _adjustParam.z, _adjustParam.w))
	end)
end

function CutePetModelMgr:pushViewWithModel(go, viewname, count, localscale, localRotationY, offset)
	local viewWithModel = {}

	viewWithModel.go = count == 1 and {
		go
	} or go
	viewWithModel.name = viewname
	viewWithModel.count = count
	viewWithModel.scale = localscale or 1
	viewWithModel.rotationY = localRotationY or 180
	viewWithModel.offset = offset

	table.insert(self._vieWithModelList, viewWithModel)

	for i = 1, count do
		self._imgGo[i] = self._imgGo[i] or UnityEngine.GameObject.New("rawImg")

		Framework.GameObjectUtil.SetLayerRecursively(self._imgGo[i], SceneLayer.UI_Value)
		goutil.setActive(self._imgGo[i], false)

		self._img[i] = self._img[i] or goutil.addComponentOnce(self._imgGo[i], ComponentType.RawImage)

		self:isShowAvatarPet(i, true)

		self._photoEff[i] = self._photoEff[i] or PhotoEffect.Get(self._imgGo[i])

		Game.ImageUtil.SetRawImageAlpha(self._img[i], 0)
		self:_createAvatarPet(i)

		local avatarPetMo = AvatarPetMo.New()

		avatarPetMo.skeleton = 201

		avatarPetMo:setDefaultState()

		if self._avatarPet[i] then
			self._avatarPet[i]:updateByMo(avatarPetMo)
			self._imgGo[i].transform:SetParent(viewWithModel.go[i].transform)

			if offset then
				if not offset[i] then
					do
						local setOffset = {
							scale = 1,
							z = 0,
							x = 0,
							y = 0
						}

						self:setOffset(i, setOffset)

						if self._avatarPetGo[i] then
							self._avatarPet[i]:updateByMo(avatarPetMo)
							goutil.setActive(self._imgGo[i], true)
						end
					end

					local tem = self._vieWithModelList[#self._vieWithModelList]

					if tem then
						if not tem.rotationY then
							local rotationY = 180

							self:setModelRotationY(rotationY, i)
							Framework.TransformUtil.SetLocalScale(self._imgGo[i].transform, 1, 1, 1)
							Framework.TransformUtil.SetLocalPos(self._imgGo[i].transform, 0, 0, 0)
						end
					end
				end
			end
		end
	end

	removetimer(self._clearPhotoEffect, self)
end

function CutePetModelMgr:popViewWithModel(viewname)
	for i, v in ipairs(self._imgGo) do
		GameUtil.SetActive(v, false)
	end

	local index = 0

	for i = 1, #self._vieWithModelList do
		if self._vieWithModelList[i].name == viewname then
			index = i
		end
	end

	if index == 0 then
		for i, v in ipairs(self._imgGo) do
			GameUtil.SetActive(v, true)
		end

		return
	end

	table.remove(self._vieWithModelList, index)

	local listLength = #self._vieWithModelList

	if listLength > 0 then
		for i, v in pairs(self._imgGo) do
			v.transform:SetParent(nil)
		end

		for i = 1, self._vieWithModelList[listLength].count do
			self._imgGo[i].transform:SetParent(self._vieWithModelList[listLength].go[i].transform)

			local rotationY = self._vieWithModelList[listLength].rotationY
			local offset = self._vieWithModelList[listLength].offset

			if offset then
				if not offset[i] then
					local setOffset = {
						scale = 1,
						z = 0,
						x = 0,
						y = 0
					}

					self:setOffset(i, setOffset)
					GameUtil.SetActive(self._imgGo[i], true)
					self:setModelRotationY(rotationY, i)
				end
			end
		end
	else
		for i, v in pairs(self._imgGo) do
			v.transform:SetParent(nil)
		end

		settimer(5, self._clearPhotoEffect, self)
	end
end

function CutePetModelMgr:_clearPhotoEffect()
	self:_clearRTMatRes()

	for i, v in pairs(self._photoEff) do
		v:clear()
	end

	for i, v in pairs(self._imgGo) do
		goutil.destroy(v)
	end

	self:_resetPhotoEffect()
end

function CutePetModelMgr:resetModel(index, modelId)
	local avatar = self:getAvatarPet(index)

	avatar.avatarmo.skeleton = modelId

	avatar:updateState()
end

function CutePetModelMgr:setOffset(index, offset)
	local tem = self._vieWithModelList[#self._vieWithModelList]

	if tem then
		tem.offset = tem.offset or {}
		tem.offset[index] = offset

		if self._avatarPetGo[index] and offset then
			local camera = self._photoEff[index]._photo.producer.rtCamera

			Framework.TransformUtil.SetLocalScale(self._avatarPetGo[index].transform, offset.scale or 5, offset.scale or 5, offset.scale or 5)
			Framework.TransformUtil.SetLocalPos(self._avatarPetGo[index].transform, camera.transform.localPosition.x + (offset.x or 0), offset.y or self._avatarPetGo[index].transform.localPosition.y, offset.z or self._avatarPetGo[index].transform.localPosition.z)
		end
	end
end

function CutePetModelMgr:setModelRotationY(rotationY, index)
	local localRotationY = rotationY or 180

	if self._avatarPetGo[index] then
		Framework.TransformUtil.SetLocalRotation(self._avatarPetGo[index].transform, 0, localRotationY, 0)
	end
end

function CutePetModelMgr:onModelTrun(deltaX, index)
	if self._avatarPetGo[index] then
		local localRotation = Quaternion.Euler(0, -0.5 * deltaX * 1, 0) * self._avatarPetGo[index].transform.localRotation
		local eulerAngles = localRotation.eulerAngles

		self:setModelRotationY(eulerAngles.y, index)
	end
end

function CutePetModelMgr:getModelInfo(index)
	local hair, tail, skin = 1, 1, 1

	if self._avatarPet[index] then
		local skinInfo = self._avatarPet.avatarmo:getDataByType(4)

		skin = skinInfo % 10

		local tailInfo = self._avatarPet.avatarmo:getDataByType(110)

		tail = tailInfo % 10
	end

	return hair, tail, skin
end

function CutePetModelMgr:getAvatarPet(index)
	if self._avatarPet[index] then
		return self._avatarPet[index]
	end

	return nil
end

function CutePetModelMgr:isShowAvatarPet(index, isOpen)
	if self._img[index] ~= nil then
		if isOpen == true then
			if self._avatarPet[index] and self._avatarPet[index]:isLoaded() then
				self._img[index].enabled = isOpen
			else
				self._needShowPetMap[index] = true
			end
		else
			self._img[index].enabled = isOpen
			self._needShowPetMap[index] = nil
		end
	end
end

function CutePetModelMgr:playEatAnim(index)
	if self._avatarPet[index] then
		self._avatarPet[index].animatorCtrl:setTrigger(UnityEngine.Animator.StringToHash("eat"))
	end
end

function CutePetModelMgr:playTouchAnim(index)
	if self._avatarPet[index] then
		self._avatarPet[index].animatorCtrl:setTrigger(UnityEngine.Animator.StringToHash("touch"))
	end
end

function CutePetModelMgr:playAnim(index, name)
	if self._avatarPet[index] then
		self._avatarPet[index].animatorCtrl:setTrigger(UnityEngine.Animator.StringToHash(name))
	end
end

CutePetModelMgr.instance = CutePetModelMgr.New()

return CutePetModelMgr
