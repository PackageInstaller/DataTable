-- chunkname: @IQIGame\\UI\\Guild\\GuildEdit\\GuildEditSettingView.lua

local m = {
	isSelectFrame = false,
	unlockHeadFrames = {},
	unlockHeadIcons = {},
	headCellPool = {},
	headFrameCellPool = {}
}
local GuildHeadCell = require("IQIGame.UI.Guild.GuildMain.GuildHeadCell")
local GuildSettingHeadCell = require("IQIGame.UI.Guild.GuildEdit.GuildSettingHeadCell")
local GuildSettingFrameCell = require("IQIGame.UI.Guild.GuildEdit.GuildSettingFrameCell")
local GuildHeadIconData = require("IQIGame.Module.Guild.GuildHeadIconData")
local GuildAvatarFrameData = require("IQIGame.Module.Guild.GuildAvatarFrameData")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	local guildHeadScroll = self.ScrollHead:GetComponent("ScrollAreaList")

	function guildHeadScroll.onRenderCell(cell)
		self:OnRenderHeadCell(cell)
	end

	function guildHeadScroll.onSelectedCell(cell)
		self:OnSelectedHeadCell(cell)
	end

	local guildHeadFrameScroll = self.ScrollFrame:GetComponent("ScrollAreaList")

	function guildHeadFrameScroll.onRenderCell(cell)
		self:OnRenderHeadFrameCell(cell)
	end

	function guildHeadFrameScroll.onSelectedCell(cell)
		self:OnSelectHeadFrameCell(cell)
	end

	function self.DelegateBtnBack()
		self:OnBtnBack()
	end

	function self.DelegateOnToggleChange(isOn)
		self:OnToggleChange(isOn)
	end

	function self.DelegateBtnChange()
		self:OnBtnChange()
	end

	self.guildHeadCell = GuildHeadCell.New(self.GuildHead)
end

function m:AddListener()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateBtnBack)
	self.BtnChange:GetComponent("Button").onClick:AddListener(self.DelegateBtnChange)
	self.SelectToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnToggleChange)
end

function m:RemoveListener()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnBack)
	self.BtnChange:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnChange)
	self.SelectToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnToggleChange)
end

function m:OnBtnBack()
	self:Close()
end

function m:OnToggleChange(isOn)
	self.isSelectFrame = isOn

	self:ShowList()
end

function m:OnBtnChange()
	local headData = GuildHeadIconData.New(self.currentSelectedHead)
	local headFrameData = GuildAvatarFrameData.New(self.currentSelectedFrameData)

	if headData.unLock == 0 or headFrameData.unLock == 0 then
		NoticeModule.ShowNotice(21066708)

		return
	end

	GuildModule.EditInfo(self.currentSelectedHead, self.currentSelectedFrameData, GuildModule.guildPOD.base.policy, GuildModule.guildPOD.base.auditType)
end

function m:ShowList()
	if self.isSelectFrame then
		self.ScrollHead:SetActive(false)
		self.ScrollFrame:SetActive(true)
		self:ShowFrameList()
	else
		self.ScrollHead:SetActive(true)
		self.ScrollFrame:SetActive(false)
		self:ShowHeadList()
	end

	self:ShowDes()
end

function m:OnRenderHeadCell(cell)
	local goCell = cell.gameObject
	local headData = self.unlockHeadIcons[cell.index + 1]

	if headData == nil then
		goCell:SetActive(false)

		return
	end

	local instanceID = goCell:GetInstanceID()
	local cell = self.headCellPool[instanceID]

	if cell == nil then
		cell = GuildSettingHeadCell.New(goCell)
		self.headCellPool[instanceID] = cell
	end

	cell:SetData(headData)

	local isPutOn = GuildModule.guildPOD.base.headIcon == headData.cfgID

	cell:SetCurrentPutOn(isPutOn)

	if self.currentSelectedHead == nil and cell.isCurrentSetting == true then
		self.currentSelectedHead = headData.cfgID
	end

	if self.currentSelectedHead ~= nil and self.currentSelectedHead == headData.cfgID then
		cell:Select(true)

		self.currentSelectedHeadCell = cell
	else
		cell:Select(false)
	end
end

function m:OnSelectedHeadCell(cell)
	local item = cell.gameObject
	local headData = self.unlockHeadIcons[cell.index + 1]
	local cell = self.headCellPool[item:GetInstanceID()]

	cell:SetData(headData)

	if self.currentSelectedHeadCell ~= nil then
		self.currentSelectedHeadCell:Select(false)
	end

	self.currentSelectedHead = headData.cfgID
	self.currentSelectedHeadCell = cell

	self.currentSelectedHeadCell:Select(true)
	self:UpdateView()
end

function m:OnRenderHeadFrameCell(cell)
	local goCell = cell.gameObject
	local headFrameData = self.unlockHeadFrames[cell.index + 1]

	if headFrameData == nil then
		goCell:SetActive(false)

		return
	end

	local instanceID = goCell:GetInstanceID()
	local cell = self.headFrameCellPool[instanceID]

	if cell == nil then
		cell = GuildSettingFrameCell.New(goCell)
		self.headFrameCellPool[instanceID] = cell
	end

	cell:SetData(headFrameData)

	local isPutOn = GuildModule.guildPOD.base.avatarFrame == headFrameData.cfgID

	cell:SetCurrentPutOn(isPutOn)

	if self.currentSelectedFrameData == nil and cell.isCurrentSetting == true then
		self.currentSelectedFrameData = headFrameData.cfgID
	end

	if self.currentSelectedFrameData ~= nil and self.currentSelectedFrameData == headFrameData.cfgID then
		cell:Select(true)

		self.currentSelectedHeadFrameCell = cell
	else
		cell:Select(false)
	end
end

function m:OnSelectHeadFrameCell(cell)
	local item = cell.gameObject
	local headFrameData = self.unlockHeadFrames[cell.index + 1]
	local cell = self.headFrameCellPool[item:GetInstanceID()]

	cell:SetData(headFrameData)

	if self.currentSelectedHeadFrameCell ~= nil then
		self.currentSelectedHeadFrameCell:Select(false)
	end

	self.currentSelectedFrameData = headFrameData.cfgID
	self.currentSelectedHeadFrameCell = cell

	self.currentSelectedHeadFrameCell:Select(true)
	self:UpdateView()
end

function m:ShowFrameList()
	self.unlockHeadFrames = GuildModule.GetUnlockGuildFrames()

	self.ScrollFrame:GetComponent("ScrollAreaList"):Refresh(#self.unlockHeadFrames)
end

function m:ShowHeadList()
	self.unlockHeadIcons = GuildModule.GetUnlockGuildHeadIcons()

	self.ScrollHead:GetComponent("ScrollAreaList"):Refresh(#self.unlockHeadIcons)
end

function m:UpdateView()
	if self.currentSelectedHead == nil then
		self.currentSelectedHead = GuildModule.guildPOD.base.headIcon
	end

	if self.currentSelectedFrameData == nil then
		self.currentSelectedFrameData = GuildModule.guildPOD.base.avatarFrame
	end

	if self.SelectToggle:GetComponent("Toggle").isOn ~= self.isSelectFrame then
		self.SelectToggle:GetComponent("Toggle").isOn = self.isSelectFrame
	else
		self:ShowList()
	end

	self.guildHeadCell:SetData(self.currentSelectedHead, self.currentSelectedFrameData, GuildModule.guildPOD.base.level)
	self:ShowDes()
end

function m:ShowDes()
	local name = ""
	local des = ""

	if self.isSelectFrame then
		if self.currentSelectedFrameData then
			local cfgData = CfgGuildAvatarFrameTable[self.currentSelectedFrameData]
			local headFrameData = GuildAvatarFrameData.New(self.currentSelectedFrameData)

			name = cfgData.Name

			if headFrameData.unLock == 1 then
				des = cfgData.Desc
			else
				des = cfgData.LockDesc
			end
		end
	elseif self.currentSelectedHead then
		local cfgData = CfgGuildHeadIconTable[self.currentSelectedHead]
		local headData = GuildHeadIconData.New(self.currentSelectedHead)

		name = cfgData.Name

		if headData.unLock == 1 then
			des = cfgData.Desc
		else
			des = cfgData.LockDescribtion
		end
	end

	UGUIUtil.SetText(self.TextName, name)
	UGUIUtil.SetText(self.TextDes, des)
end

function m:Open()
	self:AddListener()
	self.View:SetActive(true)
	self:UpdateView()
end

function m:Close()
	self:RemoveListener()
	self.View:SetActive(false)
end

function m:Dispose()
	self:Close()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
