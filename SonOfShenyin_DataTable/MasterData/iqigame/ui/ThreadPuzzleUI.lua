-- chunkname: @IQIGame\\UI\\ThreadPuzzleUI.lua

local ThreadPuzzleUI = {}

ThreadPuzzleUI = Base:Extend("ThreadPuzzleUI", "IQIGame.Onigao.UI.ThreadPuzzleUI", ThreadPuzzleUI)

local ThreadPuzzleClueItemClass = require("IQIGame.UI.Puzzle.ThreadPuzzleClueItem")

function ThreadPuzzleUI:OnInit()
	self:InitComponent()
	self:InitDelegate()
end

function ThreadPuzzleUI:InitComponent()
	self.buttonClose = self.buttonClose:GetComponent("Button")
	self.buttonTurnLeft = self.buttonTurnLeft:GetComponent("Button")
	self.buttonTurnRight = self.buttonTurnRight:GetComponent("Button")
	self.imageAnswerShape = self.imageAnswerShape:GetComponent("Image")
	self.imageItem = self.imageItem:GetComponent("Image")
	self.puzzlePanelIcon = self.puzzlePanelIcon:GetComponent("Image")
	self.imageBackground = self.imageBackground:GetComponent("Image")
	self.puzzleClueItemList = {}

	for i = 1, LuaUtility.GetChildCount(self.CluesContentLeftRoot.transform) do
		local objectCluesItemTrans = LuaUtility.GetChild(self.CluesContentLeftRoot.transform, i - 1)
		local puzzleClueItem = ThreadPuzzleClueItemClass.New(objectCluesItemTrans.gameObject, self)

		table.insert(self.puzzleClueItemList, puzzleClueItem)

		objectCluesItemTrans = LuaUtility.GetChild(self.CluesContentRightRoot.transform, i - 1)
		puzzleClueItem = ThreadPuzzleClueItemClass.New(objectCluesItemTrans.gameObject, self)

		table.insert(self.puzzleClueItemList, puzzleClueItem)
	end
end

function ThreadPuzzleUI:InitDelegate()
	function self.buttonCloseDelegate()
		self:Close()
	end

	function self.buttonTurnLeftDelegate()
		self:OnButtonTurnLeftClick()
	end

	function self.buttonTurnRightDelegate()
		self:OnButtonTurnRightClick()
	end
end

function ThreadPuzzleUI:OnAddListeners()
	self.buttonClose.onClick:AddListener(self.buttonCloseDelegate)
	self.buttonTurnLeft.onClick:AddListener(self.buttonTurnLeftDelegate)
	self.buttonTurnRight.onClick:AddListener(self.buttonTurnRightDelegate)
end

function ThreadPuzzleUI:OnRemoveListeners()
	self.buttonClose.onClick:RemoveListener(self.buttonCloseDelegate)
	self.buttonTurnLeft.onClick:RemoveListener(self.buttonTurnLeftDelegate)
	self.buttonTurnRight.onClick:RemoveListener(self.buttonTurnRightDelegate)
end

function ThreadPuzzleUI:GetPreloadAssetPaths()
	return nil
end

function ThreadPuzzleUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ThreadPuzzleUI:IsManualShowOnOpen(userData)
	return false
end

function ThreadPuzzleUI:GetBGM(userData)
	return nil
end

function ThreadPuzzleUI:OnOpen(userData)
	LuaUtility.PlayAnimation(self.gameObject, "ThreadPuzzleUI_In")
	self:Refresh(userData)
end

function ThreadPuzzleUI:OnClose(userData)
	self.isAnimation = false
end

function ThreadPuzzleUI:OnPause()
	return
end

function ThreadPuzzleUI:OnResume()
	return
end

function ThreadPuzzleUI:OnCover()
	return
end

function ThreadPuzzleUI:OnReveal()
	return
end

function ThreadPuzzleUI:OnRefocus(userData)
	return
end

function ThreadPuzzleUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ThreadPuzzleUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ThreadPuzzleUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ThreadPuzzleUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ThreadPuzzleUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function ThreadPuzzleUI:Close()
	UIModule.Close(Constant.UIControllerName.ThreadPuzzleUI)
end

function ThreadPuzzleUI:OnButtonTurnLeftClick()
	self.currentEulerAngleZ = self.currentEulerAngleZ - self.cfgDecryptionCluesData.Angle

	if self.currentEulerAngleZ < 0 then
		self.currentEulerAngleZ = 360 - self.cfgDecryptionCluesData.Angle
	end

	LuaUtility.SetEulerAnglesWithGameObject(self.imageAnswerShape.gameObject, 0, 0, self.currentEulerAngleZ)
end

function ThreadPuzzleUI:OnButtonTurnRightClick()
	self.currentEulerAngleZ = self.currentEulerAngleZ + self.cfgDecryptionCluesData.Angle

	if self.currentEulerAngleZ > 360 then
		self.currentEulerAngleZ = self.cfgDecryptionCluesData.Angle
	end

	LuaUtility.SetEulerAnglesWithGameObject(self.imageAnswerShape.gameObject, 0, 0, self.currentEulerAngleZ)
end

function ThreadPuzzleUI:Refresh(openData)
	self.currentSelectClueID = 0

	LuaUtility.SetGameObjectShow(self.imageItem.gameObject, false)
	LuaUtility.SetGameObjectShow(self.imageSuccess, false)
	LuaUtility.SetGameObjectShow(self.imageLose, false)
	LuaUtility.SetGameObjectShow(self.puzzlePanelIcon.gameObject, false)
	LuaUtility.SetGameObjectShow(self.puzzlePanelIcon.gameObject, false)
	LuaUtility.SetGameObjectShow(self.effectSuccessful, false)
	LuaUtility.SetGameObjectShow(self.effectFailure, false)

	self.cfgDecryptionCluesData = PuzzleModule.GetThreadPuzzleCfgData(openData.cluePuzzleID)

	local storyCluesData = PuzzleModule.GetCurrentStoryCluesData()

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.cfgDecryptionCluesData.Shape), self.imageAnswerShape)

	if not self.cfgDecryptionCluesData.ImageBackground or LuaUtility.StrIsNullOrEmpty(self.cfgDecryptionCluesData.ImageBackground) then
		LuaUtility.SetGameObjectShow(self.imageBackground.gameObject, false)
	else
		LuaUtility.SetGameObjectShow(self.imageBackground.gameObject, true)
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.cfgDecryptionCluesData.ImageBackground), self.imageBackground)
	end

	LuaUtility.SetText(self.textHead, self.cfgDecryptionCluesData.Title)
	LuaUtility.SetText(self.textDescription, self.cfgDecryptionCluesData.Des)
	LuaUtility.SetEulerAnglesWithGameObject(self.imageAnswerShape.gameObject, 0, 0, self.cfgDecryptionCluesData.FirstAngle)

	self.currentEulerAngleZ = self.cfgDecryptionCluesData.FirstAngle

	for i = 1, getCfgTableLength(self.puzzleClueItemList) do
		if i <= getCfgTableLength(storyCluesData) then
			self.puzzleClueItemList[i]:Refresh(storyCluesData[i])
			self.puzzleClueItemList[i]:Show()
		else
			self.puzzleClueItemList[i]:Hide()
		end
	end
end

function ThreadPuzzleUI:CheckAnswer()
	LuaUtility.SetGameObjectShow(self.imageSuccess, false)
	LuaUtility.SetGameObjectShow(self.imageLose, false)

	if self.currentEulerAngleZ == self.cfgDecryptionCluesData.RightAngle and self.currentSelectClueID == self.cfgDecryptionCluesData.CluesID then
		self:OnPuzzleSucceed()
	else
		self:OnPuzzleFailed()
	end
end

function ThreadPuzzleUI:OnPuzzleSucceed()
	LuaUtility.SetGameObjectShow(self.imageSuccess, true)
	LuaUtility.SetGameObjectShow(self.effectSuccessful, true)

	self.isAnimation = true

	Timer.New(function()
		EventDispatcher.Dispatch(EventID.BehaviourTreeNPCClueTriggerEvent, self.cfgDecryptionCluesData.SucceedParam)

		self.isAnimation = false

		self:Close()
	end, 1, 1):Start()
end

function ThreadPuzzleUI:OnPuzzleFailed()
	LuaUtility.SetGameObjectShow(self.effectFailure, true)

	self.isAnimation = true

	Timer.New(function()
		LuaUtility.SetGameObjectShow(self.imageItem.gameObject, false)
		LuaUtility.SetGameObjectShow(self.puzzlePanelIcon.gameObject, false)
		LuaUtility.SetGameObjectShow(self.imageLose, false)
		LuaUtility.SetGameObjectShow(self.effectFailure, false)

		self.isAnimation = false
	end, 0.7, 1):Start()
	LuaUtility.PlaySoundWithID(22000022)
end

function ThreadPuzzleUI:ShowCluesItem(clueID)
	if self.isAnimation then
		return
	end

	self.currentSelectClueID = clueID

	local cfgCluesData = PuzzleModule.GetCluesCfgDataWithID(clueID)

	AssetUtil.LoadImage(self, cfgCluesData.Icon, self.imageItem)
	AssetUtil.LoadImage(self, cfgCluesData.Shape, self.puzzlePanelIcon)
	LuaUtility.SetText(self.textPuzzlePanelName, cfgCluesData.CluesName)
	LuaUtility.SetGameObjectShow(self.imageItem.gameObject, true)
	LuaUtility.SetGameObjectShow(self.puzzlePanelIcon.gameObject, true)
	self:CheckAnswer()
end

return ThreadPuzzleUI
