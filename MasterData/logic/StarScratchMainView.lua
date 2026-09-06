-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starscratch/view/StarScratchMainView.lua

module("logic.extensions.starscratch.view.StarScratchMainView", package.seeall)

local StarScratchMainView = class("StarScratchMainView", ViewComponent)

function StarScratchMainView:ctor()
	StarScratchMainView.super.ctor(self)
end

function StarScratchMainView:unbindEvents()
	StarScratchMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPrePage)
	GameUtil.rmClickHandler(self._btnNextPage)
	GameUtil.rmClickHandler(self._btnGain)

	for i = 1, self._scratchCount do
		GameUtil.rmClickHandler(self._scratchList[i].btnStart)
	end
end

function StarScratchMainView:bindEvents()
	StarScratchMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnPrePage, self._onClickPre, self)
	GameUtil.addClickHandler(self._btnNextPage, self._onClickNext, self)
	GameUtil.addClickHandler(self._btnGain, self._onClickGain, self)

	for i = 1, self._scratchCount do
		local scratchUIGroup = self._scratchList[i]

		GameUtil.addClickHandler(scratchUIGroup.btnStart, function()
			self:_onClickStart(i)
		end, self)
		scratchUIGroup.scratch:regDragHandler(GameUtil.handler(function()
			self:_onScratchPointDown(i)
		end, self), nil, GameUtil.handler(function()
			self:_onScratchPointUp(i)
		end, self))
	end
end

function StarScratchMainView:buildUI()
	StarScratchMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnPrePage = self:getGo("btnPrePage")
	self._btnNextPage = self:getGo("btnNextPage")
	self._btnGain = self:getGo("btnGain")
	self._redPointGain = self:getGo("btnGain/redpoint")
	self._redPointPre = self:getGo("btnPrePage/redpoint")
	self._redPointNext = self:getGo("btnNextPage/redpoint")
	self._scratchArea = self:getGo("scratchArea")
	self._prizeCell = self:getGo("prizeCell")
	self._effectGo = self:getGo("effect")
	self._scratchList = {}
	self._scratchCount = self._scratchArea.transform.childCount

	for i = 1, self._scratchCount do
		local scratchUIGroup = {}

		scratchUIGroup.go = goutil.findChild(self._scratchArea, "scratch" .. i)
		scratchUIGroup.imgScatch = goutil.findChild(scratchUIGroup.go, "imgScatch")
		scratchUIGroup.rawImgScatch = scratchUIGroup.imgScatch:GetComponent(ComponentType.RawImage)
		scratchUIGroup.imgCover = goutil.findChild(scratchUIGroup.go, "imgCover")
		scratchUIGroup.txtTip = goutil.findChildTextComponent(scratchUIGroup.go, "txtTip")

		local prizeGo = goutil.findChild(scratchUIGroup.go, "prize")

		scratchUIGroup.prize = ItemGroup.New(prizeGo, self._prizeCell, nil, nil, true)
		scratchUIGroup.btnStart = goutil.findChild(scratchUIGroup.go, "btnStart")
		scratchUIGroup.effectGo = goutil.findChild(scratchUIGroup.go, "effect")
		scratchUIGroup.scratch = ScratchOffComponent.New()
		self._scratchList[i] = scratchUIGroup
	end

	self._txtDesc = self:getTxt("txtDesc")
	self._timeTableview = self:getGo("timeTableview")
	self._timeTableCell = self:getGo("timeTableCell")
	self._timeTableList = ScrollerList.create(self._timeTableview, self._timeTableCell, GameUtil.handler(self._updateTimeCell, self), GameUtil.handler(self._clearTimeCell, self))
	self._prizeShow = self:getGo("prizeShow")
	self._prizeShowCell = self:getGo("prizeShow/prizeShowCell")
	self._prizeShowList = ItemGroup.New(self._prizeShow, self._prizeShowCell)
	self._luckTableview = self:getGo("luckTableview")
	self._luckTableCell = self:getGo("luckTableCell")
	self._luckTableList = ScrollerList.create(self._luckTableview, self._luckTableCell, GameUtil.handler(self._updateLuckCell, self), GameUtil.handler(self._clearLuckCell, self))
	self._luckEmptyGo = self:getGo("luckEmptyGo")
	self._itemCon = self:getGo("txtNum/itemCon")
	self._txtNum = self:getTxt("txtNum")
	self._txtTime = self:getTxt("time/txt")
	self._imgBigGain = self:getGo("txtDesc/imgGain")
end

function StarScratchMainView:onExit()
	StarScratchMainView.super.onExit(self)
	self._luckTableList:dispose()
	self._timeTableList:dispose()
	self._prizeShowList:dispose(self._clearShowCell, self)

	for i = 1, self._scratchCount do
		self._scratchList[i].prize:dispose(self._clearPrizeCell, self)
		self._scratchList[i].scratch:onExit()
	end

	MaterialMgr.resetAll(self._itemCon)
	removetimer(self._changeShowPrize, self)
	removetimer(self._refreshShowTableView, self)
	removetimer(self._showPrize, self)
	removetimer(self._getLuckInfo, self)

	for i = 1, self._scratchCount do
		UIEffectManager.instance:stopEffect(self._scratchList[i].effect)
	end

	UIEffectManager.instance:stopEffect(self._bgEffect)
	RedPointController.instance:unregRedPoint(self._redPointGain)

	if self._scratchTex then
		goutil.destroy(self._scratchTex)

		self._scratchTex = nil
	end

	for i = 1, self._scratchCount do
		self._scratchList[i].scratch:onExit()
	end
end

function StarScratchMainView:onEnter()
	StarScratchMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_StarScratchInfoRes, self._PM_StarScratchInfoRes, self)
	self.addGEvent(self, GlobalNotify.PM_StarScratchBuyRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_StarScratchGainRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_StarScratchRefreshBroadcastRes, self._refreshLuckTableView, self)

	self._curCycleId = 1
	self._curPage = 1
	self._maxShowPrize = 4
	self._showIndex = 1
	self._activityId = self:getFirstParam() or StarScratchModel.instance:getCurrActId()
	self._needRefreshImg = {}

	for i = 1, self._scratchCount do
		self._needRefreshImg[i] = true
	end

	self._actCfg = StarScratchConfig.instance:getActivityCfg(self._activityId)

	StarScratchAgent.instance:sendPM_StarScratchInfoReq(self._activityId)

	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.StarScratch, self._activityId)

	for i = 1, self._scratchCount do
		self._scratchList[i].effect = UIEffectManager.instance:playEffect(self, "20240430/xingyunge/fx_ui_xyg_anniu.prefab", nil, 0, 0, true)

		self._scratchList[i].effect:setParent(self._scratchList[i].effectGo.transform)
		self._scratchList[i].effect:setScaleXYZ(1.4, 3.4, 1)
		self._scratchList[i].effect:setLocalPos(0, 0, 0)
	end

	self._bgEffect = UIEffectManager.instance:playEffect(self, "20240430/xingyunge/fx_ui_xyg_fw.prefab", nil, 0, 0, true)

	self._bgEffect:setParent(self._effectGo.transform)
	self._bgEffect:setScale(1)
	self._bgEffect:setLocalPos(0, 0, 0)
	RedPointController.instance:regRedPoint(self._redPointGain, RedPointModel.ID_STARSCRATCH_TASK)
end

function StarScratchMainView:_initData()
	local cycleCfgs = StarScratchConfig.instance:getCycleCfgs(self._activityId)

	self._curCycleId = 1

	for i, v in ipairs(cycleCfgs) do
		if GameUtil.checkIsInTimePeriod(v.openDateTime, v.endDateTime) == true then
			self._curCycleId = v.cycleId

			break
		end
	end

	self._scratchInfo = StarScratchModel.instance:getCycleInfo(self._activityId, self._curCycleId)

	local curPosId = 1

	if self._scratchInfo then
		curPosId = #self._scratchInfo.scratchs + 1

		for i, v in ipairs(self._scratchInfo.scratchs) do
			if not v.hadGained then
				curPosId = v.id

				break
			end
		end
	end

	self._cycleCfg = StarScratchConfig.instance:getCycleCfg(self._activityId, self._curCycleId)

	if curPosId > self._cycleCfg.timesLimit then
		curPosId = self._cycleCfg.timesLimit
	end

	self._curPage = math.ceil(curPosId / self._scratchCount)
end

function StarScratchMainView:_refreshView()
	self._timeTableList:reloadData(StarScratchConfig.instance:getCycleCfgs(self._activityId))

	self._maxPage = math.ceil(self._cycleCfg.timesLimit / self._scratchCount)

	self:_refreshScratchView()
	self:_refreshLuckTableView()
	self:_refreshShowTableView()
	removetimer(self._changeShowPrize, self)

	if #self._bigPrizeCfg > self._maxShowPrize then
		settimer(12, self._changeShowPrize, self, true)
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.cost)

	MaterialMgr.resetAll(self._itemCon)
	MaterialMgr.setIcon(self._itemCon, matType, matId)

	self._txtNum.text = langPara("x%d", MaterialModel.instance:getMaterialsNumber(matType, matId))

	removetimer(self._getLuckInfo, self)
	settimer(5, self._getLuckInfo, self, true)
end

function StarScratchMainView:_refreshScratchView()
	self._isScratching = false
	self._scratchInfo = StarScratchModel.instance:getCycleInfo(self._activityId, self._curCycleId)

	if self._scratchInfo and self._scratchInfo.scratchs then
		for i, v in pairs(self._scratchInfo.scratchs) do
			if not v.hadGained then
				self._isScratching = true
			end
		end
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.cost)
	local isEnough = MaterialModel.instance:IsEnough(matType, matId, matNum)

	if self._scratchInfo then
		if not (#self._scratchInfo.scratchs + 1) then
			local targetPos = 1

			for index = 1, self._scratchCount do
				local scratchUIGroup = self._scratchList[index]
				local posId = (self._curPage - 1) * self._scratchCount + index

				GameUtil.SetActive(scratchUIGroup.go, posId <= self._cycleCfg.timesLimit)

				if self._scratchInfo and self._scratchInfo.scratchs[posId] then
					if not self._scratchInfo.scratchs[posId].hadGained then
						local isGainPrize = false
						local isCanGainPrize = posId == targetPos and isEnough or false
						local isStartScratch = self._scratchInfo and self._scratchInfo.scratchs[posId] and not self._scratchInfo.scratchs[posId].hadGained or false

						if isStartScratch == true then
							self._isScratching = true
						end

						GameUtil.SetActive(scratchUIGroup.imgCover, not isStartScratch and not isGainPrize)
						GameUtil.SetActive(scratchUIGroup.imgScatch, isStartScratch)
						GameUtil.SetActive(scratchUIGroup.effectGo, isStartScratch)
						GameUtil.SetActive(scratchUIGroup.txtTip, isStartScratch and not isGainPrize)
						GameUtil.SetActive(scratchUIGroup.btnStart, isCanGainPrize and not isStartScratch and not isGainPrize)

						scratchUIGroup.txtTip.text = lang("可刮开")

						if isStartScratch or isGainPrize then
							if not self._scratchInfo.scratchs[posId].prizeId then
								local prizeId = 1
								local prizeCfg = StarScratchConfig.instance:getPrizeCfg(self._activityId, self._curCycleId, prizeId)
								local prizeArr = string.split(prizeCfg.prize, "#")
								local list = {}

								for j, v in ipairs(prizeArr) do
									table.insert(list, {
										prize = v,
										isBigPrize = prizeCfg.isBigPrize
									})
								end

								scratchUIGroup.prize:updateWithMoArray(list, self._updatePrizeCell, self)

								if self._needRefreshImg[index] == true then
									if not self._scratchTex then
										local width = GameUtil.getWidth(scratchUIGroup.rawImgScatch)
										local heigh = GameUtil.getHeight(scratchUIGroup.rawImgScatch)

										self._scratchTex = UnityEngine.Texture2D.New(width, heigh)

										local col = Color.New(0.7411764705882353, 0.7137254901960784, 0.7098039215686275, 1)

										for i = 0, width - 1 do
											for j = 0, heigh - 1 do
												self._scratchTex:SetPixel(i, j, col)
											end
										end

										self._scratchTex:Apply()
									end

									scratchUIGroup.scratch:drawTexOnImg(scratchUIGroup.rawImgScatch, self._scratchTex)

									self._needRefreshImg[index] = false
								end
							end
						end
					end
				end
			end

			GameUtil.SetActive(self._btnPrePage, self._curPage > 1)
			GameUtil.SetActive(self._btnNextPage, self._curPage < self._maxPage)
			GameUtil.SetActive(self._redPointPre, targetPos < (self._curPage - 1) * self._scratchCount + 1 and isEnough)
			GameUtil.SetActive(self._redPointNext, targetPos > self._curPage * self._scratchCount and isEnough and targetPos <= self._cycleCfg.timesLimit)

			local scratchTime = 0
			local hadGainBigPrize = false

			for i, v in pairs(self._scratchInfo.scratchs) do
				local prizeCfg = StarScratchConfig.instance:getPrizeCfg(self._activityId, self._curCycleId, v.prizeId)

				if v.hadGained == true then
					scratchTime = scratchTime + 1

					if prizeCfg.isBigPrize == true then
						hadGainBigPrize = true
					end
				end
			end

			GameUtil.SetActive(self._imgBigGain, hadGainBigPrize)

			self._txtDesc.text = not hadGainBigPrize and langPara("累计刮卡<color=#ED413AFF>%d</color>次必得，当前已刮<color=#ED413AFF>%d</color>次", self._cycleCfg.bigPrizeGuaranteed, scratchTime) or lang("本期已成功获得大奖！")
		end
	end
end

function StarScratchMainView:_refreshShowTableView()
	self._bigPrizeCfg = StarScratchConfig.instance:getPrizeCfgs(self._activityId, self._curCycleId)

	local list

	if #self._bigPrizeCfg > self._maxShowPrize then
		list = {}

		for i = 1, self._maxShowPrize do
			local index = (self._showIndex + i) % #self._bigPrizeCfg

			if index == 0 then
				index = #self._bigPrizeCfg
			end

			table.insert(list, self._bigPrizeCfg[index])

			self._showIndex = self._showIndex + 1

			if self._showIndex > #self._bigPrizeCfg then
				self._showIndex = 1
			end
		end
	else
		list = self._bigPrizeCfg
	end

	self._prizeShowList:updateWithMoArray(list, self._updateShowCell, self)
end

function StarScratchMainView:_changeShowPrize()
	local list = {}
	local count = math.min(self._maxShowPrize, #self._bigPrizeCfg)

	for i = 1, count do
		table.insert(list, i)
	end

	self._prizeShowList:updateWithMoArray(list, self._updateFadeOutCell, self)
	settimer(1, self._refreshShowTableView, self, false)
	settimer(1.2, self._showPrize, self, false)
end

function StarScratchMainView:_showPrize()
	local list = {}
	local count = math.min(self._maxShowPrize, #self._bigPrizeCfg)

	for i = 1, count do
		table.insert(list, i)
	end

	self._prizeShowList:updateWithMoArray(list, self._updateFadeInCell, self)
end

function StarScratchMainView:_refreshLuckTableView()
	local luckList = StarScratchModel.instance:getBroadcastInfo(self._activityId)

	GameUtil.SetActive(self._luckEmptyGo, #luckList <= 0)
	self._luckTableList:reloadData(luckList)
end

function StarScratchMainView:_getLuckInfo()
	StarScratchAgent.instance:sendPM_StarScratchRefreshBroadcastReq(self._activityId)
end

function StarScratchMainView:_updateTimeCell(view, cell, data, tag)
	local go = cell.gameObject
	local infoGo = goutil.findChild(go, "info")
	local txtName = goutil.findChildTextComponent(go, "info/txtName")
	local txtTime = goutil.findChildTextComponent(go, "info/txtTime")
	local activeGo = goutil.findChild(go, "info/label")

	GameUtil.SetGray(infoGo, self._curCycleId ~= data.cycleId)
	GameUtil.SetActive(activeGo, self._curCycleId == data.cycleId)

	local startDate, endDate = GameUtil.string2date(data.openDateTime), GameUtil.string2date(data.endDateTime)

	txtTime.text = langPara("%d.%d %d:%02d - %d.%d %d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	txtName.text = data.name
end

function StarScratchMainView:_clearTimeCell(cell)
	return
end

function StarScratchMainView:_updateLuckCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(go, "txt")
	local prizeCfg = StarScratchConfig.instance:getPrizeCfg(self._activityId, data.cycleId, data.prizeId)

	if not prizeCfg then
		return
	end

	local prizeArr = string.split(prizeCfg.prize, "#")
	local matType, matId, matNum = MaterialMgr.getMatParams(prizeArr[1])
	local matName = MaterialMgr.getMaterialsName(matType, matId)

	txtDesc.text = langPara("%s-%s\n成功刮出 <color=#ED413AFF>【%sx%d】</color> ", data.areaName, data.name, matName, matNum)

	GameUtil.addClickHandler(go, function()
		self:_onClickLuck(data.userId, go)
	end)
end

function StarScratchMainView:_clearLuckCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function StarScratchMainView:_updateShowCell(cell, data, i)
	local go = cell.mainGO
	local icon = goutil.findChild(go, "icon")
	local txtNum = goutil.findChildTextComponent(go, "txt")
	local matType, matId, matNum = MaterialMgr.getMatParams(data.prize)

	MaterialMgr.resetAll(icon)

	local proxy = MaterialMgr.setCellByCfg(data.prize, icon)

	if proxy then
		proxy.binder:setNum(matNum)
	end
end

function StarScratchMainView:_clearShowCell(cell)
	local go = cell.mainGO
	local icon = goutil.findChild(go, "con")

	MaterialMgr.resetAll(icon)
end

function StarScratchMainView:_updateFadeOutCell(cell, data, i)
	local go = cell.mainGO

	UnityTweens.UITweenFadeOut.StartTween(go, 0.8)
end

function StarScratchMainView:_updateFadeInCell(cell, data, i)
	local go = cell.mainGO

	UnityTweens.UITweenFadeIn.StartTween(go, 0.8)
end

function StarScratchMainView:_updatePrizeCell(cell, data, i)
	local go = cell.mainGO
	local icon = goutil.findChild(go, "con")
	local tag = goutil.findChild(go, "tag")
	local txtTag = goutil.findChildTextComponent(tag, "Text")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")

	MaterialMgr.resetAll(icon)

	local proxy = MaterialMgr.setCellByCfg(data.prize, icon)
	local matType, matId, matNum = MaterialMgr.getMatParams(data.prize)

	if proxy then
		proxy.binder:setEffStatus(false)
		proxy.binder:setNum(matNum)
		proxy.binder:setAutoTips(true)
	end

	txtTag.text = self._actCfg.bigPirzeTag

	GameUtil.SetActive(tag, data.isBigPrize)
end

function StarScratchMainView:_clearPrizeCell(cell)
	local go = cell.mainGO
	local icon = goutil.findChild(go, "con")

	MaterialMgr.resetAll(icon)
end

function StarScratchMainView:_onClickLuck(userId, go)
	FriendController.instance:showInfoView(userId, go)
end

function StarScratchMainView:_onClickClose()
	if self._isScratching == true then
		FloatWordMgr.instance:show(lang("还有未刮开的奖励"))

		return
	end

	self:close()
end

function StarScratchMainView:_onClickTip()
	TipsFacade.instance:openRulesView("star_scratch_rule")
end

function StarScratchMainView:_onClickPre()
	self._curPage = self._curPage - 1

	if self._curPage <= 0 then
		self._curPage = 1
	end

	self:_refreshScratchView()
end

function StarScratchMainView:_onClickNext()
	self._curPage = self._curPage + 1

	if self._curPage > self._maxPage then
		self._curPage = self._maxPage
	end

	self:_refreshScratchView()
end

function StarScratchMainView:_onClickGain()
	UIStateManager.instance:push(ViewName.StarScratchTaskView, self._activityId)
end

function StarScratchMainView:_onClickStart(index)
	StarScratchController.instance:sendPM_StarScratchBuyReq(self._activityId, self._curCycleId)
end

function StarScratchMainView:_onScratchPointDown(index)
	GameUtil.SetActive(self._scratchList[index].txtTip, false)
end

function StarScratchMainView:_onScratchPointUp(index)
	self._needRefreshImg[index] = true

	GameUtil.SetActive(self._scratchList[index].imgScatch, false)

	local posId = (self._curPage - 1) * self._scratchCount + index

	StarScratchAgent.instance:sendPM_StarScratchGainReq(self._activityId, self._curCycleId, posId)
end

function StarScratchMainView:_PM_StarScratchInfoRes()
	self:_initData()
	self:_refreshView()
end

return StarScratchMainView
