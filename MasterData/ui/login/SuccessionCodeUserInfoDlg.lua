-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\SuccessionCodeUserInfoDlg.lua

local SuccessionCodeUserInfoDlg = Class("SuccessionCodeUserInfoDlg", UIControls.Child)

function SuccessionCodeUserInfoDlg:ctor()
	self.serverText = UIControls.Label(self, "ServerPanel/Text")
	self.nameText = UIControls.Label(self, "NamePanel/Text")
	self.lvText = UIControls.Label(self, "LvPanel/Text")
	self.btnConfirm = UIControls.Button(self, "BtnPanel/BtnConfirm")
	self.btnConfirmText = UIControls.Label(self, "BtnPanel/BtnConfirm/Text")
end

function SuccessionCodeUserInfoDlg:setRoleInfoPanel(serverName, roleName, roleLv, sdkUid, callback)
	self.serverText:setText(serverName)
	self.nameText:setText(roleName)
	self.lvText:setText(roleLv)
	self.btnConfirmText:setText("データ復元")

	if callback == nil then
		self.btnConfirm:setVisible(false)
	else
		self.btnConfirm:addEventClick(Functor(self.onConfirmClick, self, sdkUid, callback))
	end
end

function SuccessionCodeUserInfoDlg:onConfirmClick(sdkUid, callback)
	local successionCodeBindDlg = UIManager.getUI("successionCodeBindDlg")

	if successionCodeBindDlg then
		successionCodeBindDlg:hide()
	end

	local function yesFunc()
		if callback ~= nil then
			callback(sdkUid)
			SDKAgent.reopenBindUI()
		else
			print("callback is nil")
		end
	end

	local function noFunc()
		SDKAgent.reopenBindUI()
	end

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(1793), "このキャラクターデータを復元しますか？", yesFunc, noFunc, nil, Lang.get(104), Lang.get(7))
end

return SuccessionCodeUserInfoDlg
