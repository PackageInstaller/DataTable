-- chunkname: @IQIGame\\UI\\ChallengeWorldBoss\\ChallengeWorldBossRankCell.lua

local ChallengeWorldBossRankCell = {
	showFormationUI = true,
	lastRanking = false
}

function ChallengeWorldBossRankCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_ChallengeRankCell == nil then
		ui.__SUB_UI_MAP_ChallengeRankCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_ChallengeRankCell
	local rankCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		rankCell = ChallengeWorldBossRankCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = rankCell
	else
		rankCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return rankCell
end

function ChallengeWorldBossRankCell.__New(itemCellView)
	local itemCell = Clone(ChallengeWorldBossRankCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function ChallengeWorldBossRankCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.selfBtnCom = self.goView:GetComponent("Button")

	function self.delegateBtnSelf()
		self:OnClickBtnSelf()
	end

	if self.PlayerHead then
		self.playerHead = PlayerHeadUI.New(self.PlayerHead)
	end

	self:AddListener()
end

function ChallengeWorldBossRankCell:AddListener()
	self.selfBtnCom.onClick:AddListener(self.delegateBtnSelf)
end

function ChallengeWorldBossRankCell:RemoveListener()
	self.selfBtnCom.onClick:RemoveListener(self.delegateBtnSelf)
end

function ChallengeWorldBossRankCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_ChallengeRankCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_ChallengeRankCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_ChallengeRankCell = nil
end

function ChallengeWorldBossRankCell:SetData(index, rankingPOD)
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
	self.BgRankingGoalie:SetActive(false)

	local mySelf = PlayerModule.PlayerInfo.baseInfo.pid == self.pid

	self.BgDefault:SetActive(false)

	if mySelf then
		self.BgOdd:SetActive(false)
		self.BgEven:SetActive(false)
		self.BgMine:SetActive(true)
	else
		self.BgMine:SetActive(false)
	end

	local isShowImgNum = false
	local isMax = false

	if tostring(self.rankingPOD.value) == "36002147483647" then
		isMax = true
		index = 1
	end

	for i = 1, 3 do
		local numTransform = self.NumImages.transform:Find("Image_" .. i)

		if numTransform then
			numTransform.gameObject:SetActive(i == index)
		end

		if isShowImgNum == false then
			isShowImgNum = i == index
		end
	end

	self.ImgIcon:SetActive(false)
	self.RankingText:SetActive(not isShowImgNum and index <= 3)
	self.RankingText1:SetActive(index > 3)

	self.RankingText:GetComponent("Text").text = tostring(index)
	self.RankingText1:GetComponent("Text").text = tostring(index)
	self.PlayerNameText:GetComponent("Text").text = self.pName

	local tab = string.split(rankingPOD.customData, ",")

	self.Value2Text:GetComponent("Text").text = ChallengeWorldBossDetailUIApi:GetString("ChallengeRankBossLv", tab[1], false)
	self.Value1Text:GetComponent("Text").text = tab[2]

	if isMax then
		self.Value1Text:GetComponent("Text").text = "Max"
	end

	if self.playerHead then
		self.playerHead:SetData(self.headIcon, self.pLv, rankingPOD.avatarFrame)
	end
end

function ChallengeWorldBossRankCell:SetGoalieData(rankingPOD, ranking, rankType)
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
		self.ImgIcon:SetActive(ranking > 0)
	else
		self.ImgIcon:SetActive(ranking > 3)
	end

	if rankType == 0 then
		self.RankingText:SetActive(false)
	else
		self.RankingText:SetActive(true)

		self.RankingText:GetComponent("Text").text = ChallengeWorldBossDetailUIApi:GetString("ChallengeRankStr", ranking, false, rankType)
	end

	self.RankingText1:SetActive(ranking <= 0)

	self.RankingText1:GetComponent("Text").text = ChallengeWorldBossDetailUIApi:GetString("ChallengeRankStr", ranking, false, rankType)

	UGUIUtil.SetText(self.PlayerNameText, rankingPOD.name)

	local tab = string.split(rankingPOD.customData, ",")

	UGUIUtil.SetText(self.Value1Text, tab[2])
	UGUIUtil.SetText(self.Value2Text, ChallengeWorldBossDetailUIApi:GetString("ChallengeRankBossLv", tab[1], false))

	if ranking > 0 then
		local path = ChallengeWorldBossDetailUIApi:GetString("ChallengeRankIconPath", ranking, false, rankType)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	end
end

function ChallengeWorldBossRankCell:SetEmpty(index, rankType)
	local isDouble = index % 2 == 0

	self.BgOdd:SetActive(not isDouble)
	self.BgEven:SetActive(isDouble)
	self.BgMine:SetActive(false)

	self.TextIndex:GetComponent("Text").text = ChallengeWorldBossDetailUIApi:GetString("ChallengeRankStr", tostring(index), false, rankType)
	self.TextName:GetComponent("Text").text = ChallengeWorldBossDetailUIApi:GetString("ChallengeRankStr", "--", false, rankType)
	self.TextHurt:GetComponent("Text").text = ChallengeWorldBossDetailUIApi:GetString("ChallengeRankHurt", "--", false)
end

function ChallengeWorldBossRankCell:SetMyData(ranking, boosLv, hurt, customData, rankType)
	self.index = ranking

	self.goView:SetActive(true)
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
		self.ImgIcon:SetActive(ranking > 0)
	else
		self.ImgIcon:SetActive(ranking > 3)
	end

	if rankType == 0 then
		self.RankingText:SetActive(false)
	else
		self.RankingText:SetActive(true)

		self.RankingText:GetComponent("Text").text = ChallengeWorldBossDetailUIApi:GetString("ChallengeRankStr", ranking, true, rankType)
	end

	self.RankingText1:SetActive(ranking <= 0)

	self.RankingText1:GetComponent("Text").text = ChallengeWorldBossDetailUIApi:GetString("ChallengeRankStr", ranking, true, rankType)

	UGUIUtil.SetText(self.PlayerNameText, PlayerModule.PlayerInfo.baseInfo.pName)
	UGUIUtil.SetText(self.Value1Text, ChallengeWorldBossDetailUIApi:GetString("ChallengeRankHurt", hurt, true))
	UGUIUtil.SetText(self.Value2Text, ChallengeWorldBossDetailUIApi:GetString("ChallengeRankBossLv", boosLv, true))

	if ranking > 0 then
		local path = ChallengeWorldBossDetailUIApi:GetString("ChallengeRankIconPath", ranking, true, rankType)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	end
end

function ChallengeWorldBossRankCell:OnClickBtnSelf()
	if self.showFormationUI then
		ChallengeWorldBossModule.GetRankUserData(self.lastRanking, self.index, function(userData)
			UIModule.Open(Constant.UIControllerName.ChallengeWorldFormationUI, Constant.UILayer.UI, {
				userData,
				self.rankingPOD
			})
		end)
	end
end

function ChallengeWorldBossRankCell:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)

	if self.playerHead then
		self.playerHead:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.Object.DestroyImmediate(self.goView)

	self.goView = nil
end

return ChallengeWorldBossRankCell
