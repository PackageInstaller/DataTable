-- chunkname: @IQIGame\\UI\\Soul\\SoulFeatureItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(featureSkillCid, isUnlock, unlockQuality)
	local cfgSkillData = CfgSkillTable[featureSkillCid]

	self.LockView:SetActive(not isUnlock)
	self.UnlockView:SetActive(isUnlock)
	UGUIUtil.SetText(self.LockViewNameText, cfgSkillData.Name)
	UGUIUtil.SetText(self.UnlockConditionLabel, SoulUIApi:GetString("infoViewFeatureName2"))

	for i = 0, self.StarGrid.transform.childCount - 1 do
		self.StarGrid.transform:GetChild(i).gameObject:SetActive(i <= unlockQuality)
	end

	UGUIUtil.SetTextInChildren(self.UnlockView, cfgSkillData.Name)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
