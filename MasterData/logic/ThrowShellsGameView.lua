-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throwshells/view/ThrowShellsGameView.lua

module("logic.extensions.throwshells.view.ThrowShellsGameView", package.seeall)

local ThrowShellsGameView = class("ThrowShellsGameView", ViewComponent)
local IN_TRAIL_INTERVAL = 25
local FRAME_TIME = 0.03
local MAX_OUT_TRAIL_POINT_NUM = 60
local MAX_IN_TRAIL_POINT_NUM = 30
local CANCEL_RADIUS = 55
local MAX_MONSTER_NUM = 4
local SHELL_RADIUS = 20
local PLAY_STATE = {
	IDLING = 1,
	SHOOTING = 2,
	FLYING = 3
}

function ThrowShellsGameView:ctor()
	ThrowShellsGameView.super.ctor(self)
end

function ThrowShellsGameView:buildUI()
	ThrowShellsGameView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")

	local scrollPath = "scrollview/Viewport/Content/"

	self._origin = self:getGo(scrollPath .. "origin")
	self._originScene = self:getGo(scrollPath .. "originScene")
	self._goRange = self:getGo(scrollPath .. "origin/mainActor/range")
	self._goEffctFeng = self:getGo(scrollPath .. "effect")
	self._shell = self:getGo(scrollPath .. "origin/shell")
	self._goEffectshell = self:getGo(scrollPath .. "origin/shell/effect")
	self._shellTrans = self._shell.transform

	goutil.setActive(self._shell, false)

	self._btnDrag = self:getGo(scrollPath .. "origin/mainActor/btnDrag")
	self._mainActorGo = self:getGo(scrollPath .. "origin/mainActor")
	self._mainActorAni = self:getGo(scrollPath .. "origin/mainActor/animation")
	self._goShootEffect = self:getGo(scrollPath .. "origin/mainActor/effect")
	self._dragdot = self:getGo(scrollPath .. "origin/mainActor/inTrail/dragdot")

	BeginDragHandler.Get(self._btnDrag):AddLuaHandler(function(_go, data)
		self:_beginDrag(data)
	end)
	EndDragHandler.Get(self._btnDrag):AddLuaHandler(function(_go, data)
		self:_endDrag(data)
	end)
	DragHandler.Get(self._btnDrag):AddLuaHandler(function(_go, data)
		self:_draging(data)
	end)

	self._txtRound = self:getTxt("ui/totalRound/txtRound")
	self._goCancel = self:getGo(scrollPath .. "origin/mainActor/cancel")

	goutil.setActive(self._goCancel, false)

	self._txtFengli = self:getTxt("ui/fengli/txt")
	self._monsterUI = {}

	for i = 1, MAX_MONSTER_NUM do
		local obj = {}

		obj.go = self:getGo("ui/monsters/monster_" .. i)
		obj.head = goutil.findChild(obj.go, "head/con")
		obj.blood = Framework.SliderAdapter.GetFrom(self.mainGO, "ui/monsters/monster_" .. i)

		table.insert(self._monsterUI, obj)
	end

	self._gamestartTip = self:getGo("ui/gamestartTip")
	self._duopingTip = self:getGo("ui/duopingTip")

	goutil.setActive(self._duopingTip, false)

	self._missTip = self:getGo("ui/miss")

	goutil.setActive(self._missTip, false)

	self._arrows = {}

	for i = 1, MAX_MONSTER_NUM do
		local go = self:getGo("ui/arrows/arrow_" .. i)

		table.insert(self._arrows, go)
	end

	self._scrollView = self:getGo("scrollview"):GetComponent("ScrollRect")
	self._viewportTrans = self:getGo("scrollview/Viewport"):GetComponent("RectTransform")
	self._contentTrans = self:getGo("scrollview/Viewport/Content"):GetComponent("RectTransform")
	self._scrollAdapter = Framework.ScrollRectAdapter.Get(self:getGo("scrollview").gameObject)
	self._inTrail = self:getGo(scrollPath .. "origin/mainActor/inTrail")
	self._inTrailpointsNode = self:getGo(scrollPath .. "origin/mainActor/inTrail/points")
	self._inTrailPoint = self:getGo(scrollPath .. "origin/mainActor/inTrail/points/point")

	goutil.setActive(self._inTrail, false)
	goutil.setActive(self._inTrailPoint, false)

	local function createFunc()
		return (goutil.cloneAndSetParent(self._inTrailPoint, self._inTrailpointsNode.transform))
	end

	local function disposeFunc(item)
		goutil.destroy(item)
	end

	local function resetFunc(item)
		goutil.setActive(item.gameObject, false)
	end

	self._inTrailPointPool = ObjectPool.New(MAX_IN_TRAIL_POINT_NUM, createFunc, disposeFunc, resetFunc)
	self._inTrailList = {}
	self._outTrail = self:getGo(scrollPath .. "origin/mainActor/outTrail")
	self._outTrailPoint = self:getGo(scrollPath .. "origin/mainActor/outTrail/point")

	goutil.setActive(self._outTrail, false)
	goutil.setActive(self._outTrailPoint, false)

	local function createFunc2()
		return (goutil.cloneAndSetParent(self._outTrailPoint, self._outTrail.transform))
	end

	local function disposeFunc2(item)
		goutil.destroy(item)
	end

	local function resetFunc2(item)
		goutil.setActive(item.gameObject, false)
	end

	self._outTrailPointPool = ObjectPool.New(MAX_OUT_TRAIL_POINT_NUM, createFunc2, disposeFunc2, resetFunc2)
	self._outTrailList = {}
end

function ThrowShellsGameView:bindEvents()
	ThrowShellsGameView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._clickClose, self)
	self._scrollAdapter:AddOnValueChanged(self._onScrollValueChanged, self)
end

function ThrowShellsGameView:unbindEvents()
	ThrowShellsGameView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._scrollAdapter:RemoveOnValueChanged()
end

function ThrowShellsGameView:destroyUI()
	ThrowShellsGameView.super.destroyUI(self)
end

function ThrowShellsGameView:onEnter()
	ThrowShellsGameView.super.onEnter(self)
	self:_initDataAndUI()
	getres("character/xinxiya_xiaoren/xinxiya_xiaoren-ui_p.prefab", self._onEffectLoaded, self)
	self:_refreshFengLi()
	GlobalDispatcher:addListener(GlobalNotify.ThrowShellsMonsterDamage, self._refreshMonsterBlood, self)
	GlobalDispatcher:addListener(GlobalNotify.ThrowShellsCollideWall, self._playMissTip, self)
	self:_buildTerrainData()

	local rate = 1
	local dx = 0
	local d = UnityEngine.Screen.width / UnityEngine.Screen.height

	if d > 2.23 then
		dx = -160
	end

	rate = d < 1.7777777778 and 1280 / UnityEngine.Screen.width or 720 / UnityEngine.Screen.height
	self._screenWidth = UnityEngine.Screen.width * rate + dx
	self._viewportTrans.sizeDelta = Vector2.New(self._screenWidth, 720)

	if not self._terrainCfg.isSingle then
		self._screenWidth = UnityEngine.Screen.width * rate * 2
	end

	self._contentTrans.sizeDelta = Vector2.New(self._screenWidth, 720)
end

function ThrowShellsGameView:onEnterFinished()
	ThrowShellsGameView.super.onEnterFinished(self)
end

function ThrowShellsGameView:onExit()
	ThrowShellsGameView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ThrowShellsMonsterDamage, self._refreshMonsterBlood, self)
	GlobalDispatcher:removeListener(GlobalNotify.ThrowShellsCollideWall, self._playMissTip, self)
	removeresl("character/xinxiya_xiaoren/xinxiya_xiaoren-ui_p.prefab", self._onResLoaded, self)
	removetimer(self._shoot, self)
	removetimer(self._tickFly, self)
	removetimer(self._hideShell, self)

	if self._throwShellSceneMgr then
		self._throwShellSceneMgr:onDestroy()
	end

	self._throwShellSceneMgr = nil

	for k, v in pairs(self._inTrailList) do
		self._inTrailPointPool:returnObject(v)
	end

	table.clear(self._inTrailList)

	for k, v in pairs(self._outTrailList) do
		self._outTrailPointPool:returnObject(v)
	end

	table.clear(self._outTrailList)

	for i = 1, MAX_MONSTER_NUM do
		uGuiUtil.clearImage(self._monsterUI[i].head)
	end

	if self._missTipTween then
		self._missTipTween:Kill(false)

		self._missTipTween = nil
	end

	if self._fengEffect then
		UIEffectManager.instance:stopEffect(self._fengEffect)

		self._fengEffect = nil
	end

	if self._shellPathEff then
		UIEffectManager.instance:stopEffect(self._shellPathEff)

		self._shellPathEff = nil
	end

	if self._shootEffect then
		UIEffectManager.instance:stopEffect(self._shootEffect)

		self._shootEffect = nil
	end

	if self._boomEffect then
		UIEffectManager.instance:stopEffect(self._boomEffect)

		self._boomEffect = nil
	end

	if self._res then
		self._res:Release()
	end

	self._res = nil

	if not goutil.isNil(self._spineGO) then
		goutil.destroy(self._spineGO)
	end
end

function ThrowShellsGameView:onExitFinished()
	ThrowShellsGameView.super.onExitFinished(self)
end

function ThrowShellsGameView:_refresh()
	return
end

function ThrowShellsGameView:_initDataAndUI()
	local gameCfg = self:getFirstParam()

	self._playState = PLAY_STATE.IDLING
	self._mainActor = {}
	self._mainActor.pos = {}
	self._gameCfg = gameCfg

	local propId = gameCfg.propId

	self._propCfg = ThrowShellsConfig.instance:getPropCfg(propId)
	self._GRAVITY_ACC = checknumber(ThrowShellsConfig.instance:getCommonCfg("GRAVITY_ACC"))
	self._AIR_DRAG = checknumber(ThrowShellsConfig.instance:getCommonCfg("AIR_DRAG"))
	self._terrainId = gameCfg.terrainId

	local rotation = (self._propCfg.range[1] + self._propCfg.range[2]) / 2 + 90

	Framework.TransformUtil.SetLocalRotation(self._goRange.transform, 0, 0, rotation)

	self._roundNum = 1

	self:_refreshRound()

	local terrainId = gameCfg.terrainId

	self._terrainCfg = ThrowShellsConfig.instance:getTerrainCfg(terrainId)

	goutil.setActive(self._duopingTip, not self._terrainCfg.isSingle)

	self._checkDuopingTip = not self._terrainCfg.isSingle

	goutil.setActive(self._gamestartTip, true)

	self._monsterCfg = ThrowShellsConfig.instance:getMonsterCfg(self._terrainCfg.monsterPlanId)
	self._monsterDead = {}

	for k, v in pairs(self._monsterCfg) do
		self._monsterDead[v.monsterId] = false
	end

	for i = 1, MAX_MONSTER_NUM do
		goutil.setActive(self._monsterUI[i].go, self._monsterCfg[i] ~= nil)
		self._monsterUI[i].blood:SetValue(1)

		if self._monsterCfg[i] ~= nil then
			local petCo = CharacterConfig.instance:getPetCo(self._monsterCfg[i].raceId)
			local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCo.faceIds))

			uGuiUtil.setSpriteToImage(self._monsterUI[i].head, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
		end
	end

	for i = 1, MAX_MONSTER_NUM do
		goutil.setActive(self._arrows[i], false)
	end
end

function ThrowShellsGameView:_buildTerrainData()
	self._throwShellSceneMgr = ThrowShellSceneMgr.New(self._originScene, function(mainActorPos)
		local pos = mainActorPos and mainActorPos or {
			x = 0,
			y = 0
		}

		self._mainActor.pos = pos

		Framework.TransformUtil.SetLocalPos(self._mainActorGo.transform, pos.x, pos.y, 0)
	end, self._monsterCfg, self._terrainCfg)
end

function ThrowShellsGameView:_beginDrag(data)
	if self._playState == PLAY_STATE.IDLING then
		self._playState = PLAY_STATE.SHOOTING

		goutil.setActive(self._goCancel, true)
		goutil.setActive(self._goRange, true)
	end
end

function ThrowShellsGameView:_draging(data)
	if self._playState == PLAY_STATE.SHOOTING then
		local startPos = data.pressPosition
		local endPos = data.position
		local len = GameUtil.getVector2Distance(endPos, startPos)
		local angle = math.asin((endPos.y - startPos.y) / len)

		if endPos.x < startPos.x then
			angle = math.pi - angle
		elseif angle < 0 then
			angle = math.pi * 2 + angle
		end

		self._angle = angle + math.pi
		self._angle360 = self._angle / (2 * math.pi) * 360 % 360

		if self._propCfg.range[1] < self._angle360 and self._angle360 < self._propCfg.range[2] then
			self:_drawInTrail(startPos, endPos, len)
			self:_drawOutTrail(len, self._angle)
		else
			self:_drawInTrail(startPos, endPos, len)
			self:_drawOutTrail(len, self._angle, 1)
		end
	end
end

function ThrowShellsGameView:_endDrag(data)
	local x1, y1 = Framework.TransformUtil.GetPos(self._goCancel.transform, 0, 0, 0)
	local cancelPos = {
		x = x1 * 360,
		y = y1 * 360
	}
	local x2, y2 = Framework.TransformUtil.GetPos(self._dragdot.transform, 0, 0, 0)
	local pressPos = {
		x = x2 * 360,
		y = y2 * 360
	}

	if GameUtil.getVector2Distance(cancelPos, pressPos) < CANCEL_RADIUS then
		self._playState = PLAY_STATE.IDLING
	elseif self._playState == PLAY_STATE.SHOOTING then
		if self._propCfg.range[1] <= self._angle360 and self._angle360 <= self._propCfg.range[2] then
			self:_playShootEffect()
		else
			self._playState = PLAY_STATE.IDLING
		end
	end

	goutil.setActive(self._inTrail, false)
	goutil.setActive(self._outTrail, false)
	goutil.setActive(self._goCancel, false)
	goutil.setActive(self._goRange, false)
end

function ThrowShellsGameView:_shoot()
	self._playState = PLAY_STATE.FLYING
	self._tickedTime = 0
	self._test = 0
	self._shellX = self._mainActor.pos.x
	self._shellY = self._mainActor.pos.y

	Framework.TransformUtil.SetLocalPos(self._shellTrans, self._shellX, self._shellY, 0)
	goutil.setActive(self._shell, true)
	goutil.setActive(self._gamestartTip, false)

	local url = langPara("fx_ui_xinxiyamianban/xinxiyaxiaoyouxi/fx_ui_dandao/%s.prefab", self._propCfg.qiangkou)

	self._shootEffect = UIEffectManager.instance:playEffect(self, url, self._goShootEffect, 0, 0, false, nil, nil, function(o, eff)
		return
	end)

	self._shootEffect:setParent(self._goShootEffect.transform)
	self._shootEffect:setScale(1)

	local url = langPara("fx_ui_xinxiyamianban/xinxiyaxiaoyouxi/fx_ui_dandao/%s.prefab", self._propCfg.path)

	self._shellPathEff = UIEffectManager.instance:playEffect(self, url, self._goEffectshell, 0, 0, true, nil, nil, function(o, eff)
		return
	end)

	self._shellPathEff:setParent(self._goEffectshell.transform)
	self._shellPathEff:setScale(1)
	settimer(0, self._tickFly, self, true)
end

function ThrowShellsGameView.endPosCheck(a, b, x, y)
	return a * a + b * b + 20000 >= x * x + y * y
end

function ThrowShellsGameView:_drawInTrail(startPos, endPos, len)
	goutil.setActive(self._inTrail, true)

	local partNum = math.max(math.floor(len / IN_TRAIL_INTERVAL), 1)
	local x1 = startPos.x
	local y1 = startPos.y
	local xInterval = (endPos.x - startPos.x) / partNum
	local yInterval = (endPos.y - startPos.y) / partNum
	local angle = self._angle360
	local index = 1

	Framework.TransformUtil.SetLocalPos(self._dragdot.transform, endPos.x - startPos.x, endPos.y - startPos.y, 0)

	while not ThrowShellsGameView.endPosCheck(x1 - startPos.x + xInterval, y1 - startPos.y + yInterval, endPos.x - startPos.x, endPos.y - startPos.y) do
		x1 = x1 + xInterval
		y1 = y1 + yInterval
		xInterval = xInterval * 1.1
		yInterval = yInterval * 1.1

		local item

		if index > #self._inTrailList then
			item = self._inTrailPointPool:fetchObject()

			goutil.setActive(item.gameObject, true)
			table.insert(self._inTrailList, item)
		else
			item = self._inTrailList[index]
		end

		Framework.TransformUtil.SetLocalPos(item.transform, x1 - startPos.x, y1 - startPos.y, 0)
		Framework.TransformUtil.SetLocalRotation(item.transform, 0, 0, angle)

		index = index + 1

		if index > MAX_IN_TRAIL_POINT_NUM then
			break
		end
	end

	local len = #self._inTrailList

	for i = index, len do
		self._inTrailPointPool:returnObject(self._inTrailList[i])

		self._inTrailList[i] = nil
	end
end

function ThrowShellsGameView:_drawOutTrail(len, angle, isRed)
	goutil.setActive(self._outTrail, true)

	self._horizonStartV = 10 * len * math.cos(angle)
	self._verticalStartV = 10 * len * math.sin(angle)

	local horizonStartV = self._horizonStartV
	local verticalStartV = self._verticalStartV
	local x1 = 0
	local y1 = 0
	local index = 1
	local length = 0

	while length < self._propCfg.leaderLen do
		local dx = horizonStartV * FRAME_TIME
		local dy = verticalStartV * FRAME_TIME

		x1 = x1 + dx
		y1 = y1 + dy
		length = math.sqrt(math.pow(math.abs(dx), 2) + math.pow(math.abs(dy), 2)) + length

		local h_acc = (self._windFactor - self._airDrag * horizonStartV) / self._propCfg.quality

		horizonStartV = horizonStartV + h_acc * FRAME_TIME

		local v_acc = -(self._gravity + self._airDrag * verticalStartV) / self._propCfg.quality

		verticalStartV = verticalStartV + v_acc * FRAME_TIME

		local item

		if index > #self._outTrailList then
			item = self._outTrailPointPool:fetchObject()

			goutil.setActive(item.gameObject, true)
			table.insert(self._outTrailList, item)
		else
			item = self._outTrailList[index]
		end

		local comp = item.gameObject:GetComponent(typeof(UnityEngine.UI.Image))

		if comp then
			local color = Framework.ColorUtil.ParseColor("#ffffff")

			if isRed == 1 then
				comp.color = Framework.ColorUtil.ParseColor("#ff0000")
			end
		end

		Framework.TransformUtil.SetLocalPos(item.transform, x1, y1, 0)

		index = index + 1

		if index > MAX_OUT_TRAIL_POINT_NUM then
			break
		end
	end

	local len = #self._outTrailList

	for i = index, len do
		self._outTrailPointPool:returnObject(self._outTrailList[i])

		self._outTrailList[i] = nil
	end
end

function ThrowShellsGameView:_tickFly()
	local deltaTime = UnityEngine.Time.deltaTime

	self._tickedTime = self._tickedTime + deltaTime
	self._test = self._test + 1

	if self._tickedTime > FRAME_TIME then
		self._tickedTime = self._tickedTime - FRAME_TIME

		local dx = self._horizonStartV * FRAME_TIME
		local dy = self._verticalStartV * FRAME_TIME

		self._shellX = dx + self._shellX
		self._shellY = dy + self._shellY

		local h_acc = (self._windFactor - self._airDrag * self._horizonStartV) / self._propCfg.quality

		self._horizonStartV = self._horizonStartV + h_acc * FRAME_TIME

		local v_acc = -(self._gravity + self._airDrag * self._verticalStartV) / self._propCfg.quality

		self._verticalStartV = self._verticalStartV + v_acc * FRAME_TIME

		local angle360 = math.atan(dy / dx) * 180 / math.pi

		if self._shellPathEff then
			if dx < 0 then
				angle360 = angle360 + 180
			end

			self._shellPathEff:setLocalEulerAngle(0, 0, angle360)
		end

		Framework.TransformUtil.SetLocalPos(self._shellTrans, self._shellX, self._shellY, 0)

		if self._shellX > self._screenWidth or self._shellY < 0 or self._shellX < 0 then
			self:_flyEnd()
			self:_playMissTip()
		end

		if self._throwShellSceneMgr:checkCollide({
			x = self._shellX,
			y = self._shellY
		}, SHELL_RADIUS, self._propCfg.damage) then
			self:_flyEnd()
		end
	end

	if not self._terrainCfg.isSingle then
		local width = self._contentTrans.sizeDelta.x

		self._scrollView.horizontalNormalizedPosition = self._shellX / width
	end
end

function ThrowShellsGameView:_flyEnd()
	removetimer(self._tickFly, self)
	self:_playBoomEffect()
	self:_refreshFengLi()

	self._playState = PLAY_STATE.IDLING
	self._roundNum = self._roundNum + 1

	self:_refreshRound()

	if self._roundNum > self._gameCfg.round then
		self:_openResultView(false)
	end

	GlobalDispatcher:dispatch(GlobalNotify.ThrowShellsRoundEnd)
end

function ThrowShellsGameView:_refreshRound()
	self._txtRound.text = langPara("%s / %s", self._roundNum, self._gameCfg.round)
end

function ThrowShellsGameView:_refreshMonsterBlood(monsterId, blood)
	if monsterId and self._monsterDead[monsterId] ~= nil and blood == 0 then
		self._monsterDead[monsterId] = true
	end

	local allDead = true

	for k, v in pairs(self._monsterDead) do
		if not v then
			allDead = false
		end
	end

	if blood == 0 then
		self:_playDeadEffect(monsterId, allDead)
	end

	if monsterId and self._monsterUI[monsterId] and self._monsterCfg[monsterId] then
		self._monsterUI[monsterId].blood:SetValue(blood / self._monsterCfg[monsterId].blood)
	end
end

function ThrowShellsGameView:_playDeadEffect(monsterId, allDead)
	if allDead then
		self:_openResultView(true)
	end
end

function ThrowShellsGameView:_openResultView(isPass)
	local params = {}

	params.txtRound = langPara("回合数：%s/%s", math.min(self._roundNum, self._gameCfg.round), self._gameCfg.round)

	function params.closeCallBack()
		local reChall = self._gameCfg.stageId < ThrowShellsModel.instance:getBarrierId()

		if not reChall then
			self:_endGame(isPass)
		end

		self:close()
	end

	params.isPass = isPass

	UIStateManager.instance:open(ViewName.ThrowShellsResultView, params)
end

function ThrowShellsGameView:_endGame(isPass)
	local barrierId = ThrowShellsModel.instance:getBarrierId()
	local serverKey = ThrowShellsModel.instance:getServerKey()
	local clientKey = ThrowShellsModel.instance:getClientKey()

	serverKey = GenEncryptedKeyUtil.dxor(serverKey, clientKey)

	local encryptedKey = 0

	local function encrypt(num)
		encryptedKey = num % 2 == 0 and encryptedKey + (num + serverKey) * 5381 or encryptedKey + (num + clientKey) * 31
	end

	encrypt(barrierId)
	encrypt(isPass and 1 or 0)
	ThrowingGameAgent.instance:sendPM_ThrowingGameEndGameReq(barrierId, isPass, encryptedKey)
	self:close()
end

function ThrowShellsGameView:_clickClose()
	local reChall = self._gameCfg.stageId < ThrowShellsModel.instance:getBarrierId()

	TipsFacade.instance:openPopupWindow("提示", reChall and "是否确认退出挑战" or "是否确认退出游戏 将会扣除游戏次数", function()
		if not reChall then
			self:_endGame(false)
		else
			self:close()
		end
	end, function()
		return
	end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
end

function ThrowShellsGameView:_onScrollValueChanged(vec2)
	if self._checkDuopingTip and vec2.x < 1 and vec2.x > 0.1 then
		goutil.setActive(self._duopingTip, false)

		self._checkDuopingTip = false
	end

	if not self._terrainCfg.isSingle then
		local maxX = (1 + vec2.x) * self._screenWidth / 2
		local monsterPos = self._throwShellSceneMgr:getMonstersPos()

		for i = 1, MAX_MONSTER_NUM do
			if monsterPos[i] and maxX < monsterPos[i].x then
				goutil.setActive(self._arrows[i], true)
				Framework.TransformUtil.SetLocalPos(self._arrows[i].transform, 0, monsterPos[i].y, 0)
			else
				goutil.setActive(self._arrows[i], false)
			end
		end
	end
end

function ThrowShellsGameView:_playMissTip()
	goutil.setActive(self._missTip, true)

	self._missTipTween = TweenUtil.ValueTo(1, 0, 1.7, nil, function()
		goutil.setActive(self._missTip, false)
	end, self, DG.Tweening.Ease.Linear)
end

function ThrowShellsGameView:_playFengEffect()
	if self._fengEffect then
		UIEffectManager.instance:stopEffect(self._fengEffect)

		self._fengEffect = nil
	end

	local url = "fx_ui_xinxiyamianban/xinxiyaxiaoyouxi/fx_ui_dandao/fx_ui_dandaofeng.prefab"

	self._fengEffect = UIEffectManager.instance:playEffect(self, url, self._goEffctFeng, 0, 0, true, nil, function()
		return
	end, function(o, eff)
		return
	end)

	self._fengEffect:setScaleXYZ(checknumber(self._airForce) < 0 and -1 or 1, 1, 1)
	self._fengEffect:setParent(self._goEffctFeng.transform)
end

function ThrowShellsGameView:_playBoomEffect()
	if self._shellPathEff then
		UIEffectManager.instance:stopEffect(self._shellPathEff)

		self._shellPathEff = nil
	end

	local url = langPara("fx_ui_xinxiyamianban/xinxiyaxiaoyouxi/fx_ui_dandao/%s.prefab", self._propCfg.boom)

	self._boomEffect = UIEffectManager.instance:playEffect(self, url, self._goEffectshell, 0, 0, false, nil, function()
		return
	end, function(o, eff)
		return
	end)

	self._boomEffect:setScale(1)
	self._boomEffect:setParent(self._goEffectshell.transform)
	settimer(0.6, self._hideShell, self, false)
end

function ThrowShellsGameView:_hideShell()
	removetimer(self._hideShell, self)
	goutil.setActive(self._shell, false)
end

function ThrowShellsGameView:_onEffectLoaded(res)
	if res and res.IsSuccess then
		res:Retain()

		self._res = res
		self._spineGO = goutil.cloneAndSetParent(res:GetMainAsset(), self._mainActorAni.transform)

		Framework.TransformUtil.SetLocalScale(self._spineGO.transform, 0.16, 0.16, 0)
		Framework.TransformUtil.SetLocalPos(self._spineGO.transform, 0, 0, 0)
		self:_playIdleEffect()
	end
end

function ThrowShellsGameView:_playShootEffect()
	RoleObjectPool.instance:playAnimation(self._mainActorAni, self._propCfg.shoot, false, function()
		RoleObjectPool.instance:playAnimation(self._mainActorAni, self._propCfg.idle, true, nil, true)
	end, true)

	local HIT_TIME = 0.3

	removetimer(self._shoot, self)
	settimer(HIT_TIME, self._shoot, self, false)
end

function ThrowShellsGameView:_playIdleEffect()
	RoleObjectPool.instance:playAnimation(self._mainActorAni, self._propCfg.idle, true, nil, true)
end

function ThrowShellsGameView:_refreshFengLi()
	self._airForce = math.random(self._gameCfg.airForce[1], self._gameCfg.airForce[2])
	self._windFactor = self._airForce * self._propCfg.wind
	self._gravity = self._GRAVITY_ACC * self._propCfg.quality * self._propCfg.gravity
	self._airDrag = self._AIR_DRAG * self._propCfg.airDragFactor

	self:_playFengEffect()

	self._txtFengli.text = langPara("风力 %s %s级", self._airForce > 0 and "右向" or "左向", math.abs(self._airForce))
end

return ThrowShellsGameView
