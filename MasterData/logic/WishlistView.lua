-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishlist/view/WishlistView.lua

module("logic.extensions.wishlist.view.WishlistView", package.seeall)

local WishlistView = class("WishlistView", ViewComponent)

function WishlistView:buildUI()
	WishlistView.super.buildUI(self)

	self._sign = self:getGo("sign")
	self._btnSure = self:getBtn("sign/btnSure")
	self._txtShowBless1 = self:getTxt("sign/showBless")
	self._prize = self:getGo("prize")
	self._btnClose = self:getBtn("prize/btnClose")
	self._btnTip = self:getBtn("prize/btnTip")
	self._txtShowBless2 = self:getTxt("prize/showBless")
	self._tweenPostion = self._txtShowBless2.gameObject:GetComponent("TweenPosition")
	self._UITweenFadeOut = self._txtShowBless2.gameObject:GetComponent("UITweenFadeOut")
	self._blessList = {}

	for i = 1, 6 do
		local cell = {}

		cell.go = self:getGo("sign/blessList/btnBless_" .. i)
		cell.btn = GameUtil.asBtn(cell.go)
		cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtDesc")
		cell.select = goutil.findChild(cell.go, "select")
		self._blessList[i] = cell
	end

	self._prizeList = {}

	for i = 1, 5 do
		local cell = {}

		cell.go = self:getGo("prize/prizeList/reward_" .. i)
		cell.btnShow = GameUtil.asBtn(goutil.findChild(cell.go, "btnShow"))
		cell.redPoint = goutil.findChild(cell.go, "redPoint")
		cell.receive = goutil.findChild(cell.go, "receive")
		cell.btnReward = GameUtil.asBtn(goutil.findChild(cell.go, "reward/btnReward"))
		cell.con = goutil.findChild(cell.go, "reward/con")
		self._prizeList[i] = cell
	end
end

function WishlistView:bindEvents()
	WishlistView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickBtnSure, self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)

	for i = 1, #self._blessList do
		self._blessList[i].btn:AddClickListener(function()
			self:_onClickSelectBless(i)
		end)
	end

	for i = 1, #self._prizeList do
		self._prizeList[i].btnShow:AddClickListener(function()
			self:_onClickShowBless(i)
		end)
		self._prizeList[i].btnReward:AddClickListener(function()
			self:_onClickGainPrize(i)
		end)
	end
end

function WishlistView:unbindEvents()
	WishlistView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()

	for i = 1, #self._blessList do
		self._blessList[i].btn:RemoveClickListener()
	end

	for i = 1, #self._prizeList do
		self._prizeList[i].btnShow:RemoveClickListener()
		self._prizeList[i].btnReward:RemoveClickListener()
	end
end

function WishlistView:onEnter()
	WishlistView.super.onEnter(self)
	goutil.setActive(self._prize, false)
	goutil.setActive(self._sign, false)

	self._curActCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.WishList)

	if self._curActCfg then
		WishListAgent.instance:sendPM_GetWishListInfoReq(self._curActCfg.activityId)
	else
		FloatWordMgr.instance:show(lang("活动未开始"))
		self:close()
	end

	GlobalDispatcher:addListener(WishListController.UpdateViewState, self._updateView, self)

	self._initData = false
end

function WishlistView:onExit()
	WishlistView.super.onExit(self)

	for i = 1, 5 do
		MaterialMgr.resetAll(self._prizeList[i].con)
	end

	self:_finishShowBless()
	GlobalDispatcher:removeListener(WishListController.UpdateViewState, self._updateView, self)
end

function WishlistView:_onClickSelectBless(id)
	self._selectData = self._curblessCfgs[id]

	if self._selectData then
		for i = 1, 6 do
			if not self._curblessCfgs[i] then
				local cfg = {}

				goutil.setActive(self._blessList[i].select, cfg == self._selectData)
			end
		end

		self._txtShowBless1.text = self._selectData.content
	end
end

function WishlistView:_onClickShowBless(id)
	local showId = self._myWishes[id]
	local cfg = WishListConfig.instance:getBlessCfgById(self._curActCfg.activityId, showId)

	UIStateManager.instance:open(ViewName.WishlistshowView, cfg.content)
end

function WishlistView:_onClickGainPrize(id)
	if self._hasGainIds[id] then
		FloatWordMgr.instance:show(lang("礼物已经领完了哦~"))

		return
	end

	WishListAgent.instance:sendPM_GainWishPrizeReq(self._curActCfg.activityId, id)
end

function WishlistView:_onClickTip()
	ViewMgr.instance:open(ViewName.RulesView, "wishlistrule")
end

function WishlistView:_onClickBtnSure()
	if self._isShowPrize then
		return
	end

	WishListAgent.instance:sendPM_SendWishReq(self._curActCfg.activityId, self._selectData.id)
end

function WishlistView:_updateData()
	self._curShowWish = WishListController.instance:getCurShowWish()
	self._myWishes = WishListController.instance:getMyWishes()
	self._hasGainIds = WishListController.instance:getHasGainIds()
	self._hasSendWishToday = WishListController.instance:getHasSendWishToday()
	self._showId = #self._myWishes + 1
	self._curPrizeCfgs = WishListConfig.instance:getPrizeCfg(self._curActCfg.activityId)
	self._curblessCfgs = WishListConfig.instance:getBlessCfgByDayId(self._curActCfg.activityId, self._showId) or {}
	self._isShowPrize = self._hasSendWishToday or self._showId > #self._curPrizeCfgs
end

function WishlistView:_updateView()
	self:_updateData()
	self:_switchPart(self._isShowPrize)

	for i = 1, 6 do
		if not self._curblessCfgs[i] then
			local cfg = {}

			if not GameUtil.isEmptyString(cfg.content) then
				goutil.setActive(self._blessList[i].go, true)

				self._blessList[i].txtDesc.text = cfg.content
			else
				goutil.setActive(self._blessList[i].go, false)
			end
		end
	end

	self:_onClickSelectBless(1)

	for i = 1, 5 do
		goutil.setActive(self._prizeList[i].btnReward.gameObject, not self._hasGainIds[i])

		if not self._curPrizeCfgs[i] then
			local cfg = {}

			if not self._initData and cfg then
				MaterialMgr.setCellByCfg(cfg.prize, self._prizeList[i].con)
			end

			if i <= self._showId - 1 then
				goutil.setActive(self._prizeList[i].go, true)
				goutil.setActive(self._prizeList[i].receive, self._hasGainIds[i])
				goutil.setActive(self._prizeList[i].redPoint, not self._hasGainIds[i])
			else
				goutil.setActive(self._prizeList[i].go, false)
			end
		end
	end

	self._initData = true
end

function WishlistView:_switchPart(showPrize)
	self:_finishShowBless()

	if showPrize then
		goutil.setActive(self._prize, true)
		goutil.setActive(self._sign, false)
		self:_startShowBless()
		settimer(10, self._startShowBless, self)
	else
		goutil.setActive(self._prize, false)
		goutil.setActive(self._sign, true)
	end
end

function WishlistView:_startShowBless()
	if #self._curShowWish > 0 then
		local data = self._curShowWish[math.random(#self._curShowWish)]

		if data then
			local cfg = WishListConfig.instance:getBlessCfgById(self._curActCfg.activityId, data.contentId)

			self._txtShowBless2.text = langPara("%s祝同学们：\n        %s", data.name, cfg.content)
		end
	end

	self._tweenPostion.enabled = true
	self._UITweenFadeOut.enabled = true
end

function WishlistView:_finishShowBless()
	removetimer(self._startShowBless, self)

	self._tweenPostion.enabled = false
	self._UITweenFadeOut.enabled = false
end

return WishlistView
