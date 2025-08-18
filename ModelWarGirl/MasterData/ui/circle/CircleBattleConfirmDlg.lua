-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleConfirmDlg.lua

local FlyIconUtils = require("UI/Common/FlyIconUtils")
local strClassName = "CircleBattleConfirmDlg"
local ICON_PATH = "Atlas/CircleBattleAtlas/CircleBattleSceneAtlas2"
local CircleBattleConfirmDlg = Class(strClassName, UIControls.Window)

function CircleBattleConfirmDlg:ctor(...)
	self:initUI()
end

function CircleBattleConfirmDlg:initUI(...)
	self.imgType = UIControls.Image(self, "BgPanel/Bg")
	self.imgBgType = UIControls.Image(self, "BgPanel/BgType")
	self.txtDes = UIControls.Label(self, "BgPanel/TextDes")
	self.btnCancel = UIControls.Button(self, "BgPanel/BtnDeny")

	self.btnCancel:addEventClick(self.onBtnCancelClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)
end

function CircleBattleConfirmDlg:setData(info, callBack)
	local type = info.type

	self.type = type

	local content

	if type == Const.CIRCLE_BATTLE_SHOW_TYPE.END then
		self.btnCancel:setVisible(false)

		content = ClientUtils.getClientNotice(544)
	elseif type == Const.CIRCLE_BATTLE_SHOW_TYPE.BOSS then
		content = ClientUtils.getClientNotice(545)
	elseif type == Const.CIRCLE_BATTLE_SHOW_TYPE.BOX then
		if info.boxNum == info.totalBoxNum then
			content = ClientUtils.getClientNotice(546)
		else
			local desc = ClientUtils.getClientNotice(547)

			content = utils.format(desc, info.boxNum, info.totalBoxNum - info.boxNum)
		end
	end

	self.imgType:setImage(ICON_PATH, "BgMain0" .. (type or 1))
	self.imgBgType:setImage(ICON_PATH, "BgPic0" .. (type or 1))

	if not self.child then
		self.child = UIControls.Child(self, "BgPanel/BgType", "System/CircleBattle/CircleBattleConfirmType" .. (type or 1), 0, 0, true)
	end

	self.txtDes:setText(content)

	self.callBack = callBack
end

function CircleBattleConfirmDlg:onBtnConfirmClick(...)
	self:setVisible(false)

	if self.callBack then
		self.callBack(true)
	end
end

function CircleBattleConfirmDlg:onBtnCancelClick(...)
	self:setVisible(false)

	if self.callBack then
		self.callBack(false)
	end
end

function CircleBattleConfirmDlg:destroy(...)
	CircleBattleConfirmDlg.super.destroy(self)

	local ui = UIManager.tryGetUI("circleBattleMainDlg")

	if not ui then
		return
	end
end

return CircleBattleConfirmDlg
