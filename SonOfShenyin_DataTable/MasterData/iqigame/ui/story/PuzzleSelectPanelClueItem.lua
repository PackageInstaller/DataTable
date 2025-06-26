-- chunkname: @IQIGame\\UI\\Story\\PuzzleSelectPanelClueItem.lua

local PuzzleSelectPanelClueItem = {}

function PuzzleSelectPanelClueItem.New(go, mainView)
	local o = Clone(PuzzleSelectPanelClueItem)

	o:Initialize(go, mainView)

	return o
end

function PuzzleSelectPanelClueItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.objectParent = self.gameObject.transform.parent.gameObject

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function PuzzleSelectPanelClueItem:InitComponent()
	self.SetAshComponent = self.gameObject:GetComponent(typeof(IQIGame.Onigao.Game.SetAshComponent))
	self.nameTextBg = self.textCommonName:GetComponent("BordlessFramework.UI.TextBackgroundSource")
end

function PuzzleSelectPanelClueItem:InitDelegate()
	function self.buttonClickDelegate()
		self:OnButtonClickClick()
	end
end

function PuzzleSelectPanelClueItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.buttonClickDelegate)
end

function PuzzleSelectPanelClueItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.buttonClickDelegate)
end

function PuzzleSelectPanelClueItem:OnButtonClickClick()
	if self.mainView.isPlayingAnimation then
		return
	end

	UIModule.Open(Constant.UIControllerName.PuzzleSelectDetailUI, Constant.UILayer.UI, {
		ClueID = self.Data
	})

	if self.OnClueClickDelegate then
		EventDispatcher.RemoveEventListener(EventID.StoryPuzzleSelectClickEvent, self.OnClueClickDelegate)

		self.OnClueClickDelegate = nil
	end

	function self.OnClueClickDelegate(clueID)
		LuaUtility.PlayAnimation(self.objectParent, "clueContent_Get", nil, function()
			self.mainView:OnClueClick(clueID)
			self.mainView:Close()

			self.mainView.isPlayingAnimation = false
		end)
		self.mainView:PlayHideSelectAnimation(self.Data)
		EventDispatcher.RemoveEventListener(EventID.StoryPuzzleSelectClickEvent, self.OnClueClickDelegate)

		self.OnClueClickDelegate = nil
	end

	EventDispatcher.AddEventListener(EventID.StoryPuzzleSelectClickEvent, self.OnClueClickDelegate)
	StoryUIApi:PlaySelectPuzzleSound()
end

function PuzzleSelectPanelClueItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function PuzzleSelectPanelClueItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)

	if self.OnClueClickDelegate then
		EventDispatcher.RemoveEventListener(EventID.StoryPuzzleSelectClickEvent, self.OnClueClickDelegate)

		self.OnClueClickDelegate = nil
	end
end

function PuzzleSelectPanelClueItem:OnDestroy()
	self:RemoveListener()

	if self.OnClueClickDelegate then
		EventDispatcher.RemoveEventListener(EventID.StoryPuzzleSelectClickEvent, self.OnClueClickDelegate)

		self.OnClueClickDelegate = nil
	end

	LuaUtility.UnLoadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function PuzzleSelectPanelClueItem:SetComplete(isComplete)
	self.SetAshComponent:SetAsh(isComplete)
	LuaUtility.SetGameObjectShow(self.objectComplete, isComplete)

	self.isComplete = isComplete
end

function PuzzleSelectPanelClueItem:ResetView()
	self:SetComplete(false)
end

function PuzzleSelectPanelClueItem:Refresh(clueID, selectCfgID)
	self:ResetView()

	self.Data = clueID

	local cfg = CfgUtil.GetCfgCluesDataWithID(clueID)

	LuaUtility.LoadImage(self, cfg.Icon, self.imageCommonItem:GetComponent("Image"), function()
		LuaUtility.SetImageNativeSizeWithGameObject(self.imageCommonItem)
	end)
	LuaUtility.SetText(self.textCommonName, cfg.CluesName)

	if StoryModule.CheckOptionHadTrigger(selectCfgID, clueID) then
		self:SetComplete(true)
	end

	coroutine.start(function()
		coroutine.wait(0.01)
		self.nameTextBg:SetProgress(0)
		self.nameTextBg:SetProgress(1)
	end)
end

function PuzzleSelectPanelClueItem:PlayHideAnimation()
	LuaUtility.PlayAnimation(self.objectParent, "selectContent_Out2")
end

return PuzzleSelectPanelClueItem
