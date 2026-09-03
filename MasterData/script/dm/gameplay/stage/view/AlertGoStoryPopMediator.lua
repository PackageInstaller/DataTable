-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/AlertGoStoryPopMediator.lua

AlertGoStoryPopMediator = class("AlertGoStoryPopMediator", DmPopupViewMediator)

local kResponse = {
	kOK = 1,
	kCancel = 2
}

function AlertGoStoryPopMediator:initialize()
	super.initialize(self)
end

function AlertGoStoryPopMediator:dispose()
	super.dispose(self)
end

function AlertGoStoryPopMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")

	local bgNode = self._main:getChildByFullName("bg")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("UPDATE_UI7"),
		title1 = Strings:get("UITitle_EN_Tishi")
	})

	self._cancelBtn = self:bindWidget("main.btn_cancel", OneLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Cancle",
			func = bind1(self.onCancelClicked, self)
		}
	})
	self._sureBtn = self:bindWidget("main.btn_ok", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onOKClicked, self)
		}
	})
end

function AlertGoStoryPopMediator:onCancelClicked(sender, eventType)
	self:close({
		response = kResponse.kCancel
	})
end

function AlertGoStoryPopMediator:onOKClicked(sender, eventType)
	self:close({
		response = kResponse.kOK
	})
end

function AlertGoStoryPopMediator:onCloseClicked(sender, eventType)
	self:close({
		response = kResponse.kCancel
	})
end

function AlertGoStoryPopMediator:onTouchMaskLayer()
	self:close({
		response = kResponse.kCancel
	})
end
