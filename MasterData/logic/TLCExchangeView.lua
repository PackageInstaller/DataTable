-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/TLCExchangeView.lua

module("logic.extensions.timelimitedchallenge.view.TLCExchangeView", package.seeall)

local TLCExchangeView = class("TLCExchangeView", TableViewComponent)

function TLCExchangeView:_getPath()
	return {
		cellPath = "buyItem",
		viewPath = "buyGoodsSR"
	}
end

function TLCExchangeView:_cellSize()
	return 218, 274
end

function TLCExchangeView:unbindEvents()
	TLCExchangeView.super.unbindEvents(self)
	self.closeClickBtn:RemoveClickListener()
end

function TLCExchangeView:bindEvents()
	TLCExchangeView.super.bindEvents(self)
	self.closeClickBtn:AddClickListener(self.close, self)
end

function TLCExchangeView:onExit()
	TLCExchangeView.super.onExit(self)
	TLChallengeModel.instance:setExchangeInfo(self._challengeId, nil)
	removetimer(self._onTick, self)

	self._tickedTexts = nil

	GlobalDispatcher:removeListener(GlobalNotify.TimedChallengeDoExchange, self._onDoExchangeRes, self)
end

function TLCExchangeView:buildUI()
	TLCExchangeView.super.buildUI(self)

	self.closeClickBtn = self:getBtn("btnClose")
	self._btnContainer = self:getGo("btns")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "txtDesc")
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtLeftTime = self:getTxt("txtLeftTime")
	self._timeBg = self:getGo("upInfoTran/bgIma")
end

function TLCExchangeView:onEnter()
	TLCExchangeView.super.onEnter(self)

	self._challengeId = checknumber(self:getFirstParam())

	local cfgs = TimeLimitedConfig.instance:getExchangeOpens()
	local newCfgs = {}

	for _, v in ipairs(cfgs) do
		if TLChallengeController.instance:isInOpenTimeByCfg(v) then
			if TimeGateController.instance:isTimeGateTypeByChallengeId(v.challengeId) then
				if TimeGateController.instance:isOpenByChallengeId(v.challengeId) then
					table.insert(newCfgs, v)
				end
			else
				table.insert(newCfgs, v)
			end
		end
	end

	self._leftBtnDic = {}

	GameUtil.updateCellsWithCreate(self._btnContainer, newCfgs, self._updateOneBtn, self)

	if #newCfgs == 0 then
		local text = "本活动已经结束"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			self:close()

			if TLChallengeController.instance:isInOpenTime(1) then
				UIStateManager.instance:popByName(ViewName.AruisiMainView)
			end
		end)

		self._challengeId = -1
	elseif self._challengeId == nil or self._challengeId <= 0 then
		self._challengeId = newCfgs[1].challengeId
	end

	print("self._challengeId=  " .. self._challengeId)
	self:_onClickBtn(self._challengeId, true)
	self:_onTick()
	settimer(0.5, self._onTick, self)
	GlobalDispatcher:addListener(GlobalNotify.TimedChallengeDoExchange, self._onDoExchangeRes, self)
end

function TLCExchangeView:_updateOneBtn(cell, data)
	local txtName = goutil.findChildTextComponent(cell, "sel/Txt")

	txtName.text = data.name
	txtName = goutil.findChildTextComponent(cell, "unSel/Txt2")
	txtName.text = data.name

	local btn = Framework.ButtonAdapter.Get(cell)

	btn:AddClickListener(function()
		self:_onClickBtn(data.challengeId)
	end)

	self._leftBtnDic[data.challengeId] = cell
end

function TLCExchangeView:_updateUI(msg)
	self._curViewDatas = {}

	local list = TLChallengeModel.instance:getExchangeInfo(self._challengeId)

	for _, v in ipairs(list) do
		local cfg = TimeLimitedConfig.instance:getExchangeCfgById(v.exchangeId)

		if TLChallengeController.instance:isInOpenTimeByCfg(cfg) then
			table.insert(self._curViewDatas, v)
		end
	end

	self._tickedTexts = {}

	self:reloadData()
	self:_onTick()
end

function TLCExchangeView:_updateGoldBar()
	local cfg = TimeLimitedConfig.instance:getExchangeOpenCfg(self._challengeId)
	local accounts = string.split(cfg.accounts, "#")
	local btn_list = {}

	for _, v in ipairs(accounts) do
		table.insert(btn_list, {
			showAdd = false,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list)
end

function TLCExchangeView:_onTick()
	local exchangeCfg = TimeLimitedConfig.instance:getExchangeOpenCfg(self._challengeId)

	self._txtLeftTime.text = not TLChallengeController.instance:isInOpenTimeByCfg(exchangeCfg) and "活动已经结束" or string.format("剩余：%s", TLChallengeController.instance:getExchangeLeftTimeFormated(self._challengeId))

	if self._tickedTexts then
		for k, v in pairs(self._tickedTexts) do
			if not TLChallengeController.instance:isInOpenTimeByCfg(v) then
				k.text = "已过期"
			else
				local leftTime = TLChallengeController.instance:_getLeftTimeFormat(v)

				k.text = leftTime ~= "00:00:00" and "剩余：" .. leftTime or ""
			end
		end
	end
end

function TLCExchangeView:_updateCell(view, cell, data)
	cell = cell.gameObject

	local exchangeCfg = TimeLimitedConfig.instance:getExchangeCfgById(data.exchangeId)

	if exchangeCfg == nil then
		return
	end

	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtLimit = goutil.findChildTextComponent(cell, "txtLimit")
	local pointItem = goutil.findChild(cell, "pointItem")
	local goSoldOut = goutil.findChild(cell, "goSoldOut")
	local imgIcon = goutil.findChild(cell, "imgIcon")
	local txtIcon = goutil.findChildTextComponent(cell, "txtIcon")
	local txtBuyTimes = goutil.findChildTextComponent(cell, "txtBuyTimes")
	local txtLeftTime = goutil.findChildTextComponent(cell, "txtLeftTime")

	self._tickedTexts[txtLeftTime] = exchangeCfg

	MaterialMgr.resetAll(pointItem)

	local matType, matId, matNum = unpack(string.splitToNumber(exchangeCfg.gain, ":"))
	local cfg = MaterialMgr.getMatCfg(matType, matId)

	txtName.text = exchangeCfg.name

	MaterialMgr.setCellByCfg(exchangeCfg.gain, pointItem)

	local canBuy = true

	if exchangeCfg.dailyTimes > 0 then
		canBuy = canBuy and data.dailyTimes < exchangeCfg.dailyTimes
		txtLimit.text = string.format("每日限兑：%s/%s", exchangeCfg.dailyTimes - data.dailyTimes, exchangeCfg.dailyTimes)
	else
		txtLimit.text = ""
	end

	if exchangeCfg.totalTimes > 0 then
		canBuy = canBuy and data.totalTimes < exchangeCfg.totalTimes
		txtBuyTimes.text = string.format("活动限兑：%s/%s", exchangeCfg.totalTimes - data.totalTimes, exchangeCfg.totalTimes)
	else
		txtBuyTimes.text = ""
	end

	goSoldOut:SetActive(not canBuy)

	local btn = Framework.ButtonAdapter.Get(cell)

	matType, matId, matNum = MaterialMgr.getMatParams(exchangeCfg.cost)
	cfg = MaterialMgr.getMatCfg(matType, matId)

	uGuiUtil.setSpriteToImage(imgIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.icon))

	txtIcon.text = matNum > 0 and matNum or "免费"

	btn:AddClickListener(function()
		self:_onClickBuy(data, canBuy, matType, matId, matNum, cfg.name)
	end)
end

function TLCExchangeView:_onClickBuy(data, canBuy, matType, matId, matNum, matName)
	local cfg = TimeLimitedConfig.instance:getExchangeCfgById(data.exchangeId)

	if not TLChallengeController.instance:isInOpenTimeByCfg(cfg) then
		FloatWordMgr.instance:show(lang("超出时间限制，不能兑换"))
	end

	if not canBuy then
		FloatWordMgr.instance:show(lang("购买次数达到上限"))
	elseif matNum > MaterialModel.instance:getMaterialsNumber(matType, matId) then
		FloatWordMgr.instance:show(langPara("你的%s不足%s个", matName, matNum))
	else
		UIStateManager.instance:push(ViewName.TLCExchangeWndView, cfg)
	end
end

function TLCExchangeView:_onDoExchangeRes(exchangeId)
	UIStateManager.instance:popByName(ViewName.TLCExchangeWndView)
	self:_updateUI()
end

function TLCExchangeView:_onClickBtn(challengeId, isForce)
	print("TLCExchangeView click challengeId = " .. challengeId)

	if isForce or challengeId ~= self._challengeId then
		self._challengeId = challengeId

		for k, v in pairs(self._leftBtnDic) do
			self:_setBtnSelected(v, self._challengeId == k)
		end

		if self._challengeId <= 0 then
			self._curViewDatas = {}

			self:reloadData()

			return
		end

		local cfg = TimeLimitedConfig.instance:getExchangeOpenCfg(self._challengeId)

		self._txtTip.text = cfg.desc

		if TLChallengeModel.instance:getExchangeInfo(self._challengeId) == nil then
			TimedChallengeAgent.instance:sendPM_TimedChallengeGetExchangeInfoReq(self._challengeId, self._onExchangeInfoRes, self, self._errorInfoRes)
		else
			self:_updateUI()
		end

		self:_updateGoldBar()
		self:_updateTimeGos(cfg.openTimeType ~= 4)
	end
end

function TLCExchangeView:_updateTimeGos(isShow)
	goutil.setActive(self._timeBg, isShow)
	goutil.setActive(self._txtLeftTime.gameObject, isShow)
end

function TLCExchangeView:_setBtnSelected(btn, selected)
	local sel = goutil.findChild(btn, "sel")
	local unSel = goutil.findChild(btn, "unSel")
	local graphic = btn:GetComponent(typeof(UnityEngine.UI.Graphic))

	if not goutil.isNil(graphic) then
		-- block empty
	end

	sel:SetActive(selected)
	unSel:SetActive(not selected)
end

function TLCExchangeView:_onExchangeInfoRes(msg)
	TLChallengeModel.instance:setExchangeInfo(self._challengeId, msg.infoList)
	self:_updateUI()
end

function TLCExchangeView:_errorInfoRes()
	TLChallengeModel.instance:setExchangeInfo(self._challengeId, {})
	self:_updateUI()
end

return TLCExchangeView
