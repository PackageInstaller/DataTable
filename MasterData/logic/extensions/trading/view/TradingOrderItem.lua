-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/view/TradingOrderItem.lua

module("logic.extensions.trading.view.TradingOrderItem", package.seeall)

local M = class("TradingOrderItem")

function M:ctor(compContainer)
	self._go = compContainer.gameObject

	self:init()
end

function M:init()
	local go = self._go

	self._imgIcon = goutil.findChildImageComponent(go, "icon")
	self._goToGet = goutil.findChild(go, "toGet")
	self._goNone = goutil.findChild(go, "done")
	self._imgQuality = goutil.findChildImageComponent(go, "quality")
	self._txtName = goutil.findChildTextComponent(go, "txtName")
	self._txtType = goutil.findChildTextComponent(go, "txtKind")
	self._txtTime = goutil.findChildTextComponent(go, "toGet/txtTime")
	self._imgFill = goutil.findChildImageComponent(go, "toGet/fillDi/fill")
	self._btnRefresh = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnRefresh"))
	self._btnSubmit = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnCommit"))
	self._btnSpeedUp = UIComponentType.ButtonAdapter(goutil.findChild(go, "toGet/btnAddSpeed"))
	self._goLine = goutil.findChild(go, "imgDi (1)")
	self._countDownTimer = SchedulerCtrl.New(self._onCountdown, self)

	self:bindEvents()
end

function M:bindEvents()
	self._btnRefresh:AddClickListener(self.onClickRefresh, self)
	self._btnSubmit:AddClickListener(self.onClickSubmit, self)
	self._btnSpeedUp:AddClickListener(self.onClickSpeedUp, self)
end

function M:unbindEvents()
	self._btnRefresh:RemoveClickListener()
	self._btnSubmit:RemoveClickListener()
	self._btnSpeedUp:RemoveClickListener()
	self._countDownTimer:clear()

	self._countDownTimer = nil
end

function M:updateData(data)
	self._id = data.id
	self._orderIndex = data.orderIndex
	self._txtName.text = data.name
	self._orderType = data.orderType

	goutil.setActive(self._goToGet, data.isToGet)
	goutil.setActive(self._goNone, data.isNone)
	goutil.setActive(self._btnRefresh.gameObject, data.orderType == 1 and not data.isToGet)
	goutil.setActive(self._imgIcon.gameObject, not data.isToGet)
	goutil.setActive(self._imgQuality.gameObject, not data.isToGet)
	goutil.setActive(self._goLine, not data.isToGet)

	if data.productivity then
		local total = data.productivity.total
		local surplus = data.productivity.surplus

		self._imgFill.fillAmount = (total - surplus) / total

		self:_onCountdown()
		self._countDownTimer:restart(1, true)
	end

	if data.icon then
		IconLoader.setSprite(self._imgIcon, IconType.RoomOrder, data.icon)
	end

	if data.quality then
		IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_Room, CommEnum.Quality2RoomOrderItemBg[data.quality])
	end

	goutil.setActive(self._go, true)
end

function M:_onCountdown()
	self._txtTime.text = TimeUtil.instance:numberToTime(TradingModel.instance:getRemainTime(), "h:m:s")
end

function M:onClickRefresh()
	ViewMgr.instance:open(ViewName.TradingOrderRefresh, self._id, self._orderIndex - 1)
end

function M:onClickSubmit()
	ViewMgr.instance:open(ViewName.TradingOrderInfo, self._id, self._orderType, self._orderIndex - 1)
end

function M:onClickSpeedUp()
	ViewMgr.instance:open(ViewName.TradingOrderSpeedUpTipsView)
end

function M:OnDestroy()
	self:unbindEvents()
end

return M
