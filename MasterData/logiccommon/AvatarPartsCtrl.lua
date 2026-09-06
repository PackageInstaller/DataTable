-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarcontroller/AvatarPartsCtrl.lua

module("logiccommon.common.avatar.avatarcontroller.AvatarPartsCtrl", package.seeall)

local AvatarPartsCtrl = class("AvatarPartsCtrl", AvatarController)

function AvatarPartsCtrl:ctor(avatarBase)
	AvatarPartsCtrl.super.ctor(self, avatarBase)

	self._parts = nil
	self._layer = nil

	self.addListener(self, AvatarNotify.OnPartLoaded, self._onPartLoaded, self)

	self._isInit = nil

	self:_clearCombition()
end

function AvatarPartsCtrl:_getControllerType()
	return AvatarControllerType.Part
end

function AvatarPartsCtrl:onAvatarLoaded()
	AvatarPartsCtrl.super.onAvatarLoaded(self)
end

function AvatarPartsCtrl:onAvatarLoadedCallBack()
	AvatarPartsCtrl.super.onAvatarLoadedCallBack(self)

	local avatarMo = self._avatar.avatarmo

	self:updatePartsByMo(avatarMo)
end

function AvatarPartsCtrl:onAvatarInvisible()
	AvatarPartsCtrl.super.onAvatarInvisible(self)
	self:onAvatarReset()
end

function AvatarPartsCtrl:onAvatarVisible()
	AvatarPartsCtrl.super.onAvatarVisible(self)

	local avatarMo = self._avatar.avatarmo

	self:updatePartsByMo(avatarMo)
end

function AvatarPartsCtrl:onAvatarReset()
	AvatarPartsCtrl.super.onAvatarReset(self)

	if self._parts then
		for _, p in pairs(self._parts) do
			p:reset()
		end
	end

	self._isInit = nil

	self:_clearCombition()
end

function AvatarPartsCtrl:onAvatarDestroy()
	AvatarPartsCtrl.super.onAvatarDestroy(self)
	self:removeAllListener(AvatarNotify.OnPartLoaded)

	if self._parts then
		for _, p in pairs(self._parts) do
			p:destroy()
		end
	end

	self._layer = nil
	self._parts = nil

	self:_clearCombition()
end

function AvatarPartsCtrl:setLayer(layer)
	self._layer = layer

	if self._parts then
		for _, p in pairs(self._parts) do
			p:setLayer(self._layer)
		end
	end
end

function AvatarPartsCtrl:updatePartsByMo(mo)
	if not mo then
		return
	end

	self._isInit = false

	for k, v in pairs(mo:getOwnPartTypeNames()) do
		local id = mo[v].value

		if id and id > 0 then
			-- block empty
		else
			local type = table.keyof(AvatarPartTypeName, v)

			self:removePartByType(type)
		end
	end

	for k, v in pairs(mo:getOwnPartTypeNames()) do
		local id = mo[v].value

		if id and id > 0 then
			local type = table.keyof(AvatarPartTypeName, v)

			self:addPart(type, id)
		end
	end

	self._isInit = true

	if self._parts then
		if table.nums(self._parts) == 0 then
			self._avatar:dispatch(AvatarNotify.OnAllPartLoaded)
		elseif self:isAllPartLoaded() then
			self:_onLoadAll()
		end
	else
		self._avatar:dispatch(AvatarNotify.OnAllPartLoaded)
	end
end

function AvatarPartsCtrl:addPart(type, id)
	self._parts = self._parts or {}

	local partCfg = AvatarConfig.instance:getPartCfgById(id)

	if not partCfg or not partCfg.asset then
		printError((not ("partCfg get Error Id : " .. id) or nil) and "nil")

		return
	end

	local resPath = GameUrl.getAvatarPart(partCfg.asset, AvatarPartTypeName[type], self._avatar.useType, partCfg.isResSame)
	local exitPart = self._parts[type]

	if exitPart then
		if exitPart:getResPath() ~= resPath then
			exitPart:reset()

			local skeletonGo = self._avatar:getGameObject()

			exitPart:setParent(skeletonGo and skeletonGo.transform)
			exitPart:setLayer(self._layer)
			exitPart:setPartId(id)
			exitPart:setIsUseTransMat(partCfg.isUseTransMat)
		end

		exitPart:load(resPath)

		return
	end

	local part = AvatarPartNew.New(self)

	part:setPartId(id)

	local skeletonGo = self._avatar:getGameObject()

	part:setPartType(type)
	part:setParent(skeletonGo and skeletonGo.transform)
	part:setLayer(self._layer)
	part:setIsUseTransMat(partCfg.isUseTransMat)

	self._parts[type] = part

	part:load(resPath)
end

function AvatarPartsCtrl:getPartByType(type)
	if self._parts then
		return self._parts[type]
	end
end

function AvatarPartsCtrl:removePartByType(type)
	if self._parts and self._parts[type] then
		self._parts[type]:reset()
	end
end

function AvatarPartsCtrl:getAllUseCombineParts()
	local allParts = {}

	if self._parts then
		for k, v in pairs(self._parts) do
			if v:isObjLoaded() and not v:getIsUseTransMat() and v:getPartId() and v:getPartId() ~= 0 then
				table.insert(allParts, v)
			end
		end

		table.sort(allParts, function(a, b)
			return a:getPartId() < b:getPartId()
		end)
	end

	return allParts
end

function AvatarPartsCtrl:isAllPartLoaded()
	if not self._isInit then
		return false
	end

	if self._parts then
		for _, p in pairs(self._parts) do
			if not p:isObjLoaded() then
				return false
			end
		end
	end

	return true
end

function AvatarPartsCtrl:_onPartLoaded(part)
	if part and part:isObjLoaded() then
		if self:isAllPartLoaded() then
			self:_onLoadAll()
		end
	else
		print("avatar pendant is not loaded")
	end
end

function AvatarPartsCtrl:isAllUseTransMat()
	if self._parts then
		for _, p in pairs(self._parts) do
			if not p:getIsUseTransMat() then
				return false
			end
		end
	end

	return true
end

function AvatarPartsCtrl:_buildSkinMeshRenderer()
	local go = self._avatar:getGameObject()
	local render = go:GetComponent(ComponentType.SkinnedMeshRenderer)

	if render then
		UnityEngine.GameObject.DestroyImmediate(render)
	end

	self._smrender = go:AddComponent(ComponentType.SkinnedMeshRenderer)
end

function AvatarPartsCtrl:setCombition(combition)
	local go = self._avatar:getGameObject()

	if not go then
		self:_clearCombition()

		return
	end

	self:_buildSkinMeshRenderer()

	self._combition = combition
	self._smrender.sharedMesh = combition.combineMesh
	self._smrender.bones = combition.bones
	self._smrender.sharedMesh.uv = combition.uv

	local material = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/character/toon"))

	self._smrender.material = material

	material:SetTexture("_MainTex", combition.skinnedMeshAtlas.atlas)
	GoUtil.SetMatColor(material, "_HighlightCol", 1, 0.984313725490196, 0.9490196078431372, 1)
	GoUtil.SetMatColor(material, "_ShadowCol", 0.6980392156862745, 0.6470588235294118, 0.7058823529411765, 1)
	material:SetFloat("_RampThreshold", 0.2)
	material:SetFloat("_RampSmooth", 0.4)
	GoUtil.SetMatColor(material, "_RimColor", 0.30196078431372547, 0.4470588235294118, 0.4235294117647059, 1)
	material:SetFloat("_RimThreshold", 0.532)
	material:SetFloat("_RimSmooth", 0.42)
	material:SetFloat("_worldLight", LightMgr.instance:getUseModelLight() and 0 or 1)

	if self._parts then
		for _, p in pairs(self._parts) do
			if not p:getIsUseTransMat() then
				p:reset()
			end
		end
	end

	self._avatar:dispatch(AvatarNotify.OnAllPartLoaded)
end

function AvatarPartsCtrl:showOutline(_show)
	if not self._smrender or not self._smrender.material then
		return
	end

	self._smrender.material:SetShaderPassEnabled("Always", _show)
end

function AvatarPartsCtrl:_clearCombition()
	if self._combition then
		AvatarCombitionMgr.instance:removeCombition(self._combition)

		self._combition = nil
	end

	self._smrender = nil
end

function AvatarPartsCtrl:_clearSkinMeshRenderer()
	if self._smrender then
		local material = self._smrender.material

		material.mainTexture = nil
		material.sharedMesh = nil
		self._smrender.material = nil

		UnityEngine.GameObject.DestroyImmediate(material)
		UnityEngine.GameObject.DestroyImmediate(self._smrender)
	end

	self._smrender = nil
end

function AvatarPartsCtrl:_onLoadAll()
	if self._avatar.useType == AvatarUseType.UI then
		self._avatar:dispatch(AvatarNotify.OnAllPartLoaded)
	elseif self:isAllUseTransMat() then
		self:_clearCombition()
		self._avatar:dispatch(AvatarNotify.OnAllPartLoaded)
	else
		self:_clearCombition()
		AvatarCombitionMgr.instance:combineNew(self)
	end
end

return AvatarPartsCtrl
