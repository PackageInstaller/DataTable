-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmdrinkshop/view/MMDrinkShopMakeView.lua

module("logic.extensions.mmdrinkshop.view.MMDrinkShopMakeView", package.seeall)

local MMDrinkShopMakeView = class("MMDrinkShopMakeView", ViewComponent)

function MMDrinkShopMakeView:ctor()
	MMDrinkShopMakeView.super.ctor(self)
end

function MMDrinkShopMakeView:unbindEvents()
	MMDrinkShopMakeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnFinsh)
	GameUtil.rmClickHandler(self._btnLast)
	GameUtil.rmClickHandler(self._btnNext)
end

function MMDrinkShopMakeView:bindEvents()
	MMDrinkShopMakeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnFinsh, self._onClickBtnFinish, self)
	GameUtil.addClickHandler(self._btnLast, self._onClickBtnLast, self)
	GameUtil.addClickHandler(self._btnNext, self._onClickBtnNext, self)
end

function MMDrinkShopMakeView:buildUI()
	MMDrinkShopMakeView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._txtNumScore = self:getTxt("goldBarCon/txtNum")
	self._iconScore = self:getGo("goldBarCon/icon")

	local gotableview = self:getGo("tableview")
	local goCell = self:getGo("tableview/tablecell")

	self._tableView = ScrollerList.create(gotableview, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableView:regValueChanged(GameUtil.handler(self._onSVValueChanged, self))

	self._tip = self:getGo("tip")
	self._btnFinsh = self:getGo("btnFinsh")
	self._btnLast = self:getGo("btnLast")
	self._btnNext = self:getGo("btnNext")
	self._txtTipsSelectCount = self:getTxt("txtTipsSelectCount")
	self._txtTipsCostCount = self:getTxt("txtTipsCostCount")
	self._needInfoviews = {}

	for i = 1, 3 do
		self._needInfoviews[i] = self:getGo("needInfos/need_" .. i)
	end

	self._goNeedCell = self:getGo("needInfos/needCell")

	goutil.setActive(self._goNeedCell, false)

	self._selectInfoviews = {}

	for i = 1, 3 do
		self._selectInfoviews[i] = self:getGo("selectInfos/setp_" .. i)
	end

	self._goSelectCell = self:getGo("selectInfos/selectCell")

	goutil.setActive(self._goSelectCell, false)

	self._drinkChangerBase = self:getGo("drink/base"):GetComponent("UIImageSpriteChange")
	self._drinkChangerTop = self:getGo("drink/top"):GetComponent("UIImageSpriteChange")
	self._drinkChangerToppings1 = self:getGo("drink/toppings1"):GetComponent("UIImageSpriteChange")
	self._drinkChangerToppings2 = self:getGo("drink/toppings2"):GetComponent("UIImageSpriteChange")
end

function MMDrinkShopMakeView:onExit()
	MMDrinkShopMakeView.super.onExit(self)
	self._tableView:dispose()
	MaterialMgr.resetAll(self._iconScore)

	for i, view in pairs(self._needInfoviews) do
		GameUtil.clearCells(view, self._clearNeedCell, self)
	end

	for i, view in pairs(self._selectInfoviews) do
		GameUtil.clearCells(view, self._clearSelectCell, self)
	end
end

function MMDrinkShopMakeView:onEnter()
	MMDrinkShopMakeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MMDrinkShopStartMakeRes, self._handleStartMake, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params and params[1])

	if self._activityId <= 0 then
		self._activityId = MMDrinkShopController.instance:getDefaultActivityId()
	end

	self._slotId = checknumber((params or nil) and (params[2] or 1))

	if self._slotId <= 0 then
		self._slotId = 1
	end

	self._drinkId = MMDrinkShopModel.instance:getSlotDrinkId(self._activityId, self._slotId)

	self:_updateUIByCfg()
	self:_updateUIByInfo()
end

function MMDrinkShopMakeView:_updateUIByCfg()
	self._actCfg = MMDrinkShopConfig.instance:getActivityCfgByActivityId(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	if self._actCfg then
		if not self._actCfg.showItem then
			local showItemStr = ""

			self._itemType, self._itemId = MaterialMgr.getMatParams(showItemStr)

			MaterialMgr.setIcon(self._iconScore, self._itemType, self._itemId)

			self._toppingsCfgGroups = MMDrinkShopConfig.instance:getToppingsCfgByGroup(self._activityId)
			self._drinkCfg = MMDrinkShopConfig.instance:getDrinkCfgByDrinkId(self._activityId, self._drinkId)

			if self._drinkCfg then
				self._stepToppingsPlanIdArr = self._drinkCfg.stepToppingsPlanIdArr or {}
			end

			if self._drinkCfg then
				self._stepTypeCountArr = self._drinkCfg.stepTypeCountArr or {}
			end

			self._curSelectMapGroups = {}
			self._stepTypeCountMap = {}

			for stepId, typeCount in ipairs(self._stepTypeCountArr) do
				self._stepTypeCountMap[stepId] = typeCount
				self._curSelectMapGroups[stepId] = {}
			end

			self._checkToppingsMapGroups = {}

			for stepId, planId in ipairs(self._stepToppingsPlanIdArr) do
				local toppingsPlanCfg = MMDrinkShopConfig.instance:getToppingsPlanCfgByPlanId(planId)

				if toppingsPlanCfg then
					if not toppingsPlanCfg.toppingsIdArr then
						local toppingsIdArr = {}
						local toppingsCfgMap = {}

						for _, toppingsId in ipairs(toppingsIdArr) do
							toppingsCfgMap[toppingsId] = true
						end

						self._checkToppingsMapGroups[stepId] = toppingsCfgMap
					end
				end
			end

			self._stepCountMax = #self._curSelectMapGroups

			for i, view in pairs(self._needInfoviews) do
				local temIds = {}

				for toppingsId, _ in pairs(self._checkToppingsMapGroups[i] or {}) do
					table.insert(temIds, toppingsId)
				end

				GameUtil.updateCellsList(view, self._goNeedCell, temIds, self._updateNeedCell, self)
			end

			self:_resetCurSelect()
			self:_updateCurSelectShow()
		end
	end
end

function MMDrinkShopMakeView:_updateUIByInfo()
	self._txtNumScore.text = MMDrinkShopModel.instance:getCurScore(self._activityId)
end

function MMDrinkShopMakeView:_handleStartMake()
	TipsFacade.instance:openCommonTips(lang("开始制作"))
	self:close()
	UIStateManager.instance:push(ViewName.MMDrinkShopFinishView, self._activityId, self._drinkId)
end

function MMDrinkShopMakeView:_resetCurSelect()
	if self._stepCountMax > 0 then
		self._curStepId = 1
	end

	for stepId, _ in pairs(self._curSelectMapGroups) do
		self._curSelectMapGroups[stepId] = {}
	end

	for i, view in pairs(self._selectInfoviews) do
		GameUtil.clearCells(view, self._clearSelectCell, self)

		local temIds = {}

		for toppingsId, _ in pairs(self._curSelectMapGroups[i] or {}) do
			table.insert(temIds, toppingsId)
		end

		if self._stepTypeCountMap then
			if not self._stepTypeCountMap[i] then
				local selectCount = 0
				local startIdx = #temIds + 1

				for j = startIdx, selectCount do
					table.insert(temIds, 0)
				end

				GameUtil.updateCellsList(view, self._goSelectCell, temIds, self._updateSelectCell, self)
			end
		end
	end

	goutil.setActive(self._drinkChangerBase.gameObject, false)
	goutil.setActive(self._drinkChangerTop.gameObject, false)
	goutil.setActive(self._drinkChangerToppings1.gameObject, false)
	goutil.setActive(self._drinkChangerToppings2.gameObject, false)
end

function MMDrinkShopMakeView:_updateCurSelectShow()
	if not self._toppingsCfgGroups[self._curStepId] then
		local temCfgs = {}

		for _, toppingsCfg in ipairs(self._toppingsCfgGroups[self._curStepId]) do
			table.insert(temCfgs, toppingsCfg)
		end

		self._tableView:reloadData(temCfgs)
		goutil.setActive(self._btnFinsh, self._curStepId == self._stepCountMax)
		goutil.setActive(self._btnLast, self._curStepId > 1)
		goutil.setActive(self._btnNext, self._curStepId < self._stepCountMax)

		self._txtTipsCostCount.text = langPara("已消耗预算：%s", self:_getCurSelectCostCount())
		self._txtTipsSelectCount.text = langPara("本阶段可选材料: ( %s/%s )", self:_getCurSelectCountByStepId(self._curStepId), self._stepTypeCountMap[self._curStepId] or 0)

		local curSelectview = self._selectInfoviews[self._curStepId]

		if curSelectview then
			GameUtil.clearCells(curSelectview, self._clearSelectCell, self)

			local temIds = {}

			for toppingsId, _ in pairs(self._curSelectMapGroups[self._curStepId] or {}) do
				table.insert(temIds, toppingsId)
			end

			if self._stepCountMax then
				if not self._stepTypeCountMap[self._curStepId] then
					local selectCount = 0
					local startIdx = #temIds + 1

					for j = startIdx, selectCount do
						table.insert(temIds, 0)
					end

					GameUtil.updateCellsList(curSelectview, self._goSelectCell, temIds, self._updateSelectCell, self)

					if self._curStepId == 1 then
						local toppingId1 = temIds[1]
						local toppingId2 = temIds[2]
						local toppingCfg1 = MMDrinkShopConfig.instance:getToppingsCfgByToppingsId(self._activityId, toppingId1)
						local toppingCfg2 = MMDrinkShopConfig.instance:getToppingsCfgByToppingsId(self._activityId, toppingId2)

						if toppingCfg1 then
							goutil.setActive(self._drinkChangerToppings1.gameObject, true)
							self._drinkChangerToppings1:ChangeSprite(toppingCfg1.showPic)
						else
							goutil.setActive(self._drinkChangerToppings1.gameObject, false)
						end

						if toppingCfg2 then
							goutil.setActive(self._drinkChangerToppings2.gameObject, true)
							self._drinkChangerToppings2:ChangeSprite(toppingCfg2.showPic)
						else
							goutil.setActive(self._drinkChangerToppings2.gameObject, false)
						end
					elseif self._curStepId == 2 then
						local baseToppingId = temIds[1]
						local baseToppingCfg = MMDrinkShopConfig.instance:getToppingsCfgByToppingsId(self._activityId, baseToppingId)

						if baseToppingCfg then
							goutil.setActive(self._drinkChangerBase.gameObject, true)
							self._drinkChangerBase:ChangeSprite(baseToppingCfg.showPic)
						else
							goutil.setActive(self._drinkChangerBase.gameObject, false)
						end
					elseif self._curStepId == 3 then
						local topToppingId = temIds[1]
						local topToppingCfg = MMDrinkShopConfig.instance:getToppingsCfgByToppingsId(self._activityId, topToppingId)

						if topToppingCfg then
							goutil.setActive(self._drinkChangerTop.gameObject, true)
							self._drinkChangerTop:ChangeSprite(topToppingCfg.showPic)
						else
							goutil.setActive(self._drinkChangerTop.gameObject, false)
						end
					end
				end
			end
		end
	end
end

function MMDrinkShopMakeView:_getCurSelectCountByStepId(stepId)
	local count = 0

	if not self._curSelectMapGroups[stepId] then
		for _, isSelect in pairs(self._curSelectMapGroups[stepId]) do
			if isSelect then
				count = count + 1
			end
		end

		return count
	end
end

function MMDrinkShopMakeView:_getCurSelectCostCount()
	local costCount = 0

	for stepId, curSelectMap in pairs(self._curSelectMapGroups) do
		for toppingsId, isSelect in pairs(curSelectMap) do
			if isSelect then
				local toppingsCfg = MMDrinkShopConfig.instance:getToppingsCfgByToppingsId(self._activityId, toppingsId)

				if toppingsCfg then
					costCount = costCount + (toppingsCfg.price or 0)
				end
			end
		end
	end

	return costCount
end

function MMDrinkShopMakeView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function MMDrinkShopMakeView:_onClickBtnFinish()
	for stepId, checkToppingsMap in pairs(self._checkToppingsMapGroups) do
		if not self._curSelectMapGroups[stepId] then
			for toppingsId, isCheck in pairs(checkToppingsMap) do
				if isCheck and not self._curSelectMapGroups[stepId][toppingsId] then
					TipsFacade.instance:openCommonTips(lang("订单未满足，再仔细检查下吧！"))

					return
				end
			end
		end
	end

	local curCostCount = self:_getCurSelectCostCount()
	local curScore = MMDrinkShopModel.instance:getCurScore(self._activityId)

	if curScore < curCostCount then
		TipsFacade.instance:openCommonTips(lang("当前消耗超过已可用分数，请重新选择"))

		return
	end

	local selectSteps = {}

	for stepId, curSelectMap in pairs(self._curSelectMapGroups) do
		local toppingsIds = {}

		for toppingsId, isSelect in pairs(curSelectMap) do
			if isSelect then
				table.insert(toppingsIds, toppingsId)
			end
		end

		table.insert(selectSteps, {
			stepId = stepId,
			toppingsIds = toppingsIds
		})
	end

	MMDrinkShopController.instance:startMake(self._activityId, self._slotId, selectSteps)
end

function MMDrinkShopMakeView:_onClickBtnLast()
	self._curStepId = math.max(self._curStepId - 1, 1)

	self:_updateCurSelectShow()
end

function MMDrinkShopMakeView:_onClickBtnNext()
	self._curStepId = math.min(self._curStepId + 1, self._stepCountMax)

	self:_updateCurSelectShow()
end

function MMDrinkShopMakeView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "item/icon")

	uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.showIcon))

	local txtName = goutil.findChildTextComponent(go, "txtName")

	txtName.text = data.name or ""

	local markselect = goutil.findChild(go, "btnSelect/markselect")
	local bgBtnSelect = goutil.findChild(go, "btnSelect/bg")
	local txtCost = goutil.findChildTextComponent(go, "btnSelect/txtCost")
	local iconCost = goutil.findChild(go, "btnSelect/txtCost/item")

	if not data.price then
		txtCost.text = data.price

		MaterialMgr.setIcon(iconCost, self._itemType, self._itemId)

		if not data.toppingsType then
			local stepId = 0

			if not self._curSelectMapGroups[data.toppingsType] then
				local curSelectMap = {}

				if not curSelectMap[data.toppingsId] then
					local isSelect = false

					GameUtil.SetActive(markselect, isSelect)
					GameUtil.SetActive(txtCost.gameObject, not isSelect)
					GameUtil.SetGray(bgBtnSelect, isSelect)

					local btnSelect = goutil.findChild(go, "btnSelect")

					GameUtil.addClickHandler(btnSelect, function()
						if isSelect then
							curSelectMap[data.toppingsId] = nil
						elseif not self._stepTypeCountMap[stepId] then
							local stepTypeCount = 0
							local curSelectCount = self:_getCurSelectCountByStepId(stepId)

							if stepTypeCount <= curSelectCount then
								TipsFacade.instance:openCommonTips(lang("超过当前步骤最大可选数量"))

								return
							end

							curSelectMap[data.toppingsId] = true
						end

						self:_updateCurSelectShow()
					end, self)
				end
			end
		end
	end
end

function MMDrinkShopMakeView:_clearCell(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "item/icon")

	MaterialMgr.resetAll(icon)

	local btnSelect = goutil.findChild(go, "btnSelect")

	GameUtil.rmClickHandler(btnSelect)
end

function MMDrinkShopMakeView:_onSVValueChanged()
	GameUtil.SetActive(self._tip, not self._tableView:isShowFinishCell())
end

function MMDrinkShopMakeView:_updateNeedCell(cellGo, data, tabIdx)
	local toppingsCfg = MMDrinkShopConfig.instance:getToppingsCfgByToppingsId(self._activityId, data)

	uGuiUtil.setSpriteToImage(cellGo.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(toppingsCfg.showIcon))
end

function MMDrinkShopMakeView:_clearNeedCell(cellGo)
	MaterialMgr.resetAll(cellGo)
end

function MMDrinkShopMakeView:_updateSelectCell(cellGo, data, tabIdx)
	local icon = goutil.findChild(cellGo, "icon")

	MaterialMgr.resetAll(icon)

	local txtName = goutil.findChildTextComponent(cellGo, "txtName")
	local goEmpty = goutil.findChild(cellGo, "empty")
	local toppingsCfg = MMDrinkShopConfig.instance:getToppingsCfgByToppingsId(self._activityId, data)

	if toppingsCfg then
		uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(toppingsCfg.showIcon))
		GameUtil.SetActive(icon.gameObject, true)
		GameUtil.SetActive(goEmpty, false)

		txtName.text = toppingsCfg.name or ""
	else
		GameUtil.SetActive(icon.gameObject, false)
		GameUtil.SetActive(goEmpty, true)

		txtName.text = lang("未选择")
	end
end

function MMDrinkShopMakeView:_clearSelectCell(cellGo)
	local icon = goutil.findChild(cellGo, "icon")

	MaterialMgr.resetAll(icon)
end

return MMDrinkShopMakeView
