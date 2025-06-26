-- chunkname: @IQIGame\\UI\\MazeChapterTipUI.lua

local MazeChapterTipUI = Base:Extend("MazeChapterTipUI", "IQIGame.Onigao.UI.MazeChapterTipUI", {})

function MazeChapterTipUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end
end

function MazeChapterTipUI:GetPreloadAssetPaths()
	return nil
end

function MazeChapterTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeChapterTipUI:OnOpen(userData)
	self:UpdateView(userData.chapterCid)
end

function MazeChapterTipUI:OnClose(userData)
	return
end

function MazeChapterTipUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function MazeChapterTipUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function MazeChapterTipUI:OnPause()
	return
end

function MazeChapterTipUI:OnResume()
	return
end

function MazeChapterTipUI:OnCover()
	return
end

function MazeChapterTipUI:OnReveal()
	return
end

function MazeChapterTipUI:OnRefocus(userData)
	return
end

function MazeChapterTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeChapterTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeChapterTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeChapterTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeChapterTipUI:OnDestroy()
	return
end

function MazeChapterTipUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.MazeChapterTipUI)
end

function MazeChapterTipUI:UpdateView(chapterCid)
	local cfgChapterData = CfgChapterTable[chapterCid]

	UGUIUtil.SetText(self.TitleText, MazeChapterTipUIApi:GetString("TitleText", cfgChapterData.Alias, cfgChapterData.Name))
	UGUIUtil.SetText(self.DescText, cfgChapterData.ChapterDesc)
end

return MazeChapterTipUI
