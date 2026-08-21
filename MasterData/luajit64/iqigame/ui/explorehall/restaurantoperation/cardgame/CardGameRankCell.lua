-- chunkname: @IQIGame\\UI\\ExploreHall\\RestaurantOperation\\CardGame\\CardGameRankCell.lua

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

	self.NumImages:SetActive(index > 0 and index <= 3)

	for i = 1, 3 do
		local numTransform = self.NumImages.transform:Find("Image_" .. i)

		if numTransform then
			numTransform.gameObject:SetActive(i == index)
		end
	end

	self.RankingText:SetActive(index > 3)

	self.RankingText:GetComponent("Text").text = tostring(index)
	self.PlayerNameText:GetComponent("Text").text = self.pName

	local tab = string.split(rankingPOD.customData, ",")

	UGUIUtil.SetText(self.TextOperationLv, tab[1])
	UGUIUtil.SetText(self.TextOperationAttr, tab[2])
	UGUIUtil.SetText(self.Value1Text, tab[3])

	if self.playerHead then
		self.playerHead:SetData(self.headIcon, self.pLv, rankingPOD.avatarFrame)
	end
end

function m:SetMyData(ranking, hurt, customData, rankType)
	self.index = ranking

	self.BgDefault:SetActive(true)
	self.BgOdd:SetActive(false)
	self.BgEven:SetActive(false)
	self.BgMine:SetActive(false)
	self.BgRankingGoalie:SetActive(false)

	if self.playerHead then
		self.playerHead:SetData(PlayerModule.PlayerInfo.baseInfo.headIcon, PlayerModule.PlayerInfo.baseInfo.pLv, PlayerModule.PlayerInfo.baseInfo.avatarFrame)
	end

	self.NumImages:SetActive(ranking > 0 and ranking <= 3)

	for i = 1, 3 do
		local numTransform = self.NumImages.transform:Find("Image_" .. i)

		if numTransform then
			numTransform.gameObject:SetActive(i == ranking and rankType == 1)
		end
	end

	self.RankingText:SetActive(ranking > 3)

	self.RankingText:GetComponent("Text").text = RestaurantGameCardRankUIApi:GetString("ChallengeRankStr", ranking, true, rankType)

	UGUIUtil.SetText(self.PlayerNameText, RestaurantGameCardRankUIApi:GetString("PlayerNameText", PlayerModule.PlayerInfo.baseInfo.pName))

	local tab = string.split(customData, ",")

	UGUIUtil.SetText(self.TextOperationLv, tab[1])
	UGUIUtil.SetText(self.TextOperationAttr, tab[2])

	local value = tab[3] or 0

	UGUIUtil.SetText(self.Value1Text, RestaurantGameCardRankUIApi:GetString("ChallengeRankHurt", value, true))
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
