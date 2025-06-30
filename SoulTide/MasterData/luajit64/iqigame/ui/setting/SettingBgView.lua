-- chunkname: @IQIGame\\UI\\Setting\\SettingBgView.lua

local SettingBgView = {}
local SettingLoginBgCell = require("IQIGame.UI.Setting.SettingLoginBgCell")

function SettingBgView.__New(ui)
	local o = Clone(SettingBgView)

	o:InitView(ui)

	return o
end

function SettingBgView:InitView(ui)
	self.rootUI = ui

	self.rootUI:SetActive(false)
	LuaCodeInterface.BindOutlet(self.rootUI, self)

	self.TextTitle:GetComponent("Text").text = SettingBgViewApi:GetString("TextTitle")
	self.TextTitle1:GetComponent("Text").text = SettingBgViewApi:GetString("TextTitle1")
	self.btnSureComponent = self.BtnSure:GetComponent("Button")

	function self.delegateClickBtnSure()
		self:OnClickBtnSure()
	end

	function self.delegateUpdateItem(cell)
		self:OnUpdateItem(cell)
	end

	function self.delegateSelectedItem(cell)
		self:OnSelectedItem(cell)
	end

	local uPid = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.UserPID)
	local cid = PlayerPrefsUtil.GetString(uPid, Constant.PlayerPrefsConst.UserLoginBG)

	if cid == "" or cid == nil then
		cid = SettingModule.currentBG

		PlayerPrefsUtil.SetString(uPid, Constant.PlayerPrefsConst.UserLoginBG, cid)
	end

	self:AddEventListener()
end

function SettingBgView:AddEventListener()
	self.btnSureComponent.onClick:AddListener(self.delegateClickBtnSure)
end

function SettingBgView:RemoveEventListener()
	self.btnSureComponent.onClick:RemoveListener(self.delegateClickBtnSure)
end

function SettingBgView:UpDateView()
	self.loginBgs = SettingModule.loginBgs

	local wrapContent = self.GridSlot:GetComponent("ScrollAreaList")

	wrapContent.onRenderCell = self.delegateUpdateItem
	wrapContent.onSelectedCell = self.delegateSelectedItem

	wrapContent:Refresh(#self.loginBgs)
end

function SettingBgView:OnUpdateItem(cell)
	local bgData = self.loginBgs[cell.index + 1]
	local item = cell.gameObject

	if bgData == nil then
		item:SetActive(false)

		return
	end

	local itemCell = SettingLoginBgCell.PackageOrReuseView(self, item)

	itemCell:SetItem(bgData)

	local uPid = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.UserPID)
	local cid = PlayerPrefsUtil.GetString(uPid, Constant.PlayerPrefsConst.UserLoginBG)

	if cid == bgData.cfgID then
		itemCell:SetSelected(true)
	else
		itemCell:SetSelected(false)
	end
end

function SettingBgView:OnSelectedItem(cell)
	local item = cell.gameObject
	local itemCell = SettingLoginBgCell.PackageOrReuseView(self, item)
	local bgData = self.loginBgs[cell.index + 1]

	itemCell:SetItem(bgData)

	if self.currentSelectCell ~= nil then
		self.currentSelectCell:SetSelected(false)
	end

	self.currentSelectCell = itemCell

	self.currentSelectCell:SetSelected(true)
end

function SettingBgView:OnClickBtnSure()
	if self.currentSelectCell == nil then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, SettingBgViewApi:GetString("ErrorMsg"))

		return
	end

	if self.currentSelectCell.loginBgData.isLock == false then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, SettingBgViewApi:GetString("ErrorMsg1"))

		return
	end

	local uPid = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.UserPID)

	PlayerPrefsUtil.SetString(uPid, Constant.PlayerPrefsConst.UserLoginBG, self.currentSelectCell.loginBgData.cfgID)
	NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, SettingBgViewApi:GetString("Msg"))
	self:UpDateView()
end

function SettingBgView:Dispose()
	self:Close()
	self:RemoveEventListener()
	SettingLoginBgCell.DisposeIn(self)
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function SettingBgView:Open()
	self.rootUI:SetActive(true)
	self:UpDateView()
end

function SettingBgView:Close()
	self.rootUI:SetActive(false)
end

return SettingBgView
