-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\EquipRecycle\\ActivityEquipRecycleInitialDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ActivityEquipRecycleMainDlg = Class("ActivityEquipRecycleMainDlg", UIControls.Window)

MixinClass(ActivityEquipRecycleMainDlg, ActivityPanelMixin)

function ActivityEquipRecycleMainDlg:ctor()
	return
end

function ActivityEquipRecycleMainDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.txtTime = UIControls.Label(self, "MainInfoPanel/BgTime/TextTime")
	self.equipRecyclePanel = UIControls.Panel(self, "MainInfoPanel/EquipRecyclePanel")
	self.braceletExchangePanel = UIControls.Panel(self, "MainInfoPanel/BraceletExchangePanel")
	self.btnEquipRecycleLock = UIControls.Button(self, "MainInfoPanel/EquipRecyclePanel/BtnLock")

	self.btnEquipRecycleLock:addEventClick(self.onBtnEquipRecycleLockClick)

	self.btnBraceletExchangeLock = UIControls.Button(self, "MainInfoPanel/BraceletExchangePanel/BtnLock")

	self.btnBraceletExchangeLock:addEventClick(self.onBtnBraceletExchangeLockClick)

	self.btnEquipRecycleUnlock = UIControls.Button(self, "MainInfoPanel/EquipRecyclePanel/BtnUnlock")

	self.btnEquipRecycleUnlock:addEventClick(self.onBtnEquipRecycleUnlockClick)

	self.btnBraceletExchangeUnlock = UIControls.Button(self, "MainInfoPanel/BraceletExchangePanel/BtnUnlock")

	self.btnBraceletExchangeUnlock:addEventClick(self.onBtnBraceletExchangeUnlockClick)

	self.iconNew = UIControls.RedDot(self, "MainInfoPanel/EquipRecyclePanel/BtnUnlock/IconNew")
end

function ActivityEquipRecycleMainDlg:_onShow()
	self:setData()
end

function ActivityEquipRecycleMainDlg:setData(...)
	if self.actObj then
		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, self.actObj:getRemainOpenTime(), false, Lang.get(48655), Slot(self._timerOver, self))

		self.actData = self.actObj.actData

		if not self.actData:checkOpenRecycleSystem() then
			self.canRecycle = true
		else
			self.canRecycle = false
		end

		if self.canRecycle then
			self.equipRecyclePanel:playStateAnimator("RecycleUnlock", true)
			self.braceletExchangePanel:playStateAnimator("ExchangeUnlock", true)
		else
			self.equipRecyclePanel:playStateAnimator("RecycleLock", true)
			self.braceletExchangePanel:playStateAnimator("ExchangLock", true)
		end

		self.iconNew:addHint({
			UIConst.RD_HINT_EQUIP_RECYCLE_AWARD
		})
	end
end

function ActivityEquipRecycleMainDlg:onBtnCloseClick()
	self:setVisible(false)
end

function ActivityEquipRecycleMainDlg:onBtnEquipRecycleUnlockClick()
	UIManager.getUI("activityEquipRecycleDlg", true):setData(self.actData)
end

function ActivityEquipRecycleMainDlg:onBtnBraceletExchangeUnlockClick()
	if self.actData then
		local itemId, itemNum = self.actData:getExchangeItemData()

		UIManager.getUI("activityBraceletExchangeDlg", true):setData(itemId)
	end
end

function ActivityEquipRecycleMainDlg:onBtnEquipRecycleLockClick()
	if self.actData then
		local hint = self.actData:getLimitDesc()

		if hint then
			MsgManager.notice(hint)
		end
	end
end

function ActivityEquipRecycleMainDlg:onBtnBraceletExchangeLockClick()
	MsgManager.notice(Lang.get(101573))
end

return ActivityEquipRecycleMainDlg
