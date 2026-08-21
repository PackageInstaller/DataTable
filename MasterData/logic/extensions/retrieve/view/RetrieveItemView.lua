-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveItemView.lua

module("logic.extensions.retrieve.view.RetrieveItemView", package.seeall)

local ButtonAdapter = Astral.ButtonAdapter
local M = class("RetrieveItemView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
end

function M:Awake()
	self._selectGo = goutil.findChild(self._trs, "imgSelect")
	self._imgBanner = goutil.findChildImageComponent(self._trs, "imgBanner")
	self._selectGo2 = goutil.findChild(self._trs, "imgSelect2")
	self._txtName = goutil.findChildTextComponent(self._trs, "txtTitle")
	self._txtTitle = goutil.findChildTextComponent(self._trs, "txtTitle1")
	self._newSignGo = goutil.findChild(self._trs, "new_sigh")
	self._btnClickGo = goutil.findChild(self._trs, "btnClick")
	self._btnClick = ButtonAdapter.Get(self._btnClickGo)

	self._btnClick:AddClickListener(self.dealSelect, self)

	self._itemAnimComp = self._go:GetComponent(ComponentType.Animation)
end

function M:setClickCallBack(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:dealSelect()
	local lotteryId = self._data:getLotteryId()
	local lotteryType = RetrieveEnum.LotterySimpleType.Card
	local lotteryData = ActivityController.instance:getActivityById(lotteryId)

	if lotteryData and lotteryData:getIsOpen() then
		RetrieveModel.instance:cacheChoosePool(lotteryId)

		lotteryType = lotteryData:getLotterySimpleType()

		RetrieveDispatcher:dispatchEvent(RetrieveEventType.LOTTERY_CHOOSE_POOL_END, lotteryType)

		if self._clickCallBackFunc then
			self._clickCallBackFunc(self._clickCallBackHandler, lotteryId, lotteryType, self._index)
		end

		if self._itemAnimComp then
			self._itemAnimComp:Stop()
			self._itemAnimComp:Play("retrieve_item_pick_anim")
		end
	else
		FloatWordMgr.instance:show(lang("tip_activity_over"))
	end
end

function M:setCellData(data, curIndex, isSelect)
	self._data = data
	self._index = curIndex
	self._txtName.text = data:getLotteryName()
	self._txtTitle.text = data:getSubtitle()

	IconLoader.setSprite(self._imgBanner, IconType.RetrieveBanner, data:getPictureName())
	self:setSelectState(isSelect)
	goutil.setActive(self._newSignGo, data:getIsNew())
end

function M:setSelectState(isSelect)
	goutil.setActive(self._selectGo, isSelect)
	goutil.setActive(self._selectGo2, isSelect)

	if not isSelect and self._itemAnimComp then
		self._itemAnimComp:Stop()
	end
end

function M:hideNewFlag()
	goutil.setActive(self._newSignGo, false)
end

function M:onExit()
	return
end

function M:OnDestroy()
	self._txtTitle = nil
	self._txtName = nil

	self._btnClick:RemoveClickListener()

	self._btnClick = nil
end

return M
