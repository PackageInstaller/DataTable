-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmdrinkshop/view/MMDrinkShopFinishView.lua

module("logic.extensions.mmdrinkshop.view.MMDrinkShopFinishView", package.seeall)

local MMDrinkShopFinishView = class("MMDrinkShopFinishView", ViewComponent)

function MMDrinkShopFinishView:ctor()
	MMDrinkShopFinishView.super.ctor(self)
end

function MMDrinkShopFinishView:unbindEvents()
	MMDrinkShopFinishView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnFinish)
end

function MMDrinkShopFinishView:bindEvents()
	MMDrinkShopFinishView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnFinish, self._onClickBtnFinish, self)
end

function MMDrinkShopFinishView:buildUI()
	MMDrinkShopFinishView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnFinish = self:getGo("btnFinish")
	self._drinkChangerBase = self:getGo("drink/base"):GetComponent("UIImageSpriteChange")
	self._drinkChangerTop = self:getGo("drink/top"):GetComponent("UIImageSpriteChange")
	self._drinkChangerToppings1 = self:getGo("drink/toppings1"):GetComponent("UIImageSpriteChange")
	self._drinkChangerToppings2 = self:getGo("drink/toppings2"):GetComponent("UIImageSpriteChange")
	self._conListStep = {}

	for i = 1, 3 do
		self._conListStep[i] = self:getGo("step" .. i .. "/con")
	end

	self._goShowCell = self:getGo("showcell")
end

function MMDrinkShopFinishView:onExit()
	MMDrinkShopFinishView.super.onExit(self)

	for stepId, con in pairs(self._conListStep) do
		GameUtil.clearCells(con, self._clearNeedCell, self)
	end

	if self._uiEff then
		UIEffectManager.instance:stopEffect(self._uiEff)

		self._uiEff = nil
	end
end

function MMDrinkShopFinishView:onEnter()
	MMDrinkShopFinishView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = MMDrinkShopController.instance:getDefaultActivityId()
	end

	self._drinkId = checknumber(params[2])
	self._drinkCfg = MMDrinkShopConfig.instance:getDrinkCfgByDrinkId(self._activityId, self._drinkId)

	if not self._drinkCfg then
		printError("can't find drink cfg by drinkId: ", self._drinkId)
		self:close()

		return
	end

	self:_updateUIByCfg()

	local effPath = "20260529/mmyld/fx_ui_mmyld_zzwc.prefab"

	self._uiEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScaleXYZ(1, 1, 1)
	end)
end

function MMDrinkShopFinishView:_updateUIByCfg()
	self._actCfg = MMDrinkShopConfig.instance:getActivityCfgByActivityId(self._activityId)

	if not self._drinkCfg.stepToppingsPlanIdArr then
		for stepId, planId in ipairs(self._drinkCfg.stepToppingsPlanIdArr) do
			local toppingsPlanCfg = MMDrinkShopConfig.instance:getToppingsPlanCfgByPlanId(planId)

			if toppingsPlanCfg then
				if not toppingsPlanCfg.toppingsIdArr then
					local toppingsIdArr = {}
					local con = self._conListStep[stepId]

					GameUtil.updateCellsList(con, self._goShowCell, toppingsIdArr, self._updateNeedCell, self)

					if stepId == 1 then
						local toppingsId1 = toppingsIdArr[1]
						local toppingsId2 = toppingsIdArr[2]
						local toppingsCfg1 = MMDrinkShopConfig.instance:getToppingsCfgByToppingsId(self._activityId, toppingsId1)
						local toppingsCfg2 = MMDrinkShopConfig.instance:getToppingsCfgByToppingsId(self._activityId, toppingsId2)

						if toppingsCfg1 then
							goutil.setActive(self._drinkChangerToppings1.gameObject, true)
							self._drinkChangerToppings1:ChangeSprite(toppingsCfg1.showPic)
						else
							goutil.setActive(self._drinkChangerToppings1.gameObject, false)
						end

						if toppingsCfg2 then
							goutil.setActive(self._drinkChangerToppings2.gameObject, true)
							self._drinkChangerToppings2:ChangeSprite(toppingsCfg2.showPic)
						else
							goutil.setActive(self._drinkChangerToppings2.gameObject, false)
						end
					elseif stepId == 2 then
						local toppingsBaseId = toppingsIdArr[1]
						local toppingsBaseCfg = MMDrinkShopConfig.instance:getToppingsCfgByToppingsId(self._activityId, toppingsBaseId)

						if toppingsBaseCfg then
							goutil.setActive(self._drinkChangerBase.gameObject, true)
							self._drinkChangerBase:ChangeSprite(toppingsBaseCfg.showPic)
						else
							goutil.setActive(self._drinkChangerBase.gameObject, false)
						end
					elseif stepId == 3 then
						local toppingsTopId = toppingsIdArr[1]
						local toppingsTopCfg = MMDrinkShopConfig.instance:getToppingsCfgByToppingsId(self._activityId, toppingsTopId)

						if toppingsTopCfg then
							goutil.setActive(self._drinkChangerTop.gameObject, true)
							self._drinkChangerTop:ChangeSprite(toppingsTopCfg.showPic)
						else
							goutil.setActive(self._drinkChangerTop.gameObject, false)
						end
					end
				end
			end
		end
	end
end

function MMDrinkShopFinishView:_onClickBtnTip()
	if self._actCfg then
		if not self._actCfg.ruleKey then
			local ruleKey = ""

			TipsFacade.instance:openRulesView(ruleKey)
		end
	end
end

function MMDrinkShopFinishView:_onClickBtnFinish()
	self:close()
end

function MMDrinkShopFinishView:_updateNeedCell(cellGo, data, tabIdx)
	local itemIcon = goutil.findChild(cellGo, "item/icon")
	local txtName = goutil.findChildTextComponent(cellGo, "txtName")
	local toppingsCfg = MMDrinkShopConfig.instance:getToppingsCfgByToppingsId(self._activityId, data)

	if toppingsCfg then
		uGuiUtil.setSpriteToImage(itemIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(toppingsCfg.showIcon))

		txtName.text = toppingsCfg.name or ""
	else
		txtName.text = ""
	end
end

function MMDrinkShopFinishView:_clearNeedCell(cellGo)
	local itemIcon = goutil.findChild(cellGo, "item/icon")

	MaterialMgr.resetAll(itemIcon)
end

return MMDrinkShopFinishView
