-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearscratch/view/YearScratchMainView.lua

module("logic.extensions.yearscratch.view.YearScratchMainView", package.seeall)

local YearScratchMainView = class("YearScratchMainView", ViewComponent)

function YearScratchMainView:ctor()
	YearScratchMainView.super.ctor(self)
end

function YearScratchMainView:unbindEvents()
	YearScratchMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnDiamond)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnJump)
end

function YearScratchMainView:bindEvents()
	YearScratchMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnDiamond, self._onClickDiamond, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnJump, self._onClickJump, self)
end

function YearScratchMainView:buildUI()
	YearScratchMainView.super.buildUI(self)

	self._effectGo = self:getGo("effectGo")
	self._imgScatch = self:getGo("scratchArea/imgScatch")
	self._rawImgScatch = self._imgScatch:GetComponent(ComponentType.RawImage)
	self._pointDown = PointerDownHandler.Get(self._imgScatch)
	self._pointUp = PointerUpHandler.Get(self._imgScatch)
	self._imgCover = self:getGo("scratchArea/imgCover")
	self._scatchTip = self:getGo("scratchArea/tip")
	self._scatchImgTip = self:getGo("scratchArea/imgTip")
	self._txtScatchTip = self:getTxt("scratchArea/tip/txt")
	self._successTip = self:getGo("scratchArea/successTip")
	self._failTip = self:getGo("scratchArea/failTip")
	self._imgGainGo = self:getGo("imgGain")
	self._scratchEffectGo = self:getGo("scratchArea/scratchEffectGo")
	self._prize = self:getGo("scratchArea/prize")
	self._prizeCell = self:getGo("scratchArea/prize/prizeCell")
	self._prizeGroup = ItemGroup.New(self._prize, self._prizeCell)
	self._recordPrize = self._prize:GetComponent("TestRecordPos")
	self._tableview = self:getGo("tableview")
	self._tableCell = self:getGo("tableCell")
	self._txtScratch = self:getTxt("diamondGain/txtScratch")
	self._txtGainNum = self:getTxt("diamondGain/txtGainNum")
	self._txtGainName = self:getTxt("diamondGain/txtGainNum/txtName")
	self._btnDiamond = self:getGo("diamondGain/btnDiamond")
	self._txtDiamondComplete = self:getTxt("task/diamondTask/txtComplete")
	self._txtDiamondTime = self:getTxt("task/diamondTask/txtTime")
	self._txtDiamondCount = self:getTxt("task/diamondTask/txtCount")
	self._txtWeekComplete = self:getTxt("task/weekTask/txtComplete")
	self._txtWeekTask1 = self:getTxt("task/weekTask/txtTask1")
	self._txtWeekTask2 = self:getTxt("task/weekTask/txtTask2")
	self._txtWeekCount1 = self:getTxt("task/weekTask/txtCount1")
	self._txtWeekCount2 = self:getTxt("task/weekTask/txtCount2")
	self._bigPrize = self:getGo("scratchArea/bigPrize")
	self._bigPrizeGoList = {}

	for i = 1, self._bigPrize.transform.childCount do
		table.insert(self._bigPrizeGoList, self:getGo("scratchArea/bigPrize/prize" .. i))
	end

	self._tableList = ScrollerList.create(self._tableview, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("leftTop/btnRule")
	self._btnPrize = self:getGo("btnPrize")
	self._btnJump = self:getGo("btnJump")
end

function YearScratchMainView:onExit()
	YearScratchMainView.super.onExit(self)
	self._scratch:dispose()
	self._tableList:dispose()
	self._prizeGroup:dispose(self._clearPrizeCell, self)

	for i, v in ipairs(self._bigPrizeGoList) do
		self:_clearBigPrize(v)
	end

	UIEffectManager.instance:stopEffect(self._mainEffect)
	UIEffectManager.instance:stopEffect(self._prizeEffect)
end

function YearScratchMainView:onEnter()
	YearScratchMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.YearScratchRefresh, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.YearScratchGainPrize, self._refreshView, self)

	local param = self:getFirstParam()

	self._activityId = param and param or YearScratchModel.instance:getCurrActId()

	if not self._activityId then
		FloatWordMgr.instance:show(lang("活动未开启"))
		self:close()

		return
	end

	self._actCfg = YearScratchConfig.instance:getActivityCfg(self._activityId)
	self._scratch = ScratchOffComponent.New()

	self._scratch:regDragHandler(GameUtil.handler(self._onScratchPointDown, self), nil, GameUtil.handler(self._onScratchPointUp, self))

	self._firstEnter = true

	YearScratchAgent.instance:sendPM_YearScratchInfoReq(self._activityId)

	local path = "20240403/zhounianguaguale/fx_ui_znggl_fw.prefab"

	self._mainEffect = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true)

	self._mainEffect:setParent(self._effectGo.transform)
	self._mainEffect:setLocalPos(0, 0, 0)
	self._mainEffect:setScale(1)
end

function YearScratchMainView:_initData()
	local isNotEnterPrize = not YearScratchModel.instance:getEnterPrize(self._activityId)
	local isOpenGainPrize = ServerTime.now() >= GameUtil.string2time(self._actCfg.gainGodGemTime)

	if isNotEnterPrize and isOpenGainPrize and YearScratchModel.instance:isGainPrize() == true then
		self:_onClickDiamond()
		YearScratchModel.instance:saveEnterPrize(self._activityId)
	end

	local cycleCfgs = YearScratchConfig.instance:getCycleCfgs(self._activityId)
	local isHaveNotScratch = false

	for i = 1, #cycleCfgs do
		local cycleInfo = YearScratchModel.instance:getCycleInfo(i)

		if cycleInfo and checknumber(cycleInfo.prizeId) > 0 and not cycleInfo.hadGainPrize then
			self._tabId = i
			isHaveNotScratch = true

			break
		end
	end

	if isHaveNotScratch == true then
		self._tabId = self._tabId
	elseif not isOpenGainPrize then
		self._tabId = 1

		for i = 1, #cycleCfgs do
			if ServerTime.now() >= GameUtil.string2time(cycleCfgs[i].startTime) then
				self._tabId = i
			end
		end
	else
		self._tabId = #cycleCfgs + 1
	end

	self._firstEnter = false
	self._needRefreshImg = true
end

function YearScratchMainView:_refreshView()
	if self._firstEnter == true then
		self:_initData()
	end

	self:_refreshTabList()

	local cycleInfo = YearScratchModel.instance:getCycleInfo(self._tabId)
	local cycleCfg = YearScratchConfig.instance:getCycleCfg(self._activityId, self._tabId)
	local isOpen = cycleCfg and ServerTime.now() >= GameUtil.string2time(cycleCfg.scratchTime) or false
	local isCanScratch = cycleInfo and checknumber(cycleInfo.prizeId) > 0 or false

	if cycleInfo then
		if not cycleInfo.hadGainPrize then
			local isScratch = false

			GameUtil.SetActive(self._imgScatch, isOpen and isCanScratch and not isScratch)
			GameUtil.SetActive(self._imgCover, (not isOpen or not isCanScratch) and not isScratch)
			GameUtil.SetActive(self._bigPrize, not isOpen)
			GameUtil.SetActive(self._scatchTip, not isScratch)
			GameUtil.SetActive(self._successTip, not isScratch and isOpen and isCanScratch)
			GameUtil.SetActive(self._failTip, not isScratch and isOpen and not isCanScratch)
			GameUtil.SetActive(self._imgGainGo, isScratch)

			if not cycleInfo then
				self._txtScatchTip.text = lang("神钻领取活动已开启，赶紧领取神钻吧")

				GameUtil.SetActive(self._scatchTip, true)
			elseif not isOpen then
				local startDate = GameUtil.string2date(cycleCfg.scratchTime)

				self._txtScatchTip.text = langPara("%d月%d日%d：%02d后开启刮卡", startDate.month, startDate.day, startDate.hour, startDate.min)
			else
				self._txtScatchTip.text = not isCanScratch and lang("很遗憾，本期未参与刮奖TAT") or lang("快来刮出大奖吧~！")
			end

			local gainGodGemStartDate = GameUtil.string2date(self._actCfg.gainGodGemTime)

			self._txtDiamondTime.text = langPara("<color=#96694EFF>即可在</color>%d月%d日领取神钻", gainGodGemStartDate.month, gainGodGemStartDate.day)
			self._txtDiamondCount.text = langPara("(<color=#37AE5CFF>%d</color>/1)", YearScratchModel.instance:isGainPrize() == true and 1 or 0)

			if cycleInfo and cycleCfg then
				self._txtWeekTask1.text = langPara("累计登录%d天", cycleCfg.loginDays)
				self._txtWeekTask2.text = lang("热血同行活动中满足个人进度")
				self._txtWeekCount1.text = langPara("(<color=#37AE5CFF>%d</color>/%d)", math.min(cycleInfo.loginDays, cycleCfg.loginDays), cycleCfg.loginDays)
				self._txtWeekCount2.text = langPara("(<color=#37AE5CFF>%d</color>/%d)", math.min(math.max(cycleInfo.progress, 0), cycleCfg.needProgress), cycleCfg.needProgress)
			else
				self._txtWeekTask1.text = lang("当前无任务")
				self._txtWeekTask2.text = ""
				self._txtWeekCount1.text = ""
				self._txtWeekCount2.text = ""
			end

			self._txtDiamondComplete.text = YearScratchModel.instance:isGainPrize() == true and lang("已达成") or lang("未达成")
			self._txtWeekComplete.text = cycleCfg and cycleInfo.loginDays >= cycleCfg.loginDays and cycleInfo.progress >= cycleCfg.needProgress and lang("已达成") or not cycleCfg and lang("未达成") or lang("未达成")

			local bigPrize = YearScratchConfig.instance:getBigPrize(self._activityId, self._tabId)

			if bigPrize then
				local bigPrizeList = {}

				for i, v in ipairs(bigPrize) do
					local strArr = string.split(v, "#")

					for j, str in ipairs(strArr) do
						table.insert(bigPrizeList, str)
					end
				end

				for i, v in ipairs(self._bigPrizeGoList) do
					self:_clearBigPrize(v)
					GameUtil.SetActive(v, false)

					if bigPrizeList[i] then
						GameUtil.SetActive(v, true)
						self:_updateBigPrize(v, bigPrizeList[i])
					end
				end
			else
				for i, v in ipairs(self._bigPrizeGoList) do
					self:_clearBigPrize(v)
					GameUtil.SetActive(v, false)
				end
			end

			if self._needRefreshImg == true then
				local width = GameUtil.getWidth(self._rawImgScatch)
				local heigh = GameUtil.getHeight(self._rawImgScatch)
				local tex = UnityEngine.Texture2D.New(width, heigh)
				local col = Color.New(0.7411764705882353, 0.7137254901960784, 0.7098039215686275, 1)

				for i = 0, width - 1 do
					for j = 0, heigh - 1 do
						tex:SetPixel(i, j, col)
					end
				end

				tex:Apply()
				self._scratch:drawTexOnImg(self._rawImgScatch, tex)

				self._needRefreshImg = false
			end

			local list = {}

			if isCanScratch then
				local prizeCfg = YearScratchConfig.instance:getPrize(self._activityId, self._tabId, cycleInfo.prizeId)
				local prizeArr = string.split(prizeCfg.prize, "#")

				for i, v in ipairs(prizeArr) do
					table.insert(list, v)
				end
			end

			self._prizeGroup:updateWithMoArray(list, self._updatePrizeCell, self)

			if #list > 0 then
				self._recordPrize:LoadPlan(#list - 1)
			end

			self._txtScratch.text = langPara("%d", YearScratchModel.instance:getSpaceScratchNum())

			local godGemCfg = YearScratchConfig.instance:getGodGemCfg(self._activityId)
			local index = 1

			for i = 1, #godGemCfg do
				if YearScratchModel.instance:getSpaceScratchNum() >= godGemCfg[i].section[1] then
					index = i
				end
			end

			local matType, matId, matNum = MaterialMgr.getMatParams(godGemCfg[index].prize)

			self._txtGainNum.text = YearScratchModel.instance:getSpaceScratchNum() > 0 and langPara("%d", matNum) or lang("???")
			self._txtGainName.text = langPara("%s", MaterialMgr.getMaterialsName(matType, matId))
		end
	end
end

function YearScratchMainView:_refreshTabList()
	local tabList = {}
	local cycleCfgs = YearScratchConfig.instance:getCycleCfgs(self._activityId)

	for i, v in ipairs(cycleCfgs) do
		table.insert(tabList, {
			isGainGodGem = false,
			id = v.cycleId,
			cfg = v
		})
	end

	table.insert(tabList, {
		isGainGodGem = true,
		id = #cycleCfgs + 1,
		time = self._actCfg.gainGodGemTime
	})
	self._tableList:reloadData(tabList)
end

function YearScratchMainView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local redPointStatus = goutil.findChild(go, "redpoint")
	local infoGo = goutil.findChild(go, "info")
	local label = goutil.findChild(infoGo, "label")
	local txtStatus = goutil.findChildTextComponent(infoGo, "label/txt")
	local txtTime = goutil.findChildTextComponent(infoGo, "txtTime")
	local txtName = goutil.findChildTextComponent(infoGo, "txtName")
	local btn = goutil.findChild(infoGo, "btn")

	GameUtil.SetActive(label, not data.isGainGodGem)
	GameUtil.SetActive(redPointStatus, false)
	GameUtil.SetGray(infoGo, true)

	if data.isGainGodGem == true then
		GameUtil.SetGray(infoGo, not (ServerTime.now() >= GameUtil.string2time(data.time)))

		local startDate = GameUtil.string2date(data.time)

		txtTime.text = langPara("%d.%d %d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min)
		txtName.text = lang("领 取 神 钻")
	else
		GameUtil.SetGray(infoGo, not GameUtil.checkIsInTimePeriod(data.cfg.startTime, data.cfg.endTime))

		local startDate = GameUtil.string2date(data.cfg.startTime)
		local endDate = GameUtil.string2date(data.cfg.endTime)

		txtTime.text = langPara("%d.%d %d:%02d - %d.%d %d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)

		local info = YearScratchModel.instance:getCycleInfo(data.id)

		if info and checknumber(info.prizeId) > 0 then
			txtStatus.text = lang("已参与")

			GameUtil.SetActive(redPointStatus, not info.hadGainPrize and ServerTime.now() >= GameUtil.string2time(data.cfg.scratchTime))
		else
			txtStatus.text = lang("未参与")
		end

		txtName.text = lang("刮 刮 乐 活 动")
	end

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickTab(data.id)
	end, self)
end

function YearScratchMainView:_clearCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function YearScratchMainView:_updatePrizeCell(cell, data, index)
	local go = cell.mainGO
	local con = goutil.findChild(go, "con")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local matType, matId, matNum = MaterialMgr.getMatParams(data)

	MaterialMgr.resetAll(con)

	if matType == MatType.Pet or matType == MatType.PET_SKIN then
		local proxy = MaterialMgr.setCellByCfg(data, con)

		if proxy then
			proxy.binder:setEffStatus(false)
		end
	else
		MaterialMgr.setIcon(con, matType, matId)
	end

	GameUtil.addClickHandler(go, function()
		CommonTipsMgr.instance:openTipsByConfStr(go, data)
	end, self)

	txtNum.text = string.format("X%d", matNum)
end

function YearScratchMainView:_clearPrizeCell(cell)
	local go = cell.mainGO
	local con = goutil.findChild(go, "con")

	GameUtil.rmClickHandler(go)
	MaterialMgr.resetAll(con)
end

function YearScratchMainView:_updateBigPrize(go, str)
	local con = goutil.findChild(go, "con")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local matType, matId, matNum = MaterialMgr.getMatParams(str)

	if matType == MatType.Pet or matType == MatType.PET_SKIN then
		MaterialMgr.setCellByCfg(str, con)
	else
		MaterialMgr.setIcon(con, matType, matId)
	end

	txtNum.text = langPara("X%d", matNum)

	GameUtil.addClickHandler(go, function()
		CommonTipsMgr.instance:openTipsByConfStr(go, str)
	end)
end

function YearScratchMainView:_clearBigPrize(go)
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(go)
end

function YearScratchMainView:_onClickTab(tabId)
	local cycleCfgs = YearScratchConfig.instance:getCycleCfgs(self._activityId)

	if tabId <= #cycleCfgs then
		local cfg = cycleCfgs[tabId]

		if ServerTime.now() >= GameUtil.string2time(cfg.startTime) then
			self._tabId = tabId

			self:_refreshView()
		else
			FloatWordMgr.instance:show(lang("活动未开启"))
		end
	elseif ServerTime.now() >= GameUtil.string2time(self._actCfg.gainGodGemTime) then
		self._tabId = tabId

		self:_refreshView()
	else
		FloatWordMgr.instance:show(lang("活动未开启"))
	end
end

function YearScratchMainView:_onClickDiamond()
	UIStateManager.instance:push(ViewName.YearScratchPrizeView, self._activityId)
end

function YearScratchMainView:_onClickRule()
	TipsFacade.instance:openRulesView("year_scratch_main_view")
end

function YearScratchMainView:_onClickPrize()
	TipsFacade.instance:openRulesView("year_scratch_main_view")
end

function YearScratchMainView:_onClickJump()
	GotoMgr.gotoByString("func#1047")
end

function YearScratchMainView:_onScratchPointDown()
	self._isScratch = true
	self._needRefreshImg = true

	GameUtil.SetActive(self._scatchTip, false)
	GameUtil.SetActive(self._scatchImgTip, false)
	GameUtil.SetActive(self._successTip, false)
end

function YearScratchMainView:_onScratchPointUp()
	local path = "20240403/zhounianguaguale/fx_ui_znggl_huode.prefab"

	self._prizeEffect = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, false, nil, function()
		YearScratchController.instance:showSaveChangeSet()
	end)

	self._prizeEffect:setParent(self._scratchEffectGo.transform)
	self._prizeEffect:setLocalPos(0, 0, 0)
	self._prizeEffect:setScale(1)
	YearScratchAgent.instance:sendPM_YearScratchGainPrizeReq(self._activityId, self._tabId)
end

return YearScratchMainView
