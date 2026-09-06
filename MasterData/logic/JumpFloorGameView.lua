-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/JumpFloorGameView.lua

module("logic.extensions.jumpfloor.view.JumpFloorGameView", package.seeall)

local JumpFloorGameView = class("JumpFloorGameView", ViewComponent)
local ShowUpCellFloor = 12
local ShowDownCellFloor = 6

function JumpFloorGameView:ctor()
	JumpFloorGameView.super.ctor(self)

	self._baseJumpFloorGame = nil
	self._levelJumpFloorGame = LevelJumpFloorGame.New()
	self._endlessJumpFloorGame = EndlessJumpFloorGame.New()
	self._floorCellPool = self:_initFloorCellPool()
end

function JumpFloorGameView:buildUI()
	JumpFloorGameView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnBeginGame = self:getBtn("beginGame")
	self._btnLeft = self:getBtn("main/btnLeft")
	self._btnRight = self:getBtn("main/btnRight")
	self._txtCountdown = self:getTxt("countdown/txtTime")
	self._slider = self:getSlider("slider")
	self._txtLeftNum = self:getTxt("slider/txtNum")
	self._endlessNum = self:getGo("endlessNum")
	self._txtEndlessNum = self:getTxt("endlessNum/txtEndlessNum")
	self._moveRoot = self:getGo("main/cellArea/moveRoot")
	self._moveRootRect = self._moveRoot:GetComponent(goutil.Type_RectTransform)
	self._targetPosRect = self:getGo("main/cellArea/targetPos"):GetComponent(goutil.Type_RectTransform)
	self._targetPosRect2 = self:getGo("main/cellArea/moveRoot/targetPos2"):GetComponent(goutil.Type_RectTransform)
	self._floorCellGo = self:getGo("main/cellArea/floorcell")
	self._emptyFloorCellGo = self:getGo("main/cellArea/moveRoot/emptyfloorcell")
	self._roleCell = RoleCell.New(self:getGo("main/cellArea/moveRoot/rolecell"))

	goutil.setActive(self._floorCellGo, false)

	self._effectParent = self:getGo("main/cellArea/moveRoot/effect")
end

function JumpFloorGameView:bindEvents()
	JumpFloorGameView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnBeginGame:AddClickListener(self._onClickBeginGame, self)
	self._btnLeft:AddClickListener(self._onClickLeft, self)
	self._btnRight:AddClickListener(self._onClickRight, self)
end

function JumpFloorGameView:unbindEvents()
	JumpFloorGameView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnBeginGame:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function JumpFloorGameView:onEnter()
	JumpFloorGameView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.RULES_VIEW_EXIT, self._onRuleViewExit, self)
	GlobalDispatcher:addListener(GlobalNotify.DancingLionJumpGameStartRes, self._onGameStartRes, self)

	self._params = self:getOpenParam()
	self._gameMode = self._params[1]
	self._activityId = self._params[2]
	self._stagePlanId = self._params[3]
	self._stageId = self._params[4] or 0
	self._finishCallBack = self._params[5]
	self._clientKey = self:_getRandomNum()
	self._serverKey = 0
	self._floorCellList = {}
	self._floorCellDic = {}
	self._delCellList = {}
	self._addCellList = {}
	self._curCellData = nil
	self._curFloorCell = nil
	self._isFinishGame = false
	self._isCanClick = true

	self:_initGameObjectState()
	self:_initGame()
	settimer(0.2, self._onUpdate, self)
end

function JumpFloorGameView:onExit()
	JumpFloorGameView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RULES_VIEW_EXIT, self._onRuleViewExit, self)
	GlobalDispatcher:removeListener(GlobalNotify.DancingLionJumpGameStartRes, self._onGameStartRes, self)
	self._baseJumpFloorGame:removeListener(BaseJumpFloorGame.UpdateStageMap, self._updateStageMap, self)
	self._baseJumpFloorGame:removeListener(BaseJumpFloorGame.UpdateShield, self._updateShield, self)
	self._baseJumpFloorGame:removeListener(BaseJumpFloorGame.TriggerTrap, self._onTriggerTrap, self)
	self._baseJumpFloorGame:reset()
	self:_recycleFloorCells()
	self:_clearTweens()
	self:_clearFloorCellDic()
	self._roleCell:reset()
	removetimer(self._onUpdate, self)
end

function JumpFloorGameView:_onUpdate()
	self._txtCountdown.text = string.format("<color=#FFB537>%d</color>%s", Mathf.Ceil(self._baseJumpFloorGame:getCountdown()), lang("tip_second"))
	self._txtLeftNum.text = string.format("距离终点\n<color=#E6B24A>%d</color>木桩", self._baseJumpFloorGame:getLeftFloors())

	local value = self._baseJumpFloorGame:getCurPassFloors() / self._baseJumpFloorGame:getMaxFloors()

	self._slider:SetValue(value)

	if self._gameMode == JumpFloorModel.EndlessMode then
		self._txtEndlessNum.text = string.format("<color=#E6B24A>%d</color>个木桩", self._baseJumpFloorGame:getCurPassFloors())
	end

	if self._baseJumpFloorGame:getCountdown() <= 0 then
		self:_onGameOver()
	end
end

function JumpFloorGameView:_onClickClose()
	self._baseJumpFloorGame:pause()

	local text = string.format("当前通过%d层，是否退出游戏？", self._baseJumpFloorGame:getCurPassFloors())

	local function okFunc()
		self._baseJumpFloorGame:forceEnd()
		self:_onGameOver()
	end

	local function cancelFunc()
		self._baseJumpFloorGame:playFromPause()
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc, cancelFunc)
end

function JumpFloorGameView:_onClickTip()
	self._baseJumpFloorGame:pause()
	UIStateManager.instance:push(ViewName.RulesView, "jumpfloorgameview")
end

function JumpFloorGameView:_onClickBeginGame()
	if self._gameMode == JumpFloorModel.LevelMode then
		if self._activityId > 0 then
			JumpFloorController.instance:sendLevelGameStartReq(self._activityId, self._stageId, self._clientKey)
		else
			self:_startGame()
		end
	elseif self._activityId > 0 then
		JumpFloorController.instance:sendEndlessGameStartReq(self._activityId, self._clientKey)
	else
		self:_startGame()
	end
end

function JumpFloorGameView:_onClickLeft()
	if not self._isCanClick then
		printInfo("test 不可点击")

		return
	end

	self._baseJumpFloorGame:jumpLeft()
	self:_updateStageMap()
end

function JumpFloorGameView:_onClickRight()
	if not self._isCanClick then
		printInfo("test 不可点击")

		return
	end

	self._baseJumpFloorGame:jumpRight()
	self:_updateStageMap()
end

function JumpFloorGameView:_onRuleViewExit()
	self._baseJumpFloorGame:playFromPause()
end

function JumpFloorGameView:_onGameStartRes(isSuccessStart, serverKey)
	if isSuccessStart then
		self._serverKey = serverKey

		self:_startGame()
	else
		TipsFacade.instance:openTipWindowNoX(lang("tip"), "小游戏不在活动时间", function()
			local isPass = false
			local passFloors = self._baseJumpFloorGame:getCurPassFloors()

			self:_doFinfishCallBack(isPass, passFloors)
			self:close()
		end, "知道了")
	end
end

function JumpFloorGameView:_startGame()
	goutil.setActive(self._btnBeginGame.gameObject, false)
	self._baseJumpFloorGame:play()
end

function JumpFloorGameView:_initGame()
	if self._gameMode == JumpFloorModel.LevelMode then
		goutil.setActive(self._slider.gameObject, true)
		goutil.setActive(self._endlessNum, false)

		self._baseJumpFloorGame = self._levelJumpFloorGame

		local cfg = JumpFloorConfig.instance:getStageById(self._stagePlanId, self._stageId)

		self._baseJumpFloorGame:init(cfg.stageJsonData, cfg.limitTime)
	else
		goutil.setActive(self._slider.gameObject, false)
		goutil.setActive(self._endlessNum, true)

		self._baseJumpFloorGame = self._endlessJumpFloorGame

		local countdown = 120

		self._baseJumpFloorGame:init(self:getJsonDataList(), countdown)
	end

	self._baseJumpFloorGame:addListener(BaseJumpFloorGame.UpdateStageMap, self._updateStageMap, self)
	self._baseJumpFloorGame:addListener(BaseJumpFloorGame.UpdateShield, self._updateShield, self)
	self._baseJumpFloorGame:addListener(BaseJumpFloorGame.TriggerTrap, self._onTriggerTrap, self)
	self:_initStageMap()
end

function JumpFloorGameView:getJsonDataList()
	local cfgList = JumpFloorConfig.instance:getEndlessList()
	local jsonDataList = {}

	for i, v in ipairs(cfgList) do
		table.insert(jsonDataList, v.stageJsonData)
	end

	return jsonDataList
end

function JumpFloorGameView:_getRandomNum()
	math.randomseed(os.time())

	local num = math.random(1, 10000000)

	printInfo("test 随机数", num)

	return num
end

function JumpFloorGameView:_initGameObjectState()
	goutil.setActive(self._btnBeginGame.gameObject, true)
end

function JumpFloorGameView:_initFloorCellPool()
	local function createFunc()
		local go = goutil.cloneAndSetParent(self._floorCellGo, self._moveRoot.transform, "floorcell")

		goutil.setActive(go, true)

		return go
	end

	local function disposeFunc(go)
		goutil.clearChildren(go)
	end

	local function resetFunc(go)
		goutil.setActive(go, false)

		go.name = go.name .. "(recycle)"
	end

	return ObjectPool.New(30, createFunc, disposeFunc, resetFunc)
end

function JumpFloorGameView:_initStageMap()
	self._curCellData = self._baseJumpFloorGame:getCurCellData()

	local jumpFloorCellDataList = self._baseJumpFloorGame:getCellDatas()

	for i, v in ipairs(jumpFloorCellDataList) do
		if v:getCol() <= ShowUpCellFloor then
			local go = self._floorCellPool:fetchObject()

			goutil.setActive(go, true)

			go.name = string.format("floorcell_%d_%d_%d", v:getCol(), v:getRow(), v:getIndex())

			go.transform:SetAsFirstSibling()

			local floorCell = GameUtil.AddLuaOnce(go, FloorCell)

			floorCell:init(v)
			table.insert(self._floorCellList, floorCell)
			self:_addFloorCellDic(floorCell)

			if self._curCellData == v then
				self._curFloorCell = floorCell
			end
		end
	end

	self:_initRoleCell()
end

function JumpFloorGameView:_addFloorCellDic(floorCell)
	self._floorCellDic[floorCell:getCol()] = self._floorCellDic[floorCell:getCol()] or {}
	self._floorCellDic[floorCell:getCol()][floorCell:getRow()] = floorCell
end

function JumpFloorGameView:_removeFloorCellDic(floorCell)
	if self._floorCellDic[floorCell:getCol()] then
		self._floorCellDic[floorCell:getCol()][floorCell:getRow()] = nil
	end
end

function JumpFloorGameView:_getFloorCell(col, row)
	if self._floorCellDic[col] then
		return self._floorCellDic[col][row]
	end
end

function JumpFloorGameView:_clearFloorCellDic()
	table.clear(self._floorCellDic)
end

function JumpFloorGameView:_updateStageMap()
	self._isCanClick = false
	self._curCellData = self._baseJumpFloorGame:getCurCellData()

	if self._curCellData:getCellType() ~= JumpFloorCellData.ECellType.Empty then
		local curCol = self._curCellData:getCol()
		local startFloor = Mathf.Max(1, curCol - ShowDownCellFloor)
		local endFloor = Mathf.Min(self._baseJumpFloorGame:getDestinationFloorCol(), curCol - 1 + ShowUpCellFloor)
		local maxFloor = curCol
		local minFloor = curCol

		table.clear(self._delCellList)

		local oldFloorDic = {}

		for i, v in ipairs(self._floorCellList) do
			maxFloor = Mathf.Max(maxFloor, v:getCol())
			minFloor = Mathf.Min(minFloor, v:getCol())

			if startFloor > v:getCol() or endFloor < v:getCol() then
				table.insert(self._delCellList, v)
			else
				oldFloorDic[v:getCol()] = true
			end
		end

		table.clear(self._addCellList)

		for i = startFloor, endFloor do
			if not oldFloorDic[i] then
				local rowCellList = self._baseJumpFloorGame:getCellDatasByCol(i)

				for i, v in ipairs(rowCellList) do
					local go = self._floorCellPool:fetchObject()

					goutil.setActive(go, true)
					go.transform:SetAsFirstSibling()

					go.name = string.format("floorcell_%d_%d_%d", v:getCol(), v:getRow(), v:getIndex())

					local floorCell = GameUtil.AddLuaOnce(go, FloorCell)

					floorCell:init(v, self._gameMode)
					table.insert(self._floorCellList, floorCell)
					table.insert(self._addCellList, floorCell)
					self:_addFloorCellDic(floorCell)
				end
			end
		end

		self:_updateCurFloorCell()
		self:_updateRoleCellAnimation()
		self:_updateCellAnimation()
		self:_onCompleteAnimation()
	else
		self:_updateCurFloorCell(true)
		self:_updateRoleCellAnimation(true)
		self:_onCompleteAnimation(true)
	end
end

function JumpFloorGameView:_updateCurFloorCell(isEmptyCell)
	if isEmptyCell then
		local emptyFloorCell = GameUtil.AddLuaOnce(self._emptyFloorCellGo, EmptyFloorCell)

		emptyFloorCell:init(self._curCellData)

		self._curFloorCell = emptyFloorCell
	else
		for i, v in ipairs(self._floorCellList) do
			if v:isDataEqual(self._curCellData) then
				self._curFloorCell = v

				break
			end
		end
	end
end

function JumpFloorGameView:_updateShield(isShow)
	self._roleCell:setShieldActive(isShow)
end

function JumpFloorGameView:_initRoleCell()
	self._roleCell:reset()

	self._moveRootRect.anchoredPosition = self._targetPosRect.anchoredPosition

	self._roleCell:setAnchoredPosition(self._curFloorCell:getAnchoredPosition())
end

function JumpFloorGameView:_playEffect(localPos)
	if goutil.isNil(self._moveRoot) then
		return
	end

	local eff = UIEffectManager.instance:playEffectBrief(self, "20230120/kaizhuangqiwu/fx_ui_kzqw_yanwu.prefab", self._moveRoot.transform, false)

	eff:setParent(self._moveRoot.transform)
	eff:setLocalPos(localPos.x + 10, localPos.y + 80, localPos.z)
	eff:setScale(1)
end

function JumpFloorGameView:_updateRoleCellAnimation(isEmptyCell)
	if not isEmptyCell then
		local cellDataList = self._baseJumpFloorGame:getStepCellDataList()
		local isSingleStep = #cellDataList == 0

		if isSingleStep then
			local duration = BaseJumpFloorGame.AnimationTime
			local heightY = Mathf.Max(self._roleCell:getAnchoredPosition().y, self._curFloorCell:getAnchoredPosition().y)
			local tween1, tween2, tween3 = self._roleCell:doJumpAnchorPos(self._curFloorCell:getAnchoredPosition(), duration, heightY)
			local targetMovePos = self._moveRootRect.position + (self._targetPosRect.position - self._curFloorCell:getMainGo().transform.position)

			self._moveRootTween = self._moveRootRect:DOMove(targetMovePos, duration)

			tween3:OnComplete(function()
				self:_playEffect(self._roleCell:getLocalPosition())
				self:_onGameOver()
			end)
		else
			local sequence = DG.Tweening.DOTween.Sequence()
			local floorCellList = self:_getFloorCellListByCellDataList(cellDataList)

			TimeCheck.instance:recordStartTime()

			local targetMovePos = self._moveRootRect.anchoredPosition

			for i, v in ipairs(floorCellList) do
				local heightY = 0

				if i == 1 then
					heightY = Mathf.Max(self._roleCell:getAnchoredPosition().y, v:getAnchoredPosition().y)
					targetMovePos = targetMovePos + self._roleCell:getAnchoredPosition() - v:getAnchoredPosition()
				else
					heightY = Mathf.Max(floorCellList[i - 1]:getAnchoredPosition().y, v:getAnchoredPosition().y)
					targetMovePos = targetMovePos + floorCellList[i - 1]:getAnchoredPosition() - v:getAnchoredPosition()
				end

				local tweener1, tweener1_2, tweener1_3 = self._roleCell:doJumpAnchorPos(v:getAnchoredPosition(), BaseJumpFloorGame.AnimationTime, heightY)

				sequence:Append(tweener1)
				sequence:Join(tweener1_2)
				sequence:Join(tweener1_3)

				local tweener2 = self._moveRootRect:DOAnchorPos(targetMovePos, BaseJumpFloorGame.AnimationTime)

				sequence:Join(tweener2)
			end

			self._sequenceTween = sequence

			self._sequenceTween:OnComplete(function()
				self:_playEffect(self._roleCell:getLocalPosition())
				self:_onGameOver()
			end)
		end
	else
		local duration = BaseJumpFloorGame.AnimationTime
		local heightY = Mathf.Max(self._roleCell:getAnchoredPosition().y, self._curFloorCell:getAnchoredPosition().y)

		self._roleCell:doJumpAnchorPos(self._curFloorCell:getAnchoredPosition(), duration, heightY)
		self._roleCell:onJumpAnchorComplete()

		self._emptyTween = TweenUtil.DoDelay(duration + BaseJumpFloorGame.DropTime, function()
			self:_onGameOver()
		end)
	end
end

function JumpFloorGameView:_getFloorCellListByCellDataList(cellDataList)
	local floorCellList = {}

	for i, v in ipairs(cellDataList) do
		local floorCell = self:_getFloorCell(v:getCol(), v:getRow())

		if floorCell then
			table.insert(floorCellList, floorCell)
		end
	end

	return floorCellList
end

function JumpFloorGameView:_onCompleteAnimation(isEmptyCell)
	if not isEmptyCell then
		self._curFloorCell:clearBuff()
		self:_recycleDelFloorCells()
	end
end

function JumpFloorGameView:_updateCellAnimation()
	for i, v in ipairs(self._delCellList) do
		v:doDelAnimation()
	end

	for i, v in ipairs(self._addCellList) do
		v:doAddAnimation()
	end

	table.clear(self._addCellList)
end

function JumpFloorGameView:_sendEndGameReq()
	if self._activityId <= 0 then
		return
	end

	local activityId = self._activityId
	local stageId = self._stageId
	local result = self._baseJumpFloorGame:getCurPassFloors()
	local clientEncryptedKey = GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, {
		activityId,
		stageId,
		result
	})

	JumpFloorAgent.instance:sendPM_DancingLionJumpGameEndReq(result, clientEncryptedKey)
end

function JumpFloorGameView:_getPopupStr(isSuccess, gameMode)
	if isSuccess then
		if gameMode == JumpFloorModel.LevelMode then
			return string.format("恭喜你，成功跳跃过了%d个木桩，通过本关！", self._baseJumpFloorGame:getCurPassFloors())
		else
			return string.format("恭喜你，成功跳跃过了%d个木桩！", self._baseJumpFloorGame:getCurPassFloors())
		end
	elseif gameMode == JumpFloorModel.LevelMode then
		return string.format("很遗憾，你没有跳过所有的木桩，当前已跃过%d个木桩，再来一次吧！", self._baseJumpFloorGame:getCurPassFloors())
	else
		return string.format("恭喜你，成功跳跃过了%d个木桩！", self._baseJumpFloorGame:getCurPassFloors())
	end
end

function JumpFloorGameView:_onGameOver()
	local curCol = self._curCellData:getCol()

	if curCol == self._baseJumpFloorGame:getDestinationFloorCol() then
		self._baseJumpFloorGame:gameEnd()
		removetimer(self._onUpdate, self)

		local str = self:_getPopupStr(true, self._gameMode)

		self:_showPopupView(str)

		return
	end

	if self._curCellData:getCellType() == JumpFloorCellData.ECellType.Empty then
		self._baseJumpFloorGame:gameEnd()
		removetimer(self._onUpdate, self)

		local str = self:_getPopupStr(false, self._gameMode)

		self:_showPopupView(str)

		return
	end

	if self._baseJumpFloorGame:getCountdown() <= 0 then
		self._baseJumpFloorGame:gameEnd()
		removetimer(self._onUpdate, self)

		local str = self:_getPopupStr(false, self._gameMode)

		self:_showPopupView(str)

		return
	end

	if self._baseJumpFloorGame:isForceEnd() then
		self._baseJumpFloorGame:gameEnd()
		removetimer(self._onUpdate, self)
		self:_sendEndGameReq()

		local isPass = true
		local passFloors = self._baseJumpFloorGame:getCurPassFloors()

		self:_doFinfishCallBack(isPass, passFloors)
		self:close()

		return
	end

	self._isCanClick = true

	self._baseJumpFloorGame:handleBuff()
end

function JumpFloorGameView:_onTriggerTrap()
	self._baseJumpFloorGame:gameEnd()
	removetimer(self._onUpdate, self)

	local function onComplete()
		self:_showPopupView(self._gameMode == JumpFloorModel.LevelMode and string.format("很遗憾，你没有跳过所有的木桩，当前已跃过%d个木桩，再来一次吧！", self._baseJumpFloorGame:getCurPassFloors()) or string.format("恭喜你，成功跳跃过了%d个木桩！", self._baseJumpFloorGame:getCurPassFloors()))
	end

	self._roleCell:doTweenOnDead(onComplete)
end

function JumpFloorGameView:_showPopupView(text, callback)
	local isPass = true
	local passFloors = self._baseJumpFloorGame:getCurPassFloors()

	self:_sendEndGameReq()
	TipsFacade.instance:openTipWindowNoX(lang("tip"), text, function()
		self:close()
		GameUtil.callBack(callback)
		self:_doFinfishCallBack(isPass, passFloors)
	end)
end

function JumpFloorGameView:_doFinfishCallBack(isPass, passFloors)
	local info = {}

	info.isPass = isPass
	info.gameScore = passFloors

	GameUtil.callBack(self._finishCallBack, info)
end

function JumpFloorGameView:_recycleDelFloorCells()
	if self._delCellTween then
		self._delCellTween:Kill()

		self._delCellTween = nil
	end

	self._delCellTween = TweenUtil.DoDelay(BaseJumpFloorGame.AnimationTime, function()
		for i, v in ipairs(self._delCellList) do
			local go = v:getMainGo()

			go.name = go.name .. "(recycle)"

			self._floorCellPool:returnObject(go)
			table.removebyvalue(self._floorCellList, v)
			self:_removeFloorCellDic(v)
		end

		table.clear(self._delCellList)

		self._delCellTween = nil
	end)
end

function JumpFloorGameView:_recycleFloorCells()
	for i, v in ipairs(self._floorCellList) do
		self._floorCellPool:returnObject(v:getMainGo())
	end
end

function JumpFloorGameView:_clearTweens()
	if self._delCellTween then
		self._delCellTween:Kill()

		self._delCellTween = nil
	end

	if self._sequenceTween then
		self._sequenceTween:Kill()

		self._sequenceTween = nil
	end

	if self._emptyTween then
		self._emptyTween:Kill()

		self._emptyTween = nil
	end
end

return JumpFloorGameView
