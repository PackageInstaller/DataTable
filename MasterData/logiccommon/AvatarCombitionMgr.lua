-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/AvatarCombitionMgr.lua

module("logiccommon.common.avatar.AvatarCombitionMgr", package.seeall)

local AvatarCombitionMgr = class("AvatarCombitionMgr")
local UnityCombineInstance = UnityEngine.CombineInstance
local UnityMesh = UnityEngine.Mesh
local CombineInstanceType = typeof(UnityEngine.CombineInstance)
local TransformType = typeof(UnityEngine.Transform)
local Vector2Type = typeof(UnityEngine.Vector2)
local combineTextures = {}
local combineInstances = {}
local combineUvs = {}
local combineBones = {}
local meshUvCount = 0

function AvatarCombitionMgr:ctor()
	self._combitions = {}
	self._freeCombitions = {}
end

function AvatarCombitionMgr:getCombition(key)
	local combition = self._combitions[key]

	if not combition then
		if #self._freeCombitions == 0 then
			combition = AvatarCombition.New()
		else
			combition = self._freeCombitions[1]

			table.remove(self._freeCombitions, 1)
		end

		self._combitions[key] = combition
		combition.key = key
	end

	combition:retain()

	return combition
end

function AvatarCombitionMgr:removeCombition(combition)
	combition:release()

	local key = combition.key

	if self._combitions[key] and self._combitions[key] == combition then
		if combition:tryDestroy() then
			table.insert(self._freeCombitions, combition)

			self._combitions[key] = nil
		end
	else
		combition:destroy()
		table.insert(self._freeCombitions, combition)
	end
end

function AvatarCombitionMgr:clearCombitions()
	for k, combition in pairs(self._combitions) do
		if combition:tryDestroy() then
			table.insert(self._freeCombitions, combition)
		end
	end

	table.clear(self._combitions)
end

function AvatarCombitionMgr:combine(avatar)
	local key = avatar.avatarMo:toCombineKey()
	local combition = self:getCombition(key)
	local go = avatar:getSkeletonObject()

	self:_clearTemp()

	local skelMap = avatar:getSkelMap()

	for k, v in pairs(avatar.parts) do
		if v:isPartLoaded() then
			self:_collectBonesInfo(v, skelMap)
		end
	end

	combition.bones = self:_tableToArray(combineBones, TransformType)

	if combition.combineMesh then
		avatar:setCombition(combition)

		return
	end

	for k, v in pairs(avatar.parts) do
		if v:isPartLoaded() then
			self:_collectSkinedMeshInfo(v, skelMap)
		end
	end

	local sharedMesh = UnityMesh.New()

	sharedMesh:CombineMeshes(self:_tableToArray(combineInstances, CombineInstanceType), true, false)

	combition.skinnedMeshAtlas = PackTextureCache.instance:getPackTexture(combineTextures)
	combition.combineMesh = sharedMesh
	combition.uv = self:_updateUv(combition.skinnedMeshAtlas)

	avatar:setCombition(combition)
end

function AvatarCombitionMgr:combineNew(partCtrl)
	local avatar = partCtrl._avatar
	local key = avatar.avatarmo:toCombineKey()
	local combition = self:getCombition(key)
	local go = avatar:getGameObject()

	self:_clearTemp()

	local skelMap = avatar:getSkeletonMap()
	local useParts = partCtrl:getAllUseCombineParts() or {}
	local needCombineParts = {}

	for k, v in pairs(useParts) do
		if self:checkPartIsComplete(v) then
			table.insert(needCombineParts, v)
		else
			v:setIsUseTransMat(true)
		end
	end

	for k, v in pairs(needCombineParts) do
		self:_collectBonesInfo(v, skelMap)
	end

	combition.bones = self:_tableToArray(combineBones, TransformType)

	if combition.combineMesh then
		partCtrl:setCombition(combition)

		return
	end

	for k, v in pairs(needCombineParts) do
		self:_collectSkinedMeshInfo(v, skelMap)
	end

	local sharedMesh = UnityMesh.New()

	sharedMesh:CombineMeshes(self:_tableToArray(combineInstances, CombineInstanceType), true, false)

	combition.skinnedMeshAtlas = PackTextureCache.instance:getPackTexture(combineTextures)
	combition.combineMesh = sharedMesh
	combition.uv = self:_updateUv(combition.skinnedMeshAtlas)

	partCtrl:setCombition(combition)
end

function AvatarCombitionMgr:_updateUv(skinnedMeshAtlas)
	local atlasUVs = System.Array.CreateInstance(Vector2Type, meshUvCount)
	local j = 0
	local packingResult = skinnedMeshAtlas.packingResult

	for i = 1, #combineUvs do
		local uvs = combineUvs[i]
		local index = skinnedMeshAtlas.texturesIndex[combineTextures[i].name]
		local xMin = packingResult[index - 1].xMin
		local yMin = packingResult[index - 1].yMin
		local xMax = packingResult[index - 1].xMax
		local yMax = packingResult[index - 1].yMax

		for k = 0, uvs.Length - 1 do
			local uv = Vector2.New()

			uv.x = Mathf.Lerp(xMin, xMax, uvs[k].x)
			uv.y = Mathf.Lerp(yMin, yMax, uvs[k].y)
			atlasUVs[j] = uv
			j = j + 1
		end
	end

	return atlasUVs
end

function AvatarCombitionMgr:_clearTemp()
	table.clear(combineTextures)
	table.clear(combineInstances)
	table.clear(combineBones)
	table.clear(combineUvs)

	meshUvCount = 0
end

function AvatarCombitionMgr:_collectSkinedMeshInfo(part, skelMap)
	local smr = part:getSkinedMeshRenderer()

	if not smr then
		return
	end

	for i = 0, smr.sharedMesh.subMeshCount - 1 do
		local ci = UnityCombineInstance.New()

		ci.mesh = smr.sharedMesh
		ci.subMeshIndex = i

		table.insert(combineInstances, ci)
	end

	meshUvCount = meshUvCount + smr.sharedMesh.uv.Length

	table.insert(combineUvs, smr.sharedMesh.uv)

	local mainTexture = smr.material.mainTexture

	table.insert(combineTextures, mainTexture)
end

function AvatarCombitionMgr:_collectBonesInfo(part, skelMap)
	local smr = part:getSkinedMeshRenderer()

	if not smr then
		return
	end

	local bones = smr.bones

	for i = 0, bones.Length - 1 do
		table.insert(combineBones, skelMap[bones[i].name])
	end
end

function AvatarCombitionMgr:_tableToArray(list, type)
	local arr = System.Array.CreateInstance(type, #list)

	for i = 0, #list - 1 do
		arr[i] = list[i + 1]
	end

	return arr
end

function AvatarCombitionMgr:checkPartIsComplete(part)
	local smr = part:getSkinedMeshRenderer()

	if not smr then
		return false
	end

	local useMaterial = smr.material

	if not useMaterial then
		return false
	end

	local useMainTexture = useMaterial.mainTexture

	if not useMainTexture then
		return false
	end

	return true
end

AvatarCombitionMgr.instance = AvatarCombitionMgr.New()

return AvatarCombitionMgr
