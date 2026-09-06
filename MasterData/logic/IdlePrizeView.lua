-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idlegame/view/IdlePrizeView.lua

module("logic.extensions.idlegame.view.IdlePrizeView", package.seeall)

local IdlePrizeView = class("IdlePrizeView", ViewComponent)
local TAB_PROGRESS = 1
local TAB_ACT = 2

function IdlePrizeView:ctor()
	IdlePrizeView.super.ctor(self)
end

function IdlePrizeView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnProgress:AddClickListener(self._onClickProgress, self)
	self._btnAct:AddClickListener(self._onClickAct, self)
end

function IdlePrizeView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function IdlePrizeView:buildUI()
	self._closeButton = self:getBtn("main/Btn_Close")
	self._btnProgress = self:getBtn("main/tabs/BtnProgress")
	self._progressSel = goutil.findChild(self._btnProgress.gameObject, "Sel")
	self._progressUnSel = goutil.findChild(self._btnProgress.gameObject, "Txt2")
	self._btnAct = self:getBtn("main/tabs/BtnAct")
	self.btnList = {}

	table.insert(self.btnList, self._btnProgress)
	table.insert(self.btnList, self._btnAct)

	self._panelProgress = self:getGo("main/Pnl_Progress")
	self._txtTotalMoney = goutil.findChildComponent(self._panelProgress, "bom/txtTotalMoney", "Text")
	self.Txt_Tip2 = goutil.findChild(self._panelProgress, "bom/Txt_Tip2")
	self._progressView = goutil.findChildComponent(self._panelProgress, "tableview", "UITableview")
	self._progressCell = goutil.findChild(self._panelProgress, "tablecell")

	self._progressView:RegisterCallback(self._numInProgressView, self._progressCellSize, self._progressCellAtIndex, self)
	self._progressView:SetOffsetWithoutRefresh(0)
	goutil.setActive(self._progressCell, false)
end

function IdlePrizeView:destroyUI()
	return
end

function IdlePrizeView:onEnter()
	self._tabIndex = 1

	self:setUIState(self._tabIndex, true)
	IdleGameController.instance:registerLocalNotify("ReceiveProgressPrize", self._onReceiveProgressPrize, self)
	IdleGameController.instance:registerLocalNotify("onAddMoney", self._onMoneyAdd, self)

	self._nextNeedMoney = IdleGameModel.instance:getNextProgressNeedMoney()

	local actId = checknumber(IdleGameModel.instance.activityId)
	local actType = math.floor(actId / 1000)

	if actId <= 0 or not ActivityDefineController.instance:isInActivityTimeById(actType, actId) then
		GameUtil.SetActive(self._btnAct, false)
	end
end

function IdlePrizeView:onEnterFinished()
	return
end

function IdlePrizeView:onExit()
	IdleGameController.instance:unregisterLocalNotify("ReceiveProgressPrize", self._onReceiveProgressPrize, self)
	IdleGameController.instance:unregisterLocalNotify("onAddMoney", self._onMoneyAdd, self)
end

function IdlePrizeView:onExitFinished()
	return
end

function IdlePrizeView:_onClickClose()
	self:close()
end

function IdlePrizeView:_numInProgressView()
	if self._progressViewDatas ~= nil then
		return #self._progressViewDatas
	else
		return 0
	end
end

function IdlePrizeView:_progressCellSize()
	return 762, 105
end

function IdlePrizeView:_progressCellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._progressCell)

	local data = self._progressViewDatas[idx + 1]
	local txtProgress = goutil.findChildComponent(cell.gameObject, "txtProgress", "Text")
	local btnReceive = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Btn_Get")
	local itemGet = goutil.findChild(cell.gameObject, "Img_Get")
	local cfg = IdleGameConfig.instance:getProgressPrize(data.id)

	btnReceive:RemoveClickListener()

	local isReceived = IdleGameModel.instance:getPrizeReceived(data.id)

	if data.activityId then
		isReceived = IdleGameModel.instance:getActPrizeReceived(data.id)
		cfg = data
	end

	goutil.setActive(itemGet, isReceived)
	goutil.setActive(btnReceive.gameObject, not isReceived)

	if data.activityId then
		if not isReceived then
			local canReceive = StringUtil.CompareTwoNumber(IdleGameModel.instance:getTotalMoney(), cfg.target)

			uGuiUtil.setGoGrayState(btnReceive.gameObject, not canReceive)
			btnReceive:AddClickListener(function()
				self:_onclickActPirce(data.id, canReceive)
			end)
		end
	elseif not isReceived then
		local canReceive = StringUtil.CompareTwoNumber(IdleGameModel.instance:getTotalMoney(), cfg.target)

		uGuiUtil.setGoGrayState(btnReceive.gameObject, not canReceive)
		btnReceive:AddClickListener(function()
			self:_onClickReceive(data.id, canReceive)
		end)
	end

	txtProgress.text = StringUtil.numberToString(cfg.target)

	self:_updateItems(cell.gameObject, cfg.prize)

	return cell
end

function IdlePrizeView:setUIState(tab, isForce)
	GameUtil.SetActive(self._panelProgress, tab == TAB_ACT or tab == TAB_PROGRESS)
	GameUtil.SetActive(self.Txt_Tip2, tab == TAB_PROGRESS)

	for i, v in ipairs(self.btnList) do
		local _progressSel = goutil.findChild(v.gameObject, "Sel")
		local Txt2 = goutil.findChild(v.gameObject, "Txt2")

		goutil.setActive(_progressSel, i == tab)
		goutil.setActive(Txt2, i ~= tab)
	end

	if isForce or self._tabIndex ~= tab then
		if tab == TAB_PROGRESS then
			self._progressViewDatas = IdleGameConfig.instance:getProgressPrizes()

			table.sort(self._progressViewDatas, IdlePrizeView.sortProgressPrizes)
			self._progressView:ReloadData()

			self._txtTotalMoney.text = StringUtil.numberToString(IdleGameModel.instance:getTotalMoney())
		elseif tab == TAB_ACT then
			self._progressViewDatas = IdleGameConfig.instance:getActPirzes(IdleGameModel.instance.activityId)

			self._progressView:Refresh()
			self._progressView:ReloadData()

			self._txtTotalMoney.text = StringUtil.numberToString(IdleGameModel.instance:getTotalMoney())
		end
	end

	self._tabIndex = tab
end

function IdlePrizeView.sortProgressPrizes(a, b)
	local isReceivedA = IdleGameModel.instance:getPrizeReceived(a.id)
	local isReceivedB = IdleGameModel.instance:getPrizeReceived(b.id)

	if isReceivedA ~= isReceivedB then
		return isReceivedB
	else
		return a.id < b.id
	end
end

function IdlePrizeView:_updateItems(go, itemStr)
	local t = string.split(itemStr, "#")

	for i = 1, 3 do
		local container = goutil.findChild(go, "Item_" .. i)
		local point = goutil.findChild(container, "point")

		goutil.setActive(container, i <= #t)

		if i <= #t then
			MaterialMgr.setCellByCfg(t[i], point)
		end
	end
end

function IdlePrizeView:_onClickProgress()
	self:setUIState(TAB_PROGRESS)
end

function IdlePrizeView:_onClickAct()
	self:setUIState(TAB_ACT)
end

function IdlePrizeView:_onClickReceive(id, canReceive)
	if not canReceive then
		FloatWordMgr.instance:show("还不能领取哦")
	else
		XiaoNuoPlaceAgent.instance:sendPM_XiaoNuoPrizeReq(id, function(msg)
			IdleGameModel.instance:setPrizeReceived(id)
			IdleGameController.instance:localNotify("ReceiveProgressPrize")
		end)
	end
end

function IdlePrizeView:_onclickActPirce(id, canReceive)
	if not canReceive then
		FloatWordMgr.instance:show("还不能领取哦")
	else
		XiaoNuoPlaceAgent.instance:sendPM_XiaoNuoGainActivityPrizeReq(id, function(msg)
			IdleGameModel.instance:setActPrizeReceived(id)
			IdleGameController.instance:localNotify("ReceiveProgressPrize")
			self:close()
		end)
	end
end

function IdlePrizeView:_onReceiveProgressPrize()
	self:setUIState(self._tabIndex, true)
end

function IdlePrizeView:_onMoneyAdd()
	local temp = IdleGameModel.instance:getNextProgressNeedMoney()

	if not self._tabIndex then
		return
	end

	if temp > self._nextNeedMoney or temp == -1 and temp ~= self._nextNeedMoney then
		self:setUIState(true, true)

		self._nextNeedMoney = temp
	end

	self._txtTotalMoney.text = StringUtil.numberToString(IdleGameModel.instance:getTotalMoney())
end

return IdlePrizeView
