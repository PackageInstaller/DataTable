-- chunkname: @IQIGame\\UI\\PuzzleSelectDetailUI.lua

local PuzzleSelectDetailUI = {}

PuzzleSelectDetailUI = Base:Extend("PuzzleSelectDetailUI", "IQIGame.Onigao.UI.PuzzleSelectDetailUI", PuzzleSelectDetailUI)

local AnimationShowName = "PuzzleSelectDetailUI"

function PuzzleSelectDetailUI:OnInit()
	self:InitDelegate()
end

function PuzzleSelectDetailUI:InitDelegate()
	function self.delegateOnClickButtonMask()
		self:OnClickButtonMask()
	end

	function self.delegateOnClickButtonSurvey()
		self:OnClickButtonSurvey()
	end

	function self.delegateOnClickButtonPresent()
		self:OnClickButtonPresent()
	end
end

function PuzzleSelectDetailUI:GetPreloadAssetPaths()
	return nil
end

function PuzzleSelectDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PuzzleSelectDetailUI:IsManualShowOnOpen(userData)
	return false
end

function PuzzleSelectDetailUI:GetBGM(userData)
	return nil
end

function PuzzleSelectDetailUI:OnOpen(userData)
	LuaUtility.PlayAnimation(self.gameObject, AnimationShowName, nil, function()
		self.IsAnimation = false
	end)

	self.IsAnimation = true

	self:Refresh(userData.ClueID)
end

function PuzzleSelectDetailUI:OnClose(userData)
	return
end

function PuzzleSelectDetailUI:OnAddListeners()
	self.ButtonMask:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonMask)
	self.ButtonSurvey:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonSurvey)
	self.ButtonPresent:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonPresent)
end

function PuzzleSelectDetailUI:OnRemoveListeners()
	self.ButtonMask:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonMask)
	self.ButtonSurvey:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonSurvey)
	self.ButtonPresent:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonPresent)
end

function PuzzleSelectDetailUI:OnPause()
	return
end

function PuzzleSelectDetailUI:OnResume()
	return
end

function PuzzleSelectDetailUI:OnCover()
	return
end

function PuzzleSelectDetailUI:OnReveal()
	return
end

function PuzzleSelectDetailUI:OnRefocus(userData)
	return
end

function PuzzleSelectDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PuzzleSelectDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PuzzleSelectDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PuzzleSelectDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PuzzleSelectDetailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function PuzzleSelectDetailUI:Refresh(ClueID)
	self.ClueID = ClueID

	local cfg = CfgUtil.GetCfgCluesDataWithID(self.ClueID)

	LuaUtility.LoadImage(self, cfg.Icon, self.imageCommonItem:GetComponent("Image"), function()
		LuaUtility.SetImageNativeSizeWithGameObject(self.imageCommonItem)
	end)
	LuaUtility.SetText(self.textCommonName, cfg.CluesName)
	LuaUtility.SetText(self.TextDescription, cfg.Des)
	LuaUtility.SetGameObjectShow(self.ButtonSurvey, not LuaUtility.StrIsNullOrEmpty(cfg.ActionParam))
end

function PuzzleSelectDetailUI:OnClickButtonPresent()
	if self.IsAnimation then
		return
	end

	EventDispatcher.Dispatch(EventID.StoryPuzzleSelectClickEvent, self.ClueID)
	self:Hide()
	StoryUIApi:PlayDisplaySound()
end

function PuzzleSelectDetailUI:OnClickButtonSurvey()
	if self.IsAnimation then
		return
	end

	local cfg = CfgUtil.GetCfgCluesDataWithID(self.ClueID)

	EventDispatcher.Dispatch(EventID.BehaviourTreeNPCClueTriggerEvent, cfg.ActionParam)
	EventDispatcher.Dispatch(EventID.StoryPuzzleSelectClickEvent, -1)
	self:Hide()
	StoryUIApi:PlaySurveySound()
end

function PuzzleSelectDetailUI:OnClickButtonMask()
	self:Hide()
end

function PuzzleSelectDetailUI:Hide()
	if self.IsAnimation then
		return
	end

	UIModule.CloseSelf(self)
end

return PuzzleSelectDetailUI
