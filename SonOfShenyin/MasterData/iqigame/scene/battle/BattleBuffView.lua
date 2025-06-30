-- chunkname: @IQIGame\\Scene\\Battle\\BattleBuffView.lua

local BattleBuffView = {
	leftCount = 0,
	stack = 0,
	scope = 0,
	battleUnitID = 0,
	cid = 0,
	effectCacheTable = {}
}

function BattleBuffView.New(buffData, mountTarget, scope)
	local obj = Clone(BattleBuffView)

	obj:__Init(buffData, mountTarget, scope)

	return obj
end

function BattleBuffView:__Init(buffData, mountTarget, scope)
	self.cid = buffData.cid
	self.stack = buffData.stack
	self.leftCount = buffData.leftCount
	self.scope = scope
	self.effectCacheTable = {}
	self.mountTarget = mountTarget
	self.battleUnitID = mountTarget.battleUnitID
	self.disposed = false

	local buffConfig = CfgBuffTable[self.cid]

	self:__MountEffect(buffConfig.StartEffectID, buffConfig.StartEffectPoint, buffConfig.StartEffectType, buffConfig.StartMountType, buffConfig.StartEffectPram)
end

function BattleBuffView:Update(round, stack)
	local stackDifference = self.stack - stack

	self.leftCount = round
	self.stack = stack

	local buffConfig = CfgBuffTable[self.cid]

	if stackDifference < 0 then
		self:__MountEffect(buffConfig.UpdateEffectID, buffConfig.UpdateEffectPoint, buffConfig.UpdateEffectType, buffConfig.UpdateMountType, buffConfig.UpdateEffectPram)
	elseif stackDifference > 0 then
		self:__ReduceEffect(buffConfig.UpdateEffectID, buffConfig.UpdateEffectPoint, buffConfig.UpdateEffectType, buffConfig.UpdateMountType, buffConfig.UpdateEffectPram)
	end
end

function BattleBuffView:Trigger()
	local buffConfig = CfgBuffTable[self.cid]

	self:__MountEffect(buffConfig.TriggerEffectID, buffConfig.TriggerEffectPoint, buffConfig.TriggerEffectType, buffConfig.TriggerMountType, buffConfig.TriggerEffectPram)
end

function BattleBuffView:Remove()
	local buffConfig = CfgBuffTable[self.cid]

	if buffConfig.EndEffectID == 0 or buffConfig.EndEffectID == nil then
		self:Dispose()

		return
	end

	self:__MountBattleBuffEffect(self.stack, buffConfig.EndEffectID, buffConfig.EndEffectPoint, function()
		self:Dispose()
	end)
end

function BattleBuffView:Dispose()
	self.disposed = true
	self.mountTarget = nil

	self:__RemoveAllBuffEffect()
end

function BattleBuffView:__MountEffect(effectCid, effectPointCid, effectType, mountType, effectParam)
	if effectCid == 0 or effectCid == nil then
		return
	end

	local realCid = effectCid
	local realPointCid = effectPointCid
	local realEffectType = effectType and effectType or 0
	local realMountType = mountType and mountType or 0

	if realMountType == 1 then
		self:__RemoveAllBuffEffect()
	end

	if realEffectType == 0 then
		self:__MountBattleBuffEffect(self.stack, realCid, realPointCid)
	elseif realEffectType == 1 then
		if realMountType == 1 then
			realCid = effectParam[self.stack]

			self:__MountBattleBuffEffect(self.stack, realCid, realPointCid)
		else
			for stack = 1, self.stack do
				local tempBuffEffectCid = effectParam[stack]

				if self.effectCacheTable[stack] == nil then
					self:__MountBattleBuffEffect(stack, tempBuffEffectCid, realPointCid)
				end
			end
		end
	elseif realEffectType == 2 then
		if mountType == 1 then
			local index = (self.stack - 1) * 2 + 1

			realCid = effectParam[index]
			realPointCid = effectParam[index + 1]

			self:__MountBattleBuffEffect(self.stack, realCid, realPointCid)
		else
			for stack = 1, self.stack do
				local index = (stack - 1) * 2 + 1
				local tempBuffEffectCid = effectParam[index]
				local tempBuffPointCid = effectParam[index + 1]

				if self.effectCacheTable[stack] == nil then
					self:__MountBattleBuffEffect(stack, tempBuffEffectCid, tempBuffPointCid)
				end
			end
		end
	else
		logError("未实现的 Buff effectType ----> {0}", realEffectType)
	end
end

function BattleBuffView:__ReduceEffect(stackDifference, effectCid, effectPointCid, effectType, mountType, effectParam)
	if effectCid == 0 or effectCid == nil then
		return
	end

	local realCid = effectCid
	local realPointCid = effectPointCid
	local realEffectType = effectType and effectType or 0
	local realMountType = mountType and mountType or 0

	if realEffectType == 0 then
		return
	end

	if realMountType == 1 then
		self:__RemoveAllBuffEffect()
	end

	if realEffectType == 1 then
		if mountType == 1 then
			realCid = effectParam[self.stack]

			self:__MountBattleBuffEffect(self.stack, realCid, realPointCid)
		else
			for stack = self.stack + 1, self.stack + stackDifference do
				local effectEntityID = self.effectCacheTable[stack]

				if effectEntityID ~= nil then
					log("========HideEntityByEntityID==========>>1")
					EntityUtility.HideEntityByEntityID(effectEntityID)

					self.effectCacheTable[stack] = nil
				end
			end
		end
	elseif realEffectType == 2 then
		if mountType == 1 then
			local index = (self.stack - 1) * 2 + 1

			realCid = effectParam[index]
			realPointCid = effectParam[index + 1]

			self:__MountBattleBuffEffect(self.stack, realCid, realPointCid)
		else
			for stack = self.stack + 1, self.stack + stackDifference do
				local effectEntityID = self.effectCacheTable[stack]

				if effectEntityID ~= nil then
					log("========HideEntityByEntityID==========>>2")
					EntityUtility.HideEntityByEntityID(effectEntityID)

					self.effectCacheTable[stack] = nil
				end
			end
		end
	end
end

function BattleBuffView:__RemoveAllBuffEffect()
	for stack, effectEntityID in pairs(self.effectCacheTable) do
		log("========HideEntityByEntityID==========>>3")
		EntityUtility.HideEntityByEntityID(effectEntityID)
	end

	self.effectCacheTable = {}
end

function BattleBuffView:__MountBattleBuffEffect(stack, effectCid, pointCid, unLoopCall)
	local effectConfig = CfgEffectTable[effectCid]

	if effectConfig == nil then
		logError("BattleBuff:ShowEffect  >>>>>  effectConfig=nil, effectConfigID={0}", effectCid)

		return
	end

	local effectEntityConfig = CfgEffectEntityTable[effectConfig.EntityID]

	if effectEntityConfig == nil then
		logError("BattleBuff:ShowEffect  >>>>>  effectEntityConfig=nil, effectConfigID={0}", effectCid)

		return
	end

	local isLoop = effectConfig.PlayTime >= 999
	local effectEntityID = EntityUtility.CreateEffectEntity(EntityUtility.GetElementAssetPath(effectEntityConfig.PrefabName), function(entityComponent)
		entityComponent.gameObject:SetActive(false)

		if self.disposed then
			log("========HideEntityByEntityID==========>>4")
			EntityUtility.HideEntity(entityComponent)

			return
		end

		local parentTrans

		if self.scope == Constant.UpdateScope.BattleUnit then
			parentTrans = self:__GetBuffMountPointWithBattleUnit(pointCid)
		elseif self.scope == Constant.UpdateScope.BattleTile then
			parentTrans = self:__GetBuffMountPointWithBattleTile(pointCid)
		end

		if parentTrans == nil then
			logError("Buff {0} 找不到特效 {1} 挂载父节点 {2} {3}", self.cid, effectCid, self.scope, pointCid)
			log("========HideEntityByEntityID==========>>5")
			EntityUtility.HideEntity(entityComponent)

			return
		end

		entityComponent.gameObject.transform.parent = parentTrans
		entityComponent.gameObject.transform.localPosition = Vector3.zero

		entityComponent.gameObject:SetActive(true)

		if not isLoop then
			local autoDestroyTime = Timer.New(function()
				autoDestroyTime = nil

				log("========HideEntityByEntityID==========>>6")
				EntityUtility.HideEntity(entityComponent)

				if unLoopCall ~= nil then
					unLoopCall()
				end
			end, effectConfig.PlayTime)

			autoDestroyTime:Start()
		end
	end)

	BattleModule.Log("播放战斗特效 --->> ID: {0} PointID:{1} Loop:{2}", tostring(effectCid), tostring(pointCid), tostring(isLoop))

	if isLoop then
		self.effectCacheTable[stack] = effectEntityID
	end
end

function BattleBuffView:__GetBuffMountPointWithBattleUnit(pointCid)
	local elementPointCfg = CfgElementPointTable[pointCid]

	if self.mountTarget == nil then
		logError("{0}--->>{1}", self.cid, self.battleUnitID)

		return
	end

	if elementPointCfg.IntroduceType == 0 then
		return self.mountTarget.spineRoot.transform:Find("Spine/" .. elementPointCfg.PointName)
	elseif elementPointCfg.IntroduceType == 1 then
		return self.mountTarget.spineRoot.transform:Find("Spine/" .. elementPointCfg.PointName)
	elseif elementPointCfg.IntroduceType == 2 then
		return self.mountTarget.spineRoot.transform:Find("Effect/" .. elementPointCfg.PointName)
	end

	return nil
end

function BattleBuffView:__GetBuffMountPointWithBattleTile(pointCid)
	local elementPointCfg = CfgElementPointTable[pointCid]

	if elementPointCfg ~= nil then
		if elementPointCfg.IntroduceType == 0 then
			return self.mountTarget.gameObject.transform:Find("EffectRoot/" .. elementPointCfg.PointName)
		else
			return self.mountTarget.gameObject.transform:Find("CommonEffectRoot/" .. elementPointCfg.PointName)
		end
	end

	return nil
end

return BattleBuffView
