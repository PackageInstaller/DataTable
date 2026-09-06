-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayShopMainView.lua

module("logic.extensions.payshop.view.PayShopMainView", package.seeall)

local PayShopMainView = class("PayShopMainView", TableViewComponent)
local json = require("cjson")

function PayShopMainView:ctor()
	PayShopMainView.super.ctor(self)

	self.currTabIndex = false
	self._currLevel1Id = false
	self.currSecTabId = false
	self._dropLineSizeY = 0
end

function PayShopMainView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function PayShopMainView:buildUI()
	PayShopMainView.super.buildUI(self)

	self.winCon = self:getGo("winCon")
	self.subCon = self:getGo("subCon")
	self.goldBarCon = self:getGo("goldBarCon")
	self._closeBtn = self:getBtn("winCon/closeBtn")
	self._tipBtn = self:getBtn("winCon/tipBtn")
	self._bottomBtns = {}
	self._bottomBtnsChange = {}
	self._bottomBtnsDot = {}

	local bottomBtnRoot = self:getGo("bottomBtns/tableview/Viewport/Content")

	for i = 1, bottomBtnRoot.transform.childCount do
		local btn = self:getBtn("bottomBtns/tableview/Viewport/Content/btn_" .. i)

		self._bottomBtns[i] = btn
		self._bottomBtnsDot[i] = goutil.findChild(btn.gameObject, "dot")
		self._bottomBtnsChange[i] = btn.gameObject:GetComponent(ComponentType.UIImageSpriteChange)
	end

	self._dropLineTr = goutil.findChild(self.mainGO, "tableview/Nego_Viewport/Nego_Content/dropLine").transform
	self._dropLineV2 = Vector2.New(166, 0)
	self._dropLineTr.sizeDelta = self._dropLineV2
	self._zqtjBtn = self:getBtn("zqtjBtn")
	self._tabContent = goutil.findChild(self.mainGO, "tableview/Nego_Viewport/Nego_Content").transform
	self._monthcardNewTagGo = goutil.findChild(bottomBtnRoot, "btn_" .. GameEnum.PayShopFirstTab.Privilege .. "/newTag")
	self._monthcardNewTagEffectGo = goutil.findChild(bottomBtnRoot, "btn_" .. GameEnum.PayShopFirstTab.Privilege .. "/newTag/effect")
	self._btnDraw = self:getBtn("btnDraw")
	self._btnRedPackage = self:getBtn("btnRedPackage")
	self._btnLijian = self:getBtn("btnLijian")
	self._btnGetDisc = self:getBtn("btnGetDisc")
end

function PayShopMainView:bindEvents()
	PayShopMainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._tipBtn:AddClickListener(self._onClickTip, self)
	self._zqtjBtn:AddClickListener(self._onClickZQTJ, self)
	self._btnDraw:AddClickListener(self._onClickbtnDraw, self)
	self._btnRedPackage:AddClickListener(self._onClickbtnRedPackage, self)
	self._btnLijian:AddClickListener(self._onClickbtnLijian, self)
	self._btnGetDisc:AddClickListener(self._onClickbtnGetDisc, self)
end

function PayShopMainView:unbindEvents()
	PayShopMainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipBtn:RemoveClickListener()
	self._zqtjBtn:RemoveClickListener()
	self._btnDraw:RemoveClickListener()
	self._btnRedPackage:RemoveClickListener()
	self._btnLijian:RemoveClickListener()
	self._btnGetDisc:RemoveClickListener()
end

function PayShopMainView:destroyUI()
	PayShopMainView.super.destroyUI(self)
end

function PayShopMainView:onEnter()
	PayShopMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.UpdatePayShopRedDot, self._checkRedDot, self)
	self.addGEvent(self, GlobalNotify.RedPointUpdate, self._checkRedDot, self)
	self.addGEvent(self, PayShopModel.ChangeZQTHState, self._checkZQTJBtn, self)
	self.addGEvent(self, NewHandCardAgent.NewHandCardInfoRes, self._checkZQTJBtn, self)
	self.addGEvent(self, PayAgent.NotifyPayResultRes, self._payResult, self)
	self.addGEvent(self, PayShopModel.GetAllPayShopBuyTimesRes, self._checkRedDot, self)
	self.addGEvent(self, PayShopModel.ForceUpdateView, self._forceUpdateView, self)
	self.addGEvent(self, PayShopController.GetDiscountGiftInfoRes, self._GetDiscountGiftInfoRes, self)
	PayShopController.instance:sendGetAllPayShopBuyTimesReq()
	PayShopController.instance:sendGetEmoticonGroupInfoReq()
	PayShopController.instance:sendPigraiseStateReq()
	self:_checkJumpParamLegal()
	self:_initBottomBtns()
	self:_checkZQTJBtn()
	self:_checkOpDiscountView()
	PayShopModel.instance:setRecordTag(true)
end

function PayShopMainView:onEnterFinished()
	PayShopMainView.super.onEnterFinished(self)
end

function PayShopMainView:onExit()
	PayShopMainView.super.onExit(self)
	UIStateManager.instance:updateParms(self._viewPresentor.viewName, nil)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._refreshShop, self)
	UIEffectManager.instance:stopEffect(self._monthcardNewEffectHandler)

	self._monthcardNewEffectHandler = nil
	self._currLevel1Id = false
	self.currTabIndex = false
	self._currLevel2Id = false
end

function PayShopMainView:onExitFinished()
	PayShopMainView.super.onExitFinished(self)
end

function PayShopMainView:_checkJumpParamLegal(params)
	self._locationGoodsId = nil

	if not params then
		local openParams = self:getOpenParam() or {}
		local jumpInTag = openParams[1]

		self._locationGoodsId = openParams[3]

		if jumpInTag then
			params = PayShopConfig.instance:getJumpInParam(jumpInTag)
		end
	end

	if params then
		local firTabId = params[1]
		local secTabId = params[2]
		local thiTabId = params[3]

		if not firTabId then
			self:_initReEnterTabId()

			return
		end

		local firData = PayShopConfig.instance:getLevel1TabCfg(firTabId)

		if not firData or not PayShopModel.instance:_checkOneTabCfgCommonCondition(firData) then
			self:_initReEnterTabId()

			return
		end

		local secData = false

		if secTabId then
			local level2Tabs = PayShopModel.instance:getLevel2TabCfgs(firTabId)

			for k, v in pairs(level2Tabs) do
				if v.id == secTabId then
					secData = v

					break
				end
			end
		end

		if not string.nilorempty(firData.viewName) then
			secTabId = false
			thiTabId = false
		elseif secData then
			local thiData = false

			if thiTabId then
				local level3Tabs = PayShopModel.instance:getLevel3TabCfgs(firTabId, secTabId)

				for k, v in pairs(level3Tabs) do
					if v.id == thiTabId then
						thiData = v

						break
					end
				end

				if not thiData then
					thiTabId = false
				end
			end
		else
			secTabId = false
			thiTabId = false
		end

		self._currLevel1Id = firTabId
		self._currLevel2Id = secTabId
		self._currLevel3Id = thiTabId
	else
		self:_initReEnterTabId()
	end
end

function PayShopMainView:_updateRightView()
	local lv2Tabs = self._keyList[self._currLevel2Id]
	local currTabData = lv2Tabs.cfg

	if self._currLevel3Id > 0 and lv2Tabs.leaf and #lv2Tabs.leaf > 0 then
		currTabData = false

		for i, v in ipairs(lv2Tabs.leaf) do
			if v.idx == self._currLevel3Id then
				currTabData = v.cfg

				break
			end
		end
	end

	if not currTabData then
		printError("t_pay_shop_tab_define error", self._currLevel2Id, self._currLevel3Id)

		return
	end

	if not string.nilorempty(currTabData.jumpTo) then
		GotoMgr.gotoByString(currTabData.jumpTo)

		if string.find(currTabData.jumpTo, ViewName.AccconsumeView) then
			self:_onClickClose()
		end

		if currTabData.reportBehavior > 0 then
			SurveyController.instance:reportBehavior(currTabData.reportBehavior)
		end

		return
	end

	self._currTabData = currTabData

	self:_updateView()

	if currTabData.reportBehavior > 0 then
		SurveyController.instance:reportBehavior(currTabData.reportBehavior)
	end

	self:_hideDiamondShopResetRedDot()
	self:_setSpeMainTopGoldBar()
end

function PayShopMainView:_hideDiamondShopResetRedDot()
	if self._currTabData and self._currTabData.jumpInTag == GameEnum.PayShopEasyJump.Recharge and PayShopModel.instance:checkDiamondRechagerResetDot() then
		PayShopModel.instance:setDiamondRechagerResetDotClickTime()
		GlobalDispatcher:dispatch(GlobalNotify.UpdatePayShopRedDot)
	end
end

function PayShopMainView:_setSpeMainTopGoldBar()
	local btn_list = {}

	if self._currTabData then
		local list = string.split(self._currTabData.costMats, "#")

		for i, v in ipairs(list) do
			table.insert(btn_list, {
				showAdd = true,
				id = v,
				showAddCallBack = function()
					TipsFacade.instance:openItemSourceView(v, function()
						self:_onClickClose()
					end)
				end
			})
		end
	end

	MainUIController.instance:showGlodBar(self.goldBarCon, self._viewPresentor, btn_list, false)
end

function PayShopMainView:_initLeftTabData(typeId)
	self:_initTabList(typeId)
	self:_updateTabList()
end

function PayShopMainView:_onReloadFinish()
	self._dropLineTr:SetParent(self._tabContent)
	self._dropLineTr:SetAsFirstSibling()
end

function PayShopMainView:_cellSize(view, index)
	local data = self._curViewDatas[index + 1]

	if data.tag == 1 then
		return 100, 65
	end

	return 100, 55
end

function PayShopMainView:_updateCell(view, cell, tabData)
	if tabData.tag == 1 then
		self:_updateRootCell(view, cell, tabData)
	else
		self:_updateLeafCell(view, cell, tabData)
	end

	local newTagGo = goutil.findChild(cell.gameObject, "newTag")

	goutil.setActive(newTagGo, false)
end

function PayShopMainView:_updateRootCell(view, cell, data)
	local selected = data.idx == self._currLevel2Id
	local component = GameUtil.AddLuaOnce(cell.gameObject, PayShopTabItem)

	if selected then
		local dropLineSizeY = 0

		if data.leaf and self._currLevel3Id > 0 then
			dropLineSizeY = 65 + #data.leaf * 55
		end

		self._dropLineV2.y = dropLineSizeY
		self._dropLineTr.sizeDelta = self._dropLineV2

		if dropLineSizeY > 0 then
			self._dropLineTr:SetParent(cell.gameObject.transform)
			GameUtil.setAnchoredPos(self._dropLineTr.gameObject, 0, 0)
		end
	end

	component:setData(self._currLevel1Id, data.cfg, selected, GameUtil.handler(self._onClickRoot, self, data), nil, true)
end

function PayShopMainView:_updateLeafCell(view, cell, data)
	local selected = data.idx == self._currLevel3Id
	local component = GameUtil.AddLuaOnce(cell.gameObject, PayShopTabItem)

	component:setData(self._currLevel1Id, data.cfg, selected, GameUtil.handler(self._onClickLeaf, self, data))
end

function PayShopMainView:_onClickRoot(data)
	if data.idx == self._currLevel2Id and self._currLevel3Id > 0 then
		self._currLevel3Id = 0

		self:_updateTabList()
	else
		self._currLevel2Id = data.idx
		self._currLevel3Id = 0

		if data.leaf and #data.leaf > 0 then
			self._currLevel3Id = data.leaf[1].idx
		end

		self:_updateTabList()
	end
end

function PayShopMainView:_onClickLeaf(data)
	self._currLevel3Id = data.idx

	self:reloadData()
	self:_updateRightView()
end

function PayShopMainView:_findLevel2AndLevel3Id()
	local rootIdx = self._currLevel2Id
	local leafIdx = self._currLevel3Id
	local isFindRoot = false

	for i, data in ipairs(self._allTabList) do
		if not rootIdx then
			isFindRoot = true
			rootIdx = data.idx
			isHit = true

			if data.leaf then
				for ii, vv in ipairs(data.leaf) do
					leafIdx = vv.idx

					break
				end
			end

			break
		end

		if data.idx == rootIdx then
			isFindRoot = true

			if data.leaf then
				for ii, vv in ipairs(data.leaf) do
					if not leafIdx or leafIdx == vv.idx then
						leafIdx = vv.idx

						break
					end
				end
			end
		end
	end

	if isFindRoot then
		self._currLevel2Id = rootIdx
		self._currLevel3Id = leafIdx or 0
	else
		self._currLevel2Id = false
		self._currLevel3Id = false

		self:_findLevel2AndLevel3Id()
	end
end

function PayShopMainView:_updateTabList()
	self:_findLevel2AndLevel3Id()

	local rootIdx = self._currLevel2Id
	local leafIdx = self._currLevel3Id
	local tabList = {}

	for i, v in ipairs(self._allTabList) do
		local data = v

		table.insert(tabList, data)

		if data.idx == rootIdx and leafIdx > 0 and data.leaf then
			for ii, vv in ipairs(data.leaf) do
				table.insert(tabList, vv)
			end
		end
	end

	self._curViewDatas = tabList

	self:reloadData()
	self:_updateRightView()
end

function PayShopMainView:_setMonthcardLeftTabNewTag(newTagGo, isRoot, rootId)
	if isRoot and self._currLevel1Id == GameEnum.PayShopFirstTab.Privilege and rootId == GameEnum.PayShopPrivilegeTab.MonthCard then
		goutil.setActive(newTagGo, PayShopModel.instance:checkHasNewMonthcardVersion())
	else
		goutil.setActive(newTagGo, false)
	end
end

function PayShopMainView:_updateView()
	if self._currTabData then
		PayShopModel.instance:recordCurrTabIds(self._currLevel1Id, self._currLevel2Id, self._currLevel3Id)

		if self:_needPopView() then
			UIStateManager.instance:popByName(self._currTabData.viewName)
		end

		local params

		if not string.nilorempty(self._currTabData.param) then
			params = string.split(self._currTabData.param, "#")
		end

		if self:_needAddTabDataInParams() then
			if not params then
				params = {
					0,
					self._currTabData
				}
			else
				table.insert(params, self._currTabData)
			end
		end

		PayShopModel.instance:recordJumpInTag(self._currTabData.jumpInTag)

		if params then
			if self._currTabData.viewName == ViewName.PayShopMibaoView then
				self:showTabAt(self.subCon, self._currTabData.viewName, params[1], params[2], self._locationGoodsId)
			else
				self:showTabAt(self.subCon, self._currTabData.viewName, unpack(params))
			end
		elseif self._currTabData.viewName == ViewName.PayShopMibaoView then
			self:showTabAt(self.subCon, self._currTabData.viewName, nil, nil, self._locationGoodsId)
		else
			self:showTabAt(self.subCon, self._currTabData.viewName)
		end
	end
end

function PayShopMainView:_needAddTabDataInParams()
	local viewName = self._currTabData.viewName

	return viewName == "payshopmibaoview" or viewName == "payshoprechargeview"
end

function PayShopMainView:_needPopView(tabCfg)
	local viewName = self._currTabData.viewName

	return viewName == "payshopmibaoview" or viewName == "baseexchangestack"
end

function PayShopMainView:_onClickTip()
	TipsFacade.instance:openRulesView("payshopmainview")
end

function PayShopMainView:_onClickZQTJ()
	FuncOpenController.instance:openFunc(143)
end

function PayShopMainView:_onClickbtnDraw()
	UIStateManager.instance:push(ViewName.PayshopvipdrawView)
end

function PayShopMainView:_onClickbtnRedPackage()
	UIStateManager.instance:push(ViewName.PayshopmoneycardView)
end

function PayShopMainView:_onClickbtnLijian()
	UIStateManager.instance:push(ViewName.MallautopopView)
end

function PayShopMainView:_tryShowPage()
	local showTabTypes = {}

	showTabTypes[self._currLevel1Id] = true

	local firData = PayShopConfig.instance:getLevel1TabCfg(self._currLevel1Id)

	if firData and checkint(firData.tabBelongTo) > 0 then
		local jumpPageCfg = PayShopConfig.instance:getJumpPageCfg(firData.tabBelongTo)

		if jumpPageCfg then
			if not jumpPageCfg.tabTypes then
				local teamIds = {}

				for k, v in ipairs(teamIds) do
					showTabTypes[v] = true
				end
			end
		end
	end

	return showTabTypes
end

function PayShopMainView:_initBottomBtns()
	local params = self:getOpenParam()
	local showTabTypes = {}
	local tabTypes = params and params[2] and params[2] or PayShopModel.instance:getJumpPageParam()

	if tabTypes then
		local temp

		PayShopModel.instance:recordJumpPageParam(tabTypes)

		if type(tabTypes) == "string" then
			if tabTypes == "all" then
				showTabTypes = self:_tryShowPage()
			else
				temp = json.decode(tabTypes)
			end
		elseif type(tabTypes) == "table" then
			temp = tabTypes
		end

		if temp and #temp > 0 then
			for i, tabType in ipairs(temp) do
				showTabTypes[checkint(tabType)] = true
			end
		end
	else
		showTabTypes = self:_tryShowPage()
	end

	local lv1tabCfgs = PayShopModel.instance:getLevel1TabCfgs()

	for i, v in ipairs(self._bottomBtns) do
		goutil.setActive(v.gameObject, false)
	end

	local sortBtnList = {}
	local hasShowType = false

	for index, data in ipairs(lv1tabCfgs) do
		local btn = self._bottomBtns[data.type]
		local isPass = showTabTypes[data.type]

		if isPass and btn then
			hasShowType = true

			goutil.setActive(btn.gameObject, true)
			btn:AddClickListener(function()
				self._currLevel2Id = false
				self._currLevel3Id = false

				self:_onClickBottomBtn(data)
			end)

			if self._currLevel1Id == data.type then
				self:_onClickBottomBtn(data, true)
			end

			table.insert(sortBtnList, {
				type = data.type
			})
		end
	end

	for i = #sortBtnList, 1, -1 do
		local btn = self._bottomBtns[sortBtnList[i].type]

		if btn then
			btn.transform:SetAsFirstSibling()
		end
	end

	if not hasShowType then
		self._currLevel1Id = GameEnum.PayShopFirstTab.Mibao
		self._currLevel2Id = false
		self._currLevel3Id = false

		local data = lv1tabCfgs[1]

		if data then
			self._currLevel1Id = data.type

			local btn = self._bottomBtns[self._currLevel1Id]

			if btn then
				goutil.setActive(btn.gameObject, true)
				btn:AddClickListener(function()
					self._currLevel2Id = false
					self._currLevel3Id = false

					self:_onClickBottomBtn(data)
				end)
				self:_onClickBottomBtn(data, true)
			end
		end
	end

	if BootstrapPjaqGameConfigMgr.isReview then
		for index, data in ipairs(lv1tabCfgs) do
			if BootstrapPjaqGameConfigMgr.isReview and checkbool(data.hideWithReview) then
				local btn = self._bottomBtns[data.type]

				GameUtil.SetActive(btn, false)
			end
		end
	end
end

function PayShopMainView:_newTagEffectloaded()
	if self._monthcardNewEffectHandler then
		self._monthcardNewEffectHandler:setClipping(GlobalModel.instance.uiRoot:GetComponent(goutil.Type_RectTransform))
	end
end

function PayShopMainView:_onClickBottomBtn(data, force)
	if data.type == GameEnum.PayShopFirstTab.DressShop then
		FloatWordMgr.instance:show("敬请期待")

		return
	end

	if not string.nilorempty(data.jumpTo) then
		GotoMgr.gotoByString(data.jumpTo)

		return
	end

	self:_checkVipShopSpeBtnShow(data)
	self:_checkLijianBtn(data)

	self._currLevel1Id = data.type

	for typeId, v in pairs(self._bottomBtnsChange) do
		v:SetState(typeId == data.type and 1 or 0)
	end

	if data.reportBehavior > 0 then
		SurveyController.instance:reportBehavior(data.reportBehavior)
	end

	if GameEnum.PayShopFirstTab.Shop == data.type then
		ShopModel.instance:updateLastTimeShow()
		ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._refreshShop, self, NotifyPriority.Low)
	else
		ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._refreshShop, self)
	end

	if not force then
		PayShopModel.instance:setPetSearchStr("")
	end

	if not string.nilorempty(data.viewName) then
		if data.viewName == ViewName.PayShopMibaoView then
			self:showTabAt(self.subCon, data.viewName, nil, nil, self._locationGoodsId)
		else
			self:showTabAt(self.subCon, data.viewName)
		end
	else
		self.currTabIndex = false

		self:_initLeftTabData(data.type)
	end

	self._locationGoodsId = nil
end

function PayShopMainView:_checkVipShopSpeBtnShow(data)
	goutil.setActive(self._btnDraw.gameObject, false)
	goutil.setActive(self._btnRedPackage.gameObject, false)
end

function PayShopMainView:_checkLijianBtn(data)
	goutil.setActive(self._btnLijian.gameObject, false)
end

function PayShopMainView:_refreshShop()
	ShopController.instance:getGoodLeftCount()
end

function PayShopMainView:_initReEnterTabId()
	if PayShopModel.instance:isRecordTabIds() then
		self._currLevel1Id, self._currLevel2Id, self._currLevel3Id = PayShopModel.instance:getRecodTabIds()
	else
		local params = PayShopConfig.instance:getJumpInParam(GameEnum.PayShopEasyJump.MibaoShop)

		self.currTabIndex = false
		self._currLevel1Id = params[1]
		self._currLevel2Id = params[2]
		self._currLevel3Id = params[3]
	end
end

function PayShopMainView:_onClickClose()
	PayShopModel.instance:setRecordTag(false)
	PayShopModel.instance:recordJumpPageParam(false)
	PayShopModel.instance:setPetSearchStr("")
	self:close()
end

function PayShopMainView:_checkRedDot()
	local btns = PayShopModel.instance:getLevel1TabCfgs()

	for i, data in ipairs(btns) do
		local redState = false

		if data.redPointIds then
			for _, rid in ipairs(data.redPointIds) do
				redState = RedPointModel.instance:isActive(rid)

				if redState then
					break
				end
			end
		end

		goutil.setActive(self._bottomBtnsDot[data.type], redState)
	end
end

function PayShopMainView:_checkZQTJBtn()
	local show = true

	if not ActivityPopupController.instance:getZQTJCanBuy() then
		show = NewHandCardModel.instance:isShowMainIcon()
	end

	goutil.setActive(self._zqtjBtn.gameObject, false)
end

function PayShopMainView:_initTabList(typeId)
	local tabCfgs = PayShopModel.instance:getLevel2TabCfgs(typeId)
	local list = {}
	local keyList = {}

	for key, v in ipairs(tabCfgs) do
		local data = {}

		data.tag = 1
		data.idx = v.id
		data.name = v.name
		data.cfg = v

		local level3TabCfgs = PayShopModel.instance:getLevel3TabCfgs(typeId, v.id)

		if level3TabCfgs then
			local tempList = {}

			for j, vv in ipairs(level3TabCfgs) do
				local tem = {}

				tem.tag = 2
				tem.idx = vv.id
				tem.name = vv.name
				tem.cfg = vv

				table.insert(tempList, tem)
			end

			data.leaf = tempList
		end

		table.insert(list, data)

		keyList[v.id] = data
	end

	self._allTabList = list
	self._keyList = keyList
end

function PayShopMainView:_payResult(stutas)
	if stutas == 0 then
		self:_forceUpdateView()
	end
end

function PayShopMainView:_forceUpdateView()
	self:_checkJumpParamLegal({
		self._currLevel1Id,
		self._currLevel2Id,
		self._currLevel3Id
	})
	self:_initBottomBtns()
end

function PayShopMainView:_onClickbtnGetDisc()
	UIStateManager.instance:push(ViewName.PayshopdiscgiftView)
end

function PayShopMainView:_checkOpDiscountView()
	goutil.setActive(self._btnGetDisc.gameObject, false)

	local cfg = PayShopConfig.instance:getJumpPageCfg(GameEnum.PayShopFirstTab.VipShop)

	if cfg then
		if not cfg.tabTypes then
			local tabTypes = {}

			if table.indexof(tabTypes, checknumber(self._currLevel1Id)) ~= false then
				local activityType = GameEnum.ActivityType.PAY_SHOP_DISCOUNT_GIFT
				local acfg = ActivityDefineController.instance:getActivityCfgByType(activityType)

				goutil.setActive(self._btnGetDisc.gameObject, acfg)

				if acfg then
					PayShopAgent.instance:sendGetDiscountGiftInfoReq(acfg.activityId)
				end
			end
		end
	end
end

function PayShopMainView:_GetDiscountGiftInfoRes(status)
	if status == 0 then
		local activityType = GameEnum.ActivityType.PAY_SHOP_DISCOUNT_GIFT
		local acfg = ActivityDefineController.instance:getActivityCfgByType(activityType)

		if acfg and not PayShopModel.instance:isGetAllDiscountGift(acfg.activityId) then
			UIStateManager.instance:push(ViewName.PayshopdiscgiftView)
		end
	end
end

return PayShopMainView
