-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenvsjiu/view/JieshenvsjiuView.lua

module("logic.extensions.jieshenvsjiu.view.JieshenvsjiuView", package.seeall)

local JieshenvsjiuView = class("JieshenvsjiuView", ViewComponent)

function JieshenvsjiuView:ctor()
	JieshenvsjiuView.super.ctor(self)
end

function JieshenvsjiuView:buildUI()
	JieshenvsjiuView.super.buildUI(self)

	self._goBg = self:getGo("bg")
	self._goBgEffect = self:getGo("bgEffect")
	self._goRoot = self:getGo("root")
	self._txtTime = self:getTxt("root/actTime/txt")
	self._unChooseTeam = self:getGo("root/unChooseTeam")
	self._btnClose = self:getBtn("root/leftTop/btnClose")
	self._btnTip = self:getBtn("root/btnTip")
	self._btnSupportT1 = self:getBtn("root/btnSupportT1")
	self._btnSupportT2 = self:getBtn("root/btnSupportT2")
	self._goMyTeam = self:getGo("root/myTeam")
	self._btnStartGame = self:getBtn("root/btnStartGame")
	self._btnStartGameRp = goutil.findChild(self._btnStartGame, "redpoint")
	self._txtTodayGameTime = self:getTxt("root/btnStartGame/txtTodayGameTime")
	self._sliderPercentPair = self:getSlider("root/percentPairSlider")
	self._txtLeftTeamPercent = self:getTxt("root/percentPairSlider/myTeamPercentText")
	self._txtRightTeamPercent = self:getTxt("root/percentPairSlider/otherTeamPercentText")
	self._txtScore = self:getTxt("root/tableview/score")
	self._goCell = self:getGo("cell")
	self._goTableview = self:getGo("root/tableview")
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._cellRectTrans = goutil.findChild(self._goTableview, "viewport"):GetComponent(goutil.Type_RectTransform)

	local worldPrizeRoot = self:getGo("root/worldPrizeRoot")

	self._uiMask = goutil.findChild(worldPrizeRoot, "uiMask"):GetComponent(goutil.Type_RectTransform)
	self._goWorldCell = self:getGo("worldCell")
	self._goWorldTableview = self:getGo("root/worldPrizeRoot/worldTableview")
	self._worldTableview = ScrollerList.create(self._goWorldTableview, self._goWorldCell, GameUtil.handler(self._updateWorldCell, self), GameUtil.handler(self._clearWorldCell, self))
	self._btnWorldTableview = self:getBtn("root/worldPrizeRoot/worldTableview/btn")
	self._worldArrow = goutil.findChild(self._btnWorldTableview, "arrow")
	self._txtWorldProgress = self:getTxt("root/worldPrizeRoot/worldTableview/progress/txt")
	self._WorldTableviewRectTrans = self._goWorldTableview:GetComponent(goutil.Type_RectTransform)
	self._worldCellRectTrans = goutil.findChild(self._goWorldTableview, "viewport"):GetComponent(goutil.Type_RectTransform)
end

function JieshenvsjiuView:bindEvents()
	JieshenvsjiuView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnStartGame, self._onClickStartGame, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnWorldTableview, self._onClickWorldTableView, self)
	GameUtil.addClickHandler(self._btnSupportT1, function()
		self:_onClickSupport(1)
	end)
	GameUtil.addClickHandler(self._btnSupportT2, function()
		self:_onClickSupport(2)
	end)
end

function JieshenvsjiuView:onExit()
	JieshenvsjiuView.super.onExit(self)
	removetimer(self._onRefreshPerFourMin, self)
	removetimer(function()
		self._goRoot:SetActive(true)
	end, self)

	self._isOpenWorldRoot = false

	GameUtil.setAnchoredPos(self._WorldTableviewRectTrans, 40, -258)
	GameUtil.setLocalRotation(self._worldArrow, 0, 0, 0)
	self._tableview:dispose()
	self._worldTableview:dispose()
end

function JieshenvsjiuView:unbindEvents()
	JieshenvsjiuView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSupportT1)
	GameUtil.rmClickHandler(self._btnSupportT2)
	GameUtil.rmClickHandler(self._btnStartGame)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnWorldTableview)
end

function JieshenvsjiuView:onEnter()
	JieshenvsjiuView.super.onEnter(self)
	settimer(240, self._onRefreshPerFourMin, self)
	self.addGEvent(self, GlobalNotify.JieShenVsJiuGetInfoRes, self._onGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.JieShenVsJiuGainPrizeRes, self._onGetGainPrizeRes, self)
	self.addGEvent(self, GlobalNotify.JieShenVsJiuChooseTeamRes, self._onGetChooseTeamRes, self)
	self.addGEvent(self, GlobalNotify.JieShenVsJiuStartGameRes, self._onGetStartGameRes, self)
	self.addGEvent(self, GlobalNotify.JieShenVsJiuEndGameRes, self._onGetEndGameRes, self)
	self.addGEvent(self, GlobalNotify.JieShenVsJiuGainWorldProgressPrizeRes, self._onGetWorldProgressGainPrize, self)
	self:_initActivityId()

	if not self:_initActivityId() then
		FloatWordMgr.instance:show("活动未开启")
		self:close()

		return
	end

	self._worldActId = 262005

	self:reloadViewByCfg()
	self:_loadBgEffect()

	local startTimeStemp, endTimeStemp = ActivityDefineController:getStartTimeAndEndTime(GameEnum.ActivityType.JieShenVsJiu, self._activityId)
	local startTime = GameUtil.time2date(startTimeStemp)
	local endTime = GameUtil.time2date(endTimeStemp)

	self._txtTime.text = langPara("活动时间：%d.%d %d:%02d -%d.%d %d:%02d", startTime.month, startTime.day, startTime.hour, startTime.min, endTime.month, endTime.day, endTime.hour, endTime.min)
	self._isOpenWorldRoot = false
	self._cellMap = {}
	self._worldCellMap = {}

	JieShenVsJiuAgent.instance:sendPM_JieShenVsJiuGetInfoReq(self._activityId)
end

function JieshenvsjiuView:_loadBgEffect()
	self:_removeBgEffect()

	local key = "jieshenvsjiu_bg_effect"
	local wasPlayed = GameUtil.getUserData(key) or false

	self._goBg:SetActive(wasPlayed)
	self._goRoot:SetActive(wasPlayed)

	if not wasPlayed then
		self._goBgEffect:SetActive(true)
		settimer(0.8, function()
			self._goRoot:SetActive(true)
		end, self, false)

		local bgUIEffect = UIEffectManager.instance:playEffect(self, JieshenvsjiuViewPresentor.MainViewBgPath, self._goBgEffect.transform, 0, 0, true, false)

		bgUIEffect:setParent(self._goBgEffect.transform)
		bgUIEffect:setScale(1)
		bgUIEffect:setLocalPos(0, 0, 0)
		bgUIEffect:setSortingOrder(190)

		self._bgUIEffect = bgUIEffect
		wasPlayed = true
	end

	GameUtil.saveUserData(key, wasPlayed)
end

function JieshenvsjiuView:_removeBgEffect()
	if self._bgUIEffect then
		UIEffectManager.instance:stopEffect(self._bgUIEffect)

		self._bgUIEffect = nil
	end
end

function JieshenvsjiuView:_onClickWorldTableView()
	if self._isOpenWorldRoot then
		self._isOpenWorldRoot = false

		GameUtil.setAnchoredPos(self._WorldTableviewRectTrans, 40, -258)
		GameUtil.setLocalRotation(self._worldArrow, 0, 0, 0)
		self._worldTableview:reloadData()
	else
		self._isOpenWorldRoot = true

		GameUtil.setAnchoredPos(self._WorldTableviewRectTrans, -200, -258)
		GameUtil.setLocalRotation(self._worldArrow, 0, 0, 180)
		self._worldTableview:reloadData(self._worldPrizeCfgs)
	end
end

function JieshenvsjiuView:_onClickTip()
	TipsFacade.instance:openRulesView("jieshenvsjiuview_rule")
end

function JieshenvsjiuView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local proxy = MaterialMgr.setCellByCfg(data.prize, cell.icon)
	local gainPrizeIds = JieShenVsJiuModel.instance:getGainPrizeIds(self._activityId)

	cell.txtNum.text = data.progress

	GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickGainPrize, self, data))

	local wasGain = false

	if JieShenVsJiuController.instance:getIsGainPrize(gainPrizeIds, data.prizeId) then
		wasGain = true

		GameUtil.rmClickHandler(cell.btn)
	end

	local isCanGain = not wasGain and JieShenVsJiuModel.instance:getMyScore(self._activityId) >= data.progress

	goutil.setActive(cell.got, wasGain)
	goutil.setActive(cell.btn, isCanGain)
	goutil.setActive(cell.effect, isCanGain)

	if isCanGain then
		self:_loadEffect(cell)
	else
		self:_removeEffect(cell)
	end
end

function JieshenvsjiuView:_clearCell(goCell)
	if self._cellMap[goCell] == nil then
		self._cellMap[goCell] = {}
		self._cellMap[goCell].icon = goutil.findChild(goCell, "icon")
		self._cellMap[goCell].txtNum = goutil.findChildTextComponent(goCell, "txtNum")
		self._cellMap[goCell].btn = goutil.findChild(goCell, "btn")
		self._cellMap[goCell].effect = goutil.findChild(goCell, "effect")
		self._cellMap[goCell].got = goutil.findChild(goCell, "got")
	end

	MaterialMgr.resetAll(self._cellMap[goCell].icon)

	return self._cellMap[goCell]
end

function JieshenvsjiuView:_updateWorldCell(view, goCell, data)
	local info = JieShenVsJiuModel.instance:getInfo(self._activityId)
	local cell = self:_clearWorldCell(goCell)
	local proxy = MaterialMgr.setCellByCfg(data.prize, cell.icon)

	cell.txtNum.text = data.needScore

	GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickGainWorldPrize, self, data))

	local wasGain = false

	if JieShenVsJiuController.instance:getIsGainPrize(info.gainWorldPrizeIds, data.prizeId) then
		wasGain = true

		GameUtil.rmClickHandler(cell.btn)
	end

	local curWorldProgress = checknumber(info.worldProgress)
	local isCanGain = not wasGain and curWorldProgress >= data.needScore

	print("worldPrizeId = ", data.prizeId, "needScore = ", data.needScore, "worldProgress = ", info.worldProgress, "isCanGain", isCanGain)
	goutil.setActive(cell.got, wasGain)
	goutil.setActive(cell.btn, isCanGain)
	goutil.setActive(cell.effect, isCanGain)

	if isCanGain then
		self:_loadWorldEffect(cell)
	else
		self:_removeWorldEffect(cell)
	end
end

function JieshenvsjiuView:_clearWorldCell(goCell)
	if self._worldCellMap[goCell] == nil then
		self._worldCellMap[goCell] = {}
		self._worldCellMap[goCell].icon = goutil.findChild(goCell, "icon")
		self._worldCellMap[goCell].txtNum = goutil.findChildTextComponent(goCell, "txtNum")
		self._worldCellMap[goCell].btn = goutil.findChild(goCell, "btn")
		self._worldCellMap[goCell].effect = goutil.findChild(goCell, "effect")
		self._worldCellMap[goCell].got = goutil.findChild(goCell, "got")
	end

	MaterialMgr.resetAll(self._worldCellMap[goCell].icon)

	return self._worldCellMap[goCell]
end

function JieshenvsjiuView:_loadEffect(cell)
	self:_removeEffect(cell)

	local effectPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect

	uiEffect = UIEffectManager.instance:playEffect(self, effectPath, cell.effect.transform, 0, 0, true, false, nil, function()
		uiEffect:setClipping(self._cellRectTrans)
	end)

	uiEffect:setParent(cell.effect.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	cell.uiEffect = uiEffect
end

function JieshenvsjiuView:_removeEffect(cell)
	if cell.uiEffect then
		UIEffectManager.instance:stopEffect(cell.uiEffect)

		cell.uiEffect = nil
	end
end

function JieshenvsjiuView:_loadWorldEffect(cell)
	self:_removeWorldEffect(cell)

	local effectPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect

	uiEffect = UIEffectManager.instance:playEffect(self, effectPath, cell.effect.transform, 0, 0, true, false, nil, function(...)
		uiEffect:setClipping(self._uiMask)
	end)

	uiEffect:setParent(cell.effect.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	cell.uiEffect = uiEffect
end

function JieshenvsjiuView:_removeWorldEffect(cell)
	if cell.uiEffect then
		UIEffectManager.instance:stopEffect(cell.uiEffect)

		cell.uiEffect = nil
	end
end

function JieshenvsjiuView:reloadViewByCfg()
	self._activityCfg = JieShenVsJiuConfig.instance:getActivityCfg(self._activityId)
	self._prizeCfg = JieShenVsJiuConfig.instance:getPrizeCfgs(self._activityId)

	local worldPrizePlanId = self._activityCfg.worldProgressPrizePlanId

	self._worldPrizeCfgs = GeneralWorldProgressConfig.instance:getprizeCfgsByPlanId(worldPrizePlanId)
end

function JieshenvsjiuView:_onClickSupport(teamId)
	JieShenVsJiuAgent.instance:sendPM_JieShenVsJiuChooseTeamReq(self._activityId, teamId)
end

function JieshenvsjiuView:_onClickGainPrize(data)
	JieShenVsJiuAgent.instance:sendPM_JieShenVsJiuGainPrizeReq(self._activityId, data.prizeId)
end

function JieshenvsjiuView:_onClickGainWorldPrize(data)
	print("gain world prize", data.prizeId)
	JieShenVsJiuAgent.instance:sendPM_JieShenVsJiuGainWorldProgressPrizeReq(self._activityId, data.prizeId)
end

function JieshenvsjiuView:_onClickStartGame()
	local clientKey = JieShenVsJiuModel.instance:creatMyClientKey()

	JieShenVsJiuAgent.instance:sendPM_JieShenVsJiuStartGameReq(self._activityId, clientKey)
end

function JieshenvsjiuView:_onRefreshPerFourMin()
	print("4分钟刷新")
	JieShenVsJiuAgent.instance:sendPM_JieShenVsJiuGetInfoReq(self._activityId)
	self:_refreshPercentPair()
end

function JieshenvsjiuView:_refreshPercentPair()
	local percent = JieShenVsJiuController.instance:culMyTeamSupportPercentage(self._activityId)

	self._sliderPercentPair:SetValue(percent)

	self._txtLeftTeamPercent.text = string.format("%d", percent * 100) .. "%"
	self._txtRightTeamPercent.text = string.format("%d", (1 - percent) * 100) .. "%"
end

function JieshenvsjiuView:_onGetInfoRes()
	local info = JieShenVsJiuModel.instance:getInfo(self._activityId)
	local myTeamId = info.myTeamId

	if myTeamId == 1 or myTeamId == 2 then
		self:_hadMyTeamId(true)
		self:_refreshPercentPair()

		self._txtScore.text = tostring(info.myScore)

		local cfg = {}

		for k, v in pairs(self._prizeCfg) do
			table.insert(cfg, v)
		end

		if #cfg > 1 then
			table.sort(cfg, function(a, b)
				return a.progress > b.progress
			end)
		end

		local maxValue = cfg[1].progress

		self:_initScrollList(self._tableview, self._goTableview, self._prizeCfg, info.myScore, maxValue, 0.01, false)
	else
		self:_hadMyTeamId(false)
	end

	self:_refreshTodayGameTimes()

	self._txtWorldProgress.text = "累计：<color=#F8D200FF>" .. tostring(info.worldProgress) .. "</color>次"

	self:_refreshWorldProgressInfos(info)
end

function JieshenvsjiuView:_refreshWorldProgressInfos(info)
	local cfg = {}

	for k, v in pairs(self._worldPrizeCfgs) do
		table.insert(cfg, v)
	end

	if #cfg > 1 then
		table.sort(cfg, function(a, b)
			return a.needScore > b.needScore
		end)
	end

	local maxValue = cfg[1].needScore

	self:_initScrollList(self._worldTableview, self._goWorldTableview, self._worldPrizeCfgs, info.worldProgress, maxValue, 0, true)
end

function JieshenvsjiuView:_onGetChooseTeamRes()
	JieShenVsJiuAgent.instance:sendPM_JieShenVsJiuGetInfoReq(self._activityId)
end

function JieshenvsjiuView:_onGetStartGameRes()
	print("JieShenVsJiuView: Game start")

	local serverKey = JieShenVsJiuModel.instance:getMyServerKey()
	local clientKey = JieShenVsJiuModel.instance:getMyClientKey()

	UIStateManager.instance:push(ViewName.JieShenVsJiuGameView, self._activityId, 394001)
end

function JieshenvsjiuView:_onGetEndGameRes()
	local myScore = JieShenVsJiuModel.instance:getMyScore(self._activityId)

	self:_initScrollList(self._tableview, self._goTableview, self._prizeCfg, myScore, 30, false)

	self._txtTodayGameTime.text = "今日剩余：" .. tostring(self._activityCfg.dailyGameTimes - JieShenVsJiuModel.instance:getTodayGameTimes(self._activityId)) .. "次"
end

function JieshenvsjiuView:_onGetGainPrizeRes()
	self._tableview:reloadData(self._prizeCfg)
end

function JieshenvsjiuView:_onGetWorldProgressGainPrize()
	self._worldTableview:reloadData(self._worldPrizeCfgs)
end

function JieshenvsjiuView:_hadMyTeamId(isHad)
	local myTeamId = JieShenVsJiuModel.instance:getMyTeamId(self._activityId)

	if isHad then
		local myTeamBg = goutil.findChild(self._goMyTeam, "img")

		goutil.setActive(self._btnSupportT1.gameObject, false)
		goutil.setActive(self._btnSupportT2.gameObject, false)
		goutil.setActive(self._unChooseTeam, false)
		goutil.setActive(self._btnStartGame.gameObject, true)
		goutil.setActive(self._goTableview, true)
		goutil.setActive(self._sliderPercentPair.gameObject, true)
		goutil.setActive(self._goWorldTableview, true)
		goutil.setActive(self._goMyTeam, true)

		if myTeamId == 1 then
			GameUtil.setAnchoredPos(self._goMyTeam, -189.1, 321.3, 0)
			GameUtil.setLocalRotation(myTeamBg, 0, 0, 0)
		elseif myTeamId == 2 then
			GameUtil.setAnchoredPos(self._goMyTeam, 167, 321.3, 0)
			GameUtil.setLocalRotation(myTeamBg, 0, 0, 180)
		end
	else
		goutil.setActive(self._btnSupportT1.gameObject, true)
		goutil.setActive(self._btnSupportT2.gameObject, true)
		goutil.setActive(self._unChooseTeam, true)
		goutil.setActive(self._sliderPercentPair.gameObject, false)
		goutil.setActive(self._btnStartGame.gameObject, false)
		goutil.setActive(self._goTableview, false)
		goutil.setActive(self._goWorldTableview, false)
		goutil.setActive(self._goMyTeam, false)
	end
end

function JieshenvsjiuView:_initScrollList(tableview, goTableview, data, value, maxValue, offset, isWorldTableview)
	if isWorldTableview and self._isOpenWorldRoot == false then
		tableview:reloadData()
	else
		tableview:reloadData(data)
	end

	offset = offset or 0

	self:_refreshScrollSlider(goTableview, value, maxValue, offset)
end

function JieshenvsjiuView:_refreshScrollSlider(tableview, value, maxValue, offset)
	local slider = goutil.findChildComponent(tableview, "viewport/content/slider", "Slider")

	slider.value = value / maxValue + offset
end

function JieshenvsjiuView:_refreshTodayGameTimes()
	local gameTimes = self._activityCfg.dailyGameTimes - JieShenVsJiuModel.instance:getTodayGameTimes(self._activityId)

	self._txtTodayGameTime.text = "今日剩余：" .. tostring(gameTimes) .. "次"

	local canPlay = gameTimes > 0

	goutil.setActive(self._btnStartGameRp, canPlay)
end

function JieshenvsjiuView:_initActivityId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.JieShenVsJiu)
	end
end

return JieshenvsjiuView
