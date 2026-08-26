-- chunkname: @modules/logic/room/entity/actcomp/RoomGiftActComp.lua

module("modules.logic.room.entity.actcomp.RoomGiftActComp", package.seeall)

local RoomGiftActComp = class("RoomGiftActComp", LuaCompBase)
local SPINE_DELAY_TIME = 0.6

function RoomGiftActComp:ctor(entity)
	self.entity = entity
end

function RoomGiftActComp:init(go)
	self.go = go
	self._materialRes = RoomCharacterEnum.MaterialPath
end

function RoomGiftActComp:addEventListeners()
	RoomGiftController.instance:registerCallback(RoomGiftEvent.UpdateActInfo, self._checkActivity, self)
	RoomGiftController.instance:registerCallback(RoomGiftEvent.GetBonus, self._checkActivity, self)
end

function RoomGiftActComp:removeEventListeners()
	RoomGiftController.instance:unregisterCallback(RoomGiftEvent.UpdateActInfo, self._checkActivity, self)
	RoomGiftController.instance:unregisterCallback(RoomGiftEvent.GetBonus, self._checkActivity, self)
end

function RoomGiftActComp:onStart()
	self:_checkActivity()
end

function RoomGiftActComp:_checkActivity()
	if self:_isShowSpine() then
		if not self._isCurShow then
			self._isCurShow = true

			self:_loadActivitySpine()
		end
	else
		self._isCurShow = false

		self:destroyAllActivitySpine()
	end
end

function RoomGiftActComp:_isShowSpine()
	if self.__willDestroy then
		return false
	end

	local isOnline = RoomGiftModel.instance:isActOnLine()
	local canGetRoomGift = RoomGiftModel.instance:isCanGetBonus()

	return isOnline and canGetRoomGift
end

function RoomGiftActComp:_loadActivitySpine()
	if self._isLoaderDone then
		self:_onLoadFinish()

		return
	end

	self._loader = self._loader or SequenceAbLoader.New()

	local pathDict = {}

	self.roomGiftSpineList = RoomGiftConfig.instance:getAllRoomGiftSpineList()

	for _, name in pairs(self.roomGiftSpineList) do
		local resPath = RoomGiftConfig.instance:getRoomGiftSpineRes(name)

		if not pathDict[resPath] then
			self._loader:addPath(resPath)

			pathDict[resPath] = true
		end
	end

	self._loader:addPath(self._materialRes)
	self._loader:setLoadFailCallback(self._onLoadOneFail)
	self._loader:startLoad(self._onLoadFinish, self)
end

function RoomGiftActComp:_onLoadOneFail(loader, assetItem)
	logError("RoomGiftActComp: 加载失败, url: " .. assetItem.ResPath)
end

function RoomGiftActComp:_onLoadFinish(loader)
	if not self:_isShowSpine() then
		self:destroyAllActivitySpine()

		return
	end

	self._isLoaderDone = true

	if not self.roomGiftSpineList then
		return
	end

	self._activitySpineDict = self._activitySpineDict or {}

	for _, name in ipairs(self.roomGiftSpineList) do
		local spineItem = self._activitySpineDict[name]
		local spineGO = spineItem and spineItem.spineGO

		if gohelper.isNil(spineGO) then
			self:destroyActivitySpine(spineItem)

			spineItem = {}

			local resPath = RoomGiftConfig.instance:getRoomGiftSpineRes(name)

			if self._loader then
				local prefabAssetItem = self._loader:getAssetItem(resPath)
				local prefab = prefabAssetItem and prefabAssetItem:GetResource(resPath)

				if prefab then
					spineGO = gohelper.clone(prefab, self.entity.staticContainerGO, name)

					local startPos = RoomGiftConfig.instance:getRoomGiftSpineStartPos(name)

					transformhelper.setLocalPos(spineGO.transform, startPos[1], startPos[2], startPos[3])

					local scale = RoomGiftConfig.instance:getRoomGiftSpineScale(name)

					transformhelper.setLocalScale(spineGO.transform, scale, scale, scale)

					local spineMeshRenderer = spineGO:GetComponent(typeof(UnityEngine.MeshRenderer))
					local sharedMaterial = spineMeshRenderer.sharedMaterial
					local materialAssetItem = loader:getAssetItem(self._materialRes)
					local replaceMaterial = materialAssetItem:GetResource(self._materialRes)
					local replaceMatIns = UnityEngine.GameObject.Instantiate(replaceMaterial)

					replaceMatIns:SetTexture("_MainTex", sharedMaterial:GetTexture("_MainTex"))
					replaceMatIns:SetTexture("_BackLight", sharedMaterial:GetTexture("_NormalMap"))
					replaceMatIns:SetTexture("_DissolveTex", sharedMaterial:GetTexture("_DissolveTex"))

					local spineSkeletonAnim = spineGO:GetComponent(typeof(Spine.Unity.SkeletonAnimation))
					local customMaterialOverride = spineSkeletonAnim.CustomMaterialOverride

					if customMaterialOverride then
						customMaterialOverride:Clear()
						customMaterialOverride:Add(sharedMaterial, replaceMatIns)
					end

					spineMeshRenderer.material = replaceMatIns
					spineItem.spineGO = spineGO
					spineItem.material = replaceMatIns
					spineItem.meshRenderer = spineMeshRenderer
					spineItem.skeletonAnim = spineSkeletonAnim

					gohelper.setLayer(spineGO, LayerMask.NameToLayer("Scene"), true)
				end

				self._activitySpineDict[name] = spineItem
			end
		end
	end

	self._curSpineAnimIndex = 0

	self:delayPlaySpineAnim()
end

function RoomGiftActComp:delayPlaySpineAnim()
	if not self.roomGiftSpineList or not self._activitySpineDict then
		return
	end

	self._curSpineAnimIndex = self._curSpineAnimIndex + 1

	local name = self.roomGiftSpineList[self._curSpineAnimIndex]
	local spineItem = name and self._activitySpineDict[name]
	local spineSkeletonAnim = spineItem and spineItem.skeletonAnim

	if not spineSkeletonAnim then
		self._curSpineAnimIndex = 0

		return
	end

	local animName = RoomGiftConfig.instance:getRoomGiftSpineAnim(name)

	if spineSkeletonAnim and not string.nilorempty(animName) then
		spineSkeletonAnim:PlayAnim(animName, true, true)
	end

	TaskDispatcher.cancelTask(self.delayPlaySpineAnim, self)
	TaskDispatcher.runDelay(self.delayPlaySpineAnim, self, SPINE_DELAY_TIME)
end

function RoomGiftActComp:destroyAllActivitySpine()
	if self._activitySpineDict then
		for _, spineItem in pairs(self._activitySpineDict) do
			self:destroyActivitySpine(spineItem)
		end

		self._activitySpineDict = nil
	end

	TaskDispatcher.cancelTask(self.delayPlaySpineAnim, self)

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self.roomGiftSpineList = nil
	self._isLoaderDone = false
	self._isCurShow = false
end

function RoomGiftActComp:destroyActivitySpine(spineItem)
	if not spineItem then
		return
	end

	spineItem.meshRenderer = nil
	spineItem.skeletonAnim = nil

	if spineItem.material then
		gohelper.destroy(spineItem.material)

		spineItem.material = nil
	end

	gohelper.destroy(spineItem.spineGO)
end

function RoomGiftActComp:beforeDestroy()
	self.__willDestroy = true

	self:destroyAllActivitySpine()
	self:removeEventListeners()
end

function RoomGiftActComp:onDestroy()
	self:destroyAllActivitySpine()
end

return RoomGiftActComp
