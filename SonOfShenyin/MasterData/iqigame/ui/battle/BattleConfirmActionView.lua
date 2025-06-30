-- chunkname: @IQIGame\\UI\\Battle\\BattleConfirmActionView.lua

local BattleConfirmActionPanel = {}

function BattleConfirmActionPanel.New(view)
	local obj = Clone(BattleConfirmActionPanel)

	obj:Init(view)

	return obj
end

function BattleConfirmActionPanel:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateConfirm()
		self:Close()
		EventDispatcher.Dispatch(EventID.BattleSubmitActions, true)
	end

	function self.delegateCancel()
		self:Close()
	end

	function self.delegateOnClickChangeSkipRestSetting()
		EventDispatcher.Dispatch(EventID.BattleOnClickChangeSkipRestSetting)
	end

	function self.delegateChangeSkipRestSetting(isOn)
		self.isSkipRestImage:SetActive(isOn)
	end

	function self.delegateBattleUnitDataCountChange()
		if BattleModule.isInitBattleComplete then
			self:RefreshBattleUnitActions()
		end
	end

	self.confirmButtonText:GetComponent(typeof(UnityEngine.UI.Text)).text = BattleUIApi:GetConfirmTips(true)
	self.cancelButtonText:GetComponent(typeof(UnityEngine.UI.Text)).text = BattleUIApi:GetConfirmTips(false)
	self.descriptionText:GetComponent(typeof(UnityEngine.UI.Text)).text = BattleUIApi:GetCfgText(6050005)
	self.skipHintText:GetComponent(typeof(UnityEngine.UI.Text)).text = BattleUIApi:GetCfgText(6050006)

	for i = 1, 9 do
		UnityEngine.Object.Instantiate(self.heroPrefab, self.heroParent.transform)
	end

	self.heroPrefab:SetActive(false)
end

function BattleConfirmActionPanel:AddListeners()
	self.confirmButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.delegateConfirm)
	self.cancelButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.delegateCancel)
	self.skipRestButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.delegateOnClickChangeSkipRestSetting)
	EventDispatcher.AddEventListener(EventID.BattleChangeSkipRestSetting, self.delegateChangeSkipRestSetting)
	EventDispatcher.AddEventListener(EventID.BattleUnitDataCountChange, self.delegateBattleUnitDataCountChange)
end

function BattleConfirmActionPanel:RemoveListeners()
	self.confirmButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.delegateConfirm)
	self.cancelButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.delegateCancel)
	self.skipRestButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.delegateOnClickChangeSkipRestSetting)
	EventDispatcher.RemoveEventListener(EventID.BattleChangeSkipRestSetting, self.delegateChangeSkipRestSetting)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitDataCountChange, self.delegateBattleUnitDataCountChange)
end

function BattleConfirmActionPanel:OnOpen()
	self:AddListeners()
	self:RefreshBattleUnitActions()
	self.delegateChangeSkipRestSetting(false)
end

function BattleConfirmActionPanel:OnClose()
	self:RemoveListeners()

	if self.View ~= nil then
		self:Close()
	end
end

function BattleConfirmActionPanel:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function BattleConfirmActionPanel:Open()
	self.View.gameObject:SetActive(true)
end

function BattleConfirmActionPanel:Close()
	self.View.gameObject:SetActive(false)
end

function BattleConfirmActionPanel:RefreshBattleUnitActions()
	for i = 0, self.heroParent.transform.childCount - 1 do
		self.heroParent.transform:GetChild(i).gameObject:SetActive(false)
	end

	self.battleUnitActions = {}

	local index = 0

	for _battleUnitID, _battleUnitData in pairs(BattleModule.battleUnitsData) do
		if _battleUnitData.troopType == BattleModule.playerBattleTroop then
			local heroObj = self.heroParent.transform:GetChild(index).gameObject
			local battleUnitAction = {
				gameObject = heroObj
			}

			LuaCodeInterface.BindOutlet(heroObj, battleUnitAction)

			local path = BattleModule.GetBattleUnitHeadIconByUnitData(_battleUnitData)

			AssetUtil.LoadImage(self, path, battleUnitAction.headImage:GetComponent(typeof(UnityEngine.UI.Image)))

			self.battleUnitActions[_battleUnitID] = battleUnitAction
			index = index + 1
		end
	end
end

function BattleConfirmActionPanel:RefreshRestBattleUnits(restBattleUnitActions)
	for _, battleUnitAction in pairs(self.battleUnitActions) do
		battleUnitAction.gameObject:SetActive(false)
	end

	for _, battleUnitID in pairs(restBattleUnitActions) do
		if self.battleUnitActions[battleUnitID] ~= nil then
			self.battleUnitActions[battleUnitID].gameObject:SetActive(true)
		end
	end
end

return BattleConfirmActionPanel
