-- chunkname: @IQIGame\\UI\\EndlessMazeRuneNoticeUnsealUI.lua

local EndlessMazeRuneNoticeUnsealUI = Base:Extend("EndlessMazeRuneNoticeUnsealUI", "IQIGame.Onigao.UI.EndlessMazeRuneNoticeUnsealUI", {})
local EndlessMazeRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneCell")

function EndlessMazeRuneNoticeUnsealUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.RuneCell = EndlessMazeRuneCell.New(self.RuneSlotUI)

	local titleText1, titleText2 = EndlessMazeRuneNoticeApi:GetString("UnsealTitleText")

	UGUIUtil.SetText(self.TitleText1, titleText1)
	UGUIUtil.SetText(self.TitleText2, titleText2)
end

function EndlessMazeRuneNoticeUnsealUI:GetPreloadAssetPaths()
	return nil
end

function EndlessMazeRuneNoticeUnsealUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeRuneNoticeUnsealUI:OnOpen(userData)
	self:UpdateView(userData.cid)
end

function EndlessMazeRuneNoticeUnsealUI:OnClose(userData)
	return
end

function EndlessMazeRuneNoticeUnsealUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function EndlessMazeRuneNoticeUnsealUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function EndlessMazeRuneNoticeUnsealUI:OnPause()
	return
end

function EndlessMazeRuneNoticeUnsealUI:OnResume()
	return
end

function EndlessMazeRuneNoticeUnsealUI:OnCover()
	return
end

function EndlessMazeRuneNoticeUnsealUI:OnReveal()
	return
end

function EndlessMazeRuneNoticeUnsealUI:OnRefocus(userData)
	return
end

function EndlessMazeRuneNoticeUnsealUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeRuneNoticeUnsealUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeRuneNoticeUnsealUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeRuneNoticeUnsealUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeRuneNoticeUnsealUI:OnDestroy()
	self.RuneCell:Dispose()
end

function EndlessMazeRuneNoticeUnsealUI:UpdateView(runeCid)
	local cfgRuneData = CfgRuneTable[runeCid]

	self.RuneCell:SetDataByCfgData(cfgRuneData)
	UGUIUtil.SetText(self.NameText, cfgRuneData.Name)
	UGUIUtil.SetText(self.DescText, cfgRuneData.Describe)
end

function EndlessMazeRuneNoticeUnsealUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.EndlessMazeRuneNoticeUnsealUI)
end

return EndlessMazeRuneNoticeUnsealUI
