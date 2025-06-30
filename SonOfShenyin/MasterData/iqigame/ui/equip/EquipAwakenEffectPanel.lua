-- chunkname: @IQIGame\\UI\\Equip\\EquipAwakenEffectPanel.lua

local EquipAwakenEffectPanel = {}
local EquipWearSuitView = require("IQIGame.UI.Equip.EquipWearSuitView")

function EquipAwakenEffectPanel.New(go, mainView)
	local o = Clone(EquipAwakenEffectPanel)

	o:Initialize(go, mainView)

	return o
end

function EquipAwakenEffectPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function EquipAwakenEffectPanel:InitComponent()
	self.suitView = EquipWearSuitView.New(self.SuitAttributeGroupItemPrefab)
end

function EquipAwakenEffectPanel:InitDelegate()
	return
end

function EquipAwakenEffectPanel:AddListener()
	return
end

function EquipAwakenEffectPanel:RemoveListener()
	return
end

function EquipAwakenEffectPanel:OnDestroy()
	return
end

function EquipAwakenEffectPanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function EquipAwakenEffectPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function EquipAwakenEffectPanel:Refresh(SuitIds)
	for _, v in pairs(SuitIds) do
		self.suitView:RefreshOnlyAllAwaken(v)
	end
end

return EquipAwakenEffectPanel
