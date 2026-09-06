-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampmain/FunCampDonateView.lua

module("logic.extensions.funcamp.view.funcampmain.FunCampDonateView", package.seeall)

local FunCampDonateView = class("FunCampDonateView", ViewComponent)

function FunCampDonateView:ctor()
	FunCampDonateView.super.ctor(self)
end

function FunCampDonateView:buildUI()
	FunCampDonateView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtTip = self:getTxt("tip/txt")
	self._txtDonate = self:getTxt("txtDonate")
	self._btnAdd = self:getBtn("txtDonate/btnAdd")
	self._txtCoin = self:getTxt("txtCoin")
	self.cell = self:getGo("tablecell")
	self.tableview = self:getGo("tableview")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self.scrollList:regReloadFinish(GameUtil.handler(self._reloadFinish, self))

	self._coinSlider = self:getSlider("tableview/viewport/content/progressSlider")
	self._bubble = self:getGo("tableview/viewport/content/bubble")
	self._txtDesc = goutil.findChildTextComponent(self._bubble, "txtDesc")
	self._contentRectTrans = self:getGo("tableview/viewport/content"):GetComponent(goutil.Type_RectTransform)
	self._donateCell = self:getGo("donatecell")
	self._donateItems = {}

	for i = 1, 3 do
		local item = {}

		item.icon = self:getGo(string.format("donate%d/txtCost/icon", i))
		item.txtCost = self:getTxt(string.format("donate%d/txtCost", i))
		item.btn = self:getBtn(string.format("donate%d", i))

		local donateTableview = self:getGo(string.format("donate%d/tableview", i))

		item.scrollList = ScrollerList.create(donateTableview, self._donateCell, GameUtil.handler(self._donateUpdateCell, self), GameUtil.handler(self._donateClearCell, self))

		table.insert(self._donateItems, item)
	end

	self._bg1 = self:getGo("donate1/effect")
	self._bg2 = self:getGo("donate2/effect")
	self._bg3 = self:getGo("donate3/effect")
	self._txtScore = self:getTxt("txtScore")
end

function FunCampDonateView:bindEvents()
	FunCampDonateView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)

	for i, v in ipairs(self._donateItems) do
		v.btn:AddClickListener(function()
			local donateId = i

			self:_onClickDonate(donateId)
		end)
	end
end

function FunCampDonateView:unbindEvents()
	FunCampDonateView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnAdd:RemoveClickListener()

	for i, v in ipairs(self._donateItems) do
		v.btn:RemoveClickListener()
	end
end

function FunCampDonateView:onEnter()
	FunCampDonateView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampDonateCoinsRes, self._onDonateCoinsRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampBuyDonateTimesRes, self._onBuyDonateTimesRes, self)

	self._donateType = self:getFirstParam()
	self._activityId = FunCampModel.instance:getActivityId()
	self._cfgActivity = FunCampConfig.instance:getActivityCfg(self._activityId)
	self._donateCfgList = FunCampConfig.instance:getCoinMode(self._activityId, self._donateType)

	local cfgCamp = FunCampConfig.instance:getCampGroupCfg(self._cfgActivity.groupId, FunCampModel.instance:getCampId())

	self._effectCfgList = cfgCamp and FunCampConfig.instance:getCoinEffectCfgList(self._activityId, self._donateType) or {}
	self._targetIndex = 1

	self:_initTitle(self._donateType)
	self:_initDonateItems()
	self:_updateCoinValue()
	self:_updateScoreValue()
	self:_updateScroll()
	self:_updateDonateCount()
	self:_loadBgEffect()
end

function FunCampDonateView:onExit()
	FunCampDonateView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampDonateCoinsRes, self._onDonateCoinsRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampBuyDonateTimesRes, self._onBuyDonateTimesRes, self)
	self:_clearItems()
	self.scrollList:dispose()
	self:_removeBgEffect()
end

function FunCampDonateView:_onClickClose()
	self:close()
end

function FunCampDonateView:_onClickTip()
	if self._donateType == 1 then
		UIStateManager.instance:push(ViewName.RulesView, "funcampdonateview_rule1")
	else
		UIStateManager.instance:push(ViewName.RulesView, "funcampdonateview_rule2")
	end
end

function FunCampDonateView:_onClickAdd()
	FunCampController.instance:onClickAddBuyDonateTimes(self._activityId, self._cfgActivity.donateBuyPlanId, self._cfgActivity.coinDonateTimes, FunCampModel.CoinDonate)
end

function FunCampDonateView:_onDonateCoinsRes()
	self:_updateCoinValue()
	self:_updateScoreValue()
	self:_updateScroll()
	self:_updateDonateCount()
	self:_loadDonateEffect()
end

function FunCampDonateView:_onBuyDonateTimesRes()
	self:_updateDonateCount()
end

function FunCampDonateView:_getTitleDesc(donateType)
	return donateType == FunCampModel.CoinDonate and "金币鼓舞" or "积分掠夺"
end

function FunCampDonateView:_initTitle(donateType)
	self._txtTitle.text = self:_getTitleDesc(donateType)

	local desc1 = CampGameConfig.instance:getParams("COIN_INSPIRE_DESC1")
	local desc2 = CampGameConfig.instance:getParams("COIN_INSPIRE_DESC2")

	self._txtTip.text = donateType == FunCampModel.CoinDonate and desc1 or desc2
end

function FunCampDonateView:_initDonateItems()
	for i, v in ipairs(self._donateItems) do
		local cfg = FunCampConfig.instance:getCoinModeCfg(self._activityId, self._donateType, i)

		if cfg then
			local matType, id, count = MaterialMgr.getMatParams(cfg.cost)

			v.txtCost.text = count

			MaterialMgr.setIcon(v.icon, matType, id)

			local list = MaterialMgr.changeItemStrArr(cfg.reward)

			v.scrollList:reloadData(list)
		end
	end
end

function FunCampDonateView:_clearItems()
	for i, v in ipairs(self._donateItems) do
		MaterialMgr.clearIcon(v.icon)
		v.scrollList:dispose()
	end
end

function FunCampDonateView:_reloadFinish()
	local startX = self._contentRectTrans.rect.width / 2 * -1
	local curViewDatas = self.scrollList:getData()

	for i, v in ipairs(curViewDatas) do
		if self._targetIndex == i then
			local interval = 100

			self:_updateBubblePos(interval * i + startX, v)
			self.scrollList:MoveCellToCenter(i)

			break
		end
	end
end

function FunCampDonateView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "btn/txtDesc")

	txtDesc.text = string.format("%s千万", checknumber(data.progress) / 10000000)
end

function FunCampDonateView:_clearCell(cell)
	return
end

function FunCampDonateView:_donateUpdateCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function FunCampDonateView:_donateClearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function FunCampDonateView:_updateScroll()
	self.scrollList:reloadData(self._effectCfgList)
end

function FunCampDonateView:_updateDonateCount()
	local curTime = FunCampModel.instance:getDonateTimes()
	local maxTime = FunCampModel.instance:getTotalMaxDonateTimes(self._cfgActivity.coinDonateTimes)
	local leftTime = Mathf.Max(maxTime - curTime, 0)

	self._txtDonate.text = string.format("当前可捐献次数：%d/%d", leftTime, self._cfgActivity.coinDonateTimes)
end

function FunCampDonateView:_updateCoinValue()
	local coinNum = checknumber(FunCampModel.instance:getCampCoins(self._donateType, FunCampModel.instance:getCampId()))

	self._txtCoin.text = coinNum >= 10000000 and string.format("%s千万", Mathf.Floor(checknumber(coinNum) / 10000000)) or coinNum

	self:_updateCoinSlider(self._effectCfgList, coinNum)
end

function FunCampDonateView:_updateScoreValue()
	local score = FunCampModel.instance:getCampScore(self._donateType, FunCampModel.instance:getCampId())
	local str = self._donateType == FunCampModel.CoinDonate and "阵营鼓舞值" or "阵营积分值"

	self._txtScore.text = string.format("当前%s：%s", str, score)
end

function FunCampDonateView:_updateCoinSlider(cfgs, coinNum)
	local count = #cfgs
	local num = 0
	local curCoinNum = coinNum
	local intervalValue = 0
	local record1 = 1
	local record2 = 1

	self._targetIndex = 1

	for i, v in ipairs(cfgs) do
		local cfgCoinNum = checknumber(v.progress)

		if cfgCoinNum <= curCoinNum then
			num = num + 1
			record1 = cfgCoinNum
			self._targetIndex = i
		else
			record2 = cfgCoinNum - record1
			intervalValue = curCoinNum - record1
			self._targetIndex = i

			break
		end
	end

	local value = Mathf.Clamp01(num / count + 1 / count * (intervalValue / record2))

	self._coinSlider:SetValue(value)
end

function FunCampDonateView:_updateBubblePos(targetX, cfg)
	if not goutil.isNil(self._bubble) then
		local x, y = Framework.TransformUtil.GetAnchoredPos(self._bubble.transform, 0, 0)

		GameUtil.setAnchoredPos(self._bubble, targetX, y)

		if cfg then
			self._txtDesc.text = cfg.desc
		end
	end
end

function FunCampDonateView:_onClickDonate(donateId)
	FunCampController.instance:onClickDonate(self._donateType, donateId, self._cfgActivity.coinDonateTimes)

	self._donateEffectIndex = donateId
end

function FunCampDonateView:_loadBgEffect()
	self._bgEffect1 = UIEffectManager.instance:playEffect(self, FunCampDonateViewPresentor.Effect1, self._bg1.transform, 0, 0, true, false)

	self._bgEffect1:setParent(self._bg1.transform)
	self._bgEffect1:setScale(1)
	self._bgEffect1:setLocalPos(0, 0, 0)

	self._bgEffect2 = UIEffectManager.instance:playEffect(self, FunCampDonateViewPresentor.Effect2, self._bg2.transform, 0, 0, true, false)

	self._bgEffect2:setParent(self._bg2.transform)
	self._bgEffect2:setScale(1)
	self._bgEffect2:setLocalPos(0, 0, 0)

	self._bgEffect3 = UIEffectManager.instance:playEffect(self, FunCampDonateViewPresentor.Effect3, self._bg3.transform, 0, 0, true, false)

	self._bgEffect3:setParent(self._bg3.transform)
	self._bgEffect3:setScale(1)
	self._bgEffect3:setLocalPos(0, 0, 0)
end

function FunCampDonateView:_removeBgEffect()
	if self._bgEffect1 then
		UIEffectManager.instance:stopEffect(self._bgEffect1)

		self._bgEffect1 = nil
	end

	if self._bgEffect2 then
		UIEffectManager.instance:stopEffect(self._bgEffect2)

		self._bgEffect2 = nil
	end

	if self._bgEffect3 then
		UIEffectManager.instance:stopEffect(self._bgEffect3)

		self._bgEffect3 = nil
	end
end

function FunCampDonateView:_loadDonateEffect()
	local index = Mathf.Clamp(self._donateEffectIndex, 1, 3)

	self._donateEffect = UIEffectManager.instance:playEffectBrief(self, FunCampDonateViewPresentor["DonateEffect" .. index], self["_bg" .. index].transform, false)

	self._donateEffect:setParent(self["_bg" .. index].transform)
	self._donateEffect:setLocalPos(12, 0, 0)
	self._donateEffect:setScale(1)
end

return FunCampDonateView
