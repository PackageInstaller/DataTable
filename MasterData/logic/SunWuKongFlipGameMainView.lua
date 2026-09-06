-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/flipgame/SunWuKongFlipGameMainView.lua

module("logic.extensions.sunwukongchallenge.view.flipgame.SunWuKongFlipGameMainView", package.seeall)

local SunWuKongFlipGameMainView = class("SunWuKongFlipGameMainView", ViewComponent)
local GameState = {
	Play = 1,
	NoStart = 0,
	End = 4,
	LevelEnd = 3,
	Stop = 2
}

function SunWuKongFlipGameMainView:ctor()
	self._cellInfos = {}
	self._curState = GameState.NoStart
	self._countDown = 0
end

function SunWuKongFlipGameMainView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._imgTitle = self:getGo("title/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self._txtScore = self:getTxt("score/txtScore")
	self._txtCountDown = self:getTxt("countDown/txtCountDown")
	self._cell = self:getGo("cell")

	self._cell:SetActive(false)

	self._container = self:getGo("container")
	self._gridLayoutGroup = self._container:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._maskGo = self:getGo("mask")
	self._btnClickStart = self:getBtn("btnClickStart")
	self._effectGo1 = self:getGo("effect1")
	self._effectGo2 = self:getGo("effect2")

	self:_resetEffectGo()
end

function SunWuKongFlipGameMainView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnClickStart:AddClickListener(self._onClickStart, self)
end

function SunWuKongFlipGameMainView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnClickStart:RemoveClickListener()
end

function SunWuKongFlipGameMainView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.SunWuKongFlipGameSelect, self._onFlipGameSelect, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SunWuKongChallengeStartGameRes, self._onStartGameRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]
	self._actCfg = SunWuKongChallengeConfig.instance:getActivityCfg(self._activityId)
	self._stageCfg = SunWuKongChallengeConfig.instance:getStageCfg(self._actCfg.stagePlanId, self._stageId)

	if checknumber(self._stageCfg.hiddenTaskId) <= 0 then
		FloatWordMgr.instance:show(lang("参数错误"))
		self:close()
	end

	self:_resetEffectGo()
	self:_loadEffect()

	self._clientKey = self:_getRandomNum()
	self._clientEncryptedKey = 0

	self:_setGameState(GameState.NoStart)
	settimer(1, self._update, self)
	SunWuKongChallengeFlipGameModel.instance:onInit()
	SunWuKongChallengeFlipGameModel.instance:setLevelList(self._stageCfg.hiddenTaskId)

	self._cellInfos = {}

	self:_initContainer()
end

function SunWuKongFlipGameMainView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.SunWuKongFlipGameSelect, self._onFlipGameSelect, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SunWuKongChallengeStartGameRes, self._onStartGameRes, self)
	removetimer(self._update, self)
	self:_clearContainer()
	self:_removeEffect()
end

function SunWuKongFlipGameMainView:_getRandomNum()
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))

	return math.random(1, 100000000)
end

function SunWuKongFlipGameMainView:_update()
	if self._curState == GameState.Play then
		self:_reduceTime()
		self:_setCountDown(self:_getCountDown())

		if self:_getCountDown() <= 0 then
			self:_setGameState(GameState.Stop)
			self:_onGameOver()
		end
	end
end

function SunWuKongFlipGameMainView:_onClickClose()
	if self._curState == GameState.NoStart then
		self:close()

		return
	else
		self:_setGameState(GameState.Stop)
	end

	local text = lang("中途退出小游戏，将不会保存进度，需要重新开始")

	local function okFunc()
		self:_setGameState(GameState.End)
		self:_onGameOver()
	end

	TipsFacade.instance:openTipWindow("提示", text, okFunc, "确定", UnityEngine.TextAnchor.MiddleCenter)
end

function SunWuKongFlipGameMainView:_onClickStart()
	printInfo("test 随机数", self._clientKey)
	SunWuKongChallengeController.instance:sendPM_SunWuKongChallengeStartGameReq(self._activityId, self._stageId)
end

function SunWuKongFlipGameMainView:_onStartGameRes()
	self:_setGameState(GameState.Play)
end

function SunWuKongFlipGameMainView:_setGameState(state)
	self._curState = state

	if state == GameState.NoStart then
		self._btnClickStart.gameObject:SetActive(true)
	else
		self._btnClickStart.gameObject:SetActive(false)
	end
end

function SunWuKongFlipGameMainView:_initContainer()
	self:_clearContainer()
	SunWuKongChallengeFlipGameModel.instance:setNextLevel()

	local row, column = SunWuKongChallengeFlipGameModel.instance:getRowAndColumnNum()

	self:_setTxtTitle(SunWuKongChallengeFlipGameModel.instance:getCurLevel())
	self:_setScore(0)
	self:_setCountDown(SunWuKongChallengeFlipGameModel.instance:getCurLevelDefaultTime())
	self:_fixRow(row)

	local totalNum = row * column

	table.clear(self._cellInfos)

	local randomList = SunWuKongChallengeFlipGameModel.instance:getRandomCardList()

	for i = 1, totalNum do
		local go = goutil.cloneAndSetParent(self._cell, self._container.transform, "cell_" .. tostring(i))

		go:SetActive(true)

		local cellInfo = GameUtil.AddLuaOnce(go, SunWuKongFlipGameItem)
		local id = randomList[i]

		cellInfo:buildUI(go)
		cellInfo:init(id, i)
		table.insert(self._cellInfos, cellInfo)
	end
end

function SunWuKongFlipGameMainView:_clearContainer()
	SunWuKongChallengeFlipGameModel.instance:clearGameState()
	self:_clearTween()
	self:_setMask(false)

	for i, v in ipairs(self._cellInfos) do
		v:reset()
	end

	table.clear(self._cellInfos)
	goutil.clearChildren(self._container)
end

function SunWuKongFlipGameMainView:_fixRow(num)
	self._gridLayoutGroup.constraintCount = num
end

function SunWuKongFlipGameMainView:_onFlipGameSelect()
	self:_clearTween()
	self:_setMask(true)

	if SunWuKongChallengeFlipGameModel.instance:isErase() then
		self:_setGameState(GameState.Stop)

		self._tweener = TweenUtil.DoDelay(0.5, function()
			self:_handleGameErase()
		end)
	elseif SunWuKongChallengeFlipGameModel.instance:isArriveMaxSelectCount() then
		self._tweener = TweenUtil.DoDelay(0.5, function()
			self:_handleGameSelect()
		end)
	else
		self:_setMask(false)
	end
end

function SunWuKongFlipGameMainView:_clearTween()
	if self._tweener then
		self._tweener:Kill()

		self._tweener = nil
	end

	if self._tweenerLevelEnd then
		self._tweenerLevelEnd:Kill()

		self._tweenerLevelEnd = nil
	end
end

function SunWuKongFlipGameMainView:_handleGameErase()
	SunWuKongChallengeFlipGameModel.instance:addGameScore()
	self:_setScore(SunWuKongChallengeFlipGameModel.instance:getGameScore())

	local list = SunWuKongChallengeFlipGameModel.instance:getSelectIndexList()

	SunWuKongChallengeFlipGameModel.instance:clearSelectState()

	local positionList = {}

	for i, v in ipairs(list) do
		if self._cellInfos[v] then
			self._cellInfos[v]:changeToEraseState()
			table.insert(positionList, self._cellInfos[v]:getPosition())
		end
	end

	self:_updateEffectPos(positionList)

	if SunWuKongChallengeFlipGameModel.instance:isArrivedMaxEraseCount() then
		self:_setGameState(GameState.LevelEnd)
		self:_onGameOver()
	else
		self:_setGameState(GameState.Play)
	end

	self:_setMask(false)
end

function SunWuKongFlipGameMainView:_handleGameSelect()
	local list = SunWuKongChallengeFlipGameModel.instance:getSelectIndexList()

	SunWuKongChallengeFlipGameModel.instance:clearSelectState()

	for i, v in ipairs(list) do
		if self._cellInfos[v] then
			self._cellInfos[v]:changeToUnSelectState()
		end
	end

	self:_setMask(false)
end

function SunWuKongFlipGameMainView:_onGameOver()
	if self._curState == GameState.End then
		SunWuKongChallengeFlipGameModel.instance:addToTotalGameScore()
		self:_openGameOverView()
	elseif SunWuKongChallengeFlipGameModel.instance:isArrivedMaxEraseCount() then
		self:_setGameState(GameState.LevelEnd)
		SunWuKongChallengeFlipGameModel.instance:addToTotalGameScore()

		self._tweenerLevelEnd = TweenUtil.DoDelay(0.5, function()
			if SunWuKongChallengeFlipGameModel.instance:isHaveNextLevel() then
				self:_startNextLevel()
			else
				self:_openGameOverView()
			end
		end)
	else
		SunWuKongChallengeFlipGameModel.instance:addToTotalGameScore()
		self:_openGameOverView()
	end
end

function SunWuKongFlipGameMainView:_startNextLevel()
	self:_resetEffectGo()
	self:_setGameState(GameState.Play)
	self:_initContainer()
end

function SunWuKongFlipGameMainView:_openGameOverView()
	FloatWordMgr.instance:show(langPara("游戏结束"))

	if self._curState ~= GameState.End and (SunWuKongChallengeFlipGameModel.instance:isArrivedMaxEraseCount() == false or SunWuKongChallengeFlipGameModel.instance:isHaveNextLevel()) then
		local text = lang("未能成功将所有牌子翻开，是否重新开始")

		local function okFunc()
			local score = 0

			SunWuKongChallengeController.instance:sendPM_SunWuKongChallengeEndGameReq(score)
			SunWuKongChallengeFlipGameModel.instance:onInit()
			SunWuKongChallengeFlipGameModel.instance:setLevelList(self._stageCfg.hiddenTaskId)
			self:_resetEffectGo()
			self:_setGameState(GameState.NoStart)
			self:_initContainer()
		end

		local function cancelFunc()
			local score = 0

			SunWuKongChallengeController.instance:sendPM_SunWuKongChallengeEndGameReq(score)
			self:close()
		end

		TipsFacade.instance:openPopupWindow("提示", text, okFunc, cancelFunc, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
	elseif self._curState == GameState.End then
		local score = 0

		SunWuKongChallengeController.instance:sendPM_SunWuKongChallengeEndGameReq(score)
		self:close()
	else
		local score = SunWuKongChallengeFlipGameModel.instance:getGameScore()

		SunWuKongChallengeController.instance:sendPM_SunWuKongChallengeEndGameReq(score)
		self:close()
	end
end

function SunWuKongFlipGameMainView:_setMask(active)
	goutil.setActive(self._maskGo, active)
end

function SunWuKongFlipGameMainView:_setTxtTitle(level)
	printInfo("test 设置关卡标题", level, type(level))
	self._imgTitle:SetNum(level)
end

function SunWuKongFlipGameMainView:_setCountDown(countDown)
	self._countDown = countDown
	self._txtCountDown.text = countDown .. "秒"
end

function SunWuKongFlipGameMainView:_reduceTime()
	self._countDown = self._countDown - 1

	if self._countDown >= 0 then
		self._countDown = self._countDown or 0
	end
end

function SunWuKongFlipGameMainView:_getCountDown()
	return self._countDown
end

function SunWuKongFlipGameMainView:_addCountDown(num)
	self._countDown = num
end

function SunWuKongFlipGameMainView:_setScore(score)
	self._txtScore.text = score .. "对"
end

function SunWuKongFlipGameMainView:_loadEffect()
	self._uiEffects = {}

	local path = "fx_ui_dianliangmengzhidui/fx_ui_xiaochu_mzd.prefab"
	local uiEffect1 = UIEffectManager.instance:playEffect(self, path, self._effectGo1.transform, 0, 0, true, false)

	uiEffect1:setParent(self._effectGo1.transform)
	uiEffect1:setScale(1)

	uiEffect1.hideEffWhileNotOnTop = false

	local uiEffect2 = UIEffectManager.instance:playEffect(self, path, self._effectGo2.transform, 0, 0, true, false)

	uiEffect2:setParent(self._effectGo2.transform)
	uiEffect2:setScale(1)

	uiEffect2.hideEffWhileNotOnTop = false

	table.insert(self._uiEffects, uiEffect1)
	table.insert(self._uiEffects, uiEffect2)
end

function SunWuKongFlipGameMainView:_removeEffect()
	if self._uiEffects then
		for i, v in ipairs(self._uiEffects) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._uiEffects = nil
	end
end

function SunWuKongFlipGameMainView:_updateEffectPos(posList)
	self._effectGo1.transform.position = posList[1]
	self._effectGo2.transform.position = posList[2]

	self._effectGo1:SetActive(false)
	self._effectGo1:SetActive(true)
	self._effectGo2:SetActive(false)
	self._effectGo2:SetActive(true)
end

function SunWuKongFlipGameMainView:_resetEffectGo()
	self._effectGo1:SetActive(false)
	self._effectGo2:SetActive(false)
end

return SunWuKongFlipGameMainView
