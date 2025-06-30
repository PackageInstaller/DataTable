-- chunkname: @IQIGame\\UI\\ActivityList\\DiceGameActivity\\DiceGameActivityView_rewardItem.lua

local DiceGameActivityView_rewardItem = {}

function DiceGameActivityView_rewardItem.New(go, mainView)
	local o = Clone(DiceGameActivityView_rewardItem)

	o:Initialize(go, mainView)

	return o
end

function DiceGameActivityView_rewardItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function DiceGameActivityView_rewardItem:InitComponent()
	return
end

function DiceGameActivityView_rewardItem:InitDelegate()
	return
end

function DiceGameActivityView_rewardItem:AddListener()
	return
end

function DiceGameActivityView_rewardItem:RemoveListener()
	return
end

function DiceGameActivityView_rewardItem:OnDestroy()
	return
end

function DiceGameActivityView_rewardItem:Refresh(Data)
	self.data = Data

	local cfgDrop = CfgUtil.GetCfgDropLibDataWithID(self.data.drop)
	local cfgItem = CfgUtil.GetItemCfgDataWithID(cfgDrop.GiftItemIds[1])
	local str = string.format(CfgUtil.GetCfgTipsTextWithID(9000009), self.data.left .. "-" .. self.data.right)
	local str = str .. cfgItem.Name .. "*" .. cfgDrop.GiftItemCount[1]

	LuaUtility.SetText(self.textReward, str)
end

return DiceGameActivityView_rewardItem
