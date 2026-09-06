-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/rank/PetTop5RankAvatar.lua

module("logic.extensions.handbook.view.rank.PetTop5RankAvatar", package.seeall)

local PetTop5RankAvatar = class("PetTop5RankAvatar")

function PetTop5RankAvatar.AddOnce(go)
	local component = PetTop5RankAvatar.Get(go)

	component = component or Framework.LuaComponentContainer.Add(go, PetTop5RankAvatar)

	return component
end

function PetTop5RankAvatar.Remove(go)
	Framework.LuaComponentContainer.Remove(go, PetTop5RankAvatar)
end

function PetTop5RankAvatar.Get(go)
	return (Framework.LuaComponentContainer.Get(go, PetTop5RankAvatar))
end

function PetTop5RankAvatar:ctor(container)
	self._container = container.gameObject

	self:onBuildUI()
end

function PetTop5RankAvatar:onBuildUI()
	self._isloaded = true
	self._objPoint = goutil.findChild(self._container, "Obj_Point")
end

function PetTop5RankAvatar:setAvatarActive(value)
	if self._objPoint then
		self._objPoint:SetActive(value == true)
	end
end

function PetTop5RankAvatar:OnDestroy()
	self:_destroyCharactor()
end

function PetTop5RankAvatar:onEnter()
	return
end

function PetTop5RankAvatar:onExit()
	self:_removeAvatar()
end

function PetTop5RankAvatar:initAvatar(data)
	self._data = data

	if not self._resShadowPath then
		self._resShadowPath = CommonResPath.CharacterShadow

		getres(self._resShadowPath, self._onRoleShadowLoaded, self, ResType.AssetBundle, true)
	end

	self:_createAvatar()

	local avatarMo = DressModel.instance:getAvatarMoByGrCosAndMount(self._data.gender, self._data.clothes)

	self._avatar:updateByMo(avatarMo)
end

function PetTop5RankAvatar:_createAvatar()
	if not self._avatar then
		self._avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)
		self._avatar.useType = AvatarUseType.Scene

		self._avatar:setParent(self._objPoint.transform)
		self._avatar:setLayer(SceneLayer.UI3D_Value)
		self._avatar:addListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
	end
end

function PetTop5RankAvatar:_removeAvatar()
	if self._avatar then
		self._avatar:removeListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
		AvatarsMgrNew.instance:removeAvatar(self._avatar)

		self._avatar = nil
	end
end

function PetTop5RankAvatar:_onAvatarLoaded(avatar)
	if avatar == self._avatar then
		PowerCheckController.instance:localNotify(PowerCheckController.RoleResLoadFinish)

		local animator = avatar.animatorCtrl:getAnimator()

		if animator then
			animator:SetBool("ui", false)
		end

		self:_udpateMatParam()
	end
end

function PetTop5RankAvatar:_udpateMatParam()
	self:_changePlayerNakeMat()
	self:_changePlayerFaceMat()
	self:_changePlayerHairMat()
end

function PetTop5RankAvatar:_changePlayerNakeMat()
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

function PetTop5RankAvatar:_changePlayerFaceMat()
	local faceObje = self._avatar:getBoneByName(self._avatar and self._avatar.avatarmo and self._avatar.avatarmo.skeleton and self._avatar.avatarmo.skeleton == 2 and AnimatorHash.maleBlendShapeName or AnimatorHash.femaleBlendShapeName)

	if faceObje then
		local skinedMeshRenderer = faceObje:GetComponent(ComponentType.SkinnedMeshRenderer)

		if skinedMeshRenderer and skinedMeshRenderer.material then
			skinedMeshRenderer.material:SetFloat("_worldLight", 0)
		end
	end
end

function PetTop5RankAvatar:_changePlayerHairMat()
	local var_17_0 = self._avatar

	if self._avatar then
		var_17_0 = self._avatar.pendantsCtrl

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

function PetTop5RankAvatar:_onRoleShadowLoaded(res)
	if not self._resShadowPath then
		self:_destroyShadow()

		return
	end

	if res and res.IsSuccess then
		self._charactorShadowRes = res

		self._charactorShadowRes:Retain()

		self._charactorShadow = goutil.clone(res:GetMainAsset())

		goutil.addChildToParent(self._charactorShadow, self._objPoint.transform)
		goutil.setActive(self._charactorShadow, true)
		Framework.GameObjectUtil.SetLayerRecursively(self._charactorShadow, SceneLayer.UI3D_Value)
		Framework.TransformUtil.SetLocalPos(self._charactorShadow.transform, -0.02, 0.02, 0)
		Framework.TransformUtil.SetLocalScale(self._charactorShadow.transform, 0.7, 0.7, 1)
		Framework.TransformUtil.SetLocalRotation(self._charactorShadow.transform, 0, 0, 0)
	end
end

function PetTop5RankAvatar:_destroyCharactor()
	self:_removeAvatar()

	self._resPath = nil
end

function PetTop5RankAvatar:_destroyShadow()
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

return PetTop5RankAvatar
