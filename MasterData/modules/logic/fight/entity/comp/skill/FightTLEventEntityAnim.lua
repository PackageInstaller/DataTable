-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventEntityAnim.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventEntityAnim", package.seeall)

local FightTLEventEntityAnim = class("FightTLEventEntityAnim", FightTimelineTrackItem)

function FightTLEventEntityAnim:onTrackStart(fightStepData, duration, paramsArr)
	local targetType = paramsArr[1]

	self._targetEntitys = nil

	if targetType == "1" then
		self._targetEntitys = {}

		table.insert(self._targetEntitys, FightHelper.getEntity(fightStepData.fromId))
	elseif targetType == "2" then
		self._targetEntitys = FightHelper.getSkillTargetEntitys(fightStepData)
	elseif targetType == "3" then
		self._targetEntitys = {}

		table.insert(self._targetEntitys, FightHelper.getEntity(fightStepData.toId))
	elseif targetType == "4" then
		self._targetEntitys = FightHelper.getSkillTargetEntitys(fightStepData)

		tabletool.removeValue(self._targetEntitys, FightHelper.getEntity(fightStepData.fromId))
	elseif not string.nilorempty(targetType) then
		local entityMgr = FightGameMgr.entityMgr
		local entityId = fightStepData.stepUid .. "_" .. targetType
		local tempEntity = entityMgr:getEntity(entityId)

		if tempEntity then
			self._targetEntitys = {}

			table.insert(self._targetEntitys, tempEntity)
		else
			logError("找不到实体, id: " .. tostring(entityId))

			return
		end
	end

	local tarSkin = paramsArr[6]

	if not string.nilorempty(tarSkin) then
		self._targetEntitys = {}
		tarSkin = tonumber(tarSkin)

		for entityId, entity in pairs(FightGameMgr.entityMgr.entityDic) do
			local entityData = entity:getMO()

			if entityData and entityData.skin == tarSkin then
				table.insert(self._targetEntitys, entity)
			end
		end
	end

	self.setAnimEntityList = {}
	self._ani_path = nil
	self._leftPath = nil
	self._rightPath = nil
	self._loader = MultiAbLoader.New()
	self._revertSpinePosAndColor = paramsArr[5] == "1"

	local path = paramsArr[2]

	if not string.nilorempty(path) then
		self._ani_path = path

		self._loader:addPath(FightHelper.getEntityAniPath(path))
	end

	path = paramsArr[3]

	if not string.nilorempty(paramsArr[3]) then
		self._leftPath = path

		self._loader:addPath(FightHelper.getEntityAniPath(path))
	end

	path = paramsArr[4]

	if not string.nilorempty(paramsArr[4]) then
		self._rightPath = path

		self._loader:addPath(FightHelper.getEntityAniPath(path))
	end

	if #self._loader._pathList > 0 then
		self._loader:startLoad(self._onLoaded, self)
	end
end

function FightTLEventEntityAnim:onTrackEnd()
	self:onDestructor()
end

function FightTLEventEntityAnim:_onLoaded(multiAbLoader)
	if not self._targetEntitys then
		return
	end

	local sideAni = {}
	local sideName = {}

	if self._leftPath then
		local leftAsset = self._loader:getAssetItem(FightHelper.getEntityAniPath(self._leftPath))

		if leftAsset then
			local ani = leftAsset:GetResource(ResUrl.getEntityAnim(self._leftPath))

			if ani then
				sideAni[FightEnum.EntitySide.EnemySide] = ani
				sideName[FightEnum.EntitySide.EnemySide] = self._leftPath
				ani.legacy = true
			end
		end
	end

	if self._rightPath then
		local rightAsset = self._loader:getAssetItem(FightHelper.getEntityAniPath(self._rightPath))

		if rightAsset then
			local ani = rightAsset:GetResource(ResUrl.getEntityAnim(self._rightPath))

			if ani then
				sideAni[FightEnum.EntitySide.MySide] = ani
				sideName[FightEnum.EntitySide.MySide] = self._rightPath
				ani.legacy = true
			end
		end
	end

	local normalAnim

	if self._ani_path then
		local assetItem = self._loader:getAssetItem(FightHelper.getEntityAniPath(self._ani_path))

		if assetItem then
			normalAnim = assetItem:GetResource(ResUrl.getEntityAnim(self._ani_path))

			if normalAnim then
				normalAnim.legacy = true
			end
		end
	end

	self._animStateName = {}
	self._animCompList = {}

	for _, entity in ipairs(self._targetEntitys) do
		if not tabletool.indexOf(self.setAnimEntityList, entity.id) and entity.spine then
			local spineObj = entity.spine:getSpineGO()

			if spineObj then
				local animInst = sideAni[entity:getSide()] or normalAnim
				local aniName = sideName[entity:getSide()] or self._ani_path

				if animInst then
					local animComp = gohelper.onceAddComponent(spineObj, typeof(UnityEngine.Animation))

					table.insert(self._animCompList, animComp)
					table.insert(self._animStateName, aniName)

					animComp.enabled = true
					animComp.clip = animInst

					animComp:AddClip(animInst, aniName)

					local state = animComp.this:get(aniName)

					if state then
						state.speed = FightModel.instance:getSpeed()
					end

					animComp:Play()
					table.insert(self.setAnimEntityList, entity.id)
					FightController.instance:dispatchEvent(FightEvent.TimelinePlayEntityAni, entity.id, true)
				end
			else
				self.waitSpineList = self.waitSpineList or {}

				table.insert(self.waitSpineList, entity.spine)
				FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self.onSpineLoaded, self)
			end
		end
	end

	FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, self._onUpdateSpeed, self)
end

function FightTLEventEntityAnim:onSpineLoaded(spine)
	if not self.waitSpineList then
		return
	end

	for index, waitSpine in ipairs(self.waitSpineList) do
		if waitSpine == spine then
			self:_onLoaded()
			table.remove(self.waitSpineList, index)

			break
		end
	end

	if #self.waitSpineList < 1 then
		self:clearWaitSpine()
	end
end

function FightTLEventEntityAnim:_onUpdateSpeed()
	for i, animComp in ipairs(self._animCompList) do
		local state = animComp.this:get(self._animStateName[i])

		if state then
			state.speed = FightModel.instance:getSpeed()
		end
	end
end

function FightTLEventEntityAnim:onDestructor()
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, self._onUpdateSpeed, self)
	self:_clearLoader()
	self:_clearAnim()
	self:_resetEntitys()
	self:clearWaitSpine()
end

function FightTLEventEntityAnim:_clearAnim()
	if self._animCompList then
		for i, animComp in ipairs(self._animCompList) do
			if not gohelper.isNil(animComp) then
				local aniName = self._animStateName[i]

				if animComp:GetClip(aniName) then
					animComp:RemoveClip(aniName)
				end

				if animComp.clip and animComp.clip.name == aniName then
					animComp.clip = nil
				end

				animComp.enabled = false
			end
		end

		tabletool.clear(self._animCompList)

		self._animCompList = nil
	end
end

function FightTLEventEntityAnim:_resetEntitys()
	if self._targetEntitys then
		for _, entity in ipairs(self._targetEntitys) do
			if entity.spine then
				local spineGO = entity.spine:getSpineGO()

				ZProj.CharacterSetVariantHelper.Disable(entity.spine)
				FightController.instance:dispatchEvent(FightEvent.TimelinePlayEntityAni, entity.id, false)

				if self._revertSpinePosAndColor then
					transformhelper.setLocalPos(entity.spine.transform, 0, 0, 0)
				end
			end
		end
	end

	self._targetEntitys = nil
end

function FightTLEventEntityAnim:_clearLoader()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function FightTLEventEntityAnim:clearWaitSpine()
	self.waitSpineList = nil

	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self.onSpineLoaded, self)
end

return FightTLEventEntityAnim
