-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activityshop/view/ShenqishopexchangeView.lua

module("logic.extensions.activityshop.view.ShenqishopexchangeView", package.seeall)

local ShenqishopexchangeView = class("ShenqishopexchangeView", ViewComponent)

function ShenqishopexchangeView:ctor()
	ShenqishopexchangeView.super.ctor(self)
end

function ShenqishopexchangeView:unbindEvents()
	ShenqishopexchangeView.super.unbindEvents(self)
	self.closeClickBtn:RemoveClickListener()
	self._btn_add:RemoveClickListener()
	self.btnRule:RemoveClickListener()
end

function ShenqishopexchangeView:bindEvents()
	ShenqishopexchangeView.super.bindEvents(self)
	self.closeClickBtn:AddClickListener(self.close, self)
	self._btn_add:AddClickListener(self._onClickbtn_add, self)
	self.btnRule:AddClickListener(self._onClickRule, self)
end

function ShenqishopexchangeView:_onClickbtn_add()
	if self.goodsInfo then
		MaterialMgr.openGetSource(self.goodsInfo[1], self.goodsInfo[2])
	end
end

function ShenqishopexchangeView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "shenqiexchange_rule")
end

function ShenqishopexchangeView:buildUI()
	ShenqishopexchangeView.super.buildUI(self)

	local upInfoGo = self:getGo("upInfoTran")

	self.closeClickBtn = Framework.ButtonAdapter.GetFrom(upInfoGo, "closeClickBtn")
	self.supTimeTxt = goutil.findChildTextComponent(upInfoGo, "supTimeTxt")
	self.daibiIconGo = goutil.findChild(upInfoGo, "diabiItem/daibiIconIma")
	self.daibiCountTxt = goutil.findChild(upInfoGo, "diabiItem/daibiCountTxt"):GetComponent("Text")
	self.daibiAddBtn = Framework.ButtonAdapter.GetFrom(upInfoGo, "diabiItem/daibiAddBtn")
	self.supTimeTxt.text = ""
	self._roleCon = self:getGo("spriteInfoGo/roleCon")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "spriteInfoGo/bubble/txtTip")
	self.btnRule = self:getBtn("btnRule")
	self._btn_add = self:getBtn("upInfoTran/diabiItem/btn_add")
	self._titleTxt = goutil.findChildTextComponent(self.mainGO, "upInfoTran/titleTxt")
	self.scrollerGo = self:getGo("buyGoodsSR")
	self.cellGo = self:getGo("buyItem")
	self.scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self.ScrollView = self:getGo("ScrollView")
	self.BtnCell = self:getGo("BtnCell")
	self.tabScrollList = ScrollerList.create(self.ScrollView, self.BtnCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self.clearTabCell, self))
	self._roleGo = self:getGo("role")
end

function ShenqishopexchangeView:onExit()
	ShenqishopexchangeView.super.onExit(self)
	self.scrollList:dispose()
	self.tabScrollList:dispose()
	self:_resetRoleModel()
	GlobalDispatcher:removeListener(GlobalNotify.UpdateActiveShopInfo, self._updateView, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._setCostCoin, self)
end

function ShenqishopexchangeView:onEnter()
	ShenqishopexchangeView.super.onEnter(self)
	SurveyController.instance:reportBehavior(200556)

	self._activityType = 94

	local cfg = ActivityDefineController.instance:getActivityCfgByType(self._activityType)

	if cfg == nil then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("moyanbattleview__1"), function()
			self:close()
		end)

		return
	end

	self._activityId = cfg.activityId

	if not self._activityId or self._activityId <= 0 then
		return
	end

	ActivityshopModel.instance:clearDailyRed(self._activityType, self._activityId)

	self._activeCfg = ActivityDefineConfig.instance:getCfgById(self._activityType, self._activityId)

	if not self._activeCfg then
		printError("无活动配置", self._activityType, self._activityId)
	end

	ActivityshopModel.instance:clearDailyRed(self._activityType, self._activityId)
	self:_initPageTab()

	self._titleTxt.text = ActivityshopConfig.instance:getActShopTitleName(self._activityType, self._activityId)

	GlobalDispatcher:addListener(GlobalNotify.UpdateActiveShopInfo, self._updateView, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._setCostCoin, self)
	ActivityshopController.instance:getAllShopItemInfo(self._activityType, self._activityId)
	self:_showRoleModel()
end

function ShenqishopexchangeView:_initPageTab()
	self._tabDataList = ActivityshopConfig.instance:getActivityShopCfgWithPage(self._activityType, self._activityId) or {}
	self._currTabId = 1

	self:_updataExchangeBuyInfo(self._tabDataList[self._currTabId], true)
end

function ShenqishopexchangeView:_updateView()
	if self._dataList then
		self:_updataExchangeBuyInfo(self._dataList)
	end

	self:_setCostCoin()
end

function ShenqishopexchangeView:_setCostCoin()
	local itemStr = ActivityshopConfig.instance:getShenqiKeyValue("SHOW_ITEM")

	if itemStr then
		local arr = string.split(itemStr, ":")
		local matType = checknumber(arr[1])
		local matId = checknumber(arr[2])

		MaterialMgr.setIcon(self.daibiIconGo, matType, matId)

		local haveCount = MaterialModel.instance:getMaterialsNumber(matType, matId)

		self.daibiCountTxt.text = tostring(haveCount)
	else
		self.daibiCountTxt.text = ""

		MaterialMgr.clearIcon(self.daibiIconGo)
	end

	local list = ActivityshopConfig.instance:getShenQiTabList()

	self.tabScrollList:reloadData(list)
end

function ShenqishopexchangeView:_updataExchangeBuyInfo(dataList, resetPos)
	self._dataList = dataList

	if dataList[1] then
		self.goodsInfo = {}

		local temp = string.split(dataList[1].sellPrice, ":")

		self.goodsInfo[1] = checknumber(temp[1])
		self.goodsInfo[2] = checknumber(temp[2])

		self:_setCostCoin()
	end

	local list1 = {}
	local list2 = {}
	local list3 = {}
	local sellOut = false

	for i, v in ipairs(dataList) do
		sellOut = false

		if v.sellPeriodLimit ~= "none" then
			local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, v.shopItemId)

			if buyTime >= v.sellLimitCount then
				sellOut = true

				table.insert(list2, v)
			end
		end

		if not sellOut then
			if string.nilorempty(v.sellTime) or not PayShopController.instance:checkTimeStr(v.sellTime) then
				table.insert(list3, v)
			else
				table.insert(list1, v)
			end
		end
	end

	for i, v in ipairs(list3) do
		table.insert(list1, v)
	end

	for i, v in ipairs(list2) do
		table.insert(list1, v)
	end

	self.scrollList:reloadData(list1)
end

function ShenqishopexchangeView:_updateCell(view, cell, data, tag)
	local goodsNameTxt = goutil.findChildTextComponent(cell, "goodsNameTxt")
	local limitTxt = goutil.findChildTextComponent(cell, "limitBgIma/limitTxt")
	local goodsTranGo = goutil.findChild(cell, "goodsTranGo")
	local buyOutGo = goutil.findChild(cell, "buyOutGo")
	local buyLimit = goutil.findChild(cell, "buyLimit")
	local consumeImaGo = goutil.findChild(cell, "consumeGo/consumeIma")
	local consumeTxt = goutil.findChildTextComponent(cell, "consumeGo/consumeTxt")

	MaterialMgr.resetAll(goodsTranGo)

	local itemId = data.shopItemId
	local activityId = data.activityId
	local matSplitList = string.split(data.sellContent, ":")
	local goodsType = checknumber(matSplitList[1])
	local goodsId = checknumber(matSplitList[2])
	local cfg = MaterialMgr.getMatCfg(goodsType, goodsId)
	local colorStr = MaterialMgr.getGoodsColor(goodsType, goodsId)

	goodsNameTxt.text = string.format("<color=%s>%s</color>", colorStr, data.name)

	local sellOut = false
	local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, itemId)

	if data.sellPeriodLimit ~= "none" then
		sellOut = buyTime >= data.sellLimitCount
	end

	local limitStr = self:GetLimitTypeStr(data.sellPeriodLimit)

	limitTxt.text = string.nilorempty(limitStr) and "" or sellOut and string.format(limitStr, 0, data.sellLimitCount) or string.format(limitStr, data.sellLimitCount - buyTime, data.sellLimitCount)

	local content = data.sellContent

	if string.find(data.sellContent, "^" .. MatType.Cloth .. ":") then
		local arr = string.split(data.sellContent, "#")

		content = arr[RoleModel.instance:getGender() + 1]
	end

	local subLua = MaterialMgr.setCellByCfg(content, goodsTranGo)

	buyOutGo:SetActive(sellOut)
	buyLimit:SetActive(false)

	if not sellOut and (string.nilorempty(data.sellTime) or not PayShopController.instance:checkTimeStr(data.sellTime)) then
		buyLimit:SetActive(true)
	end

	local sellPriceSplit = string.split(data.sellPrice, ":")
	local priceType = sellPriceSplit[1] and checknumber(sellPriceSplit[1]) or 104
	local priceId = sellPriceSplit[2] and checknumber(sellPriceSplit[2]) or 1

	if not sellPriceSplit[3] then
		local priceCount = 100

		consumeTxt.text = MaterialFacade.instance:getGoodCost(priceType, priceId, priceCount)

		MaterialMgr.setIcon(consumeImaGo, priceType, priceId)

		local len = StringUtil.GetUtf8Length(priceCount)

		Framework.TransformUtil.SetLocalPos(consumeImaGo.transform, -25 - (len - 1) * 10, 2, 0)
		GameUtil.asBtn(cell):AddClickListener(function()
			if sellOut then
				FloatWordMgr.instance:show(lang("已售罄"))

				return
			end

			if string.nilorempty(data.sellTime) or not PayShopController.instance:checkTimeStr(data.sellTime) then
				if not string.nilorempty(data.notSellTimeTips) then
					TipsFacade.instance:openCommonTips(data.notSellTimeTips)
				end

				return
			end

			local haveNum = MaterialModel.instance:getMaterialsNumber(priceType, priceId) or 0

			if priceType == MatType.Diamond_Consume then
				priceType = MatType.Diamond
				priceId = MatType.Diamond_Binding
			end

			if ((priceType == MatType.Diamond or nil) and RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()) < checknumber(priceCount) then
				local cfg = MaterialMgr.getMatCfg(priceType, priceId)

				if cfg then
					FloatWordMgr.instance:show(langPara("所需%s不足！", cfg.name))
				else
					FloatWordMgr.instance:show(lang("所需货币不足！"))
				end
			else
				UIStateManager.instance:push(ViewName.ActivityshopexchangebuyView, self._activityType, activityId, itemId)
			end
		end, self)
	end
end

function ShenqishopexchangeView:clearCell(cell)
	local goodsTranGo = goutil.findChild(cell, "goodsTranGo")

	MaterialMgr.resetAll(goodsTranGo)
end

function ShenqishopexchangeView:_updateTabCell(view, cell, data, tag)
	local icon = goutil.findChild(cell, "Icon")
	local txt = goutil.findChildTextComponent(cell, "Text")
	local txtName = goutil.findChildTextComponent(cell, "name")

	MaterialMgr.updateItemByStr(icon, data.item)

	txt.text = MaterialMgr.getMatCount(data.item)
	txtName.text = MaterialMgr.getMaterialsNameByCfg(data.item)
end

function ShenqishopexchangeView:clearTabCell(cell)
	local icon = goutil.findChild(cell, "Icon")
	local txt = goutil.findChildTextComponent(cell, "Text")

	MaterialMgr.clearIcon(icon)
end

function ShenqishopexchangeView:GetLimitTypeStr(str)
	if string.nilorempty(str) or str == "none" then
		return
	end

	if str == "daily" then
		return lang("每日限购 %s/%s")
	end

	if str == "allTime" then
		return lang("活动限购 %s/%s")
	end

	if str == "weekly" then
		return lang("每周限购 %s/%s")
	end
end

function ShenqishopexchangeView:_showRoleModel()
	local curFaceId = EvolveConfig.instance:getNewRaceId()
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._roleGo, scale, nil, true, x, y)
end

function ShenqishopexchangeView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

return ShenqishopexchangeView
