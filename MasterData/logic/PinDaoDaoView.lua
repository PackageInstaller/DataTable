-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pindaodao/view/PinDaoDaoView.lua

module("logic.extensions.pindaodao.view.PinDaoDaoView", package.seeall)

local PinDaoDaoView = class("PinDaoDaoView", ViewComponent)
local reduceType = {
	newPlayer = 1,
	oldPlayer = 2,
	commonPlayer = 3
}

function PinDaoDaoView:ctor()
	PinDaoDaoView.super.ctor(self)
end

function PinDaoDaoView:unbindEvents()
	PinDaoDaoView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnInvite:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function PinDaoDaoView:bindEvents()
	PinDaoDaoView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnBuy:AddClickListener(self._buyOnClick, self)
	self._btnInvite:AddClickListener(self._inviteOnClick, self)
	self._btnRight:AddClickListener(self._rightOnClick, self)
	self._btnLeft:AddClickListener(self._leftOnClick, self)
	self._btnTip:AddClickListener(self._tipsOnClick, self)
end

function PinDaoDaoView:buildUI()
	PinDaoDaoView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnBuy = self:getBtn("btnBuy")
	self._btnInvite = self:getBtn("btnInvite")
	self._btnRight = self:getBtn("showCommodity/btnRight")
	self._btnLeft = self:getBtn("showCommodity/btnLeft")
	self._btnTip = self:getBtn("btnTip")
	self._txtTime = self:getTxt("time/txt")
	self._txtCurCost = self:getTxt("btnBuy/txtCurCost")
	self._txtOriginal = self:getTxt("btnBuy/txtOriginal")
	self._txtProgress = self:getTxt("bargainList/txtProgress")
	self._txtNotStart = self:getTxt("showCommodity/status/imgNotStarted/time")
	self._txtUnderway = self:getTxt("showCommodity/status/imgUnderway/time")
	self._bargainTimes = self:getTxt("bargainTimes")
	self._friendList = self:getGo("bargainList/friendList")
	self._friendCell = self:getGo("bargainList/friendCell")
	self._con = self:getGo("showCommodity/con")
	self._status = self:getGo("showCommodity/status")
	self._imgNull = self:getGo("bargainList/imgNull")
	self._imgFinished = self:getGo("showCommodity/status/imgFinished")
	self._imgUnderway = self:getGo("showCommodity/status/imgUnderway")
	self._imgNotStarted = self:getGo("showCommodity/status/imgNotStarted")
	self._imgOriginal = self:getGo("btnBuy/txtOriginal/img")
	self._friendTab = ScrollerList.create(self._friendList, self._friendCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtBuytips = self:getTxt("txtBuytips")
	self._showPosCellList = {}

	for i = 1, 3 do
		local cell = self:getGo(string.format("list/pos%s", i))

		table.insert(self._showPosCellList, cell)
	end

	self._imgLine = self:getGo("btnBuy/txtOriginal/img")

	local goCell = self:getGo("tableview/tablecell")
	local goTab = self:getGo("tableview")

	self._tableview = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCellGoods, self), GameUtil.handler(self._clearCellGoods, self))
end

function PinDaoDaoView:onExit()
	PinDaoDaoView.super.onExit(self)
	self._friendTab:dispose()
	self._tableview:dispose()
	MaterialMgr.resetAll(self._con)
	removetimer(self._showTime, self)
	self:_setLastSelectId()
end

function PinDaoDaoView:onEnter()
	PinDaoDaoView.super.onEnter(self)

	local param = self:getOpenParam() or {}

	self._activityId = checknumber(param[1])

	if self._activityId <= 0 then
		self._activityId = 565001
	end

	self.addGEvent(self, GlobalNotify.PM_PinDaoDaoInfoRes, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.PM_PinDaoDaoBuyGoodsRes, self._handleBuyGoods, self)
	self.addGEvent(self, GlobalNotify.PM_PinDaoDaoReduceInfoChange, self._handleReduceInfoChange, self)
	self.addGEvent(self, GlobalNotify.PinDaoDaoSelectGoodsId, self._handleSelectGoodsId, self)
	self:_updateUIByCfg()
	PinDaoDaoController.instance:getInfo(self._activityId)

	local lastGoodsId = self:_getLastSelectId()

	if lastGoodsId == 0 then
		lastGoodsId = 1
	end

	self:_switchGoods(lastGoodsId)
	settimer(1, self._showTime, self)
end

function PinDaoDaoView:_updateCell(view, cell, data)
	local head = goutil.findChild(cell, "head")
	local imgOld = goutil.findChild(cell, "state/imgOld")
	local imgNew = goutil.findChild(cell, "state/imgNew")
	local imgnormal = goutil.findChild(cell, "state/imgnormal")
	local txtAera = goutil.findChildTextComponent(cell, "arean/txtAera")
	local txtName = goutil.findChildTextComponent(cell, "arean/txtName")
	local txtName = goutil.findChildTextComponent(cell, "arean/txtName")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local txtDes = goutil.findChildTextComponent(cell, "txtDes")

	txtDes.text = data == self._firstReduceInfo and "赠送首刀优惠" or "手起刀落砍一刀"

	HeadItemController.instance:setHeadCellByInfo(head, data.headInfo, true)

	txtName.text = data.headInfo.userName
	txtAera.text = string.format("%s服-", data.headInfo.areaId)
	txtNum.text = string.format("-%s神钻", data.reduceCount)

	goutil.setActive(imgOld, data.playerType == reduceType.oldPlayer)
	goutil.setActive(imgNew, data.playerType == reduceType.newPlayer)
	goutil.setActive(imgnormal, data.playerType == reduceType.commonPlayer)
end

function PinDaoDaoView:_clearCell(cell)
	local head = goutil.findChild(cell, "head")

	HeadItemController.instance:resetHeadCell(head)
end

function PinDaoDaoView:_showTime()
	if self._timePeriod ~= GameUtil.inTimePeriod then
		return
	end

	local goodsCfg = self._goodsCfgs[self._selectGoodsId]
	local endTimeStamp = GameUtil.string2time(goodsCfg.endTime)
	local nowTimeStamp = ServerTime.now()
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(endTimeStamp - nowTimeStamp)

	if endTimeStamp - nowTimeStamp < 0 then
		self:_refreshView()

		return
	end

	self._txtUnderway.text = day <= 0 and string.format("剩余时间\n%02d:%02d:%02d", hour, min, sec) or string.format("剩余时间\n%02d天 %02d:%02d:%02d", day, hour, min, sec)
end

function PinDaoDaoView:_rightOnClick()
	self._selectGoodsId = self._selectGoodsId + 1

	if self._selectGoodsId > #self._goodsCfgs then
		FloatWordMgr.instance:show("已经到尾了")

		self._selectGoodsId = #self._goodsCfgs

		return
	end

	self:_refreshView()
end

function PinDaoDaoView:_leftOnClick()
	if self._selectGoodsId <= 1 then
		FloatWordMgr.instance:show("已经到头了")

		return
	end

	self._selectGoodsId = self._selectGoodsId - 1

	self:_refreshView()
end

function PinDaoDaoView:_tipsOnClick()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function PinDaoDaoView:_inviteOnClick()
	if self._timePeriod ~= GameUtil.inTimePeriod then
		return
	end

	UIStateManager.instance:push(ViewName.PinDaoDaoInviteView, self._activityId, self._selectGoodsId)
end

function PinDaoDaoView:_buyOnClick()
	if self._timePeriod == GameUtil.beforeTimePeriod then
		return
	end

	if self._actCfg then
		if not self._actCfg.buyGoodsLimit then
			local maxBuyCount = 0

			if maxBuyCount <= #self._buyGoodsIds then
				FloatWordMgr.instance:show("已售罄")

				return
			end

			if self:_isBuyGoods(self._selectGoodsId) then
				FloatWordMgr.instance:show("已售罄")

				return
			end

			local function okFunc()
				PinDaoDaoController.instance:buyGoods(self._activityId, self._selectGoodsId)
			end

			local goodsCfg = self._goodsCfgs[self._selectGoodsId]
			local costName = MaterialMgr.getMaterialsNameByCfg(goodsCfg.dec)
			local costMatType, costMatId = MaterialMgr.getMatParams(goodsCfg.dec)
			local originNum, minNum, curPrice = self:_getCurPrice(goodsCfg.goodsId)

			if not goodsCfg.goods then
				local goods = ""
				local mattype, matid, matnum = MaterialMgr.getMatParams(goods)
				local matName = MaterialMgr.getMaterialsNameByCfg(goods)
				local tipsContent = string.format("当前商品【<color=#eb4642>%sx%s</color>】已砍<color=#eb4642>%s%s</color>，是否花费<color=#eb4642>%s%s</color>购买？\n购买后<color=#eb4642>无法再购买其他商品</color>，请再次确认商品选择是否正确。", matName, matnum, originNum - curPrice, costName, curPrice, costName)

				TipsFacade.instance:openPopupCostMatViewNew(costMatType, costMatId, curPrice, tipsContent, okFunc)
			end
		end
	end
end

function PinDaoDaoView:_chatTips()
	FloatWordMgr.instance:show("发送成功")
end

function PinDaoDaoView:_updateUIByCfg()
	self._actCfg = PinDaoDaoConfig.instance:getActivityCfgById(self._activityId)
	self._goodsCfgs = PinDaoDaoConfig.instance:getGoodsCfgs(self._activityId) or {}
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function PinDaoDaoView:_handleGetInfo()
	self._totalReduceCount = 0

	local info = PinDaoDaoModel.instance:getInfoByActId(self._activityId)

	if info then
		self._totalReduceCount = info.totalReduceCount or 0
	end

	self:_handleBuyGoods()
end

function PinDaoDaoView:_handleBuyGoods()
	self._buyGoodsIds = {}

	local info = PinDaoDaoModel.instance:getInfoByActId(self._activityId)

	if info then
		self._buyGoodsIds = info.buyGoodsIds or {}
	end

	self:_handleReduceInfoChange()
end

function PinDaoDaoView:_handleReduceInfoChange()
	self._firstReduceInfo = nil

	local records = {}
	local info = PinDaoDaoModel.instance:getInfoByActId(self._activityId)

	self._currentReduceTotal = 0

	local roleId = checknumber(RoleModel.instance:getUserId())

	if info then
		if not info.reduceItemList then
			local reduceItemList = {}

			for i, v in ipairs(reduceItemList) do
				if checknumber(v.headInfo.userId) == roleId and not self._firstReduceInfo then
					self._firstReduceInfo = v

					table.insert(records, 1, v)
				else
					table.insert(records, v)
				end

				self._currentReduceTotal = self._currentReduceTotal + v.reduceCount
			end
		end
	end

	self._friendTab:reloadData(records)
	goutil.setActive(self._imgNull, #records == 0)
	self:_refreshView()

	if self:isFirstEnterActivity() and self._firstReduceInfo then
		local usertype = self._firstReduceInfo.playerType
		local showCount = self._firstReduceInfo.reduceCount
		local showStr = ""

		if usertype == reduceType.newPlayer then
			showStr = "新"
		elseif usertype == reduceType.oldPlayer then
			showStr = "回归"
		elseif usertype == reduceType.commonPlayer then
			showStr = "活跃"
		end

		local tips = string.format("经过精密测算，您是<color=#eb4642>%s</color>玩家，现送您第一刀<color=#eb4642>%s</color>神钻，快把喜欢的商品带回家吧！", showStr, showCount)

		TipsFacade.instance:openTipWindowNoX("提示", tips, function()
			self:_setFirstEnterActivity()
		end)
	end
end

function PinDaoDaoView:_switchGoods(goodsId)
	self._selectGoodsId = goodsId

	self:_refreshView()
end

function PinDaoDaoView:_refreshView()
	local goodsCfg = self._goodsCfgs[self._selectGoodsId]

	MaterialMgr.resetAll(self._con)
	MaterialMgr.setCellByCfg(goodsCfg.goods, self._con)
	self._tableview:reloadData(self._goodsCfgs)
	self._tableview:MoveCellToCenter(self._selectGoodsId - 1)

	self._timePeriod = GameUtil.getTimePeriod(goodsCfg.startTime, goodsCfg.endTime)

	goutil.setActive(self._imgUnderway, self._timePeriod == GameUtil.inTimePeriod)
	goutil.setActive(self._imgFinished, self._timePeriod == GameUtil.afterTimePeriod)
	goutil.setActive(self._imgNotStarted, self._timePeriod == GameUtil.beforeTimePeriod)
	goutil.setActive(self._imgOriginal, false)
	goutil.setActive(self._txtCurCost.gameObject, false)

	local originNum, minNum, curPrice = self:_getCurPrice(goodsCfg.goodsId)

	if curPrice >= 0 and self._timePeriod ~= GameUtil.beforeTimePeriod and curPrice < originNum then
		goutil.setActive(self._imgOriginal, true)
		goutil.setActive(self._txtCurCost.gameObject, true)
	end

	GameUtil.SetGray(self._btnInvite, self._timePeriod ~= GameUtil.inTimePeriod)
	GameUtil.SetGray(self._btnBuy, self._timePeriod == GameUtil.beforeTimePeriod)

	self._txtCurCost.text = string.format("%s神钻", curPrice)
	self._txtOriginal.text = string.format("%s神钻", originNum)
	self._buyGoodsIds = self._buyGoodsIds or {}

	GameUtil.SetGray(self._btnBuy, false)

	if self._actCfg then
		if not self._actCfg.buyGoodsLimit then
			local maxBuyCount = 0

			goutil.setActive(self._imgOriginal, true)

			local reduceCfg = PinDaoDaoConfig.instance:getReduceCfgByActivityId(self._activityId, reduceType.commonPlayer)
			local maxReduceCount = originNum - minNum

			self._txtProgress.text = string.format("已砍价: %s/%s神钻", Mathf.Min(originNum - curPrice, maxReduceCount), maxReduceCount)

			if maxBuyCount <= #self._buyGoodsIds then
				GameUtil.SetGray(self._btnBuy, true)

				self._txtOriginal.text = "已售罄"
				self._txtCurCost.text = ""

				goutil.setActive(self._imgOriginal, false)
			end

			if self:_isBuyGoods(goodsCfg.goodsId) then
				self._txtOriginal.text = "已购买"
				self._txtCurCost.text = ""

				GameUtil.SetGray(self._btnBuy, true)
				goutil.setActive(self._imgOriginal, false)
			end

			self._txtNotStart.text = GameUtil.formatTimeString("%m月%d日 %H:%M开启", goodsCfg.startTime)
			self._totalReduceCount = self._totalReduceCount or 0
			self._bargainTimes.text = string.format("帮砍剩余次数:%s/%s", self._actCfg.helpReduceLimit - self._totalReduceCount, self._actCfg.helpReduceLimit)
			self._txtBuytips.text = string.format("活动期间仅可购买一次商品<color=#20b376>（%s/%s）</color>", #self._buyGoodsIds, self._actCfg.buyGoodsLimit)

			self:_showTime()
		end
	end
end

function PinDaoDaoView:_isBuyGoods(goodsId)
	for _, v in ipairs(self._buyGoodsIds) do
		if v == goodsId then
			return true
		end
	end

	return false
end

function PinDaoDaoView:_getCurPrice(goodsId)
	local goodsCfg = PinDaoDaoConfig.instance:getGoodsCfgByActivityId(self._activityId, goodsId)

	if not goodsCfg then
		return 0, 0, 0
	end

	local originNum = goodsCfg.originCostNum
	local maxReduceCount = self._actCfg.maxReduceCount
	local MinCostNum = goodsCfg.minCostNum
	local showMinCostNum = Mathf.Max(MinCostNum, originNum - maxReduceCount)

	self._currentReduceTotal = self._currentReduceTotal or 0

	local curPrice = Mathf.Max(MinCostNum, originNum - Mathf.Min(self._currentReduceTotal, maxReduceCount))

	return originNum, showMinCostNum, curPrice
end

function PinDaoDaoView:_getCurrentDiscount()
	self._currentReduceTotal = self._currentReduceTotal or 0

	local maxReduceCount = self._actCfg.maxReduceCount

	return Mathf.Min(self._currentReduceTotal, maxReduceCount)
end

function PinDaoDaoView:_getLastSelectId()
	local saveKey = string.format("PinDaoDaoView_LastSelectId_%d", self._activityId)

	return checknumber(GameUtil.getUserData(saveKey))
end

function PinDaoDaoView:_setLastSelectId()
	local saveKey = string.format("PinDaoDaoView_LastSelectId_%d", self._activityId)

	GameUtil.saveUserData(saveKey, tostring(self._selectGoodsId))
end

function PinDaoDaoView:isFirstEnterActivity()
	local saveKey = string.format("PinDaoDaoView_IsFirstEnter_%d", self._activityId)

	return checknumber(GameUtil.getUserData(saveKey)) <= 0
end

function PinDaoDaoView:_setFirstEnterActivity()
	local saveKey = string.format("PinDaoDaoView_IsFirstEnter_%d", self._activityId)

	GameUtil.saveUserData(saveKey, "1")
end

function PinDaoDaoView:_updateCellGoods(view, cell, data)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")
	local goItem = goutil.findChild(go, "item")
	local select = goutil.findChild(go, "select")

	goutil.setActive(select, data.goodsId == self._selectGoodsId)
	MaterialMgr.resetAll(goItem)
	MaterialMgr.setCellByCfg(data.goods, goItem)
	GameUtil.addClickHandler(btn, function()
		UIStateManager.instance:push(ViewName.PinDaoDaoSelectView, self._activityId, self._selectGoodsId, self:_getCurrentDiscount())
	end)
end

function PinDaoDaoView:_clearCellGoods(cell)
	local go = cell.gameObject
	local goItem = goutil.findChild(go, "item")

	MaterialMgr.resetAll(goItem)

	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function PinDaoDaoView:_handleSelectGoodsId(goodsId)
	self:_switchGoods(goodsId)
end

return PinDaoDaoView
