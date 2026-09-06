-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/pool/RoleObjectPool.lua

module("logiccommon.common.viewlib.pool.RoleObjectPool", package.seeall)

local RoleObjectPool = class("RoleObjectPool")

RoleObjectPool.delayRecycleTime = 10

local Type_SkeletonGraphic = typeof(Spine.Unity.SkeletonGraphic)

function RoleObjectPool:ctor()
	local go = goutil.create(self.__cname, false)

	go:SetActive(false)

	self._root = go.transform
	self._pools = {}
end

function RoleObjectPool:lateUpdate()
	for path, loader in pairs(self._pools) do
		loader:lateUpdate()

		if loader:checkCanDestroy(RoleObjectPool.delayRecycleTime) then
			self.willDelete = self.willDelete or {}

			table.insert(self.willDelete, path)
		end
	end

	if self.willDelete then
		for k, v in ipairs(self.willDelete) do
			local temLoader = self._pools[v]

			temLoader:Destroy()

			self._pools[v] = nil
		end

		self.willDelete = nil
	end
end

function RoleObjectPool:getRoleLoader(path)
	local loader = self._pools[path]

	if loader == nil then
		loader = RoleLoader.New(path)
		self._pools[path] = loader
	end

	return loader
end

function RoleObjectPool:getSpineAsset(path, callBack)
	local loader

	if not string.nilorempty(path) then
		loader = self:getRoleLoader(path)

		loader:loadAsset(callBack)

		return loader, callBack
	else
		GameUtil.callBack(callBack, nil)
	end

	return loader, callBack
end

function RoleObjectPool:getRoleAsset(skinId, callBack, isAuto)
	if isAuto == nil then
		isAuto = true
	end

	local loader
	local idx, path = CharacterConfig.instance:GetCharacterResIdx(skinId, isAuto)

	return self:getSpineAsset(path, callBack)
end

function RoleObjectPool:resetLoader(loader, callBack, go)
	self:_resetObject(go)

	if loader ~= nil and loader.rmCallBack then
		loader:rmCallBack(callBack)
		loader:retrunObject(go)
	end

	return nil, nil, nil
end

function RoleObjectPool:_resetObject(obj)
	if not goutil.isNil(obj) and not goutil.isNil(obj.transform) then
		obj.transform:SetParent(self._root)
		obj:SetActive(false)
	end
end

function RoleObjectPool:removeRole(obj)
	obj = obj or {}
	obj.loader, obj.callBack, obj.asset = self:resetLoader(obj.loader, obj.callBack, obj.asset)

	return obj
end

function RoleObjectPool:addRoleToParent(obj, skinId, parent, scale, callBack, lihui, x, y)
	local scaleX, scaleY, scaleZ = 1, 1, 1

	if type(scale) == "table" then
		scaleX = scale[1] or 1
		scaleY = scale[2] or 1
		scaleZ = scale[3] or 1
	else
		scaleX = scale or 1
		scaleY = scaleX
		scaleZ = scaleX
	end

	scaleY = math.abs(scaleY)
	scaleZ = math.abs(scaleZ)
	x = x or 0
	y = y or 0
	obj = self:removeRole(obj)
	obj.loader, obj.callBack = self:getRoleAsset(skinId, function(go)
		if go ~= nil then
			go:SetActive(true)
			goutil.addChildToParent(go, parent)
			Framework.TransformUtil.SetLocalScale(go.transform, scaleX, scaleY, scaleZ)
			Framework.TransformUtil.SetLocalRotation(go.transform, 0, 0, 0)
			Framework.TransformUtil.SetLocalPos(go.transform, x, y, 0)

			obj.asset = go
		end

		GameUtil.callBack(callBack, go)
	end, lihui)

	return obj
end

function RoleObjectPool:addPosterToParent(obj, posterId, isChange, parent, displayBagOffset, callBack)
	local posterCfg = PetSkinConfig.instance:getPosterModelCo(posterId)
	local url = GameUrl.getPosterUISpineUrl(posterCfg.resName)

	if isChange and not string.nilorempty(posterCfg.resNameExt) then
		url = GameUrl.getPosterUISpineUrl(posterCfg.resNameExt)
	end

	if displayBagOffset == nil then
		displayBagOffset = posterCfg.zoom
	end

	obj = self:removeRole(obj)
	obj.loader, obj.callBack = self:getSpineAsset(url, function(go)
		if go ~= nil then
			go:SetActive(true)
			goutil.addChildToParent(go, parent)

			local scale = 1
			local x, y = 0, 0

			if displayBagOffset then
				x = checknumber(displayBagOffset[1])
				y = checknumber(displayBagOffset[2])
				scale = displayBagOffset[3] or 1
			end

			Framework.TransformUtil.SetLocalScale(go.transform, scale, math.abs(scale), 1)
			Framework.TransformUtil.SetLocalRotation(go.transform, 0, 0, 0)
			Framework.TransformUtil.SetLocalPos(go.transform, x, y, 0)

			obj.asset = go

			GameUtil.callBack(callBack, go)
		end
	end)

	return obj
end

function RoleObjectPool:removeHead(obj)
	if obj and not goutil.isNil(obj.asset) then
		local graphic = goutil.findChildComponent(obj.asset, "skeleton", Type_SkeletonGraphic)

		if graphic ~= nil then
			if graphic.material ~= nil then
				local mat = graphic.material

				mat.mainTexture = nil

				SimpleMaterialLoader.instance:recycleInstanceMat(CommonResPath.SpineSkeletonGraphicMat, mat)
			end

			SystemReflexHelp.setSkeletonGraphicPmaVertexColors(graphic, true)
		end
	end

	return self:removeRole(obj)
end

function RoleObjectPool:addHeadToParent(obj, type, id, parent, callBack)
	obj = self:removeHead(obj)
	obj.loader, obj.callBack = self:getHeadAsset(type, id, function(go)
		if go ~= nil then
			go:SetActive(true)
			goutil.addChildToParent(go, parent)
			Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)
			Framework.TransformUtil.SetLocalRotation(go.transform, 0, 0, 0)
			Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)

			obj.asset = go

			local graphic = goutil.findChildComponent(go, "skeleton", Type_SkeletonGraphic)

			if graphic ~= nil then
				local mat = SimpleMaterialLoader.instance:getInstanceMat(CommonResPath.SpineSkeletonGraphicMat)

				if mat then
					mat.mainTexture = graphic.material.mainTexture
					graphic.material = mat

					SystemReflexHelp.setSkeletonGraphicPmaVertexColors(graphic, false)
				end
			end
		end

		GameUtil.callBack(callBack, go)
	end)

	return obj
end

function RoleObjectPool:getHeadAsset(type, id, callBack)
	local cfg = MaterialMgr.getMatCfg(type, id)
	local icon = cfg.icon
	local path = GameUrl.getHeadSpineUIUrl(icon)

	return self:getSpineAsset(path, callBack)
end

function RoleObjectPool:destroyAll()
	for path, loader in pairs(self._pools) do
		self.willDelete = self.willDelete or {}

		table.insert(self.willDelete, path)
	end

	if self.willDelete then
		for k, v in ipairs(self.willDelete) do
			local temLoader = self._pools[v]

			temLoader:Destroy()

			self._pools[v] = nil
		end

		self.willDelete = nil
	end
end

function RoleObjectPool:getCurAnimationName(go)
	if not go then
		return
	end

	local graphic = go:GetComponentInChildren(Type_SkeletonGraphic)

	if graphic then
		return graphic.startingAnimation
	end

	return nil
end

function RoleObjectPool:playAnimation(go, animName, loop, callBack, reStart)
	if not go then
		return
	end

	local graphic = go:GetComponentInChildren(Type_SkeletonGraphic)

	if graphic then
		local sk = graphic.skeletonDataAsset

		if sk ~= nil then
			local data = sk:GetAnimationStateData()
			local skd = data.SkeletonData
			local ani = skd:FindAnimation(animName)

			if reStart then
				graphic.AnimationState:ClearTracks()
			end

			if ani ~= nil then
				graphic:Initialize(true)

				graphic.startingAnimation = animName

				graphic.AnimationState:SetAnimation(0, animName, loop)
				graphic:Update(0)

				local onComplete

				function onComplete()
					GameUtil.callBack(callBack)

					graphic.AnimationState.Complete = graphic.AnimationState.Complete - onComplete
				end

				graphic.AnimationState.Complete = graphic.AnimationState.Complete + onComplete
			end
		end
	end
end

function RoleObjectPool:addSpineToParent(obj, path, parent, scale, callBack, x, y)
	local scaleX, scaleY, scaleZ = 1, 1, 1

	if type(scale) == "table" then
		scaleX = scale[1] or 1
		scaleY = scale[2] or 1
		scaleZ = scale[3] or 1
	else
		scaleX = scale or 1
		scaleY = scaleX
		scaleZ = scaleX
	end

	scaleY = math.abs(scaleY)
	scaleZ = math.abs(scaleZ)
	x = x or 0
	y = y or 0
	obj = self:removeRole(obj)
	obj.loader, obj.callBack = self:getSpineAsset(path, function(go)
		if go ~= nil then
			go:SetActive(true)
			goutil.addChildToParent(go, parent)
			Framework.TransformUtil.SetLocalPos(go.transform, x, y, 0)
			Framework.TransformUtil.SetLocalScale(go.transform, scaleX, scaleY, scaleZ)

			obj.asset = go
		end

		GameUtil.callBack(callBack, go)
	end)

	return obj
end

RoleObjectPool.instance = RoleObjectPool.New()

return RoleObjectPool
