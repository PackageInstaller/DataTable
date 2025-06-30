-- chunkname: @IQIGame\\UI\\EndlessMazeRuneNoticeGetUI.lua

local EndlessMazeRuneNoticeGetUI = Base:Extend("EndlessMazeRuneNoticeGetUI", "IQIGame.Onigao.UI.EndlessMazeRuneNoticeGetUI", {
	RuneCells = {}
})
local EndlessMazeNamedRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeNamedRuneCell")

function EndlessMazeRuneNoticeGetUI:OnInit()
	self.ScrollAreaList = self.RuneGrid:GetComponent("ScrollAreaList")

	function self.ScrollAreaList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	local titleText1, titleText2 = EndlessMazeRuneNoticeApi:GetString("GetTitleText")

	UGUIUtil.SetText(self.TitleText1, titleText1)
	UGUIUtil.SetText(self.TitleText2, titleText2)
end

function EndlessMazeRuneNoticeGetUI:GetPreloadAssetPaths()
	return nil
end

function EndlessMazeRuneNoticeGetUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeRuneNoticeGetUI:OnOpen(userData)
	self:UpdateView(userData)
end

function EndlessMazeRuneNoticeGetUI:OnClose(userData)
	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "CloseEndlessMazeRuneNoticeGetUI")
end

function EndlessMazeRuneNoticeGetUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function EndlessMazeRuneNoticeGetUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function EndlessMazeRuneNoticeGetUI:OnPause()
	return
end

function EndlessMazeRuneNoticeGetUI:OnResume()
	return
end

function EndlessMazeRuneNoticeGetUI:OnCover()
	return
end

function EndlessMazeRuneNoticeGetUI:OnReveal()
	return
end

function EndlessMazeRuneNoticeGetUI:OnRefocus(userData)
	return
end

function EndlessMazeRuneNoticeGetUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeRuneNoticeGetUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeRuneNoticeGetUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeRuneNoticeGetUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeRuneNoticeGetUI:OnDestroy()
	for instanceID, runeCell in pairs(self.RuneCells) do
		runeCell:Dispose()
	end
end

function EndlessMazeRuneNoticeGetUI:UpdateView(mazeRuneCidList)
	self.MazeRuneCidList = mazeRuneCidList

	self.ScrollAreaList:Refresh(#self.MazeRuneCidList)
end

function EndlessMazeRuneNoticeGetUI:OnRenderCell(cell)
	local mazeRuneCid = self.MazeRuneCidList[cell.index + 1]
	local runeCell = self.RuneCells[cell.gameObject:GetInstanceID()]

	if runeCell == nil then
		runeCell = EndlessMazeNamedRuneCell.New(cell.gameObject)
		self.RuneCells[cell.gameObject:GetInstanceID()] = runeCell
	end

	runeCell:SetDataByCID(mazeRuneCid)
end

function EndlessMazeRuneNoticeGetUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)

	local dataList = {}

	for instanceId, runeCell in pairs(self.RuneCells) do
		if runeCell.View.activeSelf then
			table.insert(dataList, {
				runeCid = runeCell.RuneCell.CfgRuneData.Id,
				startPos = runeCell.RuneCell.View.transform.position
			})
		end
	end

	EventDispatcher.Dispatch(EventID.MazeFlyRuneOrItem, dataList)
end

return EndlessMazeRuneNoticeGetUI
