-- chunkname: @IQIGame\\UI\\Story\\Maze\\StoryMazePanel.lua

local StoryMazePanel = {}
local MazeMapViewClass = require("IQIGame.UI.Story.Maze.MazeMapView")
local MazeSmallMapClass = require("IQIGame.UI.Story.Maze.MazeSmallMapView")
local MazeHeroItemViewClass = require("IQIGame.UI.Story.Maze.MazeHeroItemView")

function StoryMazePanel.New(go, mainView)
	local o = Clone(StoryMazePanel)

	o:Initialize(go, mainView)

	return o
end

function StoryMazePanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMember()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function StoryMazePanel:InitMember()
	self.heroItemViewArray = {}
end

function StoryMazePanel:InitComponent()
	self.smallMapView = MazeSmallMapClass.New(self.smallMapItem, self)
	self.mapView = MazeMapViewClass.New(self.mapItem, self)

	self.mapView:Close()

	self.warningMaterial = self.decorate:GetComponent("Image").material

	self.warningMaterial:SetFloat("_lerp", 0)
end

function StoryMazePanel:InitDelegate()
	function self.delegateOnClickReturnButton()
		StoryModule.PauseStory()
		NoticeModule.ShowNotice(80001, function()
			MazeModule.InTheMaze = false

			EventDispatcher.Dispatch(EventID.QuitStageLevel)
		end, function()
			NoticeModule.ShowNotice(80002, function()
				BehaviorTreeUtility.CompleteLevel(true)
			end)
		end)
		EventDispatcher.AddSingleEventListener(EventID.ConfirmationUICloseEvent, function()
			StoryModule.ContinueStory()
		end)
	end

	function self.delegateOnClickRightBtn()
		self:OnClickRightBtn()
	end

	function self.refreshEvent()
		self:Refresh()
	end

	function self.delegateOnClickFormationBtn()
		self:OnClickFormationBtn()
	end

	function self.setWarningShowDelegate(type)
		self:SetWarningShow(type)
	end

	function self.delegateOnClickButtonPuzzle()
		self:OnClickButtonPuzzle()
	end

	function self.setMazePuzzleButtonShowEvent(isShow)
		self:SetMazePuzzleShow(isShow)
	end

	function self.SetDeviceButtonShowEvent(isShow)
		self:SetDeviceButtonShow(isShow)
	end
end

function StoryMazePanel:AddListener()
	self.ReturnBtn:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.delegateOnClickReturnButton)
	self.FormationBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickFormationBtn)
	self.rightBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickRightBtn)
	self.buttonPuzzle:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonPuzzle)
	EventDispatcher.AddEventListener(EventID.MazeStagePanelRefreshEvent, self.refreshEvent)
	EventDispatcher.AddEventListener(EventID.SetMazeWarningShowEvent, self.setWarningShowDelegate)
	EventDispatcher.AddEventListener(EventID.SetMazePuzzleShowEvent, self.setMazePuzzleButtonShowEvent)
	EventDispatcher.AddEventListener(EventID.SetMazeDeviceShowEvent, self.SetDeviceButtonShowEvent)
end

function StoryMazePanel:RemoveListener()
	self.ReturnBtn:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.delegateOnClickReturnButton)
	self.FormationBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickFormationBtn)
	self.rightBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickRightBtn)
	self.buttonPuzzle:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonPuzzle)
	EventDispatcher.RemoveEventListener(EventID.MazeStagePanelRefreshEvent, self.refreshEvent)
	EventDispatcher.RemoveEventListener(EventID.SetMazeWarningShowEvent, self.setWarningShowDelegate)
	EventDispatcher.RemoveEventListener(EventID.SetMazePuzzleShowEvent, self.setMazePuzzleButtonShowEvent)
	EventDispatcher.RemoveEventListener(EventID.SetMazeDeviceShowEvent, self.SetDeviceButtonShowEvent)
end

function StoryMazePanel:SetDeviceButtonShow(isShow)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.rightBtn, isShow)
end

function StoryMazePanel:OnDestroy()
	self:RemoveListener()
	self.mapView:OnDestroy()

	self.mapView = nil

	self.smallMapView:OnDestroy()

	self.smallMapView = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	GameObject.Destroy(self.gameObject)
end

function StoryMazePanel:OnClose()
	self:RemoveListener()
end

function StoryMazePanel:OnOpen()
	self:AddListener()
end

function StoryMazePanel:Open()
	return
end

function StoryMazePanel:Close()
	return
end

function StoryMazePanel:SetMazePuzzleShow(isShow)
	LuaUtility.SetGameObjectShow(self.buttonPuzzle, isShow)
end

function StoryMazePanel:OnClickButtonPuzzle()
	UIModule.Open(Constant.UIControllerName.PuzzleUI, Constant.UILayer.UI)
end

function StoryMazePanel:OnClickRightBtn()
	UIModule.Open(Constant.UIControllerName.MazeEquipUI, Constant.UILayer.UI)
end

function StoryMazePanel:OnClickFormationBtn()
	local userData = {}

	userData.StageId = MazeStageModule.GetMazeStageID()
	userData.OpenType = Constant.FormationOpenType.Maze
	userData.IsActiveHomeBtn = false

	function userData.startFunction()
		UIModule.Close(Constant.UIControllerName.FormationUI)
	end

	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
end

function StoryMazePanel:Refresh()
	self.smallMapView:Refresh()
	self:RefreshHeroes()
end

function StoryMazePanel:RefreshHeroes()
	local mazePod = MazeStageModule.GetMazeStagePOD()
	local heroData = mazePod.heros
	local index = 1

	for _, v in pairs(heroData) do
		local view = self:_GetHeroView(index)

		view:Refresh(v)
		view:Show()

		index = index + 1
	end

	local len = #self.heroItemViewArray

	for i = index, len do
		self.heroItemViewArray[i]:Hide()
	end
end

function StoryMazePanel:_GetHeroView(index)
	if not self.heroItemViewArray[index] then
		local o = GameObject.Instantiate(self.heroItem, self.formationGrid.transform)

		self.heroItemViewArray[index] = MazeHeroItemViewClass.New(o, self)
	end

	return self.heroItemViewArray[index]
end

function StoryMazePanel:ShowBigMap()
	self.mapView:Open()
	self.mapView:Refresh()
end

function StoryMazePanel:SetWarningShow(type)
	if type == type == Constant.MazeWarningDefine.Low then
		self.warningMaterial:SetFloat("_lerp", 0)
	elseif type == Constant.MazeWarningDefine.Medium then
		self.warningMaterial:SetFloat("_lerp", 1)
	elseif type == Constant.MazeWarningDefine.High then
		self.warningMaterial:SetFloat("_lerp", 2)
	end
end

function StoryMazePanel:OnClickButtonGM()
	return
end

return StoryMazePanel
