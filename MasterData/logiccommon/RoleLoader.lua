-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/pool/RoleLoader.lua

module("logiccommon.common.viewlib.pool.RoleLoader", package.seeall)

local RoleLoader = class("RoleLoader")
local skeletonGraphicType = typeof(Spine.Unity.SkeletonGraphic)
local UnityTime = UnityEngine.Time

function RoleLoader:ctor(path)
	self.path = path
	self.res = nil
	self._asset = nil
	self._capacity = 10
	self._goPool = {}
	self.isLoading = false
	self.callBackPool = {}
	self.usingCount = 0
	self.usingTime = 0
	self._oriMatMap = {}
	self._cloneMatMap = {}
	self._oriSkelList = nil
end

function RoleLoader:loadAsset(callback)
	if self.isLoading == false and self.path then
		self.isLoading = true

		self:checkCanCallBack(callback)
		self:GetCharacterUIAsset(self.path)
	else
		self:checkCanCallBack(callback)
	end
end

function RoleLoader:GetCharacterUIAsset(resPath, cb)
	local function onLoaded(res)
		if res.IsSuccess ~= true then
			return
		end

		self.res = res

		res:Retain()

		local asset = res:GetAsset(nil, nil)

		self._asset = asset

		self:_indexOriMats(asset)

		self._oriSkelList = self:_collectSkels(asset)

		self:doAllCallBack()
	end

	getres(resPath, onLoaded, nil, ResType.AssetBundle, true)
end

function RoleLoader:checkCanCallBack(callback)
	if self._asset ~= nil then
		self:doCallBack(callback)
	elseif callback ~= nil then
		table.insert(self.callBackPool, callback)
	end
end

function RoleLoader:doCallBack(callback)
	if callback ~= nil then
		local go = self:getOrCreateRole()

		callback(go, self)
	end
end

function RoleLoader:doAllCallBack()
	for k, func in pairs(self.callBackPool) do
		self:doCallBack(func)
	end

	self.callBackPool = {}
end

function RoleLoader:rmCallBack(callBack)
	for k, func in pairs(self.callBackPool) do
		if callBack == func then
			self.callBackPool[k] = nil
		end
	end
end

function RoleLoader:getOrCreateRole()
	local count = #self._goPool
	local go

	if count < 1 then
		go = goutil.clone(self._asset)

		self:_buildCloneMatMap(go)
		self:_resetMaterialByMap(go)
	else
		go = table.remove(self._goPool)
	end

	self:_playDefaultAnim(go)

	self.usingCount = self.usingCount + 1
	self.usingTime = 0

	return go
end

function RoleLoader:retrunObject(go)
	if go ~= nil and go.transform ~= nil and not self:checkIsInPool(go) then
		local count = #self._goPool

		if count >= self._capacity then
			if self._cloneMatMap then
				self._cloneMatMap[go] = nil
			end

			goutil.destroy(go, true)
		else
			self:_resetMaterialByMap(go)
			table.insert(self._goPool, go)
		end

		self.usingCount = self.usingCount - 1
		self.usingTime = 0
	end
end

function RoleLoader:checkIsInPool(go)
	local count = #self._goPool

	if count > 0 then
		local obj

		for i = 1, count do
			if self._goPool[i] == go then
				return true
			end
		end
	end

	return false
end

function RoleLoader:lateUpdate()
	if self.usingCount <= 0 then
		self.usingTime = self.usingTime + UnityTime.deltaTime
	end
end

function RoleLoader:checkCanDestroy(usedTime)
	if self._asset and self.usingCount <= 0 and usedTime <= self.usingTime then
		return true
	end

	return false
end

function RoleLoader:clear()
	local count = #self._goPool

	if count > 0 then
		local obj

		for i = 1, count do
			goutil.destroy(self._goPool[i], true)
		end

		table.clear(self._goPool)
	end

	self.callBackPool = {}
	self._oriMatMap = nil
	self._cloneMatMap = nil
	self._oriSkelList = nil
end

function RoleLoader:Destroy()
	self:clear()

	if self.res then
		self.res:Release()
		GameUtil.unloadResource(self.res)

		self.res = nil
	end

	self._asset = nil
	self.usingCount = 0
end

function RoleLoader:_indexOriMats(go)
	self._oriMatMap = self._oriMatMap or {}

	local skelList = self:_collectSkels(go)

	for _, skelGo in ipairs(skelList) do
		local r = skelGo:GetComponent("SkeletonGraphic")

		if r ~= nil and r.material ~= nil then
			self._oriMatMap[skelGo] = r.material
		end
	end
end

function RoleLoader:_buildCloneMatMap(cloneRoot)
	if goutil.isNil(cloneRoot) or goutil.isNil(self._asset) or not self._oriSkelList then
		return
	end

	local cloneList = self:_collectSkels(cloneRoot)
	local n = math.min(#self._oriSkelList, #cloneList)

	if n <= 0 then
		return
	end

	local subMap = {}

	for i = 1, n do
		local oriGo, cloneGo = self._oriSkelList[i], cloneList[i]

		if self._oriMatMap then
			if self._oriMatMap ~= nil and not goutil.isNil(cloneGo) then
				subMap[cloneGo] = self._oriMatMap
			end
		end
	end

	self._cloneMatMap = self._cloneMatMap or {}
	self._cloneMatMap[cloneRoot] = subMap
end

function RoleLoader:_resetMaterialByMap(go)
	local var_18_0 = not goutil.isNil(go) and self._cloneMatMap and self._cloneMatMap[go] or false
	local mapRoot = true

	goto label_18_0

	::label_18_0::

	if mapRoot == nil then
		return
	end

	for cloneNode, mat in pairs(mapRoot) do
		if not goutil.isNil(cloneNode) then
			local r = cloneNode:GetComponent("SkeletonGraphic")

			if r ~= nil then
				r.material = mat
			end
		end
	end
end

function RoleLoader:_collectSkels(rootGo)
	local outList = {}

	if goutil.isNil(rootGo) then
		return outList
	end

	local stack = {
		rootGo
	}

	while #stack > 0 do
		local currentGo = table.remove(stack)
		local curTran = currentGo and currentGo.transform

		if curTran ~= nil then
			local r = currentGo:GetComponent("SkeletonGraphic")

			if r ~= nil then
				table.insert(outList, currentGo)
			end

			local childCount = curTran.childCount

			for i = childCount, 1, -1 do
				local trans = curTran:GetChild(i - 1)

				if trans ~= nil then
					table.insert(stack, trans.gameObject)
				end
			end
		end
	end

	return outList
end

function RoleLoader:_playDefaultAnim(go)
	if goutil.isNil(go) then
		return
	end

	local comps = go:GetComponentsInChildren(skeletonGraphicType)

	for i = 0, comps.Length - 1 do
		RoleObjectPool.instance:playAnimation(comps[i].gameObject, "idle", true, nil, true)
	end
end

return RoleLoader
