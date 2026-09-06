-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/mainview/PalyerAvatarCtrl.lua

module("logic.extensions.tutorsystem.view.mainview.PalyerAvatarCtrl", package.seeall)

local PalyerAvatarCtrl = class("PalyerAvatarCtrl")

function PalyerAvatarCtrl.AddOnce(go)
	local component = PalyerAvatarCtrl.Get(go)

	component = component or Framework.LuaComponentContainer.Add(go, PalyerAvatarCtrl)

	return component
end

function PalyerAvatarCtrl.Remove(go)
	Framework.LuaComponentContainer.Remove(go, PalyerAvatarCtrl)
end

function PalyerAvatarCtrl.Get(go)
	return (Framework.LuaComponentContainer.Get(go, PalyerAvatarCtrl))
end

function PalyerAvatarCtrl:ctor(container)
	self._container = container.gameObject
	self._isloaded = true
end

function PalyerAvatarCtrl:setAvatarActive(value)
	self._container:SetActive(value == true)
end

function PalyerAvatarCtrl:destroy()
	self:_destroyCharactor()
end

function PalyerAvatarCtrl:initAvatar(data)
	self._data = data

	if not self._resShadowPath then
		self._resShadowPath = CommonResPath.CharacterShadow

		getres(self._resShadowPath, self._onRoleShadowLoaded, self, ResType.AssetBundle, true)
	end

	self:_createAvatar()

	local avatarMo = DressModel.instance:getAvatarMoByGrCosAndMount(self._data.gender, self._data.clothes)

	self._avatar:updateByMo(avatarMo)
end

function PalyerAvatarCtrl:_createAvatar()
	if not self._avatar then
		self._avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)
		self._avatar.useType = AvatarUseType.Scene

		self._avatar:setParent(self._container.transform)
		self._avatar:setLayer(SceneLayer.UI3D_Value)
		self._avatar:addListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
	end
end

function PalyerAvatarCtrl:_removeAvatar()
	if self._avatar then
		self._avatar:removeListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
		AvatarsMgrNew.instance:removeAvatar(self._avatar)

		self._avatar = nil
	end
end

function PalyerAvatarCtrl:_onAvatarLoaded(avatar)
	if avatar == self._avatar then
		PowerCheckController.instance:localNotify(PowerCheckController.RoleResLoadFinish)

		local animator = avatar.animatorCtrl:getAnimator()

		if animator then
			animator:SetBool("ui", false)
		end

		self:_udpateMatParam()
	end
end

function PalyerAvatarCtrl:_udpateMatParam()
	self:_changePlayerNakeMat()
	self:_changePlayerFaceMat()
	self:_changePlayerHairMat()
end

function PalyerAvatarCtrl:_changePlayerNakeMat()
	for k, v in pairs(self._avatar.avatarmo:getOwnNakeParts()) do
		local nakeparts = self._avatar:getBoneByName(AvatarNakePartTypeName[v])

		if nakeparts then
			local skinedMeshRenderer = nakeparts:GetComponent(ComponentType.SkinnedMeshRenderer)

			if skinedMeshRenderer and skinedMeshRenderer.material then
				skinedMeshRenderer.material:SetFloat("_worldLight", 0)
			end
		end
	end
end

function PalyerAvatarCtrl:_changePlayerFaceMat()
	local faceObje = self._avatar:getBoneByName(self._avatar and self._avatar.avatarmo and self._avatar.avatarmo.skeleton and self._avatar.avatarmo.skeleton == 2 and AnimatorHash.maleBlendShapeName or AnimatorHash.femaleBlendShapeName)

	if faceObje then
		local skinedMeshRenderer = faceObje:GetComponent(ComponentType.SkinnedMeshRenderer)

		if skinedMeshRenderer and skinedMeshRenderer.material then
			skinedMeshRenderer.material:SetFloat("_worldLight", 0)
		end
	end
end

function PalyerAvatarCtrl:_changePlayerHairMat()
	local var_14_0 = self._avatar

	if self._avatar then
		var_14_0 = self._avatar.pendantsCtrl

		if self._avatar.pendantsCtrl then
			local _pendants = self._avatar.pendantsCtrl._pendants

			if not _pendants then
				return
			end

			local hair = _pendants[AvatarPendantType.Hair]

			if not hair then
				return
			end

			local hairGo = hair:getGameObject()

			if not hairGo then
				return
			end

			local hairGoRender = hairGo:GetComponentsInChildren(ComponentType.SkinnedMeshRenderer)

			if not hairGoRender then
				return
			end

			for i = 0, hairGoRender.Length - 1 do
				if hairGoRender[i] and hairGoRender[i].material then
					hairGoRender[i].material:SetFloat("_worldLight", 0)
				end
			end
		end
	end
end

function PalyerAvatarCtrl:_onRoleShadowLoaded(res)
	if not self._resShadowPath then
		self:_destroyShadow()

		return
	end

	if res and res.IsSuccess then
		self._charactorShadowRes = res

		self._charactorShadowRes:Retain()

		self._charactorShadow = goutil.clone(res:GetMainAsset())

		goutil.addChildToParent(self._charactorShadow, self._container.transform)
		goutil.setActive(self._charactorShadow, true)
		Framework.GameObjectUtil.SetLayerRecursively(self._charactorShadow, SceneLayer.UI3D_Value)
		Framework.TransformUtil.SetLocalPos(self._charactorShadow.transform, -0.02, 0.02, 0)
		Framework.TransformUtil.SetLocalScale(self._charactorShadow.transform, 0.7, 0.7, 1)
		Framework.TransformUtil.SetLocalRotation(self._charactorShadow.transform, 0, 0, 0)
	end
end

function PalyerAvatarCtrl:_destroyCharactor()
	self:_removeAvatar()

	self._resPath = nil
end

function PalyerAvatarCtrl:_destroyShadow()
	if self._charactorShadow then
		goutil.destroy(self._charactorShadow, true)

		self._charactorShadow = nil
	end

	if self._charactorShadowRes then
		self._charactorShadowRes:Release()

		self._charactorShadowRes = nil
	end

	self._resShadowPath = nil
end

return PalyerAvatarCtrl
