-- chunkname: @IQIGame\\UI\\SettlementUI\\settlementRewardItemCell.lua

local settlementRewardItemCell = {}

function settlementRewardItemCell.New(go, mainView)
	local o = Clone(settlementRewardItemCell)

	o:Initialize(go, mainView)

	return o
end

function settlementRewardItemCell:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function settlementRewardItemCell:InitComponent()
	self.layoutElement = self.gameObject:GetComponent("UnityEngine.UI.LayoutElement")
	self.itemCell = ItemCell.New(self.CommonSlotUI, true, true, true)
end

function settlementRewardItemCell:InitDelegate()
	return
end

function settlementRewardItemCell:AddListener()
	return
end

function settlementRewardItemCell:RemoveListener()
	return
end

function settlementRewardItemCell:OnDestroy()
	self:RemoveListener()
	self.itemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.layoutElement = nil
	self.gameObject = nil
end

function settlementRewardItemCell:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function settlementRewardItemCell:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function settlementRewardItemCell:PlayEffectShow()
	LuaUtility.SetGameObjectShow(self.effectBlink, false)
	coroutine.start(function()
		coroutine.wait(0.3)
		LuaUtility.SetGameObjectShow(self.effectBlink, true)
	end)
end

function settlementRewardItemCell:GetLayout()
	if not LuaUtility.GameObjectIsNullOrEmpty(self.layoutElement) then
		self.layoutElement = self.gameObject:GetComponent("UnityEngine.UI.LayoutElement")
	end

	return self.layoutElement
end

function settlementRewardItemCell:Refresh(Data)
	self.itemCell:SetItemByCid(Data.cid)
	self.itemCell:SetNum(Data.num)
	self.itemCell:SetTag(Data.tag)
end

return settlementRewardItemCell
