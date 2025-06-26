-- chunkname: @IQIGame\\UI\\RoleDevelopmentPanel.lua

local UITabList = require("IQIGame.UI.Common.UITabList")
local RoleDevelopmentRolePreviewPanel = require("IQIGame/UI/RoleDevelopmentPanel/RoleDevelopmentRolePreviewPanel")
local RoleDevelopmentInfoPanel = require("IQIGame/UI/RoleDevelopmentPanel/RoleDevelopmentInfoPanel")
local RoleDevelopmentEquipPanel = require("IQIGame/UI/RoleDevelopmentPanel/RoleDevelopmentEquipPanel")
local DIYSkillPanel = require("IQIGame/UI/RoleDevelopmentPanel/DIYSkillPanel/RoleDevelopmentDIYSkillPanel")
local RoleDevelopmentRoleWarehousePanel = require("IQIGame/UI/RoleDevelopmentPanel/RoleDevelopmentRoleWarehousePanel")
local RoleDevelopmentStarRisePanel = require("IQIGame/UI/RoleDevelopmentPanel/RoleDevelopmentStarRisePanel")
local RoleDevelopmentPersonalityPanel = require("IQIGame/UI/RoleDevelopmentPanel/RoleDevelopmentPersonalityPanel")
local RoleDevelopmentTipsPanel = require("IQIGame/UI/RoleDevelopmentPanel/RoleDevelopmentTipsPanel")
local RoleDevelopmentBaseSkillPanel = require("IQIGame.UI.RoleDevelopmentPanel.RoleDevelopmentBaseSkillPanel")
local RoleItemCell = {
	roleCid = 0
}

function RoleItemCell.New(view)
	local obj = Clone(RoleItemCell)

	obj:__Init(view)

	return obj
end

function RoleItemCell:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)

	function self.__delegateOnHeroSkinChange()
		self:__OnHeroSkinChange()
	end

	function self.__delegateOnRoleBreakThroughEvent()
		self:__OnHeroSkinChange()
	end

	function self.__delegateOnRefreshRedDot()
		self:__OnRefreshRedDot()
	end

	EventDispatcher.AddEventListener(EventID.ChangeSkinResult, self.__delegateOnHeroSkinChange)
	EventDispatcher.AddEventListener(EventID.RoleBreakThroughSucess, self.__delegateOnRoleBreakThroughEvent)
	EventDispatcher.AddEventListener(EventID.roleRedDotEvent, self.__delegateOnRefreshRedDot)
end

function RoleItemCell:Show(warlockData)
	self.roleCid = warlockData.cid

	self.view.gameObject:SetActive(true)

	local headIconPath = warlockData:GetCurStaticSkinImagePath(Constant.SkinImageType.DetailsHeadIcon)

	AssetUtil.LoadImage(self, headIconPath, self.icon:GetComponent(typeof(UnityEngine.UI.Image)))

	local bgPath, selectPath = RoleDevelopmentApi:GetRoleListIconBackground(warlockData:GetCfg().Quality)

	AssetUtil.LoadImage(self, bgPath, self.normalRoot:GetComponent(typeof(UnityEngine.UI.Image)))
	AssetUtil.LoadImage(self, selectPath, self.selectRoot:GetComponent(typeof(UnityEngine.UI.Image)))
	self:__OnRefreshRedDot()
end

function RoleItemCell:Hide()
	self.view.gameObject:SetActive(false)
end

function RoleItemCell:__OnHeroSkinChange()
	local warlockData = WarlockModule.GetHeroData(self.roleCid)
	local headIconPath = warlockData:GetCurStaticSkinImagePath(Constant.SkinImageType.DetailsHeadIcon)

	AssetUtil.LoadImage(self, headIconPath, self.icon:GetComponent(typeof(UnityEngine.UI.Image)))
end

function RoleItemCell:ChangeSelect(isSelect)
	self.selectRoot.gameObject:SetActive(isSelect)
	self.normalRoot.gameObject:SetActive(not isSelect)
end

function RoleItemCell:__OnRefreshRedDot()
	LuaUtility.SetGameObjectShow(self.RedDot, RedDotModule.CanShowRedDot_WarlockItem(self.roleCid))
end

function RoleItemCell:Dispose()
	EventDispatcher.RemoveEventListener(EventID.ChangeSkinResult, self.__delegateOnHeroSkinChange)
	EventDispatcher.RemoveEventListener(EventID.RoleBreakThroughSucess, self.__delegateOnRoleBreakThroughEvent)
	EventDispatcher.RemoveEventListener(EventID.roleRedDotEvent, self.__delegateOnRefreshRedDot)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

local RoleDevelopmentPanel = Base:Extend("RoleDevelopmentPanel", "IQIGame.Onigao.UI.RoleDevelopmentPanel", {
	selectRoleCid = 0,
	roleSortType = 1
})

function RoleDevelopmentPanel:OnInit()
	self:__OnPrepareEventProxy()

	self.commonReturnBtn = CommonReturnBtn.New(self.comReturnBtn, self)

	self:__InitRoleAreaList()
	self:__InitDevelopmentTabList()

	self.rolePreviewPanel = RoleDevelopmentRolePreviewPanel.New(self.rolePreviewRoot, RoleDevelopmentRolePreviewPanel)

	self:__InitRoleWarehouse()

	function self.__OnTipsButtonClickProxy()
		self:__OnTipsButtonClickEvent()
	end

	self.tipsPanel = RoleDevelopmentTipsPanel.New(self.tipsPanelRoot)
end

function RoleDevelopmentPanel:GetPreloadAssetPaths()
	return nil
end

function RoleDevelopmentPanel:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RoleDevelopmentPanel:IsManualShowOnOpen(userData)
	return false
end

function RoleDevelopmentPanel:GetBGM(userData)
	return nil
end

function RoleDevelopmentPanel:OnOpen(userData)
	self.selectRoleCid = userData.roleCid

	if userData.hideHomeButton then
		self.commonReturnBtn:SetHomeBtnState(false)
	else
		self.commonReturnBtn:SetHomeBtnState(true)
	end

	local sortType = userData.sortType

	if sortType == nil then
		sortType = Constant.WarlockSortType.Quality
	end

	local downSort = userData.downSort

	if downSort == nil then
		downSort = false
	end

	local roleList = userData.roleList

	if roleList == nil then
		roleList = WarlockModule.GetWarlockList()
	end

	if self.selectRoleCid == nil then
		self.selectRoleCid = roleList[1].cid
	end

	self:__OnRefreshRoleListShow(sortType, downSort, roleList, true)
	self.developmentTableList:UpdateTableActive(1, true)
	self.rolePreviewPanel:Show(self.selectRoleCid)
	WarlockModule.UpdateLocalRecordNewHeroData(self.selectRoleCid)
	self:__UpdateRolePreviewPanelWithRoleChange()
	self:RedDotRefresh()
	self:PlayEnterAnim()
end

function RoleDevelopmentPanel:OnClose(userData)
	CVModule.StopCV()
	ModuleTimerUtil.Stop(Constant.ModuleTimerName.RoleDevelopmentPanel)
	self.roleWarehousePanel:Hide()
end

function RoleDevelopmentPanel:__OnPrepareEventProxy()
	function self.__OnRoleWarehouseBtnClickEventProxy()
		self:__OnOpenRoleWarehouse()
	end

	function self.__OnChangeTargetSelectIndexEvent(index)
		self:__OnChangeToTargetIndex(index)
	end

	function self.__OnPlayContentAnimEvent(isReverse)
		if isReverse then
			self:PlayEnterAnim()
		else
			self:PlayExitAnim()
		end
	end

	function self.setLeftContentShowEvent(show)
		self:SetLeftContentShowEvent(show)
	end

	function self.setLeftContentSiblingEvent(siblingIndex)
		self:SetLeftContentSibling(siblingIndex)
	end

	function self.setReturnBtnShowEvent(show)
		if show then
			self.commonReturnBtn:Show()
		else
			self.commonReturnBtn:Hide()
		end
	end

	function self.onRedDotEvent()
		self:RedDotRefresh()
	end

	function self.delegateOnClickButtonTempPersonality()
		UIModule.Open(Constant.UIControllerName.PersonalitySystemPanel, Constant.UILayer.UI)
	end
end

function RoleDevelopmentPanel:OnAddListeners()
	self.roleWarehouseBtn:GetComponent("Button").onClick:AddListener(self.__OnRoleWarehouseBtnClickEventProxy)
	self.tipsBtn:GetComponent("Button").onClick:AddListener(self.__OnTipsButtonClickProxy)
	self.buttonTempPersonality:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonTempPersonality)
	EventDispatcher.AddEventListener(EventID.ChangeTargetSelectIndexEvent, self.__OnChangeTargetSelectIndexEvent)
	EventDispatcher.AddEventListener(EventID.PlayContentAnimEvent, self.__OnPlayContentAnimEvent)
	EventDispatcher.AddEventListener(EventID.SetRoleDevelopmentPanelLeftContentShow, self.setLeftContentShowEvent)
	EventDispatcher.AddEventListener(EventID.SetRoleDevelopmentPanelLeftContentSiblingIndex, self.setLeftContentSiblingEvent)
	EventDispatcher.AddEventListener(EventID.SetRoleDevelopmentPanelReturnBtnShow, self.setReturnBtnShowEvent)
	EventDispatcher.AddEventListener(EventID.roleRedDotEvent, self.onRedDotEvent)
end

function RoleDevelopmentPanel:OnRemoveListeners()
	self.roleWarehouseBtn:GetComponent("Button").onClick:RemoveListener(self.__OnRoleWarehouseBtnClickEventProxy)
	self.tipsBtn:GetComponent("Button").onClick:RemoveListener(self.__OnTipsButtonClickProxy)
	self.buttonTempPersonality:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonTempPersonality)
	EventDispatcher.RemoveEventListener(EventID.ChangeTargetSelectIndexEvent, self.__OnChangeTargetSelectIndexEvent)
	EventDispatcher.RemoveEventListener(EventID.PlayContentAnimEvent, self.__OnPlayContentAnimEvent)
	EventDispatcher.RemoveEventListener(EventID.SetRoleDevelopmentPanelLeftContentShow, self.setLeftContentShowEvent)
	EventDispatcher.RemoveEventListener(EventID.SetRoleDevelopmentPanelLeftContentSiblingIndex, self.setLeftContentSiblingEvent)
	EventDispatcher.RemoveEventListener(EventID.SetRoleDevelopmentPanelReturnBtnShow, self.setReturnBtnShowEvent)
	EventDispatcher.RemoveEventListener(EventID.roleRedDotEvent, self.onRedDotEvent)
end

function RoleDevelopmentPanel:OnPause()
	return
end

function RoleDevelopmentPanel:OnResume()
	return
end

function RoleDevelopmentPanel:OnCover()
	return
end

function RoleDevelopmentPanel:OnReveal()
	return
end

function RoleDevelopmentPanel:OnRefocus(userData)
	return
end

function RoleDevelopmentPanel:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RoleDevelopmentPanel:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RoleDevelopmentPanel:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RoleDevelopmentPanel:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RoleDevelopmentPanel:OnDestroy()
	self.tipsPanel:Dispose()
	self.commonReturnBtn:Dispose()
	self.rolePreviewPanel:Dispose()
	self.roleWarehousePanel:Dispose()

	self.roleWarehousePanel = nil

	self.developmentTableList:Dispose()

	self.developmentTableList = nil

	ForPairs(self.roleAreaItemList, function(_, _itemCell)
		_itemCell:Dispose()
	end)

	self.roleAreaItemList = nil
	self.roleAreaList = nil
end

function RoleDevelopmentPanel:__InitRoleAreaList()
	self.roleAreaItemList = {}

	self.roleListItemTemplate.gameObject:SetActive(false)

	self.roleAreaList = self.roleList:GetComponent("ScrollAreaList")

	function self.roleAreaList.onRenderCell(cell)
		self:__OnRenderRoleListItem(cell)
	end

	function self.roleAreaList.onSelectedCell(cell)
		self:__OnRoleListItemSelect(cell)
	end
end

function RoleDevelopmentPanel:__OnRenderRoleListItem(itemCell)
	local insID = itemCell.gameObject:GetInstanceID()
	local roleItemCell = self.roleAreaItemList[insID]

	if roleItemCell == nil then
		roleItemCell = RoleItemCell.New(itemCell.gameObject)
		self.roleAreaItemList[insID] = roleItemCell
	end

	roleItemCell:Show(self.roleAreaDataList[itemCell.index + 1])
	roleItemCell:ChangeSelect(roleItemCell.roleCid == self.selectRoleCid)
end

function RoleDevelopmentPanel:__OnRoleListItemSelect(itemCell)
	local insID = itemCell.gameObject:GetInstanceID()

	ForPairs(self.roleAreaItemList, function(_insID, _roleItemCell)
		_roleItemCell:ChangeSelect(_insID == insID)
	end)

	local roleItemCell = self.roleAreaItemList[insID]

	self:__OnChangeSelectRole(roleItemCell.roleCid)
end

function RoleDevelopmentPanel:__InitRoleWarehouse()
	self.roleWarehousePanel = RoleDevelopmentRoleWarehousePanel.New(self.roleWarehouseRoot)

	function self.roleWarehousePanel.ChangeSelectRoleEvent(_roleCid)
		self:__OnRoleSelectByWarehouse(_roleCid)
	end

	function self.roleWarehousePanel.CloseEvent(_sortType, _downSort, _roleList)
		self:__OnRoleWarehouseClose(_sortType, _downSort, _roleList)
	end
end

function RoleDevelopmentPanel:__OnOpenRoleWarehouse()
	self.roleWarehousePanel:Show(self.roleAreaDataList, self.selectRoleCid, self.roleSortType, self.roleDownSort)
end

function RoleDevelopmentPanel:__OnRoleSelectByWarehouse(roleCid)
	self:__OnChangeSelectRole(roleCid)
end

function RoleDevelopmentPanel:__OnRoleWarehouseClose(sortType, downSort, roleList)
	if self.roleSortType ~= sortType or self.roleDownSort ~= downSort then
		self:__OnRefreshRoleListShow(sortType, downSort, roleList)

		return
	end

	ForPairs(self.roleAreaItemList, function(_insID, _roleItemCell)
		_roleItemCell:ChangeSelect(_roleItemCell.roleCid == self.selectRoleCid)
	end)
end

function RoleDevelopmentPanel:__OnChangeSelectRole(roleCid)
	CVModule.StopCV()

	self.selectRoleCid = roleCid

	local len = #self.roleAreaDataList

	for i = 1, len do
		if self.roleAreaDataList[i].cid == roleCid then
			WarlockModule.curWarlockData = self.roleAreaDataList[i]

			break
		end
	end

	local changeTableIndex = self.developmentTableList:UpdateTableActive(1)

	if not changeTableIndex then
		local viewTable = self.developmentTableList:GetSelectItem().viewTable

		viewTable:Refresh(roleCid)
	end

	WarlockModule.UpdateLocalRecordNewHeroData(roleCid)
	self:__UpdateRolePreviewPanelWithRoleChange()
	self:RedDotRefresh()
end

function RoleDevelopmentPanel:__OnRefreshRoleListShow(sortType, downSort, roleList, multipleRefresh)
	self.roleSortType = sortType
	self.roleDownSort = downSort
	self.roleAreaDataList = roleList

	if multipleRefresh then
		self.roleAreaList.startIndex = 0

		self.roleAreaList:Refresh(#self.roleAreaDataList)
	end

	if self.selectRoleCid == -1 then
		self.selectRoleCid = self.roleAreaDataList[1].cid
	end

	local startIndex = 1

	ForArray(self.roleAreaDataList, function(k, v)
		if v.cid ~= self.selectRoleCid then
			return
		end

		startIndex = k

		return true
	end)

	self.roleAreaList.startIndex = startIndex - 1

	self.roleAreaList:Refresh(#self.roleAreaDataList)
end

function RoleDevelopmentPanel:__InitDevelopmentTabList()
	self.developmentTableList = UITabList.Create()

	self.developmentTableList:AddTableItem(self.infoTabItem, function()
		return RoleDevelopmentInfoPanel.New(self.infoPanel, RoleDevelopmentInfoPanel)
	end, function(_isOn, _view)
		self:__OnToggleValueChange(_isOn, _view)
	end, nil)
	self.developmentTableList:AddTableItem(self.baseSkillTableItem, function()
		return RoleDevelopmentBaseSkillPanel.New(self.baseSkillPanel, RoleDevelopmentBaseSkillPanel)
	end, function(_isOn, _view)
		self:__OnToggleValueChange(_isOn, _view)
	end, nil)
	self.developmentTableList:AddTableItem(self.skillTabItem, function()
		return DIYSkillPanel.New(self.SkillPanel, DIYSkillPanel)
	end, function(_isOn, _view)
		self:__OnToggleValueChange(_isOn, _view)
	end, function()
		return self:__CheckSkillTabItemActive()
	end)
	self.developmentTableList:AddTableItem(self.equipTabItem, function()
		return RoleDevelopmentEquipPanel.New(self.equipPanel, RoleDevelopmentEquipPanel)
	end, function(_isOn, _view)
		self:__OnToggleValueChange(_isOn, _view)
	end, function()
		return self:__CheckEquipTabItemActive()
	end)
	self.developmentTableList:AddTableItem(self.upGradationTabItem, function()
		return RoleDevelopmentPersonalityPanel.New(self.personalityPanel, RoleDevelopmentPersonalityPanel)
	end, function(_isOn, _view)
		self:__OnToggleValueChange(_isOn, _view)
	end, function()
		return self:__CheckPersonalityTabItemActive()
	end)
	self.levelUpTabItem.gameObject:SetActive(true)
	self.developmentTableList:AddTableItem(self.levelUpTabItem, function()
		return RoleDevelopmentStarRisePanel.New(self.StarRisePanel, RoleDevelopmentStarRisePanel)
	end, function(_isOn, _view)
		self:__OnToggleValueChange(_isOn, _view)
	end, function()
		return self:__CheckLevelUpTabItemActive()
	end)
end

function RoleDevelopmentPanel:__OnToggleValueChange(_isOn, _view)
	if _isOn then
		CVModule.StopCV()
		_view:Show(self.selectRoleCid)
		self:__UpdateRolePreviewPanelWithTableChange()
	else
		_view:Hide()
	end
end

function RoleDevelopmentPanel:__OnChangeToTargetIndex(index)
	self.developmentTableList:UpdateTableActive(index, true)
end

function RoleDevelopmentPanel:__CheckSkillTabItemActive()
	return true
end

function RoleDevelopmentPanel:__CheckEquipTabItemActive()
	return true
end

function RoleDevelopmentPanel:__CheckUpGradationTabItemActive()
	return true
end

function RoleDevelopmentPanel:__CheckPersonalityTabItemActive()
	return true
end

function RoleDevelopmentPanel:__CheckLevelUpTabItemActive()
	local heroWarlockData = WarlockModule.WarlockDataDic[self.selectRoleCid]

	if heroWarlockData:GetStarLevel() == 5 then
		return false
	end

	return true
end

function RoleDevelopmentPanel:__UpdateRolePreviewPanelWithRoleChange()
	if self.rolePreviewPanel:ActiveSelf() then
		self.rolePreviewPanel:Refresh(self.selectRoleCid)
	else
		self.rolePreviewPanel:Show(self.selectRoleCid)
	end
end

function RoleDevelopmentPanel:__UpdateRolePreviewPanelWithTableChange()
	if not self.rolePreviewPanel:ActiveSelf() then
		self.rolePreviewPanel:Show(self.selectRoleCid)
	end
end

function RoleDevelopmentPanel:PlayExitAnim()
	UIUtil.PlayOrRewindDefaultAnim(self.ContentRoot, false)
end

function RoleDevelopmentPanel:PlayEnterAnim()
	UIUtil.PlayOrRewindDefaultAnim(self.ContentRoot, true)
end

function RoleDevelopmentPanel:OnClickTempButtonOpenPersonalityUI()
	return
end

function RoleDevelopmentPanel:SetLeftContentShowEvent(show)
	LuaUtility.SetGameObjectShow(self.LeftContent, show)
end

function RoleDevelopmentPanel:SetLeftContentSibling(siblingIndex)
	LuaUtility.SetGameObjectSiblingIndex(self.LeftContent, siblingIndex)
end

function RoleDevelopmentPanel:__OnTipsButtonClickEvent()
	self.tipsPanel:Show(self.selectRoleCid)
end

function RoleDevelopmentPanel:RedDotRefresh()
	LuaUtility.SetGameObjectShow(self.RedDot_upGradationTab, RedDotModule.CanShowRedDot_Warlock_PersonalityItem(self.selectRoleCid))
	LuaUtility.SetGameObjectShow(self.RedDot_infoTab, RedDotModule.CanShowRedDot_Warlock_BreachReward(self.selectRoleCid))
	LuaUtility.SetGameObjectShow(self.RedDot_levelUpTab, RedDotModule.CanShowRedDot_Warlock_LevelUp(self.selectRoleCid))
end

return RoleDevelopmentPanel
