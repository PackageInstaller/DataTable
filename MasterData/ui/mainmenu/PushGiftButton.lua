-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\PushGiftButton.lua

local PushGiftButton = Class("PushGiftButton", UIControls.Child)

function PushGiftButton:ctor()
	self.btn = UIControls.Button(self, "", "Text")
end

function PushGiftButton:setData(data)
	ClientTimerManager.RemoveSecondTickUI(self.btn)

	self.data = data
	self.remineTime = data.endTime - ClientUtils.getServerTime()

	if self.remineTime > 86400 then
		self.btn:setText(string.format(Lang.get(30022), math.floor(self.remineTime / 86400)))
	else
		ClientTimerManager.AddSecondTickUI(self.btn, self.remineTime, nil, "", "", Slot(self.timeDownCB, self))
	end

	self.btn:addEventClick(Slot(self.onBtnClick, self))
end

function PushGiftButton:onBtnClick()
	UIManager.getUI("welfarePushGiftDlg", true):setData(self.data)
end

function PushGiftButton:timeDownCB()
	self:setVisible(false)
end

return PushGiftButton
