-- chunkname: @IQIGame\\UI\\ActivityPassUI\\maxRewardItem.lua

local maxRewardItem = {}

function maxRewardItem.New(go)
	local o = Clone(maxRewardItem)

	o:Initialize(go)

	return o
end

function maxRewardItem:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function maxRewardItem:InitComponent()
	self.progressImg = self.progressImg:GetComponent("Image")
	self.numBg = self.gameObject.transform:Find("numBg")
end

function maxRewardItem:InitDelegate()
	return
end

function maxRewardItem:AddListener()
	return
end

function maxRewardItem:RemoveListener()
	return
end

function maxRewardItem:OnButtonGetClick()
	return
end

function maxRewardItem:OnButtonExtraGetClick()
	return
end

function maxRewardItem:Show(show)
	LuaUtility.SetGameObjectShow(self.gameObject, show)
end

function maxRewardItem:Refresh(data, isExtra, force)
	if self.Data and self.Data.cid == data.cid and self.Data.status == data.status and self.Data.schedule == data.schedule and self.Data.count == data.count then
		return
	end

	local extraCfgTask = CfgUtil.GetTaskCfgWithID(data.cid)

	self.progressImg.fillAmount = data.schedule / data.cfgTaskConfig.NeedSchedule

	LuaUtility.SetText(self.presentExpText, data.schedule)
	LuaUtility.SetText(self.maxExpText, data.cfgTaskConfig.NeedSchedule)

	if data.count < 1 then
		LuaUtility.SetText(self.numText, "x0")
	else
		LuaUtility.SetText(self.numText, "x" .. data.count)
	end

	local itemData = LuaUtility.ActionParamToItemDataTable(extraCfgTask.ActionParam)
	local cellNormal

	if itemData[1] then
		cellNormal = ExtendItemCellOne.New(self.maxRewardItem.gameObject)

		cellNormal:SetAwardData(itemData[1], itemData[1]:GetNum())
		LuaUtility.SetGameObjectShow(self.maxRewardItem, true)
	else
		LuaUtility.SetGameObjectShow(self.maxRewardItem, false)
	end

	self.extraCfg = data.cfgTaskConfig
	self.Data = data
end

function maxRewardItem:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return maxRewardItem
