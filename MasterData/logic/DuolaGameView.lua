-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolamengmeng/view/DuolaGameView.lua

module("logic.extensions.duolamengmeng.view.DuolaGameView", package.seeall)

local DuolaGameView = class("DuolaGameView", ViewComponent)
local GAME_STATE_TOSTART = 1
local GAME_STATE_PLAYING = 2
local GAME_STATE_END = 3
local NUM_CELL_STORE = 8
local PLAYER_RADIUS = 14
local JUMP_SPEED = 1000
local GAME_UPDATETIME = 0
local POSY_TO_SLOW = -120
local START_POS_X = 200
local START_POS_Y = -230
local ADD_SPEED_FACTOR = 0.03
local RIPITIDE_HEIGHT = 340

function DuolaGameView:ctor()
	DuolaGameView.super.ctor(self)
end

function DuolaGameView:buildUI()
	DuolaGameView.super.buildUI(self)

	self._itemCell = self:getGo("scroller/itemCell")
	self._startTip = self:getGo("startTip")
	self._bg = self:getBtn("bg")
	self._btnClose = self:getBtn("btnClose")
	self._scroller = self:getGo("scroller")
	self._cellParent = self:getGo("scroller/cells")
	self._playerGo = self:getGo("scroller/player")
	self._cell = self:getGo("cell")
	self._scrollView = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._scrollView, self._cell, GameUtil.handler(self._updatePieceCell, self), GameUtil.handler(self._clearPieceCell, self))
	self._heart = {}

	for i = 1, 3 do
		self._heart[i] = {}
		self._heart[i].go = self:getGo("lift/heart" .. i)
		self._heart[i].effectGo = self:getGo("lift/effect" .. i)
	end

	self._cellList = {}
	self._player = {}
	self._player.go = self._playerGo
	self._player.img = self._playerGo:GetComponent("Image")
	self._player.goRebornEffect = self:getGo("scroller/player/effect")
	self._rebornEffect = nil
	self._ripiteEffectGo = self:getGo("ripitideEffect")
	self._ripiteEffect = {}
	self._prizeEffect = {}
end

function DuolaGameView:bindEvents()
	DuolaGameView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._clickClose, self)
	self._bg:AddClickListener(self._clickBg, self)
end

function DuolaGameView:unbindEvents()
	DuolaGameView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._bg:RemoveClickListener()
end

function DuolaGameView:destroyUI()
	DuolaGameView.super.destroyUI(self)
end

function DuolaGameView:onEnter()
	DuolaGameView.super.onEnter(self)

	self._heartNum = 3
	self._buyGameTimes = 0
	self._params = self:getFirstParam()

	if self._params.gameCfg == nil or self._params.prizeList == nil or self._params.dropPlanCfg == nil or self._params.rebornCfg == nil then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("缺游戏配置"), GameUtil.handler(self.close, self))

		return
	end

	if not DuolaMMmodel.instance:getLoginFirstChallenge() then
		UIStateManager.instance:push(ViewName.DuolaMMGameRuleView)
		DuolaMMmodel.instance:setLoginFirstChallenge(true)
	end

	GlobalDispatcher:addListener(GlobalNotify.DuoLaMMGameReborn, self._handleReborn, self)
	self:_prepareData()
	self:_showRiptiteEffect()
	self:_resetScroller()
	self:_resetPlayer()
	self:_refreshCurCfg()
	self:_refreshHeart()
	self:_refresh()
end

function DuolaGameView:onEnterFinished()
	DuolaGameView.super.onEnterFinished(self)
end

function DuolaGameView:onExit()
	DuolaGameView.super.onExit(self)
	removetimer(self._updateFrame, self)
	removetimer(self._gameOver, self)
	removetimer(self._gameRebornEffectEnd, self)
	GlobalDispatcher:removeListener(GlobalNotify.DuoLaMMGameReborn, self._handleReborn, self)

	for i, v in pairs(self._cellList) do
		self:_clearCell(i)
	end

	table.clear(self._cellList)

	self._cellList = {}

	for i = 1, 3 do
		UIEffectManager.instance:stopEffect(self._heart[i].effect)
	end

	if self._jumpTween then
		self._jumpTween:Kill(false)

		self._jumpTween = nil
	end

	if self._colorTween then
		self._colorTween:Kill(false)

		self._colorTween = nil
	end

	self._scrollList:dispose()
	UIEffectManager.instance:stopEffect(self._ripiteEffect)
end

function DuolaGameView:onExitFinished()
	DuolaGameView.super.onExitFinished(self)
end

function DuolaGameView:_showRiptiteEffect()
	local path = "fx_ui_duolamengmengtiaozhan/fx_ui_duolamengmengtiaozhan_shui.prefab"

	self._ripiteEffect = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
	end)

	self._ripiteEffect:setParent(self._ripiteEffectGo.transform)
	self._ripiteEffect:setScale(1)

	self._ripiteEffect.hideEffWhileNotOnTop = true
end

function DuolaGameView:_prepareData()
	self._prizeList = self._params.prizeList

	for k, v in ipairs(self._prizeList) do
		v.num = 0
	end

	self._dropPlanCfg = self._params.dropPlanCfg
	self._rebornCfg = self._params.rebornCfg
	self._rebornMaxTime = 0

	for k, v in pairs(self._params.rebornCfg) do
		self._rebornMaxTime = self._rebornMaxTime + 1
	end

	local gameList = {}

	for k, v in pairs(self._params.gameCfg) do
		table.insert(gameList, v)
	end

	table.sort(gameList, function(a, b)
		return a.level < b.level
	end)

	self._gameCfg = gameList
	self._rebornCallBack = self._params.rebornCallBack
	self._finishCallBack = self._params.finishCallBack
	self._state = GAME_STATE_TOSTART

	goutil.setActive(self._startTip, true)

	self._index = 0
	self._riptideSpeed = 1
	self._jumping = false
end

function DuolaGameView:_refresh()
	self:_refreshCells()
	self._scrollList:reloadData(self._prizeList)
end

function DuolaGameView:_refreshHeart()
	for i = 1, 3 do
		goutil.setActive(self._heart[i].go, i <= self._heartNum)
	end
end

function DuolaGameView:_refreshPrize()
	self._scrollList:refresh(self._prizeList)
end

function DuolaGameView:_updatePieceCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, data.imgPath)

	local preStr = txtNum.text
	local preNum = 0

	if string.find(preStr, "%d") then
		local num = string.find(preStr, "%d")

		preNum = checknumber(string.sub(preStr, num, string.len(preStr)))
	end

	if preNum < data.num then
		self:_showJiaYiEffect(cell)
		print("-----------------------duolaGAme  %s", cell.index)
	end

	self._prizeEffect = {}
	txtNum.text = data.num
end

function DuolaGameView:_showJiaYiEffect(cell)
	local effectGO = goutil.findChild(cell, "effect")

	if effectGO then
		local path = "fx_ui_duolamengmengtiaozhan/fx_kouxue_+1.prefab"

		self._prizeEffect[cell] = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, false, nil, nil, nil)

		self._prizeEffect[cell]:setParent(effectGO.transform)
		self._prizeEffect[cell]:setScale(1)
		self._prizeEffect[cell]:setLocalPos(0, 0, 0)

		self._prizeEffect[cell].hideEffWhileNotOnTop = true
	end
end

function DuolaGameView:_clearPieceCell(cell)
	local icon = goutil.findChild(cell, "icon")

	if self._prizeEffect[cell] then
		UIEffectManager.instance:stopEffect(self._prizeEffect[cell])
	end

	uGuiUtil.clearImage(icon)
end

function DuolaGameView:_refreshCells()
	for i = self._index, self._index + NUM_CELL_STORE / 2 do
		self:_addCell(i)
	end

	for i, v in pairs(self._cellList) do
		if i >= self._index - NUM_CELL_STORE / 2 and i <= self._index + NUM_CELL_STORE / 2 then
			-- block empty
		else
			self:_clearCell(i)
		end
	end
end

function DuolaGameView:_clickBg()
	if self._state == GAME_STATE_TOSTART then
		self:_start()
	elseif self._state == GAME_STATE_PLAYING then
		self:_jump()
	elseif self._state == GAME_STATE_END then
		-- block empty
	end
end

function DuolaGameView:_clickClose()
	if self._state == GAME_STATE_PLAYING then
		self:_suspend()

		local str = "你确定现在要退出游戏吗？\n\n现在退出只能获得当前的碎片哦"

		TipsFacade.instance:openPopupWindow("提示", str, function()
			self:_gameOver()
		end, function()
			self:_continue()
		end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	else
		self:close()
	end
end

function DuolaGameView:_addCell(index)
	if self._cellList[index] == nil and index > 0 then
		local gameCfg = self:_getGameCfg(index)

		if gameCfg then
			local cell = goutil.cloneAndSetParent(self._itemCell, self._cellParent.transform)

			goutil.setActive(cell, true)

			local component = DuolaItem.GetGo(cell.gameObject)
			local data = {
				go = cell,
				gameCfg = gameCfg,
				dropPlanCfg = self._dropPlanCfg[gameCfg.dropPlanId],
				prizeList = self._prizeList
			}

			component:init(index, data)

			self._cellList[index] = cell
		end
	end
end

function DuolaGameView:_clearCell(index)
	if self._cellList[index] and index > 0 then
		local cell = self._cellList[index]
		local component = DuolaItem.GetGo(cell.gameObject)

		component:OnDestroy()

		self._cellList[index] = nil
	end
end

function DuolaGameView:_start()
	goutil.setActive(self._startTip, false)

	self._state = GAME_STATE_PLAYING

	self:_updateFrame()
	settimer(GAME_UPDATETIME, self._updateFrame, self, true)
end

function DuolaGameView:_updateFrame()
	local pos = self._scroller.transform.localPosition
	local canvasPosY = self._player.pos.y + pos.y
	local ripitdieSpeed = self._riptideSpeed

	if canvasPosY > POSY_TO_SLOW then
		ripitdieSpeed = (1 + (canvasPosY - POSY_TO_SLOW) * ADD_SPEED_FACTOR) * ripitdieSpeed
	end

	local posy = pos.y - ripitdieSpeed

	GameUtil.setLocalPos(self._scroller, 0, posy, 0)

	if canvasPosY - PLAYER_RADIUS + RIPITIDE_HEIGHT < 0 then
		self:_collide()
	end

	if self:_checkVirusCollision() then
		self:_collide()
	end
end

function DuolaGameView:_resetScroller()
	GameUtil.setLocalPos(self._scroller, 0, 0, 0)
end

function DuolaGameView:_resetPlayer()
	self._player.pos = {
		x = START_POS_X,
		y = START_POS_Y
	}

	GameUtil.setLocalPos(self._player.go, self._player.pos.x, self._player.pos.y, 0)
end

function DuolaGameView:_refreshCurCfg()
	self._curGameCfg = self:_getGameCfg(self._index)

	if self._curGameCfg then
		self._riptideSpeed = math.random(self._curGameCfg.riptide[1], self._curGameCfg.riptide[1])
	end
end

function DuolaGameView:_getGameCfg(index)
	local gameCfg

	for k, v in pairs(self._gameCfg) do
		if index <= v.level then
			gameCfg = v

			break
		end
	end

	return gameCfg
end

function DuolaGameView:_collide()
	self:_suspend()

	if self._jumpTween then
		self._jumpTween:Kill(false)

		self._jumpTween = nil
	end

	local times = 2
	local singleTime = 0.7

	if self._colorTween then
		self._colorTween:Kill(false)

		self._colorTween = nil
	end

	self._colorTween = TweenUtil.ValueTo(0, times * 255, singleTime * times, function(val)
		local green = (255 - val % 255) / 255

		Game.ImageUtil.SetColorRGBA(self._player.img, 1, green, green, 1)
	end, function()
		self:_collideEffectEnd()
	end, self, DG.Tweening.Ease.Linear)

	self:_showHeartEffect()
end

function DuolaGameView:_showHeartEffect()
	local i = self._heartNum

	self._heartNum = self._heartNum - 1

	self:_refreshHeart()

	local path = "fx_ui_duolamengmengtiaozhan/fx_kouxue_kouxue.prefab"

	if i > 0 and self._heart[i] then
		self._heart[i].effect = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, false, nil, nil, function(finishHandlerTarget, eff)
			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)

			self._heart[i].effect = nil
		end)

		self._heart[i].effect:setParent(self._heart[i].effectGo.transform)
		self._heart[i].effect:setScale(1)

		self._heart[i].effect.hideEffWhileNotOnTop = true
	end
end

function DuolaGameView:_collideEffectEnd()
	if self._colorTween then
		self._colorTween:Kill(false)

		self._colorTween = nil
	end

	if self._heartNum > 0 then
		self:_gameReborn()
	elseif self._buyGameTimes < self._rebornMaxTime then
		local buyCfg = self._rebornCfg[self._buyGameTimes + 1]

		if buyCfg then
			local strConsume = buyCfg.consume
			local price = checknumber(string.split(strConsume, ":")[3])

			if price <= RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond() then
				local str = langPara("是否消耗%s钻石补满3点生命值？\n每轮游戏仅可补满%d次", price, self._rebornMaxTime)

				TipsFacade.instance:openPopupWindow("提示", str, function()
					self._buyGameTimes = self._buyGameTimes + 1
					self._heartNum = 3

					self:_refreshHeart()
					self:_sendReborn()
				end, function()
					self:_gameOverTip()
				end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)

				return
			end
		end

		self:_gameOverTip()
	else
		self:_gameOverTip()
	end
end

function DuolaGameView:_gameOver()
	removetimer(self._gameOver, self)

	self._state = GAME_STATE_END

	self._finishCallBack(self._prizeList)
	self:close()
end

function DuolaGameView:_gameOverTip()
	removetimer(self._updateFrame, self)
	settimer(1.6, self._gameOver, self, false)
	FloatWordMgr.instance:show("生命耗尽，游戏结束！")
end

function DuolaGameView:_suspend()
	removetimer(self._updateFrame, self)
end

function DuolaGameView:_continue()
	self:_updateFrame()
	settimer(GAME_UPDATETIME, self._updateFrame, self, true)
end

function DuolaGameView:_sendReborn()
	self._rebornCallBack()
end

function DuolaGameView:_handleReborn(status)
	if status == 0 then
		self:_gameReborn()
	else
		FloatWordMgr.instance:show("复活失败")
		self:_gameOver()
	end
end

function DuolaGameView:_gameReborn()
	goutil.setActive(self._player.go, false)

	local nextCell = self._cellList[self._index + 1]

	if nextCell == nil then
		nextCell = self._cellList[self._index]
	end

	local comp = DuolaItem.GetGo(nextCell)
	local nowPos = comp:getPos()

	self._player.pos = {
		x = nowPos.x,
		y = nowPos.y
	}

	GameUtil.setLocalPos(self._player.go, self._player.pos.x, self._player.pos.y, 0)
	self:_jumpSuccess(comp)

	self._jumping = true

	if self._rebornEffect then
		UIEffectManager.instance:stopEffect(self._rebornEffect)
	end

	local path = "fx_ui_duolamengmengtiaozhan/fx_duolamengmeng_touxiang2.prefab"

	self._rebornEffect = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
	end)

	self._rebornEffect:setParent(self._player.goRebornEffect.transform)
	self._rebornEffect:setScale(1)

	self._rebornEffect.hideEffWhileNotOnTop = true

	settimer(0.5, self._gameRebornEffectEnd, self, false)
end

function DuolaGameView:_gameRebornEffectEnd()
	goutil.setActive(self._player.go, true)
	removetimer(self._gameRebornEffectEnd, self)

	if self._colorTween then
		self._colorTween:Kill(false)

		self._colorTween = nil
	end

	self._jumping = false

	self:_continue()
	Game.ImageUtil.SetColorRGBA(self._player.img, 1, 1, 1, 1)
end

function DuolaGameView:_jump()
	if self._jumping == true then
		return
	end

	local nextCell = self._cellList[self._index + 1]

	if nextCell then
		if self._jumpTween then
			self._jumpTween:Kill(false)

			self._jumpTween = nil
		end

		self._lastRiptideY = self._scroller.transform.localPosition.y

		local comp = DuolaItem.GetGo(nextCell)
		local nextPos = comp:getPos()
		local dropId = comp:getDropId()
		local playerPos = {
			x = self._player.pos.x,
			y = self._player.pos.y
		}
		local diffX = nextPos.x - playerPos.x
		local diffY = nextPos.y - playerPos.y
		local time = DuolaMMcontroller.instance:calculateDistance(nextPos, playerPos) / JUMP_SPEED

		self._jumping = true
		self._jumpTween = TweenUtil.ValueTo(0, 1, time, function(val)
			local posX = val * diffX + playerPos.x
			local posY = val * diffY + playerPos.y

			GameUtil.setLocalPos(self._player.go, posX, posY, 0)

			self._player.pos.x = posX
			self._player.pos.y = posY
		end, function()
			self:_jumpSuccess(comp)
		end, self, DG.Tweening.Ease.Linear)
	end
end

function DuolaGameView:_jumpSuccess(comp)
	local dropId = comp:getDropId()
	local nextPos = comp:getPos()

	self._jumping = false
	self._jumpTween = nil
	self._player.pos = {
		x = nextPos.x,
		y = nextPos.y
	}
	self._index = self._index + 1

	self:_refreshCells()

	if checknumber(dropId) > 0 then
		self._prizeList[dropId].num = self._prizeList[dropId].num + 1

		self:_refreshPrize()
	end

	comp:disappear()

	local nextCell = self._cellList[self._index + 1]

	if nextCell == nil then
		FloatWordMgr.instance:show("轻松通关，有手就行！")
		settimer(1.5, self._gameOver, self, false)
	end
end

function DuolaGameView:_checkVirusCollision()
	local nextCell = self._cellList[self._index + 1]

	if nextCell then
		local comp = DuolaItem.GetGo(nextCell)
		local worldPos = self._player.go.transform.position

		return (comp:checkVirusCollision(worldPos, PLAYER_RADIUS))
	else
		return false
	end
end

return DuolaGameView
