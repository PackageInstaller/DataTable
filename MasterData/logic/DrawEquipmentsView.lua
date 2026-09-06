-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawequipments/view/DrawEquipmentsView.lua

module("logic.extensions.drawequipments.view.DrawEquipmentsView", package.seeall)

local DrawEquipmentsView = class("DrawEquipmentsView", ViewComponent)

function DrawEquipmentsView:buildUI()
	DrawEquipmentsView.super.buildUI(self)

	self._viewBgImg = self:getGo("viewBgIma")

	local upShowGo = self:getGo("upShowGo")

	self._btnClose = Framework.ButtonAdapter.GetFrom(upShowGo, "viewCloseBtn")
	self._daibiIma = goutil.findChild(upShowGo, "daibiItem/daibiIconIma"):GetComponent("Image")
	self._daibiTxt = goutil.findChild(upShowGo, "daibiItem/daibiCountTxt"):GetComponent("Text")
	self._daibiBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "daibiItem/daibiAddBtn")
	self._diamondTxt = goutil.findChild(upShowGo, "diamondItem/diamondCountTxt"):GetComponent("Text")
	self._diamondBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "diamondItem/diamondAddBtn")
	self._btnRewardsReview = self:getBtn("viewDownTran/rewardsReview")
	self._btnComposed = self:getBtn("viewDownTran/btnComposed")
	self._btnDecomposed = self:getBtn("viewDownTran/btnDecomposed")
	self._suptimeNode = self:getGo("suptimebg")
	self._supTimeTxt = self:getTxt("suptimebg/supTimeTxt")

	self:_initDiscountNode()
	self:_initPoolsView()
	self:_initShowEquipments()
	self:_initDrawCycleInfo()
	self:_initDrawInfo()
	self:_initProgressPrize()

	local txtTitle = goutil.findChildTextComponent(upShowGo, "txtTitle")
	local txtReview = self:getTxt("viewDownTran/rewardsReview/Text")

	txtTitle.text = lang("drawequipments_title")
	txtReview.text = lang("text_rewards_review_linefeed")
	self.btn_1 = self:getGo("btn_1")
	self.btn_2 = self:getGo("btn_2")

	self:setSelectBtn(self.btn_1, false)
	self:setSelectBtn(self.btn_2, true)
end

function DrawEquipmentsView:_initDiscountNode()
	self._btnDiscount = self:getBtn("viewDownTran/btnDiscount")
	self._discountIcon = self:getGo("viewDownTran/btnDiscount/shopIconIma")
	self._discountTag = self:getTxt("viewDownTran/btnDiscount/shopZheTxt")
	self._discountName = self:getTxt("viewDownTran/btnDiscount/shopNameTxt")
end

function DrawEquipmentsView:_initProgressPrize()
	self._progressPrize = self:getGo("progressPrize")
	self._progressView = self:getGo("progressPrize/progressPrizeView"):GetComponent(ComponentType.ScrollRect)
	self._progressTxt = self:getTxt("progressPrize/progressTxt")
	self._cellProgressItem = self:getGo("progressPrize/cellProgressItem")
	self._prizeViewContent = self:getGo("progressPrize/progressPrizeView/Viewport/Content").transform
	self._prizeProgressBar = Framework.SliderAdapter.GetFrom(self._prizeViewContent.gameObject, "progBar")
	self._progressStart = goutil.findChild(self._prizeViewContent.gameObject, "progressStart")
	self._progressEnd = goutil.findChild(self._prizeViewContent.gameObject, "progressEnd")

	self._cellProgressItem:SetActive(false)

	local viewPort = self:getGo("progressPrize/progressPrizeView/Viewport").transform

	self._progressBarSize = self._prizeProgressBar.transform.sizeDelta.x
	self._prizeViewContentSize = viewPort.rect.height
end

function DrawEquipmentsView:_initPoolsView()
	self._poolsViewContent = self:getGo("poolsView/Viewport/Content").transform

	local poolsNode = self:getGo("poolsView/Viewport/Content/poolsNode")

	self._poolsLayout = poolsNode:GetComponent(ComponentType.UILayoutSingleLine)
end

function DrawEquipmentsView:_initShowEquipments()
	local equipmentsNode = self:getGo("equipments")

	self._equipments = {}

	for i = 1, equipmentsNode.transform.childCount do
		local go = equipmentsNode.transform:GetChild(i - 1).gameObject

		if go then
			self._equipments[i] = {}
			self._equipments[i].itemGo = go
			self._equipments[i].itemIma = goutil.findChild(go, "equipIma"):GetComponent("Image")
			self._equipments[i].attrIma = goutil.findChild(go, "attrIma"):GetComponent("UIImageSpriteChange")
		end
	end
end

function DrawEquipmentsView:_initDrawCycleInfo()
	local viewDownGo = self:getGo("viewDownTran")

	self._cycleDesIma = goutil.findChild(viewDownGo, "cycleDesIma"):GetComponent(ComponentType.UIImageSpriteChange)
	self._cycleNum_1 = goutil.findChild(viewDownGo, "cycleCountGo/cycleNum_1"):GetComponent(ComponentType.UIImageSpriteChange)
	self._cycleNum_2 = goutil.findChild(viewDownGo, "cycleCountGo/cycleNum_2"):GetComponent(ComponentType.UIImageSpriteChange)
end

function DrawEquipmentsView:_initDrawInfo()
	local viewDownGo = self:getGo("viewDownTran")

	self._oneNeedGo = goutil.findChild(viewDownGo, "oneNeedGo")
	self._oneNeedTxtNum = goutil.findChildTextComponent(self._oneNeedGo, "oneNeedNum")
	self._tenNeedGo = goutil.findChild(viewDownGo, "tenNeedGo")
	self._tenNeedTxtNum = goutil.findChildTextComponent(self._tenNeedGo, "tenNeedNum")
	self._btnDrawOnce = self:getBtn("viewDownTran/oneClickBtn")
	self._btnDrawTen = self:getBtn("viewDownTran/tenClickBtn")
	self._tenRedPoint = self:getGo("viewDownTran/tenClickBtn/tenRedGo")
	self._oneNeedIcon = self:getGo("viewDownTran/oneNeedGo/icon")
	self._tenNeedIcon = self:getGo("viewDownTran/tenNeedGo/icon")

	local oneNeedTxt = goutil.findChildTextComponent(self._oneNeedGo, "oneNeedTxt")
	local tenNeedTxt = goutil.findChildTextComponent(self._tenNeedGo, "tenNeedTxt")
	local oneDesTxt = goutil.findChildTextComponent(self._btnDrawOnce.gameObject, "oneDesTxt")
	local tenDesTxt = goutil.findChildTextComponent(self._btnDrawTen.gameObject, "tenDesTxt")

	oneNeedTxt.text = lang("text_cost_tips")
	tenNeedTxt.text = lang("text_cost_tips")

	local drawTypeTimes = DrawEquipmentsConfig.instance:getDrawTypeTimes()
	local times = string.split(drawTypeTimes, ",")

	self._drawOnceTimesNum = checknumber(times[1])
	self._drawTenTimesNum = checknumber(times[2])
	oneDesTxt.text = string.format(lang("drawequipments_draw_numtips"), self._drawOnceTimesNum)
	tenDesTxt.text = string.format(lang("drawequipments_draw_numtips"), self._drawTenTimesNum)
end

function DrawEquipmentsView:bindEvents()
	DrawEquipmentsView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnDrawOnce:AddClickListener(self._onClickDrawOnce, self)
	self._btnDrawTen:AddClickListener(self._onClickDrawTen, self)
	self._btnComposed:AddClickListener(self._onClickComposed, self)
	self._btnRewardsReview:AddClickListener(self._onClickRewardsReview, self)
	self._btnDecomposed:AddClickListener(self._onClickDecomposed, self)
	self._btnDiscount:AddClickListener(self._onClickDiscount, self)
	self._daibiBtn:AddClickListener(self._onClickDaibiBtn, self)
	self._diamondBtn:AddClickListener(self._onClickDiamondBtn, self)
	GameUtil.addClickHandler(self.btn_1, self.clickJumpFunc, self)
end

function DrawEquipmentsView:unbindEvents()
	DrawEquipmentsView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnDrawOnce:RemoveClickListener()
	self._btnDrawTen:RemoveClickListener()
	self._btnComposed:RemoveClickListener()
	self._btnRewardsReview:RemoveClickListener()
	self._btnDecomposed:RemoveClickListener()
	self._btnDiscount:RemoveClickListener()
	self._daibiBtn:RemoveClickListener()
	self._diamondBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self.btn_1)
end

function DrawEquipmentsView:onEnter()
	DrawEquipmentsView.super.onEnter(self)

	self._openPoolId = nil

	self:_initParams()
	self:_refreshPoolsView()

	self._openPoolId = self._openPoolId or self._pools[1]:getPoolId()

	self:_selectPool(self._openPoolId)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._onCurrencyCountChange, self)
	GlobalDispatcher:addListener(GlobalNotify.OnDrawEquipmentDrawBack, self._onDrawEquipmentDrawBack, self)
	GlobalDispatcher:addListener(GlobalNotify.OnDrawEquipmentsInfo, self._onDrawEquipmentsInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._updataShowDaibi, self)
end

function DrawEquipmentsView:setSelectBtn(btn, boo)
	local unselect = goutil.findChild(btn, "unselect")
	local selected = goutil.findChild(btn, "selected")

	GameUtil.SetActive(selected, boo)
	GameUtil.SetActive(unselect, not boo)
end

function DrawEquipmentsView:clickJumpFunc()
	local funcId = 43

	if FuncOpenModel.instance:getFuncIsOpen(funcId) then
		FuncOpenController.instance:openFunc(funcId)
		self:close()
	end
end

function DrawEquipmentsView:_initParams()
	local openParams = self:getOpenParam()

	if openParams then
		self._openPoolId = openParams[1]
	end

	self._openPoolId = self._openPoolId or DrawEquipmentsController.instance:getLastOpenPoolId()

	local currOpenPools = DrawEquipmentsModel.instance:getCurrOpenPools()

	for i = 1, #currOpenPools do
		if currOpenPools[i]:getPoolId() == checknumber(self._openPoolId) and not currOpenPools[i]:isPoolPreheat() then
			break
		end
	end

	self._openPoolId = self._openPoolId or currOpenPools[1]:getPoolId()
	self._hasDrawInfoRespond = false

	UIStateManager.instance:updateParms(self._viewPresentor.viewName)
end

function DrawEquipmentsView:_checkTryOpenPoolOpened()
	if self._tryOpenPoolId and self._tryOpenPoolId ~= self._openPoolId then
		-- block empty
	end
end

function DrawEquipmentsView:onExit()
	removetimer(self._tickSurplusTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._onCurrencyCountChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnDrawEquipmentDrawBack, self._onDrawEquipmentDrawBack, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnDrawEquipmentsInfo, self._onDrawEquipmentsInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._updataShowDaibi, self)
	DrawEquipmentsView.super.onExit(self)
end

function DrawEquipmentsView:onExitFinished()
	self._selectPoolId = nil
	self._openPoolId = nil
	self._tryOpenPoolId = nil
	self._currProgressPrize = nil

	for i = 1, #self._equipments do
		MaterialMgr.clearIcon(self._equipments[i].itemIma)
	end

	if self._progressItemsNode then
		for i = 1, #self._progressItemsNode do
			local goodsGo = goutil.findChild(self._progressItemsNode[i], "goodsGo")

			MaterialMgr.resetAll(goodsGo)
		end
	end

	MaterialMgr.clearIcon(self._oneNeedIcon)
	MaterialMgr.clearIcon(self._tenNeedIcon)
	MaterialMgr.clearIcon(self._daibiIma)
	uGuiUtil.clearImage(self._viewBgImg)
	uGuiUtil.clearImage(self._discountIcon)
	MaterialMgr.resetAll(self._discountIcon)
	DrawEquipmentsView.super.onExitFinished(self)
end

function DrawEquipmentsView:_refreshPoolsView()
	self._pools = DrawEquipmentsModel.instance:getCurrOpenPools()

	local poolsNum = #self._pools
	local transform = self._poolsLayout.transform
	local childCount = transform.childCount

	while childCount < poolsNum do
		UGUIToolHelper.AddChild(transform.gameObject, transform:GetChild(0).gameObject)

		childCount = childCount + 1
	end

	for i = 1, poolsNum do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(true)

		local pool = self._pools[i]

		self:_refreshPool(go, pool)
	end

	for i = poolsNum + 1, childCount do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	self._poolsLayout:Layout()
	self:_adjustPoolScrollView(childCount)
end

function DrawEquipmentsView:_adjustPoolScrollView(cnt)
	local contentSize = cnt * self._poolsLayout.verticalSpace
	local sizeDelta = self._poolsViewContent.sizeDelta

	sizeDelta.y = contentSize + 10
	self._poolsViewContent.sizeDelta = sizeDelta
end

function DrawEquipmentsView:_refreshPool(go, pool)
	local btn = Framework.ButtonAdapter.Get(go)
	local nameTxt = goutil.findChildTextComponent(go, "nameTxt")
	local selectGo = goutil.findChild(go, "choiseGo")
	local redpointGo = goutil.findChild(go, "redpointGo")
	local locakGo = goutil.findChild(go, "locakGo")
	local lockTxt = goutil.findChildTextComponent(locakGo, "lockTxt")
	local openGo = goutil.findChild(go, "openGo")

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self:_selectPool(pool:getPoolId())
	end)

	nameTxt.text = pool:getPoolTabName()

	local x, y = pool:getPoolTabNamePos()

	Framework.TransformUtil.SetLocalPos(nameTxt.gameObject.transform, x, y, 0)
	selectGo:SetActive(pool:getPoolId() == self._selectPoolId)

	if pool:isPoolPreheat() then
		openGo:SetActive(false)
		locakGo:SetActive(true)

		lockTxt.text = pool:poolTimerDesc()

		redpointGo:SetActive(false)
	else
		lockTxt.text = ""

		locakGo:SetActive(false)
		openGo:SetActive(pool:getPoolId() > 1)

		local matType, matId, matNum = pool:getConsume()

		redpointGo:SetActive(matType ~= 0 and MaterialModel.instance:getMaterialsNumber(matType, matId) >= matNum * self._drawTenTimesNum)
	end
end

function DrawEquipmentsView:_refreshDrawInfo(pool)
	local matType, matId, matNum = pool:getConsume()

	if matType == 0 then
		self._oneNeedGo:SetActive(false)
		self._tenNeedGo:SetActive(false)

		return
	end

	self._oneNeedGo:SetActive(true)
	self._tenNeedGo:SetActive(true)

	self._oneNeedTxtNum.text = tostring(matNum * self._drawOnceTimesNum)
	self._tenNeedTxtNum.text = tostring(matNum * self._drawTenTimesNum)

	MaterialMgr.setIcon(self._oneNeedIcon, matType, matId)
	MaterialMgr.setIcon(self._tenNeedIcon, matType, matId)

	local hasNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	self._tenRedPoint:SetActive(hasNum >= matNum * self._drawTenTimesNum)
end

function DrawEquipmentsView:_refreshGiftNode(pool)
	self._currGiftMo = pool:getActiveGiftMo()

	if not self._currGiftMo then
		self._btnDiscount.gameObject:SetActive(false)

		return
	end

	self._btnDiscount.gameObject:SetActive(true)

	self._discountName.text = self._currGiftMo.giftName
	self._discountTag.text = self._currGiftMo.label

	uGuiUtil.clearImage(self._discountIcon)
	MaterialMgr.resetAll(self._discountIcon)

	if self._currGiftMo.giftType == 1 then
		MaterialMgr.updateItemByStr(self._discountIcon, self._currGiftMo.giftIcon)
	else
		uGuiUtil.setSpriteToImage(self._discountIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(self._currGiftMo.giftIcon))
	end
end

function DrawEquipmentsView:_refreshProgressPrize(pool)
	local prize = pool:getProgressPrize()

	self._currProgressPrize = nil

	if not prize then
		self._progressPrize:SetActive(false)

		return
	end

	Framework.TransformUtil.SetAnchoredPos(self._prizeViewContent, 0, 0)
	self._progressPrize:SetActive(true)

	self._currProgressPrize = {}

	for k, v in pairs(prize) do
		table.insert(self._currProgressPrize, v)
	end

	table.sort(self._currProgressPrize, function(x, y)
		return x.times < y.times
	end)
	self:_refreshProgressPrizeProgress(pool)
end

function DrawEquipmentsView:_refreshProgressPrizeProgress(pool)
	self._progressItemsNode = self._progressItemsNode or {}

	local nodeCnt = #self._progressItemsNode
	local prizeNum = #self._currProgressPrize

	while nodeCnt < prizeNum do
		local node = UGUIToolHelper.AddChild(self._prizeViewContent.gameObject, self._cellProgressItem)

		nodeCnt = nodeCnt + 1

		table.insert(self._progressItemsNode, node)
	end

	local startX, startY = Framework.TransformUtil.GetLocalPos(self._progressStart.transform, nil, nil, nil)
	local endX, endY = Framework.TransformUtil.GetLocalPos(self._progressEnd.transform, nil, nil, nil)
	local progressUnit = 3
	local maxTimes = self._currProgressPrize[#self._currProgressPrize].times
	local maxPrizePos = startY + maxTimes * progressUnit

	if maxPrizePos < endY then
		maxPrizePos = endY
		progressUnit = (endY - startY) / maxTimes
	end

	local drawTimes = pool:getDrawTimes()
	local currShowNodeY = startY

	for i = 1, prizeNum do
		local go = self._progressItemsNode[i]
		local prize = self._currProgressPrize[i]

		go:SetActive(true)
		self:_fillProgressPrizeItemNode(go, prize, pool)

		local posY = startY + progressUnit * prize.times

		Framework.TransformUtil.SetLocalPos(go.transform, startX, posY, 0)

		if drawTimes > prize.times then
			currShowNodeY = posY
		end
	end

	for i = prizeNum + 1, nodeCnt do
		local go = self._progressItemsNode[i]

		go:SetActive(false)
	end

	local deltaSize = math.max(0, maxPrizePos - endY)
	local contentSize = self._prizeViewContentSize + deltaSize
	local sizeDelta = self._prizeProgressBar.transform.sizeDelta

	sizeDelta.x = self._progressBarSize + deltaSize
	self._prizeProgressBar.transform.sizeDelta = sizeDelta
	sizeDelta = self._prizeViewContent.sizeDelta
	sizeDelta.y = contentSize
	self._prizeViewContent.sizeDelta = sizeDelta

	self._prizeProgressBar:SetValue(drawTimes / maxTimes)

	self._progressTxt.text = string.format(lang("drawequipments_hasdraw_numtips"), drawTimes)

	local yPos = math.max(math.min(0, -currShowNodeY), -contentSize + self._prizeViewContentSize)

	Framework.TransformUtil.SetAnchoredPos(self._prizeViewContent, 0, yPos)
end

function DrawEquipmentsView:_fillProgressPrizeItemNode(go, data, pool)
	local drawTimes = pool:getDrawTimes()
	local goodsGo = goutil.findChild(go, "goodsGo")
	local cellCountTxt = goutil.findChildTextComponent(go, "cellCountTxt")
	local cellStageIma = goutil.findChildComponent(go, "cellStageIma", ComponentType.UIChangeGroup)
	local lingquGo = goutil.findChild(go, "lingquGo")

	MaterialMgr.resetAll(goodsGo)

	if not string.nilorempty(data.prize) then
		local goodsList = string.split(data.prize, ":")
		local matType = checknumber(goodsList[1])
		local proxy = MaterialMgr.setCell(matType, checknumber(goodsList[2]), goodsGo)

		proxy.binder:setNum(checknumber(goodsList[3]))
	end

	cellCountTxt.text = data.times

	if drawTimes >= data.times then
		cellStageIma:SetState(1)
		lingquGo:SetActive(true)
	else
		cellStageIma:SetState(0)
		lingquGo:SetActive(false)
	end
end

function DrawEquipmentsView:_selectPool(poolId)
	if self._selectPoolId == poolId then
		return
	end

	local pool = DrawEquipmentsModel.instance:getPoolById(poolId)

	if pool:isPoolPreheat() then
		FloatWordMgr.instance:show(lang("drawequip_open_tips"))

		return
	end

	self._selectPoolId = poolId

	uGuiUtil.setSpriteToImage(self._viewBgImg, uGuiUtil.LoaderType_BigBg, pool:getPoolBgk())
	self:_showEquipments(pool)
	self:_updateCycleDrawNum(pool)
	self:_refreshDrawInfo(pool)
	self:_refreshProgressPrize(pool)
	self:_refreshGiftNode(pool)
	self:_refreshPoolsView()
	self:_updataShowDaibi(pool)
	DrawEquipmentsController.instance:setLastOpenPoolId(poolId)

	if not pool:isDataReady() and not self._hasDrawInfoRespond then
		DrawEquipmentsController.instance:getEquipmentPoolInfoReq()
	end

	self:_refreshSurplusTimeNode(pool)
end

function DrawEquipmentsView:_refreshSurplusTimeNode(pool)
	removetimer(self._tickSurplusTime, self)

	if pool:getPoolId() == 1 then
		self._suptimeNode:SetActive(false)

		return
	end

	local endTime = pool:getEndTimeStamp()

	self._suptimeNode:SetActive(endTime > 0)

	if endTime > 0 then
		settimer(0, self._tickSurplusTime, self)
		self:_tickSurplusTime()
	end
end

function DrawEquipmentsView:_tickSurplusTime()
	local pool = DrawEquipmentsModel.instance:getPoolById(self._selectPoolId)

	if not pool then
		return
	end

	local supTime = pool:getEndTimeStamp() - ServerTime.now()

	if supTime > 0 then
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

		self._supTimeTxt.text = day > 0 and string.format(lang("text_countdown_min"), day, hour, min) or string.format(lang("text_countdown_second"), hour, min, sec)
	else
		removetimer(self._tickSurplusTime, self)
		self:close()
	end
end

function DrawEquipmentsView:_showEquipments(pool)
	local showEquips = pool:getShowEquipments()

	if showEquips then
		if not #showEquips then
			local cnt = 0

			for i = 1, cnt do
				GameUtil.SetActive(self._equipments[i].itemGo, true)
				MaterialMgr.setIcon(self._equipments[i].itemIma, MatType.Equipment, showEquips[i])

				local cfg = EquipmentConfig.instance:GetEquipDefineInfoById(showEquips[i])

				if cfg and not string.nilorempty(cfg.additionRaceType) then
					GameUtil.SetActive(self._equipments[i].attrIma, true)

					local index = GameEnum.Races[cfg.additionRaceType]

					self._equipments[i].attrIma:SetState(index - 1)
				else
					GameUtil.SetActive(self._equipments[i].attrIma, false)
				end
			end

			for i = cnt + 1, #self._equipments do
				GameUtil.SetActive(self._equipments[i].itemGo, false)
			end
		end
	end
end

function DrawEquipmentsView:_updateCycleDrawNum(pool)
	local index = pool:getPoolCycleIndex()
	local cycleCount = pool:getCycleCount()

	GameUtil.SetActive(self._cycleNum_1, false)
	GameUtil.SetActive(self._cycleNum_2, false)
	GameUtil.SetActive(self._cycleDesIma, index >= 0)

	if cycleCount > 0 then
		local supCount = pool:getCycleSurplusNum()

		GameUtil.SetActive(self._cycleNum_1, true)

		if supCount > 9 then
			GameUtil.SetActive(self._cycleNum_2, true)

			local shi = math.floor(supCount / 10)
			local ge = supCount - shi * 10

			self._cycleNum_1:SetState(index * 10 + shi)
			self._cycleNum_2:SetState(index * 10 + ge)
		else
			self._cycleNum_1:SetState(index * 10 + supCount)
		end
	end

	if index >= 0 then
		self._cycleDesIma:SetState(index)
	end
end

function DrawEquipmentsView:_onClickClose()
	DrawEquipmentsController.instance:setLastOpenPoolId()
	self:close()
end

function DrawEquipmentsView:_onClickDrawOnce()
	self:_startDraw(self._drawOnceTimesNum)
end

function DrawEquipmentsView:_onClickDrawTen()
	self:_startDraw(self._drawTenTimesNum)
end

function DrawEquipmentsView:_onClickComposed()
	UIStateManager.instance:push(ViewName.EquipAlchemy)
end

function DrawEquipmentsView:_onClickRewardsReview()
	ViewMgr.instance:open(ViewName.EquipPreviewView, self._selectPoolId)
end

function DrawEquipmentsView:_onClickDecomposed()
	UIStateManager.instance:push(ViewName.EquipRecycle, MatType.Equipment)
end

function DrawEquipmentsView:_onClickDiscount()
	if not self._currGiftMo then
		return
	end

	local cfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._currGiftMo.goodsId)

	if PayShopModel.instance:getPayShopGoodsCanBuyById(self._currGiftMo.goodsId) then
		if self._currGiftMo.payType == GameEnum.PayShopPayType.RMB then
			local data = {
				id = self._currGiftMo.goodsId,
				times = PayShopModel.instance:getMibaoBuyTimesById(self._currGiftMo.goodsId)
			}

			UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data)
		else
			local planId = PayShopModel.instance:getBestDiscountPlanIdByGoodsDefineId(self._currGiftMo.goodsId)
			local data = PayShopModel.instance:getBuyData(self._currGiftMo.goodsId)

			if data then
				UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data, false, planId)
			end
		end
	elseif self._currGiftMo.giftType == 1 then
		PayShopController.instance:openView(GameEnum.PayShopEasyJump.DiscountGift)
	else
		PayShopController.instance:openView(GameEnum.PayShopEasyJump.TehuiGift)
	end
end

function DrawEquipmentsView:_startDraw(times)
	local pool = DrawEquipmentsModel.instance:getPoolById(self._selectPoolId)

	if not pool then
		return
	end

	if not pool:isDataReady() then
		FloatWordMgr.instance:show(lang("text_requesting_svr_data"))

		return
	end

	local matType, matId, matNum = pool:getConsume()
	local hasNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if matType == 0 or hasNum >= matNum * times then
		DrawEquipmentsController.instance:drawEquipmentPoolDraw(pool:getPoolId(), times)
	else
		local matName = MaterialMgr.getMaterialsName(matType, matId)

		FloatWordMgr.instance:show(string.format(lang("text_buytimes_item_noenough"), matName))
		MaterialMgr.openGetSource(matType, matId)
	end
end

function DrawEquipmentsView:_onDrawEquipmentsInfo()
	self._hasDrawInfoRespond = true

	self:_refreshPoolsView()

	local selectPoolId = self._selectPoolId

	self._selectPoolId = 0

	self:_selectPool(selectPoolId)
end

function DrawEquipmentsView:_onDrawEquipmentDrawBack(poolId, times)
	if poolId ~= self._selectPoolId then
		return
	end

	self:_refreshPoolsView()

	local selectPoolId = self._selectPoolId

	self._selectPoolId = 0

	self:_selectPool(selectPoolId)
	ViewMgr.instance:open(ViewName.DrawEquipmentEff, times)
end

function DrawEquipmentsView:_onCurrencyCountChange()
	self:_refreshPoolsView()

	local selectPoolId = self._selectPoolId

	self._selectPoolId = 0

	self:_selectPool(selectPoolId)
end

function DrawEquipmentsView:_updataShowDaibi(poolMo)
	if self._diamondTxt then
		local num = RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()

		self._diamondTxt.text = tostring(num)
	end

	if self._daibiTxt == nil or poolMo == nil or poolMo.getConsume == nil then
		return
	end

	local matType, matId, matNum = poolMo:getConsume()

	if checknumber(matType) <= 0 or checknumber(matId) <= 0 then
		return
	end

	local count = MaterialModel.instance:getMaterialsNumber(matType, matId)

	self._daibiTxt.text = tostring(count)

	MaterialMgr.setIcon(self._daibiIma, matType, matId)
end

function DrawEquipmentsView:_onClickDaibiBtn()
	local poolMo = DrawEquipmentsModel.instance:getPoolById(self._selectPoolId)

	if poolMo == nil or poolMo.getConsume == nil then
		return
	end

	local matType, matId = poolMo:getConsume()

	if checknumber(matType) <= 0 or checknumber(matId) <= 0 then
		return
	end

	MaterialMgr.openGetSource(matType, matId)
end

function DrawEquipmentsView:_onClickDiamondBtn()
	FuncOpenController.instance:openFunc(95, GameEnum.PayShopEasyJump.Recharge)
end

return DrawEquipmentsView
