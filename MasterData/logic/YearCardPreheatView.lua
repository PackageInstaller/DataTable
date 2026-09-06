-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat/view/YearCardPreheatView.lua

module("logic.extensions.yearcardpreheat.view.YearCardPreheatView", package.seeall)

local YearCardPreheatView = class("YearCardPreheatView", ViewComponent)

function YearCardPreheatView:buildUI()
	YearCardPreheatView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtDailyTime = self:getTxt("txtDailyTime")
	self._txtTotalTime = self:getTxt("totalTime/txt")
	self._txtProgress = self:getTxt("curProgress/txt")
	self._btnEnterGame = self:getBtn("btnEnterGame")
	self.con = self:getGo("petCon")
	self._cellList = {}

	for i = 1, 6 do
		local cell = {}

		cell.go = self:getGo("cellList/cell" .. i)
		cell.goPrize = goutil.findChild(cell.go, "prize")
		cell.goBtnPrize = goutil.findChild(cell.goPrize, "btn")
		cell.btnPrize = GameUtil.asBtn(cell.goBtnPrize)
		cell.markGained = goutil.findChild(cell.goPrize, "receive")
		cell.matCell = goutil.findChild(cell.goPrize, "matCell")
		cell.goInfo = goutil.findChild(cell.go, "info")
		cell.goShowInfo = goutil.findChild(cell.goInfo, "showInfo")
		cell.txtShowInfo = goutil.findChildTextComponent(cell.goShowInfo, "txt")
		cell.goHideInfo = goutil.findChild(cell.goInfo, "hideInfo")
		cell.txtHideInfo = goutil.findChildTextComponent(cell.goHideInfo, "txt")
		cell.goBtnEvent = goutil.findChild(cell.goInfo, "btnEvent")
		cell.btnEvent = GameUtil.asBtn(cell.goBtnEvent)
		cell.goCover = goutil.findChild(cell.go, "cover")
		cell.goBtnUnlock = goutil.findChild(cell.goCover, "btn")
		cell.btnUnlock = GameUtil.asBtn(cell.goBtnUnlock)
		cell.txtShowTip = goutil.findChildTextComponent(cell.goCover, "txtShowTip")
		cell.cfg = nil
		self._cellList[i] = cell
	end

	self._petRareCell = self:getGo("petInfo/rare")
end

function YearCardPreheatView:bindEvents()
	YearCardPreheatView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnEnterGame:AddClickListener(self._onClickEnterGame, self)

	for i = 1, 6 do
		local cell = self._cellList[i]

		cell.btnPrize:AddClickListener(function()
			self:_onClickGainPrize(i)
		end, self)
		cell.btnUnlock:AddClickListener(function()
			self:_onClickUnlock(i)
		end, self)
		cell.btnEvent:AddClickListener(function()
			self:_onClickEvent(i)
		end, self)
	end
end

function YearCardPreheatView:unbindEvents()
	YearCardPreheatView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnEnterGame:RemoveClickListener()

	for i = 1, 6 do
		local cell = self._cellList[i]

		cell.btnPrize:RemoveClickListener()
		cell.btnUnlock:RemoveClickListener()
		cell.btnEvent:RemoveClickListener()
	end
end

function YearCardPreheatView:onEnter()
	YearCardPreheatView.super.onEnter(self)
	self:_resetView()

	self._curActId = YearCardPreheatModel.instance:getCurActId()

	if self._curActId > 0 then
		self:_refreshViewByCfg()
		AnnualFeePreheatAgent.instance:sendPM_GetAnnualFeeInfoReq(self._curActId)
	end

	GlobalDispatcher:addListener(GlobalNotify.YearCardPreheatError, self._onError, self)
	GlobalDispatcher:addListener(GlobalNotify.YearCardPreheatUndateInfo, self._refreshViewByInfo, self)

	self._roleId = 16001
	self._curRoleId = self._roleId
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, self._curRoleId, self.con, 1)

	local petCo = CharacterConfig.instance:getPetCo(self._roleId)
	local proxy = MaterialMgr.setCell(MatType.Rare, self._roleId, self._petRareCell)
end

function YearCardPreheatView:onExit()
	YearCardPreheatView.super.onExit(self)

	for i = 1, 6 do
		local cell = self._cellList[i]

		MaterialMgr.resetAll(cell.matCell)
	end

	self:_removeAllEffect()
	GlobalDispatcher:removeListener(GlobalNotify.YearCardPreheatError, self._onError, self)
	GlobalDispatcher:removeListener(GlobalNotify.YearCardPreheatUndateInfo, self._refreshViewByInfo, self)

	self.loader = RoleObjectPool.instance:removeRole(self.loader)

	MaterialMgr.resetAll(self._petRareCell)
end

function YearCardPreheatView:_onError(status)
	self:close()
end

function YearCardPreheatView:_resetView()
	for i = 1, 6 do
		local cell = self._cellList[i]

		goutil.setActive(cell.go, false)
		goutil.setActive(cell.goCover, true)
		goutil.setActive(cell.goShowInfo, true)
		goutil.setActive(cell.goHideInfo, false)
		goutil.setActive(cell.goBtnPrize, false)
		goutil.setActive(cell.goBtnEvent, false)

		cell.txtShowInfo.text = ""
		cell.txtHideInfo.text = ""
		cell.txtShowTip.text = ""

		MaterialMgr.resetAll(cell.matCell)
	end

	self:_removeAllEffect()
end

function YearCardPreheatView:_refreshViewByCfg()
	self._curActCfg = YearCardPreheatConfig.instance:getCommonCfgByActId(self._curActId)

	if self._curActCfg then
		local cfgs = YearCardPreheatConfig.instance:getInfoCfgByPlanId(self._curActCfg.informationPlanId)
		local prizeCfgs = YearCardPreheatConfig.instance:getPrizeCfgByPlanId(self._curActCfg.prizePlanId)

		for i = 1, 6 do
			local cell = self._cellList[i]

			if cfgs[i] then
				cell.cfg = cfgs[i]
				cell.txtShowInfo.text = lang(cell.cfg.showTip)
				cell.txtShowTip.text = lang(cell.cfg.unlockTip)

				if not string.nilorempty(cell.cfg.btnEvent) then
					goutil.setActive(cell.goBtnEvent, true)
				end

				goutil.setActive(cell.go, true)
				MaterialMgr.setCellByCfg(prizeCfgs[i].prize, cell.matCell)
			end
		end
	end
end

function YearCardPreheatView:_refreshViewByInfo()
	local _model = YearCardPreheatModel.instance
	local timeTotalLeft = self._curActCfg.totalLimit - _model.totalTime
	local timeDailyLeft = self._curActCfg.dailyLimit - _model.dailyTime

	self._txtDailyTime.text = langPara("今日剩余奖励次数：%s/%s", timeTotalLeft < timeDailyLeft and timeTotalLeft or timeDailyLeft, self._curActCfg.dailyLimit)
	self._txtTotalTime.text = timeTotalLeft
	self._txtProgress.text = _model.progress

	for i = 1, 6 do
		local cell = self._cellList[i]

		if _model.progress >= cell.cfg.progress then
			local gainEffPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

			self:_createEff(gainEffPath, cell.goBtnPrize, "gainEff" .. i, true)
			goutil.setActive(cell.goBtnPrize, not _model.prizeStatus[i])
			goutil.setActive(cell.goCover, not _model.unlockStatus[i])

			gainEffPath = "20211217/chizhijiemi/fx_ui_czjm_kejiesuo.prefab"

			self:_createEff("20211217/chizhijiemi/fx_ui_czjm_kejiesuo.prefab", cell.goCover, "lockEff" .. i, true)
			goutil.setActive(cell.markGained, _model.prizeStatus[i])
		end
	end
end

function YearCardPreheatView:_createEff(effPath, effParent, effKey, isLoop)
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
		eff:setClipping(effParent:GetComponent(goutil.Type_RectTransform))
	end)
end

function YearCardPreheatView:_removeAllEffect()
	if self._exictEffs then
		for _, eff in pairs(self._exictEffs) do
			UIEffectManager.instance:stopEffect(eff)
		end

		self._exictEffs = nil
	end
end

function YearCardPreheatView:_removeEffect(key)
	if self._exictEffs then
		if self._exictEffs then
			UIEffectManager.instance:stopEffect(self._exictEffs)

			self._exictEffs[key] = nil
		end
	end
end

function YearCardPreheatView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "yearcardpreheat")
end

function YearCardPreheatView:_onClickEnterGame()
	local _model = YearCardPreheatModel.instance
	local dailyTimeLeft = self._curActCfg.dailyLimit - _model.dailyTime
	local totalTimeLeft = self._curActCfg.totalLimit - _model.totalTime

	if dailyTimeLeft == 0 then
		FloatWordMgr.instance:show(lang("活动奖励次数已全部使用，本次揭秘不会获得奖励"))
	elseif totalTimeLeft == 0 then
		FloatWordMgr.instance:show(lang("活动奖励次数已全部使用，本次揭秘不会获得奖励"))
	end

	UIStateManager.instance:push(ViewName.YearCardPreheatGameEnterView)
end

function YearCardPreheatView:_onClickUnlock(id)
	local cell = self._cellList[id]

	if cell.cfg then
		local _model = YearCardPreheatModel.instance

		if _model.progress >= cell.cfg.progress then
			YearCardPreheatModel.instance:setUnlockId(id)
			AnnualFeePreheatAgent.instance:sendPM_AnnualFeeUnlockReq(self._curActId, id)

			local gainEffPath = "20211217/chizhijiemi/fx_ui_czjm_jiesuo.prefab"

			self:_createEff(gainEffPath, cell.goInfo, "unlockEff" .. id, false)
		else
			FloatWordMgr.instance:show(lang("当前全服揭秘进度不满足解锁要求"))
		end
	end
end

function YearCardPreheatView:_onClickEvent(id)
	local cell = self._cellList[id]

	if cell.cfg then
		local event = cell.cfg.btnEvent

		if event == "txt" then
			goutil.setActive(cell.goShowInfo, false)
			goutil.setActive(cell.goBtnEvent, false)

			cell.txtHideInfo.text = lang(cell.cfg.eventParams)

			goutil.setActive(cell.goHideInfo, true)
		elseif event == "ui" then
			GotoMgr.gotoByString(string.format("ui#%s", cell.cfg.eventParams))
		elseif event == "rule" then
			UIStateManager.instance:open(ViewName.RulesView, cell.cfg.eventParams)
		elseif event == "skin" then
			local params = string.split(cell.cfg.eventParams, "#")
			local roleId = checkint(params[1])
			local scale = checknumber((not params[2] or nil) and 1)

			if roleId > 0 then
				if self._curRoleId == roleId then
					self._curRoleId = self._roleId
					scale = 1
				else
					self._curRoleId = roleId
				end

				self.loader = RoleObjectPool.instance:removeRole(self.loader)
				self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, self._curRoleId, self.con, scale)
			end
		else
			goutil.setActive(cell.goBtnEvent, false)
		end
	end
end

function YearCardPreheatView:_onClickGainPrize(id)
	local cell = self._cellList[id]

	if cell.cfg then
		YearCardPreheatModel.instance:setGetPrize(id)
		AnnualFeePreheatAgent.instance:sendPM_GainAnnualFeePrizeReq(self._curActId, id)
	end
end

return YearCardPreheatView
