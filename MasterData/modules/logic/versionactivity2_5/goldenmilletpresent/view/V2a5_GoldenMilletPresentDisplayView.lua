-- chunkname: @modules/logic/versionactivity2_5/goldenmilletpresent/view/V2a5_GoldenMilletPresentDisplayView.lua

module("modules.logic.versionactivity2_5.goldenmilletpresent.view.V2a5_GoldenMilletPresentDisplayView", package.seeall)

local V2a5_GoldenMilletPresentDisplayView = class("V2a5_GoldenMilletPresentDisplayView", BaseViewExtended)

function V2a5_GoldenMilletPresentDisplayView:onInitView()
	gohelper.setActive(self.viewGO, true)

	self._btnPresentList = self:getUserDataTb_()

	for i = 1, GoldenMilletEnum.DISPLAY_SKIN_COUNT do
		local btnChildPath = string.format("present%s/#btn_Present", i)
		local btnPresent = gohelper.findChildButtonWithAudio(self.viewGO, btnChildPath)

		if btnPresent then
			self._btnPresentList[#self._btnPresentList + 1] = btnPresent
		end
	end

	self._goHasReceiveTip = gohelper.findChild(self.viewGO, "#go_ReceiveTip")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._btnBgClose = gohelper.findChildButtonWithAudio(self.viewGO, "close")
end

function V2a5_GoldenMilletPresentDisplayView:addEvents()
	for i, btnPresent in ipairs(self._btnPresentList) do
		btnPresent:AddClickListener(self._btnPresentOnClick, self, i)
	end

	if self._btnClose then
		self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	end

	if self._btnBgClose then
		self._btnBgClose:AddClickListener(self._btnCloseOnClick, self)
	end
end

function V2a5_GoldenMilletPresentDisplayView:removeEvents()
	for _, btnPresent in ipairs(self._btnPresentList) do
		btnPresent:RemoveClickListener()
	end

	if self._btnClose then
		self._btnClose:RemoveClickListener()
	end

	if self._btnBgClose then
		self._btnBgClose:RemoveClickListener()
	end
end

function V2a5_GoldenMilletPresentDisplayView:_btnPresentOnClick(index)
	local isOpen = GoldenMilletPresentModel.instance:isGoldenMilletPresentOpen(true)

	if not isOpen then
		return
	end

	local skinId = GoldenMilletEnum.Index2Skin[index]

	if skinId then
		CharacterController.instance:openCharacterSkinTipView({
			isShowHomeBtn = false,
			skinId = skinId
		})
	end
end

function V2a5_GoldenMilletPresentDisplayView:_btnCloseOnClick()
	self:closeThis()
end

function V2a5_GoldenMilletPresentDisplayView:onOpen()
	local haveReceived = GoldenMilletPresentModel.instance:haveReceivedSkin()

	gohelper.setActive(self._goHasReceiveTip, haveReceived)
	AudioMgr.instance:trigger(AudioEnum.UI.GoldenMilletDisplayViewOpen)
end

function V2a5_GoldenMilletPresentDisplayView:onDestroy()
	for _, btnPresent in ipairs(self._btnPresentList) do
		btnPresent:RemoveClickListener()
	end
end

return V2a5_GoldenMilletPresentDisplayView
