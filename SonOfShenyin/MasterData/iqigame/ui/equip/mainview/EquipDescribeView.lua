-- chunkname: @IQIGame\\UI\\Equip\\MainView\\EquipDescribeView.lua

local EquipBaseInfoView = require("IQIGame.UI.Equip.EquipBaseInfoView")
local equipReplacePanelClass = require("IQIGame/UI/Equip/EquipReplacePanel")
local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.replacePanel = equipReplacePanelClass.New(self.equipReplacePanel, self)

	self.replacePanel:Hide()

	self.equipDefaultBaseInfoView = EquipBaseInfoView.New(self.EquipAttParent, self)

	self:InitDelegate()
end

function m:InitDelegate()
	function self.DelegateOnClickReplaceButton()
		self:OnClickReplaceButton()
	end

	function self.delegateOnClickChargeButton()
		EquipModule.ReplaceEquip(WarlockModule.curWarlockData.cid, self.equipData.id)
	end

	function self.DelegateOnClickDischargeButton()
		self:OnClickDischargeButton()
	end

	function self.DelegateOnClickLockButton()
		self:OnClickLockButton()
	end

	function self.delegateOnEquipSuccess()
		self:SetData(self.equipData)
	end

	function self.delegateOnUnloadEquipSucceedSucess()
		self:SetData(self.equipData)
	end

	function self.delegateLockEquipSucceedSucess()
		self:SetData(self.equipData)
	end
end

function m:AddListeners()
	self.ChargeButton:GetComponent("Button").onClick:AddListener(self.delegateOnClickChargeButton)
	self.ReplaceButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickReplaceButton)
	self.DischargeButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDischargeButton)
	self.LockButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickLockButton)
	EventDispatcher.AddEventListener(EventID.WearEquipSucceedNew, self.delegateOnEquipSuccess)
	EventDispatcher.AddEventListener(EventID.UnloadEquipSucceedNew, self.delegateOnUnloadEquipSucceedSucess)
	EventDispatcher.AddEventListener(EventID.LockEquipSucceedNew, self.delegateLockEquipSucceedSucess)
end

function m:RemoveListeners()
	self.ChargeButton:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickChargeButton)
	self.ReplaceButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickReplaceButton)
	self.DischargeButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDischargeButton)
	self.LockButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickLockButton)
	EventDispatcher.RemoveEventListener(EventID.WearEquipSucceedNew, self.delegateOnEquipSuccess)
	EventDispatcher.RemoveEventListener(EventID.UnloadEquipSucceedNew, self.delegateOnUnloadEquipSucceedSucess)
	EventDispatcher.RemoveEventListener(EventID.LockEquipSucceedNew, self.delegateLockEquipSucceedSucess)
end

function m:SetData(equipData, isHideEquipButton)
	self.equipData = equipData

	local itemCfg = CfgItemTable[equipData.itemCid]

	UGUIUtil.SetText(self.equipNameText, itemCfg.Name)
	UGUIUtil.SetText(self.describeText, itemCfg.ItemStory)
	self.equipDefaultBaseInfoView:Refresh(equipData)
	self.equipDefaultBaseInfoView:Show()

	if isHideEquipButton then
		LuaUtility.SetGameObjectShow(self.ChargeButton, false)
		LuaUtility.SetGameObjectShow(self.DischargeButton, false)
		LuaUtility.SetGameObjectShow(self.ReplaceButton, false)
	else
		LuaUtility.SetGameObjectShow(self.ChargeButton, equipData and equipData.heroCid == 0)
		LuaUtility.SetGameObjectShow(self.DischargeButton, equipData and equipData.heroCid ~= 0 and equipData.heroCid == EquipModule.currentHeroCid)
		LuaUtility.SetGameObjectShow(self.ReplaceButton, equipData and equipData.heroCid ~= 0 and equipData.heroCid ~= EquipModule.currentHeroCid)
	end
end

function m:OnOpen(userData, isHideEquipButton)
	self:AddListeners()
	self:SetData(userData, isHideEquipButton)
	self:Show()
end

function m:OnClose()
	self:RemoveListeners()
	self:Hide()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function m:OnClickReplaceButton()
	self.replacePanel:Show()
	self.replacePanel:Refresh(Constant.EquipReplacePanelType.Equip, WarlockModule.curWarlockData.cid, self.SelectedEquipData.heroCid, function()
		EquipModule.ReplaceEquip(WarlockModule.curWarlockData.cid, self.equipData.id)
	end)
end

function m:OnClickDischargeButton()
	EquipModule.UnloadEquip(WarlockModule.curWarlockData.cid, self.equipData.id)
end

function m:OnClickLockButton()
	EquipModule.LockEquip({
		self.equipData.id
	})
end

return m
