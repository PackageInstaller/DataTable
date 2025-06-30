-- chunkname: @IQIGame\\UI\\Battle\\BattleHUD\\BattleHUDView.lua

local UIObjectPool = require("IQIGame/UI/Common/UIObjectPool")
local BattleHUDItemView = require("IQIGame/UI/Battle/BattleHUD/BattleHUDItemView")
local m = {
	hudItemTable = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:__Init(view)

	return obj
end

function m:__Init(view)
	self.gameObject = view
	self.hudItemTable = {}

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.template.gameObject:SetActive(false)
	self:__InitItemViewPool()
	self:__InitEventDelegate()
	self:__AddEventListener()
end

function m:__InitItemViewPool()
	function self.__ItemViewCreateFunc()
		return self:__OnCreateHUDItemView()
	end

	function self.__ItemViewDisposeFunc(_item)
		self:__OnDisposeHUDItemView(_item)
	end

	self.itemViewPool = UIObjectPool.New(10, self.__ItemViewCreateFunc, self.__ItemViewDisposeFunc)
end

function m:__OnCreateHUDItemView()
	local item = UnityEngine.Object.Instantiate(self.template, self.template.transform.parent)
	local itemView = BattleHUDItemView.New(item, self.gameObject)

	return itemView
end

function m:__OnItemViewRelease(itemView)
	if self.hudItemTable[itemView.battleUnitID] ~= nil then
		self.hudItemTable[itemView.battleUnitID] = nil
	end

	itemView:Release()
	self.itemViewPool:Release(itemView)
end

function m:__OnDisposeHUDItemView(itemView)
	itemView:Dispose()

	self.hudItemTable[itemView.battleUnitID] = nil
end

function m:__InitEventDelegate()
	function self.__delegateOnBattleUnitHPChange(battleUnitID)
		self:__OnBattleUnitHPChange(battleUnitID)
	end

	function self.__delegateOnBattleUnitEnergyChange(battleUnitID)
		self:__OnBattleUnitEnergyChange(battleUnitID)
	end

	function self.__delegateOnBattleUnitAddBuff(battleUnitID, buffCid)
		self:__OnBattleUnitAddBuff(battleUnitID, buffCid)
	end

	function self.__delegateOnBattleUnitUpdateBuff(battleUnitID, buffCid, stackDifference, roundDifference)
		self:__OnBattleUnitUpdateBuff(battleUnitID, buffCid, stackDifference, roundDifference)
	end

	function self.__delegateOnBattleUnitTriggerBuff(battleUnitID, buffCid)
		self:__OnBattleUnitTriggerBuff(battleUnitID, buffCid)
	end

	function self.__delegateOnBattleUnitRemoveBuff(battleUnitID, buffCid)
		self:__OnBattleUnitRemoveBuff(battleUnitID, buffCid)
	end

	function self.__delegateOnBattleUnitAddWake(battleUnitID, wakeCid)
		self:__OnBattleUnitAddWake(battleUnitID, wakeCid)
	end

	function self.__delegateOnBattleUnitUpdateWakeStatus(battleUnitID, wakeCid)
		self:__OnBattleUnitUpdateWakeStatus(battleUnitID, wakeCid)
	end

	function self.__delegateOnBattleUnitRemoveWake(battleUnitID, wakeCid)
		self:__OnBattleUnitRemoveWake(battleUnitID, wakeCid)
	end

	function self.__delegateOnBattleUnitWakeNumChange(battleUnitID)
		self:__OnBattleUnitWakeNumChange(battleUnitID)
	end

	function self.__delegateShowUnitDamageEffect(_battleUnitID, _battleDamageData)
		self:__OnShowDamageEffect(_battleUnitID, _battleDamageData)
	end

	function self.__delegateShowUnitEnergyNumber(_battleUnitID, _energyNumber)
		self:__OnShowEnergyNumber(_battleUnitID, _energyNumber)
	end

	function self.__delegateOnChangeBattleUnitHUDActive(_battleUnitID, _active)
		self:__OnChangeBattleUnitHUDActive(_battleUnitID, _active)
	end

	function self.__delegateOnBattleUnitChangePos(battleUnitID)
		self:__OnBattleUnitChangePos(battleUnitID)
	end

	function self.__delegateOnBattleUnitSkinViewJoinBattle(battleUnitID)
		self:__OnBattleUnitSkinViewJoinBattle(battleUnitID)
	end
end

function m:__AddEventListener()
	EventDispatcher.AddEventListener(EventID.BattleUnitHPChange, self.__delegateOnBattleUnitHPChange)
	EventDispatcher.AddEventListener(EventID.BattleUnitEnergyChange, self.__delegateOnBattleUnitEnergyChange)
	EventDispatcher.AddEventListener(EventID.BattleUnitAddBuff, self.__delegateOnBattleUnitAddBuff)
	EventDispatcher.AddEventListener(EventID.BattleUnitUpdateBuff, self.__delegateOnBattleUnitUpdateBuff)
	EventDispatcher.AddEventListener(EventID.BattleUnitTriggerBuff, self.__delegateOnBattleUnitTriggerBuff)
	EventDispatcher.AddEventListener(EventID.BattleUnitRemoveBuff, self.__delegateOnBattleUnitRemoveBuff)
	EventDispatcher.AddEventListener(EventID.BattleUnitAddWake, self.__delegateOnBattleUnitAddWake)
	EventDispatcher.AddEventListener(EventID.BattleUnitUpdateWakeStatus, self.__delegateOnBattleUnitUpdateWakeStatus)
	EventDispatcher.AddEventListener(EventID.BattleUnitRemoveWake, self.__delegateOnBattleUnitRemoveWake)
	EventDispatcher.AddEventListener(EventID.BattleUnitWakeNumChange, self.__delegateOnBattleUnitWakeNumChange)
	EventDispatcher.AddEventListener(EventID.ShowUnitDamageNumber, self.__delegateShowUnitDamageEffect)
	EventDispatcher.AddEventListener(EventID.ShowUnitEnergyNumber, self.__delegateShowUnitEnergyNumber)
	EventDispatcher.AddEventListener(EventID.ChangeBattleUnitHUDActive, self.__delegateOnChangeBattleUnitHUDActive)
	EventDispatcher.AddEventListener(EventID.BattleUnitChangePos, self.__delegateOnBattleUnitChangePos)
	EventDispatcher.AddEventListener(EventID.BattleUnitSkinViewJoinBattle, self.__delegateOnBattleUnitSkinViewJoinBattle)
end

function m:__RemoveEventListener()
	EventDispatcher.RemoveEventListener(EventID.BattleUnitHPChange, self.__delegateOnBattleUnitHPChange)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitEnergyChange, self.__delegateOnBattleUnitEnergyChange)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitAddBuff, self.__delegateOnBattleUnitAddBuff)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitUpdateBuff, self.__delegateOnBattleUnitUpdateBuff)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitTriggerBuff, self.__delegateOnBattleUnitTriggerBuff)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitRemoveBuff, self.__delegateOnBattleUnitRemoveBuff)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitAddWake, self.__delegateOnBattleUnitAddWake)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitUpdateWakeStatus, self.__delegateOnBattleUnitUpdateWakeStatus)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitRemoveWake, self.__delegateOnBattleUnitRemoveWake)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitWakeNumChange, self.__delegateOnBattleUnitWakeNumChange)
	EventDispatcher.RemoveEventListener(EventID.ShowUnitDamageNumber, self.__delegateShowUnitDamageEffect)
	EventDispatcher.RemoveEventListener(EventID.ShowUnitEnergyNumber, self.__delegateShowUnitEnergyNumber)
	EventDispatcher.RemoveEventListener(EventID.ChangeBattleUnitHUDActive, self.__delegateOnChangeBattleUnitHUDActive)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitChangePos, self.__delegateOnBattleUnitChangePos)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitSkinViewJoinBattle, self.__delegateOnBattleUnitSkinViewJoinBattle)
end

function m:AddHUDItem(battleUnitID, bossHUD)
	local itemView = self.itemViewPool:Obtain()

	itemView:BindingBattleUnit(battleUnitID, bossHUD)

	self.hudItemTable[battleUnitID] = itemView
end

function m:RemoveHUDItem(battleUnitID)
	local itemView = self.hudItemTable[battleUnitID]

	if itemView == nil then
		return
	end

	self:__OnItemViewRelease(itemView)
end

function m:SetViewItemActive(active)
	for _, viewItem in pairs(self.hudItemTable) do
		viewItem:SetActive(active)
	end
end

function m:OnUpdate()
	for _, viewItem in pairs(self.hudItemTable) do
		viewItem:OnUpdate()
	end
end

function m:OnClose()
	for _, viewItem in pairs(self.hudItemTable) do
		viewItem:Dispose()
	end

	self.hudItemTable = {}
end

function m:Dispose()
	self.itemViewPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function m:__OnBattleUnitHPChange(battleUnitID)
	local itemView = self.hudItemTable[battleUnitID]

	if itemView == nil then
		return
	end

	itemView:OnBattleUnitHpChange()
end

function m:__OnBattleUnitEnergyChange(battleUnitID)
	local itemView = self.hudItemTable[battleUnitID]

	if itemView == nil then
		return
	end

	itemView:OnBattleUnitEnergyChange()
end

function m:__OnBattleUnitAddBuff(battleUnitID, buffCid)
	local itemView = self.hudItemTable[battleUnitID]

	if itemView == nil then
		return
	end

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
	local battleBuffData = battleUnitData:GetBuffData(buffCid)

	itemView:OnAddBuff(battleBuffData, true)
end

function m:__OnBattleUnitUpdateBuff(battleUnitID, buffCid, stackDifference, roundDifference)
	local itemView = self.hudItemTable[battleUnitID]

	if itemView == nil then
		return
	end

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
	local battleBuffData = battleUnitData:GetBuffData(buffCid)

	itemView:OnUpdateBuff(battleBuffData, stackDifference, roundDifference)
end

function m:__OnBattleUnitTriggerBuff(battleUnitID, buffCid)
	local itemView = self.hudItemTable[battleUnitID]

	if itemView == nil then
		return
	end

	itemView:OnTriggerBuff(buffCid)
end

function m:__OnBattleUnitRemoveBuff(battleUnitID, buffCid)
	local itemView = self.hudItemTable[battleUnitID]

	if itemView == nil then
		return
	end

	itemView:OnRemoveBuff(buffCid)
end

function m:__OnBattleUnitAddWake(battleUnitID, wakeCid)
	local itemView = self.hudItemTable[battleUnitID]

	if itemView == nil then
		return
	end

	itemView:OnBattleUnitAddWake(wakeCid)
end

function m:__OnBattleUnitUpdateWakeStatus(battleUnitID, wakeCid)
	local itemView = self.hudItemTable[battleUnitID]

	if itemView == nil then
		return
	end

	itemView:OnBattleUnitUpdateWakeStatus(wakeCid)
end

function m:__OnBattleUnitRemoveWake(battleUnitID, wakeCid)
	local itemView = self.hudItemTable[battleUnitID]

	if itemView == nil then
		return
	end

	itemView:OnBattleUnitRemoveWake(wakeCid)
end

function m:__OnBattleUnitWakeNumChange(battleUnitID)
	local itemView = self.hudItemTable[battleUnitID]

	if itemView == nil then
		return
	end

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)

	itemView:OnBattleUnitUpdateWakeNum(battleUnitData.PODData.WeakNum)
end

function m:__OnShowDamageEffect(battleUnitID, battleDamageData)
	local itemView = self.hudItemTable[battleUnitID]

	if itemView == nil then
		return
	end

	itemView:ShowDamageEffect(battleDamageData)
end

function m:__OnShowEnergyNumber(battleUnitID, energyNumber)
	local itemView = self.hudItemTable[battleUnitID]

	if itemView == nil then
		return
	end

	itemView:ShowEnergyNumber(energyNumber)
end

function m:__OnChangeBattleUnitHUDActive(battleUnitID, active)
	local itemView = self.hudItemTable[battleUnitID]

	if itemView == nil then
		return
	end

	itemView:SetActive(active)
end

function m:__OnBattleUnitChangePos(battleUnitID)
	local itemView = self.hudItemTable[battleUnitID]

	if itemView == nil then
		return
	end

	itemView:OnBattleUnitPosChange()
end

function m:__OnBattleUnitSkinViewJoinBattle(battleUnitID)
	local itemView = self.hudItemTable[battleUnitID]

	if itemView == nil then
		return
	end

	itemView:OnBattleUnitChangeSkin()
end

return m
