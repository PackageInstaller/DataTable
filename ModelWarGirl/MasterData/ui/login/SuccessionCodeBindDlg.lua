-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\SuccessionCodeBindDlg.lua

local strClassName = "SuccessionCodeBindDlg"
local SuccessionCodeBindDlg = Class(strClassName, UIControls.Window)
local successionCodeUserInfoDlg = require("UI/Login/SuccessionCodeUserInfoDlg")
local UIControls = require("UI/UIControls")
local SDKConst = require("SDK/SDKConst")
local SDKCore = require("SDK/SDKCore")
local UserData = require("Helper/UserData")
local UrlConfig = require("Network/UrlConfig")
local OpenServerHelper = require("Network/OpenServerHelper")
local DeviceHelper = require("Helper/DeviceHelper")
local ResponseCode = SDKConst.ResponseCode

function SuccessionCodeBindDlg:ctor()
	self.textTitle = UIControls.Label(self, "Bg/TextTitle")
	self.bindTitle = UIControls.Label(self, "Bg/ConfirmPanel/TextTitle")
	self.bindTip = UIControls.Label(self, "Bg/ConfirmPanel/TextTips")
	self.roleInfoScrollview = UIControls.ScrollViewLoopV(self, "Bg/ConfirmPanel/InfoList")
	self.btnConfirm = UIControls.Button(self, "Bg/ConfirmPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self._giveUpBind)

	self.roleList = {}
end

function SuccessionCodeBindDlg:tryShow(data)
	local userPass = UserData.loadCommonData("flow_new_jp_bind_pass" .. CurAvatar.uid)

	if userPass == "1" then
		Framework.Tools.LuaToolkit.LogEx("--flow user choosed pass already:" .. CurAvatar.uid)
		self:setVisible(false)

		return
	end

	local info = ClientUtils.string2Table(data)

	self.roleList = info.data.items

	Framework.Tools.LuaToolkit.LogEx("--flow try show bind role with CurAvatar.uid:" .. CurAvatar.uid)

	for key, value in pairs(self.roleList) do
		if value.new_role_id ~= "" and tonumber(CurAvatar.uid) == tonumber(value.new_role_id) then
			self:setVisible(false)
			Framework.Tools.LuaToolkit.LogEx("--flow find bind data, pass and let play.")

			return
		end
	end

	if not self:getVisible() and next(self.roleList) ~= nil then
		self:initRolePanel()
	else
		self:setVisible(false)
		Framework.Tools.LuaToolkit.LogEx("--flow roleList is empty pass.")
	end
end

function SuccessionCodeBindDlg:hide()
	if self:getVisible() then
		self:setVisible(false)
	end
end

function SuccessionCodeBindDlg:initRolePanel()
	local roleInfoPanel = {}
	local roleName
	local showIndex = 0

	roleInfoPanel[0] = successionCodeUserInfoDlg(self, "Bg/ConfirmPanel/InfoList/Content", "System/Login/AccountInputCodeInfoCell", 0, 0, true)

	roleInfoPanel[0]:setRoleInfoPanel("Server", "Name", "Level", "ID", nil)

	for key, value in pairs(self.roleList) do
		print(key, ClientUtils.table2String(value))

		roleName = utils.splitString(value.role_name, "-")[2]

		if value.new_role_id == "" then
			showIndex = showIndex + 1

			if roleName ~= "" then
				roleInfoPanel[key] = successionCodeUserInfoDlg(self, "Bg/ConfirmPanel/InfoList/Content", "System/Login/AccountInputCodeInfoCell", 0, 0, true)

				roleInfoPanel[key]:setRoleInfoPanel(value.server_name, roleName, value.level, value.role_id, Slot(self.bindJapanOldRole, self))
			else
				roleInfoPanel[key] = successionCodeUserInfoDlg(self, "Bg/ConfirmPanel/InfoList/Content", "System/Login/AccountInputCodeInfoCell", 0, 0, true)

				roleInfoPanel[key]:setRoleInfoPanel(value.server_name, Lang.get(655), value.level, value.role_id, Slot(self.bindJapanOldRole, self))
			end
		end
	end

	if showIndex == 0 then
		Framework.Tools.LuaToolkit.LogEx("--flow all role is bind")
		self:setVisible(false)
	else
		Framework.Tools.LuaToolkit.LogEx("--flow role left to bind " .. showIndex)
		self:setVisible(true)
	end
end

function SuccessionCodeBindDlg:bindJapanOldRole(uid)
	local token = UserData.loadCommonData("jp_login_token")
	local dataBind = {}

	dataBind.acctype = AccountManager.accType
	dataBind.accid = SDKAgent.getUserID()
	dataBind.old_uid = tonumber(uid)
	dataBind.new_uid = tonumber(CurAvatar.uid)
	dataBind.token = token

	Framework.Tools.LuaToolkit.LogEx("--flow bind data:" .. ClientUtils.table2String(dataBind))

	local url = UrlConfig.BindRole

	OpenServerHelper.httpPost(url, dataBind, Slot(self._bindCallback, self), 3)
end

function SuccessionCodeBindDlg:_bindCallback(succ, data)
	Framework.Tools.LuaToolkit.LogEx("--flow bind response:" .. succ .. "|" .. data)

	if string.find(data, "error") then
		local function yesFunc()
			SDKAgent.reopenBindUI()
		end

		local successionCodeBindDlg = UIManager.getUI("successionCodeBindDlg")

		if successionCodeBindDlg then
			successionCodeBindDlg:hide()
		end

		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(1793), "キャラクターデータの復元に失敗しました。もう一度お試しください。", yesFunc, nil, nil)
	else
		Framework.Tools.LuaToolkit.LogEx("--flow bind succ and logout")
		Framework.SDK.U3DOceanSDK.QuitApplication()
	end
end

function SuccessionCodeBindDlg:_giveUpBind()
	self:setVisible(false)

	local function yesFunc()
		UserData.saveCommonData("flow_new_jp_bind_pass" .. CurAvatar.uid, "1")
	end

	local function noFunc()
		SDKAgent.reopenBindUI()
	end

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(1793), "復元を諦めることにしますか？\n（諦める後、他のサーバーで再び復元を選択することができます）", yesFunc, noFunc, nil, Lang.get(104), Lang.get(7))
end

return SuccessionCodeBindDlg
