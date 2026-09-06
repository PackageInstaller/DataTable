-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recalltask/view/RecallShopView.lua

module("logic.extensions.recalltask.view.RecallShopView", package.seeall)

local RecallShopView = class("RecallShopView", TableViewComponent)

function RecallShopView:ctor()
	RecallShopView.super.ctor(self)
end

function RecallShopView:bindEvents()
	RecallShopView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._xiaohaoBtn:AddClickListener(function()
		CommonTipsMgr.instance:openMaterialTips(self._xiaohaoBtn, MatType.ACTIVITY_ITEM, RecallTaskModel.instance.openActivityId, 0)
	end, self)
end

function RecallShopView:unbindEvents()
	RecallShopView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._xiaohaoBtn:RemoveClickListener()
end

function RecallShopView:onExit()
	RecallShopView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateActiveShopInfo, self._updataShopListAndMaterial, self)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil

	removetimer(self._calculationSurplusTime, self)
end

function RecallShopView:destroyUI()
	RecallShopView.super.destroyUI(self)

	local xhBig = self._xiaohaoIma.gameObject:GetComponent("ImageBigBG")

	if xhBig then
		xhBig:ClearImage()
	end
end

function RecallShopView:buildUI()
	RecallShopView.super.buildUI(self)

	self._closeBtn = self:getBtn("viewInfoGo/viewCloseBtn")

	local xiaohaoGo = self:getGo("viewInfoGo/xiaohaoItem")

	self._xiaohaoIma = goutil.findChild(xiaohaoGo, "xiaohaoIma"):GetComponent("Image")
	self._xiaohaoTxt = goutil.findChildTextComponent(xiaohaoGo, "xiaohaoTxt")
	self._xiaohaoBtn = Framework.ButtonAdapter.GetFrom(xiaohaoGo, "xiaohaoBtn")
	self._timerTxt = goutil.findChildTextComponent(self.mainGO, "viewInfoGo/timerGo/timerTxt")
	self._xiaohaoTxt.text = ""
	self._timerTxt.text = ""
end

function RecallShopView:onEnter()
	RecallShopView.super.onEnter(self)

	local choiseNum = self:getFirstParam()
	local str = "RecallShopRedpoint" .. choiseNum
	local value = GameUtil.getUserDayData(str)

	if value ~= 1 and RecallTaskModel.instance:isCanBuyCommodity(choiseNum == 2) then
		GameUtil.saveUserDayData(str, 1)

		if choiseNum == 1 then
			GlobalDispatcher:dispatch(GlobalNotify.PR_UpdataPlayerReturnRed, 5)
		end
	end

	GlobalDispatcher:addListener(GlobalNotify.UpdateActiveShopInfo, self._updataShopListAndMaterial, self)
	MaterialMgr.setIcon(self._xiaohaoIma, MatType.ACTIVITY_ITEM, RecallTaskModel.instance.openActivityId)

	self._curViewDatas, self._shopName = RecallTaskConfig.instance:getRecallShopsCfgs(choiseNum)

	self:_updataShopListAndMaterial()

	self._endTime = -1

	self:_showActivityTimer()
	ActivityshopController.instance:getAllShopItemInfo(RecallTaskModel.instance.openActivityType, RecallTaskModel.instance.openActivityId)

	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.mainGO.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
end

function RecallShopView:_updataShopListAndMaterial()
	local count = MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, RecallTaskModel.instance.openActivityId)

	self._xiaohaoTxt.text = tostring(count)

	self._tableview:ReloadData()
end

function RecallShopView:_showActivityTimer()
	removetimer(self._calculationSurplusTime, self)

	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(RecallTaskModel.instance.openActivityType, RecallTaskModel.instance.openActivityId)
	local nowTime = ServerTime.nowServerLook()

	if etime <= nowTime then
		self._timerTxt.text = "活动结束"
		self._endTime = -1

		return
	end

	self._endTime = etime

	if nowTime < self._endTime then
		self:_calculationSurplusTime()
		settimer(1, self._calculationSurplusTime, self, true)
	end
end

function RecallShopView:_calculationSurplusTime()
	local supTime = self._endTime - ServerTime.nowServerLook()

	if supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timerTxt.text = "活动结束"
		self._endTime = -1

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self._timerTxt.text = day > 0 and string.format("剩余时间: %s天%s时%s分", day, hour, min) or string.format("剩余时间： %s时%s分%s秒", hour, min, sec)
end

function RecallShopView:_getPath()
	return {
		cellPath = "viewInfoGo/cellItem",
		viewPath = "viewInfoGo/cellItemSR"
	}
end

function RecallShopView:_cellSize()
	return 160, 208
end

function RecallShopView:_updateCell(view, cell, data)
	local limitTxt = goutil.findChildTextComponent(cell, "limitTxt")
	local goodsPos = goutil.findChild(cell, "iconGo")
	local costTxt = goutil.findChildTextComponent(cell, "costTxt")
	local costImaGo = goutil.findChild(cell, "costTxt/costIma")
	local buyOutGo = goutil.findChild(cell, "buyOutGo")

	MaterialMgr.resetAll(goodsPos)
	MaterialMgr.resetAll(costImaGo)
	GameUtil.asBtn(cell):RemoveClickListener()

	local sellOut = false
	local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(data.activityType, data.activityId, data.shopItemId)

	if data.sellPeriodLimit ~= "none" then
		sellOut = buyTime >= data.sellLimitCount
	end

	local limitStr = self:_getLimitTypeStr(data.sellPeriodLimit)

	limitTxt.text = string.nilorempty(limitStr) and "" or sellOut and string.format(limitStr, 0, data.sellLimitCount) or string.format(limitStr, data.sellLimitCount - buyTime, data.sellLimitCount)

	buyOutGo:SetActive(sellOut)
	MaterialMgr.setCellByCfg(data.sellContent, goodsPos)

	local prizes = string.split(data.sellPrice, ":")

	costTxt.text = prizes[3]

	MaterialMgr.setIcon(costImaGo, checknumber(prizes[1]), checknumber(prizes[2]))
	GameUtil.asBtn(cell):AddClickListener(function()
		if checknumber(self._endTime) <= 0 then
			FloatWordMgr.instance:show("活动已结束")

			return
		end

		if sellOut then
			FloatWordMgr.instance:show(lang("text_recall_desc_6"))

			return
		end

		local haveNum = MaterialModel.instance:getMaterialsNumber(checknumber(prizes[1]), checknumber(prizes[2]))

		if haveNum < checknumber(prizes[3]) then
			local cfg = MaterialMgr.getMatCfg(checknumber(prizes[1]), checknumber(prizes[2]))

			if cfg then
				if not cfg.mame then
					local name = lang("text_currency_name")

					FloatWordMgr.instance:show(langPara("text_mirror_desc_6", name))
				end
			end
		else
			UIStateManager.instance:push(ViewName.ActivityshopexchangebuyView, data.activityType, data.activityId, data.shopItemId)
		end
	end, self)
end

function RecallShopView:_getLimitTypeStr(str)
	if string.nilorempty(str) or str == "none" then
		return
	end

	if str == "daily" then
		return "每日限购 %s/%s"
	end

	if str == "allTime" then
		return "活动限购 %s/%s"
	end

	if str == "weekly" then
		return "每周限购 %s/%s"
	end
end

return RecallShopView
