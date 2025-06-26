-- chunkname: @IQIGame\\UI\\Puzzle\\PuzzleUIDetailPanel.lua

local PuzzleUIDetailPanel = {}

function PuzzleUIDetailPanel.New(go, mainView)
	local o = Clone(PuzzleUIDetailPanel)

	o:Initialize(go, mainView)

	return o
end

function PuzzleUIDetailPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function PuzzleUIDetailPanel:InitComponent()
	self.clueImg = self.clueImg:GetComponent("Image")
	self.SurveyCanvasGroup = self.buttonSurvey:GetComponent("CanvasGroup")
	self.ArrowList = {}

	for i = 1, 10 do
		local trans = LuaUtility.GetChild(self.arrowParent.transform, i - 1)

		table.insert(self.ArrowList, trans.gameObject)
	end
end

function PuzzleUIDetailPanel:InitDelegate()
	function self.delegateOnClickButtonSurvey()
		self:OnClickButtonSurvey()
	end
end

function PuzzleUIDetailPanel:AddListener()
	self.buttonSurvey:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonSurvey)
end

function PuzzleUIDetailPanel:RemoveListener()
	self.buttonSurvey:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonSurvey)
end

function PuzzleUIDetailPanel:OnClickButtonSurvey()
	self.mainView:Close()
	EventDispatcher.Dispatch(EventID.BehaviourTreeNPCClueTriggerEvent, self.Data.ActionParam)
end

function PuzzleUIDetailPanel:OnDestroy()
	self:RemoveListener()
	LuaUtility.UnLoadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function PuzzleUIDetailPanel:SetSurveyShow(show)
	self.SurveyCanvasGroup.alpha = show and 1 or 0
	self.SurveyCanvasGroup.blocksRaycasts = show and true or false
end

function PuzzleUIDetailPanel:RestState()
	self:SetSurveyShow(false)
end

function PuzzleUIDetailPanel:Refresh(Data)
	self:RestState()

	self.Data = Data

	LuaUtility.LoadImage(self, self.Data.Icon, self.clueImg)
	LuaUtility.SetText(self.clueNameText, self.Data.CluesName)
	LuaUtility.SetText(self.detailText, self.Data.Des)
	self:SetSurveyShow(self.Data.IsSurvey)
end

function PuzzleUIDetailPanel:ShowArrow(index)
	if self.CurrentArrow then
		LuaUtility.SetGameObjectShow(self.CurrentArrow, false)
	end

	LuaUtility.SetGameObjectShow(self.ArrowList[index], true)

	self.CurrentArrow = self.ArrowList[index]
end

function PuzzleUIDetailPanel:HideArrow()
	if self.CurrentArrow then
		LuaUtility.SetGameObjectShow(self.CurrentArrow, false)
	end
end

return PuzzleUIDetailPanel
