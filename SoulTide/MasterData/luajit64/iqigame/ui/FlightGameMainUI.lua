-- chunkname: @IQIGame\\UI\\FlightGameMainUI.lua

local FlightGameMainUI = {}

FlightGameMainUI = Base:Extend("FlightGameMainUI", "IQIGame.Onigao.UI.FlightGameMainUI", FlightGameMainUI)

require("IQIGame.UIExternalApi.FlightGameMainUIApi")

local FlightGameBossHpView = require("IQIGame.UI.ExploreHall.FlightChallenge.FlightGameMain.FlightGameBossHpView")

function FlightGameMainUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateUpdateFlightGameDistance()
		self:OnUpdateFlightGameDistance()
	end

	function self.DelegateUpdatePlayer()
		self:OnUpdatePlayer()
	end

	function self.DelegateBtnSpecialItem()
		self:OnBtnSpecialItem()
	end

	self.joystickComp = self.Joystick:GetComponent("FingersJoystickScript")

	function self.joystickComp.JoystickExecuted(script, value)
		self:OnJoystickExecuted(script, value)
	end

	self.flightGameBossHpView = FlightGameBossHpView.New(self.BossHp)

	self:InitPlayerBtn()
end

function FlightGameMainUI:GetPreloadAssetPaths()
	return nil
end

function FlightGameMainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FlightGameMainUI:IsManualShowOnOpen(userData)
	return false
end

function FlightGameMainUI:GetBGM(userData)
	return nil
end

function FlightGameMainUI:OnOpen(userData)
	self:UpdateView()
	self.flightGameBossHpView:Hide()
end

function FlightGameMainUI:OnClose(userData)
	return
end

function FlightGameMainUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnSpecialItem:GetComponent("Button").onClick:AddListener(self.DelegateBtnSpecialItem)

	for k, v in pairs(self.playerBtnHandlers) do
		self["BtnPlayer" .. k]:GetComponent("Button").onClick:AddListener(v)
	end

	EventDispatcher.AddEventListener(EventID.UpdateFlightGameDistanceEvent, self.DelegateUpdateFlightGameDistance)
	EventDispatcher.AddEventListener(EventID.UpdateFlightGamePlayerEvent, self.DelegateUpdatePlayer)
end

function FlightGameMainUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnSpecialItem:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSpecialItem)

	for k, v in pairs(self.playerBtnHandlers) do
		self["BtnPlayer" .. k]:GetComponent("Button").onClick:RemoveListener(v)
	end

	EventDispatcher.RemoveEventListener(EventID.UpdateFlightGameDistanceEvent, self.DelegateUpdateFlightGameDistance)
	EventDispatcher.RemoveEventListener(EventID.UpdateFlightGamePlayerEvent, self.DelegateUpdatePlayer)
end

function FlightGameMainUI:OnPause()
	return
end

function FlightGameMainUI:OnResume()
	return
end

function FlightGameMainUI:OnCover()
	return
end

function FlightGameMainUI:OnReveal()
	return
end

function FlightGameMainUI:OnRefocus(userData)
	return
end

function FlightGameMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FlightGameMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FlightGameMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FlightGameMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FlightGameMainUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	self.joystickComp.JoystickExecuted = nil

	for i, v in pairs(self.playerBtnHandlers) do
		self.playerBtnHandlers[i] = nil
	end

	self.playerBtnHandlers = nil

	self.flightGameBossHpView:Dispose()

	self.flightGameBossHpView = nil
end

function FlightGameMainUI:InitPlayerBtn()
	self.playerBtnHandlers = {}

	local index = 1

	for i, v in pairs(FlightChallengeModule.flightGamePlayer) do
		if index <= 3 then
			self["BtnPlayer" .. index].name = i

			local path = UIGlobalApi.GetImagePath(v:GetConfigData().HeadIcon)

			AssetUtil.LoadImage(self, path, self["PlayerHead" .. index]:GetComponent("Image"))

			local fun = self["OnClickBtnPlayer" .. index]

			self.playerBtnHandlers[index] = function(...)
				fun(self, ...)
			end
		end

		index = index + 1
	end
end

function FlightGameMainUI:OnJoystickExecuted(script, value)
	EventDispatcher.Dispatch(EventID.JoystickMove, value)
end

function FlightGameMainUI:UpdateView()
	self:RefreshDistance()
	self:RefreshPlayerMsg()
	self:RefreshPlayerBtn()
end

function FlightGameMainUI:OnUpdateFlightGameDistance()
	self:RefreshDistance()
end

function FlightGameMainUI:OnUpdatePlayer()
	self:RefreshPlayerMsg()
end

function FlightGameMainUI:RefreshPlayerBtn()
	for i = 1, 3 do
		self["BtnPlayer" .. i]:SetActive(tonumber(self["BtnPlayer" .. i].name) ~= FlightGameModule.gamePlayerData.cid)
	end
end

function FlightGameMainUI:RefreshDistance()
	UGUIUtil.SetText(self.TextDistance, FlightGameMainUIApi:GetString("TextDistance", FlightGameModule.flightDistance))
	UGUIUtil.SetText(self.TextRewardNum, FlightGameMainUIApi:GetString("TextRewardNum", FlightGameModule.GetRewardBoxNum()))
end

function FlightGameMainUI:RefreshPlayerMsg()
	self.ImgBlood:GetComponent("Image").fillAmount = FlightGameModule.flightGameScene.gamePlayer.blood / FlightGameModule.totalBlood

	UGUIUtil.SetText(self.TextBlood, FlightGameMainUIApi:GetString("TextBlood", FlightGameModule.flightGameScene.gamePlayer.blood))
	UGUIUtil.SetText(self.TextSpeed, FlightGameMainUIApi:GetString("TextSpeed", FlightGameModule.flightGameScene.gamePlayer.flySpeed))
	UGUIUtil.SetText(self.TextSpecialItemNum, FlightGameModule.bombNum)
end

function FlightGameMainUI:OnClickBtnPlayer1()
	FlightGameModule.ChangeFlightChallengePlayer(tonumber(self.BtnPlayer1.name))
	self:RefreshPlayerBtn()
end

function FlightGameMainUI:OnClickBtnPlayer2()
	FlightGameModule.ChangeFlightChallengePlayer(tonumber(self.BtnPlayer2.name))
	self:RefreshPlayerBtn()
end

function FlightGameMainUI:OnClickBtnPlayer3()
	FlightGameModule.ChangeFlightChallengePlayer(tonumber(self.BtnPlayer3.name))
	self:RefreshPlayerBtn()
end

function FlightGameMainUI:OnBtnSpecialItem()
	FlightGameModule.UseBombs()
end

function FlightGameMainUI:OnClickBtnClose()
	FlightGameModule.GameOver()
end

return FlightGameMainUI
