-- chunkname: @IQIGame\\UI\\Battle\\BattleQuitView.lua

local BattleQuitUI = {}

function BattleQuitUI.New(view)
	local obj = Clone(BattleQuitUI)

	obj:Init(view)

	return obj
end

function BattleQuitUI:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateConfirmQuit()
		self:Close()
		EventDispatcher.Dispatch(EventID.QuitBattle)
	end

	function self.delegateCancelQuit()
		self:Close()
	end

	self.confirmButtonText:GetComponent(typeof(UnityEngine.UI.Text)).text = BattleUIApi:GetConfirmTips(true)
	self.cancelButtonText:GetComponent(typeof(UnityEngine.UI.Text)).text = BattleUIApi:GetConfirmTips(false)
	self.titleText:GetComponent(typeof(UnityEngine.UI.Text)).text = BattleApi:GetCfgText(6050001)
	self.descriptionText:GetComponent(typeof(UnityEngine.UI.Text)).text = BattleApi:GetCfgText(6050002)
end

function BattleQuitUI:AddListeners()
	self.confirmButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.delegateConfirmQuit)
	self.cancelButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.delegateCancelQuit)
end

function BattleQuitUI:RemoveListeners()
	self.confirmButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.delegateConfirmQuit)
	self.cancelButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.delegateCancelQuit)
end

function BattleQuitUI:OnOpen()
	self:AddListeners()
end

function BattleQuitUI:OnClose()
	self:RemoveListeners()

	if self.View ~= nil then
		self:Close()
	end
end

function BattleQuitUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function BattleQuitUI:Open()
	self.View.gameObject:SetActive(true)
end

function BattleQuitUI:Close()
	self.View.gameObject:SetActive(false)
end

return BattleQuitUI
