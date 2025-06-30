-- chunkname: @IQIGame\\UI\\MazeSoulReviveUI.lua

local MazeSoulReviveUI = Base:Extend("MazeSoulReviveUI", "IQIGame.Onigao.UI.MazeSoulReviveUI", {
	MaxNum = 0
})
local MazeSoulRevivePortraitUI = require("IQIGame.UI.MazeSoulRevive.MazeSoulRevivePortraitUI")

function MazeSoulReviveUI:OnInit()
	function self.DelegateGetPreloadedAsset(path)
		return self.UIController.GetPreloadedAsset(path)
	end

	function self.DelegateOnClickReviveBtn()
		self:OnClickReviveBtn()
	end

	function self.DelegateOnSoulRevive(dollData)
		self:OnSoulRevive(dollData)
	end

	self.Portraits = {}

	for i = 1, 5 do
		local portrait = MazeSoulRevivePortraitUI.New(UnityEngine.Object.Instantiate(self.PortraitPrefab), self)

		portrait.View.transform:SetParent(self.SoulGrid.transform, false)

		self.Portraits[i] = portrait
	end

	self.NoticeTweens = self.NoticeText:GetComponentsInChildren(typeof(UITweener))
	self.ReviveBtn:GetComponentInChildren(typeof(UnityEngine.UI.Text)).text = MazeSoulReviveUIApi:GetString("ReviveBtnText")
end

function MazeSoulReviveUI:GetPreloadAssetPaths()
	return {
		UIGlobalApi.GetUIPrefab("/_SoulListUI/Card_Mould")
	}
end

function MazeSoulReviveUI:GetOpenPreloadAssetPaths(userData)
	local ret = {}
	local deadSoulDataList = {}
	local dollDataList = MazeDataModule.GetActiveDollDataList()

	for i = 1, #dollDataList do
		local dollPOD = dollDataList[i]

		if dollPOD.finalAttributes[Constant.Attribute.TYPE_HP] == 0 then
			local soulData = MazeDataModule.GetSoulData(dollPOD.soulCid)

			table.insert(deadSoulDataList, soulData)
		end
	end

	for i, v in pairs(deadSoulDataList) do
		if v.isUnlock == false then
			ret[#ret + 1] = UIGlobalApi.GetHarmoniousImagePath(v:GetCfgSoul().FragmentIcon)
		end

		ret[#ret + 1] = UIGlobalApi.GetHarmoniousImagePath(v:GetCfgSoulRes2D().SoulSoulCard)
		ret[#ret + 1] = UIGlobalApi.ImagePath .. "/" .. v:GetCfgSoulQuality().QualityColour
		ret[#ret + 1] = UIGlobalApi.ImagePath .. "/" .. v:GetCfgSoulQuality().QualityCardFrame
		ret[#ret + 1] = UIGlobalApi.ImagePath .. "/" .. v:GetCfgSoulQuality().LevelBG
	end

	return ret
end

function MazeSoulReviveUI:OnOpen(userData)
	self:UpdateView(userData.maxNum)
end

function MazeSoulReviveUI:OnClose(userData)
	ModuleTimerUtil.Stop(Constant.UIControllerName.MazeSoulReviveUI)
end

function MazeSoulReviveUI:OnAddListeners()
	for i = 1, #self.Portraits do
		local portrait = self.Portraits[i]

		portrait:AddListeners()
	end

	self.ReviveBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickReviveBtn)
	EventDispatcher.AddEventListener(EventID.MazeSoulRevive, self.DelegateOnSoulRevive)
end

function MazeSoulReviveUI:OnRemoveListeners()
	for i = 1, #self.Portraits do
		local portrait = self.Portraits[i]

		portrait:RemoveListeners()
	end

	self.ReviveBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickReviveBtn)
	EventDispatcher.RemoveEventListener(EventID.MazeSoulRevive, self.DelegateOnSoulRevive)
end

function MazeSoulReviveUI:OnPause()
	return
end

function MazeSoulReviveUI:OnResume()
	return
end

function MazeSoulReviveUI:OnCover()
	return
end

function MazeSoulReviveUI:OnReveal()
	return
end

function MazeSoulReviveUI:OnRefocus(userData)
	return
end

function MazeSoulReviveUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeSoulReviveUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeSoulReviveUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeSoulReviveUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeSoulReviveUI:OnDestroy()
	for i = 1, #self.Portraits do
		local portrait = self.Portraits[i]

		portrait:Dispose()
	end
end

function MazeSoulReviveUI:UpdateView(maxNum)
	self.MaxNum = maxNum

	for i = 1, #self.Portraits do
		local portrait = self.Portraits[i]

		portrait:SetSelect(false)
	end

	self.ReviveBtn:GetComponent("Button").interactable = false
	self.NoticeText:GetComponent("Text").text = MazeSoulReviveUIApi:GetString("NoticeText", maxNum)

	local deadSoulPODList = {}
	local dollDataList = MazeDataModule.GetActiveDollDataList()

	for i = 1, #dollDataList do
		local dollPOD = dollDataList[i]

		if dollPOD.finalAttributes[Constant.Attribute.TYPE_HP] == 0 then
			table.insert(deadSoulPODList, dollPOD)
		end
	end

	for i = 1, #self.Portraits do
		local portrait = self.Portraits[i]
		local dollPOD = deadSoulPODList[i]

		portrait:SetData(dollPOD)
	end

	self.ReviveBtn:SetActive(true)
end

function MazeSoulReviveUI:SelectPortrait(portrait)
	if not portrait.Selected and self:GetSelectedSoulNumber() == self.MaxNum then
		for i = 0, self.NoticeTweens.Length - 1 do
			local tween = self.NoticeTweens[i]

			tween:ResetToBeginning()

			tween.enabled = true

			tween:PlayForward()
		end

		return
	end

	portrait:SetSelect(not portrait.Selected)

	self.ReviveBtn:GetComponent("Button").interactable = self:GetSelectedSoulNumber() > 0
end

function MazeSoulReviveUI:GetSelectedSoulNumber()
	local selectedNum = 0

	for i = 1, #self.Portraits do
		local lportrait = self.Portraits[i]

		if lportrait.Selected then
			selectedNum = selectedNum + 1
		end
	end

	return selectedNum
end

function MazeSoulReviveUI:OnClickReviveBtn()
	local dollIds = {}

	for i = 1, #self.Portraits do
		local portrait = self.Portraits[i]

		if portrait.Selected then
			table.insert(dollIds, portrait.DollPOD.id)
		end
	end

	self.ReviveBtn:SetActive(false)
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_DOLL_REVIVE, {
		DollIDs = dollIds
	})
end

function MazeSoulReviveUI:OnSoulRevive(dollPOD)
	for i = 1, #self.Portraits do
		local portrait = self.Portraits[i]

		if portrait.DollPOD ~= nil and portrait.DollPOD.id == dollPOD.id then
			portrait:OnSoulRevive()
		end
	end

	local timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.MazeSoulReviveUI, function()
		UIModule.Close(Constant.UIControllerName.MazeSoulReviveUI)
	end, 1.5)

	timer:Start()
end

return MazeSoulReviveUI
