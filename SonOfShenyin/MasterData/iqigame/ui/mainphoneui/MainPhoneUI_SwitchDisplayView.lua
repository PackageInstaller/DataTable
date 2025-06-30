-- chunkname: @IQIGame\\UI\\MainPhoneUI\\MainPhoneUI_SwitchDisplayView.lua

local DisplayItemCell = {}

function DisplayItemCell.New(view)
	local obj = Clone(DisplayItemCell)

	obj:__Init(view)

	return obj
end

function DisplayItemCell:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function DisplayItemCell:Show(skinCid)
	self.skinCid = skinCid

	self.gameObject:SetActive(true)

	if skinCid == nil then
		self:__ShowEmpty()
	elseif skinCid == 0 then
		self:__ShowEmpty()
	else
		self:__ShowHeroSkin(skinCid)
	end
end

function DisplayItemCell:__ShowEmpty()
	self.RoleImage.gameObject:SetActive(false)
end

function DisplayItemCell:__ShowHeroSkin(skinCid)
	self.RoleImage.gameObject:SetActive(true)

	local heroSkinData = CfgHeroSkinTable[skinCid]
	local path = SkinModule.GetHeroSkinImgPathByType(heroSkinData, Constant.SkinImageType.HeroResourcesShowImg)

	AssetUtil.LoadImage(self, path, self.RoleImage:GetComponent("Image"))
end

function DisplayItemCell:Hide()
	self.gameObject:SetActive(false)
end

function DisplayItemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local SwitchDisplayView = {
	displayItemCellList = {},
	displaySkinList = {}
}

function SwitchDisplayView.New(view)
	local obj = Clone(SwitchDisplayView)

	obj:__Init(view)

	return obj
end

function SwitchDisplayView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:__InitDisplayScrollAreaList()

	function self.__delegateOnRandomToggleValueChange(_isOn)
		self:__OnRandomToggleValueChange(_isOn)
	end

	self:__OnAddListeners()
end

function SwitchDisplayView:__OnRandomToggleValueChange(isOn)
	local value = 0

	if isOn then
		value = 1
	end

	SettingModule.SetRoleDisplayRandomState(value)
end

function SwitchDisplayView:__OnAddListeners()
	local isOn = SettingModule.GetRoleDisplayRandomState()
	local toggleCom = self.RandomSwitchToggle:GetComponent("Toggle")

	toggleCom.isOn = isOn

	toggleCom.onValueChanged:AddListener(self.__delegateOnRandomToggleValueChange)
	UIEventUtil.AddClickEventListener_Button(self, "CancelBtn")
	UIEventUtil.AddClickEventListener_Button(self, "ConfirmBtn")
	UIEventUtil.AddClickEventListener_Button(self, "CloseBtn")
	EventUtil.AddEventListener(self, EventID.MainPhoneUIRoleDisplaySkinSelected)
	EventUtil.AddEventListener(self, EventID.MainPhoneUIRoleDisplaySkinRemove)
end

function SwitchDisplayView:__OnRemoveListeners()
	local toggleCom = self.RandomSwitchToggle:GetComponent("Toggle")

	toggleCom.onValueChanged:RemoveListener(self.__delegateOnRandomToggleValueChange)
	UIEventUtil.ClearEventListener(self)
	EventUtil.ClearEventListener(self)
end

function SwitchDisplayView:Show()
	self.gameObject:SetActive(true)
	self:__RefreshDisplaySkinShow()
end

function SwitchDisplayView:Hide()
	self.gameObject:SetActive(false)
end

function SwitchDisplayView:Dispose()
	self:__OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function SwitchDisplayView:__InitDisplayScrollAreaList()
	self.scrollAreaList = self.ScrollAreaListRoot:GetComponent("ScrollAreaList")

	function self.scrollAreaList.onRenderCell(_cell)
		self:__OnDisplayCellRender(_cell)
	end

	function self.scrollAreaList.onSelectedCell(_cell)
		self:__OnDisplayCellSelected(_cell)
	end
end

function SwitchDisplayView:__OnDisplayCellRender(cell)
	local dataIndex = cell.index + 1
	local instanceID = cell.gameObject:GetInstanceID()
	local displayItemCell = self.displayItemCellList[instanceID]

	if displayItemCell == nil then
		displayItemCell = DisplayItemCell.New(cell.gameObject)
		self.displayItemCellList[instanceID] = displayItemCell
	end

	local skinCid = self.displaySkinList[dataIndex]

	displayItemCell:Show(skinCid)
end

function SwitchDisplayView:__OnDisplayCellSelected(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local displayItemCell = self.displayItemCellList[instanceID]

	EventDispatcher.Dispatch(EventID.SetMainPhoneUIRoleDisplaySelectViewActive, true, displayItemCell.skinCid)
end

function SwitchDisplayView:__RefreshDisplaySkinShow()
	local skinList = PlayerModule.GetDisplaySkinList()

	self.displaySkinList = Clone(skinList)

	PlayerModule.SetDisplaySkinListWithSwitchDisplayViewData(self.displaySkinList)
	self.scrollAreaList:Refresh(#self.displaySkinList)
end

function SwitchDisplayView:__OnCancelBtnClickHandler()
	EventDispatcher.Dispatch(EventID.SetMainPhoneUIRoleDisplaySetViewActive, false)
end

function SwitchDisplayView:__OnConfirmBtnClickHandler()
	local array = {}

	ForArray(self.displaySkinList, function(_, _skinCid)
		if _skinCid == 0 then
			return
		end

		table.insert(array, _skinCid)
	end)
	PlayerModule.SetKanBanPool(array)
	EventDispatcher.Dispatch(EventID.SetMainPhoneUIRoleDisplaySetViewActive, false)
end

function SwitchDisplayView:__OnCloseBtnClickHandler()
	EventDispatcher.Dispatch(EventID.SetMainPhoneUIRoleDisplaySetViewActive, false)
end

function SwitchDisplayView:__OnMainPhoneUIRoleDisplaySkinSelectedHandler(skinCid, oldSkinCid)
	local tempIndex = 0
	local sourceIndex = 0

	ForArray(self.displaySkinList, function(_index, _skinCid)
		if _skinCid == skinCid then
			sourceIndex = _index
		end

		if oldSkinCid ~= 0 then
			if _skinCid == oldSkinCid then
				tempIndex = _index
			end
		elseif tempIndex == 0 and _skinCid == 0 then
			tempIndex = _index
		end
	end)

	if sourceIndex == 0 then
		self.displaySkinList[tempIndex] = skinCid
	else
		self.displaySkinList[tempIndex] = skinCid
		self.displaySkinList[sourceIndex] = oldSkinCid
	end

	self.scrollAreaList:Refresh(#self.displaySkinList)
	PlayerModule.SetDisplaySkinListWithSwitchDisplayViewData(self.displaySkinList)
	EventDispatcher.Dispatch(EventID.SetMainPhoneUIRoleDisplaySelectViewActive, false)
end

function SwitchDisplayView:__OnMainPhoneUIRoleDisplaySkinRemoveHandler(skinCid, oldSkinCid)
	local tempIndex = 0
	local tempCount = 0

	ForArray(self.displaySkinList, function(_index, _skinCid)
		if _skinCid == 0 then
			return
		end

		tempCount = tempCount + 1

		if _skinCid == skinCid then
			tempIndex = _index
		end

		if tempCount <= 1 then
			return
		end

		return tempIndex > 0
	end)

	if tempIndex == 0 then
		return
	end

	if tempCount <= 1 then
		NoticeModule.ShowNotice(51024)

		return
	end

	self.displaySkinList[tempIndex] = 0

	self.scrollAreaList:Refresh(#self.displaySkinList)
	PlayerModule.SetDisplaySkinListWithSwitchDisplayViewData(self.displaySkinList)
	EventDispatcher.Dispatch(EventID.SetMainPhoneUIRoleDisplaySelectViewActive, false)
end

return SwitchDisplayView
