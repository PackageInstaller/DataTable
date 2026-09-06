-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandpowergiftView.lua

module("logic.extensions.newhandwelfare.view.NewhandpowergiftView", package.seeall)

local NewhandpowergiftView = class("NewhandpowergiftView", TableViewComponent)

function NewhandpowergiftView:ctor()
	NewhandpowergiftView.super.ctor(self)

	self._tempVector2 = Vector2.New(0, 0)
end

function NewhandpowergiftView:unbindEvents()
	NewhandpowergiftView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnGet:RemoveClickListener()
end

function NewhandpowergiftView:bindEvents()
	NewhandpowergiftView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnBuy:AddClickListener(self._onClickbtnBuy, self)
	self._btnGet:AddClickListener(self._onClickbtnGet, self)
end

function NewhandpowergiftView:buildUI()
	NewhandpowergiftView.super.buildUI(self)

	self._txtPower = goutil.findChildTextComponent(self.mainGO, "main/txtPower")
	self._btnClose = self:getBtn("btnClose")
	self._txtBtnget = goutil.findChildTextComponent(self.mainGO, "main/btnGet/Text")
	self._txtBtnbuy = goutil.findChildTextComponent(self.mainGO, "main/btnBuy/txtBtnbuy")
	self._btnBuy = self:getBtn("main/btnBuy")
	self._btnGet = self:getBtn("main/btnGet")
	self._scrollRect = self._tableview.gameObject:GetComponent(ComponentType.ScrollRect)
	self._itemGroupList = {}
	self._effectHandlers = {}
	self._txtPower = goutil.findChildTextComponent(self.mainGO, "main/txtPower")
	self._supreLockGo = self:getGo("main/iconBottom/lock")
	self._sldProgressGo = self:getGo("main/ScrollView/Viewport/Content/sldProgress")
	self._sldProgressTr = self._sldProgressGo.transform
	self._sldProgressSlider = Framework.SliderAdapter.Get(self._sldProgressGo)

	self._sldProgressSlider:SetValue(0)

	self._txtLeftTime = self:getTxt("leftTime/txt")
end

function NewhandpowergiftView:onExit()
	NewhandpowergiftView.super.onExit(self)
	removetimer(self._onTicking, self)
	GlobalDispatcher:removeListener(NewhandwelfareController.NewHandWelfareGainZdlPrizeRes, self._NewHandWelfareGainZdlPrizeRes, self)
	GlobalDispatcher:removeListener(NewhandwelfareController.NewHandWelfareOneKeyGainZdlPrizeRes, self._NewHandWelfareGainZdlPrizeRes, self)
	GlobalDispatcher:removeListener(NewhandwelfareController.PM_NotifyNewHandWelfarePaySucRes, self._PM_NotifyNewHandWelfarePaySucRes, self)

	self._isFirstEnter = false
end

function NewhandpowergiftView:onEnter()
	NewhandpowergiftView.super.onEnter(self)

	self._periodId = NewhandwelfareModel.instance:getPeriodId()

	GlobalDispatcher:addListener(NewhandwelfareController.NewHandWelfareGainZdlPrizeRes, self._NewHandWelfareGainZdlPrizeRes, self)
	GlobalDispatcher:addListener(NewhandwelfareController.NewHandWelfareOneKeyGainZdlPrizeRes, self._NewHandWelfareGainZdlPrizeRes, self)
	GlobalDispatcher:addListener(NewhandwelfareController.PM_NotifyNewHandWelfarePaySucRes, self._PM_NotifyNewHandWelfarePaySucRes, self)
	self.addGEvent(self, NewhandwelfareController.NewHandWelfareGetInfoRes, self._updateTime, self)

	self._curViewDatas = NewhandwelfareConfig.instance:getZdlRewardCfgs(self._periodId) or {}
	self._txtPower.text = "历史最高战力:" .. RoleModel.instance:getMaxPower()
	self._isFirstEnter = true

	self:reloadData()
	self:_setBuySuperPrizeState()
	self:_setBtnGetState()
	self:_setPowerTxt()
	self:_setProgress()
	self:_updateTime()
end

function NewhandpowergiftView:_getPath()
	return {
		cellPath = "main/cell",
		viewPath = "main/ScrollView"
	}
end

function NewhandpowergiftView:_updateCell(view, cell, cfg)
	local txtPower = goutil.findChildTextComponent(cell.gameObject, "txtPower")
	local goLeftitemcon = goutil.findChild(cell.gameObject, "leftitemcon")
	local goRightitemcon = goutil.findChild(cell.gameObject, "rightitemcon")
	local goItemcell = goutil.findChild(cell.gameObject, "itemcell")

	self:_setReward(goLeftitemcon, goRightitemcon, goItemcell, cfg.normalPrize, cfg.superPrize, cfg.prizeId)

	txtPower.text = cfg.needZdl
end

function NewhandpowergiftView:_clearTableview(cell)
	local goLeftitemcon = goutil.findChild(cell.gameObject, "leftitemcon")
	local goRightitemcon = goutil.findChild(cell.gameObject, "rightitemcon")

	if self._itemGroupList[goLeftitemcon] then
		self._itemGroupList[goLeftitemcon]:dispose(self._clearRewardCell, self)
	end

	if self._itemGroupList[goRightitemcon] then
		self._itemGroupList[goRightitemcon]:dispose(self._clearRewardCell, self)
	end
end

function NewhandpowergiftView:_setReward(goLeftItemcon, goRightItemcon, goItemcell, normalPrize, superPrize, prizeId)
	local leftGroup = self._itemGroupList[goLeftItemcon]

	if not leftGroup then
		leftGroup = ItemGroup.New(goLeftItemcon, goItemcell, nil, nil, true)
		self._itemGroupList[goLeftItemcon] = leftGroup
	end

	local rightGroup = self._itemGroupList[goRightItemcon]

	if not rightGroup then
		rightGroup = ItemGroup.New(goRightItemcon, goItemcell, nil, nil, true)
		self._itemGroupList[goRightItemcon] = rightGroup
	end

	local leftArr = string.split(normalPrize, "#")
	local rightArr = string.split(superPrize, "#")

	leftGroup:updateWithMoArray(leftArr, function(item, cfg)
		self:_updateRewardCell(item, cfg, prizeId, true)
	end)
	rightGroup:updateWithMoArray(rightArr, function(item, cfg)
		self:_updateRewardCell(item, cfg, prizeId, false)
	end)
end

function NewhandpowergiftView:_updateRewardCell(item, cfgStr, prizeId, isNormal)
	local btnGet = Framework.ButtonAdapter.GetFrom(item.mainGO, "btnGet")
	local goEffect = goutil.findChild(item.mainGO, "effect")
	local goImgReceived = goutil.findChild(item.mainGO, "imgReceived")
	local goItemcon = goutil.findChild(item.mainGO, "itemcon")
	local isReceive = NewhandwelfareModel.instance:isGainZdlPrize(prizeId, isNormal)
	local canGain = NewhandwelfareModel.instance:checkCanGainZdlPrize(self._periodId, prizeId, isNormal)

	goutil.setActive(goImgReceived, isReceive)
	goutil.setActive(btnGet.gameObject, canGain)
	MaterialMgr.setCellByCfg(cfgStr, goItemcon)

	if self._effectHandlers[goEffect] then
		UIEffectManager.instance:stopEffect(self._effectHandlers[goEffect])

		self._effectHandlers[goEffect] = nil
	end

	if canGain then
		local effName = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
		local handler

		handler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true, nil, nil, function()
			handler:setScrollRectClipping(self._scrollRect)
		end)

		handler:setParent(goEffect.transform)
		handler:setLocalPos(0, 0, 0)
		handler:setScale(1)

		self._effectHandlers[goEffect] = handler
	end

	btnGet:AddClickListener(function()
		self:_onClickRewardItem(prizeId, isNormal)
	end)
end

function NewhandpowergiftView:_clearRewardCell(item)
	local goEffect = goutil.findChild(item.mainGO, "effect")

	if self._effectHandlers[goEffect] then
		UIEffectManager.instance:stopEffect(self._effectHandlers[goEffect])

		self._effectHandlers[goEffect] = nil
	end

	local goItemcon = goutil.findChild(item.mainGO, "itemcon")

	MaterialMgr.resetAll(goItemcon)
end

function NewhandpowergiftView:_onClickRewardItem(prizeId, isNormal)
	isNormal = checkbool(isNormal)

	if NewhandwelfareModel.instance:isGainZdlPrize(prizeId, isNormal) then
		return
	end

	if NewhandwelfareModel.instance:checkCanGainZdlPrize(self._periodId, prizeId, isNormal) then
		NewhandwelfareController.instance:recordGainZdlPrizeIsNormal(isNormal)
		NewHandWelfareAgent.instance:sendNewHandWelfareGainZdlPrizeReq(prizeId, isNormal)
	end
end

function NewhandpowergiftView:_onReloadFinish()
	if self._isFirstEnter then
		self._isFirstEnter = false

		local currScore = RoleModel.instance:getMaxPower()

		if self._curViewDatas[#self._curViewDatas] then
			if not self._curViewDatas[#self._curViewDatas].needZdl then
				local needZdl = 0

				if needZdl <= currScore then
					self._tableview:MoveOffset(126 * (#self._curViewDatas - 2), true, false)

					return
				end

				for i, v in ipairs(self._curViewDatas) do
					if currScore < v.needZdl and i > 1 then
						self._tableview:MoveOffset(126 * (i - 2), true, false)

						break
					end
				end
			end
		end
	end
end

function NewhandpowergiftView:_NewHandWelfareGainZdlPrizeRes(status)
	if status == 0 then
		self:reloadData()
		self:_setBtnGetState()
	end
end

function NewhandpowergiftView:_onClickbtnClose()
	self:close()
end

function NewhandpowergiftView:_onClickbtnBuy()
	if self._periodId <= 0 then
		return
	end

	local isBuy = NewhandwelfareModel.instance:isBuyZDLSuperPrize()

	if isBuy then
		FloatWordMgr.instance:show("已购买领袖密令")

		return
	end

	UIStateManager.instance:push(ViewName.NewhandpowergiftbuyView)
end

function NewhandpowergiftView:_onClickbtnGet()
	local isBuySuper = NewhandwelfareModel.instance:isBuyZDLSuperPrize()
	local canGetPrize = NewhandwelfareModel.instance:checkZdlPrizeDot()

	if canGetPrize then
		NewHandWelfareAgent.instance:sendNewHandWelfareOneKeyGainZdlPrizeReq()
	elseif not isBuySuper then
		self:_onClickbtnBuy()
	else
		FloatWordMgr.instance:show("当前无奖励可领取")
	end
end

function NewhandpowergiftView:_setBuySuperPrizeState()
	local isBuy = NewhandwelfareModel.instance:isBuyZDLSuperPrize()

	goutil.setActive(self._btnBuy.gameObject, not isBuy)
	goutil.setActive(self._supreLockGo.gameObject, not isBuy)

	if not isBuy then
		local payGoodsId = NewhandwelfareConfig.instance:getCommonValue("BUY_ZDL_SUPER_PRIZE_PRICE")

		self._txtBtnbuy.text = string.format("%s元激活", PayConfig.instance:getPayMoneyYuan(payGoodsId))
	end
end

function NewhandpowergiftView:_setBtnGetState()
	local canGetPrize = NewhandwelfareModel.instance:checkZdlPrizeDot()
	local isBuy = NewhandwelfareModel.instance:isBuyZDLSuperPrize()

	self._txtBtnget.text = (canGetPrize or isBuy) and "一键领取" or "继续领取"
end

function NewhandpowergiftView:_PM_NotifyNewHandWelfarePaySucRes(status)
	if status == 0 then
		self:_setBtnGetState()
		self:_setBuySuperPrizeState()
		self:reloadData()
	end
end

function NewhandpowergiftView:_setPowerTxt()
	local maxPower = 0
	local curZDL = RoleModel.instance:getMaxPower()
	local cfgs = NewhandwelfareConfig.instance:getZdlRewardCfgs(self._periodId) or {}

	for i, v in ipairs(cfgs) do
		maxPower = math.max(maxPower, v.needZdl)
	end

	self._txtPower.text = string.format("%s/%s", curZDL, maxPower)
end

function NewhandpowergiftView:_setProgress()
	local currScore = RoleModel.instance:getMaxPower()
	local prizeCfgs = NewhandwelfareConfig.instance:getZdlRewardCfgs(self._periodId) or {}
	local len = Mathf.Max(#prizeCfgs - 1, 0)

	self._tempVector2.y = self._sldProgressTr.sizeDelta.y
	self._tempVector2.x = 126 * len
	self._sldProgressTr.sizeDelta = self._tempVector2

	local fill = 0

	if #prizeCfgs > 0 then
		local step = 1 / len

		if prizeCfgs[#prizeCfgs] then
			if not prizeCfgs[#prizeCfgs].needZdl then
				local needZdl = 0

				if needZdl <= currScore then
					fill = 1
				else
					local nextScore = 0
					local lastScore = 0

					for i, v in ipairs(prizeCfgs) do
						if currScore >= v.needZdl then
							if i ~= 1 then
								fill = fill + step
							end

							lastScore = v.needZdl
						else
							nextScore = v.needZdl

							break
						end
					end

					if lastScore < currScore and currScore > prizeCfgs[1].needZdl then
						fill = fill + (currScore - lastScore) / (nextScore - lastScore) * step
					end
				end
			end
		end
	end

	self._sldProgressSlider:SetValue(fill)
end

function NewhandpowergiftView:_updateTime()
	self._endTime = NewhandwelfareModel.instance:getNewHandPlayerEndTime()

	settimer(1, self._onTicking, self, true)
	self:_onTicking()
end

function NewhandpowergiftView:_onTicking()
	local leftTime = Mathf.Max(self._endTime - ServerTime.now(), 0)

	self._txtLeftTime.text = GameUtil.FormatTimeWordsNoSec(leftTime)

	if leftTime <= 0 then
		leftTime = 0

		removetimer(self._onTicking, self)
	end
end

return NewhandpowergiftView
