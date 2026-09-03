-- chunkname: @/tmp/or_script/lua_compile/dm/utils/EasyTab.lua

EasyTab = class("EasyTab", objectlua.Object)

local clickType = {
	moved = 1,
	began = 0,
	canceled = 3,
	ended = 2
}

function EasyTab:initialize(data)
	super.initialize(self)

	self._buttons = data.buttons
	self._defultIndex = data.defultIndex or 1
	self._buttonClick = data.buttonClick
	self._clickType = data.clicType or clickType.began
	self._delegate = data.delegate
	self._clickSound = data.sound or "Se_Click_Common_1"

	self:initButtons()
end

function EasyTab:initButtons()
	self._buttons[self._defultIndex]:setEnabled(false)

	for key, button in pairs(self._buttons) do
		button:addTouchEventListener(function(sender, eventType)
			if self._buttonClick and eventType == self._clickType then
				if self._delegate then
					self._buttonClick(self._delegate, sender, eventType, key)
				else
					self._buttonClick(sender, eventType, key)
				end

				self:buttonClick(sender)
			end
		end)
	end
end

function EasyTab:buttonClick(button)
	for i, v in pairs(self._buttons) do
		v:setEnabled(button ~= v)
	end
end

function EasyTab:setCurrentSelectButtonByIndex(index)
	self:buttonClick(self._buttons[index])
end

function EasyTab:playSound()
	AudioEngine:getInstance():playEffect(options.clickAudio, false)
end
