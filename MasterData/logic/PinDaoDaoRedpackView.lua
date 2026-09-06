-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pindaodao/view/PinDaoDaoRedpackView.lua

module("logic.extensions.pindaodao.view.PinDaoDaoRedpackView", package.seeall)

local PinDaoDaoRedpackView = class("PinDaoDaoRedpackView", ViewComponent)

function PinDaoDaoRedpackView:ctor()
	PinDaoDaoRedpackView.super.ctor(self)
end

function PinDaoDaoRedpackView:unbindEvents()
	PinDaoDaoRedpackView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRound)
	GameUtil.rmClickHandler(self._btnGoTo)
end

function PinDaoDaoRedpackView:bindEvents()
	PinDaoDaoRedpackView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRound, self._openRedPack, self)
	GameUtil.addClickHandler(self._btnGoTo, self._goToOnClick, self)
end

function PinDaoDaoRedpackView:buildUI()
	PinDaoDaoRedpackView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnRound = self:getGo("btns/btnRound")
	self._btnGoTo = self:getGo("btns/btnResult/btnGoto")
	self._resultGo = self:getGo("btns/btnResult")
	self._roundGo = self:getGo("btns/btnRound")
	self._resultHead = self:getGo("btns/btnResult/goHead")
	self._roundHead = self:getGo("btns/btnRound/goHead")
	self._txtTips = self:getTxt("btns/btnResult/tip/txt")
end

function PinDaoDaoRedpackView:onExit()
	PinDaoDaoRedpackView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._roundHead)
	HeadItemController.instance:resetHeadCell(self._resultHead)
end

function PinDaoDaoRedpackView:onEnter()
	PinDaoDaoRedpackView.super.onEnter(self)

	local param = self:getOpenParam() or {}

	self._activityId = checknumber(param[1])
	self._goodsId = checknumber(param[2])
	self._reduceUserId = checknumber(param[3])

	if self._activityId <= 0 or self._goodsId <= 0 or self._reduceUserId <= 0 then
		self:close()

		return
	end

	self.addGEvent(self, GlobalNotify.PM_PinDaoDaoInfoRes, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.PM_PinDaoDaoPlayerInfoRes, self._handleGetPlayerInfo, self)
	self.addGEvent(self, GlobalNotify.PM_PinDaoDaoHelpReduceRes, self._handleHelpReduce, self)
	self:_initInfo()

	local info = PinDaoDaoModel.instance:getInfoByActId(self._activityId)

	if info then
		self:_handleGetInfo()
	else
		PinDaoDaoController.instance:getInfo(self._activityId)
	end

	PinDaoDaoController.instance:viewPlayerGoodsInfo(self._activityId, self._reduceUserId)
end

function PinDaoDaoRedpackView:_initInfo()
	self._helpReduceLimit = 0
	self._totalReduceCount = 0
	self._reduceItemList = {}
	self._todayReduceCount = 0
	self._isHasBuyGoodsId = false
	self._playerHeadInfo = nil
	self._currentReduceTotal = 0
	self._curHelpReduceCount = 0
	self._curHelpReduceCount = 0
	self._needShowInfo = false

	self:_updateUIByCfg()
end

function PinDaoDaoRedpackView:_updateUIByCfg()
	self._actCfg = PinDaoDaoConfig.instance:getActivityCfgById(self._activityId)
	self._goodsCfg = PinDaoDaoConfig.instance:getGoodsCfgByActivityId(self._activityId, self._goodsId)
	self._helpReduceLimit = 0
	self._reduceTotalLimit = 0

	if not self._actCfg or not self._goodsCfg then
		self:close()

		return
	end

	if self._actCfg then
		self._reduceTotalLimit = self._actCfg.maxReduceCount or 0
		self._helpReduceLimit = self._actCfg.helpReduceLimit or 0
	end
end

function PinDaoDaoRedpackView:_handleGetInfo()
	self._dailyReduceLimit = 0
	self._totalReduceCount = 0

	local info = PinDaoDaoModel.instance:getInfoByActId(self._activityId)

	if info then
		if not info.playerType then
			local playerType = 1
			local playerTypeCfg = PinDaoDaoConfig.instance:getReduceCfgByActivityId(self._activityId, playerType)

			if playerTypeCfg then
				self._dailyReduceLimit = playerTypeCfg.dailyReduceLimit or 0
			end

			self._totalReduceCount = info.totalReduceCount or 0
		end
	end

	self:_refreshRedpack()
end

function PinDaoDaoRedpackView:_handleGetPlayerInfo(info)
	self._todayReduceCount = 0
	self._isHasBuyGoodsId = false
	self._playerHeadInfo = nil
	self._curHelpReduceCount = 0
	self._currentReduceTotal = 0

	if info then
		self._todayReduceCount = info.todayReduceCount or 0
		self._playerHeadInfo = info.headInfo or nil

		if not info.buyGoodsIds then
			local buyGoodsIds = {}

			for _, goodsId in ipairs(buyGoodsIds) do
				if checknumber(goodsId) == self._goodsId then
					self._isHasBuyGoodsId = true

					break
				end
			end

			if not info.reduceItemList then
				local reduceItemList = {}

				for _, itemInfo in ipairs(reduceItemList) do
					if checknumber(itemInfo.headInfo.userId) == checknumber(RoleModel.instance:getUserId()) then
						self._curHelpReduceCount = itemInfo.reduceCount or 0
					end

					self._currentReduceTotal = self._currentReduceTotal + (itemInfo.reduceCount or 0)
				end
			end
		end
	end

	self:_setHeadIcon()
	self:_refreshRedpack()
end

function PinDaoDaoRedpackView:_refreshRedpack()
	goutil.setActive(self._resultGo, false)
	goutil.setActive(self._roundGo, false)

	if not self._actCfg or not self._goodsCfg then
		self:close()

		return
	end

	local timePeriod = GameUtil.getTimePeriod(self._goodsCfg.startTime, self._goodsCfg.endTime)
	local str = ""
	local canHelp = true

	if self._curHelpReduceCount > 0 then
		str = "已帮好友砍过价"
		canHelp = false
	elseif self._isHasBuyGoodsId or timePeriod == GameUtil.afterTimePeriod then
		str = "该商品已被购买"
		canHelp = false
	elseif self._todayReduceCount >= self._dailyReduceLimit then
		print("拼刀刀打印", self._todayReduceCount, self._dailyReduceLimit)

		str = "对方的今日助力次数已达上限"
		canHelp = false
	elseif self._totalReduceCount >= self._helpReduceLimit then
		str = "您本次活动的助力次数已达上限"
		canHelp = false
	elseif self._currentReduceTotal >= self._reduceTotalLimit then
		str = "该商品已砍至最低价"
		canHelp = false
	end

	self._txtTips.text = not self._needShowInfo and str or string.format("成功帮好友砍掉%s神钻", self._curHelpReduceCount)

	goutil.setActive(self._resultGo, not canHelp)
	goutil.setActive(self._roundGo, canHelp)
end

function PinDaoDaoRedpackView:_setHeadIcon()
	HeadItemController.instance:resetHeadCell(self._roundHead)
	HeadItemController.instance:resetHeadCell(self._resultHead)

	if self._playerHeadInfo then
		HeadItemController.instance:setHeadCellByInfo(self._roundHead, self._playerHeadInfo)
		HeadItemController.instance:setHeadCellByInfo(self._resultHead, self._playerHeadInfo)
	end
end

function PinDaoDaoRedpackView:_handleHelpReduce(info)
	if info.code == 0 then
		self._curHelpReduceCount = info.reduce
		self._needShowInfo = true

		self:_refreshRedpack()
	else
		PinDaoDaoController.instance:viewPlayerGoodsInfo(self._activityId, self._reduceUserId)
	end
end

function PinDaoDaoRedpackView:_openRedPack()
	PinDaoDaoController.instance:helpReduce(self._activityId, self._reduceUserId)
end

function PinDaoDaoRedpackView:_goToOnClick()
	self:close()
	UIStateManager.instance:push(ViewName.PinDaoDaoView, self._activityId)
end

return PinDaoDaoRedpackView
