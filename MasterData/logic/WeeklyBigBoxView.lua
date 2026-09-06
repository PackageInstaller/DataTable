-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklybigbox/view/WeeklyBigBoxView.lua

module("logic.extensions.weeklybigbox.view.WeeklyBigBoxView", package.seeall)

local WeeklyBigBoxView = class("WeeklyBigBoxView", ViewComponent)

function WeeklyBigBoxView:ctor()
	WeeklyBigBoxView.super.ctor(self)
end

function WeeklyBigBoxView:unbindEvents()
	WeeklyBigBoxView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnGet)
	GameUtil.rmClickHandler(self._btnReward)
	GameUtil.rmClickHandler(self._btnGame)

	for i = 1, 10 do
		local boxInfo = self._boxes[i]

		GameUtil.rmClickHandler(boxInfo.boxGo)
	end
end

function WeeklyBigBoxView:bindEvents()
	WeeklyBigBoxView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickGet, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickReward, self)
	GameUtil.addClickHandler(self._btnGame, self._onClickGame, self)

	for i = 1, 10 do
		local boxInfo = self._boxes[i]

		GameUtil.addClickHandler(GameUtil.asBtn(boxInfo.boxGo), GameUtil.handler(self._showPackageTips, self, i))
	end
end

function WeeklyBigBoxView:buildUI()
	WeeklyBigBoxView.super.buildUI(self)

	self._btnTip = self:getBtn("btnTip")
	self._txtTime = self:getTxt("time/txt")
	self._btnGame = self:getBtn("btnGame")
	self._txtGame = self:getTxt("btnGame/Text")
	self._tagGo = self:getGo("tag")
	self._btnReward = self:getBtn("btnReward")
	self._btnGet = self:getBtn("btnGet")
	self._txtRemain = self:getTxt("txtRemain")
	self._notOpenTimeGo = self:getGo("luckyRankGo/notOpenTime")
	self._nobodyTxtGo = self:getGo("luckyRankGo/nobodyTxt")
	self._mainEffectGo = self:getGo("effect")
	self._boxes = {}

	for i = 1, 10 do
		local box = self:getGo(string.format("cells/cell_%d", i))
		local tag = goutil.findChild(box, "tag")
		local item = goutil.findChild(box, "item")
		local effect = goutil.findChild(box, "effect")

		goutil.setActive(tag, false)

		local rX, rY, rZ = GameUtil.getLocalRotation(box)

		table.insert(self._boxes, {
			state = 0,
			boxGo = box,
			tagGo = tag,
			itemGo = item,
			effectGo = effect,
			rX = rX,
			rY = rY,
			rZ = rZ
		})
	end

	local bigPrizeStr = WeeklyBigBoxConfig.instance:getCommonValue("NEED_RECORD_BIG_PRIZE_IDS")
	local array = string.splitToNumber(bigPrizeStr, ",")

	self._bigPrizeMap = {}

	for i = 1, #array do
		self._bigPrizeMap[array[i]] = true
	end
end

function WeeklyBigBoxView:onExit()
	WeeklyBigBoxView.super.onExit(self)
	removetimer(self._checkIsNewDay, self)
	WeeklyBigBoxController.instance:unregisterLocalNotify(WeeklyBigBoxController.E_GetInfoRes, self._updateAll, self)
	WeeklyBigBoxController.instance:unregisterLocalNotify(WeeklyBigBoxController.E_OpenRedPackageRes, self._onOpenRedPackage, self)

	if self._loopRoller then
		self._loopRoller:dispose()
	end

	for i = 1, 10 do
		local boxInfo = self._boxes[i]

		MaterialMgr.resetAll(boxInfo.itemGo)
	end

	self:_removeMainEffect()
end

function WeeklyBigBoxView:onEnter()
	WeeklyBigBoxView.super.onEnter(self)
	WeeklyBigBoxController.instance:registerLocalNotify(WeeklyBigBoxController.E_GetInfoRes, self._updateAll, self)
	WeeklyBigBoxController.instance:registerLocalNotify(WeeklyBigBoxController.E_OpenRedPackageRes, self._onOpenRedPackage, self)
	self:_initActivityTimeText()

	self._loopRoller = self._loopRoller or LoopRoller.New(self:getGo("luckyRankGo"))

	self._loopRoller:init({
		margin = 4,
		updateCellFunc = self._updateRollerCell,
		removeCellFunc = self._removeRollerCell,
		thisArg = self,
		direction = LoopRoller.Direction_B2T,
		weekAlign = LoopRoller.WeekAlign_LeftOrTop,
		speed = WeeklyBigBoxConfig.instance:getClientCommonValue("ROLLER_SPEED", true)
	})
	self:_resetPrizes()
	self:_dailyReset()
	WeeklyBigBoxModel.instance:getIfNewDay()
	settimer(1, self._checkIsNewDay, self)
	self:_addMainEffect()
end

function WeeklyBigBoxView:_removeMainEffect()
	if self._mainEffect then
		UIEffectManager.instance:stopEffect(self._mainEffect)

		self._mainEffect = nil
	end
end

function WeeklyBigBoxView:_addMainEffect()
	self:_removeMainEffect()

	local effectPath = "20220902/hongbaoyu/fx_ui_zmhby_fenwei.prefab"
	local eff = UIEffectManager.instance:playEffect(self, effectPath, self._mainEffectGo.transform, 0, 0, true)

	eff:setParent(self._mainEffectGo.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._mainEffect = eff
end

function WeeklyBigBoxView:_checkIsNewDay()
	if WeeklyBigBoxModel.instance:getIfNewDay() then
		self:_dailyReset()
	end
end

function WeeklyBigBoxView:_dailyReset()
	if self:_isInActTime() then
		WeeklyBigBoxAgent.instance:sendPM_WeeklyBigBoxGetInfoReq()
	else
		WeeklyBigBoxModel.instance:resetUserData()
		self:_updateAll()
	end
end

function WeeklyBigBoxView:_updateAll()
	local model = WeeklyBigBoxModel.instance
	local records = model:getRecordInfos()

	if self:_isInActTime() then
		self._loopRoller:reload(records)
		self._loopRoller:play()
		goutil.setActive(self._notOpenTimeGo, false)
	else
		self._loopRoller:dispose()
		goutil.setActive(self._notOpenTimeGo, true)
		goutil.setActive(self._nobodyTxtGo, false)
	end

	goutil.setActive(self._tagGo, model:isHasFreeTimes())

	local remainCount = model:getRemainCount()

	self._txtRemain.text = langPara("剩余%d次（次日清空）", remainCount)

	self:_resetPrizes()
	self:_updateBtnState()
end

function WeeklyBigBoxView:_updateRollerCell(item, data, index)
	local txtZoneName = goutil.findChildTextComponent(item, "txtZoneName")
	local txtName = goutil.findChildTextComponent(item, "txtName")
	local clickGo = goutil.findChild(item, "txtName/click")
	local txtDesc = goutil.findChildTextComponent(item, "txtDesc")

	txtZoneName.text = data.arenaName or ""
	txtName.text = data.userName or ""

	local conf = WeeklyBigBoxConfig.instance:getPrizeConf(data.prizeId)

	txtDesc.text = langPara("开出<color=#ff0000>%s</color>", (conf or nil) and MaterialMgr.getMaterialsNameByCfg(conf.prize))

	GameUtil.rmClickHandler(clickGo)
	GameUtil.addClickHandler(clickGo, function()
		if data.userId ~= nil then
			FriendController.instance:showInfoView(data.userId, txtNameGO)
		end
	end, self)
end

function WeeklyBigBoxView:_removeRollerCell(item)
	local clickGo = goutil.findChild(item, "txtName/click")

	GameUtil.rmClickHandler(clickGo)
end

function WeeklyBigBoxView:_initActivityTimeText()
	self._txtTime.text = WeeklyBigBoxConfig.instance:getClientCommonValue("OPEN_DAYS_OF_WEEK_STR")
end

function WeeklyBigBoxView:_updateBtnState()
	local model = WeeklyBigBoxModel.instance

	self._txtGame.text = model:getRedPackageCount() > 0 and lang("一键拆开") or lang("抢红包")
end

function WeeklyBigBoxView:_resetPrizes()
	local configInstance = WeeklyBigBoxConfig.instance
	local model = WeeklyBigBoxModel.instance
	local packageCount = model:getRedPackageCount()

	if packageCount <= 0 then
		local prizeArrayStr = configInstance:getClientCommonValue("SHOW_PRIZE_IDS")
		local prizeIds = string.splitToNumber(prizeArrayStr, "#")

		for i = 1, 10 do
			local boxInfo = self._boxes[i]
			local prizeId = prizeIds[i]
			local conf = configInstance:getPrizeConf(prizeId)
			local bBigPrize = self._bigPrizeMap[prizeId]

			goutil.setActive(boxInfo.tagGo, bBigPrize)

			boxInfo.state = 0

			MaterialMgr.setCellByCfg(conf.prize, boxInfo.itemGo)
			self:_clearEffect(boxInfo)
		end

		self:_exitOpenRedPackage()
	else
		local defaultPrize = configInstance:getClientCommonValue("RED_PACKAGE_ITEM")

		for i = 1, 10 do
			local boxInfo = self._boxes[i]

			goutil.setActive(boxInfo.tagGo, false)

			if i <= packageCount then
				boxInfo.state = 1

				self:_playEffect(boxInfo)

				local proxy = MaterialMgr.setCellByCfg(defaultPrize, boxInfo.itemGo)

				if proxy then
					proxy:setNumStr("")
					proxy:setAutoTips(false)
					proxy:setCallBack(function()
						FloatWordMgr.instance:show(lang("WeeklyBigBoxView__4"))
					end)
				end
			else
				boxInfo.state = 0

				self:_clearEffect(boxInfo)
				MaterialMgr.resetAll(boxInfo.itemGo)
			end
		end

		self:_enterOpenRedPackage()
	end
end

function WeeklyBigBoxView:_enterOpenRedPackage()
	goutil.setActive(self._tagGo, false)
	GameUtil.SetActive(self._txtRemain, false)
end

function WeeklyBigBoxView:_exitOpenRedPackage()
	goutil.setActive(self._tagGo, WeeklyBigBoxModel.instance:isHasFreeTimes())
	GameUtil.SetActive(self._txtRemain, true)
end

function WeeklyBigBoxView:_showPackageTips(index)
	local boxInfo = self._boxes[index]

	if boxInfo and boxInfo.state == 1 then
		FloatWordMgr.instance:show(lang("WeeklyBigBoxView__4"))
	end
end

function WeeklyBigBoxView:_onOpenRedPackage(msg)
	local configInstance = WeeklyBigBoxConfig.instance
	local prizeIds = msg.prizeIds

	for i = 1, 10 do
		local prizeId = checknumber(prizeIds[i])
		local boxInfo = self._boxes[i]

		if prizeId > 0 then
			local conf = configInstance:getPrizeConf(prizeId)
			local bBigPrize = self._bigPrizeMap[prizeId]

			goutil.setActive(boxInfo.tagGo, bBigPrize)
			MaterialMgr.resetAll(boxInfo.itemGo)
			MaterialMgr.setCellByCfg(conf.prize, boxInfo.itemGo)
		else
			goutil.setActive(boxInfo.tagGo, false)
		end

		self:_clearEffect(boxInfo)

		boxInfo.state = 0
	end

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	MaterialController.instance:showChangeSetInTemp(msg.changeSetId)
	self:_updateBtnState()
	self:_exitOpenRedPackage()
end

local RedPackageEffectPath = "20220902/hongbaoyu/fx_ui_zmhby_hongbaodianliang.prefab"

function WeeklyBigBoxView:_playEffect(boxInfo)
	self:_clearEffect(boxInfo)

	local uiEffect = UIEffectManager.instance:playEffect(self, RedPackageEffectPath, boxInfo.effectGo.transform, 0, 0, true)

	uiEffect:setParent(boxInfo.effectGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)
	uiEffect:setLocalEulerAngle(boxInfo.rX, boxInfo.rY, boxInfo.rZ)

	boxInfo.uiEffect = uiEffect
end

function WeeklyBigBoxView:_clearEffect(boxInfo)
	if boxInfo and boxInfo.uiEffect then
		UIEffectManager.instance:stopEffect(boxInfo.uiEffect)

		boxInfo.uiEffect = nil
	end
end

function WeeklyBigBoxView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "WeeklyBigBox_rule")
end

function WeeklyBigBoxView:_onClickGet()
	TipsFacade.instance:openTipWindow(lang("tip"), lang("WeeklyBigBoxView__1"), function()
		GotoMgr.gotoByString("func#56#1")
	end, lang("前往"))
end

function WeeklyBigBoxView:_onClickReward(index)
	UIStateManager.instance:push(ViewName.PrizeLotteryExplainView, 2)
end

function WeeklyBigBoxView:_isInActTime()
	local openWeekDayStr = WeeklyBigBoxConfig.instance:getCommonValue("OPEN_DAYS_OF_WEEK")
	local nowTime = ServerTime.now()
	local nowDate = GameUtil.time2date(nowTime)
	local wday = nowDate.wday

	if nowDate.hour < 5 then
		wday = wday + 6

		if wday > 7 then
			wday = wday - 7
		end
	end

	wday = wday - 1

	if wday == 0 then
		wday = 7
	end

	local wDayStr = tostring(wday)

	return string.find(openWeekDayStr, wDayStr)
end

function WeeklyBigBoxView:_onClickGame()
	if not self:_isInActTime() then
		FloatWordMgr.instance:show(lang("WeeklyBigBoxView__2"))

		return
	end

	local model = WeeklyBigBoxModel.instance

	if model:getRedPackageCount() > 0 then
		WeeklyBigBoxAgent.instance:sendPM_WeeklyBigBoxOpenRedPackageReq()
	elseif model:getRemainCount() > 0 then
		WeeklyBigBoxController.instance:reqStartGame()
	else
		FloatWordMgr.instance:show(lang("WeeklyBigBoxView__3"))
	end
end

return WeeklyBigBoxView
