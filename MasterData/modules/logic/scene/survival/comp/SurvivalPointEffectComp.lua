-- chunkname: @modules/logic/scene/survival/comp/SurvivalPointEffectComp.lua

module("modules.logic.scene.survival.comp.SurvivalPointEffectComp", package.seeall)

local SurvivalPointEffectComp = class("SurvivalPointEffectComp", BaseSceneComp)

SurvivalPointEffectComp.ResPaths = {
	changeModel = "survival/effects/prefab/v3a1_scene_zaiju.prefab",
	teleportGate = "survival/effects/prefab/v3a1_scene_biaoji.prefab",
	skill = "survival/effects/prefab/v3a4_survival_jineng.prefab",
	warming1 = "survival/effects/prefab/v2a8_survival_jingjie_1.prefab",
	warming2 = "survival/effects/prefab/v2a8_survival_jingjie_2.prefab",
	useitem = "survival/effects/prefab/v2a8_survival_daoju.prefab",
	fastfight = "survival/effects/prefab/v2a8_scene_tiaoguo.prefab",
	explode = "survival/effects/prefab/v3a1_scene_baozha.prefab"
}

function SurvivalPointEffectComp:onScenePrepared(sceneId, levelId)
	self._sceneGo = self:getCurScene().level:getSceneGo()
	self._effectRoot = gohelper.create3d(self._sceneGo, "PointEffectRoot")
	self._warmingPool = {}
	self._useitemPool = {}
	self._skillPool = {}
	self._allInsts = {}
	self._allKeys = {}
	self._autoDisposeEffect = {}

	self:setTeleportGateEffect()
end

function SurvivalPointEffectComp:setPointEffectType(key, q, r, type)
	if not self._effectRoot then
		return
	end

	self._allInsts[q] = self._allInsts[q] or {}
	self._allInsts[q][r] = self._allInsts[q][r] or {
		allKey = {}
	}

	local info = self._allInsts[q][r]
	local dict = info.allKey

	if dict[key] == type then
		return
	end

	dict[key] = type
	self._allKeys[key] = true

	self:pointChangeCheck(info, q, r)
end

function SurvivalPointEffectComp:setTeleportGateEffect()
	if not self._effectRoot then
		return
	end

	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	if sceneMo.sceneProp.teleportGate == 1 then
		if not self._teleportEffect then
			local res = SurvivalMapHelper.instance:getBlockRes(SurvivalPointEffectComp.ResPaths.teleportGate)

			self._teleportEffect = gohelper.clone(res, self._effectRoot)
		else
			gohelper.setActive(self._teleportEffect, true)
		end

		local pos = sceneMo.sceneProp.teleportGateHex
		local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(pos.q, pos.r)

		transformhelper.setLocalPos(self._teleportEffect.transform, x, y, z)
	else
		gohelper.setActive(self._teleportEffect, false)
	end
end

function SurvivalPointEffectComp:addAutoDisposeEffect(path, pos, time, scale)
	if not self._effectRoot then
		return
	end

	time = time or 2
	scale = scale or 1

	local res = SurvivalMapHelper.instance:getBlockRes(path)
	local effectGo = gohelper.clone(res, self._effectRoot)

	transformhelper.setLocalPos(effectGo.transform, pos.x, pos.y, pos.z)
	transformhelper.setLocalScale(effectGo.transform, scale, scale, scale)

	self._autoDisposeEffect[effectGo] = time + UnityEngine.Time.realtimeSinceStartup

	TaskDispatcher.runRepeat(self._checkEffectDispose, self, 2, -1)
end

function SurvivalPointEffectComp:_checkEffectDispose()
	local time = UnityEngine.Time.realtimeSinceStartup

	for go, dt in pairs(self._autoDisposeEffect) do
		if dt < time then
			gohelper.destroy(go)

			self._autoDisposeEffect[go] = nil
		end
	end

	if not next(self._autoDisposeEffect) then
		TaskDispatcher.cancelTask(self._checkEffectDispose, self)
	end
end

function SurvivalPointEffectComp:clearPointsByKey(key)
	if not self._allKeys[key] then
		return
	end

	for q, v in pairs(self._allInsts) do
		for r, info in pairs(v) do
			if info.allKey[key] then
				info.allKey[key] = nil

				self:pointChangeCheck(info, q, r)
			end
		end
	end

	self._allKeys[key] = nil
end

function SurvivalPointEffectComp:pointChangeCheck(info, q, r)
	local dict = info.allKey
	local needShowType = 0

	for _, saveType in pairs(dict) do
		if needShowType < saveType then
			needShowType = saveType
		end
	end

	if needShowType == 0 then
		needShowType = nil
	end

	if needShowType ~= info.curType then
		self:inPoolRes(info.curType, info.obj)

		info.curType = needShowType
		info.obj = self:setResByType(needShowType, q, r)
	end
end

function SurvivalPointEffectComp:setResByType(type, q, r)
	if not type then
		return
	end

	local obj

	if type == 1 then
		obj = table.remove(self._warmingPool)

		if not obj then
			local mapId = SurvivalMapModel.instance:getCurMapId()
			local groupId = lua_survival_map_group_mapping.configDict[mapId].id
			local co = lua_survival_map_group.configDict[groupId]

			if not co then
				logError("没有找到配置" .. tostring(mapId) .. " >> " .. tostring(groupId))
			end

			local res = SurvivalMapHelper.instance:getBlockRes((co.id == 5 or nil) and SurvivalPointEffectComp.ResPaths.warming2)

			obj = gohelper.clone(res, self._effectRoot)

			transformhelper.setLocalRotation(obj.transform, 0, 30, 0)
		end
	elseif type == 2 then
		obj = table.remove(self._useitemPool)

		if not obj then
			local res = SurvivalMapHelper.instance:getBlockRes(SurvivalPointEffectComp.ResPaths.useitem)

			obj = gohelper.clone(res, self._effectRoot)

			transformhelper.setLocalRotation(obj.transform, 0, 30, 0)
		end
	elseif type == 3 then
		obj = table.remove(self._skillPool)

		if not obj then
			local res = SurvivalMapHelper.instance:getBlockRes(SurvivalPointEffectComp.ResPaths.skill)

			obj = gohelper.clone(res, self._effectRoot)

			transformhelper.setLocalRotation(obj.transform, 0, 30, 0)
		end
	end

	gohelper.setActive(obj, true)

	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(q, r)

	transformhelper.setLocalPos(obj.transform, x, y, z)

	obj.name = string.format("[%s,%s,%s]", q, r, -q - r)

	return obj
end

function SurvivalPointEffectComp:inPoolRes(type, obj)
	if not type then
		return
	end

	gohelper.setActive(obj, false)

	if type == 1 then
		table.insert(self._warmingPool, obj)
	elseif type == 2 then
		table.insert(self._useitemPool, obj)
	elseif type == 3 then
		table.insert(self._skillPool, obj)
	end
end

function SurvivalPointEffectComp:onSceneClose()
	if self._teleportEffect then
		gohelper.destroy(self._teleportEffect)

		self._teleportEffect = nil
	end

	if self._effectRoot then
		gohelper.destroy(self._effectRoot)

		self._effectRoot = nil
	end

	TaskDispatcher.cancelTask(self._checkEffectDispose, self)

	self._autoDisposeEffect = {}
	self._warmingPool = {}
	self._useitemPool = {}
	self._skillPool = {}
	self._allInsts = {}
end

return SurvivalPointEffectComp
