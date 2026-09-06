-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportshowView.lua

module("logic.extensions.passport.view.PassportshowView", package.seeall)

local PassportshowView = class("PassportshowView", TableViewComponent)

function PassportshowView:ctor()
	PassportshowView.super.ctor(self)

	self._currTabData = nil
end

function PassportshowView:_getPath()
	return {
		cellPath = "container/mid/tablecell",
		viewPath = "container/mid/tableview"
	}
end

function PassportshowView:buildUI()
	PassportshowView.super.buildUI(self)

	self._goOneKey = self:getGo("container/btnOneKey")
	self._txtDiamondNum = goutil.findChildTextComponent(self.mainGO, "container/btnOneKey/txt")
	self._redpoint = goutil.findChild(self.mainGO, "container/btnOneKey/imgredpoint")
	self._btnHelp = self:getGo("container/btnHelp")
	self._goBuyProgress = self:getGo("container/rightTop/pos1")
	self._goBuyPassport = self:getGo("container/rightTop/pos2")
	self._btnBuyProgress = self:getBtn("container/rightTop/pos1/btnBuyProgress")
	self._btnBuyPassport = self:getBtn("container/rightTop/pos2/btnBuyPassport")
	self._goLock = self:getGo("container/mid/LeftBottom/iconBottom/btnLock")
	self._btnLock = self:getBtn("container/mid/LeftBottom/iconBottom/btnLock")
	self._sldProgress = self:getSlider("container/mid/tableview/Viewport/Content/sldProgress")

	local var_3_0 = self:getGo("container/mid/tableview/Viewport/Content/sldProgress")

	var_3_0 = var_3_0 and self:getGo("container/mid/tableview/Viewport/Content/sldProgress"):GetComponent("RectTransform")
	self._retProress = var_3_0

	local var_3_1 = self:getGo("container/mid/tableview")

	var_3_1 = var_3_1 and self:getGo("container/mid/tableview"):GetComponent(ComponentType.ScrollRect)
	self._scrollRect = var_3_1
	self._txtProgress = goutil.findChildTextComponent(self.mainGO, "container/mid/LeftTop/txtProgress")
	self._txtProgressTips = goutil.findChildTextComponent(self.mainGO, "container/mid/LeftTop/txtProgressTips")
	self._txtBottomTips = goutil.findChildTextComponent(self.mainGO, "container/txtBottomTips")
	self._timeTips = self:getGo("container/timeTips")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "container/timeTips/txt")
	self._changeGroup = goutil.findChildComponent(self.mainGO, "container/mid", "UIChangeGroup")
	self._goIconBottom = self:getGo("container/mid/LeftBottom/iconBottom")
	self._imgBG = self:getGo("container/imgBG")
end

function PassportshowView:bindEvents()
	PassportshowView.super.bindEvents(self)

	if self._btnBuyProgress then
		self._btnBuyProgress:AddClickListener(self._onClickBtnBuyProgress, self)
	end

	if self._btnBuyPassport then
		self._btnBuyPassport:AddClickListener(self._onClickBtnBuyPassport, self)
	end

	if self._goOneKey then
		GameUtil.addClickHandler(self._goOneKey, self._onClickBtnOneKey, self)
	end

	if self._btnHelp then
		GameUtil.addClickHandler(self._btnHelp, self._onClickBtnHelp, self)
	end

	if self._btnLock then
		self._btnLock:AddClickListener(self._onClickBtnBuyPassport, self)
	end
end

function PassportshowView:unbindEvents()
	PassportshowView.super.unbindEvents(self)

	if self._btnBuyProgress then
		self._btnBuyProgress:RemoveClickListener()
	end

	if self._btnBuyPassport then
		self._btnBuyPassport:RemoveClickListener()
	end

	if self._goOneKey then
		GameUtil.rmClickHandler(self._goOneKey)
	end

	if self._btnHelp then
		GameUtil.rmClickHandler(self._btnHelp)
	end

	if self._btnLock then
		self._btnLock:RemoveClickListener()
	end
end

function PassportshowView:destroyUI()
	PassportshowView.super.destroyUI(self)
end

function PassportshowView:onEnter()
	PassportshowView.super.onEnter(self)
	self:_resetview()

	self._canGetRewardIndex = 0
	self._openparam = checkint(self:getFirstParam())

	if self._openparam == 3 or self._openparam == 23 then
		WTowerController.instance:getWarriorInfo(nil)
	end

	self._passPortFuncId = self._openparam

	GlobalDispatcher:addListener(GlobalNotify.PassportStateUpdate, self._refreshUI, self)
	PassportController.instance:sendGetInfoReq(self._openparam, self._refreshUI, self)
end

function PassportshowView:onEnterFinished()
	PassportshowView.super.onEnterFinished(self)
end

function PassportshowView:onExit()
	PassportshowView.super.onExit(self)
	self:_resetview()
	GlobalDispatcher:removeListener(GlobalNotify.PassportStateUpdate, self._refreshUI, self)
end

function PassportshowView:onExitFinished()
	PassportshowView.super.onExitFinished(self)
end

function PassportshowView:_resetview()
	self._curData = nil

	GameUtil.SetActive(self._goBuyProgress, false)
	GameUtil.SetActive(self._goBuyPassport, false)
	GameUtil.SetActive(self._goLock, false)
	GameUtil.SetActive(self._goOneKey, false)
	GameUtil.SetActive(self._timeTips, false)
	GameUtil.SetGray(self._goIconBottom, true)

	if self._imgBG then
		uGuiUtil.clearImage(self._imgBG)
	end

	if self._sldProgress then
		self._sldProgress:SetValue(0)
	end

	removetimer(self._updatePerSec, self)
	ClockMgr.instance:removeListener(ClockMgr.TickHour, self._updatePerHour, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._updatePerDay, self)
end

function PassportshowView:_refreshUI()
	self._curData = PassportModel.instance:getInfo(self._passPortFuncId)

	local funcCfg = self._curData.funcCfg

	if self._curData == nil or funcCfg == nil then
		self:close()

		return
	end

	if self._goOneKey then
		self:_updateOneKeyGainState()
	end

	if self._txtProgress and checknumber(funcCfg.id) ~= 0 then
		self._txtProgress.text = funcCfg.id
	end

	if self._txtProgressTips and not string.nilorempty(funcCfg.progressTips) then
		self._txtProgressTips.text = funcCfg.progressTips
	end

	if self._txtBottomTips and not string.nilorempty(funcCfg.bottomTips) then
		self._txtBottomTips.text = funcCfg.bottomTips
	end

	if self._txtProgress and not string.nilorempty(self._curData.progressTxt) then
		self._txtProgress.text = self._curData.progressTxt
	end

	if self._goBuyProgress then
		GameUtil.SetActive(self._goBuyProgress, funcCfg.isShowBuy and self._curData.progressAbletToBuy > 0)
	end

	if self._goBuyPassport then
		local cfg = self._curData.actCfg
		local boo = true

		if not string.nilorempty(cfg.buyEndTime) then
			local timeNow = ServerTime.now()
			local timeEnd = GameUtil.string2time(cfg.buyEndTime)

			boo = timeNow < timeEnd
		end

		GameUtil.SetActive(self._goBuyPassport, not self._curData.hasPay and boo)
	end

	if self._goLock then
		GameUtil.SetActive(self._goLock, not self._curData.hasPay)
	end

	if self._goIconBottom then
		uGuiUtil.setImageGrayStateRecursive(self._goIconBottom, not self._curData.hasPay)
	end

	if self._btnInvestment then
		GameUtil.SetGray(self._btnInvestment, self._curData.hasPay)
	end

	if self._timeTips and funcCfg.type == 1 and funcCfg.isShowTime == true then
		self:_updateTime()
	end

	if self._changeGroup and self._openparam <= 3 then
		self._changeGroup:SetState(self._openparam - 1)
	end

	if self._imgBG and not string.nilorempty(funcCfg.mainBG) then
		local path = GameUrl.getPassportBGUrl(funcCfg.mainBG)

		uGuiUtil.setSpriteToImage(self._imgBG, uGuiUtil.SpriteType.BigBg, path)
	end

	if self._sldProgress and self._retProress then
		self._sldProgress:SetValue(self._curData.sldValue)

		self._retProress.offsetMin = self._curData.funcCfg.type == 1 and self._retProress and UnityEngine.Vector2.New(70, 335) or UnityEngine.Vector2.New(-70, 335)
	end

	self:initTabData()
end

function PassportshowView:initTabData()
	self._currTabData = self:_creatCellDataList()

	self:updateView()
end

function PassportshowView:updateView()
	self._currTabData = self:_creatCellDataList()
	self._curViewDatas = {}

	for _, v in ipairs(self._currTabData) do
		table.insert(self._curViewDatas, v)
	end

	self:reloadData()
end

function PassportshowView:_updateCell(view, cell, data)
	local component = GameUtil.AddLuaOnce(cell.gameObject, PassportCellItem)

	if self._scrollRect and self._curData and data then
		component:setData(self, self._scrollRect, self._curData, data)
	end
end

function PassportshowView:_onReloadFinish()
	if self._canGetRewardIndex > 0 then
		self:moveCellToCenter(self._canGetRewardIndex, 200)
	end
end

function PassportshowView:_creatCellDataList()
	local dataList = {}

	self._canGetRewardIndex = 0

	for index, v in ipairs(self._curData.prizeCfgs) do
		local data = {}

		data.id = index
		data.progressKey = self:getProgressKeyFormatStr(v.thresholdParam)
		data.freePrize = v.freePrize
		data.payedPrize = v.payedPrize
		data.freeState = self._curData.normalPrizeState[index]
		data.superState = self._curData.superPrizeState[index]

		if self._canGetRewardIndex == 0 and (not data.freeState or self._curData.hasPay and not data.superState) then
			self._canGetRewardIndex = index
		end

		table.insert(dataList, data)
	end

	return dataList
end

function PassportshowView:getProgressKeyFormatStr(thresholdParam)
	if self._curData.funcId == 4 or self._curData.funcId == 24 then
		local params = string.split(thresholdParam, "-")

		return string.format("第%s章", checkint(params[1]) - 1000)
	else
		return thresholdParam
	end
end

function PassportshowView:_onClickBtnHelp()
	ViewMgr.instance:open(ViewName.RulesView, self._curData.funcCfg.rule)
end

function PassportshowView:_onClickBtnBuyPassport()
	if self._curData.hasPay then
		GameUtil.SetActive(self._goBuyPassport, false)
		GameUtil.SetActive(self._goLock, false)

		if self._goIconBottom then
			uGuiUtil.setImageGrayStateRecursive(self._goIconBottom, true)
		end

		return
	end

	local cfg = self._curData.actCfg

	if not string.nilorempty(cfg.buyEndTime) then
		local timeNow = ServerTime.now()
		local timeEnd = GameUtil.string2time(cfg.buyEndTime)

		if timeEnd <= timeNow then
			return
		end
	end

	UIStateManager.instance:push(ViewName.PassportbuyView, self._curData.actCfg, self._curData.funcCfg, 1, self._curData.sldValue, self:_getPassportbuyViewExtraParam())
end

function PassportshowView:_getPassportbuyViewExtraParam()
	return nil
end

function PassportshowView:_onClickBtnBuyProgress()
	if self._curData.progressAbletToBuy <= 0 then
		GameUtil.SetActive(self._goBuyProgress, false)

		return
	end

	UIStateManager.instance:push(ViewName.PassportbuyporgressView, self._curData.funcCfg, self._curData.actCfg, self._curData.progressAbletToBuy)
end

function PassportshowView:_onClickBtnOneKey()
	PassportController.instance:sendOneKeyGainPrizeReq(self._curData.actId, self._curData.funcId)
end

function PassportshowView:_updateOneKeyGainState()
	local data1, data2, data3, num = PassportModel.instance:getCurDataList(nil, self._curData.funcId)

	if #data1 > 0 or #data2 > 0 then
		GameUtil.SetActive(self._goOneKey, true)
	else
		GameUtil.SetActive(self._goOneKey, false)
	end

	if self._txtDiamondNum then
		self._txtDiamondNum.text = "一键领取"
	end

	if #data1 > 0 or #data2 > 0 and self._curData.hasPay then
		goutil.setActive(self._redpoint, true)
	else
		goutil.setActive(self._redpoint, false)
	end
end

function PassportshowView:_updatePerSec()
	local currTime = ServerTime.now()
	local countDownTime = self._curData.endTime / 1000 - currTime

	if countDownTime < 0 then
		self:close()
		GlobalDispatcher:dispatch(GlobalNotify.ActivityEnd)

		return
	end

	self._txtTime.text = countDownTime > 86400 and TimeUtil:timeConvert(countDownTime, "DD天HH时", true) or TimeUtil:timeConvert2(countDownTime, "HH:MM:SS", true)
end

function PassportshowView:_updatePerHour()
	local currTime = ServerTime.now()
	local countDownTime = self._curData.endTime / 1000 - currTime

	if countDownTime < 0 then
		GlobalDispatcher:dispatch(GlobalNotify.ActivityEnd)
		self:close()

		return
	end

	if countDownTime > 86400 then
		self._txtTime.text = TimeUtil:timeConvert(countDownTime, "DD天HH时", true)
	else
		self._txtTime.text = TimeUtil:timeConvert2(countDownTime, "HH:MM:SS", true)

		ClockMgr.instance:removetimer(ClockMgr.TickHour, self._updatePerHour, self)
		settimer(1, self._updatePerSec, self)
	end
end

function PassportshowView:_updatePerDay()
	local param = checkint(self._openparam)

	if param == 3 then
		WTowerController.instance:getWarriorInfo()
	end

	self._passPortFuncId = param

	PassportController.instance:sendGetInfoReq(param, self._refreshUI, self)
end

function PassportshowView:_updateTime()
	local currTime = ServerTime.now()
	local countDownTime = self._curData.endTime / 1000 - currTime

	if countDownTime < 0 then
		self:close()
		GlobalDispatcher:dispatch(GlobalNotify.ActivityEnd)

		return
	end

	if countDownTime > 86400 then
		ClockMgr.instance:addListener(ClockMgr.TickHour, self._updatePerHour, self)

		self._txtTime.text = TimeUtil:timeConvert(countDownTime, "DD天HH时", true)
	else
		settimer(1, self._updatePerSec, self)

		self._txtTime.text = TimeUtil:timeConvert2(countDownTime, "HH:MM:SS", true)
	end

	GameUtil.SetActive(self._timeTips, true)
end

return PassportshowView
