-- chunkname: @modules/logic/room/entity/comp/base/RoomBaseSpineEffectComp.lua

module("modules.logic.room.entity.comp.base.RoomBaseSpineEffectComp", package.seeall)

local RoomBaseSpineEffectComp = class("RoomBaseSpineEffectComp", LuaCompBase)

function RoomBaseSpineEffectComp:ctor(entity)
	self.entity = entity
	self._isHasEffectGODict = {}
	self._prefabNameDict = {}
	self._animNameDict = {}
end

function RoomBaseSpineEffectComp:init(go)
	self.go = go
	self._effectCfgList = {}

	local cfgList = self:getEffectCfgList()

	tabletool.addValues(self._effectCfgList, cfgList)
	self:onInit()
end

function RoomBaseSpineEffectComp:_logNotPoint(cfg)
	return
end

function RoomBaseSpineEffectComp:_logResError(cfg)
	return
end

function RoomBaseSpineEffectComp:getEffectCfgList()
	return nil
end

function RoomBaseSpineEffectComp:getSpineComp()
	return nil
end

function RoomBaseSpineEffectComp:onPlayShowEffect(animState, effectGo, animId)
	return
end

function RoomBaseSpineEffectComp:addResToLoader(loader)
	for i, cfg in ipairs(self._effectCfgList) do
		loader:addPath(self:_getEffecResAb(cfg.effectRes))
	end
end

function RoomBaseSpineEffectComp:_getEffecRes(path)
	return RoomResHelper.getCharacterEffectPath(path)
end

function RoomBaseSpineEffectComp:_getEffecResAb(path)
	return RoomResHelper.getCharacterEffectABPath(path)
end

function RoomBaseSpineEffectComp:addEventListeners()
	return
end

function RoomBaseSpineEffectComp:removeEventListeners()
	return
end

function RoomBaseSpineEffectComp:isHasEffectGO(animState)
	if self._isHasEffectGODict[animState] then
		return true
	end

	return false
end

function RoomBaseSpineEffectComp:play(animState)
	if not self._isHasEffectGODict[self._curAnimState] then
		self._curAnimState = animState

		if self._isHasEffectGODict[self._curAnimState] then
			for animId, effectGo in pairs(self._animEffectGODic) do
				gohelper.setActive(effectGo, false)

				if self._animNameDict[animId] == animState then
					gohelper.setActive(effectGo, true)
					self:onPlayShowEffect(animState, effectGo, animId)
				end
			end
		end
	end
end

function RoomBaseSpineEffectComp:spawnEffect(loader)
	local spineComp = self:getSpineComp()
	local spineGO = spineComp and spineComp:getSpineGO()

	self._animEffectGODic = self._animEffectGODic or {}
	self._prefabNameDict = self._prefabNameDict or {}
	self._isHasEffectGODict = self._isHasEffectGODict or {}
	self._animNameDict = self._animNameDict or {}

	for i, cfg in ipairs(self._effectCfgList) do
		local nameKey = cfg.id

		if gohelper.isNil(self._animEffectGODic[nameKey]) then
			local resAb = self:_getEffecResAb(cfg.effectRes)
			local prefabAssetItem = loader:getAssetItem(resAb)
			local isError = true

			if prefabAssetItem then
				local res = self:_getEffecRes(cfg.effectRes)
				local prefab = prefabAssetItem:GetResource(res)

				if prefab then
					isError = false

					local pointPath = RoomCharacterHelper.getSpinePointPath(cfg.point)
					local pointGo = gohelper.findChild(spineGO, pointPath)

					if gohelper.isNil(pointGo) then
						self:_logNotPoint(cfg)

						pointGo = spineGO or self.entity.containerGO
					end

					local prefabName = prefab.name
					local effectGo = gohelper.clone(prefab, pointGo, prefabName)

					self._animNameDict[nameKey] = cfg.animName
					self._animEffectGODic[nameKey] = effectGo
					self._prefabNameDict[nameKey] = prefabName
					self._isHasEffectGODict[cfg.animName] = true

					gohelper.setActive(effectGo, false)
				end
			end

			if isError then
				self:_logResError(cfg)
			end
		end
	end
end

function RoomBaseSpineEffectComp:clearEffect()
	if self._animEffectGODic then
		for key, effectGO in pairs(self._animEffectGODic) do
			rawset(self._animEffectGODic, key, nil)
			gohelper.destroy(effectGO)
		end

		self._animEffectGODic = nil
		self._isHasEffectGODict = {}
		self._prefabNameDict = {}
		self._animNameDict = {}
	end
end

function RoomBaseSpineEffectComp:beforeDestroy()
	self:removeEventListeners()
	self:clearEffect()
end

return RoomBaseSpineEffectComp
