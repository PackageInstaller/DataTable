-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportwpView.lua

module("logic.extensions.passport.view.PassportwpView", package.seeall)

local PassportwpView = class("PassportwpView", PassportshowView)

function PassportwpView:ctor()
	PassportwpView.super.ctor(self)
end

function PassportwpView:buildUI()
	PassportwpView.super.buildUI(self)

	self._goBuyPassport = self:getGo("container/btnBuyPassport")
	self._btnBuyPassport = self._goBuyPassport and GameUtil.asBtn(self._goBuyPassport)
	self._goBuyProgress = self:getGo("container/btnBuyProgress")
	self._btnBuyProgress = self._goBuyProgress and GameUtil.asBtn(self._goBuyProgress)
	self._btnClose = self:getBtn("btnClose")
	self._btnGoTo = self:getBtn("container/btnGoTo")
	self._changeGroup = nil
	self._imgBG = nil
	self.effResPath = "fx_ui_tongxingzheng/fx_ui_tongxingzheng.prefab"
	self._btnSkill = self:getBtn("btnSkill")
	self._extraPart = self:getGo("extraPart")
	self._btnGetExtra = self:getBtn("extraPart/btnGet")
	self._btnRuleExtra = self:getBtn("extraPart/btnRule")
	self._txtProgressExtra = self:getTxt("extraPart/txtProgress")
	self._showcell = self:getGo("showcell")
	self._txtProgressShow = goutil.findChildTextComponent(self._showcell, "txtProgress")
	self._freePrizeShow = goutil.findChild(self._showcell, "freePrize")
	self._superPrizePrizeShow_1 = goutil.findChild(self._showcell, "superPrize_1")
	self._superPrizePrizeShow_2 = goutil.findChild(self._showcell, "superPrize_2")
end

function PassportwpView:bindEvents()
	PassportwpView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGoTo, self._onClickBtnGoTo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnRuleExtra, self._onClickRuleExtra, self)
	GameUtil.addClickHandler(self._btnGetExtra, self._onClickGetExtra, self)
end

function PassportwpView:unbindEvents()
	PassportwpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGoTo)
	GameUtil.rmClickHandler(self._btnRuleExtra)
	GameUtil.rmClickHandler(self._btnGetExtra)
	GameUtil.rmClickHandler(self._btnSkill)
end

function PassportwpView:destroyUI()
	PassportwpView.super.destroyUI(self)
end

function PassportwpView:onEnter()
	self:_resetview()

	self._openparam = self:_getOpenparam()
	self._buyView = ViewName.PassportwpbuyView
	self._passPortFuncId = self._openparam

	GlobalDispatcher:addListener(GlobalNotify.PassportStateUpdate, self._refreshUI, self)
	PassportController.instance:sendGetInfoReq(self._openparam, self._refreshUI, self)

	if not GameUtil.isEmptyString(self.effResPath) then
		self._playEff = UIEffectManager.instance:playEffect(self, self.effResPath, nil, 0, 0, true, false, nil, function(target, eff)
			eff:setParent(self.mainGO.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1)

			eff.hideEffWhileNotOnTop = true
		end)
	end

	goutil.setActive(self._extraPart, false)
	GlobalDispatcher:addListener(GlobalNotify.PassportExtraPrizeUpdate, self._refreshExtraPart, self)

	self._ableToLClick = true
	self._canGetRewardIndex = 0
end

function PassportwpView:onEnterFinished()
	PassportwpView.super.onEnterFinished(self)
end

function PassportwpView:onExit()
	PassportwpView.super.onExit(self)

	if self._playEff then
		UIEffectManager.instance:stopEffect(self._playEff)

		self._playEff = nil
	end

	if self._baoxiangEff then
		UIEffectManager.instance:stopEffect(self._baoxiangEff)

		self._baoxiangEff = nil
	end

	GlobalDispatcher:removeListener(GlobalNotify.PassportExtraPrizeUpdate, self._refreshExtraPart, self)
	removetimer(self._gainExtra, self)
	MaterialMgr.resetAll(self._freePrizeShow)
	MaterialMgr.resetAll(self._superPrizePrizeShow_1)
	MaterialMgr.resetAll(self._superPrizePrizeShow_2)

	self._showId = nil
end

function PassportwpView:onExitFinished()
	PassportwpView.super.onExitFinished(self)
	self:_resetview()
	GlobalDispatcher:removeListener(GlobalNotify.PassportStateUpdate, self._refreshUI, self)
end

function PassportwpView:_getOpenparam()
	local funcId = checknumber(self:getFirstParam())

	if funcId > 0 then
		return funcId
	end

	return 1
end

function PassportwpView:_refreshUI()
	PassportwpView.super._refreshUI(self)

	self._retProress.offsetMin = UnityEngine.Vector2.New(70, -50)
	self._retProress.offsetMax = UnityEngine.Vector2.New(-384, -40)

	self:_refreshExtraPart()

	if self._btnSkill then
		self._jumpTo = self._curData.actCfg.jumpTo

		if string.nilorempty(self._jumpTo) then
			GameUtil.SetActive(self._btnSkill.gameObject, false)
		else
			local jumpToParms = string.split(self._jumpTo, "#")

			if jumpToParms[1] == "skin" then
				GameUtil.SetActive(self._btnSkill.gameObject, true)
			elseif jumpToParms[1] == "pet" then
				GameUtil.SetActive(self._btnSkill.gameObject, true)
			elseif jumpToParms[1] == "mount" then
				GameUtil.SetActive(self._btnSkill.gameObject, false)
			else
				GameUtil.SetActive(self._btnSkill.gameObject, false)
				printError("参数未定义")
			end
		end
	end

	self:_playAni()
end

function PassportwpView:_onClickBtnGoTo()
	UIStateManager.instance:push(ViewName.diamondtask, GameEnum.TaskViewTab.Daily)
end

function PassportwpView:_onClickBtnOneKey()
	PassportController.instance:sendOneKeyGainPrizeReq(self._curData.actId, self._curData.funcId)
end

function PassportwpView:_updateOneKeyGainState()
	local data1, data2, data3, num = PassportModel.instance:getCurDataList(nil, self._curData.funcId)

	if #data1 > 0 or #data2 > 0 then
		GameUtil.SetActive(self._goOneKey, true)
	else
		GameUtil.SetActive(self._goOneKey, false)
	end

	if #data1 > 0 or #data2 > 0 and self._curData.hasPay then
		goutil.setActive(self._redpoint, true)
	else
		goutil.setActive(self._redpoint, false)
	end

	self._txtDiamondNum.text = "一键领取"
end

function PassportwpView:_onClickBtnBuyPassport()
	if self._curData.hasPay then
		GameUtil.SetActive(self._goBuyPassport, false)
		GameUtil.SetActive(self._goLock, false)
		uGuiUtil.setImageGrayStateRecursive(self._goIconBottom, true)

		return
	end

	UIStateManager.instance:push(self._buyView, self._curData.actCfg, self._curData.funcCfg, 1)
end

function PassportwpView:_onClickSkill()
	local jumpToParms = string.split(self._jumpTo, "#")

	if jumpToParms[1] == "skin" then
		local skinId = checkint(jumpToParms[2])
		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		PetbookController.instance:previewBattle(skinCfg.raceId, skinId)
	elseif jumpToParms[1] == "pet" then
		local raceId = checkint(jumpToParms[2])

		PetbookController.instance:previewBattle(raceId, raceId)
	elseif jumpToParms[1] == "mount" then
		-- block empty
	end
end

function PassportwpView:_creatCellDataList()
	local dataList = {}

	for index, v in ipairs(self._curData.prizeCfgs) do
		local data = {}

		data.id = index

		if self._curData.funcId == 4 then
			local params = string.split(v.thresholdParam, "-")

			data.progressKey = string.format("第%s章", checkint(params[1]) - 1000)
		else
			data.progressKey = v.thresholdParam
		end

		data.freePrize = v.freePrize
		data.payedPrize = v.payedPrize
		data.freeState = self._curData.normalPrizeState[index]
		data.superState = self._curData.superPrizeState[index]
		data.isLast = false

		if self._canGetRewardIndex == 0 and (not data.freeState or self._curData.hasPay and not data.superState) then
			self._canGetRewardIndex = index
		end

		table.insert(dataList, data)
	end

	dataList[#dataList].isLast = true
	dataList = self:_extendCellData(dataList)

	return dataList
end

function PassportwpView:_extendCellData(dataList)
	table.insert(dataList, {})
	table.insert(dataList, {})

	return dataList
end

function PassportwpView:_updateCell(view, cell, data)
	PassportwpView.super._updateCell(self, view, cell, data)

	if data.isLast then
		goutil.addChildToParent(self._extraPart, cell.gameObject)
		GameUtil.setAnchoredPos(self._extraPart, 0, 0)
		goutil.setActive(self._extraPart, true)
	else
		local extraPart = goutil.findChild(cell.gameObject, "extraPart")

		if extraPart then
			goutil.addChildToParent(self._extraPart, self.mainGO)
			goutil.setActive(self._extraPart, false)
		end
	end

	self:_refreshShowCell(self._tableview:GetCurrentIndex() + 1)
end

function PassportwpView:_refreshShowCell(dataId)
	if not self:_isNeedShowCell() then
		return
	end

	if self._curData.prizeCfgs[dataId] then
		local showId = self._curData.prizeCfgs[dataId].showId

		if self._showId ~= showId then
			self._showId = showId

			local data = self._currTabData[self._showId]

			if data then
				MaterialMgr.resetAll(self._freePrizeShow)
				MaterialMgr.resetAll(self._superPrizePrizeShow_1)
				MaterialMgr.resetAll(self._superPrizePrizeShow_2)
				MaterialMgr.setCellByCfg(data.freePrize, self._freePrizeShow)

				local supersPrizes = string.split(data.payedPrize, "#")

				MaterialMgr.setCellByCfg(supersPrizes[1], self._superPrizePrizeShow_1)
				MaterialMgr.setCellByCfg(supersPrizes[2], self._superPrizePrizeShow_2)

				self._txtProgressShow.text = langPara("%s勋章奖励", data.progressKey)

				goutil.setActive(self._showcell, true)
			else
				goutil.setActive(self._showcell, false)
			end
		end
	end
end

function PassportwpView:_isNeedShowCell()
	return true
end

function PassportwpView:_onClickGetExtra()
	if self._isAbleToGetExtra then
		if not self._ableToLClick then
			return
		end

		if self._baoxiangEff then
			UIEffectManager.instance:stopEffect(self._baoxiangEff)

			self._baoxiangEff = nil
		end

		self._baoxiangEff = UIEffectManager.instance:playEffect(self, "fx_ui_tongxingzheng/fx_ui_tongxingzheng_baoxiangbaokai.prefab", self._btnGetExtra.gameObject.transform, 0, 0, false, false, nil, function(target, eff)
			eff.effGo.transform:SetParent(self._btnGetExtra.gameObject.transform)
			GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
			GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
			eff:setScrollRectClipping(self._scrollRect)
		end)
		self._ableToLClick = false

		removetimer(self._gainExtra, self)
		settimer(0.6, self._gainExtra, self, false)
	else
		CommonTipsMgr.instance:openTipsByConfStr(self._btnGetExtra.gameObject, self._extraPrize)
	end
end

function PassportwpView:_gainExtra()
	PassportController:sendGainExtraPrize(self._curData.actId, self._curData.funcId)

	self._ableToLClick = true
end

function PassportwpView:_onClickRuleExtra()
	UIStateManager.instance:push(ViewName.RulesView, "passportwpextraprize")
end

function PassportwpView:_refreshExtraPart()
	local extraCfg = PassportConfig.instance:getExtraPrizeCfgByActId(self._curData.actId)

	self._isAbleToGetExtra = self._curData.usefulProgress >= extraCfg.consumeProcess
	self._extraPrize = string.split(extraCfg.prize, "#")[1]
	self._txtProgressExtra.text = langPara("%s/%s", self._curData.usefulProgress, extraCfg.consumeProcess)

	if self._baoxiangEff then
		UIEffectManager.instance:stopEffect(self._baoxiangEff)

		self._baoxiangEff = nil
	end

	if self._isAbleToGetExtra then
		self._baoxiangEff = UIEffectManager.instance:playEffect(self, "fx_ui_tongxingzheng/fx_ui_tongxingzheng_baoxiang.prefab", self._btnGetExtra.gameObject.transform, 0, 0, true, false, nil, function(target, eff)
			eff.effGo.transform:SetParent(self._btnGetExtra.gameObject.transform)
			GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
			GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
			eff:setScrollRectClipping(self._scrollRect)
		end)
	end
end

function PassportwpView:_playAni()
	local aniPath = self._curData.actCfg.aniPath

	if not string.nilorempty(aniPath) then
		local userDataKey = self._viewPresentor.viewName .. "aniPlay"
		local userDataValue = checkint(GameUtil.getUserDayData(userDataKey))

		if userDataValue <= 0 then
			GameUtil.saveUserDayData(userDataKey, 1)

			local animConfig = {
				passable = false,
				animName = aniPath,
				callbackTarget = self
			}

			ViewMgr.instance:open(ViewName.AnimationPlaying, animConfig)
		end
	end
end

return PassportwpView
