-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/festiveflower/view/FestiveFlowerGainView.lua

module("logic.extensions.festiveflower.view.FestiveFlowerGainView", package.seeall)

local FestiveFlowerGainView = class("FestiveFlowerGainView", TableViewComponent)

function FestiveFlowerGainView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableView"
	}
end

function FestiveFlowerGainView:_cellSize(view, index)
	return 132, 64
end

function FestiveFlowerGainView:ctor()
	FestiveFlowerGainView.super.ctor(self)
end

function FestiveFlowerGainView:unbindEvents()
	FestiveFlowerGainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FestiveFlowerGainView:bindEvents()
	FestiveFlowerGainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function FestiveFlowerGainView:buildUI()
	FestiveFlowerGainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function FestiveFlowerGainView:onExit()
	FestiveFlowerGainView.super.onExit(self)

	local controller = FestiveFlowerController.instance

	controller:unregisterLocalNotify(FestiveFlowerController.E_FlowerInfoRes, self._updateAll, self)
	controller:unregisterLocalNotify(FestiveFlowerController.E_BuyFlowerRes, self._updateAll, self)
	controller:unregisterLocalNotify(FestiveFlowerController.E_FreeFlowerRes, self._updateAll, self)
	GlobalDispatcher:removeListener(GlobalNotify.NotifyPayShopItemBuySucRes, self._updateAll, self)

	self._flowerDefineMap = {}
end

function FestiveFlowerGainView:onEnter()
	FestiveFlowerGainView.super.onEnter(self)

	local controller = FestiveFlowerController.instance

	controller:registerLocalNotify(FestiveFlowerController.E_FlowerInfoRes, self._updateAll, self)
	controller:registerLocalNotify(FestiveFlowerController.E_BuyFlowerRes, self._updateAll, self)
	controller:registerLocalNotify(FestiveFlowerController.E_FreeFlowerRes, self._updateAll, self)
	GlobalDispatcher:addListener(GlobalNotify.NotifyPayShopItemBuySucRes, self._updateAll, self)

	self._activityId = FestiveFlowerModel.instance:getActivityId()

	local activityConf = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.FESTIVE_FLOWER, self._activityId)

	if not activityConf or not GameUtil.checkIsInTimePeriod(activityConf.startTime, activityConf.endTime) then
		FloatWordMgr.instance:show(lang("FirePowerContestMainView__2"))
		self:close()

		return
	end

	self._flowerDefineMap = {}

	local sendFlowerConfigs = SendFlowerConfig.instance:getFlowerCfg()

	for i, flowerConfig in ipairs(sendFlowerConfigs) do
		local content = flowerConfig.content

		if not string.nilorempty(content) then
			local matType, id, matNum = MaterialMgr.getMatParams(content)

			self._flowerDefineMap[id] = flowerConfig
		end
	end

	self._flowerConfigs = FestiveFlowerConfig.instance:getFlowerItemConfigs(self._activityId) or {}

	FestiveFlowerAgent.instance:sendPM_FestiveFlowerFlowerInfoReq(self._activityId)
end

function FestiveFlowerGainView:_updateAll()
	self:updateListData(self._flowerConfigs)
end

function FestiveFlowerGainView:_updateCell(view, cell, data)
	local model = FestiveFlowerModel.instance
	local item = goutil.findChild(cell, "item")
	local btnBuyOrGainGo = goutil.findChild(cell, "btnBuyOrGain")
	local txtDiscount = goutil.findChildTextComponent(cell, "txtDiscount")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtHaveCount = goutil.findChildTextComponent(cell, "txtHaveCount")
	local txtGetWayGo = goutil.findChild(cell, "txtGetWay")
	local txtGetWay = goutil.findChildTextComponent(cell, "txtGetWay")
	local daibiItemGo = goutil.findChild(cell, "daibiItem")
	local daibiIconIma = goutil.findChild(daibiItemGo, "daibiIconIma")
	local daibiCountTxt = goutil.findChildTextComponent(daibiItemGo, "daibiCountTxt")
	local txtLimit = goutil.findChildTextComponent(cell, "btnBuyOrGain/txt")

	MaterialMgr.clearIcon(daibiIconIma)
	MaterialMgr.resetAll(item)

	local isUseShopCfg = checknumber(data.commodityId) > 0
	local payCfg = isUseShopCfg and PayShopConfig.instance:getPayShopGoodsCfgById(data.commodityId) or {}
	local hasBuyTime = model:getBuyTime(data.flowerId)

	if not data.limitTimes then
		local limitBuyTimes = 0
		local remainBuyTime = limitBuyTimes - hasBuyTime
		local bNotEnoughBuyTime = remainBuyTime <= 0
		local isGray = false

		if isUseShopCfg then
			local times = PayShopModel.instance:getMibaoBuyTimesById(data.commodityId)
			local limitTimes = payCfg.limitTimes

			remainBuyTime = limitTimes - times
			bNotEnoughBuyTime = limitTimes - times <= 0

			if string.nilorempty(payCfg.originalGoodsId) then
				goutil.setActive(daibiItemGo, false)
				goutil.setActive(txtGetWayGo, true)

				txtGetWay.text = data.getway or ""

				goutil.setActive(btnBuyOrGainGo, true)

				if limitTimes > 0 then
					isGray = bNotEnoughBuyTime

					GameUtil.setBtnState(btnBuyOrGainGo, txtLimit, bNotEnoughBuyTime)
				else
					GameUtil.setBtnState(btnBuyOrGainGo, txtLimit, false)
				end
			else
				local matType, id, matNum = MaterialMgr.getMatParams(PayShopModel.instance:getBuyItemMinCostPayGoodsId(data.commodityId))

				daibiCountTxt.text = tostring(matNum)

				MaterialMgr.setIcon(daibiIconIma, matType, id)

				txtLimit.text = langPara(data.btnName, remainBuyTime, limitTimes)

				GameUtil.setBtnState(btnBuyOrGainGo, txtLimit, bNotEnoughBuyTime)
				goutil.setActive(daibiItemGo, not bNotEnoughBuyTime)
				goutil.setActive(txtGetWayGo, false)

				isGray = bNotEnoughBuyTime
			end
		elseif string.nilorempty(data.consume) then
			goutil.setActive(daibiItemGo, false)
			goutil.setActive(txtGetWayGo, true)

			txtGetWay.text = data.getway or ""

			goutil.setActive(btnBuyOrGainGo, true)

			txtLimit.text = data.btnName

			if limitBuyTimes > 0 then
				isGray = bNotEnoughBuyTime

				GameUtil.setBtnState(btnBuyOrGainGo, txtLimit, bNotEnoughBuyTime)
			else
				GameUtil.setBtnState(btnBuyOrGainGo, txtLimit, false)
			end
		else
			local matType, id, matNum = MaterialMgr.getMatParams(data.consume)

			daibiCountTxt.text = tostring(matNum)

			MaterialMgr.setIcon(daibiIconIma, matType, id)

			txtLimit.text = langPara(data.btnName, remainBuyTime, limitBuyTimes)

			GameUtil.setBtnState(btnBuyOrGainGo, txtLimit, bNotEnoughBuyTime)
			goutil.setActive(daibiItemGo, not bNotEnoughBuyTime)
			goutil.setActive(txtGetWayGo, false)

			isGray = bNotEnoughBuyTime
		end

		txtHaveCount.text = langPara("已拥有：%d", MaterialMgr.getMatCount(data.content))
		txtDiscount.text = data.discount or ""

		local _, flowerItemId, _ = MaterialMgr.getMatParams(data.content)
		local flowerDefine = self._flowerDefineMap[flowerItemId]

		if flowerDefine then
			local actConfig = FestiveFlowerConfig.instance:getFestiveFlowerActConf(FestiveFlowerModel.instance:getActivityId())

			txtName.text = langPara("增加魅力值：%d", flowerDefine.value * actConfig.ratio)
		else
			txtName.text = ""
		end

		MaterialMgr.setCellByCfg(data.content, item)
		GameUtil.rmClickHandler(GameUtil.asBtn(btnBuyOrGainGo))

		if not isGray then
			GameUtil.addClickHandler(GameUtil.asBtn(btnBuyOrGainGo), function()
				if isUseShopCfg then
					local costCfg, disCountPlanId = PayShopModel.instance:getBuyItemMinCostPayGoodsId(data.commodityId)
					local matType, id, matNum = MaterialMgr.getMatParams(costCfg)
					local count = MaterialMgr.getMatCount(costCfg)
					local name = MaterialMgr.getMaterialsNameByCfg(data.content)
					local costName = MaterialMgr.getMaterialsName(matType, id)

					if matNum <= count then
						local function okFunc()
							PayShopController.instance:buyShopItem(data.commodityId, 1, disCountPlanId)
						end

						local function cencelFunc()
							return
						end

						local tipsContent = string.format("确定要花费%s%s，购买1个%s吗？", matNum, costName, name)

						TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
					else
						MaterialMgr.openGetSourceByStr(payCfg.originalGoodsId)
					end
				elseif not string.nilorempty(data.consume) then
					self:buyFlower(data)
				elseif checknumber(data.chatTextPlanId) > 0 then
					self:_gainFreeFlower(data)
				else
					self:close()
					GotoMgr.gotoByString(data.jumpTo)
				end
			end, self)
		end
	end
end

function FestiveFlowerGainView:_gainFreeFlower(data)
	local function doIt()
		local content = FestiveFlowerConfig.instance:randomWord(self._activityId, data.chatTextPlanId)

		self:close()
		UIStateManager.instance:push(ViewName.chat, GameEnum.ChatChannel.World, content)
	end

	TipsFacade.instance:openTipWindow(lang("FestiveFlowerGainView__2"), lang("FestiveFlowerGainView__1"), doIt, lang("前往"))
end

local RememberBuyKey = "FestiveFlowerGainView_RememberBuyKey"

function FestiveFlowerGainView:buyFlower(data)
	local function doIt()
		FestiveFlowerController.instance:reqBuyFlower(data.flowerId)
	end

	local function funcTog()
		GameUtil.saveUserDayData(RememberBuyKey, true)
	end

	if not GameUtil.getUserDayData(RememberBuyKey) then
		local model = FestiveFlowerModel.instance
		local hasBuyTime = model:getBuyTime(data.flowerId)

		if not data.limitTimes then
			local limitBuyTimes = 0
			local materialName = MaterialMgr.getMaterialsNameByCfg(data.content)
			local matType, id, matNum = MaterialMgr.getMatParams(data.consume)
			local content = langPara("确定花费<color=#d44c28>%d%s</color>购买%s吗？\n<size=20>每天最多可购买%d次，还能购买%d次</size>", matNum, MaterialMgr.getMaterialsName(matType, id), materialName, limitBuyTimes, math.max(limitBuyTimes - hasBuyTime, 0))
			local togText = lang("FestiveFlowerMainView__2")

			TipsFacade.instance:openPopupCostMatViewNew(matType, id, matNum, content, doIt, funcTog, togText)
		end
	else
		doIt()
	end
end

function FestiveFlowerGainView:_clearTableview(cell)
	local daibiItemGo = goutil.findChild(cell, "daibiItem")
	local daibiIconIma = goutil.findChild(daibiItemGo, "daibiIconIma")
	local btnBuyOrGainGo = goutil.findChild(cell, "btnBuyOrGain")
	local item = goutil.findChild(cell, "item")

	MaterialMgr.clearIcon(daibiIconIma)
	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(GameUtil.asBtn(btnBuyOrGainGo))
end

return FestiveFlowerGainView
