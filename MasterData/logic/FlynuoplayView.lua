-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/view/game/FlynuoplayView.lua

module("logic.extensions.flyingnuo.view.game.FlynuoplayView", package.seeall)

local FlynuoplayView = class("FlynuoplayView", ViewComponent)
local fillImgSizeY = 770

function FlynuoplayView:ctor()
	FlynuoplayView.super.ctor(self)

	self._imgFillVector2 = Vector2.New(0, 10)
end

function FlynuoplayView:buildUI()
	FlynuoplayView.super.buildUI(self)

	self._uiCamera = goutil.find("UICamera"):GetComponent(ComponentType.Camera)
	self._closeBtn = self:getBtn("closeBtn")
	self._boundBg = self:getGo("boundBg").transform
	self._playerCon = self:getGo("root/playercon/player")
	self._pipeCon = self:getGo("root/pipeCon")
	self._gameStartTip = self:getGo("gameStartTip")
	self._heartChanges = {}

	for i = 1, 3 do
		self._heartChanges[i] = self:getGo("scoreBg/hearts/heart" .. i):GetComponent(ComponentType.UIImageSpriteChange)
	end

	self._fillImgTr = self:getGo("scoreBg/scoreRewardCon/fillBg/fillImg").transform
	self._currScoreText = goutil.findChildTextComponent(self.mainGO, "scoreBg/currScoreText")
	self._reliveText = goutil.findChildTextComponent(self.mainGO, "scoreBg/reliveText")
	self._scoreCell = self:getGo("scoreBg/scoreRewardCon/cell")
	self._scoreCellParent = self:getGo("scoreBg/scoreRewardCon/scoreCellParent")
	self._scoreCellGroup = ItemGroup.New(self._scoreCellParent, self._scoreCell, nil, nil, true)
	self._pipeParent = self:getGo("root/pipeCon").transform
	self._pipeCellGo = self:getGo("root/pipeCon/cell")
	self._bgComp1 = self:getGo("moveBgCon/bg1"):GetComponent(ComponentType.TweenPosition)
	self._bgComp2 = self:getGo("moveBgCon/bg2"):GetComponent(ComponentType.TweenPosition)

	goutil.setActive(self._pipeCellGo, false)
	goutil.setActive(self._scoreCell, false)
	self:_setImgFill(0)

	self._reduceHpGo = self:getGo("reduceHp")
	self._reduceHpTweenPos = self._reduceHpGo:GetComponent(UnityTweensType.TweenPosition)
	self._reduceHpCanvasGroup = self._reduceHpGo:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._reduceHpCanvasGroup.alpha = 0
	self._effectGo = self:getGo("effect")
end

function FlynuoplayView:bindEvents()
	FlynuoplayView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickEndGame, self)
end

function FlynuoplayView:unbindEvents()
	FlynuoplayView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function FlynuoplayView:destroyUI()
	FlynuoplayView.super.destroyUI(self)
end

function FlynuoplayView:onEnter()
	FlynuoplayView.super.onEnter(self)
	GlobalDispatcher:addListener(FlyNuoGameController.ScoreChange, self._updateScore, self)
	GlobalDispatcher:addListener(FlyNuoGameController.HpChange, self._updateHp, self)
	GlobalDispatcher:addListener(FlyingNuoAgent.ReliveRes, self._updateHp, self)
	GlobalDispatcher:addListener(FlyNuoGameController.ShieldChange, self._shiledChange, self)
	self:_gameInit()
	self:_updateView()
	self:_updateScore()
end

function FlynuoplayView:onEnterFinished()
	FlynuoplayView.super.onEnterFinished(self)

	FlyNuoModel.instance.playViewIsOpen = true

	local moveSpeed = FlyNuoConfig.instance:getBgMoveSpeed()

	if moveSpeed <= 0 then
		self._bgComp1:Stop()
		self._bgComp2:Stop()
	else
		local bgMoveTime = math.ceil(2048 / moveSpeed)

		self._bgComp1.time = bgMoveTime
		self._bgComp2.time = bgMoveTime

		self._bgComp1:Begin()
		self._bgComp2:Begin()
	end
end

function FlynuoplayView:onExit()
	FlynuoplayView.super.onExit(self)
	self._player:onExit()
	GlobalDispatcher:removeListener(FlyNuoGameController.ScoreChange, self._updateScore, self)
	GlobalDispatcher:removeListener(FlyNuoGameController.HpChange, self._updateHp, self)
	GlobalDispatcher:removeListener(FlyingNuoAgent.ReliveRes, self._updateHp, self)
	GlobalDispatcher:removeListener(FlyNuoGameController.ShieldChange, self._shiledChange, self)
	self._scoreCellGroup:dispose(self._disPoseScoreCell, self)
	self._reduceHpTweenPos:Stop()
	UIEffectManager.instance:stopEffect(self._guideEffectHandler)

	self._reduceHpCanvasGroup.alpha = 0

	removetimer(self._updateReduceHpAlpha, self)
end

function FlynuoplayView:onExitFinished()
	FlynuoplayView.super.onExitFinished(self)
end

function FlynuoplayView:_gameInit()
	self._isClickEnd = false

	self:_setScore(0)
	self:_updateHp()
	goutil.setActive(self._gameStartTip, true)

	self._player = GameUtil.AddLuaOnce(self._playerCon, FlynuoPlayer)

	self._player:onEnter(self)
	FlyNuoGameController.instance:gameInit(self, self._player, self._pipeParent, self._pipeCellGo)
end

function FlynuoplayView:_onClickEndGame()
	if self._isClickEnd then
		return
	end

	self._isClickEnd = true

	FlyNuoGameController.instance:endGame()
end

function FlynuoplayView:startGame()
	goutil.setActive(self._gameStartTip, false)
end

function FlynuoplayView:_updateView()
	local activityid = self:getFirstParam()
	local cfg = FlyNuoConfig.instance:getActivityCfgById(activityid)
	local prizeCfgs = FlyNuoConfig.instance:getPrizeCfg(cfg.prizePlan)
	local newCfgs = {}

	for k, v in pairs(prizeCfgs) do
		table.insert(newCfgs, v)
	end

	table.sort(newCfgs, function(a, b)
		return a.leftScore < b.leftScore
	end)

	self._prizeCfgs = newCfgs
	self._scoreCellSpace = fillImgSizeY / #newCfgs

	self._scoreCellGroup:updateWithMoArray(newCfgs, self._updateScoreCell, self)
end

function FlynuoplayView:_updateScore()
	local currScore = FlyNuoModel.instance:getScore()
	local fill = 0

	if self._prizeCfgs then
		local len = #self._prizeCfgs
		local step = 1 / len

		if currScore >= self._prizeCfgs[#self._prizeCfgs].leftScore then
			fill = 1
		else
			local nextScore = 0
			local lastScore = 0

			for i, v in ipairs(self._prizeCfgs) do
				if currScore >= v.leftScore then
					if i ~= 1 then
						fill = fill + step
					end

					lastScore = v.leftScore
				else
					nextScore = v.leftScore

					break
				end
			end

			fill = fill + (currScore - lastScore) / (nextScore - lastScore) * step
		end
	end

	self:_setImgFill(fill)
	self:_setScore(currScore)
end

function FlynuoplayView:_setScore(num)
	self._currScoreText.text = "当前积分\n" .. GameUtil.HtmlColorTxt(num, "#fffffff")
end

function FlynuoplayView:_updateHp()
	local hp = FlyNuoModel.instance:getHp()

	for i, v in ipairs(self._heartChanges) do
		goutil.setActive(v.gameObject, false)
	end

	for i = 1, hp do
		goutil.setActive(self._heartChanges[i].gameObject, true)
	end

	self:_setReliveMsg()
end

function FlynuoplayView:_updateScoreCell(item, cfg)
	local numText = goutil.findChildTextComponent(item.mainGO, "numText")
	local numText2 = goutil.findChildTextComponent(item.mainGO, "numText2")
	local txtProgress = goutil.findChildTextComponent(item.mainGO, "txtProgress")
	local iconGo = goutil.findChild(item.mainGO, "icon")
	local icon2Go = goutil.findChild(item.mainGO, "icon2")
	local list1 = string.split(cfg.prize, "#")
	local mt1 = string.split(list1[1], ":")

	MaterialMgr.setIcon(iconGo, checknumber(mt1[1]), checknumber(mt1[2]))

	numText.text = mt1[#mt1]

	goutil.setActive(icon2Go, list1[2])

	numText2.text = ""

	if list1[2] then
		local mt2 = string.split(list1[2], ":")

		MaterialMgr.setIcon(icon2Go, checknumber(mt2[1]), checknumber(mt2[2]))

		numText2.text = mt2[#mt2]
	end

	txtProgress.text = cfg.leftScore

	GameUtil.setLocalPos(item.mainGO, (item.index - 1) * self._scoreCellSpace - 20, -41.5)
end

function FlynuoplayView:_disPoseScoreCell(item)
	local icon = goutil.findChild(item.mainGO, "icon")
	local icon2 = goutil.findChild(item.mainGO, "icon2")

	MaterialMgr.resetAll(icon)
	MaterialMgr.resetAll(icon2)
end

function FlynuoplayView:_setReliveMsg()
	local canReliveTime = FlyNuoConfig.instance:getCanReliveTime()
	local currReliveTime = FlyNuoModel.instance:getReliveTime()
	local leftTime = canReliveTime - currReliveTime
	local color = leftTime > 0 and "#75ff88ff" or "#FF553EFF"

	self._reliveText.text = "当前已复活：" .. GameUtil.HtmlColorTxt(currReliveTime .. "/" .. canReliveTime, color)
end

function FlynuoplayView:_shiledChange()
	return
end

function FlynuoplayView:_setImgFill(num)
	self._imgFillVector2.x = fillImgSizeY * (num / 1)
	self._fillImgTr.sizeDelta = self._imgFillVector2
end

function FlynuoplayView:isHit()
	goutil.setActive(self._reduceHpGo, true)
	self._reduceHpTweenPos:Begin()

	self._alphaChangeTime = ServerTime.nowMs()

	settimer(0, self._updateReduceHpAlpha, self, true)
end

function FlynuoplayView:_updateReduceHpAlpha()
	local msTime = 800
	local goTime = ServerTime.nowMs() - self._alphaChangeTime

	if msTime <= goTime then
		removetimer(self._updateReduceHpAlpha, self)

		self._reduceHpCanvasGroup.alpha = 0
	end

	self._reduceHpCanvasGroup.alpha = 1 - goTime / msTime
end

function FlynuoplayView:relive()
	goutil.setActive(self._effectGo, true)

	local name = "common/fx_ui_zhiyin_quan_03.prefab"

	self._guideEffectHandler = UIEffectManager.instance:playEffect(self, name, nil, 0, 0, true)

	self._guideEffectHandler:setParent(self._effectGo.transform)
	self._guideEffectHandler:setScale(1)
	self._guideEffectHandler:setLocalPos(0, 0, 0)
end

function FlynuoplayView:hideClickEffect()
	goutil.setActive(self._effectGo, false)

	if self._guideEffectHandler then
		UIEffectManager.instance:stopEffect(self._guideEffectHandler)

		self._guideEffectHandler = nil
	end
end

return FlynuoplayView
