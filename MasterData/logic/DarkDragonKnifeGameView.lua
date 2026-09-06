-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/view/DarkDragonKnifeGameView.lua

module("logic.extensions.darkdragonknife.view.DarkDragonKnifeGameView", package.seeall)

local DarkDragonKnifeGameView = class("DarkDragonKnifeGameView", ViewComponent)
local SKILL_STATE_ON = 1
local SKILL_STATE_ING = 2
local SKILL_STATE_OFF = 3
local BORN_RADIUS = 600
local FAR_RADIUS = 300
local NEAR_RADIUS = 100
local ACTOR_RADIUS = 30
local COMBO_MAINTAIN_TIME = 3
local HIT_TIME = 0.733
local TICK_TIME = 0.027

function DarkDragonKnifeGameView:ctor()
	DarkDragonKnifeGameView.super.ctor(self)
end

function DarkDragonKnifeGameView:buildUI()
	DarkDragonKnifeGameView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._startTip = self:getGo("gamestartTip")
	self._btnStartGame = self:getBtn("gamestartTip/btnStartGame")
	self._txtCombo = self:getGo("combo/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self._txtTime = self:getTxt("ui/txtTime")
	self._txtKill = self:getTxt("ui/txtKill")
	self._scoreBarSli = self:getSlider("mainContainer/tower/bloodSlider")
	self._towerAnimation = self:getGo("mainContainer/tower/animation")
	self._goTower = self:getGo("mainContainer/tower")
	self._scoreBarSli2 = self:getSlider("totalBloodSlider")
	self._headIcon = self:getGo("totalBloodSlider/imgHeadIcon")
	self._playerName = self:getTxt("totalBloodSlider/txtName")
	self._txtBlood = self:getTxt("totalBloodSlider/txtBlood")
	self._btnSkill = self:getBtn("btnSkill")
	self._effectSkillBtn = self:getGo("btnSkill/effect")
	self._killShow = self:getGo("mainContainer/mainActor/kill")
	self._txtKillShow = self:getGo("mainContainer/mainActor/kill/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self._joystickBg = self:getGo("joystickview/joystickArea/joystickbackground")
	self._virtualJoystick = goutil.addComponentOnce(self._joystickBg, typeof(VirtualJoystick))
	self._initBgPos = Vector2.New(Framework.TransformUtil.GetLocalPos(self._joystickBg.transform, 0, 0, 0))
	self._joystickCtrl = goutil.findChildComponent(self.mainGO, "joystickview", typeof(ClickToShowJoystick))

	self._joystickCtrl.gameObject:SetActive(true)

	self._mainBallRectTrans = self:getGo("mainContainer/mainActor"):GetComponent(typeof(UnityEngine.RectTransform))
	self._mainAreaRectTrans = self:getGo("mainArea"):GetComponent(typeof(UnityEngine.RectTransform))
	self._goMainActor = self:getGo("mainContainer/mainActor")

	local areaSizeDelta = self._mainAreaRectTrans.sizeDelta

	self._mainAreaSize = Vector2.New(areaSizeDelta.x, areaSizeDelta.y)
	self._mainAreaMinPoint = -0.5 * self._mainAreaSize
	self._mainActor = {}
	self._mainActor.velocity = Vector2.zero
	self._mainActor.pos = Vector2.zero
	self._mainActor.rectTrans = self._mainBallRectTrans
	self._mainActor.radius = ACTOR_RADIUS
	self._mainActor.go = self:getGo("mainContainer/mainActor")
	self._rigidbody = self._mainActor.go:GetComponent(typeof(UnityEngine.Rigidbody2D))
	self._monsters = {}
	self._bulletList = {}
	self._tangentVector2 = Vector2.New()
	self._deadEffList = {}
	self._monsterDeadEffect = self:getGo("monsterDeadEffect")
	self._mainContainer = self:getGo("mainContainer")
	self._itemCenter = self:getGo("itemCenter").transform
	self._monsterCellGo = self:getGo("itemCenter/monster")

	goutil.setActive(self._monsterCellGo, false)

	local function createFunc()
		local go = goutil.cloneAndSetParent(self._monsterCellGo, self._mainContainer.transform)

		return {
			gameObject = go,
			transform = go.transform,
			class = GameUtil.AddLuaOnce(go, DDKMonster)
		}
	end

	local function disposeFunc(item)
		return
	end

	local function resetFunc(item)
		item.class:onExit()
		goutil.setActive(item.gameObject, false)
	end

	self._monsterPool = ObjectPool.New(25, createFunc, disposeFunc, resetFunc)
	self._bulletCellGo = self:getGo("itemCenter/bullet")

	goutil.setActive(self._bulletCellGo, false)

	local function createFunc()
		local go = goutil.cloneAndSetParent(self._bulletCellGo, self._itemCenter)

		return {
			gameObject = go,
			transform = go.transform,
			class = GameUtil.AddLuaOnce(go, DDKBullet)
		}
	end

	local function disposeFunc(item)
		return
	end

	local function resetFunc(item)
		item.class:onExit()
		goutil.setActive(item.gameObject, false)
	end

	self._bulletPool = ObjectPool.New(25, createFunc, disposeFunc, resetFunc)
end

function DarkDragonKnifeGameView:bindEvents()
	DarkDragonKnifeGameView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._virtualJoystick:AddDownListener(self._onJoystickDown, self)
	self._virtualJoystick:AddUpListener(self._onJoystickUp, self)
	self._virtualJoystick:AddDragListener(self._onJoystickDrag, self)
	self._btnSkill:AddClickListener(self._skillOpen, self)
	self._btnStartGame:AddClickListener(self._onClickStartGame, self)
end

function DarkDragonKnifeGameView:unbindEvents()
	DarkDragonKnifeGameView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._virtualJoystick:RemoveDownListener()
	self._virtualJoystick:RemoveUpListener()
	self._virtualJoystick:RemoveDragListener()
	self._btnSkill:RemoveClickListener()
	self._btnStartGame:RemoveClickListener()
end

function DarkDragonKnifeGameView:destroyUI()
	DarkDragonKnifeGameView.super.destroyUI(self)
	self._monsterPool:clear()
	self._bulletPool:clear()
end

function DarkDragonKnifeGameView:onEnter()
	DarkDragonKnifeGameView.super.onEnter(self)

	self._playerName.text = RoleModel.instance:getUserName()
	self._isRunning = false

	local gameId = 1
	local propId = DDragonKModel.instance:getPropId()
	local actId = DDragonKModel.instance:getActId()
	local actCfg = DDragonKConfig.instance:getActCfg(actId)
	local propPlanId = actCfg.propPlanId

	self._scorePlan = actCfg.scorePlan
	self._gameCfgList = DDragonKConfig.instance:getGameCfgList(gameId)
	self._actorCfg = DDragonKConfig.instance:getActorCfg(gameId)
	self._towerCfg = self._actorCfg[DDragonKModel.ACTOR_TYPE_TOWER]
	self._propCfg = DDragonKConfig.instance:getPropCfg(propPlanId, propId)
	self._propAttackIntervalTime = 10 / checknumber(self._propCfg.attackSpeed)
	self._propAttackRange = self._propCfg.length
	self._propAttackDamage = self._propCfg.damage
	self._mainActorVelocity = self._propCfg.moveSpeed

	GlobalDispatcher:addListener(GlobalNotify.DarkDragonKnifeDamage, self._damgeTower, self)
	GlobalDispatcher:addListener(GlobalNotify.DarkDragonKnifeBornBullet, self._bornBullet, self)
	GlobalDispatcher:addListener(GlobalNotify.DarkDragonKnifeBulletAttack, self._bulletAttack, self)
	GlobalDispatcher:addListener(GlobalNotify.DarkDragonKnifeGameStart, self._onStartGameRes, self)
	self:_initDataAndUI()
end

function DarkDragonKnifeGameView:_onEffectLoaded(uiEffect)
	uiEffect:setParent(self._towerAnimation.transform)
	uiEffect:setScale(0.13)
	uiEffect:setLocalPos()

	self._sg = uiEffect.effGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
	self._effLoaded = true

	self:_playTowerIdleAnimation()
end

function DarkDragonKnifeGameView:onEnterFinished()
	DarkDragonKnifeGameView.super.onEnterFinished(self)
end

function DarkDragonKnifeGameView:onExit()
	DarkDragonKnifeGameView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DarkDragonKnifeDamage, self._damgeTower, self)
	GlobalDispatcher:removeListener(GlobalNotify.DarkDragonKnifeBornBullet, self._bornBullet, self)
	GlobalDispatcher:removeListener(GlobalNotify.DarkDragonKnifeBulletAttack, self._bulletAttack, self)
	GlobalDispatcher:removeListener(GlobalNotify.DarkDragonKnifeGameStart, self._onStartGameRes, self)

	if self._meanTimeTween then
		self._meanTimeTween:Kill(false)

		self._meanTimeTween = nil
	end

	if self._skillEffect then
		UIEffectManager.instance:stopEffect(self._skillEffect)

		self._skillEffect = nil
	end

	if self._towerEff then
		UIEffectManager.instance:stopEffect(self._towerEff)

		self._towerEff = nil
	end

	if self._towerDeadEffect then
		UIEffectManager.instance:stopEffect(self._towerDeadEffect)

		self._towerDeadEffect = nil
	end

	for k, v in pairs(self._deadEffList) do
		UIEffectManager.instance:stopEffect(v)
	end

	table.clear(self._deadEffect)
	self:_resetAll()

	if self._mainActor.class then
		self._mainActor.class:onDestroy()
	end

	self._mainActor.class = nil

	removetimer(self._playTowerIdleAnimation, self)
	removetimer(self._tick, self)
	removetimer(self._onSecond, self)
	removetimer(self._stopGame, self)
end

function DarkDragonKnifeGameView:onExitFinished()
	DarkDragonKnifeGameView.super.onExitFinished(self)
end

function DarkDragonKnifeGameView:_initDataAndUI()
	self._mainActor.class = DDKMainActor.New(self._goMainActor, self, self._propCfg, self:_ActorPath())
	self._animationScale = 1

	Framework.TransformUtil.SetLocalPos(self._joystickBg.transform, self._initBgPos.x, self._initBgPos.y, 0)

	self._tickedTime = 0
	self._cutTime = 0
	self._tickBornMonsterTime = 0
	self._txtTime.text = langPara("游戏时长：%.2f", self._tickedTime)
	self._towerBlood = self._towerCfg.blood

	self._scoreBarSli:SetValue(1)

	self._killNum = 0

	self:_refreshKillNum()

	self._skill_state = SKILL_STATE_OFF
	self._skillTime = 0
	self._skillKillNum = 0

	goutil.setActive(self._btnSkill.gameObject, false)

	self._comboNum = 0
	self._comboTime = 0

	goutil.setActive(self._killShow, false)
	self:_refreshTowerBlood()
	goutil.setActive(self._startTip, true)

	local startPos = {
		x = -150,
		y = 0
	}

	Framework.TransformUtil.SetAnchoredPos(self._mainActor.rectTrans, startPos.x, startPos.y)
	self._mainActor.class:setDirection(startPos.x < 0)

	self._mainActor.pos = startPos

	local url = self:_towerPath()

	self._towerEff = UIEffectManager.instance:playEffect(self.view, url, self._towerAnimation, 0, 0, true, nil, nil, self._onEffectLoaded, self)

	goutil.setActive(self._goTower, true)

	self._monsterDeadIndex = 1

	self:_refreshComboNum()

	self._maxTime = checknumber(DDragonKConfig.instance:getCommonCfg("MAX_GAME_TIME")) + 12
end

function DarkDragonKnifeGameView:_ActorPath()
	return {
		"lihui_spine/10139_arui_lihui/10139_arui_lihui-ui_p.prefab"
	}
end

function DarkDragonKnifeGameView:_towerPath()
	return "fx_ui_longzun/xiaoyouxi/aruilong/aruilong-ui_p.prefab"
end

function DarkDragonKnifeGameView:_resetAll()
	for k, v in pairs(self._monsters) do
		self._monsterPool:returnObject(v)
	end

	table.clear(self._monsters)

	for k, v in pairs(self._bulletList) do
		self._bulletPool:returnObject(v)
	end

	table.clear(self._bulletList)
end

function DarkDragonKnifeGameView:_onJoystickUp()
	self._mainActor.velocity = Vector2.zero
end

function DarkDragonKnifeGameView:_onJoystickDown()
	return
end

function DarkDragonKnifeGameView:_onJoystickDrag(x, y)
	self._mainActor.velocity = self._mainActorVelocity * Vector2.New(x, y)
end

function DarkDragonKnifeGameView:_onClickStartGame()
	if not self._isRunning then
		self:_startGame()
	end
end

function DarkDragonKnifeGameView:_moveMainActor(deltaTime, velocity)
	local actor = self._mainActor
	local pos = actor.pos
	local vel = velocity and velocity or actor.velocity

	pos = pos + deltaTime * vel

	self:_moveMainActorVelocity(deltaTime, vel)
end

function DarkDragonKnifeGameView:_moveContrary(deltaTime)
	self:_moveMainActorVelocity(deltaTime, self._tangentVector2)
end

function DarkDragonKnifeGameView:_moveMainActorVelocity(deltaTime, velocity)
	self._rigidbody.velocity = velocity * 0.01

	local x, y, z = Framework.TransformUtil.GetLocalPos(self._mainActor.go.transform, 0, 0, 0)
	local pos = self._mainActor.pos

	pos.x = x
	pos.y = y

	if Mathf.Abs(self._mainActor.velocity.x - 0) > 1e-05 then
		self._mainActor.class:setDirection(self._mainActor.velocity.x < 0)
	end
end

function DarkDragonKnifeGameView:_startGame()
	local clientKey = ServerTime.nowServerLook()

	DDragonKModel.instance:setClientKey(clientKey)

	local actId = DDragonKModel.instance:getActId()

	DarkDragonKnifeAgent.instance:sendPM_DarkDragonKnifeStartGameReq(actId, clientKey)
end

function DarkDragonKnifeGameView:_onStartGameRes()
	goutil.setActive(self._startTip, false)

	self._isRunning = true

	settimer(0, self._tick, self, true)
	settimer(1, self._onSecond, self)
end

function DarkDragonKnifeGameView:_tick()
	if not self._isRunning then
		return
	end

	local deltaTime = UnityEngine.Time.deltaTime

	self._tickedTime = self._tickedTime + deltaTime
	self._tickBornMonsterTime = self._tickBornMonsterTime + deltaTime

	if self._tickedTime > self._maxTime then
		self:_playDeadEffect()
	end

	self._txtTime.text = langPara("游戏时长：%.2f", self._tickedTime)

	self:_updateMonster()
	self:_moveMainActor(deltaTime)
	self:_checkCollider(deltaTime)
	self:_tickSkill(deltaTime)
	self:_tickCombo(deltaTime)
end

function DarkDragonKnifeGameView:_onSecond()
	self:_updateSiblingIndex()
end

function DarkDragonKnifeGameView:_updateSiblingIndex()
	local t = {}
	local childCount = self._mainContainer.transform.childCount

	for i = 1, childCount do
		local trans = self._mainContainer.transform:GetChild(i - 1)
		local go = trans.gameObject

		if go and go.activeSelf then
			table.insert(t, go)
		end
	end

	table.sort(t, function(a, b)
		local x1, y1 = Framework.TransformUtil.GetLocalPos(a.transform, 0, 0, 0)
		local x2, y2 = Framework.TransformUtil.GetLocalPos(b.transform, 0, 0, 0)

		return y2 < y1
	end)

	for i, go in ipairs(t) do
		go.transform:SetSiblingIndex(i)
	end
end

function DarkDragonKnifeGameView:_checkCollider(deltaTime)
	self._cutTime = self._cutTime + deltaTime

	if self._cutTime > self._propAttackIntervalTime then
		self._cutTime = self._cutTime - self._propAttackIntervalTime

		local frameKillNum = 0
		local isMoving = self._mainActor.velocity.x ~= 0 or self._mainActor.velocity.y ~= 0

		self._mainActor.class:_playAnimationAndEffect(self._animationScale, isMoving)

		for k, v in pairs(self._bulletList) do
			if v.class:checkCollide(self._mainActor.pos, self._propAttackRange) then
				self._bulletPool:returnObject(v)

				self._bulletList[k] = nil

				self:_addKillNum()
				self:_addCombo()

				frameKillNum = frameKillNum + 1
			end
		end

		for k, v in pairs(self._monsters) do
			if v.class:checkCollide(self._mainActor.pos, self._propAttackRange) and v.class:knifeDamage(self._propAttackDamage) then
				self:_playMonsterDeadEffect(v.class:getPos())
				self._monsterPool:returnObject(v)

				self._monsters[k] = nil

				self:_addKillNum()
				self:_addCombo()

				frameKillNum = frameKillNum + 1
			end
		end

		self:_showMeanTimeKill(frameKillNum)
	end

	for k, v in pairs(self._bulletList) do
		if v.class:checkCollide(self._mainActor.pos, self._mainActor.radius) then
			self._bulletPool:returnObject(v)

			self._bulletList[k] = nil
		end
	end
end

function DarkDragonKnifeGameView:_updateMonster()
	if self._tickBornMonsterTime > TICK_TIME then
		self._tickBornMonsterTime = self._tickBornMonsterTime - TICK_TIME

		local id

		for k, v in ipairs(self._gameCfgList) do
			if v.gameTime > self._tickedTime then
				id = k

				break
			end
		end

		local cfg = id == nil and self._gameCfgList[#self._gameCfgList] or self._gameCfgList[id]
		local maxProb = 1000
		local prob = math.random(1, maxProb)

		if prob <= cfg.nearProbability then
			for i = 1, cfg.nearNum do
				self:_bornMonster(DDragonKModel.ACTOR_TYPE_MELEE, cfg)
			end
		end

		if prob > maxProb - cfg.farProbability then
			for i = 1, cfg.farNum do
				self:_bornMonster(DDragonKModel.ACTOR_TYPE_DISTANT, cfg)
			end
		end
	end
end

function DarkDragonKnifeGameView:_bornMonster(type, gameCfg)
	local item = self._monsterPool:fetchObject()

	goutil.setActive(item.gameObject, true)
	item.class:setCfg(type, gameCfg, self._actorCfg[type], self.view)

	local angle = math.pi * 2 * math.random()
	local x = math.cos(angle) * BORN_RADIUS
	local y = math.sin(angle) * BORN_RADIUS

	Framework.TransformUtil.SetLocalPos(item.transform, x, y, 0)

	local targetRadius = type == DDragonKModel.ACTOR_TYPE_MELEE and NEAR_RADIUS or FAR_RADIUS
	local tx = math.cos(angle) * targetRadius
	local ty = math.sin(angle) * targetRadius

	item.class:beginMove({
		x = tx,
		y = ty
	})

	self._monsters[item] = item
end

function DarkDragonKnifeGameView:_bornBullet(params)
	local item = self._bulletPool:fetchObject()

	goutil.setActive(item.gameObject, true)
	item.class:setCfg(params, self._actorCfg[DDragonKModel.ACTOR_TYPE_DISTANT], self.view)
	Framework.TransformUtil.SetLocalPos(item.transform, params.pos.x, params.pos.y, 0)

	local len = GameUtil.getVector2Distance(params.pos, {
		x = 0,
		y = 0
	})
	local angle = math.asin(params.pos.y / len)

	if params.pos.x < 0 then
		angle = math.pi - angle
	elseif angle < 0 then
		angle = math.pi * 2 + angle
	end

	Framework.TransformUtil.SetLocalRotation(item.transform, 0, 0, 360 * angle / (2 * math.pi) + 90)

	local tx = math.cos(angle) * NEAR_RADIUS
	local ty = math.sin(angle) * NEAR_RADIUS

	item.class:beginMove({
		x = tx,
		y = ty
	})

	self._bulletList[item.gameObject] = item
end

function DarkDragonKnifeGameView:_bulletAttack(damageVal, mGo)
	self:_damgeTower(damageVal)
	self._bulletPool:returnObject(self._bulletList[mGo])

	self._bulletList[mGo] = nil
end

function DarkDragonKnifeGameView:_playDeadEffect()
	if self._isRunning then
		removetimer(self._tick, self)
		removetimer(self._onSecond, self)

		for k, v in pairs(self._monsters) do
			v.class:onPause()
		end

		for k, v in pairs(self._bulletList) do
			v.class:onExit()
		end

		self._joystickCtrl:StopJoystickMove()
		goutil.setActive(self._goTower, false)

		local deadUrl = "xiaoyouxi/xiaoanlongyouxi/fx_xiaoyouxi_siwang_02.prefab"

		self._towerDeadEffect = UIEffectManager.instance:playEffect(self, deadUrl, self.mainGO, 0, 0, false, nil, function()
			return
		end, function(o, eff)
			return
		end)

		self._towerDeadEffect:setParent(self.mainGO.transform)
		self._towerDeadEffect:setLocalPos(0, 0, 0)
		self._towerDeadEffect:setScale(20)
		settimer(1, self._stopGame, self, false)

		self._isRunning = false
	end
end

function DarkDragonKnifeGameView:_stopGame()
	removetimer(self._stopGame, self)

	local scoreCfg = DDragonKConfig.instance:getScoreCfg(self._scorePlan)
	local scoreList = {}

	for k, v in pairs(scoreCfg) do
		table.insert(scoreList, v)
	end

	table.sort(scoreList, function(a, b)
		return a.id < b.id
	end)

	local totalScore = 0

	for k, v in ipairs(scoreList) do
		if self._tickedTime > v.gameTime then
			totalScore = v.score
		end
	end

	local params = {}

	params.totalScore = totalScore
	params.tickTime = math.floor(self._tickedTime)

	function params.closeCallBack()
		self:close()
	end

	UIStateManager.instance:open(ViewName.DdkResultView, params)
end

function DarkDragonKnifeGameView:_damgeTower(hurt)
	self._towerBlood = math.max(self._towerBlood - checknumber(hurt), 0)

	local sg = self._sg

	if sg then
		local clipName = "hit"

		sg.startingAnimation = clipName
		sg.AnimationState.TimeScale = 1

		sg.AnimationState:SetAnimation(0, clipName, false)
		sg:Update(0)
		removetimer(self._playTowerIdleAnimation, self)
		settimer(HIT_TIME, self._playTowerIdleAnimation, self, false)
	end

	self:_refreshTowerBlood()
end

function DarkDragonKnifeGameView:_refreshTowerBlood()
	local value = self._towerBlood / self._towerCfg.blood

	self._scoreBarSli:SetValue(value)
	self._scoreBarSli2:SetValue(value)

	self._txtBlood.text = langPara("%s/%s", self._towerBlood, self._towerCfg.blood)

	if self._towerBlood == 0 then
		self:_playDeadEffect()
	end
end

function DarkDragonKnifeGameView:_addKillNum()
	self._skillKillNum = self._skillKillNum + 1
	self._killNum = self._killNum + 1

	if self._skill_state == SKILL_STATE_OFF and self._skillKillNum >= checknumber(DDragonKConfig.instance:getCommonCfg("ULTIMATE_ACTIVE_NUM")) then
		self._skill_state = SKILL_STATE_ON

		goutil.setActive(self._btnSkill.gameObject, true)

		self._skillKillNum = 0

		local effectPath = "fx_ui_fuli/fx_ui_fuli_lingqu.prefab"

		self._skillEffect = UIEffectManager.instance:playEffect(self, effectPath, self._effectSkillBtn.transform, 0, 0, true, false, nil, function(target, eff)
			eff:setParent(self._effectSkillBtn.transform)
			eff:setScale(0.7)
			eff:setLocalPos()
		end, self)
	end

	self:_refreshKillNum()
end

function DarkDragonKnifeGameView:_refreshKillNum()
	self._txtKill.text = langPara("击杀数量：<color=#59E8FDFF>%s</color>", self._killNum)
end

function DarkDragonKnifeGameView:_skillOpen()
	if self._skill_state == SKILL_STATE_ON then
		if self._skillEffect then
			UIEffectManager.instance:stopEffect(self._skillEffect)

			self._skillEffect = nil
		end

		local scale = checknumber(DDragonKConfig.instance:getCommonCfg("ULTIMATE_SPEED_SCALE"))

		self._propAttackIntervalTime = self._propAttackIntervalTime / scale
		self._skillTime = checknumber(DDragonKConfig.instance:getCommonCfg("ULTIMATE_TIME"))
		self._skill_state = SKILL_STATE_ING
		self._animationScale = 1.5

		goutil.setActive(self._btnSkill.gameObject, false)
	end
end

function DarkDragonKnifeGameView:_tickSkill(deltaTime)
	if self._skill_state == SKILL_STATE_ING then
		self._skillTime = self._skillTime - deltaTime

		if self._skillTime < 0 then
			self._propAttackIntervalTime = 10 / checknumber(self._propCfg.attackSpeed)
			self._skill_state = SKILL_STATE_OFF
			self._animationScale = 1
		end
	end
end

function DarkDragonKnifeGameView:_tickCombo(deltaTime)
	self._comboTime = self._comboTime + deltaTime

	if self._comboTime > COMBO_MAINTAIN_TIME then
		self._comboNum = 0

		self:_refreshComboNum()
	end
end

function DarkDragonKnifeGameView:_addCombo()
	self._comboNum = self._comboNum + 1
	self._comboTime = 0

	self:_refreshComboNum()
end

function DarkDragonKnifeGameView:_refreshComboNum()
	self._txtCombo:SetText(self._comboNum)
end

function DarkDragonKnifeGameView:_showMeanTimeKill(num)
	if num > 1 then
		goutil.setActive(self._killShow, true)
		self._txtKillShow:SetText(num)

		self._meanTimeTween = TweenUtil.ValueTo(1, 0, 1.7, function(val)
			return
		end, function()
			goutil.setActive(self._killShow, false)
		end, self, DG.Tweening.Ease.Linear)
	end
end

function DarkDragonKnifeGameView:_playTowerIdleAnimation()
	local sg = self._sg

	if sg then
		local clipName = "idle"

		sg.startingAnimation = clipName
		sg.AnimationState.TimeScale = 1

		sg.AnimationState:SetAnimation(0, clipName, true)
		sg:Update(0)
	end
end

function DarkDragonKnifeGameView:_playMonsterDeadEffect(pos)
	local index = self._monsterDeadIndex

	self._monsterDeadIndex = self._monsterDeadIndex + 1

	local deadUrl = "xiaoyouxi/xiaoanlongyouxi/fx_xiaoyouxi_siwang_01.prefab"

	self._deadEffList[index] = UIEffectManager.instance:playEffect(self, deadUrl, self._monsterDeadEffect, pos.x, pos.y, false, nil, function()
		UIEffectManager.instance:stopEffect(self._deadEffList[index])

		self._deadEffList[index] = nil
	end, function(o, eff)
		eff:setParent(self._monsterDeadEffect.transform)
		eff:setScale(30)
	end)
end

return DarkDragonKnifeGameView
