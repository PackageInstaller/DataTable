-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monopoly/view/MonopolyView.lua

module("logic.extensions.monopoly.view.MonopolyView", package.seeall)

local MonopolyView = class("MonopolyView", ViewComponent)
local EFFECT_PARA = {
	jiayi = {
		time = 0.5,
		path = "fx_ui_duolamengmengtiaozhan/fx_ui_duolamengmeng_lunhuitanbao.prefab"
	}
}
local LEVEL_PREFIX = "Lv."

function MonopolyView:ctor()
	MonopolyView.super.ctor(self)
end

function MonopolyView:buildUI()
	MonopolyView.super.buildUI(self)

	self.container = {}

	for i = 1, MonopolyModel.CELL_NUM do
		local cell = {}

		cell.go = goutil.findChild(self.mainGO, "circle/cell_" .. i)
		cell.select = goutil.findChild(cell.go, "select")
		cell.effect = goutil.findChild(cell.go, "effect")
		cell.cellLevel = goutil.findChild(cell.go, "cellLevel")
		cell.txtLevel = goutil.findChildTextComponent(cell.go, "cellLevel/txtLevel")
		cell.txtAddNum = goutil.findChildTextComponent(cell.go, "txt/txtAdd")

		table.insert(self.container, cell)
	end

	self._GoControl = {}

	for i = 1, 6 do
		self._GoControl[i] = {}
		self._GoControl[i].btn = self:getBtn("viewControl/step_" .. i)
		self._GoControl[i].go = goutil.findChild(self.mainGO, "viewControl/step_" .. i .. "/select")

		self._GoControl[i].btn:AddClickListener(function()
			self:_controlDice(i)
		end)
	end

	self.btnClose = self:getBtn("btnClose")
	self.btnDice = self:getBtn("middle/btnDice")
	self.btnControl = self:getBtn("middle/btnControl")
	self.btnControlSure = self:getBtn("viewControl/btnSure")
	self.btnControlCancel = self:getBtn("viewControl/btnCancel")
	self.btnTips1 = self:getGo("middle/btnTips1")
	self.btnTips2 = self:getGo("middle/btnTips2")
	self.con = self:getGo("bg2/con")
	self._btnAnim = Framework.ToggleAdapter.GetFrom(self.mainGO.gameObject, "middle/btnAnim")
	self.controlView = goutil.findChild(self.mainGO, "viewControl")
	self._customInput = UICustomInput.Get(self.controlView)
	self._randomView = goutil.findChild(self.mainGO, "viewRandom")
	self._txtDetails = goutil.findChildTextComponent(self.mainGO, "viewRandom/txtDetails")
	self._random_img = self:getGo("viewRandom/img")
	self._txtDice = goutil.findChildTextComponent(self.mainGO, "middle/txtDiceHave")
	self._txtControlHave = goutil.findChildTextComponent(self.mainGO, "middle/txtControlHave")
	self._txtDiceLimit = goutil.findChildTextComponent(self.mainGO, "middle/txtDiceLimit")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "time/txtTime")
	self._txtCircleNum = goutil.findChildTextComponent(self.mainGO, "txtCircleNum")
	self._txtTip = self:getBtn("btnTip")
	self._btnPrize = self:getBtn("viewExtraBonus/btnPrize")
	self._bounsIcon = self:getGo("viewExtraBonus/icon")
	self._diceRedPoint = goutil.findChild(self.mainGO, "middle/btnDice/imgRed")
	self._controlRedPoint = goutil.findChild(self.mainGO, "middle/btnControl/imgRed")
	self._goMiddle = goutil.findChild(self.mainGO, "middle")
	self.cellEffects = {}
	self.cellNumEffectTweeners = {}
	self.intervalTime = 0.3
	self.randomTipShowTime = 1
end

function MonopolyView:bindEvents()
	MonopolyView.super.bindEvents(self)
	self.btnClose:AddClickListener(function()
		if not self._isRunning or self._gameOver == true then
			MonopolyController.instance:clearSaiziRes()
			self:close()
		end
	end, self)
	self.btnDice:AddClickListener(self._normalDice, self)
	self.btnControl:AddClickListener(self._openControlView, self)
	self._customInput:AddListener(self._ControlInputCallback, self)
	self.btnControlSure:AddClickListener(self._controlDiceSure, self)
	self.btnControlCancel:AddClickListener(self._controlViewClose, self)
	self._txtTip:AddClickListener(self._openTips, self)
	self._btnPrize:AddClickListener(self._openMonopolyPrize, self)
	GameUtil.addClickHandler(self.btnTips1, self.onClickTips1, self)
	GameUtil.addClickHandler(self.btnTips2, self.onClickTips2, self)
end

function MonopolyView:unbindEvents()
	MonopolyView.super.unbindEvents(self)
	self.btnClose:RemoveClickListener()
	self.btnDice:RemoveClickListener()
	self.btnControl:RemoveClickListener()
	self._customInput:RemoveListener()

	for i = 1, 6 do
		self._GoControl[i].btn:RemoveClickListener()
	end

	self.btnControlSure:RemoveClickListener()
	self.btnControlCancel:RemoveClickListener()
	self._txtTip:RemoveClickListener()
	self._btnPrize:RemoveClickListener()
end

function MonopolyView:destroyUI()
	MonopolyView.super.destroyUI(self)
end

function MonopolyView:onEnter()
	MonopolyView.super.onEnter(self)

	local btnList
	local btnList = {
		{
			showAdd = true,
			id = GameEnum.GoldType.Diamond
		}
	}

	MainUIController.instance:showGlodBar(self:getGo("goldBarCon"), self._viewPresentor, btnList)

	if not MonopolyModel.instance:checkMonopolyOpen() then
		FloatWordMgr.instance.show("不在活动开启时间内")
		UIStateManager.instance:pop()
	end

	if not MonopolyModel.instance:getLoginFirstChallenge() then
		self:_openMonopolyPrize()
		MonopolyModel.instance:setLoginFirstChallenge(true)
	end

	MonopolyController.instance:getMonopolyInfo(function(msg)
		self:_refresh()
	end)
	self._btnAnim:RemoveOnValueChanged()
	self._btnAnim:AddOnValueChanged(function(go, isOn)
		self._closeAnim = isOn
	end)
	MonopolyController.instance:resetCiList()
	goutil.setActive(self.controlView, false)
	goutil.setActive(self._randomView, false)

	self._btnAnim.isOn = false
	self._closeAnim = false
	self._gameOver = false

	GlobalDispatcher:addListener(GlobalNotify.MonopolyDiceCount, self._refresh, self)
	MonopolyController.instance:clearSaiziRes()

	self._isRunning = false
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, 10338, self.con, 0.6)

	self:_updateTime()
	settimer(1, self._updateTime, self)
end

function MonopolyView:_updateTime()
	local activityId = MonopolyModel.instance:getActivityId()

	if checknumber(activityId) ~= 0 then
		local time = GameUtil.string2time(ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.Monopoly, activityId).endTime)
		local diff = time - ServerTime.now()
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(diff)

		if diff > 0 then
			self._txtTime.text = langPara("活动剩余时间：%d天%d小时%d分%d秒", day, hour, min, sec)
		else
			self._txtTime.text = langPara("活动已结束")
			self._gameOver = true
		end
	else
		self._txtTime.text = langPara("活动已结束")
	end
end

function MonopolyView:onEnterFinished()
	MonopolyView.super.onEnterFinished(self)
end

function MonopolyView:onExit()
	MonopolyView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.MonopolyDiceCount, self._refresh, self)
	removetimer(self._stepEnd, self)
	removetimer(self._playFowardEffect, self)
	removetimer(self._updateTime, self)

	for i = 1, MonopolyModel.CELL_NUM do
		local item = goutil.findChild(self.container[i].go, "item")

		GameUtil.asBtn(item):RemoveClickListener()

		if self.cellEffects[i] then
			UIEffectManager.instance:stopEffect(self.cellEffects[i])

			self.cellEffects[i] = nil
		end
	end

	for k, tween in pairs(self.cellNumEffectTweeners) do
		if tween then
			tween:Kill(false)

			tween = nil
		end
	end

	MaterialMgr.resetAll(self._bounsIcon)
	self._btnAnim:RemoveOnValueChanged()

	self._monopolyDiceResMsg = nil
	self._isRunning = false

	RoleObjectPool.instance:removeRole(self._role)
	MonopolyController.instance:destroyAnimationSaiziTimer()
	MonopolyController.instance:clearSaiziRes()

	self._closeAnim = false

	uGuiUtil.clearImage(self._random_img)
end

function MonopolyView:onExitFinished()
	MonopolyView.super.onExitFinished(self)
end

function MonopolyView:_controlDice(count)
	self.count = count

	self:_refreshControlDice()
end

function MonopolyView:_refreshControlDice()
	for i = 1, 6 do
		goutil.setActive(self._GoControl[i].go, self.count == i)
	end
end

function MonopolyView:_controlViewClose()
	goutil.setActive(self.controlView, false)

	self.count = nil

	if self._itemProxy then
		self._itemProxy.binder:setEffStatus(true)
	end
end

function MonopolyView:_controlDiceSure()
	if not self.count then
		FloatWordMgr.instance:show("您未选择想要的数字，请选择")

		return
	end

	self:_letsGo()
	self:_controlViewClose()
end

function MonopolyView:_normalDice()
	if not MonopolyModel.instance:checkMonopolyOpen() then
		FloatWordMgr.instance:show("活动已结束")

		return
	end

	MonopolyModel.instance:refreshHasBuyDiceTimes()

	if self._isRunning then
		return
	end

	local enough = MonopolyController.instance:getIfDiceEnough()

	if enough then
		self:_letsGo()
	else
		local hasBuyDiceTimes = MonopolyModel.instance:getHasBuyDiceTimes()
		local activityId = MonopolyModel.instance:getActivityId()
		local actCfg = MonopolyConfig.instance:getMonopolyConfigById(activityId)
		local limitNum = checknumber(actCfg.limit)

		if limitNum <= hasBuyDiceTimes then
			FloatWordMgr.instance:show("今日购买已达上限，次日5点刷新购买次数")
		else
			local target = MonopolyConfig.instance:getMonopolyConfigById(activityId).commonDecMp
			local leftBuyNum = math.min(limitNum, limitNum - hasBuyDiceTimes)
			local price = actCfg.diamond
			local priceStr = MatType.Diamond .. ":" .. MatType.Diamond_Normal .. ":" .. price
			local str = langPara("每日限购%s/%s", hasBuyDiceTimes, limitNum)

			TipsFacade.instance:openPopupCostManyView(target, priceStr, leftBuyNum, str, nil, function(num)
				MonopolyController.instance:buyDice(num)
			end)
		end
	end
end

function MonopolyView:_letsGo()
	if self._isRunning then
		return
	end

	if self.count then
		if not MonopolyController.instance:getIfControlDiceEnough() then
			return
		end
	elseif not MonopolyController.instance:getIfDiceEnough() then
		return
	end

	self:closeMiddleView()

	self._isRunning = true

	MonopolyController.instance:go(self.count, function(msg, count)
		self._monopolyDiceResMsg = msg

		MonopolyController.instance:rotateSaizi(count, self._closeAnim, msg.forward, function()
			self:_stepLightFlow()
		end)
	end)

	self.count = nil
end

function MonopolyView:_stepLightFlow()
	if not self._monopolyDiceResMsg then
		return
	end

	self.curPos = self.curPos or MonopolyModel.instance:getCurPosition()

	self:_stepForward(self._monopolyDiceResMsg.forward, self.curPos + self._monopolyDiceResMsg.forward, function()
		self:_refreshRound()

		if MonopolyModel.instance:hasRandomEvent() then
			self:_playRandomEvent()
		else
			MonopolyController.instance:clearSaiziRes()
			self:stepEnd()
		end
	end)
	self:_refreshDice()
end

function MonopolyView:_openControlView()
	if self._isRunning then
		return
	end

	if not MonopolyModel.instance:checkMonopolyOpen() then
		FloatWordMgr.instance:show("活动已结束")

		return
	end

	local enough = MonopolyController.instance:getIfControlDiceEnough()

	if not enough then
		FloatWordMgr.instance:show("目前没有遥控骰子，可在冒险过程中，\n通过【？】事件获得，也可通过额外奖励获得")

		return
	end

	goutil.setActive(self.controlView, true)

	if self._itemProxy then
		self._itemProxy.binder:setEffStatus(false)
	end

	self:_refreshControlDice()
end

function MonopolyView:_refresh()
	self.curPos = MonopolyModel.instance:getCurPosition()

	local activityId = MonopolyModel.instance:getActivityId()

	self._planId = MonopolyConfig.instance:getMonopolyConfigById(activityId).planId

	for i = 1, MonopolyModel.CELL_NUM do
		self:refreshOneCellLevel(i)
	end

	self:_refreshRound()
	self:_refreshDice()
end

function MonopolyView:_refreshDice()
	local diceNum = MonopolyController.instance:getDiceNum()
	local ControlDiceNum = MonopolyController.instance:getControlDiceNum()

	self._txtDice.text = langPara("当前拥有<color=#ffb166>%s</color>个", diceNum)

	local buyTimes = MonopolyModel.instance:getHasBuyDiceTimes()
	local activityId = MonopolyModel.instance:getActivityId()
	local actCfg = MonopolyConfig.instance:getMonopolyConfigById(activityId)
	local limitNum = checknumber(actCfg.limit)

	self._txtDiceLimit.text = string.format("每日限购:%d/%d", buyTimes, limitNum)
	self._txtControlHave.text = langPara("当前拥有<color=#ffb166>%s</color>个", ControlDiceNum)

	goutil.setActive(self._diceRedPoint, diceNum > 0)
	goutil.setActive(self._controlRedPoint, ControlDiceNum > 0)
end

function MonopolyView:_refreshRound()
	if self._gameOver == false then
		local round = MonopolyModel.instance:getCurRound()

		self._txtCircleNum.text = string.format("当前第%s圈", checknumber(round + 1))

		MaterialMgr.resetAll(self._bounsIcon)

		local activityId = MonopolyModel.instance:getActivityId()
		local planId = MonopolyConfig.instance:getMonopolyConfigById(activityId).planId
		local list = MonopolyConfig.instance:getExtraBonus(planId)

		for i, v in ipairs(list) do
			if round < v.round or i == #list then
				self._itemProxy = MaterialMgr.setCellByCfg(v.showItem, self._bounsIcon)

				self._itemProxy.binder:setNumStr()
				self._itemProxy.binder:setBgActive(false)

				break
			end
		end
	end
end

function MonopolyView:_stepForward(count, targetPos, callback)
	goutil.setActive(self.container[self.curPos].select, false)

	self.forward = count > 0 and 1 or -1
	self.targetPos = self:_checkNumber(targetPos)
	self._stepEndCallback = callback

	settimer(self.intervalTime, self._playFowardEffect, self, true)
	settimer(self.intervalTime * (math.abs(count) + 1), self._stepEnd, self, false)
end

function MonopolyView:_stepEnd()
	GameUtil.callBack(self._stepEndCallback)
	removetimer(self._stepEnd, self)

	self._stepEndCallback = nil
end

function MonopolyView:_checkNumber(n)
	if n > MonopolyModel.CELL_NUM then
		return n - MonopolyModel.CELL_NUM
	elseif n < 0 then
		return 21 + n
	end

	return n
end

function MonopolyView:_playFowardEffect()
	self.lastPos = self.curPos
	self.curPos = self.curPos + self.forward
	self.curPos = self:_checkNumber(self.curPos)

	goutil.setActive(self.container[self.curPos].select, true)
	goutil.setActive(self.container[self.lastPos].select, false)

	if self.curPos == self.targetPos then
		removetimer(self._playFowardEffect, self)
	end
end

function MonopolyView:_ControlInputCallback(hover)
	if not hover then
		self:_controlViewClose()
	end
end

function MonopolyView:_playRandomEvent()
	local randomEvent = MonopolyModel.instance:getRandomEvent()
	local cfg = MonopolyConfig.instance:getMonopolyEvent(randomEvent.eventId)

	uGuiUtil.setSpriteToImage(self._random_img, uGuiUtil.SpriteType.BigBg, cfg.imgPath .. ".png")

	if not string.nilorempty(cfg.desc) then
		self._txtDetails.text = string.format(cfg.desc, tostring(math.abs(randomEvent.eventForward)))
	end

	local showEnd = function()
		goutil.setActive(self._randomView, false)

		if self._itemProxy then
			self._itemProxy.binder:setEffStatus(true)
		end

		local eventForward = checknumber(randomEvent.eventForward)

		if eventForward ~= 0 then
			self:_stepForward(randomEvent.eventForward, MonopolyModel.instance:getCurPosition(), function()
				self:stepEnd()
			end)
		else
			self:stepEnd()
		end

		removetimer(showEnd, self)
		MonopolyModel.instance:SaveRandomEvent(nil, nil)
		MonopolyController.instance:clearSaiziRes()
	end

	goutil.setActive(self._randomView, true)

	if self._itemProxy then
		self._itemProxy.binder:setEffStatus(false)
	end

	MonopolyController.instance:clearSaiziRes()
	settimer(self.randomTipShowTime * 2, showEnd, self, false)
end

function MonopolyView:_openTips()
	if self._isRunning then
		return
	end

	UIStateManager.instance:push(ViewName.RulesView, "monopolyview")
end

function MonopolyView:onClickTips1()
	local activityId = MonopolyModel.instance:getActivityId()
	local cfg = MonopolyConfig.instance:getMonopolyConfigById(activityId)

	if cfg then
		local consume = cfg.commonDecMp

		CommonTipsMgr.instance:openTipsByConfStr(self.btnTips1, consume)
	end
end

function MonopolyView:onClickTips2()
	local activityId = MonopolyModel.instance:getActivityId()
	local cfg = MonopolyConfig.instance:getMonopolyConfigById(activityId)

	if cfg then
		local consume = cfg.pointedDecMp

		CommonTipsMgr.instance:openTipsByConfStr(self.btnTips2, consume)
	end
end

function MonopolyView:_openMonopolyPrize()
	if self._isRunning then
		return
	end

	if not MonopolyModel.instance:checkMonopolyOpen() then
		FloatWordMgr.instance:show("活动已结束")

		return
	end

	UIStateManager.instance:push(ViewName.MonopolyprizeView, "monopolyprizeview")
end

function MonopolyView:openMiddleView()
	goutil.setActive(self._goMiddle, true)
end

function MonopolyView:closeMiddleView()
	goutil.setActive(self._goMiddle, false)
end

function MonopolyView:stepEnd()
	local cfg = MonopolyConfig.instance:getRoundCfg(self.curPos - 1, self._planId)

	if checknumber(cfg.upgradePlanId) > 0 then
		self:showEffectAdd1End()
	else
		self:refreshOneCellLevel(self.curPos)

		self._isRunning = false
	end

	MonopolyController.instance:showMonopolyCI()
	self:openMiddleView()
end

function MonopolyView:showEffectAdd1End()
	local index = self.curPos
	local cell = self.container[index]

	if cell then
		local cfg = MonopolyConfig.instance:getRoundCfg(self.curPos - 1, self._planId)
		local upgradeCfg = MonopolyConfig.instance:getLevelPlan(cfg.upgradePlanId)
		local nowLevel = MonopolyModel.instance:getStepLevel(index)
		local nowReward = upgradeCfg[nowLevel].rewards
		local nowArrStr = string.split(nowReward, ":")
		local nowNum = checknumber(nowArrStr[3])
		local strShowLevel = self.container[index].txtLevel.text
		local preLevel = nowLevel

		if string.find(strShowLevel, LEVEL_PREFIX) then
			local num = string.find(strShowLevel, "%d")

			preLevel = checknumber(string.sub(strShowLevel, num, string.len(strShowLevel)))
		end

		local preReward = upgradeCfg[preLevel].rewards
		local preArrStr = string.split(preReward, ":")
		local preNum = checknumber(preArrStr[3])

		if preLevel == #upgradeCfg then
			self:refreshOneCellLevel(self.curPos)

			self._isRunning = false
		else
			local addValue = nowNum - preNum

			GameUtil.SetActive(cell.txtAddNum.gameObject, true)

			self.cellNumEffectTweeners[index] = TweenUtil.ValueTo(1, 0, 2, function(val)
				cell.txtAddNum.text = addValue .. "+"
			end, function()
				self.cellNumEffectTweeners[index] = nil

				GameUtil.SetActive(cell.txtAddNum.gameObject, false)
				self:refreshOneCellLevel(self.curPos)

				self._isRunning = false
			end, self)

			local param = EFFECT_PARA.jiayi

			self.cellEffects[index] = UIEffectManager.instance:playEffect(self, param.path, nil, 0, 0, false, nil, nil, function(finishHandlerTarget, eff)
				Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
			end)

			self.cellEffects[index]:setParent(cell.effect.transform)
			self.cellEffects[index]:setScale(1)

			self.cellEffects[index].hideEffWhileNotOnTop = true
		end
	end
end

function MonopolyView:refreshOneCellLevel(i)
	goutil.setActive(self.container[i].select, self.curPos == i)

	local bigPrize = goutil.findChild(self.container[i].go, "icon")
	local unKnown = goutil.findChild(self.container[i].go, "unKnown")
	local item = goutil.findChild(self.container[i].go, "item")
	local imgQue = goutil.findChild(self.container[i].go, "imgQue")
	local numTxt = goutil.findChildTextComponent(self.container[i].go, "txt")

	numTxt.text = ""

	GameUtil.SetActive(item, true)

	local cfg = MonopolyConfig.instance:getRoundCfg(i - 1, self._planId)

	if cfg then
		GameUtil.SetActive(unKnown, checknumber(cfg.eventGroupId) > 0)
		GameUtil.SetActive(imgQue, checknumber(cfg.eventGroupId) > 0)
		GameUtil.SetActive(bigPrize, checknumber(cfg.grandprize) == 1)

		local reward

		if checknumber(cfg.upgradePlanId) > 0 then
			local upgradeCfg = MonopolyConfig.instance:getLevelPlan(cfg.upgradePlanId)
			local level = MonopolyModel.instance:getStepLevel(i)

			reward = upgradeCfg[level].rewards
			self.container[i].txtLevel.text = level < #upgradeCfg and langPara("%s%s", LEVEL_PREFIX, level) or langPara("<color=#ff7e69>满级</color>")

			goutil.setActive(self.container[i].cellLevel, true)
		else
			reward = cfg.reward
			self.container[i].txtLevel.text = ""

			goutil.setActive(self.container[i].cellLevel, false)
		end

		MaterialMgr.clearIcon(item)

		if not string.nilorempty(reward) then
			MaterialMgr.updateItemByStr(item, reward, numTxt)
			GameUtil.asBtn(item):AddClickListener(function()
				local arr = string.split(reward, ":")

				CommonTipsMgr.instance:openMaterialTips(self.container[i].go, checknumber(arr[1]), checknumber(arr[2]), 0)
			end)
		end
	end
end

return MonopolyView
