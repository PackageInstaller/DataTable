-- chunkname: @IQIGame\\UI\\RpgMaze\\MazeExBossRewardCell.lua

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

function m:SetData(data, index)
	self.cfgRPGMazeExBossReward = data

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
	UGUIUtil.SetText(self.RankingText, MazeBossChallengeDetailUIApi:GetString("TextRewardIndex", self.cfgRPGMazeExBossReward.RankLowerLimit, self.cfgRPGMazeExBossReward.RankUpperLimit, self.cfgRPGMazeExBossReward.RankType))

	if not isShowImgNum then
		local path = MazeBossChallengeDetailUIApi:GetString("RankRewardIconPath", self.cfgRPGMazeExBossReward.RankLowerLimit, self.cfgRPGMazeExBossReward.RankUpperLimit, self.cfgRPGMazeExBossReward.RankType)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	end

	self.RewardMould:SetActive(false)

	for i = 1, self.RewardGrid.transform.childCount - 1 do
		local obj = self.RewardGrid.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	for i = 1, #self.cfgRPGMazeExBossReward.Reward, 2 do
		local itemId = self.cfgRPGMazeExBossReward.Reward[i]
		local itemNum = self.cfgRPGMazeExBossReward.Reward[i + 1]
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

function m:Clear()
	self.View:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
