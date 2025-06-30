-- chunkname: @IQIGame\\UI\\Archives\\StoryReviewPlotItemView.lua

local StoryReviewPlotItemView = {}

function StoryReviewPlotItemView.New(go, mainView)
	local o = Clone(StoryReviewPlotItemView)

	o:Initialize(go, mainView)

	return o
end

function StoryReviewPlotItemView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function StoryReviewPlotItemView:InitComponent()
	self.imageIcon = self.imageIcon:GetComponent("Image")
end

function StoryReviewPlotItemView:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function StoryReviewPlotItemView:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function StoryReviewPlotItemView:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function StoryReviewPlotItemView:OnClickButtonClick()
	self.mainView:OpenStagePanel(self.optimizedViewsHolder.ItemIndex)
end

function StoryReviewPlotItemView:ButtonInactive()
	self.buttonClick:GetComponent("Button").interactable = false
end

function StoryReviewPlotItemView:OnDestroy()
	return
end

function StoryReviewPlotItemView:PlayInAnimation()
	LuaUtility.PlayAnimation(self.gameObject, "PlotMould_In")
end

function StoryReviewPlotItemView:Refresh(Data, OptimizedViewsHolder)
	self.data = Data
	self.optimizedViewsHolder = OptimizedViewsHolder

	LuaUtility.SetGameObjectShow(self.Unlock, self.data.PlotType == Constant.StoryReviewType.Main)
	LuaUtility.SetGameObjectShow(self.Locked, self.data.PlotType == Constant.StoryReviewType.Continue)

	if not LuaUtility.StrIsNullOrEmpty(self.data.PlotIcon) then
		LuaUtility.LoadImage(self, self.data.PlotIcon, self.imageIcon)
	else
		LuaUtility.LoadImage(self, "Assets/05_Images/UI/BasicsPart/Achievement/PlotDisplay/PlotDisplay_Bg_01.png", self.imageIcon)
	end

	LuaUtility.SetText(self.detailTitleText, "PART" .. OptimizedViewsHolder.ItemIndex + 1)
	LuaUtility.SetText(self.textName, self.data.Desc)
end

return StoryReviewPlotItemView
