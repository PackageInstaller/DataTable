-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGamePlayerUpdate\\PlaceGamePlayerFeatureItemCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(featureSkillCid, isUnlock, needLv)
	local cfgSkillData = CfgSkillTable[featureSkillCid]

	self.LockView:SetActive(not isUnlock)
	self.UnlockView:SetActive(isUnlock)
	UGUIUtil.SetText(self.LockViewNameText, cfgSkillData.Name)
	UGUIUtil.SetText(self.UnlockConditionLabel, PlaceGamePlayerUpdateUIApi:GetString("UnlockFeatureCondition", needLv))
	UGUIUtil.SetTextInChildren(self.UnlockView, cfgSkillData.Name)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
