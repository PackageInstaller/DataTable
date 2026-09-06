-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/view/NumberBombView.lua

module("logic.extensions.numberbomb.view.NumberBombView", package.seeall)

local NumberBombView = class("NumberBombView", TableViewComponent)

function NumberBombView:ctor()
	NumberBombView.super.ctor(self)

	self._commonCfgInfo = nil
	self._gameBaseInfo = nil
	self._actiId = nil
	self._costInfo = nil
	self._isOpen = false
	self._isDoing = false
	self._txtTweenPos = nil
	self._txtTweenFade = nil
end

function NumberBombView:bindEvents()
	NumberBombView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.NumberRule)
	end, self)
	self._startBtn:AddClickListener(self._onClickStartBtn, self)
	self._annalBtn:AddClickListener(function()
		if not self._isOpen then
			FloatWordMgr.instance:show("活动结束")

			return
		end

		UIStateManager.instance:push(ViewName.NumberRecord)
	end, self)
	self._rankBtn:AddClickListener(function()
		if not self._isOpen then
			FloatWordMgr.instance:show("活动结束")

			return
		end

		UIStateManager.instance:push(ViewName.NumberRank)
	end, self)
	self._rewardBtn:AddClickListener(function()
		if not self._isOpen then
			FloatWordMgr.instance:show("活动结束")

			return
		end

		UIStateManager.instance:push(ViewName.NumberReward)
	end, self)
end

function NumberBombView:unbindEvents()
	NumberBombView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._startBtn:RemoveClickListener()
	self._annalBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._rewardBtn:RemoveClickListener()

	if self._txtTweenPos then
		self._txtTweenPos:RemoveListener()
	end
end

function NumberBombView:onExit()
	NumberBombView.super.onExit(self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil

	for _, eff in pairs(self._cellEffs or {}) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self._cellEffs = {}

	removetimer(self._calculationSurplusTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.NumberGameBaseInfo, self._updataShowView, self)
	GlobalDispatcher:removeListener(GlobalNotify.ReceiveGameSocrePrize, self._receiveGameSocrePrize, self)
	GlobalDispatcher:removeListener(GlobalNotify.ReceiveGameProPrize, self._updataShowView, self)

	if self._txtTweenPos then
		self._txtTweenPos:Stop()
	end

	if self._txtTweenFade then
		self._txtTweenFade:Stop()
	end

	self._txtTweenPos = nil
	self._txtTweenFade = nil

	NumberGameModel.instance:getAndSetGameOverData()
end

function NumberBombView:destroyUI()
	NumberBombView.super.destroyUI(self)

	local biBig = self._biIconIma.gameObject:GetComponent("ImageBigBG")

	if biBig then
		biBig:ClearImage()
	end

	local getBig = self._getIcon.gameObject:GetComponent("ImageBigBG")

	if getBig then
		getBig:ClearImage()
	end

	self._commonCfgInfo = nil
	self._gameBaseInfo = nil
	self._actiId = nil
	self._costInfo = nil
	self._isOpen = false
	self._isDoing = false
end

function NumberBombView:buildUI()
	NumberBombView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._timeTxt = self:getTxt("time/timeTxt")
	self._startBtn = self:getBtn("startBtn")
	self._openDesTxt = goutil.findChildTextComponent(self.mainGO, "openDesTxt")
	self._scoreCountTxt = goutil.findChildTextComponent(self.mainGO, "scoreCountTxt")
	self._rankCountTxt = goutil.findChildTextComponent(self.mainGO, "rankCountTxt")
	self._sessionCountTxt = goutil.findChildTextComponent(self.mainGO, "sessionCountTxt")
	self._biCountTxt = goutil.findChildTextComponent(self.mainGO, "biCountTxt")
	self._biIconIma = self:getGo("biCountTxt/biIconIma"):GetComponent("Image")
	self._scoreChangeTxt = goutil.findChildTextComponent(self.mainGO, "scoreChangeTxt")
	self._annalBtn = self:getBtn("annalBtn")
	self._annalRed = self:getGo("annalBtn/annalRed")
	self._rankBtn = self:getBtn("rankBtn")
	self._rankRed = self:getGo("rankBtn/rankRed")
	self._rewardBtn = self:getBtn("rewardBtn")
	self._rewardRed = self:getGo("rewardBtn/rewardRed")
	self._scoreImaGo = self:getGo("scoreImaGo")
	self._rectClip = self:getGo("cellItemSR/Viewport"):GetComponent(goutil.Type_RectTransform)

	local getMatGo = self:getGo("getMatGo")

	self._getIcon = goutil.findChild(getMatGo, "getIconGo"):GetComponent("Image")
	self._getCountTxt = goutil.findChildTextComponent(getMatGo, "getCountTxt")
	self._progBarGo = self:getGo("cellItemSR/Viewport/Content/progBarGo/progBarSli")
	self._progBarSli = self._progBarGo:GetComponent("Slider")
	self._progBarSli.value = 0
	self._timeTxt.text = ""
	self._openDesTxt.text = ""
	self._scoreCountTxt.text = ""
	self._rankCountTxt.text = ""
	self._sessionCountTxt.text = ""
	self._biCountTxt.text = ""
	self._scoreChangeTxt.text = ""

	self._annalRed:SetActive(false)
	self._rankRed:SetActive(false)
	self._rewardRed:SetActive(false)
end

function NumberBombView:onEnter()
	NumberBombView.super.onEnter(self)

	self._scoreChangeTxt.text = ""
	self._actiId = NumberGameConfig.instance:getOpenActivityId()
	self._commonCfgInfo = NumberGameConfig.instance:getCommonInfo()

	if checknumber(self._actiId) <= 0 then
		print("sr---炸弹数字 NumberBombView:onEnter()   1获取的活动时间id为空 = ", self._actiId)

		self._actiId = self._commonCfgInfo.lastActiId
	end

	if checknumber(self._actiId) <= 0 then
		printError("sr---炸弹数字 NumberBombView:onEnter()   2获取的活动时间id为空 = ", self._actiId)

		return
	end

	local actiCfg = ActivityDefineConfig.instance:getCfgById(self._commonCfgInfo.actiType, self._actiId)

	self._endTime = 0

	if actiCfg and not string.nilorempty(actiCfg.endTime) then
		self._endTime = GameUtil.string2time(actiCfg.endTime)
	end

	local cfg = NumberGameConfig.instance:getActivityCfg(self._actiId)

	if cfg == nil or string.nilorempty(cfg.coinItem) then
		printError("sr---炸弹数字 NumberBombView:onEnter()   当前活动时间类型没有配置 = ", self._actiId)

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.NumberGameBaseInfo, self._updataShowView, self)
	GlobalDispatcher:addListener(GlobalNotify.ReceiveGameSocrePrize, self._receiveGameSocrePrize, self)
	GlobalDispatcher:addListener(GlobalNotify.ReceiveGameProPrize, self._updataShowView, self)

	local value = GameUtil.getUserData("NumberBombPopup")

	if checknumber(value) ~= 1 then
		GameUtil.saveUserData("NumberBombPopup", 1)
		UIStateManager.instance:push(ViewName.NumberRule)
	end

	self._curViewDatas = NumberGameConfig.instance:getNumberProgressCfgs(cfg.progressPrizePlan)
	self._isOpen = true
	self._isDoing = true
	self._cellEffs = self._cellEffs or {}

	local list = string.split(cfg.coinItem, ":")

	self._costInfo = {
		have = 0,
		matType = checknumber(list[1]),
		matId = checknumber(list[2])
	}

	self:_showActivityTimer()
	self:_updataShowView(true)
	MaterialMgr.setIcon(self._getIcon, self._costInfo.matType, self._costInfo.matId)
	MaterialMgr.setIcon(self._biIconIma, self._costInfo.matType, self._costInfo.matId)
	NumberGameController.instance:csGetGameBaseInfoReq()

	local effPath = "fx_ui_zdsz/fx_ui_zdsz_zhumianban.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function NumberBombView:_showActivityTimer()
	removetimer(self._calculationSurplusTime, self)

	if self._endTime <= 0 or self._endTime <= ServerTime.now() then
		self._timeTxt.text = "活动结束"

		self:_updataStartTxtShow(true)

		return
	end

	if self._endTime > ServerTime.now() then
		self:_calculationSurplusTime()
		settimer(1, self._calculationSurplusTime, self, true)
	end
end

function NumberBombView:_calculationSurplusTime()
	local supTime = self._endTime - ServerTime.now()

	if supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timeTxt.text = "活动结束"

		self:_updataStartTxtShow(true)

		return
	end

	self:_updataStartTxtShow()

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self._timeTxt.text = day > 0 and string.format("剩余时间: %s天%s时%s分", day, hour, min) or string.format("剩余时间： %s时%s分%s秒", hour, min, sec)
end

function NumberBombView:_updataShowView(isEnter)
	self._gameBaseInfo = NumberGameModel.instance:getGameBaseInfo()

	local count = self._gameBaseInfo.allCoinCount

	self._costInfo.have = count
	self._getCountTxt.text = tostring(count)
	self._rankCountTxt.text = self._gameBaseInfo.rank <= 0 and "未上榜" or tostring(self._gameBaseInfo.rank)
	self._sessionCountTxt.text = string.format("%s/%s/%s", self._gameBaseInfo.totalGameTimes, (checknumber(self._gameBaseInfo.curScore) > 0 and checknumber(self._gameBaseInfo.totalGameTimes) > 0 or nil) and string.format("%.1f", self._gameBaseInfo.curScore / self._gameBaseInfo.totalGameTimes), self._gameBaseInfo.winGameTimes)
	self._biCountTxt.text = self._gameBaseInfo.todayCoinCount .. "/" .. self._commonCfgInfo.daibiMax

	self:_startCreateTween(isEnter)

	local isRed = NumberGameModel.instance:getGameRewardRedpoint()

	self._rewardRed:SetActive(isRed)
	self:_updateShowProgressBar()
end

function NumberBombView:_startCreateTween(isEnter)
	self._scoreCountTxt.text = tostring(self._gameBaseInfo.curScore)

	local overInfo = NumberGameModel.instance:getAndSetGameOverData(true)

	if isEnter or overInfo == nil or checknumber(overInfo.endScore) == 0 then
		if self._txtTweenPos then
			self._txtTweenPos:Stop()
		end

		if self._txtTweenFade then
			self._txtTweenFade:Stop()
		end

		return
	end

	UIEffectManager.instance:playEffect(self, "fx_ui_zdsz/fx_ui_zdsz_jifen.prefab", self._scoreImaGo, 0, 0, false, nil, nil, function(view, uiEffect)
		uiEffect:setParent(self._scoreImaGo.transform)
		uiEffect:setLocalPos(-50, 0, 0)
		uiEffect:setScale(1)

		if self._txtTweenPos == nil then
			self._txtTweenPos = UnityTweens.TweenPosition.Create(self._scoreChangeTxt.gameObject, Vector3.New(-400, -183, 0), Vector3.New(-400, -140, 0), 1, UnityTweens.EaseType.easeInSine, 0.8)

			self._txtTweenPos:AddListener(function()
				self._scoreCountTxt.text = tostring(self._gameBaseInfo.curScore)
				self._scoreChangeTxt.text = ""
			end, self)
		end

		if self._txtTweenFade == nil then
			self._txtTweenFade = UnityTweens.UITweenFade.Create(self._scoreChangeTxt.gameObject, 1, 0, 1, UnityTweens.EaseType.easeInQuad, 0.8)
		end

		self._scoreCountTxt.text = tostring(self._gameBaseInfo.befScore)
		self._scoreChangeTxt.text = overInfo.endScore > 0 and string.format("<color=#EB4642FF>+%s</color>", overInfo.endScore) or string.format("<color=#20b376FF>-%s</color>", math.abs(overInfo.endScore))

		self._txtTweenPos:Begin()
		self._txtTweenFade:Begin()
		NumberGameModel.instance:getAndSetGameOverData()
	end)
end

function NumberBombView:_updataStartTxtShow(isEnd)
	self._isDoing = NumberGameModel.instance:isNumberGameDoing()
	self._openDesTxt.text = self._commonCfgInfo.opentimeTips
end

function NumberBombView:_receiveGameSocrePrize(prizeId)
	local isRed = NumberGameModel.instance:getGameRewardRedpoint()

	self._rewardRed:SetActive(isRed)
end

function NumberBombView:_onClickStartBtn()
	if not self._isOpen then
		FloatWordMgr.instance:show("当前活动已结束")

		return
	end

	if not self._isDoing then
		FloatWordMgr.instance:show("开放时间 " .. self._commonCfgInfo.opentimeTips)

		return
	end

	if self._gameBaseInfo.todayCoinCount >= self._commonCfgInfo.daibiMax then
		local value = GameUtil.getUserDayData("NumberBombDaibiCount")

		if checknumber(value) ~= 1 then
			GameUtil.saveUserDayData("NumberBombDaibiCount", 1)

			local des = "今日获得炸弹币已达上限\n继续游戏，无法获得炸弹币哦！\n积分获得不受影响！"

			TipsFacade.instance:openTipWindow("匹配提示", des, function()
				NumberGameController.instance:startMatch()
			end, "知道了", UnityEngine.TextAnchor.MiddleCenter)

			return
		end
	end

	NumberGameController.instance:startMatch()
end

function NumberBombView:_updateShowProgressBar()
	if self._curViewDatas then
		if not #self._curViewDatas then
			local count = 0

			self._tableview:ReloadData()

			local width = count * 120 + 1

			GameUtil.setWidth(self._progBarGo, width)

			if count == 0 or self._costInfo.have <= 0 then
				self._progBarSli.value = 0

				return
			end

			local once = 1 / count
			local value = 0

			for i = 1, count do
				if self._curViewDatas[i] then
					if self._curViewDatas[i].needCount <= self._costInfo.have then
						value = value + once
					else
						local syc = 0

						if self._curViewDatas[i - 1] and self._curViewDatas[i - 1].needCount > 0 then
							syc = self._curViewDatas[i - 1].needCount
						end

						local temp = (self._costInfo.have - syc) * once / (self._curViewDatas[i].needCount - syc)

						value = value + temp

						break
					end
				end
			end

			self._progBarSli.value = value
		end
	end
end

function NumberBombView:_onCellUpdatePosition(pos)
	local contentGo = self._tableview:GetContent()

	if self._curViewDatas then
		if not #self._curViewDatas then
			local count = 0
			local width = count * 120 + 60

			GameUtil.setWidth(contentGo, width)
			Framework.TransformUtil.SetLocalPos(self._progBarGo.transform, contentGo.transform.localPosition.x, -105, 0)
		end
	end
end

function NumberBombView:_onReloadFinish()
	self:_onCellUpdatePosition()
end

function NumberBombView:_getPath()
	return {
		cellPath = "cellItem",
		viewPath = "cellItemSR"
	}
end

function NumberBombView:_cellSize()
	return 120, 150
end

function NumberBombView:_updateCell(view, cell, data)
	local goodsGo = goutil.findChild(cell, "goodsGo")
	local countTxt = goutil.findChildTextComponent(cell, "countTxt")
	local stageIma = goutil.findChildComponent(cell, "stageIma", "UIChangeGroup")
	local lingquGo = goutil.findChild(cell, "lingquGo")
	local clickGo = goutil.findChild(cell, "clickGo")

	MaterialMgr.resetAll(goodsGo)
	GameUtil.asBtn(clickGo):RemoveClickListener()

	if self._cellEffs and self._cellEffs[cell] then
		UIEffectManager.instance:stopEffect(self._cellEffs[cell])
	end

	MaterialMgr.setCellByCfg(data.prize, goodsGo)

	countTxt.text = tostring(data.needCount)

	GameUtil.SetActive(lingquGo, false)

	if cell.data == #self._curViewDatas then
		Framework.TransformUtil.SetLocalPos(stageIma.gameObject.transform, 53.5, 45.6, 0)
	else
		Framework.TransformUtil.SetLocalPos(stageIma.gameObject.transform, 60, 45.6, 0)
	end

	if data.needCount > self._costInfo.have then
		stageIma:SetState(0)
		GameUtil.SetActive(clickGo, false)

		return
	end

	stageIma:SetState(1)

	if self._gameBaseInfo.proPrizeIds and table.indexof(self._gameBaseInfo.proPrizeIds, data.prizeId) then
		GameUtil.SetActive(lingquGo, true)
		GameUtil.SetActive(clickGo, false)

		return
	end

	self._cellEffs[cell] = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", goodsGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(goodsGo.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 0.9, 0.9, 0.9)
		eff:setClipping(self._rectClip)
	end)

	GameUtil.SetActive(clickGo, true)
	GameUtil.asBtn(clickGo):AddClickListener(function()
		NumberGameController.instance:csSendNGGainProgressPrizeReq(data.prizeId)
	end, self)
end

return NumberBombView
