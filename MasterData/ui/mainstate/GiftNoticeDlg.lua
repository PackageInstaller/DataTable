-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\GiftNoticeDlg.lua

local strClassName = "GiftNoticeDlg"
local GiftNoticeDlg = Class(strClassName, UIControls.Panel)

function GiftNoticeDlg:ctor()
	self:initUI()

	self.isNew = false
end

function GiftNoticeDlg:initUI()
	self.btn = UIControls.Button(self, self.mPath .. "/BgPanel/BtnRecGift", "Text")

	self.btn:setText(Lang.get(30471))

	self.aniPanel = UIControls.UIAni(self, self.mPath)
	self.aniBtn = UIControls.UIAni(self, self.mPath .. "/BgPanel")

	self.btn:addEventClick(self.onClick)
end

function GiftNoticeDlg:onRefresh()
	self.actId, self.isNew = CurAvatar:getNewActivityUnlocked()

	if not self.actId or not CurAvatar:isActivityValid(self.actId) then
		self:setVisible(false)

		return
	end

	self:setVisible(true)
	self:playAnimOnShow()
end

function GiftNoticeDlg:playAnimOnShow()
	if self.isNew == true then
		self.aniPanel:startAni("ShowActivityRecGiftNotice", true)

		self.isNew = false
	end
end

function GiftNoticeDlg:onClick()
	local actObj = CurAvatar:getActivityObj(self.actId)

	if actObj and actObj:isValid() then
		if actObj:isNewOpened() then
			RPC.opActSetFocus(actObj.opId, 1)
		end

		CurAvatar:jumpToShowActivity(self.actId)
	else
		MsgManager.notice(Lang.get(1870))
	end

	CurAvatar:removeNewActivityUnlocked(self.actId)
	self:onRefresh()
end

return GiftNoticeDlg
