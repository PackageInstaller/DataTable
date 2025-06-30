-- chunkname: @IQIGame\\UI\\ChapterMapUI.lua

local ChapterMapUI = {
	mapBlocks = {}
}

ChapterMapUI = Base:Extend("ChapterMapUI", "IQIGame.Onigao.UI.ChapterMapUI", ChapterMapUI)

local mainMapBlock = require("IQIGame.UI.Map.MainMap.MainMapBlock")
local classifitaionPanel = require("IQIGame.UI.Map.MapChapterDetails.ClassifitaionPanel")

function ChapterMapUI:OnInit()
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	function self.DelegateNotifyUpdateStage()
		self:NotifyUpdateStage()
	end

	function self.DelegateOnClickStageItemCellEvent()
		UIModule.CloseSelf(self)
	end

	self.ClassifitaionView = classifitaionPanel.New(self.ClassifitaionPanel, self)
	self.UIMapImgCom = self.PreviewMapFog:GetComponent("Image")

	self:InitBlocks()
end

function ChapterMapUI:GetPreloadAssetPaths()
	return nil
end

function ChapterMapUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChapterMapUI:IsManualShowOnOpen(userData)
	return false
end

function ChapterMapUI:GetBGM(userData)
	return nil
end

function ChapterMapUI:OnOpen(userData)
	self:OnOpenAddListeners()
	self.ClassifitaionView:Show()
	self.ClassifitaionView:SetData()
	self:UpdateBlcoksState()
	self:PlayMapCloundMask()
	self:RefreshMainline()
end

function ChapterMapUI:OnClose(userData)
	self:OnCloseRemoveListeners()
	self.ClassifitaionView:ResetLastIndex()
end

function ChapterMapUI:OnOpenAddListeners()
	EventDispatcher.AddEventListener(EventID.ClickStageItemCellEvent, self.DelegateOnClickStageItemCellEvent)
end

function ChapterMapUI:OnCloseRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.ClickStageItemCellEvent, self.DelegateOnClickStageItemCellEvent)
end

function ChapterMapUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.OnNotifyStage, self.DelegateNotifyUpdateStage)
end

function ChapterMapUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.OnNotifyStage, self.DelegateNotifyUpdateStage)
end

function ChapterMapUI:OnPause()
	return
end

function ChapterMapUI:OnResume()
	return
end

function ChapterMapUI:OnCover()
	return
end

function ChapterMapUI:OnReveal()
	return
end

function ChapterMapUI:OnRefocus(userData)
	return
end

function ChapterMapUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ChapterMapUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChapterMapUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChapterMapUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChapterMapUI:OnDestroy()
	self.commonReturnBtn:Dispose()

	for k, v in pairs(self.mapBlocks) do
		v:Dispose()
	end
end

function ChapterMapUI:InitBlocks()
	for _, v in pairsCfg(CfgWorldMapTable) do
		local obj = self.MapBG.transform:Find(tostring(v.Id))

		if obj ~= nil then
			table.insert(self.mapBlocks, mainMapBlock.New(obj.gameObject, v.Id))
		end
	end
end

function ChapterMapUI:UpdateBlcoksState()
	for k, v in pairs(self.mapBlocks) do
		v:SetData()
	end
end

function ChapterMapUI:NotifyUpdateStage()
	self:UpdateBlcoksState()
	self:RefreshMainline()
end

function ChapterMapUI:PlayMapCloundMask()
	local newUnlockCfg = MapModule.GetNewUnlockMap()

	AssetUtil.LoadAsset(self, newUnlockCfg.CloudMask, self.LoadMapCloudMaskSuccess, nil, newUnlockCfg)
end

function ChapterMapUI:LoadMapCloudMaskSuccess(assetName, asset, duration, userData)
	self.UIMapImgCom.material:SetTexture("_MainMask", asset)
	self.UIMapImgCom.material:SetFloat("_CloudMaskLerp", 1)
end

function ChapterMapUI:RefreshMainline()
	local mapBlock

	for k, v in pairs(self.mapBlocks) do
		if v:GetIsHasMainline() then
			mapBlock = v
		end
	end

	self:UpdatePlayerHeadLocation(mapBlock)
end

function ChapterMapUI:UpdatePlayerHeadLocation(target)
	if target == nil then
		LuaUtility.SetGameObjectShow(self.PlayerHead, false)

		return
	end

	LuaUtility.SetGameObjectShow(self.PlayerHead, true)

	local pos = target.View.transform.localPosition

	LuaUtility.SetLocalPositionWithGameObject(self.PlayerHead, pos.x, pos.y + 60, 0)
end

function ChapterMapUI:LoadPlayerHeadImg()
	AssetUtil.LoadImage(self, "", self.PlayerHead:GetComponent("Image"))
end

return ChapterMapUI
