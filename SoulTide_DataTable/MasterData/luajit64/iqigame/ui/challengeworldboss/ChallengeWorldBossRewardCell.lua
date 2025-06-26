-- chunkname: @IQIGame\\UI\\ChallengeWorldBoss\\ChallengeWorldBossRewardCell.lua

local ChallengeWorldBossRewardCell = {}

function ChallengeWorldBossRewardCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_ChallengeWorldBossRewardCell == nil then
		ui.__SUB_UI_MAP_ChallengeWorldBossRewardCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_ChallengeWorldBossRewardCell
	local towerRewardCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		towerRewardCell = ChallengeWorldBossRewardCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = towerRewardCell
	else
		towerRewardCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return towerRewardCell
end

function ChallengeWorldBossRewardCell.__New(itemCellView)
	local itemCell = Clone(ChallengeWorldBossRewardCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function ChallengeWorldBossRewardCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function ChallengeWorldBossRewardCell:AddListener()
	return
end

function ChallengeWorldBossRewardCell:RemoveListener()
	return
end

function ChallengeWorldBossRewardCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_ChallengeWorldBossRewardCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_ChallengeWorldBossRewardCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_ChallengeWorldBossRewardCell = nil
end

function ChallengeWorldBossRewardCell:SetData(data, index)
	self.cfgWorldBossReward = data

	if data == nil then
		self:Clear()
	else
		self:Update(index)
	end
end

function ChallengeWorldBossRewardCell:Update(index)
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
	UGUIUtil.SetText(self.RankingText, ChallengeWorldBossDetailUIApi:GetString("TextRewardIndex", self.cfgWorldBossReward.RankLowerLimit, self.cfgWorldBossReward.RankUpperLimit, self.cfgWorldBossReward.RankType))
	self.ImgIcon:SetActive(not isShowImgNum)

	if not isShowImgNum then
		local path = ChallengeWorldBossDetailUIApi:GetString("ChallengeRankRewardIconPath", self.cfgWorldBossReward.RankLowerLimit, self.cfgWorldBossReward.RankUpperLimit, self.cfgWorldBossReward.RankType)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	end

	self.RewardMould:SetActive(false)

	for i = 1, self.RewardGrid.transform.childCount - 1 do
		local obj = self.RewardGrid.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	for i = 1, #self.cfgWorldBossReward.Reward, 2 do
		local itemId = self.cfgWorldBossReward.Reward[i]
		local itemNum = self.cfgWorldBossReward.Reward[i + 1]
		local itemObj = UnityEngine.Object.Instantiate(self.RewardMould)

		itemObj.transform:SetParent(self.RewardGrid.transform, false)
		itemObj:SetActive(true)

		local itemCell = ItemCell.PackageOrReuseView(self, itemObj.transform:GetChild(0).gameObject)

		itemCell:SetItem(CfgItemTable[itemId])

		if itemNum > 0 then
			itemCell:SetNum(itemNum)
		else
			itemCell:SetNum("")
		end
	end
end

function ChallengeWorldBossRewardCell:Clear()
	self.goView:SetActive(false)
end

function ChallengeWorldBossRewardCell:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return ChallengeWorldBossRewardCell
