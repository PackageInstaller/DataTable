-- chunkname: @IQIGame\\UI\\ExploreHall\\FishingActivity\\FishingActivityRank\\FishingActivityRankCell.lua

local m = {
	showFormationUI = true,
	lastRanking = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	if self.PlayerHead then
		self.playerHead = PlayerHeadUI.New(self.PlayerHead)
	end

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(index, rankingPOD)
	self.index = index
	self.rankingPOD = rankingPOD
	self.pid = rankingPOD.pid
	self.pName = rankingPOD.name
	self.guid = rankingPOD.guid
	self.headIcon = rankingPOD.headIcon
	self.pLv = rankingPOD.pLv
	self.vip = rankingPOD.vip

	local isDouble = index % 2 == 0

	self.BgOdd:SetActive(not isDouble)
	self.BgEven:SetActive(isDouble)

	local mySelf = PlayerModule.PlayerInfo.baseInfo.pid == self.pid

	self.BgDefault:SetActive(false)
	self.BgRankingGoalie:SetActive(false)

	if mySelf then
		self.BgOdd:SetActive(false)
		self.BgEven:SetActive(false)
		self.BgMine:SetActive(true)
	else
		self.BgMine:SetActive(false)
	end

	local isShowImgNum = false

	for i = 1, 3 do
		local numTransform = self.NumImages.transform:Find("Image_" .. i)

		if numTransform then
			numTransform.gameObject:SetActive(i == index)
		end

		if isShowImgNum == false then
			isShowImgNum = i == index
		end
	end

	self.RankingText:SetActive(not isShowImgNum and index <= 3)
	self.RankingText1:SetActive(index > 3)

	self.RankingText:GetComponent("Text").text = tostring(index)
	self.RankingText1:GetComponent("Text").text = tostring(index)
	self.PlayerNameText:GetComponent("Text").text = self.pName

	local tab = string.split(rankingPOD.customData, ",")
	local fishID = tonumber(tab[1])

	UGUIUtil.SetText(self.TextFishName, CfgFishActiveFishListTable[fishID].Name)

	self.Value1Text:GetComponent("Text").text = rankingPOD.value

	self.ImgRank:SetActive(false)

	if self.playerHead then
		self.playerHead:SetData(self.headIcon, self.pLv, rankingPOD.avatarFrame)
	end
end

function m:SetEmpty(index, rankType)
	local isDouble = index % 2 == 0

	self.BgOdd:SetActive(not isDouble)
	self.BgEven:SetActive(isDouble)
	self.BgMine:SetActive(false)

	self.TextIndex:GetComponent("Text").text = FishingActivityRankUIApi:GetString("ChallengeRankStr", tostring(index), false, rankType)
	self.TextName:GetComponent("Text").text = FishingActivityRankUIApi:GetString("ChallengeRankStr", "--", false, rankType)
	self.TextHurt:GetComponent("Text").text = FishingActivityRankUIApi:GetString("ChallengeRankHurt", "--", false)
end

function m:SetGoalieData(rankingPOD, ranking, rankType)
	self.BgOdd:SetActive(false)
	self.BgEven:SetActive(false)
	self.BgRankingGoalie:SetActive(true)
	self.BgDefault:SetActive(false)
	self.BgMine:SetActive(false)
	UGUIUtil.SetText(self.RankingText, tostring(ranking))

	if self.playerHead then
		self.playerHead:SetData(rankingPOD.headIcon, rankingPOD.pLv, rankingPOD.avatarFrame)
	end

	local isShowImgNum = false

	for i = 1, 3 do
		local numTransform = self.NumImages.transform:Find("Image_" .. i)

		if numTransform then
			numTransform.gameObject:SetActive(i == ranking and rankType == 1)
		end

		if isShowImgNum == false then
			isShowImgNum = i == ranking
		end
	end

	if rankType == 2 then
		self.ImgRank:SetActive(ranking > 0)
	else
		self.ImgRank:SetActive(ranking > 3)
	end

	if rankType == 0 then
		self.RankingText:SetActive(false)
	else
		self.RankingText:SetActive(true)

		self.RankingText:GetComponent("Text").text = FishingActivityRankUIApi:GetString("ChallengeRankStr", ranking, false, rankType)
	end

	self.RankingText1:SetActive(ranking <= 0)

	self.RankingText1:GetComponent("Text").text = FishingActivityRankUIApi:GetString("ChallengeRankStr", ranking, false, rankType)

	UGUIUtil.SetText(self.PlayerNameText, rankingPOD.name)
	UGUIUtil.SetText(self.Value1Text, tostring(rankingPOD.value))

	if ranking > 0 then
		local path = FishingActivityRankUIApi:GetString("BossRankIconPath", ranking, false, rankType)

		AssetUtil.LoadImage(self, path, self.ImgRank:GetComponent("Image"))
	end
end

function m:SetMyData(ranking, value, customData, rankType)
	self.index = ranking

	self.BgDefault:SetActive(true)
	self.BgOdd:SetActive(false)
	self.BgEven:SetActive(false)
	self.BgMine:SetActive(false)
	self.BgRankingGoalie:SetActive(false)
	UGUIUtil.SetText(self.RankingText, RankingUIControllerApi:GetString("RankingText", ranking))

	if self.playerHead then
		self.playerHead:SetData(PlayerModule.PlayerInfo.baseInfo.headIcon, PlayerModule.PlayerInfo.baseInfo.pLv, PlayerModule.PlayerInfo.baseInfo.avatarFrame)
	end

	local isShowImgNum = false

	for i = 1, 3 do
		local numTransform = self.NumImages.transform:Find("Image_" .. i)

		if numTransform then
			numTransform.gameObject:SetActive(i == ranking and rankType == 1)
		end

		if isShowImgNum == false then
			isShowImgNum = i == ranking
		end
	end

	if rankType == 2 then
		self.ImgRank:SetActive(ranking > 0)
	else
		self.ImgRank:SetActive(ranking > 3)
	end

	if rankType == 0 then
		self.RankingText:SetActive(false)
	else
		self.RankingText:SetActive(true)

		self.RankingText:GetComponent("Text").text = FishingActivityRankUIApi:GetString("ChallengeRankStr", ranking, true, rankType)
	end

	self.RankingText1:SetActive(ranking <= 0)

	self.RankingText1:GetComponent("Text").text = FishingActivityRankUIApi:GetString("ChallengeRankStr", ranking, true, rankType)

	UGUIUtil.SetText(self.PlayerNameText, FishingActivityRankUIApi:GetString("PlayerNameText", PlayerModule.PlayerInfo.baseInfo.pName))

	local tab = string.split(customData, ",")
	local fishID = tonumber(tab[1])

	if fishID then
		UGUIUtil.SetText(self.TextFishName, CfgFishActiveFishListTable[fishID].Name)
	end

	UGUIUtil.SetText(self.Value1Text, FishingActivityRankUIApi:GetString("ChallengeRankHurt", value, true))

	if ranking > 0 then
		local path = FishingActivityRankUIApi:GetString("BossRankIconPath", ranking, true, rankType)

		AssetUtil.LoadImage(self, path, self.ImgRank:GetComponent("Image"))
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	if self.playerHead then
		self.playerHead:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
