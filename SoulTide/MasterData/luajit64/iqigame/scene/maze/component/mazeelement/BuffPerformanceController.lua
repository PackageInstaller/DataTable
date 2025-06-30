-- chunkname: @IQIGame\\Scene\\Maze\\Component\\MazeElement\\BuffPerformanceController.lua

local m = {}

function m.New(host)
	local obj = Clone(m)

	obj:Init(host)

	return obj
end

function m:Init(host)
	self.Host = host
	self.RemainBuffEffects = {}
	self.AllEffectPlayIds = {}

	function self.DelegateOnAddBuff(dollId, buffCid)
		self:OnAddBuff(dollId, buffCid)
	end

	function self.DelegateOnRemoveBuff(dollId, buffCid)
		self:OnRemoveBuff(dollId, buffCid)
	end

	self:AddEventListeners()
end

function m:AddEventListeners()
	EventDispatcher.AddEventListener(EventID.MazeBuffAdded, self.DelegateOnAddBuff)
	EventDispatcher.AddEventListener(EventID.MazeBuffRemoved, self.DelegateOnRemoveBuff)
end

function m:RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.MazeBuffAdded, self.DelegateOnAddBuff)
	EventDispatcher.RemoveEventListener(EventID.MazeBuffRemoved, self.DelegateOnRemoveBuff)
end

function m:OnShow()
	for i = 1, #MazeDataModule.PlayerInfo.Buffs do
		local buffPOD = MazeDataModule.PlayerInfo.Buffs[i]

		self:OnAddBuff(0, buffPOD.CID)
	end

	local mazeDollPOD = MazeDataModule.GetFirstAliveDoll()

	for i = 1, #mazeDollPOD.buffs do
		local buffPOD = mazeDollPOD.buffs[i]

		self:OnAddBuff(mazeDollPOD.id, buffPOD.CID)
	end
end

function m:OnAddBuff(dollId, buffCid)
	local cfgBuffData = CfgBuffTable[buffCid]

	self:PlayEffect(cfgBuffData.StartEffectID, cfgBuffData.RemainEffectMountType, cfgBuffData.StartEffectPoint)

	if cfgBuffData.RemainEffectID ~= 0 and self.RemainBuffEffects[cfgBuffData.RemainEffectID] == nil then
		self.RemainBuffEffects[cfgBuffData.RemainEffectID] = self:PlayEffect(cfgBuffData.RemainEffectID, cfgBuffData.RemainEffectMountType, cfgBuffData.RemainEffectPoint, cfgBuffData.RemainEffectDelayTime)
	end
end

function m:OnRemoveBuff(dollId, buffCid)
	local cfgBuffData = CfgBuffTable[buffCid]

	self:PlayEffect(cfgBuffData.BuffEndEffectID, cfgBuffData.RemainEffectMountType, cfgBuffData.BuffEndEffectPoint)

	if cfgBuffData.RemainEffectID ~= 0 then
		local needKeep = self:HasSameRemainEffectBuff(cfgBuffData.RemainEffectID)

		if not needKeep and self.RemainBuffEffects[cfgBuffData.RemainEffectID] ~= nil then
			self:StopEffect(self.RemainBuffEffects[cfgBuffData.RemainEffectID])

			self.RemainBuffEffects[cfgBuffData.RemainEffectID] = nil
		end
	end
end

function m:HasSameRemainEffectBuff(remainEffectCid)
	for i = 1, #MazeDataModule.PlayerInfo.Buffs do
		local buffPOD = MazeDataModule.PlayerInfo.Buffs[i]
		local cfgBuffData = CfgBuffTable[buffPOD.CID]

		if cfgBuffData.RemainEffectID == remainEffectCid then
			return true
		end
	end

	local mazeDollPOD = MazeDataModule.GetFirstAliveDoll()

	if mazeDollPOD == nil then
		return false
	end

	for i = 1, #mazeDollPOD.buffs do
		local buffPOD = mazeDollPOD.buffs[i]
		local cfgBuffData = CfgBuffTable[buffPOD.CID]

		if cfgBuffData.RemainEffectID == remainEffectCid then
			return true
		end
	end

	return false
end

function m:PlayEffect(effectCid, mountType, mountPointCid, delay)
	if effectCid == 0 then
		return
	end

	if mountPointCid == 0 then
		logError("迷宫元素buff特效挂点配置错误。Effect：" .. effectCid)

		return nil
	end

	if delay == nil then
		delay = 0
	end

	local gameObject, layer, sortingLayer, sortingOrder, entityId, notifyMask

	if mountType == 1 then
		gameObject = self.Host.gameObject
		entityId = self.Host.EntityId
		layer = 0
		sortingLayer = LuaCodeInterface.SortingLayerNameToID("Element")
		sortingOrder = gameObject:GetComponentInChildren(typeof(UnityEngine.Renderer)).sortingOrder
		notifyMask = true
	else
		gameObject = MazeModule.MazeScene.ConstantMainUIEffectCanvasGo
		entityId = 0
		layer = LayerMask.NameToLayer("UI")
		sortingLayer = 0
		sortingOrder = 0
		notifyMask = false
	end

	if gameObject == nil then
		return nil
	end

	local effectPlayId = GameEntry.Effect:PlayMountPointEffect(effectCid, mountPointCid, entityId, gameObject, delay, 0, layer, sortingLayer, sortingOrder, 1, notifyMask)

	table.insert(self.AllEffectPlayIds, effectPlayId)

	return effectPlayId
end

function m:StopEffect(effectPlayId)
	GameEntry.Effect:StopEffect(effectPlayId)

	local index = table.indexOf(self.AllEffectPlayIds, effectPlayId)

	table.remove(self.AllEffectPlayIds, index)
end

function m:StopAllEffect()
	for i = #self.AllEffectPlayIds, 1, -1 do
		self:StopEffect(self.AllEffectPlayIds[i])
	end

	self.AllEffectPlayIds = {}
	self.RemainBuffEffects = {}
end

function m:Dispose()
	self:StopAllEffect()
	self:RemoveEventListeners()

	self.Host = nil
end

return m
