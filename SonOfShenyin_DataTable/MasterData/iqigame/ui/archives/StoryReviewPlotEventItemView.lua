-- chunkname: @IQIGame\\UI\\Archives\\StoryReviewPlotEventItemView.lua

local StoryReviewPlotEventItemView = {}

function StoryReviewPlotEventItemView.New(go, mainView)
	local o = Clone(StoryReviewPlotEventItemView)

	o:Initialize(go, mainView)

	return o
end

function StoryReviewPlotEventItemView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function StoryReviewPlotEventItemView:InitComponent()
	return
end

function StoryReviewPlotEventItemView:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function StoryReviewPlotEventItemView:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function StoryReviewPlotEventItemView:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function StoryReviewPlotEventItemView:OnClickButtonClick()
	StoryChapterModule.EnterDup(self.data.Id, true)
	GameChapterModule.SetupCurChapterType(Constant.ChapterPassType.TYPE_StoryReview)
end

function StoryReviewPlotEventItemView:OnDestroy()
	return
end

function StoryReviewPlotEventItemView:PlayInAnimation()
	LuaUtility.PlayAnimation(self.gameObject, "plotEventItem_In")
end

function StoryReviewPlotEventItemView:Refresh(Data, index)
	self.data = Data

	if not StoryChapterModule.GetStoryReviewStageIsLock(self.data.Id) then
		LuaUtility.SetGameObjectShow(self.Locked, true)
		LuaUtility.SetGameObjectShow(self.Unlock, false)

		return
	end

	LuaUtility.SetGameObjectShow(self.Locked, false)
	LuaUtility.SetGameObjectShow(self.Unlock, true)
	LuaUtility.SetText(self.textName, self.data.Name)
	LuaUtility.SetText(self.TitleText, index < 10 and "0" .. index or index)
	self:PlayInAnimation()
end

return StoryReviewPlotEventItemView
