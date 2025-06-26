-- chunkname: @IQIGame\\UI\\MazeScoreLevelUpUI.lua

local MazeScoreLevelUpUI = Base:Extend("MazeScoreLevelUpUI", "IQIGame.Onigao.UI.MazeScoreLevelUpUI", {})

function MazeScoreLevelUpUI:OnInit()
	UGUIUtil.SetText(self.ScoreLevelLabel, MazeScoreLevelUpUIApi:GetString("ScoreLevelLabel"))
end

function MazeScoreLevelUpUI:GetPreloadAssetPaths()
	local paths = {}
	local scoreLevelImages = MazeScoreLevelUpUIApi:GetString("ScoreLevelImages")

	for i = 1, #scoreLevelImages do
		table.insert(paths, scoreLevelImages[i])
	end

	return paths
end

function MazeScoreLevelUpUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeScoreLevelUpUI:OnOpen(userData)
	self.Content:SetActive(true)
	self:UpdateView(userData.beforeLevel, userData.afterLevel)

	local timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.MazeScoreLevelUpUI, function()
		self.Content:SetActive(false)
		UIModule.Close(Constant.UIControllerName.MazeScoreLevelUpUI)
	end, 2)

	timer:Start()
end

function MazeScoreLevelUpUI:OnClose(userData)
	ModuleTimerUtil.Stop(Constant.UIControllerName.MazeScoreLevelUpUI)
end

function MazeScoreLevelUpUI:OnAddListeners()
	return
end

function MazeScoreLevelUpUI:OnRemoveListeners()
	return
end

function MazeScoreLevelUpUI:OnPause()
	return
end

function MazeScoreLevelUpUI:OnResume()
	return
end

function MazeScoreLevelUpUI:OnCover()
	return
end

function MazeScoreLevelUpUI:OnReveal()
	return
end

function MazeScoreLevelUpUI:OnRefocus(userData)
	return
end

function MazeScoreLevelUpUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeScoreLevelUpUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeScoreLevelUpUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeScoreLevelUpUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeScoreLevelUpUI:OnDestroy()
	return
end

function MazeScoreLevelUpUI:UpdateView(beforeLevel, afterLevel)
	local scoreLevelImages = MazeScoreLevelUpUIApi:GetString("ScoreLevelImages")

	self.BeforeImage:GetComponent("Image").sprite = LuaCodeInterface.ToSprite(self.UIController:GetPreloadedAsset(scoreLevelImages[beforeLevel]))
	self.AfterImage:GetComponent("Image").sprite = LuaCodeInterface.ToSprite(self.UIController:GetPreloadedAsset(scoreLevelImages[afterLevel]))
end

return MazeScoreLevelUpUI
