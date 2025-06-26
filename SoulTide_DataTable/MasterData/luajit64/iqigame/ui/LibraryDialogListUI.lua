-- chunkname: @IQIGame\\UI\\LibraryDialogListUI.lua

local LibraryDialogListUI = Base:Extend("LibraryDialogListUI", "IQIGame.Onigao.UI.LibraryDialogListUI", {})
local storyTypes = {
	{
		Constant.LibraryStoryType.TownStory,
		LibraryStoryUIApi:GetString("StoryTypeName", Constant.LibraryStoryType.TownStory)
	},
	{
		Constant.LibraryStoryType.SoulStory,
		LibraryStoryUIApi:GetString("StoryTypeName", Constant.LibraryStoryType.SoulStory)
	},
	{
		Constant.LibraryStoryType.NPCStory,
		LibraryStoryUIApi:GetString("StoryTypeName", Constant.LibraryStoryType.NPCStory)
	},
	{
		Constant.LibraryStoryType.MazeStory,
		LibraryStoryUIApi:GetString("StoryTypeName", Constant.LibraryStoryType.MazeStory)
	},
	{
		Constant.LibraryStoryType.StoryCG,
		LibraryStoryUIApi:GetString("StoryTypeName", Constant.LibraryStoryType.StoryCG)
	},
	{
		Constant.LibraryStoryType.ActionStory,
		LibraryStoryUIApi:GetString("StoryTypeName", Constant.LibraryStoryType.ActionStory)
	}
}
local LibraryDialogView = require("IQIGame.UI.Library.LibraryDialogView")
local LibraryDialogSoulView = require("IQIGame.UI.Library.LibraryDialogSoulView")
local LibraryDialogNpcView = require("IQIGame.UI.Library.LibraryDialogNpcView")
local LibraryDialogMazeView = require("IQIGame.UI.Library.LibraryDialogMazeView")
local LibraryDialogCGView = require("IQIGame.UI.Library.LibraryDialogCGView")
local libraryActionStoryView = require("IQIGame.UI.Library.LibraryActionStoryView")

require("IQIGame.UI.AVPro.AVProView")

function LibraryDialogListUI:OnInit()
	UGUIUtil.SetText(self.PanelTitle, LibraryStoryUIApi:GetString("PanelTitle"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateTaskCommitResponse(cids, awards)
		self:OnTaskCommitResponse(cids, awards)
	end

	function self.delegateBtnReward()
		self:OnClickBtnReward()
	end

	function self.delegateBtnJump()
		self:OnCloseMedia()
	end

	function self.delegateOnPlayMovieComplete()
		self:OnPlayMovieComplete()
	end

	function self.delegateOnPlayMovieLoad(x, y)
		self:OnPlayMovieLoad(x, y)
	end

	function self.delegateOnPlayMovieError()
		self:OnPlayMovieError()
	end

	self.scrollList = self.Toggle:GetComponent("ScrollAreaList")

	function self.scrollList.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	self.PanelViews = {}

	for i = 1, #storyTypes do
		local typeData = storyTypes[i]
		local type = typeData[1]
		local childView

		if type == Constant.LibraryStoryType.TownStory then
			childView = LibraryDialogView.New(self.DialogList)
		elseif type == Constant.LibraryStoryType.SoulStory then
			childView = LibraryDialogSoulView.New(self.SoulList)
		elseif type == Constant.LibraryStoryType.NPCStory then
			childView = LibraryDialogNpcView.New(self.NpcList)
		elseif type == Constant.LibraryStoryType.MazeStory then
			childView = LibraryDialogMazeView.New(self.MazeList, self)
		elseif type == Constant.LibraryStoryType.StoryCG then
			childView = LibraryDialogCGView.New(self.StoryCG, self)
		elseif type == Constant.LibraryStoryType.ActionStory then
			childView = libraryActionStoryView.New(self.ActionStory)
		end

		childView:Close()

		self.PanelViews[type] = childView
	end

	self.avProView = AVProView.New()
	self.avProView.playCurtainEnterLoop = self.delegateOnPlayMovieLoad
	self.avProView.playComplete = self.delegateOnPlayMovieComplete
	self.avProView.videoError = self.delegateOnPlayMovieError

	function self.avProView.playCurtainEndComplete()
		self:OnSpineCurtainEnd()
	end
end

function LibraryDialogListUI:GetPreloadAssetPaths()
	return nil
end

function LibraryDialogListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LibraryDialogListUI:IsManualShowOnOpen(userData)
	return false
end

function LibraryDialogListUI:GetBGM(userData)
	return nil
end

function LibraryDialogListUI:OnOpen(userData)
	self:UpdateView()
end

function LibraryDialogListUI:OnClose(userData)
	return
end

function LibraryDialogListUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnRewardBox:GetComponent("Button").onClick:AddListener(self.delegateBtnReward)
	self.BtnJump:GetComponent("Button").onClick:AddListener(self.delegateBtnJump)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.delegateTaskCommitResponse)
end

function LibraryDialogListUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnRewardBox:GetComponent("Button").onClick:RemoveListener(self.delegateBtnReward)
	self.BtnJump:GetComponent("Button").onClick:RemoveListener(self.delegateBtnJump)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.delegateTaskCommitResponse)
end

function LibraryDialogListUI:OnPause()
	return
end

function LibraryDialogListUI:OnResume()
	return
end

function LibraryDialogListUI:OnCover()
	return
end

function LibraryDialogListUI:OnReveal()
	return
end

function LibraryDialogListUI:OnRefocus(userData)
	return
end

function LibraryDialogListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LibraryDialogListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LibraryDialogListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LibraryDialogListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LibraryDialogListUI:OnDestroy()
	for type, panelView in pairs(self.PanelViews) do
		panelView:Dispose()
	end
end

function LibraryDialogListUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.LibraryDialogListUI)
end

function LibraryDialogListUI:UpdateView()
	self.scrollList:Refresh(#storyTypes)
	self:OpenChildPanel()
	self:UpdateReward()
end

function LibraryDialogListUI:SetToggleTypeSelect(togObj, isSelect)
	if togObj then
		togObj.transform:Find("goDown").gameObject:SetActive(not isSelect)
		togObj.transform:Find("goUp").gameObject:SetActive(isSelect)
	end
end

function LibraryDialogListUI:OnSelectedGridCell(cell)
	self.selectStoryType = storyTypes[cell.index + 1]

	if self.selectObj ~= nil then
		self:SetToggleTypeSelect(self.selectObj, false)
	end

	self.selectObj = cell.gameObject.gameObject

	self:SetToggleTypeSelect(self.selectObj, true)
	self:OpenChildPanel()
end

function LibraryDialogListUI:OnRenderGridCell(cell)
	local storyType = storyTypes[cell.index + 1]

	if storyType == nil then
		cell.gameObject:SetActive(false)

		return
	end

	if storyType[1] == Constant.LibraryStoryType.ActionStory then
		local storyDataTab = TownLibraryModule.GetStoryDataByType(storyType[1])

		if #storyDataTab == 0 then
			cell.gameObject:SetActive(false)

			return
		end
	end

	local item = cell.gameObject

	item:SetActive(true)

	item.transform:Find("goDown/Text").gameObject:GetComponent("Text").text = storyType[2]
	item.transform:Find("goUp/Text").gameObject:GetComponent("Text").text = storyType[2]

	if self.selectStoryType ~= nil then
		if self.selectStoryType[1] == storyType[1] then
			self.selectObj = item

			self:SetToggleTypeSelect(self.selectObj, true)
		else
			self:SetToggleTypeSelect(item, false)
		end
	else
		self.selectStoryType = storyType
		self.selectObj = item

		self:SetToggleTypeSelect(self.selectObj, true)
	end
end

function LibraryDialogListUI:OpenChildPanel()
	for i, v in pairs(self.PanelViews) do
		v:Close()
	end

	local type = self.selectStoryType[1]

	self.PanelViews[type]:Open(type)
end

function LibraryDialogListUI:OnTaskCommitResponse(cids, awards)
	self:UpdateReward()
end

function LibraryDialogListUI:UpdateReward()
	local red = TownLibraryModule.GetRedPoint(Constant.LibraryTaskType.TaskTypeStory)

	self.ImgRedPoint:SetActive(red)

	local num, totalNum = TownLibraryModule.GetUnLockStoryRes()

	UGUIUtil.SetText(self.TextReward, LibraryMazeUIApi:GetString("TextReward", num, totalNum))

	self.ImgReward:GetComponent("Image").fillAmount = num / totalNum
end

function LibraryDialogListUI:OnClickBtnReward()
	UIModule.Open(Constant.UIControllerName.LibraryRewardUI, Constant.UILayer.UI, Constant.LibraryTaskType.TaskTypeStory)
end

function LibraryDialogListUI:PlayMovie(cfgCGInfo)
	self.playCfgCG = cfgCGInfo

	self.Mask:SetActive(true)
	self.avProView:Show(self.UIController.gameObject, self.curtainNode, self.VideoNode, cfgCGInfo.PlayPrefab, cfgCGInfo.Movies)
end

function LibraryDialogListUI:OnPlayMovieLoad(gameObj, mediaPlayer)
	self.BtnJump:SetActive(true)
end

function LibraryDialogListUI:OnPlayMovieComplete()
	self.BtnJump:SetActive(false)
end

function LibraryDialogListUI:OnPlayMovieError()
	self.BtnJump:SetActive(false)
	self:OnSpineCurtainEnd()
end

function LibraryDialogListUI:OnSpineCurtainEnd()
	self.Mask:SetActive(false)
end

function LibraryDialogListUI:OnCloseMedia()
	self.avProView:CloseVideo()
	self.BtnJump:SetActive(false)
end

return LibraryDialogListUI
