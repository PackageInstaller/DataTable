-- chunkname: @IQIGame\\UI\\Puzzle\\PuzzleClueDetailPanel.lua

local PuzzleClueDetailPanel = {}
local clueImagePath = "mask/clueImg"
local imageAddPath = "imageAdd"

function PuzzleClueDetailPanel.New(go, mainView)
	local o = Clone(PuzzleClueDetailPanel)

	o:Initialize(go, mainView)

	return o
end

function PuzzleClueDetailPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.showArray = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function PuzzleClueDetailPanel:InitComponent()
	self.compoundItemArray = {}

	local tb1 = {}

	tb1.gameObject = self.compoundItem1
	tb1.image = self.compoundItem1.transform:Find(clueImagePath):GetComponent("Image")
	tb1.imageAdd = self.compoundItem1.transform:Find(imageAddPath).gameObject

	LuaUtility.SetGameObjectShow(self.compoundItem1, false)

	self.compoundItemArray[1] = tb1

	local tb2 = {}

	tb2.gameObject = self.compoundItem2
	tb2.image = self.compoundItem2.transform:Find(clueImagePath):GetComponent("Image")
	tb2.imageAdd = self.compoundItem2.transform:Find(imageAddPath).gameObject

	LuaUtility.SetGameObjectShow(self.compoundItem2, false)

	self.compoundItemArray[2] = tb2

	local tb3 = {}

	tb3.gameObject = self.compoundItem3
	tb3.image = self.compoundItem3.transform:Find(clueImagePath):GetComponent("Image")
	tb3.imageAdd = self.compoundItem3.transform:Find(imageAddPath).gameObject

	LuaUtility.SetGameObjectShow(self.compoundItem3, false)

	self.compoundItemArray[3] = tb3

	local tb4 = {}

	tb4.gameObject = self.compoundItem4
	tb4.image = self.compoundItem4.transform:Find(clueImagePath):GetComponent("Image")
	tb4.imageAdd = self.compoundItem4.transform:Find(imageAddPath).gameObject

	LuaUtility.SetGameObjectShow(self.compoundItem4, false)

	self.compoundItemArray[4] = tb4
end

function PuzzleClueDetailPanel:InitDelegate()
	function self.delegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end
end

function PuzzleClueDetailPanel:AddListener()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickCloseBtn)
end

function PuzzleClueDetailPanel:RemoveListener()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickCloseBtn)
end

function PuzzleClueDetailPanel:OnClickCloseBtn()
	if self.isExpand then
		self:Shrink()
		self.mainView:UnSelectedAll()
	else
		self:Expand()
		self:Refresh(self.cfgClueCraft)
	end
end

function PuzzleClueDetailPanel:OnDestroy()
	return
end

function PuzzleClueDetailPanel:Show()
	self.showArray = {}

	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function PuzzleClueDetailPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
	LuaUtility.SetGameObjectShow(self.FX_Story_Craft_Successful, false)
	LuaUtility.SetGameObjectShow(self.FX_Story_Craft_Lose, false)
end

function PuzzleClueDetailPanel:Expand()
	LuaUtility.ReversePlayAnimation(self.gameObject, "PuzzleUI_clueDetailPanel")

	self.showArray = {}
	self.isExpand = true
end

function PuzzleClueDetailPanel:Shrink()
	LuaUtility.PlayAnimation(self.gameObject, "PuzzleUI_clueDetailPanel")

	self.showArray = {}
	self.isExpand = false

	LuaUtility.SetGameObjectShow(self.FX_Story_Craft_Successful, false)
	LuaUtility.SetGameObjectShow(self.FX_Story_Craft_Lose, false)
end

function PuzzleClueDetailPanel:GetIsShow()
	if not self.gameObject.activeSelf then
		return false
	else
		return self.isExpand
	end
end

function PuzzleClueDetailPanel:AddClue(clueID)
	if #self.showArray >= 4 then
		return
	end

	table.insert(self.showArray, clueID)
	self:Refresh(self.cfgClueCraft)

	if #self.showArray == #self.cfgClueCraft.CluesID then
		self:CheckCompose()
	end
end

function PuzzleClueDetailPanel:ReduceClue(clueID)
	if #self.showArray <= 0 then
		return
	end

	local len = #self.showArray

	for i = 1, len do
		if self.showArray[i] == clueID then
			table.remove(self.showArray, i)

			break
		end
	end

	self:Refresh(self.cfgClueCraft)
end

function PuzzleClueDetailPanel:CheckCompose()
	local set = {}
	local len = #self.showArray

	for i = 1, len do
		set[self.showArray[i]] = 1
	end

	len = #self.cfgClueCraft.CluesID

	for i = 1, len do
		if not set[self.cfgClueCraft.CluesID[i]] then
			self:_Failed()

			return
		end
	end

	self:_Success()
end

function PuzzleClueDetailPanel:_Success()
	coroutine.start(function()
		LuaUtility.SetGameObjectShow(self.FX_Story_Craft_Successful, false)
		LuaUtility.SetGameObjectShow(self.FX_Story_Craft_Successful, true)
		StoryUIApi:PlayPuzzleSuccessSound()
		GameEntry.UI:DisableAllLoadedUIFormsRaycast()
		coroutine.wait(LuaUtility.GetParticleSystemLength(self.FX_Story_Craft_Successful))
		GameEntry.UI:EnableAllLoadedUIFormsRaycast()
		PuzzleModule.CluesComposing(self.cfgClueCraft.Id)

		self.showArray = {}

		self.mainView:Refresh()
		self.mainView:ShowClueComposeTips(self.cfgClueCraft.ComposeID, function()
			if not LuaUtility.StrIsNullOrEmpty(self.cfgClueCraft.CreateParam) then
				EventDispatcher.Dispatch(EventID.BehaviourTreeNPCClueTriggerEvent, self.cfgClueCraft.CreateParam)
			end

			UIModule.Close(Constant.UIControllerName.PuzzleUI)
		end)
		StoryUIApi:PlayPuzzleUIConnectSuccessSound()
	end)
end

function PuzzleClueDetailPanel:_Failed()
	coroutine.start(function()
		LuaUtility.SetGameObjectShow(self.FX_Story_Craft_Lose, false)
		LuaUtility.SetGameObjectShow(self.FX_Story_Craft_Lose, true)
		StoryUIApi:PlayPuzzleFailedSound()
		GameEntry.UI:DisableAllLoadedUIFormsRaycast()
		coroutine.wait(LuaUtility.GetParticleSystemLength(self.FX_Story_Craft_Lose))
		GameEntry.UI:EnableAllLoadedUIFormsRaycast()

		self.showArray = {}

		self:Refresh(self.cfgClueCraft)
		self.mainView:UnSelectedAll()
	end)
end

function PuzzleClueDetailPanel:GetComposeIsEmpty()
	return #self.showArray == 0
end

function PuzzleClueDetailPanel:GetIsSelected(id)
	if not self.showArray then
		return
	end

	local len = #self.showArray

	if len == 0 then
		return
	end

	for i = 1, len do
		if self.showArray[i] == id then
			return true
		end
	end

	return false
end

function PuzzleClueDetailPanel:Refresh(cfgClueCraft)
	if not cfgClueCraft then
		return
	end

	self.cfgClueCraft = cfgClueCraft

	local column = #self.cfgClueCraft.CluesID

	LuaUtility.SetGameObjectShow(self.compoundItem2, column > 2)

	local len = #self.compoundItemArray

	for i = 1, len do
		if i <= column then
			LuaUtility.SetGameObjectShow(self.compoundItemArray[i].gameObject, true)
			LuaUtility.SetGameObjectShow(self.compoundItemArray[i].imageAdd, true)
		else
			LuaUtility.SetGameObjectShow(self.compoundItemArray[i].gameObject, false)
		end
	end

	local index = 0

	len = #self.showArray

	for i = 1, len do
		local cfg = CfgUtil.GetCfgCluesDataWithID(self.showArray[i])

		LuaUtility.LoadImage(self, cfg.Icon, self.compoundItemArray[i].image)
		LuaUtility.SetGameObjectShow(self.compoundItemArray[i].imageAdd, false)
		LuaUtility.SetGameObjectShow(self.compoundItemArray[i].image.gameObject, true)

		index = i
	end

	for i = index + 1, column do
		LuaUtility.SetGameObjectShow(self.compoundItemArray[i].image.gameObject, false)
	end

	LuaUtility.SetText(self.detailText, self.cfgClueCraft.CarftDes)
end

return PuzzleClueDetailPanel
