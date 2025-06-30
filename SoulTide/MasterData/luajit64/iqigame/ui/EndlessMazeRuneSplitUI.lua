-- chunkname: @IQIGame\\UI\\EndlessMazeRuneSplitUI.lua

local EndlessMazeRuneSplitUI = Base:Extend("EndlessMazeRuneSplitUI", "IQIGame.Onigao.UI.EndlessMazeRuneSplitUI", {})
local EndlessMazeNamedRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeNamedRuneCell")

function EndlessMazeRuneSplitUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.OriginalRuneCell = EndlessMazeNamedRuneCell.New(UnityEngine.Object.Instantiate(self.RuneCellPrefab))

	self.OriginalRuneCell.View.transform:SetParent(self.OriginalRuneNode.transform, false)

	self.RuneCells = {}

	for i = 1, 5 do
		local cell = EndlessMazeNamedRuneCell.New(UnityEngine.Object.Instantiate(self.RuneCellPrefab))

		cell.View.transform:SetParent(self.GetRuneGrid.transform, false)

		self.RuneCells[i] = cell
	end

	self.Tweeners = {}

	local tweeners = self.OriginalRuneNode:GetComponentsInChildren(typeof(UITweener))

	for i = 0, tweeners.Length - 1 do
		table.insert(self.Tweeners, tweeners[i])
	end

	tweeners = self.GetRuneGrid:GetComponentsInChildren(typeof(UITweener))

	for i = 0, tweeners.Length - 1 do
		table.insert(self.Tweeners, tweeners[i])
	end

	local titleText1, titleText2 = EndlessMazeRuneNoticeApi:GetString("SplitTitleText")

	UGUIUtil.SetText(self.TitleText1, titleText1)
	UGUIUtil.SetText(self.TitleText2, titleText2)
end

function EndlessMazeRuneSplitUI:GetPreloadAssetPaths()
	return nil
end

function EndlessMazeRuneSplitUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeRuneSplitUI:OnOpen(userData)
	self:UpdateView(userData.cid, userData.splitRunes)
end

function EndlessMazeRuneSplitUI:OnClose(userData)
	self.OriginalRuneNode:SetActive(false)
	self.GetRuneGrid:SetActive(false)

	for i = 1, #self.Tweeners do
		local tweener = self.Tweeners[i]

		tweener:ResetToBeginning()

		tweener.enabled = true
	end
end

function EndlessMazeRuneSplitUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function EndlessMazeRuneSplitUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function EndlessMazeRuneSplitUI:OnPause()
	return
end

function EndlessMazeRuneSplitUI:OnResume()
	return
end

function EndlessMazeRuneSplitUI:OnCover()
	return
end

function EndlessMazeRuneSplitUI:OnReveal()
	return
end

function EndlessMazeRuneSplitUI:OnRefocus(userData)
	return
end

function EndlessMazeRuneSplitUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeRuneSplitUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeRuneSplitUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeRuneSplitUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeRuneSplitUI:OnDestroy()
	self.OriginalRuneCell:Dispose()

	for i = 1, #self.RuneCells do
		local cell = self.RuneCells[i]

		cell:Dispose()
	end
end

function EndlessMazeRuneSplitUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.EndlessMazeRuneSplitUI)
end

function EndlessMazeRuneSplitUI:UpdateView(cid, splitRunes)
	self.CloseBtn:SetActive(false)

	local timer = Timer.New(function()
		self.CloseBtn:SetActive(true)
	end, 1)

	timer:Start()
	self.OriginalRuneNode:SetActive(true)
	self.GetRuneGrid:SetActive(true)
	self.OriginalRuneCell:SetDataByCID(cid)

	for i = 1, #self.RuneCells do
		local cell = self.RuneCells[i]
		local runeCid = splitRunes[i]

		cell:SetDataByCID(runeCid)
	end
end

return EndlessMazeRuneSplitUI
