-- chunkname: @IQIGame\\UI\\AmusementParkGameFlappyBirdUI.lua

local AmusementParkGameFlappyBirdUI = {
	IsNewMaxScore = false,
	PassTime = 0,
	BirdObstacleCells = {},
	BirthLocation = Vector3.New(670, 0, 0),
	ObstaclePrefabs = {}
}

AmusementParkGameFlappyBirdUI = Base:Extend("AmusementParkGameFlappyBirdUI", "IQIGame.Onigao.UI.AmusementParkGameFlappyBirdUI", AmusementParkGameFlappyBirdUI)

require("IQIGame.UIExternalApi.AmusementParkGameFlappyBirdUIApi")

local AmusementParkBirdBG = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkBirdGame.AmusementParkBirdBG")
local AmusementParkBirdObstacleCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkBirdGame.AmusementParkBirdObstacleCell")
local AmusementParkBirdPlayer = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkBirdGame.AmusementParkBirdPlayer")

function AmusementParkGameFlappyBirdUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateOnClickBtnStartGame()
		self:OnClickBtnStartGame()
	end

	function self.DelegateOnClickBtnRank()
		self:OnClickBtnRank()
	end

	function self.DelegateOnClickBtnRest()
		self:OnClickBtnRest()
	end

	function self.DelegateUpdateBirdGameRank()
		self:RefreshRank()
	end

	function self.DelegateOnClick()
		self:OnClick()
	end

	self.UpCollider2D = self.Top:GetComponent(typeof(UnityEngine.Collider2D))
	self.DownCollider2D = self.Bottom:GetComponent(typeof(UnityEngine.Collider2D))
	self.ParkBirdBG = AmusementParkBirdBG.New(self.BGNode)
	self.BirdPlayer = AmusementParkBirdPlayer.New(self.Player)
	self.ObstaclePrefabs = {}

	for i = 1, self.BalkPrefabs.transform.childCount do
		local objTrs = self.BalkPrefabs.transform:Find(i)

		if objTrs then
			self.ObstaclePrefabs[i] = objTrs.gameObject
		end
	end
end

function AmusementParkGameFlappyBirdUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkGameFlappyBirdUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkGameFlappyBirdUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkGameFlappyBirdUI:GetBGM(userData)
	return nil
end

function AmusementParkGameFlappyBirdUI:OnOpen(userData)
	AmusementParkBirdGameModule.GetBirdGameRank()
	self:ResetGame()
end

function AmusementParkGameFlappyBirdUI:OnClose(userData)
	return
end

function AmusementParkGameFlappyBirdUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnStartGame:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnStartGame)
	self.BtnRank:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnRank)
	self.BtnRest:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnRest)
	self.BtnJump:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
	EventDispatcher.AddEventListener(EventID.APUpdateBirdGameRankEvent, self.DelegateUpdateBirdGameRank)
end

function AmusementParkGameFlappyBirdUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnStartGame:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnStartGame)
	self.BtnRank:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnRank)
	self.BtnRest:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnRest)
	self.BtnJump:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
	EventDispatcher.RemoveEventListener(EventID.APUpdateBirdGameRankEvent, self.DelegateUpdateBirdGameRank)
end

function AmusementParkGameFlappyBirdUI:OnPause()
	return
end

function AmusementParkGameFlappyBirdUI:OnResume()
	return
end

function AmusementParkGameFlappyBirdUI:OnCover()
	return
end

function AmusementParkGameFlappyBirdUI:OnReveal()
	return
end

function AmusementParkGameFlappyBirdUI:OnRefocus(userData)
	return
end

function AmusementParkGameFlappyBirdUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if AmusementParkBirdGameModule.apBirdGameData.startGame then
		self.ParkBirdBG:OnUpdate(elapseSeconds, realElapseSeconds)
		self.BirdPlayer:OnUpdate(elapseSeconds, realElapseSeconds)

		if PlayerModule.GetServerTime() - self.PassTime > 1 then
			self.PassTime = PlayerModule.GetServerTime()

			local level = AmusementParkBirdGameModule.apBirdGameData:GetCfgData().Level
			local score = AmusementParkBirdGameModule.apBirdGameData:GetGameScore()

			if level > AmusementParkBirdGameModule.maxLv then
				AmusementParkBirdGameModule.maxLv = level
				self.IsNewMaxScore = true
			end

			if level == AmusementParkBirdGameModule.maxLv and score > AmusementParkBirdGameModule.maxScore then
				AmusementParkBirdGameModule.maxScore = score
				self.IsNewMaxScore = true
			end

			self:RefreshScore()
		end

		if self.LastBirdObstacleCell then
			local direction = self.BirthLocation.x - self.LastBirdObstacleCell.View.transform.localPosition.x

			if direction >= AmusementParkBirdGameModule.apBirdGameData:GetCfgData().BalkCoolDown then
				self.LastBirdObstacleCell = nil

				self:CreateObstacle()
			end
		end

		for i, v in pairs(self.BirdObstacleCells) do
			v:OnUpdate(elapseSeconds, realElapseSeconds)

			if v.View.transform.localPosition.x < -self.BirthLocation.x then
				v:Dispose()

				self.BirdObstacleCells[i] = nil
			end
		end

		local result = self:CheckCollision()

		if result then
			self:GameOver()

			if self.IsNewMaxScore then
				AmusementParkBirdGameModule.PixelBird()
			end
		end
	end
end

function AmusementParkGameFlappyBirdUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkGameFlappyBirdUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkGameFlappyBirdUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkGameFlappyBirdUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.ParkBirdBG:Dispose()
	self.BirdPlayer:Dispose()
	self:CleanObstacles()
end

function AmusementParkGameFlappyBirdUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function AmusementParkGameFlappyBirdUI:CreateObstacle()
	local index = math.random(1, #AmusementParkBirdGameModule.apBirdGameData:GetCfgData().BalkGroup)
	local id = AmusementParkBirdGameModule.apBirdGameData:GetCfgData().BalkGroup[index]
	local obj = UnityEngine.Object.Instantiate(self.ObstaclePrefabs[id])

	obj:SetActive(true)

	local speed = AmusementParkBirdGameModule.apBirdGameData:GetCfgData().HorizontalSpeed
	local cell = AmusementParkBirdObstacleCell.New(obj)

	cell.View.transform:SetParent(self.ObstacleNode.transform, false)

	cell.View.transform.localPosition = self.BirthLocation

	cell:SetData(speed)
	table.insert(self.BirdObstacleCells, cell)

	self.LastBirdObstacleCell = cell
end

function AmusementParkGameFlappyBirdUI:UpdateView()
	self.ResultView:SetActive(false)

	local apBirdGameData = AmusementParkBirdGameModule.apBirdGameData

	self.ParkBirdBG:SetSpeed(apBirdGameData:GetCfgData().HorizontalSpeed)
	UGUIUtil.SetText(self.TextCurrentLV, AmusementParkGameFlappyBirdUIApi:GetString("TextCurrentLV", apBirdGameData:GetCfgData().Level))
	self:RefreshScore()
	self:RefreshRank()
end

function AmusementParkGameFlappyBirdUI:CleanObstacles()
	for i, v in pairs(self.BirdObstacleCells) do
		v:Dispose()
	end

	self.BirdObstacleCells = {}
end

function AmusementParkGameFlappyBirdUI:RefreshScore()
	UGUIUtil.SetText(self.TextGameScore, AmusementParkGameFlappyBirdUIApi:GetString("TextGameScore", AmusementParkBirdGameModule.apBirdGameData:GetGameScore()))
	UGUIUtil.SetText(self.TextMaxLv, AmusementParkGameFlappyBirdUIApi:GetString("TextCurrentLV", AmusementParkBirdGameModule.maxLv))
	UGUIUtil.SetText(self.TextMaxScore, AmusementParkGameFlappyBirdUIApi:GetString("TextGameScore", AmusementParkBirdGameModule.maxScore))
end

function AmusementParkGameFlappyBirdUI:RefreshRank()
	local showMyRank = AmusementParkBirdGameModule.myRanking

	self.TextRankTag:SetActive(false)

	if AmusementParkBirdGameModule.rankType == 2 then
		showMyRank = 999

		self.TextRankTag:SetActive(true)
	elseif showMyRank > 999 then
		showMyRank = 999

		self.TextRankTag:SetActive(true)
	end

	UGUIUtil.SetText(self.TextRank, AmusementParkGameFlappyBirdUIApi:GetString("TextRank", showMyRank))
	self:RefreshScore()
end

function AmusementParkGameFlappyBirdUI:OnClick()
	local speed = AmusementParkBirdGameModule.apBirdGameData:GetCfgData().VerticalUpSpeed
	local acceleration = AmusementParkBirdGameModule.apBirdGameData:GetCfgData().VerticalUpAcceleration

	self.BirdPlayer:SetData(acceleration, speed)
	GameEntry.Sound:PlaySound(10903, Constant.SoundGroup.UI)
end

function AmusementParkGameFlappyBirdUI:CheckCollision()
	local top = false

	top = self.BirdPlayer:CheckBirdBoundsIntersects(self.UpCollider2D)

	if top then
		return true
	end

	top = self.BirdPlayer:CheckBirdBoundsIntersects(self.DownCollider2D)

	if top then
		return true
	end

	for i, v in pairs(self.BirdObstacleCells) do
		top = self.BirdPlayer:CheckBirdBoundsIntersects(v.TopCollider2D)
		top = top or self.BirdPlayer:CheckBirdBoundsIntersects(v.BottomCollider2D)

		if top then
			return true
		end
	end

	return top
end

function AmusementParkGameFlappyBirdUI:GameOver()
	AmusementParkBirdGameModule.PixelBird()
	AmusementParkBirdGameModule.apBirdGameData:EndGame()
	self.BirdPlayer:PlayerDead()
	self.ResultView:SetActive(true)
	GameEntry.Sound:PlaySound(10906, Constant.SoundGroup.UI)
end

function AmusementParkGameFlappyBirdUI:ResetGame()
	AmusementParkBirdGameModule.CreateNewGame()

	self.IsNewMaxScore = false

	self.ParkBirdBG:ResetPos()
	self.BirdPlayer:ResetPlayer()
	self.BtnStartGame:SetActive(true)
	self:CleanObstacles()
	self:UpdateView()
end

function AmusementParkGameFlappyBirdUI:OnClickBtnStartGame()
	self.BtnStartGame:SetActive(false)
	self.ParkBirdBG:SetStartMove(true)
	AmusementParkBirdGameModule.apBirdGameData:StartGame()
	self:CreateObstacle()
end

function AmusementParkGameFlappyBirdUI:OnClickBtnRest()
	self:ResetGame()
end

function AmusementParkGameFlappyBirdUI:OnClickBtnRank()
	UIModule.Open(Constant.UIControllerName.AmusementParkGameFlappyBirdRankUI, Constant.UILayer.UI)
end

return AmusementParkGameFlappyBirdUI
