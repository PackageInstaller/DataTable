-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\MainMenuButton.lua

local EventConst = require("EventConst")
local MainMenuButton = Class("MainMenuButton", UIControls.Button)

function MainMenuButton:ctor(parent, path, textPath, canEmoji)
	self:addEventClick(self.onClick)

	if UIControls.checkControlFunc(parent, path .. "Dis") then
		self.dis = UIControls.Button(parent, path .. "Dis")

		self.dis:addEventClick(self.onClickDis)

		if UIControls.checkControlFunc(parent, path .. "Dis/TextLock") then
			self.textLock = UIControls.Label(self, path .. "Dis/TextLock")
		end
	end

	self.slotOfConditionChange = Slot(self.checkCondition, self)
end

function MainMenuButton:setting(redDotIDs, conditionID, connectUI, doUIFunc, doFuncName)
	if redDotIDs then
		if UIControls.checkControlFunc(self.mParent, self.mPath .. "/IconNew") then
			self.redDot = UIControls.RedDot(self.mParent, self.mPath .. "/IconNew")

			self.redDot:addHint(redDotIDs)
		end

		self.redDotIDs = redDotIDs
	end

	self._conditionID = conditionID

	if self.dis then
		self.dis._conditionID = conditionID
	end

	self._uiName = connectUI
	self._uiFunc = doUIFunc
	self._doFuncName = doFuncName

	self:checkCondition()
	self:bindCondition()
end

function MainMenuButton:setRedHintState(isShow)
	if self.redDot then
		if isShow then
			if self.redDotIDs then
				self.redDot:addHint(self.redDotIDs)
			end
		else
			self.redDot:clearHint()
		end
	end
end

function MainMenuButton:bindCondition()
	if not self.registered and self._conditionID then
		EventCenter.addEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfConditionChange, self._conditionID)

		self.registered = true
	end
end

function MainMenuButton:clearCondition()
	if self.registered and self._conditionID then
		EventCenter.removeEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfConditionChange, self._conditionID)

		self.registered = false
	end
end

function MainMenuButton:checkCondition()
	if not self._conditionID then
		return
	elseif self._conditionID == 70 then
		self:setVisible(#CurAvatar.getPushGift() > 0)
	elseif self._conditionID == 71 then
		self:setVisible(#CurAvatar.getPushGift() > 1)
	end

	local isLocked = ConditionLimitManager.inLimitState(self._conditionID)

	self:setVisible(not isLocked)

	if self.dis then
		self.dis:setVisible(isLocked)

		if isLocked and self.textLock then
			self.textLock:setText(ConditionLimitManager.getLimitUnlockDesc(self._conditionID, true))
		end
	end
end

function MainMenuButton:onClick(sender)
	if sender._uiName then
		local ui = UIManager.getUI(sender._uiName, true)

		if ui and sender._uiFunc then
			ui[sender._uiFunc](ui)
		end
	end

	if sender._doFuncName and sender.mParent[sender._doFuncName] then
		sender.mParent[sender._doFuncName](sender.mParent, sender)
	end
end

function MainMenuButton:onClickDis(sender)
	local hint = ConditionLimitManager.getLimitUnlockDesc(sender._conditionID)

	if hint and hint ~= "" then
		MsgManager.notice(hint)
	end
end

return MainMenuButton
