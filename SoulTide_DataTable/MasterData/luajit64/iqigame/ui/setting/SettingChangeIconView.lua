-- chunkname: @IQIGame\\UI\\Setting\\SettingChangeIconView.lua

local SettingChangeIconView = {
	isSelectFrame = false,
	headCellPool = {},
	headFrameCellPool = {}
}
local SettingHeadCell = require("IQIGame.UI.Setting.SettingHeadCell")
local SettingHeadFrameCell = require("IQIGame.UI.Setting.SettingHeadFrameCell")
local SettingSelectGroupView = require("IQIGame.UI.Setting.ChangeIcon.SettingSelectGroupView")

function SettingChangeIconView.__New(ui)
	local o = Clone(SettingChangeIconView)

	o:InitView(ui)

	return o
end

function SettingChangeIconView:InitView(ui)
	self.rootUI = ui

	self.rootUI:SetActive(false)
	LuaCodeInterface.BindOutlet(self.rootUI, self)
	UGUIUtil.SetText(self.TextTitleEng, SettingPlayerInfoViewApi:GetString("TextTitleEng"))
	UGUIUtil.SetText(self.TextToggleFrameDown, SettingPlayerInfoViewApi:GetString("TextToggleFrame"))
	UGUIUtil.SetText(self.TextToggleFrameUp, SettingPlayerInfoViewApi:GetString("TextToggleFrame"))
	UGUIUtil.SetText(self.TextToggleHeadDown, SettingPlayerInfoViewApi:GetString("TextToggleHead"))
	UGUIUtil.SetText(self.TextToggleHeadUp, SettingPlayerInfoViewApi:GetString("TextToggleHead"))
	UGUIUtil.SetText(self.TextBtnClose, SettingPlayerInfoViewApi:GetString("TextBtnClose"))

	self.TextTitle1:GetComponent("Text").text = SettingPlayerInfoViewApi:GetString("TextTitle3")
	self.TextTitle2:GetComponent("Text").text = SettingPlayerInfoViewApi:GetString("TextTitle4")
	self.btnCloseComponent = self.BtnClose:GetComponent("Button")
	self.btnConfirmComponent = self.BtnConfirm:GetComponent("Button")

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateClickBtnConfirm()
		self:OnClickBtnConfirm()
	end

	self.headScroll = self.GridSlot:GetComponent("ScrollAreaList")

	function self.headScroll.onRenderCell(cell)
		self:OnRenderHeadCell(cell)
	end

	function self.headScroll.onSelectedCell(cell)
		self:OnSelectedHeadCell(cell)
	end

	self.headFrameScroll = self.ScrollFrame:GetComponent("ScrollAreaList")

	function self.headFrameScroll.onRenderCell(cell)
		self:OnRenderHeadFrameCell(cell)
	end

	function self.headFrameScroll.onSelectedCell(cell)
		self:OnSelectHeadFrameCell(cell)
	end

	function self.delegateOnToggleChange(isOn)
		self:OnToggleChange(isOn)
	end

	function self.delegateUpdatePlayerHeadIcon()
		self:OnUpdatePlayerHeadIcon()
	end

	function self.delegateUpdatePlayerAvatarFrame()
		self:OnUpdatePlayerAvatarFrame()
	end

	function self.DelegateOnPlayerHeadFrameLoaded()
		self:OnPlayerHeadFrameLoaded()
	end

	self.selectGroupView = SettingSelectGroupView.New(self.SelectGroup)

	function self.selectGroupView.selectCallBack()
		self:OnSelectGroup()
	end
end

function SettingChangeIconView:AddEventListener()
	self.btnCloseComponent.onClick:AddListener(self.delegateClickBtnClose)
	self.btnConfirmComponent.onClick:AddListener(self.delegateClickBtnConfirm)
	self.Toggle:GetComponent("Toggle").onValueChanged:AddListener(self.delegateOnToggleChange)
	EventDispatcher.AddEventListener(EventID.UpdatePlayerHeadIcon, self.delegateUpdatePlayerHeadIcon)
	EventDispatcher.AddEventListener(EventID.UpdatePlayerAvatarFrame, self.delegateUpdatePlayerAvatarFrame)
	EventDispatcher.AddEventListener(EventID.PlayerHeadFrameLoaded, self.DelegateOnPlayerHeadFrameLoaded)
end

function SettingChangeIconView:RemoveEventListener()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateClickBtnClose)
	self.btnConfirmComponent.onClick:RemoveListener(self.delegateClickBtnConfirm)
	self.Toggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.delegateOnToggleChange)
	EventDispatcher.RemoveEventListener(EventID.UpdatePlayerHeadIcon, self.delegateUpdatePlayerHeadIcon)
	EventDispatcher.RemoveEventListener(EventID.UpdatePlayerAvatarFrame, self.delegateUpdatePlayerAvatarFrame)
	EventDispatcher.RemoveEventListener(EventID.PlayerHeadFrameLoaded, self.DelegateOnPlayerHeadFrameLoaded)
end

function SettingChangeIconView:OnUpdatePlayerHeadIcon()
	self:ShowHeadList()
end

function SettingChangeIconView:OnUpdatePlayerAvatarFrame()
	self:ShowFrameList()
end

function SettingChangeIconView:ShowHeadList()
	local selectGroup = self.selectGroupView.selectIndex
	local headIconSelectGroup = {
		selectGroup
	}

	if selectGroup == 0 then
		headIconSelectGroup = self.selectGroupView.defaultGroup
	end

	self.unlockHeadIcons = {}

	for i = 1, #SettingModule.unlockHeadIcons do
		local data = SettingModule.unlockHeadIcons[i]

		if table.indexOf(headIconSelectGroup, data.cfgInfo.Group) ~= -1 then
			if data.isLock then
				table.insert(self.unlockHeadIcons, data)
			elseif data.cfgInfo.IsLockShow then
				table.insert(self.unlockHeadIcons, data)
			end
		end
	end

	table.sort(self.unlockHeadIcons, function(a, b)
		local aLock = a.isLock and 1 or 0
		local bLock = b.isLock and 1 or 0
		local res = false

		if aLock == bLock then
			res = a.cfgInfo.Sort < b.cfgInfo.Sort
		else
			res = bLock < aLock
		end

		return res
	end)
	self.headScroll:Refresh(#self.unlockHeadIcons)

	if self.currentSelectedHead then
		local playerHeadData = SettingModule.GetPlayHeadData(PlayerModule.PlayerInfo.baseInfo.headIcon)
		local isCurrentSetting = playerHeadData.cfgID == self.currentSelectedHead.cfgID

		self.BtnConfirm:SetActive(self.currentSelectedHead.isLock and not isCurrentSetting)
		self.TextUnlock:SetActive(not self.currentSelectedHead.isLock)
		UGUIUtil.SetText(self.TextUnlock, self.currentSelectedHead.cfgInfo.LockDescribtion)
		UGUIUtil.SetText(self.TextName, self.currentSelectedHead.cfgInfo.Name)
		UGUIUtil.SetText(self.TextDes, self.currentSelectedHead.cfgInfo.Desc)
		self:PreviewingMsg()
	else
		self.BtnConfirm:SetActive(false)
		self.TextUnlock:SetActive(false)
	end
end

function SettingChangeIconView:ShowFrameList()
	local selectGroup = self.selectGroupView.selectIndex
	local frameSelectGroup = {
		selectGroup
	}

	if selectGroup == 0 then
		frameSelectGroup = self.selectGroupView.defaultGroup
	end

	self.unlockHeadFrames = {}

	for i = 1, #SettingModule.unlockHeadFrames do
		local data = SettingModule.unlockHeadFrames[i]

		if table.indexOf(frameSelectGroup, data.cfgInfo.Group) ~= -1 then
			if data.isLock then
				table.insert(self.unlockHeadFrames, data)
			elseif data.cfgInfo.IsLockShow then
				table.insert(self.unlockHeadFrames, data)
			end
		end
	end

	table.sort(self.unlockHeadFrames, function(a, b)
		local aLock = a.isLock and 1 or 0
		local bLock = b.isLock and 1 or 0
		local res = false

		if aLock == bLock then
			res = a.cfgInfo.Sort < b.cfgInfo.Sort
		else
			res = bLock < aLock
		end

		return res
	end)
	self.headFrameScroll:Refresh(#self.unlockHeadFrames)

	if self.currentSelectedHeadFrame then
		local playerHeadFrameData = SettingModule.GetPlayHeadFrameData(PlayerModule.PlayerInfo.baseInfo.avatarFrame)
		local isCurrentSetting = false

		if playerHeadFrameData then
			isCurrentSetting = playerHeadFrameData.cfgID == self.currentSelectedHeadFrame.cfgID
		end

		self.BtnConfirm:SetActive(self.currentSelectedHeadFrame.isLock and not isCurrentSetting)
		self.TextUnlock:SetActive(not self.currentSelectedHeadFrame.isLock)
		UGUIUtil.SetText(self.TextUnlock, self.currentSelectedHeadFrame.cfgInfo.LockDesc)
		UGUIUtil.SetText(self.TextName, self.currentSelectedHeadFrame.cfgInfo.Name)
		UGUIUtil.SetText(self.TextDes, self.currentSelectedHeadFrame.cfgInfo.Desc)
		self:PreviewingMsg()
	else
		self.BtnConfirm:SetActive(false)
		self.TextUnlock:SetActive(false)
	end
end

function SettingChangeIconView:OnRenderHeadCell(cell)
	local goCell = cell.gameObject
	local headData = self.unlockHeadIcons[cell.index + 1]

	if headData == nil then
		goCell:SetActive(false)

		return
	end

	local instanceID = goCell:GetInstanceID()
	local cell = self.headCellPool[instanceID]

	if cell == nil then
		cell = SettingHeadCell.New(goCell)
		self.headCellPool[instanceID] = cell
	end

	cell:SetData(headData)

	if self.currentSelectedHead == nil and cell.isCurrentSetting == true then
		self.currentSelectedHead = headData
	end

	if self.currentSelectedHead ~= nil and self.currentSelectedHead.cfgID == headData.cfgID then
		cell:Select(true)

		self.currentSelectedHeadCell = cell
	else
		cell:Select(false)
	end
end

function SettingChangeIconView:OnSelectedHeadCell(cell)
	local item = cell.gameObject
	local headData = self.unlockHeadIcons[cell.index + 1]
	local cell = self.headCellPool[item:GetInstanceID()]

	cell:SetData(headData)

	if self.currentSelectedHeadCell ~= nil then
		self.currentSelectedHeadCell:Select(false)
	end

	self.currentSelectedHead = headData
	self.currentSelectedHeadCell = cell

	self.currentSelectedHeadCell:Select(true)
	self.BtnConfirm:SetActive(self.currentSelectedHead.isLock and not self.currentSelectedHeadCell.isCurrentSetting)
	self.TextUnlock:SetActive(not self.currentSelectedHead.isLock)
	UGUIUtil.SetText(self.TextUnlock, self.currentSelectedHead.cfgInfo.LockDescribtion)
	UGUIUtil.SetText(self.TextName, self.currentSelectedHead.cfgInfo.Name)
	UGUIUtil.SetText(self.TextDes, self.currentSelectedHead.cfgInfo.Desc)
	self:PreviewingMsg()
end

function SettingChangeIconView:OnClickBtnClose()
	self:Close()
end

function SettingChangeIconView:OnClickBtnConfirm()
	if self.currentSelectedHead and self.currentSelectedHeadFrame then
		if self.currentSelectedHead.isLock == false and self.currentSelectedHeadFrame.isLock == true then
			NoticeModule.ShowNotice(21058001, function()
				self:SaveHeadAndFrame(nil, self.currentSelectedHeadFrame.cfgID)
			end, nil, self)
		elseif self.currentSelectedHead.isLock == true and self.currentSelectedHeadFrame.isLock == false then
			NoticeModule.ShowNotice(21058002, function()
				self:SaveHeadAndFrame(self.currentSelectedHead.cfgID, nil)
			end, nil, self)
		elseif self.currentSelectedHead.isLock == true and self.currentSelectedHeadFrame.isLock == true then
			self:SaveHeadAndFrame(self.currentSelectedHead.cfgID, self.currentSelectedHeadFrame.cfgID)
		end
	else
		local headID, frameID

		if self.currentSelectedHead and self.currentSelectedHead.isLock then
			headID = self.currentSelectedHead.cfgID
		end

		if self.currentSelectedHeadFrame and self.currentSelectedHeadFrame.isLock then
			frameID = self.currentSelectedHeadFrame.cfgID
		end

		self:SaveHeadAndFrame(headID, frameID)
	end
end

function SettingChangeIconView:SaveHeadAndFrame(headID, frameID)
	if headID and headID ~= PlayerModule.PlayerInfo.baseInfo.headIcon then
		SettingModule.ChangeData(SettingModule.CHANGE_PLAYER_HEAD, headID)
	end

	if frameID and frameID ~= PlayerModule.PlayerInfo.baseInfo.avatarFrame then
		SettingModule.ChangeData(SettingModule.CHANGE_PLAYER_HEAD_FRAME, frameID)
	end

	self:Close()
end

function SettingChangeIconView:OnRenderHeadFrameCell(cell)
	local goCell = cell.gameObject
	local headFrameData = self.unlockHeadFrames[cell.index + 1]

	if headFrameData == nil then
		goCell:SetActive(false)

		return
	end

	local instanceID = goCell:GetInstanceID()
	local cell = self.headFrameCellPool[instanceID]

	if cell == nil then
		cell = SettingHeadFrameCell.New(goCell, self.rootUI)
		self.headFrameCellPool[instanceID] = cell
	end

	cell:SetData(headFrameData)

	if self.currentSelectedHeadFrame == nil and cell.isCurrentSetting == true then
		self.currentSelectedHeadFrame = headFrameData
	end

	if self.currentSelectedHeadFrame ~= nil and self.currentSelectedHeadFrame.cfgID == headFrameData.cfgID then
		cell:Select(true)

		self.currentSelectedHeadFrameCell = cell
	else
		cell:Select(false)
	end
end

function SettingChangeIconView:OnSelectHeadFrameCell(cell)
	local item = cell.gameObject
	local headFrameData = self.unlockHeadFrames[cell.index + 1]
	local cell = self.headFrameCellPool[item:GetInstanceID()]

	if self.currentSelectedHeadFrameCell ~= nil then
		self.currentSelectedHeadFrameCell:Select(false)
	end

	self.currentSelectedHeadFrame = headFrameData
	self.currentSelectedHeadFrameCell = cell

	self.currentSelectedHeadFrameCell:Select(true)
	self.BtnConfirm:SetActive(self.currentSelectedHeadFrame.isLock and not self.currentSelectedHeadFrameCell.isCurrentSetting)
	self.TextUnlock:SetActive(not self.currentSelectedHeadFrame.isLock)
	UGUIUtil.SetText(self.TextUnlock, self.currentSelectedHeadFrame.cfgInfo.LockDesc)
	UGUIUtil.SetText(self.TextName, self.currentSelectedHeadFrame.cfgInfo.Name)
	UGUIUtil.SetText(self.TextDes, self.currentSelectedHeadFrame.cfgInfo.Desc)
	self:PreviewingMsg()
end

function SettingChangeIconView:OnToggleChange(isOn)
	self.isSelectFrame = isOn

	self:ShowList()
end

function SettingChangeIconView:ShowList()
	if self.isSelectFrame then
		self.GridSlot:SetActive(false)
		self.ScrollFrame:SetActive(true)

		local tabData = CfgDiscreteDataTable[6520095].Data

		self.selectGroupView:RefreshGroup(tabData)
		self:ShowFrameList()
	else
		self.GridSlot:SetActive(true)
		self.ScrollFrame:SetActive(false)

		local tabData = CfgDiscreteDataTable[6520094].Data

		self.selectGroupView:RefreshGroup(tabData)
		self:ShowHeadList()
	end
end

function SettingChangeIconView:OnSelectGroup()
	if self.isSelectFrame then
		self:ShowFrameList()
	else
		self:ShowHeadList()
	end
end

function SettingChangeIconView:PreviewingMsg()
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.currentSelectedHead.cfgInfo.Url), self.ImgHead:GetComponent("Image"))

	if self.currentSelectedHeadFrame then
		local path = UIGlobalApi.GetPrefabRoot(self.currentSelectedHeadFrame.cfgInfo.Prefab)

		AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, nil)
	end

	self.TextDate:SetActive(false)

	if self.isSelectFrame then
		if self.currentSelectedHeadFrame then
			local timeLimitHeadFrame = self.currentSelectedHeadFrame:GetTimeLimit()

			if timeLimitHeadFrame > 0 and timeLimitHeadFrame > PlayerModule.GetServerTime() then
				UGUIUtil.SetText(self.TextDate, SettingUIApi:GetString("TextData", getCustomDateTimeText(timeLimitHeadFrame, "MonthToMinuteFormat")))
				self.TextDate:SetActive(true)
			end
		end
	else
		local timeLimitHead = self.currentSelectedHead:GetTimeLimit()

		if timeLimitHead > 0 and timeLimitHead > PlayerModule.GetServerTime() then
			UGUIUtil.SetText(self.TextDate, SettingUIApi:GetString("TextData", getCustomDateTimeText(timeLimitHead, "MonthToMinuteFormat")))
			self.TextDate:SetActive(true)
		end
	end
end

function SettingChangeIconView:OnLoadSucceed(assetName, asset, duration, userData)
	for i = 0, self.ImgFrame.transform.childCount - 1 do
		local obj = self.ImgFrame.transform:GetChild(0).gameObject

		UnityEngine.GameObject.DestroyImmediate(obj)
	end

	local goFrame = UnityEngine.Object.Instantiate(asset)

	goFrame.transform:SetParent(self.ImgFrame.transform, false)
	UIUtil.InitSortedComponents(self.rootUI:GetComponent("Canvas"), goFrame)
	self:OnPlayerHeadFrameLoaded()
end

function SettingChangeIconView:OnPlayerHeadFrameLoaded()
	local mask = self.ScrollFrame:GetComponent(typeof(UnityEngine.UI.RectMask3D))

	mask:SetDirtyTarget()

	local mask = self.LeftNode:GetComponent(typeof(UnityEngine.UI.RectMask3D))

	mask:SetDirtyTarget()

	local rectMask = self.ScrollFrame:GetComponent("RectMask2D")

	rectMask.enabled = false
	rectMask.enabled = true
end

function SettingChangeIconView:Dispose()
	AssetUtil.UnloadAsset(self)
	self.selectGroupView:Dispose()
	self:Close()

	for i, v in pairs(self.headCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function SettingChangeIconView:Open()
	self.currentSelectedHeadFrame = SettingModule.GetPlayHeadFrameData(PlayerModule.PlayerInfo.baseInfo.avatarFrame)
	self.currentSelectedHead = SettingModule.GetPlayHeadData(PlayerModule.PlayerInfo.baseInfo.headIcon)

	self.rootUI:SetActive(true)
	self:AddEventListener()

	if self.Toggle:GetComponent("Toggle").isOn ~= self.isSelectFrame then
		self.Toggle:GetComponent("Toggle").isOn = self.isSelectFrame
	else
		self:ShowList()
	end
end

function SettingChangeIconView:Close()
	self.rootUI:SetActive(false)
	self:RemoveEventListener()
end

return SettingChangeIconView
