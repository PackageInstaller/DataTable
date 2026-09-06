-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulategift/view/NineYearsSignView.lua

module("logic.extensions.accumulategift.view.NineYearsSignView", package.seeall)

local NineYearsSignView = class("NineYearsSignView", TableViewComponent)

function NineYearsSignView:ctor()
	NineYearsSignView.super.ctor(self)

	self._actId = 18002
	self._petRaceId = 1014501
	self._itemEffList = nil
end

function NineYearsSignView:buildUI()
	NineYearsSignView.super.buildUI(self)

	self.closeBtn = self:getBtn("closeBtn")
	self.tipsBtn = self:getBtn("tipsBtn")
end

function NineYearsSignView:bindEvents()
	NineYearsSignView.super.bindEvents(self)
	self.closeBtn:AddClickListener(self.close, self)
	self.tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "nineyearssign")
	end, self)
end

function NineYearsSignView:unbindEvents()
	NineYearsSignView.super.unbindEvents(self)
	self.closeBtn:RemoveClickListener()
	self.tipsBtn:RemoveClickListener()
end

function NineYearsSignView:onExit()
	NineYearsSignView.super.onExit(self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._SendOperationCheckInGetInfoReq, self)

	for _, eff in pairs(self._itemEffList) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self._itemEffList = nil
	self._isViewOver = false
	self._curViewDatas = nil
end

function NineYearsSignView:destroyUI()
	NineYearsSignView.super.destroyUI(self)
end

function NineYearsSignView:onEnter()
	NineYearsSignView.super.onEnter(self)

	self._isViewOver = false
	self._allCfgs = OperationSignInConfig.instance:getSignInCfgList(self._actId)

	if #self._allCfgs > 1 then
		table.sort(self._allCfgs, function(a, b)
			return a.day < b.day
		end)
	end

	self._signList = {}
	self._loginDay = 0

	self:_UpdataItemListSR()
	self:_SendOperationCheckInGetInfoReq()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._SendOperationCheckInGetInfoReq, self)
end

function NineYearsSignView:_SendOperationCheckInGetInfoReq()
	OperationCheckInAgent.instance:sendPM_OperationCheckInGetInfoReq(self._actId, function(msg)
		if checknumber(msg.onlineDay) > 0 then
			self._loginDay = msg.onlineDay
		end

		if msg.hasGainPrizeDays then
			self._signList = msg.hasGainPrizeDays
		end

		self:_UpdataItemListSR()
	end)
end

function NineYearsSignView:_CalculationSurplusTime()
	self._supTime = self._supTime - 1

	if self._supTime <= 0 then
		removetimer(self._CalculationSurplusTime, self)

		self.timeTxt.text = "活动结束"
		self._isViewOver = true

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._supTime)

	self.timeTxt.text = day > 0 and string.format("活动时间: %s天%s时%s分", day, hour, min) or string.format("活动时间： %s时%s分%s秒", hour, min, sec)
end

function NineYearsSignView:_UpdataItemListSR()
	self._curViewDatas = {}

	for _, cfg in pairs(self._allCfgs or {}) do
		if cfg and not string.nilorempty(cfg.reward) then
			local data = {}

			data.day = cfg.day
			data.goodsList = string.split(cfg.reward, ":")
			data.stageNum = self:_GetItemStageNum(cfg.day)

			table.insert(self._curViewDatas, data)
		end
	end

	if #self._curViewDatas > 1 then
		table.sort(self._curViewDatas, function(a, b)
			if a.stageNum == b.stageNum then
				return a.day < b.day
			end

			return a.stageNum < b.stageNum
		end)
	end

	self._itemEffList = self._itemEffList or {}

	for _, eff in pairs(self._itemEffList) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self._tableview:ReloadData()
end

function NineYearsSignView:_GetItemStageNum(day)
	for k, coun in pairs(self._signList or {}) do
		if k and checknumber(coun) > 0 and day == coun then
			return 3
		end
	end

	if day <= self._loginDay then
		return 1
	end

	return 2
end

function NineYearsSignView:_OnClickSkillExplainBtn(isSkill)
	UIJumper.instance:pushOneStack(self._viewPresentor.viewName, true)

	if isSkill then
		PetbookController.instance:previewBattle(self._petRaceId)
	else
		PetbookController.instance:openPetinfoView(self._petRaceId)
	end
end

function NineYearsSignView:_getPath()
	return {
		cellPath = "itemCell",
		viewPath = "itemListSR"
	}
end

function NineYearsSignView:_cellSize()
	return 140, 310
end

function NineYearsSignView:_updateCell(view, cell, data)
	local goodsGo = goutil.findChild(cell, "goodsGo")
	local awardGo = goutil.findChild(cell, "awardGo")
	local dayNumTxt = goutil.findChildTextComponent(cell, "dayNumTxt")
	local awardBtnGo = goutil.findChild(cell, "awardBtn")
	local awardTxt = goutil.findChildTextComponent(cell, "awardBtn/awardTxt")
	local imgRedGo = goutil.findChild(cell, "awardBtn/imgRedGo")
	local effectGo = goutil.findChild(cell, "effectGo")

	GameUtil.asBtn(awardBtnGo):RemoveClickListener()
	MaterialMgr.resetAll(goodsGo)

	if data.stageNum == 1 then
		GameUtil.SetActive(dayNumTxt, false)
		awardGo:SetActive(false)
		awardBtnGo:SetActive(true)
		imgRedGo:SetActive(true)

		awardTxt.text = "领取"

		local effect = UIEffectManager.instance:playEffect(self, "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab", effectGo, 0, 0, true, nil, nil, function(self2, uiEffect)
			uiEffect:setScrollRectClipping(self._scrollRect)
			uiEffect:setParent(effectGo.transform)
			uiEffect:setScale(1.1)

			uiEffect.hideEffWhileNotOnTop = true
			self._itemEffList[cell] = uiEffect
		end)
	elseif data.stageNum == 2 then
		GameUtil.SetActive(dayNumTxt, true)

		dayNumTxt.text = tostring(data.day)

		awardGo:SetActive(false)

		awardTxt.text = ""

		imgRedGo:SetActive(false)
		awardBtnGo:SetActive(false)
	elseif data.stageNum == 3 then
		GameUtil.SetActive(dayNumTxt, false)
		awardGo:SetActive(true)
		awardBtnGo:SetActive(true)
		imgRedGo:SetActive(false)

		awardTxt.text = "已领取"
	end

	if data.goodsList and #data.goodsList > 2 then
		local itemType = checknumber(data.goodsList[1])
		local proxy = MaterialMgr.setCell(itemType, checknumber(data.goodsList[2]), goodsGo)

		proxy.binder:setNum(checknumber(data.goodsList[3]))

		if itemType == MatType.Pet then
			local lv = data.goodsList[4] and checknumber(data.goodsList[4]) or 1

			proxy.binder:setLvl(lv)
		end
	end

	if data.stageNum == 2 then
		return
	end

	GameUtil.asBtn(awardBtnGo):AddClickListener(function()
		self:_OnClickAwardBtn(data)
	end, self)
end

function NineYearsSignView:_OnClickAwardBtn(data)
	if data.stageNum == 2 then
		FloatWordMgr.instance:show("未满足领取条件！")

		return
	end

	if data.stageNum == 3 then
		return
	end

	OperationCheckInAgent.instance:sendPM_OperationCheckInGainPrizeReq(self._actId, data.day, function(msg)
		self._signList = self._signList or {}

		table.insert(self._signList, data.day)
		self:_UpdataItemListSR()
	end)
end

return NineYearsSignView
