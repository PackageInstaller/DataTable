-- chunkname: @IQIGame\\UI\\MazeClockUI.lua

local MazeClockUI = Base:Extend("MazeClockUI", "IQIGame.Onigao.UI.MazeClockUI", {
	g = 0,
	radius = 0,
	PointerAngle = 0,
	Started = false,
	PlateSpeedRatio = 0,
	RetryCount = 0,
	BrickGos = {},
	BlockControllers = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MazeClockBlockController = require("IQIGame.UI.MazeClock.MazeClockBlockController")

function MazeClockUI:OnInit()
	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickRetryBtn()
		self:OnClickRetryBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickStartBtn()
		self:OnClickStartBtn()
	end

	self.BrickPool = UIObjectPool.New(8, function()
		return UnityEngine.Object.Instantiate(self.BrickPrefab)
	end, function(view)
		UnityEngine.Object.Destroy(view)
	end)
	self.BlockPools = {}
	self.BlockPools[1] = UIObjectPool.New(2, function()
		return MazeClockBlockController.New(UnityEngine.Object.Instantiate(self.Block1Prefab), 1)
	end, function(controller)
		local v = controller.View

		UnityEngine.Object.Destroy(v)
		controller:Dispose()
	end)
	self.BlockPools[2] = UIObjectPool.New(2, function()
		return MazeClockBlockController.New(UnityEngine.Object.Instantiate(self.Block2Prefab), 2)
	end, function(controller)
		local v = controller.View

		UnityEngine.Object.Destroy(v)
		controller:Dispose()
	end)
	self.BlockPools[3] = UIObjectPool.New(2, function()
		return MazeClockBlockController.New(UnityEngine.Object.Instantiate(self.Block3Prefab), 3)
	end, function(controller)
		local v = controller.View

		UnityEngine.Object.Destroy(v)
		controller:Dispose()
	end)
	self.OuterGlowNormalTweenGroupPlayer = self.OuterGlowNormal.transform:GetChild(0):GetComponent("TweenGroupPlayer")

	UGUIUtil.SetTextInChildren(self.ConfirmBtn, MazeClockUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetTextInChildren(self.RetryBtn, MazeClockUIApi:GetString("RetryBtnText"))
	UGUIUtil.SetTextInChildren(self.CloseBtn, MazeClockUIApi:GetString("CloseBtnText"))
	UGUIUtil.SetTextInChildren(self.StartBtn, MazeClockUIApi:GetString("StartBtnText"))

	local g, radius = MazeClockUIApi:GetString("Constants")

	self.g = g
	self.Radius = radius
end

function MazeClockUI:GetPreloadAssetPaths()
	return nil
end

function MazeClockUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeClockUI:IsManualShowOnOpen(userData)
	return false
end

function MazeClockUI:GetBGM(userData)
	return nil
end

function MazeClockUI:OnOpen(userData)
	self.CfgMazePendulumData = CfgMazePendulumTable[userData.cid]
	self.RetryCount = userData.retryCount
	self.PlateSpeedRatio = 1 + userData.speedChange / 100
	self.BrickList = userData.brickList

	self:UpdateView()
end

function MazeClockUI:OnClose(userData)
	self.Started = false

	ModuleTimerUtil.Stop(Constant.UIControllerName.MazeClockUI)
end

function MazeClockUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.RetryBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRetryBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.StartBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickStartBtn)
end

function MazeClockUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.RetryBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRetryBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.StartBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickStartBtn)
end

function MazeClockUI:OnPause()
	return
end

function MazeClockUI:OnResume()
	return
end

function MazeClockUI:OnCover()
	return
end

function MazeClockUI:OnReveal()
	return
end

function MazeClockUI:OnRefocus(userData)
	return
end

function MazeClockUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self:UpdateRotation(elapseSeconds)
end

function MazeClockUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeClockUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeClockUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeClockUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:ClearBricks(true)
	self.BrickPool:Dispose()
	self:ClearBlocks(false)

	for i = 1, #self.BlockPools do
		local pool = self.BlockPools[i]

		pool:Dispose()
	end
end

function MazeClockUI:UpdateView()
	self.RetryBtn:SetActive(false)
	self.CloseBtn:SetActive(false)
	self.ConfirmBtn:SetActive(false)
	self.StartBtn:SetActive(true)

	for i = 1, 3 do
		self["PlateAngle" .. i] = 0
		self["Plate" .. i].transform.rotation = Quaternion.identity
	end

	self.PointerAngle = 0
	self.Pointer.transform.rotation = Quaternion.identity

	self:ClearBricks(false)

	for i = 1, #self.BrickList do
		local brickData = self.BrickList[i]
		local brick = self.BrickPool:Obtain()

		brick:SetActive(true)
		brick.transform:SetParent(self["BrickNode" .. brickData.ClockLevel].transform, false)

		brick.transform.rotation = Quaternion.Euler(0, 0, -brickData.ClockArea[1])

		local imgComponent = brick:GetComponent("Image")

		imgComponent.fillAmount = (brickData.ClockArea[2] - brickData.ClockArea[1]) / 360

		AssetUtil.LoadImage(self, MazeClockUIApi:GetString("BrickImagePath", brickData.ClockType, brickData.ClockLevel), imgComponent, self.OnLoadBrickComplete, nil, imgComponent)
		table.insert(self.BrickGos, brick)
	end

	self:ClearBlocks(false)

	for i = 1, #self.CfgMazePendulumData.ShadowArea, 2 do
		local type = self.CfgMazePendulumData.ShadowArea[i]
		local angle = self.CfgMazePendulumData.ShadowArea[i + 1]
		local controller = self.BlockPools[type]:Obtain()

		controller.View:SetActive(true)
		controller.View.transform:SetParent(self.BlockNode.transform, false)

		controller.View.transform.rotation = Quaternion.Euler(0, 0, -angle)

		table.insert(self.BlockControllers, controller)
	end

	self.OuterGlowNormal:SetActive(true)

	for i = 0, 3 do
		self["OuterGlowResult" .. i]:SetActive(false)
	end

	self.OuterGlowNormalTweenGroupPlayer:Play(1)

	self.RetryCount = self.RetryCount - 1
	self.ResultIndex = -1

	self:UpdatePointLight()
end

function MazeClockUI:ClearBricks(isDestroy)
	for i = 1, #self.BrickGos do
		local go = self.BrickGos[i]

		if not isDestroy then
			go.transform:SetParent(self.UIController.transform, false)
		end

		go:SetActive(false)
		self.BrickPool:Release(go)
	end

	self.BrickGos = {}
end

function MazeClockUI:ClearBlocks(isDestroy)
	for i = 1, #self.BlockControllers do
		local controller = self.BlockControllers[i]

		if not isDestroy then
			controller.View.transform:SetParent(self.UIController.transform, false)
		end

		controller.View:SetActive(false)
		self.BlockPools[controller.Type]:Release(controller)
	end

	self.BlockControllers = {}
end

function MazeClockUI:OnLoadBrickComplete(assetName, asset, duration, userData)
	userData:SetNativeSize()
	userData.gameObject:SetActive(true)
end

function MazeClockUI:UpdateRotation(elapsedSeconds)
	if self.Started then
		for i = 1, 3 do
			local data = self.CfgMazePendulumData.LevelSpeed[i]

			self["PlateAngle" .. i] = self["PlateAngle" .. i] + data[1] * self.PlateSpeedRatio * data[2] * elapsedSeconds

			if self["PlateAngle" .. i] >= 360 then
				self["PlateAngle" .. i] = self["PlateAngle" .. i] % 360
			elseif self["PlateAngle" .. i] < 0 then
				self["PlateAngle" .. i] = self["PlateAngle" .. i] % 360 + 360
			end

			self["Plate" .. i].transform.rotation = Quaternion.Euler(0, 0, -self["PlateAngle" .. i])
		end

		local w = math.pow(2 * self.g * (1 - math.cos(self.PointerAngle / 180 * math.pi)) / self.Radius + self.CfgMazePendulumData.PointerSpeed * self.CfgMazePendulumData.PointerSpeed, 0.5)

		self.PointerAngle = self.PointerAngle + w

		if self.PointerAngle >= 360 then
			self.PointerAngle = self.PointerAngle % 360
		end

		self.Pointer.transform.rotation = Quaternion.Euler(0, 0, -self.PointerAngle)

		self:UpdatePointLight()
	end
end

function MazeClockUI:UpdatePointLight()
	self.TargetBrickData = nil
	self.ResultIndex = -1

	local minLevel = 4

	for i = 1, #self.BrickList do
		local brickData = self.BrickList[i]
		local startAngle = brickData.ClockArea[1] + self["PlateAngle" .. brickData.ClockLevel]

		if startAngle >= 360 then
			startAngle = startAngle % 360
		end

		local endAngle = brickData.ClockArea[2] - brickData.ClockArea[1] + startAngle

		if (startAngle <= self.PointerAngle and endAngle > self.PointerAngle or startAngle <= self.PointerAngle + 360 and endAngle > self.PointerAngle + 360) and minLevel > brickData.ClockLevel then
			minLevel = brickData.ClockLevel
			self.TargetBrickData = brickData
			self.ResultIndex = i
		end
	end

	local pointLightLevel = 0

	if self.TargetBrickData ~= nil then
		pointLightLevel = self.TargetBrickData.ClockLevel
	end

	local size = self.PointLightContainer.transform.sizeDelta

	size.y = MazeClockUIApi:GetString("PointLightDistance", pointLightLevel)
	self.PointLightContainer.transform.sizeDelta = size
end

function MazeClockUI:OnClickConfirmBtn()
	if self.Started then
		self.Started = false

		self.ConfirmBtn:SetActive(false)

		local resultType = 0

		if self.TargetBrickData ~= nil then
			resultType = self.TargetBrickData.ClockType
		end

		self.OuterGlowNormalTweenGroupPlayer:Play(2)

		local timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.MazeClockUI, function()
			self.OuterGlowNormal:SetActive(false)

			for i = 0, 3 do
				self["OuterGlowResult" .. i]:SetActive(i == resultType)
			end

			if self.RetryCount > 0 then
				self.RetryBtn:SetActive(true)
			else
				self.CloseBtn:SetActive(true)
			end
		end, 0.75)

		timer:Start()
	end
end

function MazeClockUI:OnClickRetryBtn()
	self:UpdateView()
	self:StartGame()
end

function MazeClockUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.MazeClockUI)
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_ENDCLOCK_ORDER, {
		Index = self.ResultIndex
	})
end

function MazeClockUI:OnClickStartBtn()
	self:StartGame()
end

function MazeClockUI:StartGame()
	self.StartBtn:SetActive(false)
	self.ConfirmBtn:SetActive(true)

	self.Started = true
end

return MazeClockUI
