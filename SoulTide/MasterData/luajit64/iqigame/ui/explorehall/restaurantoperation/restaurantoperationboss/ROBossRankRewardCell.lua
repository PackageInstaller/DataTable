-- chunkname: @IQIGame\\UI\\ExploreHall\\RestaurantOperation\\RestaurantOperationBoss\\ROBossRankRewardCell.lua

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

function m:SetData(data, index)
	self.cfgReward = data

	if data == nil then
		self:Clear()
	else
		self:Update(index)
	end
end

function m:Update(index)
	local tog = index % 2
	local isSow = tog == 1

	self.BgOdd:SetActive(isSow)
	self.BgEven:SetActive(not isSow)

	local isShowImgNum = false

	for i = 1, 3 do
		local numTransform = self.Num123.transform:Find("Image_" .. i)

		if numTransform then
			numTransform.gameObject:SetActive(i == index)
		end

		if isShowImgNum == false then
			isShowImgNum = i == index
		end
	end

	self.RankingText:SetActive(not isShowImgNum)
	self.ImgIcon:SetActive(not isShowImgNum)
	UGUIUtil.SetText(self.RankingText, RestaurantOperationBossRankRewardUIApi:GetString("TextRewardIndex", self.cfgReward.RankLowerLimit, self.cfgReward.RankUpperLimit, self.cfgReward.RankType))

	if not isShowImgNum then
		local path = RestaurantOperationBossRankRewardUIApi:GetString("RankRewardIconPath", self.cfgReward.RankLowerLimit, self.cfgReward.RankUpperLimit, self.cfgReward.RankType)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	end

	self.RewardMould:SetActive(false)

	for i = 1, self.RewardGrid.transform.childCount - 1 do
		local obj = self.RewardGrid.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	for i = 1, #self.cfgReward.Reward, 2 do
		local itemId = self.cfgReward.Reward[i]
		local itemNum = self.cfgReward.Reward[i + 1]
		local itemObj = UnityEngine.Object.Instantiate(self.RewardMould)

		itemObj.transform:SetParent(self.RewardGrid.transform, false)
		itemObj:SetActive(true)

		local itemCell = ItemCell.New(itemObj.transform:GetChild(0).gameObject)

		itemCell:SetItem(CfgItemTable[itemId])

		if itemNum > 0 then
			itemCell:SetNum(itemNum)
		else
			itemCell:SetNum("")
		end
	end
end

function m:Clear()
	self.View:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
