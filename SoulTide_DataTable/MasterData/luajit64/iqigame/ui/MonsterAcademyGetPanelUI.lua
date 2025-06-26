-- chunkname: @IQIGame\\UI\\MonsterAcademyGetPanelUI.lua

local MonsterAcademyGetPanelUI = {
	getPanelCellPool = {}
}

MonsterAcademyGetPanelUI = Base:Extend("MonsterAcademyGetPanelUI", "IQIGame.Onigao.UI.MonsterAcademyGetPanelUI", MonsterAcademyGetPanelUI)

require("IQIGame.UIExternalApi.MonsterAcademyGetPanelUIApi")

local MonsterAcademyGetPanelCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyGetPanelCell")

function MonsterAcademyGetPanelUI:OnInit()
	function self.DelegateUpdateItem(cell)
		self:UpdateItem(cell)
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	local wrapContent = self.ItemContainer:GetComponent("ScrollAreaList")

	wrapContent.onRenderCell = self.DelegateUpdateItem

	UGUIUtil.SetText(self.TextTitle, MonsterAcademyGetPanelUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.TextEng, MonsterAcademyGetPanelUIApi:GetString("TextEng"))

	self.goBtnTxt:GetComponent("Text").text = MonsterAcademyGetPanelUIApi:GetString("goBtnTxt")
end

function MonsterAcademyGetPanelUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyGetPanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademyGetPanelUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyGetPanelUI:GetBGM(userData)
	return nil
end

function MonsterAcademyGetPanelUI:OnOpen(userData)
	if userData == nil then
		return
	end

	self.OpenTime = Time.realtimeSinceStartup

	self:UpdateView(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, userData.items, {})
end

function MonsterAcademyGetPanelUI:OnClose(userData)
	return
end

function MonsterAcademyGetPanelUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function MonsterAcademyGetPanelUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function MonsterAcademyGetPanelUI:OnPause()
	return
end

function MonsterAcademyGetPanelUI:OnResume()
	return
end

function MonsterAcademyGetPanelUI:OnCover()
	return
end

function MonsterAcademyGetPanelUI:OnReveal()
	return
end

function MonsterAcademyGetPanelUI:OnRefocus(userData)
	return
end

function MonsterAcademyGetPanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademyGetPanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyGetPanelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyGetPanelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyGetPanelUI:OnDestroy()
	for i, v in pairs(self.getPanelCellPool) do
		v:Dispose()
	end
end

function MonsterAcademyGetPanelUI:OnClickCloseBtn()
	if Time.realtimeSinceStartup - self.OpenTime < 1 then
		return
	end

	UIModule.Close(Constant.UIControllerName.MonsterAcademyGetPanelUI)
end

function MonsterAcademyGetPanelUI:UpdateView(tipCid, items, args)
	self.RawItemDatas = items

	UGUIUtil.SetText(self.ContentText, getTipText(tipCid, unpack(args)))

	local wrapContent = self.ItemContainer:GetComponent("ScrollAreaList")

	wrapContent:Refresh(#items)
end

function MonsterAcademyGetPanelUI:UpdateItem(cell)
	local itemGo = cell.gameObject
	local rawItemData = self.RawItemDatas[cell.index + 1]
	local instanceID = itemGo:GetInstanceID()
	local itemCell = self.getPanelCellPool[instanceID]

	if itemCell == nil then
		itemCell = MonsterAcademyGetPanelCell.New(cell.gameObject)
		self.getPanelCellPool[instanceID] = itemCell
	end

	itemCell:SetData(rawItemData)
end

return MonsterAcademyGetPanelUI
