-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityEquipRefineDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local strClassName = "ActivityEquipRefineDlg"
local ActivityEquipRefineDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityEquipRefineDlg, ActivityPanelMixin)

function ActivityEquipRefineDlg:ctor()
	return
end

function ActivityEquipRefineDlg:initUI()
	self.textTime = UIControls.Label(self, "MainInfoPanel/BgTime/TextTime")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.textServeTimes = UIControls.Label(self, "MainInfoPanel/BgServeTimes/TextServeTimes")
	self.textChat = UIControls.Label(self, "MainInfoPanel/BgChat/TextChat")
	self.btnEquipCustom = UIControls.Button(self, "MainInfoPanel/BtnEquipCustom")

	self.btnEquipCustom:addEventClick(self.onBtnMakeClick)

	self.btnEquipWash = UIControls.Button(self, "MainInfoPanel/BtnEquipWash")

	self.btnEquipWash:addEventClick(self.onBtnReformClick)

	self.unLockMakePanel = UIControls.Panel(self, "MainInfoPanel/BtnEquipCustom/UnLockPanel")
	self.lockMakePanel = UIControls.Panel(self, "MainInfoPanel/BtnEquipCustom/LockPanel")
	self.textMakeUnLockDes = UIControls.Label(self, "MainInfoPanel/BtnEquipCustom/UnLockPanel/BgDes/TextDes")
	self.textMakeRule = UIControls.Label(self, "MainInfoPanel/BtnEquipCustom/LockPanel/BgRule/TextRule")
	self.textMakeLockDes = UIControls.Label(self, "MainInfoPanel/BtnEquipCustom/LockPanel/BgDes/TextDes")
	self.unLockReformPanel = UIControls.Panel(self, "MainInfoPanel/BtnEquipWash/UnLockPanel")
	self.lockReformPanel = UIControls.Panel(self, "MainInfoPanel/BtnEquipWash/LockPanel")
	self.textReformUnLockDes = UIControls.Label(self, "MainInfoPanel/BtnEquipWash/UnLockPanel/BgDes/TextDes")
	self.textReformRule = UIControls.Label(self, "MainInfoPanel/BtnEquipWash/LockPanel/BgRule/TextRule")
	self.textReformLockDes = UIControls.Label(self, "MainInfoPanel/BtnEquipWash/LockPanel/BgDes/TextDes")
end

function ActivityEquipRefineDlg:_onShow()
	self.actObj:checkNew()
end

function ActivityEquipRefineDlg:_setData()
	self.actData = self.actObj.actData
	self.actData.isOpenActDlg = true

	self:checkNotice()

	if self.actData.miscData.make_limit_id and ConditionLimitManager.inLimitState(self.actData.miscData.make_limit_id) then
		self.lockMakePanel:setVisible(true)
		self.unLockMakePanel:setVisible(false)
		self.textMakeRule:setText(ClientUtils.getClientNotice(726))
		self.textMakeLockDes:setText(ClientUtils.getClientNotice(734))
	else
		self.lockMakePanel:setVisible(false)
		self.unLockMakePanel:setVisible(true)
		self.textMakeUnLockDes:setText(ClientUtils.getClientNotice(734))
	end

	if self.actData.miscData.baptize_limit_id and ConditionLimitManager.inLimitState(self.actData.miscData.baptize_limit_id) then
		self.unLockReformPanel:setVisible(false)
		self.lockReformPanel:setVisible(true)
		self.textReformRule:setText(ClientUtils.getClientNotice(727))
		self.textReformLockDes:setText(ClientUtils.getClientNotice(735))
	else
		self.unLockReformPanel:setVisible(true)
		self.lockReformPanel:setVisible(false)
		self.textReformUnLockDes:setText(ClientUtils.getClientNotice(735))
	end

	self.textServeTimes:setText(string.format(Lang.get(89827), self.actData.remainCount))
	self.textChat:setText(ClientUtils.getClientNotice(736))
end

function ActivityEquipRefineDlg:checkNotice()
	local time = self.actObj:getRemainOpenTime()

	if self.actData.equipMakeData.resid ~= 0 then
		UIManager.getUI("activityEquipMakeDlg", true):setData(self.actObj)

		if time <= 86400 then
			UIManager.showConfirmWithId(1100)
		end

		self:setVisible(false)
	elseif self.actData.equipReformData.gid ~= "0" then
		UIManager.getUI("activityEquipReformDlg", true):setData(self.actObj)

		if time <= 86400 then
			UIManager.showConfirmWithId(1101)
		end

		self:setVisible(false)
	end
end

function ActivityEquipRefineDlg:onBtnMakeClick()
	if self.actData.miscData.make_limit_id and ConditionLimitManager.inLimitState(self.actData.miscData.make_limit_id) then
		MsgManager.notice(ClientUtils.getClientNotice(726))
	elseif self.actData.remainCount > 0 then
		UIManager.getUI("activityEquipMakeDlg", true):setData(self.actObj)
	else
		MsgManager.notice(ClientUtils.getClientNotice(725))
	end
end

function ActivityEquipRefineDlg:onBtnReformClick()
	if self.actData.miscData.baptize_limit_id and ConditionLimitManager.inLimitState(self.actData.miscData.baptize_limit_id) then
		MsgManager.notice(ClientUtils.getClientNotice(727))
	elseif self.actData.remainCount > 0 then
		UIManager.getUI("activityEquipReformDlg", true):setData(self.actObj)
	else
		MsgManager.notice(ClientUtils.getClientNotice(725))
	end
end

function ActivityEquipRefineDlg:onBtnCloseClick()
	self:setVisible(false)
end

return ActivityEquipRefineDlg
