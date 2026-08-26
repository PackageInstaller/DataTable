-- chunkname: @modules/logic/versionactivity1_6/goldenmilletpresent/view/GoldenMilletPresentDisplayView.lua

module("modules.logic.versionactivity1_6.goldenmilletpresent.view.GoldenMilletPresentDisplayView", package.seeall)

local GoldenMilletPresentDisplayView = class("GoldenMilletPresentDisplayView", BaseViewExtended)

function GoldenMilletPresentDisplayView:onInitView()
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
end

function GoldenMilletPresentDisplayView:addEvents()
	for i, btnPresent in ipairs(self._btnPresentList) do
		btnPresent:AddClickListener(self._btnPresentOnClick, self, i)
	end

	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function GoldenMilletPresentDisplayView:removeEvents()
	for _, btnPresent in ipairs(self._btnPresentList) do
		btnPresent:RemoveClickListener()
	end

	self._btnClose:RemoveClickListener()
end

function GoldenMilletPresentDisplayView:_btnPresentOnClick(index)
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

function GoldenMilletPresentDisplayView:_btnCloseOnClick()
	self:closeThis()
end

function GoldenMilletPresentDisplayView:onOpen()
	local haveReceived = GoldenMilletPresentModel.instance:haveReceivedSkin()

	gohelper.setActive(self._goHasReceiveTip, haveReceived)
	AudioMgr.instance:trigger(AudioEnum.UI.GoldenMilletDisplayViewOpen)
end

return GoldenMilletPresentDisplayView
