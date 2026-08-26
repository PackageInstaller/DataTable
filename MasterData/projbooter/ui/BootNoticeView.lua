-- chunkname: @projbooter/ui/BootNoticeView.lua

module("projbooter.ui.BootNoticeView", package.seeall)

local BootNoticeView = class("BootNoticeView")

function BootNoticeView:init(callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj
	self._go = BootResMgr.instance:getNoticeViewGo()

	self._go:SetActive(true)

	self._rootTr = self._go.transform

	local txtType = typeof(UnityEngine.UI.Text)

	self._txtTitle = self._rootTr:Find("top/title"):GetComponent(txtType)
	self._txtContent = self._rootTr:Find("#scroll_desc/viewport/content/desc"):GetComponent(txtType)
	self._btnGo = self._rootTr:Find("btnOk").gameObject
	self._okBtn = SLFramework.UGUI.ButtonWrap.Get(self._btnGo)

	self._okBtn:AddClickListener(self._onClickOkBtn, self)
	self._go.transform:SetAsLastSibling()
	self:_setNotice()
end

function BootNoticeView:_setNotice()
	self._txtTitle.text = NoticeModel.instance:getBeforeLoginNoticeTitle()
	self._txtContent.text = NoticeModel.instance:getBeforeLoginNoticeContent()
end

function BootNoticeView:_onClickOkBtn()
	if self._callback == nil then
		return
	end

	self._callback(self._callbackObj)

	self._callback = nil
	self._callbackObj = nil

	self:dispose()
end

function BootNoticeView:dispose()
	if self._okBtn then
		self._okBtn:RemoveClickListener()
		UnityEngine.GameObject.Destroy(self._go)

		self._go = nil
	end

	for key, value in pairs(self) do
		if type(value) == "userdata" then
			rawset(self, key, nil)
		end
	end
end

BootNoticeView.instance = BootNoticeView.New()

return BootNoticeView
