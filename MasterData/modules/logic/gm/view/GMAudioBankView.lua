-- chunkname: @modules/logic/gm/view/GMAudioBankView.lua

module("modules.logic.gm.view.GMAudioBankView", package.seeall)

local GMAudioBankView = class("GMAudioBankView", BaseView)
local State = {
	hide = 3,
	tweening = 2,
	show = 1
}

function GMAudioBankView:onInitView()
	self._rect = gohelper.findChild(self.viewGO, "view").transform
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "view/btnClose")
	self._btnShow = gohelper.findChildButtonWithAudio(self.viewGO, "view/btnShow")
	self._btnHide = gohelper.findChildButtonWithAudio(self.viewGO, "view/btnHide")
	self._btnSearch = gohelper.findChildButtonWithAudio(self.viewGO, "view/title/btnSearch")
	self._inputSearch = gohelper.findChildTextMeshInputField(self.viewGO, "view/title/InputField")

	GMAudioBankViewModel.instance:setList({})
end

function GMAudioBankView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._btnShow:AddClickListener(self._onClickShow, self)
	self._btnHide:AddClickListener(self._onClickHide, self)
	self._btnSearch:AddClickListener(self._onClickSearch, self)
end

function GMAudioBankView:_onClickShow()
	if self._state == State.hide then
		self._state = State.tweening
		self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._rect, 0, 0.2, self._onShow, self)
	end
end

function GMAudioBankView:_onShow()
	self._tweenId = nil
	self._state = State.show

	self:_updateBtns()
end

function GMAudioBankView:_onClickHide()
	if self._state == State.show then
		self._state = State.tweening
		self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._rect, -800, 0.2, self._onHide, self)
	end
end

function GMAudioBankView:_onHide()
	self._tweenId = nil
	self._state = State.hide

	self:_updateBtns()
end

function GMAudioBankView:_updateBtns()
	gohelper.setActive(self._btnShow.gameObject, self._state == State.hide)
	gohelper.setActive(self._btnHide.gameObject, self._state == State.show)
end

function GMAudioBankView:_onClickSearch()
	local value = self._inputSearch:GetText()
	local list = {}

	for _, audioCO in ipairs(AudioConfig.instance._allAudio) do
		if audioCO.bankName == value then
			table.insert(list, audioCO)
		end
	end

	GMAudioBankViewModel.instance:setList(list)
end

function GMAudioBankView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnShow:RemoveClickListener()
	self._btnHide:RemoveClickListener()
	self._btnSearch:RemoveClickListener()
	self._inputSearch:RemoveOnValueChanged()
end

function GMAudioBankView:onUpdateParam()
	return
end

function GMAudioBankView:onOpen()
	self._state = State.show

	self:_updateBtns()
end

function GMAudioBankView:onClose()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

return GMAudioBankView
