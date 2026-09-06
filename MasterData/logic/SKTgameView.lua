-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttian/view/game/SKTgameView.lua

module("logic.extensions.saintknighttian.view.game.SKTgameView", package.seeall)

local SKTgameView = class("SKTgameView", ViewComponent)
local LineEnum = {
	Down = 1,
	Up = 3,
	Mid = 2
}

function SKTgameView:ctor()
	SKTgameView.super.ctor(self)
end

function SKTgameView:buildUI()
	SKTgameView.super.buildUI(self)

	self._moveCellcon = self:getGo("movecon").transform
	self._moveCellGo = self:getGo("movecon/cell")
	self._fbbPlayerGo = self:getGo("movecon/fbbcon")
	self._wyPlayerGo = self:getGo("movecon/wycon")
	self._fbbRoleCon = self:getGo("movecon/fbbcon/player/con").transform
	self._fbbPlayerClass = GameUtil.AddLuaOnce(self._fbbPlayerGo, SKXTPlayer)
	self._wyPlayerClass = GameUtil.AddLuaOnce(self._wyPlayerGo, SKTPetPlayer)
	self._btnDown = self:getBtn("btnDown")
	self._btnUp = self:getBtn("btnUp")
	self._warningTipGo = self:getGo("warningTip")

	goutil.setActive(self._warningTipGo, false)
	goutil.setActive(self._moveCellGo, false)
	self:_initMoveCells()

	self._bg1Tr = self:getGo("bgMove/bg1").transform
	self._bg2Tr = self:getGo("bgMove/bg2").transform
	self._bgWidth = self._bg1Tr.sizeDelta.x
	self._progressWidth = self:getGo("progress").transform.sizeDelta.x
	self._fbbHeadTr = self:getGo("progress/fbbHead").transform
	self._wyHeadTr = self:getGo("progress/wyHead").transform
	self._btnClose = self:getBtn("btnClose")
	self._gamestarTip = self:getBtn("gamestarTip")
	self._maskGo = self:getGo("mask")
end

function SKTgameView:bindEvents()
	SKTgameView.super.bindEvents(self)
	self._btnDown:AddClickListener(self._onClickbtnDown, self)
	self._btnUp:AddClickListener(self._onClickbtnUp, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._gamestarTip:AddClickListener(self._onClickgamestarTip, self)
end

function SKTgameView:unbindEvents()
	SKTgameView.super.unbindEvents(self)
	self._btnDown:RemoveClickListener()
	self._btnUp:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._gamestarTip:RemoveClickListener()
end

function SKTgameView:destroyUI()
	SKTgameView.super.destroyUI(self)
	self._moveItemPool:clear()
end

function SKTgameView:onEnter()
	SKTgameView.super.onEnter(self)
	self._fbbPlayerClass:onEnter(self)
	self._wyPlayerClass:onEnter()
	SaintKnightTianController.instance:startGame()
	goutil.setActive(self._gamestarTip.gameObject, true)
	goutil.setActive(self._wyPlayerGo, false)
	goutil.setActive(self._maskGo, false)
	goutil.setActive(self._btnDown.gameObject, true)
	goutil.setActive(self._btnUp.gameObject, true)
	self:_prepareData()
	self:_initMoveItems()
	self:_setPlayerPos()
	self:_setWYHeadPos()
	self:_setFBBHeadPos()
	self:_loadRoles()
end

function SKTgameView:onEnterFinished()
	SKTgameView.super.onEnterFinished(self)
end

function SKTgameView:onExit()
	SKTgameView.super.onExit(self)
	self:_stop()
	self._fbbPlayerClass:onExit()
	self._wyPlayerClass:onExit()

	for k, v in pairs(self._moveItems) do
		self._moveItemPool:returnObject(v)
	end

	for k, v in pairs(self._delayCreatItemList) do
		self._moveItemPool:returnObject(v)
	end

	self:_retrurnOutHitItemToPool()

	self._delayCreatItemList = {}
	self._moveItems = {}

	removetimer(self._update, self)
	removetimer(self._stopWarning, self)
	removetimer(self._checkHasDelayAndDoCreatNextItem, self)
	removetimer(self.close, self)
	removetimer(self._delayDoHitFinish, self)
	goutil.setActive(self._maskGo, false)
end

function SKTgameView:onExitFinished()
	SKTgameView.super.onExitFinished(self)
end

function SKTgameView:_onClickbtnClose()
	self:_pause(true)

	local function okFunc()
		self:close()
	end

	local function cacelFunc()
		self:_resume()
	end

	local title = "提示"
	local content = "是否选择退出游戏？\n退出将不会获得极速之羽哦！"
	local okBtnStr = "退出"
	local cancelBtnStr = "取消"

	UIStateManager.instance:push(ViewName.FbbgametipView, title, content, okFunc, cacelFunc, okBtnStr, cancelBtnStr)
end

function SKTgameView:_onClickbtnDown()
	if not self._playCanMoveLine then
		return
	end

	self._currPlayerLineType = self._currPlayerLineType - 1

	if self._currPlayerLineType < 1 then
		self._currPlayerLineType = 1
	end

	self:_setPlayerPos()
end

function SKTgameView:_onClickbtnUp()
	if not self._playCanMoveLine then
		return
	end

	self._currPlayerLineType = self._currPlayerLineType + 1

	if self._currPlayerLineType > 3 then
		self._currPlayerLineType = 3
	end

	self:_setPlayerPos()
end

function SKTgameView:_onClickgamestarTip()
	goutil.setActive(self._gamestarTip.gameObject, false)
	self:_start()
end

function SKTgameView:_initMoveCells()
	self._moveItems = {}

	local function createFunc()
		local go = goutil.cloneAndSetParent(self._moveCellGo, self._moveCellcon)

		return {
			lineType = 0,
			index = 0,
			gameObject = go,
			transform = go.transform,
			class = GameUtil.AddLuaOnce(go, SKTMoveItem)
		}
	end

	local function disposeFunc(item)
		return
	end

	local function resetFunc(item)
		item.class:onExit()
		goutil.setActive(item.gameObject, false)
	end

	self._moveItemPool = ObjectPool.New(30, createFunc, disposeFunc, resetFunc)
end

function SKTgameView:_prepareData()
	self._sceneMoveInitSpeed = SaintKnightTianConfig.instance:getDefineValue("SCENE_MOVE_SPEED", true)
	self._sceneMoveSpeed = self._sceneMoveInitSpeed
	self._sceneMoveSpeedMax = SaintKnightTianConfig.instance:getDefineValue("SCENE_MOVE_SPEED_MAX", true)
	self._into_max_speed_need_time = SaintKnightTianConfig.instance:getDefineValue("INTO_MAX_SPEED_TIME", true)
	self._moveDataList = SaintKnightTianModel.instance:prepareGameDatas()
	self._battleSlotIndex = SaintKnightTianConfig.instance:getDefineValue("BATTLE_SLOT", true)
	self._warinning_tip_slot = SaintKnightTianConfig.instance:getDefineValue("WARINING_TIP_SLOT", true)
	self._wyHeadPosInitRatio = SaintKnightTianConfig.instance:getDefineValue("WY_INIT_RATIO", true) / 100
	self._currPlayerLineType = LineEnum.Mid
	self._every_hit_reduce_hp_ratio = SaintKnightTianConfig.instance:getDefineValue("EVERY_HIT_REDUCE_HP_RATIO", true) / 100
	self._every_hit_time = SaintKnightTianConfig.instance:getDefineValue("EVERY_HIT_TIME", true)
	self._playTime = 0
	self._wy_playspeed = SaintKnightTianConfig.instance:getDefineValue("WY_MOVE_SPEED", true)
	self._itemSpace = 150
	self._itemSpaceOffset = 350
	self._lineSpace = 200
	self._playCanMoveLine = true
	self._needIntoWYBattle = false
	self._runLength = 0
	self._wyrunLength = 0
	self._currBgIndex = 1
	self._lastHitItem = false
	self._isStopMove = false
	self._isInWYBattle = false
	self._hasPlayWarning = false
	self._closeWinState = false
	self._currHitMaxIndex = 0
	self._isGoingToWY = false
	self._wyFinalBattlePosx = 500
	self._fbbMoveToWy_Time = 3
	self._delayCreatItemList = {}
	self._isHitRecordIds = {
		{},
		{},
		{}
	}
	self._totalRunLength = #self._moveDataList[1] * self._itemSpace + self._itemSpaceOffset
end

function SKTgameView:_initMoveItems()
	local count = 15

	self._dataIndex1 = count
	self._dataIndex2 = count
	self._dataIndex3 = count
	self._dataIndex1Max = count
	self._dataIndex2Max = count
	self._dataIndex3Max = count

	for i, list in ipairs(self._moveDataList) do
		if i == LineEnum.Up then
			self._dataIndex3Max = #list
		elseif i == LineEnum.Mid then
			self._dataIndex2Max = #list
		elseif i == LineEnum.Down then
			self._dataIndex1Max = #list
		end

		for j, v in ipairs(list) do
			if j >= self._dataIndex1 then
				break
			end

			local item = self._moveItemPool:fetchObject()

			goutil.setActive(item.gameObject, true)

			item.lineType = i
			item.index = j

			self:_setItemPos(item)
			self:_setItemOnEnter(item)
			table.insert(self._moveItems, item)
		end
	end
end

function SKTgameView:_setPlayerPos()
	self._fbbPlayerClass:setAnchoredPos(155, (self._currPlayerLineType - 2) * self._lineSpace)
end

function SKTgameView:_setItemPos(item)
	local x = (item.index - 1) * self._itemSpace - self._runLength + self._itemSpaceOffset
	local y = (item.lineType - 2) * self._lineSpace

	Framework.TransformUtil.SetAnchoredPos(item.transform, x, y)

	return x, y
end

function SKTgameView:_start()
	self._isStopMove = false
	self._isPause = false

	RoleObjectPool.instance:playAnimation(self._fbbRoleGo, "idle2", true)
	settimer(0, self._update, self, true)
end

function SKTgameView:_pause(closeWinState)
	self._isPause = true
	self._closeWinState = closeWinState
end

function SKTgameView:_resume()
	self._isPause = false
	self._closeWinState = false
end

function SKTgameView:_stop()
	self._isStopMove = true

	removetimer(self._update, self)
end

local deltaTime

function SKTgameView:_update()
	deltaTime = Time.deltaTime

	if self._isStopMove then
		return
	end

	if self._closeWinState then
		return
	end

	self._wyrunLength = self._wyrunLength + deltaTime * self._wy_playspeed

	self:_setWYHeadPos()

	if self._isPause then
		return
	end

	if not self._moveItems and #self._moveItems <= 0 then
		return
	end

	self._playTime = self._playTime + deltaTime

	self:_setCurrSceneMoveSpeed()

	self._runLength = self._runLength + deltaTime * self:_getCurrSceneMoveSpeed()

	self._fbbPlayerClass:update(deltaTime)
	self._wyPlayerClass:update(deltaTime)
	self:_itemsMove()
	self:_checkHit()
	self:_bgMove()
	self:_setFBBHeadPos()
end

local posx, posy = 0, 0

function SKTgameView:_itemsMove()
	for k, item in pairs(self._moveItems) do
		posx = self:_setItemPos(item)

		if posx <= -self._itemSpace then
			table.remove(self._moveItems, k)
			self:_creatNextItem(item)
		end
	end
end

function SKTgameView:_creatNextItem(item)
	local lineType = item.lineType
	local index = 0

	if lineType == LineEnum.Down then
		self._dataIndex1 = self._dataIndex1 + 1
		index = self._dataIndex1
	elseif lineType == LineEnum.Mid then
		self._dataIndex2 = self._dataIndex2 + 1
		index = self._dataIndex2
	elseif lineType == LineEnum.Up then
		self._dataIndex3 = self._dataIndex3 + 1
		index = self._dataIndex3
	end

	item.class:reset()

	if not _isInWYBattle and self._moveDataList[lineType][index] then
		item.index = index

		goutil.setActive(item.gameObject, true)
		self:_setItemPos(item)
		self:_setItemOnEnter(item)
		table.insert(self._moveItems, item)
	else
		self._moveItemPool:returnObject(item)
	end
end

function SKTgameView:_delayCreatNextItem(hitItem)
	table.insert(self._delayCreatItemList, hitItem)
	goutil.setActive(hitItem.gameObject, false)
	Framework.TransformUtil.SetAnchoredPos(hitItem.transform, 10000, 0)
	settimer(0.2, self._checkHasDelayAndDoCreatNextItem, self, true)
end

function SKTgameView:_checkHasDelayAndDoCreatNextItem()
	if #self._delayCreatItemList > 0 then
		local hitItem = table.remove(self._delayCreatItemList)

		if hitItem then
			self:_creatNextItem(hitItem)
		end
	else
		removetimer(self._checkHasDelayAndDoCreatNextItem, self)
	end
end

function SKTgameView:_isMaxSlot()
	return self._runLength >= self._battleSlotIndex * self._itemSpace
end

function SKTgameView:_isWarnningSlot()
	return self._runLength >= self._warinning_tip_slot * self._itemSpace
end

function SKTgameView:_setItemOnEnter(item)
	local lineType, index = item.lineType, item.index
	local cfgId = self._moveDataList[lineType][index]

	if cfgId then
		item.gameObject.name = "item_" .. lineType .. "_" .. index

		item.class:onEnter(cfgId)
	end
end

function SKTgameView:_checkHit()
	local pposx = self._fbbPlayerClass:getScreenPosX()
	local pradius = self._fbbPlayerClass:getRadius()
	local hitItem = false
	local class = false

	for k, v in pairs(self._moveItems) do
		class = v.class

		if self._currPlayerLineType == v.lineType and not class:hasBeenHit() and v.index - self._currHitMaxIndex <= 2 and not self._isHitRecordIds[v.lineType][v.index] then
			local posx = class:getScreenPosX()
			local radius = class:getRadius()

			if math.pow(pposx - posx, 2) <= math.pow(pradius + radius - 20, 2) then
				table.remove(self._moveItems, k)

				hitItem = v
				self._isHitRecordIds[v.lineType][v.index] = true

				break
			end
		end
	end

	self._currOutHitItem = hitItem

	if self:_isMaxSlot() then
		self._needIntoWYBattle = true
	end

	if self:_isWarnningSlot() and not self._hasPlayWarning then
		self:_playWarning()
	end

	if hitItem then
		self._currHitMaxIndex = math.max(self._currHitMaxIndex, hitItem.index)

		hitItem.class:setIsHit()
	end

	if hitItem then
		if hitItem.class:isEmptySlot() then
			self:_creatNextItem(hitItem)
		elseif hitItem.class:getSlotType() == GameEnum.FBBSlotType.Scoop then
			self:_gotoEatScoreItem(hitItem)
			AudioPlayerEx.instance:playEffect(30501)
		elseif hitItem.class:getSlotType() == GameEnum.FBBSlotType.JL then
			self:_pause()
			self:_JLBattle()
		end
	elseif self._needIntoWYBattle and not self._isGoingToWY then
		self:_gotoWYBattle()
	elseif hitItem then
		printInfo("===被移除抛弃", hitItem.lineType, hitItem.index, hitItem.class:getSlotType(), hitItem.class:isEmptySlot())
	end
end

function SKTgameView:_JLBattle()
	self._playCanMoveLine = false

	local class = self._currOutHitItem.class
	local hp = class:getHP()

	if hp <= 0 then
		self:_retrurnOutHitItemToPool()

		self._playCanMoveLine = true

		self:_resume()

		if self._needIntoWYBattle then
			self:_gotoWYBattle()
		end
	else
		self:_calBattleData(class:getScreenPosX(), class:getHP())

		local function hitOnecCallBack()
			local oneHitReduceHp = self._battleData.oneHitReduceHp
			local realReduceHP1 = oneHitReduceHp >= class:getHP() and class:getHP() or oneHitReduceHp
			local realReduceHP2 = oneHitReduceHp >= self._fbbPlayerClass:getHP() and self._fbbPlayerClass:getHP() or oneHitReduceHp
			local reduceHP = math.min(realReduceHP1, realReduceHP2)

			class:reduceHP(reduceHP)
			class:creatShakeTween(0.1)
			self._fbbPlayerClass:reduceHP(reduceHP)
		end

		local function hitFinishCallBack()
			settimer(0.2, self._delayDoHitFinish, self, false)
		end

		self:_onBattle(hitOnecCallBack, hitFinishCallBack)
	end
end

function SKTgameView:_delayDoHitFinish()
	self._playCanMoveLine = true

	if not self._closeWinState then
		self:_resume()
	end

	self:_setPlayerPos()

	if self._needIntoWYBattle then
		self:_gotoWYBattle()
	end

	if self._fbbPlayerClass:getHP() <= 0 then
		self:_retrurnOutHitItemToPool()
		self:_gameOver()

		return
	end

	if self._isStopMove then
		self:_retrurnOutHitItemToPool()

		return
	end

	if self._currOutHitItem and self._currOutHitItem.class:getHP() <= 0 then
		self:_delayCreatNextItem(self._currOutHitItem)

		self._currOutHitItem = nil
	end
end

function SKTgameView:_calBattleData(targetCurPosX, targetHP)
	local oneHitReduceHp = self:_getOneHitReduceHp()
	local totalHitTime = math.min(math.ceil(self._fbbPlayerClass:getHP() / oneHitReduceHp), math.ceil(targetHP / oneHitReduceHp))
	local fbbPosx = self._fbbPlayerClass:getScreenPosX()
	local offsetx1 = fbbPosx - 60
	local offsetx2 = targetCurPosX - 80
	local offsetx3 = fbbPosx

	self._battleData = {
		posList = {
			{
				duration = 0.1,
				offsetx = offsetx1
			},
			{
				duration = 0.2,
				offsetx = offsetx2
			},
			{
				duration = 0.1,
				offsetx = offsetx3
			}
		},
		totalHitTime = totalHitTime,
		oneHitReduceHp = oneHitReduceHp
	}
end

function SKTgameView:_onBattle(hitCallBack, hitFinishCallBack)
	local tweenIndex = 0
	local tweenCount = self._battleData.totalHitTime

	self._fbbPlayerClass:enterBattle()

	local doFbbTween

	function doFbbTween()
		tweenIndex = tweenIndex + 1

		if tweenIndex == 3 then
			AudioPlayerEx.instance:playEffect(30502)
			hitCallBack()

			tweenCount = tweenCount - 1

			if tweenCount <= 0 then
				self._fbbPlayerClass:exitBattle()
				hitFinishCallBack()

				return
			end

			tweenIndex = 1
		end

		self._fbbPlayerClass:setTweenYOffset(0)

		local tween = self._fbbPlayerClass:createTween(self._battleData.posList[tweenIndex].duration, self._battleData.posList[tweenIndex].offsetx)

		tween:AddListener(function()
			tween:RemoveListener()
			doFbbTween()
		end)
		tween:Begin()
	end

	doFbbTween()
end

function SKTgameView:_gameOver()
	self._fbbPlayerClass:exitBattle()
	self:_stop()
	SaintKnightTianController.instance:settleGame(self._fbbPlayerClass:getHP())
	goutil.setActive(self._maskGo, true)

	if self._fbbPlayerClass:getHP() == 0 then
		local function okFunc()
			UIStateManager.instance:popByName(ViewName.SKTgameView)
		end

		local title = lang("挑战失败")
		local content = lang("saintknighttiangameTips")
		local okBtnStr = lang("知道了")

		UIStateManager.instance:push(ViewName.FbbgametipView, title, content, okFunc, nil, okBtnStr, "")
	else
		settimer(1, self.close, self, false)
	end
end

function SKTgameView:_gotoWYBattle()
	self._isGoingToWY = true

	self:_wyMoveToScene()
	self:_fbbMoveToWy()
end

function SKTgameView:_playWarning()
	AudioPlayerEx.instance:playEffect(30503)

	self._hasPlayWarning = true
	self._playCanMoveLine = false
	self._currPlayerLineType = LineEnum.Mid

	self:_setPlayerPos()
	goutil.setActive(self._btnDown.gameObject, false)
	goutil.setActive(self._btnUp.gameObject, false)
	goutil.setActive(self._warningTipGo, true)

	local time = SaintKnightTianConfig.instance:getDefineValue("WARNING_TIME", true)

	settimer(time, self._stopWarning, self, false)
end

function SKTgameView:_stopWarning()
	removetimer(self._stopWarning, self)
	goutil.setActive(self._warningTipGo, false)
end

function SKTgameView:_wyMoveToScene()
	goutil.setActive(self._wyPlayerGo, true)
	Framework.TransformUtil.SetLocalPos(self._wyPlayerGo.transform, self._wyFinalBattlePosx + 200, 0, 0)

	local tween = self._wyPlayerClass:createTween(self._fbbMoveToWy_Time * 0.8, self._wyFinalBattlePosx)

	tween:AddListener(function()
		return
	end)
	tween:Begin()
end

function SKTgameView:_fbbMoveToWy()
	for k, v in pairs(self._moveItems) do
		self._moveItemPool:returnObject(v)
	end

	local wyPosX = self._wyFinalBattlePosx
	local fbbNextPosX = wyPosX - self._wyPlayerClass:getRadius() - self._fbbPlayerClass:getRadius() - 50
	local fbbPosX = self._fbbPlayerClass:getScreenPosX()

	self._fbbPlayerClass:setTweenXOffset(fbbNextPosX - fbbPosX)

	local tween1 = self._fbbPlayerClass:createTween(self._fbbMoveToWy_Time)

	tween1.loopType = UnityTweens.LoopType.none

	tween1:AddListener(function()
		tween1:RemoveListener()
		self:_onWYBattle()
	end)
	tween1:Begin()
end

function SKTgameView:_onWYBattle()
	self:_stop()
	self:_setFBBHeadPos(true)
	self:_setWYHeadPos(true)

	self._isInWYBattle = true

	self:_calBattleData(self._wyPlayerClass:getScreenPosX(), self._wyPlayerClass:getHP())

	local function hitOnecCallBack()
		local oneHitReduceHp = self._battleData.oneHitReduceHp
		local realReduceHP1 = oneHitReduceHp >= self._wyPlayerClass:getHP() and self._wyPlayerClass:getHP() or oneHitReduceHp
		local realReduceHP2 = oneHitReduceHp >= self._fbbPlayerClass:getHP() and self._fbbPlayerClass:getHP() or oneHitReduceHp
		local reduceHP = math.min(realReduceHP1, realReduceHP2)

		self._wyPlayerClass:reduceHP(reduceHP)
		self._wyPlayerClass:creatShakeTween(0.1)
		self._fbbPlayerClass:reduceHP(reduceHP)
	end

	local function hitFinishCallBack()
		if self._fbbPlayerClass:getHP() <= 0 or self._wyPlayerClass:getHP() <= 0 then
			self:_gameOver()
		end
	end

	self:_onBattle(hitOnecCallBack, hitFinishCallBack)
end

function SKTgameView:_gotoEatScoreItem(hitItem)
	local duration = 0.2
	local class = hitItem.class
	local posx1 = class:getScreenPosX()
	local fbbposx = self._fbbPlayerClass:getScreenPosX()
	local offsetx = -math.abs(fbbposx - posx1)

	class:setTweenXOffset(offsetx)
	class:setTweenYOffset(-50)

	local tweenScale = class:createScaleTween(duration)
	local tween = class:createTween(duration)

	tween.loopType = UnityTweens.LoopType.none

	tweenScale:AddListener(function()
		tweenScale:RemoveListener()
		tweenScale:Stop()
		tween:Stop()
		self._fbbPlayerClass:addHP(class:getHP())
		self:_delayCreatNextItem(hitItem)
	end)
	tween:Begin()
end

function SKTgameView:_getCurrSceneMoveSpeed()
	return self._sceneMoveSpeed
end

function SKTgameView:_setCurrSceneMoveSpeed()
	if self._sceneMoveSpeed >= self._sceneMoveSpeedMax then
		return self._sceneMoveSpeedMax
	end

	self._sceneMoveSpeed = self._playTime / self._into_max_speed_need_time * (self._sceneMoveSpeedMax - self._sceneMoveInitSpeed) + self._sceneMoveInitSpeed
end

function SKTgameView:_bgMove()
	local x1 = -(self._runLength % self._bgWidth)
	local x2 = -(self._runLength % self._bgWidth) + self._bgWidth

	if self._currBgIndex % 2 == 0 then
		x2 = x1
		x1 = x2
	end

	Framework.TransformUtil.SetLocalPos(self._bg1Tr, x1, 0, 0)
	Framework.TransformUtil.SetLocalPos(self._bg2Tr, x2, 0, 0)

	if x1 + self._bgWidth <= 0 or x2 + self._bgWidth <= 0 then
		self._currBgIndex = self._currBgIndex + 1
	end
end

function SKTgameView:_setFBBHeadPos(isMax)
	local ratio = 1

	if not isMax and not self._isStopMove then
		ratio = self._runLength / self._totalRunLength
	end

	ratio = math.min(1, ratio)

	Framework.TransformUtil.SetAnchoredPos(self._fbbHeadTr, ratio * self._progressWidth, 5)
end

function SKTgameView:_setWYHeadPos(isMax)
	local ratio = 1

	if not isMax and not self._isStopMove then
		ratio = self._wyrunLength / self._totalRunLength + self._wyHeadPosInitRatio
	end

	ratio = math.min(1, ratio)

	Framework.TransformUtil.SetAnchoredPos(self._wyHeadTr, ratio * self._progressWidth, 5)
end

function SKTgameView:_endGameRes()
	return
end

function SKTgameView:_getOneHitReduceHp()
	local reduceHP = math.ceil(self._fbbPlayerClass:getHP() * self._every_hit_reduce_hp_ratio)

	if reduceHP <= 0 then
		return 1
	else
		return reduceHP
	end
end

function SKTgameView:_retrurnOutHitItemToPool()
	if self._currOutHitItem then
		self._moveItemPool:returnObject(self._currOutHitItem)

		self._currOutHitItem = nil
	end
end

function SKTgameView:_loadRoles()
	if not self._fbbRoleGo then
		local go = self:getResInstance(SKTgameViewPresentor.FBBCharacterPath)

		self._fbbRoleGo = go

		if go then
			local tr = go.transform
			local scale = 0.25

			tr:SetParent(self._fbbRoleCon)
			Framework.TransformUtil.SetLocalPos(tr, 0, -73, 0)
			Framework.TransformUtil.SetLocalScale(tr, scale, scale, scale)
			Framework.TransformUtil.SetLocalRotation(tr, 0, 0, 0)
		end
	end

	RoleObjectPool.instance:playAnimation(self._fbbRoleGo, "idle", true)
end

return SKTgameView
