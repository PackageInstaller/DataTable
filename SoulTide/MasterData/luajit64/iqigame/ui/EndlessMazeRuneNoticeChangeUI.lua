-- chunkname: @IQIGame\\UI\\EndlessMazeRuneNoticeChangeUI.lua

local EndlessMazeRuneNoticeChangeUI = Base:Extend("EndlessMazeRuneNoticeChangeUI", "IQIGame.Onigao.UI.EndlessMazeRuneNoticeChangeUI", {})
local EndlessMazeRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneCell")

function EndlessMazeRuneNoticeChangeUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.RuneCell = EndlessMazeRuneCell.New(self.RuneSlotUI)

	local titleText1, titleText2 = EndlessMazeRuneNoticeApi:GetString("GrowUpTitleText")

	UGUIUtil.SetText(self.TitleText1, titleText1)
	UGUIUtil.SetText(self.TitleText2, titleText2)
	UGUIUtil.SetText(self.FinishTargetLabelText, EndlessMazeRuneNoticeApi:GetString("FinishTargetLabelText"))
end

function EndlessMazeRuneNoticeChangeUI:GetPreloadAssetPaths()
	return nil
end

function EndlessMazeRuneNoticeChangeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeRuneNoticeChangeUI:OnOpen(userData)
	self:UpdateView(userData.oldRuneCid, userData.newRuneCid)
end

function EndlessMazeRuneNoticeChangeUI:OnClose(userData)
	return
end

function EndlessMazeRuneNoticeChangeUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function EndlessMazeRuneNoticeChangeUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function EndlessMazeRuneNoticeChangeUI:OnPause()
	return
end

function EndlessMazeRuneNoticeChangeUI:OnResume()
	return
end

function EndlessMazeRuneNoticeChangeUI:OnCover()
	return
end

function EndlessMazeRuneNoticeChangeUI:OnReveal()
	return
end

function EndlessMazeRuneNoticeChangeUI:OnRefocus(userData)
	return
end

function EndlessMazeRuneNoticeChangeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeRuneNoticeChangeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeRuneNoticeChangeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeRuneNoticeChangeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeRuneNoticeChangeUI:OnDestroy()
	self.RuneCell:Dispose()
end

function EndlessMazeRuneNoticeChangeUI:UpdateView(oldRuneCid, newRuneCid)
	local oldRuneCfgData = CfgRuneTable[oldRuneCid]
	local newRuneCfgData = CfgRuneTable[newRuneCid]

	self.RuneCell:SetDataByCfgData(newRuneCfgData)
	UGUIUtil.SetText(self.NameText, newRuneCfgData.Name)

	local cfgTargetData = CfgTargetTable[oldRuneCfgData.Target]

	UGUIUtil.SetText(self.TargetText, EndlessMazeRuneNoticeApi:GetString("TargetText", cfgTargetData.TargetDes, cfgTargetData.TargetNum, cfgTargetData.TargetNum))
	UGUIUtil.SetText(self.PrevDescText, oldRuneCfgData.Describe)
	UGUIUtil.SetText(self.CurrentDescText, newRuneCfgData.Describe)
end

function EndlessMazeRuneNoticeChangeUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.EndlessMazeRuneNoticeChangeUI)
end

return EndlessMazeRuneNoticeChangeUI
