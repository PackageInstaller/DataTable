-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarypreheat/view/TenthAnniversaryPreheatView.lua

module("logic.extensions.anniversarypreheat.view.TenthAnniversaryPreheatView", package.seeall)

local TenthAnniversaryPreheatView = class("TenthAnniversaryPreheatView", ViewComponent)

function TenthAnniversaryPreheatView:buildUI()
	TenthAnniversaryPreheatView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goTableview = self:getGo("tableview")
	self._goCell = self:getGo("cell")
	self._tableView = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._goBottom = self:getGo("bottom")
	self._btnShare = goutil.findChild(self._goBottom, "btnShare")
	self._btnBullet = goutil.findChild(self._goBottom, "btnBullet")
	self._goPrizeCell = goutil.findChild(self._goBottom, "cell")
	self._goPrizetableView = goutil.findChild(self._goBottom, "tableView")
	self._prizeTableView = ScrollerList.create(self._goPrizetableView, self._goPrizeCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._clipRect = goutil.findChild(self._goPrizetableView, "ViewPort"):GetComponent(goutil.Type_RectTransform)
	self._txtProgress = goutil.findChildTextComponent(self._goBottom, "txtCurProgress")
	self._sldPrgress = self:getSlider("bottom/tableView/ViewPort/Content/progressSlider")
	self._txtTip = goutil.findChildTextComponent(self._goBottom, "tip/txt")
	self._bubble = goutil.findChild(self._goBottom, "bubble")
	self._itemShare = goutil.findChild(self._bubble, "pointItem")
	self._togBullet = self:getToggle("bottom/btnCloseBullet")
	self._goDisplayer = self:getGo("displayer")
	self._displayer = self._goDisplayer:GetComponent("BulletScreenDisplayer")
	self._txtTime = self:getTxt("txtTime")
	self._shareImg = self:getGo("shareImg")
end

function TenthAnniversaryPreheatView:bindEvents()
	TenthAnniversaryPreheatView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnShare, self.onClickShare, self)
	GameUtil.addClickHandler(self._btnBullet, self.onClickBullet, self)
	self._togBullet:AddOnValueChanged(function()
		self:_onBulletValueChanged(self._togBullet.isOn)
	end)
end

function TenthAnniversaryPreheatView:unbindEvents()
	TenthAnniversaryPreheatView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnShare)
	GameUtil.rmClickHandler(self._btnBullet)
	self._togBullet:RemoveOnValueChanged()
end

function TenthAnniversaryPreheatView:onEnter()
	TenthAnniversaryPreheatView.super.onEnter(self)

	self._actId = AnniversaryPreheatModel.instance:getActIdByCfg()

	if self._actId > 0 then
		self:refreshViewByCfg()
		AnniversaryPreheatController.instance:getInfo()
	else
		local text = "活动未开始"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
	end

	AnniversaryPreheatController.instance:getInfo()
	GlobalDispatcher:addListener(GlobalNotify.AnniversaryPreheatError, self._onError, self)
	GlobalDispatcher:addListener(GlobalNotify.AnniversaryPreheatGetInfo, self.updateViewByInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.AnniversaryPreheatDanMuInfoUpdate, self._handleDanMuInfoPart, self)
end

function TenthAnniversaryPreheatView:onExit()
	TenthAnniversaryPreheatView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AnniversaryPreheatError, self._onError, self)
	GlobalDispatcher:removeListener(GlobalNotify.AnniversaryPreheatGetInfo, self.updateViewByInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.AnniversaryPreheatDanMuInfoUpdate, self._handleDanMuInfoPart, self)
	self:_removeAllEffect()
	self._tableView:dispose()
	self._prizeTableView:dispose()
	MaterialMgr.resetAll(self._itemShare)
	self._displayer:Clear()
	removetimer(self._onTick, self)
end

function TenthAnniversaryPreheatView:_onError(status)
	if status == -62 then
		local text = "活动未开始"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
	end
end

function TenthAnniversaryPreheatView:refreshViewByCfg()
	self._actTimeCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.Anniversary_Preheat)
	self._actCfg = AnniversaryPreheatConfig.instance:getActCfg(self._actId)
	self._prizeCfgs = AnniversaryPreheatConfig.instance:getPrizeCfgs(self._actId)
	self._hudCfgs = AnniversaryPreheatConfig.instance:getHudCfgs(self._actId)

	self._tableView:reloadData(self._hudCfgs)

	self._txtTip.text = langPara("分享可增加%s期待值，每日限<color=#20b376>%s</color>次，发表弹幕可增加%s期待值，每日限<color=#20b376>%s</color>次", self._actCfg.shareAddScore, 1, self._actCfg.danMuScore, self._actCfg.danMuTimes)
	self._curEndTime = GameUtil.string2time(self._actTimeCfg.endTime)

	self:_onTick()
	settimer(1, self._onTick, self)
end

function TenthAnniversaryPreheatView:updateViewByInfo()
	self._shareState = AnniversaryPreheatModel.instance:getCurShareState()

	MaterialMgr.resetAll(self._itemShare)

	local proxy = MaterialMgr.setCellByCfg(self._actCfg.sharePrize, self._itemShare)

	if self._shareState == 1 then
		goutil.setActive(self._bubble, true)
		GameUtil.SetGray(self._btnShare, true)
		proxy.binder:setAutoTips(false)
		proxy.binder:setCallBack(function()
			AnniversaryPreheatController.instance:gainSharePrize()
		end)
	elseif self._shareState == 2 then
		goutil.setActive(self._bubble, false)
		GameUtil.SetGray(self._btnShare, true)
	else
		goutil.setActive(self._bubble, true)
		GameUtil.SetGray(self._btnShare, false)
		proxy.binder:setGray(true)
	end

	self:_updateDanMuPart()
	self:_setProgressPart()
end

function TenthAnniversaryPreheatView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.con = goutil.findChild(cell.go, "con")
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtDesc")

	uGuiUtil.clearImage(cell.con)
	GameUtil.rmClickHandler(cell.go)

	return cell
end

function TenthAnniversaryPreheatView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.txtDesc.text = data.txtDesc

	if not string.nilorempty(data.showPicPath) then
		local picPath = string.format("ui/bigbg/anniversarypreheat/%s.png", data.showPicPath)

		uGuiUtil.setSpriteToImage(cell.con, uGuiUtil.SpriteType.BigBg, picPath)
	end

	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickJumpTo, self, data))
end

function TenthAnniversaryPreheatView:_onClickJumpTo(data)
	local timeStart = ServerTime.now()
	local isTimeMatch = GameUtil.checkIsInTimePeriod(data.startTime, data.endTime)

	if isTimeMatch then
		GotoMgr.gotoByString(data.jumpTo)
	else
		FloatWordMgr.instance:show(data.offlineTip)
	end
end

function TenthAnniversaryPreheatView:_clearPrizeCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.item = goutil.findChild(cell.go, "item/itemcell")
	cell.mark = goutil.findChild(cell.go, "item/received")
	cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")

	goutil.setActive(cell.mark, false)
	MaterialMgr.resetAll(cell.item)
	self:_removeEffect(cell.go)

	return cell
end

function TenthAnniversaryPreheatView:_updatePrizeCell(view, goCell, data)
	local cell = self:_clearPrizeCell(goCell)

	cell.txtNum.text = data.progress

	local proxy = MaterialMgr.setCellByCfg(data.prize, cell.item)
	local isMatchProgress = self._curProgress >= data.progress
	local isHasGain = AnniversaryPreheatModel.instance:getIsGainPrizeState(data.id)

	goutil.setActive(cell.mark, isHasGain)

	if isMatchProgress and not isHasGain then
		self:_createEff("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", cell.item, cell.go, true, self._clipRect)
		proxy.binder:setAutoTips(false)
		proxy.binder:setCallBack(function()
			AnniversaryPreheatController.instance:gainProgressPrize(data.id)
		end)
	end
end

function TenthAnniversaryPreheatView:_createEff(effPath, effParent, effKey, isLoop, clipRect)
	self._exictEffs = self._exictEffs or {}

	if not effParent then
		return
	end

	local exictEff = self._exictEffs[effKey]

	if exictEff then
		UIEffectManager.instance:stopEffect(exictEff)

		self._exictEffs[effKey] = nil
	end

	self._exictEffs[effKey] = UIEffectManager.instance:playEffect(self, effPath, effParent.transform, 0, 0, isLoop, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(effParent.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)

		if clipRect then
			eff:setClipping(clipRect)
		end
	end)
end

function TenthAnniversaryPreheatView:_removeAllEffect()
	if self._exictEffs then
		for _, eff in pairs(self._exictEffs) do
			UIEffectManager.instance:stopEffect(eff)
		end

		self._exictEffs = nil
	end
end

function TenthAnniversaryPreheatView:_removeEffect(key)
	if self._exictEffs then
		if self._exictEffs then
			UIEffectManager.instance:stopEffect(self._exictEffs)

			self._exictEffs[key] = nil
		end
	end
end

function TenthAnniversaryPreheatView:_setProgressPart()
	self._curProgress = AnniversaryPreheatModel.instance:getCurProgress()

	self._prizeTableView:reloadData(self._prizeCfgs)

	self._txtProgress.text = langPara("全服：%s", self._curProgress)

	local sldValue = 0

	if self._prizeCfgs and #self._prizeCfgs > 1 then
		local stepNum = #self._prizeCfgs
		local stepValue = checknumber(1) / checknumber(stepNum)
		local addValue = 0

		if self._curProgress >= self._prizeCfgs[1].progress then
			sldValue = sldValue + stepValue
		end

		for i = 1, stepNum - 1 do
			local cfg = self._prizeCfgs[i]
			local nextCfg = self._prizeCfgs[i + 1]

			if self._curProgress >= nextCfg.progress then
				addValue = stepValue
				sldValue = sldValue + stepValue

				if self._curProgress == nextCfg.progress then
					break
				end
			else
				sldValue = sldValue + checknumber(self._curProgress - cfg.progress) / checknumber(nextCfg.progress - cfg.progress) * stepValue

				break
			end
		end
	end

	self._sldPrgress:SetValue(sldValue)
end

function TenthAnniversaryPreheatView:onClickShare()
	if self._shareState ~= 0 then
		FloatWordMgr.instance:show(lang("今日已分享"))
	else
		ShareController.instance:share(1, nil, self._shareImg:GetComponent(typeof(UnityEngine.UI.RawImage)).texture, 0, function()
			AnniversaryPreheatController.instance:sendSucShare()
		end)
	end
end

function TenthAnniversaryPreheatView:_onBulletValueChanged(isOn)
	AnniversaryPreheatController.instance:switchDanMuState(isOn)
end

function TenthAnniversaryPreheatView:_updateDanMuPart()
	local danMuState = AnniversaryPreheatModel.instance:getDanMuState()

	self._togBullet.isOn = danMuState
	self._infos = AnniversaryPreheatModel.instance:getDanMuInfo()
	self._isAbleToSetBullet = AnniversaryPreheatModel.instance:getIsAbleSetBullet()

	GameUtil.SetGray(self._btnBullet, not self._isAbleToSetBullet)
	goutil.setActive(self._goDisplayer, not danMuState)

	if danMuState then
		-- block empty
	elseif self._infos and #self._infos > 0 then
		-- block empty
	else
		AnniversaryPreheatController.instance:getDanMuInfos()
	end
end

function TenthAnniversaryPreheatView:_handleDanMuInfoPart()
	self._displayer:Clear()

	self._infos = AnniversaryPreheatModel.instance:getDanMuInfo()

	if self._infos and #self._infos > 0 then
		for _, v in pairs(self._infos) do
			local danMuCfg = AnniversaryPreheatConfig.instance:getBulletScreenCfgById(checkint(v.danmuId))

			if danMuCfg then
				local bullet = langPara("%s:%s", v.senderName, danMuCfg.content)

				self._displayer:AddBullet(bullet, false)
			end
		end
	end
end

function TenthAnniversaryPreheatView:onClickBullet()
	if self._isAbleToSetBullet then
		UIStateManager.instance:push(ViewName.TenthAnniversaryBulletView)
	else
		FloatWordMgr.instance:show(lang("今日发表弹幕次数已耗尽"))
	end
end

function TenthAnniversaryPreheatView:_onTick()
	local timeLeft = self._curEndTime - ServerTime.now()

	if timeLeft > 0 then
		self._txtTime.text = langPara("%s", GameUtil.FormatTimeSymbol(timeLeft))
	else
		FloatWordMgr.instance:show(lang("当前活动结束"))
		self:close()
	end
end

return TenthAnniversaryPreheatView
