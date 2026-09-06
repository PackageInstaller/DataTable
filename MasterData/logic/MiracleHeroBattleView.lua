-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroBattleView.lua

module("logic.extensions.miraclehero.view.MiracleHeroBattleView", package.seeall)

local MiracleHeroBattleView = class("MiracleHeroBattleView", ViewComponent)
local STATE_GAME_RUNING = 1
local STATE_START = 2
local STATE_MY_TEAM_START = 3
local STATE_MY_TEAM_READY = 4
local STATE_CAN_OPERATE = 5
local STATE_OPERATING = 6
local STATE_MY_TEAM_ROUND = 7
local STATE_MY_TEAM_SHOW = 8
local STATE_ENEMY_TEAM_START = 9
local STATE_ENEMY_READY = 10
local STATE_ENEMY_ROUND = 11
local STATE_ENEMY_SHOW = 12
local STATE_TEAM_ROUND_END = 13
local STATE_BLOCK = 14
local STATE_GAME_END = 15
local ROUND_TIPS_SHOW_TIME = 1
local AUTO_SELECT_SHOW_TIME = 0.2
local AUTO_CONFIRM_SHOW_TIME = 1
local FLY_EFFECT_TIME = 0.6
local EMPTY_ELEMENTID = 0

function MiracleHeroBattleView:ctor()
	MiracleHeroBattleView.super.ctor(self)

	self._cellPEffectPools = {}
	self._petTweens = {}
	self._demageTextPools = {}
	self._attrCellPools = {}
	self._updateHuds = {}
	self._effectHandlerMap = {}
	self._x_space = 60
	self._y_space = 60
	self._x_spacing = 0
	self._y_spacing = 16
	self._supplyNum = 0
end

function MiracleHeroBattleView:unbindEvents()
	MiracleHeroBattleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSupport)
	GameUtil.rmClickHandler(self._btnAuto)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._imgAssistPet)
	DragHandler.Get(self._attrlContain):RemoveLuaHandler(self._dragHandler)
	PointerDownHandler.Get(self._attrlContain):RemoveLuaHandler(self._pointerDownHandler)
	PointerUpHandler.Get(self._attrlContain):RemoveLuaHandler(self._pointerUpHandler)
end

function MiracleHeroBattleView:bindEvents()
	MiracleHeroBattleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSupport, self._onClickSupport, self)
	GameUtil.addClickHandler(self._btnAuto, self._onClickAuto, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._imgAssistPet, self._onClickSupportInfo, self)

	self._dragHandler = DragHandler.Get(self._attrlContain):AddLuaHandler(function(_go, eventData)
		self:_onDrag(eventData)
	end)
	self._pointerDownHandler = PointerDownHandler.Get(self._attrlContain):AddLuaHandler(function(_go, eventData)
		self:_onPointerDown(eventData)
	end)
	self._pointerUpHandler = PointerUpHandler.Get(self._attrlContain):AddLuaHandler(function(_go, eventData)
		self:_onPointerUp(eventData)
	end)
end

function MiracleHeroBattleView:buildUI()
	MiracleHeroBattleView.super.buildUI(self)
	self:initFSM()

	self._leftFormation = self:getGo("leftFormation")
	self._rightFormation = self:getGo("rightFormation")
	self._leftPet = {}

	for i = 1, 5 do
		self._leftPet[i] = goutil.findChild(self._leftFormation, "petCell_" .. i)
	end

	self._rightPet = {}

	for i = 1, 5 do
		self._rightPet[i] = goutil.findChild(self._rightFormation, "petCell_" .. i)
	end

	self._effectContain = self:getGo("effectContain")
	self._flyEffectCell = self:getGo("flyEffectCell")
	self._petCell = self:getGo("petCell")
	self._skillDesc = self:getGo("skillDesc")
	self._txtDesc = self:getTxt("skillDesc/txtDesc")
	self._txtElement = self:getTxt("skillDesc/txtElement")
	self._btnSupport = self:getGo("btnSupport")
	self._supportBlockGo = self:getGo("btnSupport/imgBlock")
	self._imgSupportBlock = self:getImg("btnSupport/imgBlock")
	self._txtEnergy = self:getTxt("energy/txt")
	self._slideEnergy = self:getSlider("energy/slider")
	self._txtCd = self:getTxt("txtCd")
	self._damagesText = self:getGo("damagesText")
	self._damageContain = self:getGo("damageContain")
	self._damageTextCell = self:getGo("damageTextCell")
	self._txtBigRound = self:getTxt("roundInfo/bigRound/txtRound")
	self._minRound = self:getGo("roundInfo/minRound")
	self._txtMinRound = self:getTxt("roundInfo/minRound/txtMinRound")
	self._txtAttackRound = self:getTxt("roundInfo/minRound/txtAttackTime")
	self._attrlContain = self:getGo("attrlContain")
	self._attrCell = self:getGo("attrCell")
	self._btnAuto = self:getGo("btnAuto")
	self._imgAutoBg = self:getGo("btnAuto/imgBg")
	self._autoChange = self._imgAutoBg:GetComponent(ComponentType.UIImageSpriteChange)
	self._btnClose = self:getGo("btnClose")
	self._assistPetGo = self:getGo("assistPet")
	self._imgAssistPet = self:getGo("assistPet/con")
	self._bgEffectGo = self:getGo("bgEffect")
	self._startRoundTips = self:getGo("startRoundTips")
	self._txtStartRoundTips = self:getTxt("startRoundTips/txt")
	self._attrAreaTips = self:getGo("attrAreaTips")
	self._targetArea = self:getGo("targetArea")
end

function MiracleHeroBattleView:destroyUI()
	MiracleHeroBattleView.super.destroyUI(self)
	self._stateMachine:clear()
end

function MiracleHeroBattleView:onExit()
	MiracleHeroBattleView.super.onExit(self)
	removetimer(self._updateHud, self)
	removetimer(self._autoSelect, self)
	removetimer(self._autoConfim, self)
	removetimer(self._fallDownAttrCell, self)
	removetimer(self._endShow, self)

	for k, v in pairs(self._cellPEffectPools or {}) do
		v:clear()
	end

	self._cellPEffectPools = {}

	for k, v in pairs(self._demageTextPools or {}) do
		v:clear()
	end

	self._demageTextPools = {}

	for k, v in pairs(self._attrCellPools or {}) do
		v:clear()
	end

	self._attrCellPools = {}

	local size = MiracleHeroBattleModel.instance:getMapSize()

	for i = 1, size.x do
		for j = 1, size.y do
			local cell = self._attrCells[i][j]

			if cell then
				cell:onDestroy()
			end

			self._attrCells[i][j] = nil
		end
	end

	for i, v in ipairs(self._updateHuds) do
		goutil.destroy(i)
	end

	self._updateHuds = {}

	for i, v in pairs(self._leftPet) do
		self:clearPetCell(v)
	end

	for i, v in pairs(self._rightPet) do
		self:clearPetCell(v)
	end

	if self._assistEffect then
		UIEffectManager.instance:stopEffect(self._assistEffect)

		self._assistEffect = nil
	end

	for k, v in pairs(self._effectHandlerMap) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._effectHandlerMap = {}

	UIEffectManager.instance:stopEffect(self._bgEffect)
	MaterialMgr.clearIcon(self._imgAssistPet)
	uGuiUtil.clearImage(self._btnSupport)

	if self._autoBtnTween then
		UnityTweens.TweenRotate.StopTween(self._imgAutoBg)
		GameUtil.setLocalRotation(self._imgAutoBg, 0, 0, 0)

		self._autoBtnTween = nil
	end

	for k, v in pairs(self._petTweens) do
		UnityTweens.TweenPosition.StopTween(k)

		self._petTweens[k] = nil
	end

	self._stateMachine:stopTimer()
end

function MiracleHeroBattleView:onEnter()
	MiracleHeroBattleView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.MiracleHeroBattleStartRes, self._PM_MiracleHeroBattleStartRes, self)
	self.addGEvent(self, GlobalNotify.MiracleHeroSyncBattleRes, self._PM_MiracleHeroSyncBattleRes, self)
	self.addGEvent(self, GlobalNotify.MiracleHeroBattleEnd, self.close, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._challengeId = params[2]
	self._stageId = params[3]

	self._stateMachine:startTimer()
	self._stateMachine:gotoState(STATE_GAME_RUNING)
	MiracleHeroController.instance:sendPM_MiracleHeroBattleStartReq(self._activityId)
end

function MiracleHeroBattleView:initFSM()
	self._stateMachine = SimpleFSM.New()

	self._stateMachine:addState(STATE_GAME_RUNING, GameUtil.handler(self._initGameRuning, self))
	self._stateMachine:addState(STATE_START, GameUtil.handler(self._initStart, self))
	self._stateMachine:addState(STATE_MY_TEAM_START, GameUtil.handler(self._initMyTeamStart, self))
	self._stateMachine:addState(STATE_MY_TEAM_READY, GameUtil.handler(self._initMyTeamReady, self), nil, GameUtil.handler(self._onWaitAttrCell, self))
	self._stateMachine:addState(STATE_CAN_OPERATE, GameUtil.handler(self._initCanOpreate, self))
	self._stateMachine:addState(STATE_OPERATING, GameUtil.handler(self._initOpreating, self), GameUtil.handler(self._exitOpreating, self))
	self._stateMachine:addState(STATE_MY_TEAM_ROUND, GameUtil.handler(self._initCalculate, self))
	self._stateMachine:addState(STATE_MY_TEAM_SHOW, GameUtil.handler(self._initShow, self))
	self._stateMachine:addState(STATE_ENEMY_TEAM_START, GameUtil.handler(self._initEnemyTeamStart, self))
	self._stateMachine:addState(STATE_ENEMY_READY, GameUtil.handler(self._initEnemyReady, self))
	self._stateMachine:addState(STATE_ENEMY_ROUND, GameUtil.handler(self._initEnemyRound, self))
	self._stateMachine:addState(STATE_ENEMY_SHOW, GameUtil.handler(self._initEnemyShow, self))
	self._stateMachine:addState(STATE_TEAM_ROUND_END, GameUtil.handler(self._initTeamRoundEnd, self))
	self._stateMachine:addState(STATE_BLOCK, GameUtil.handler(self._initBlock, self))
	self._stateMachine:addState(STATE_GAME_END, GameUtil.handler(self._initGameEnd, self))

	local linkedList = {
		[STATE_GAME_RUNING] = {
			STATE_START
		},
		[STATE_START] = {
			STATE_MY_TEAM_START,
			STATE_ENEMY_TEAM_START
		},
		[STATE_MY_TEAM_START] = {
			STATE_MY_TEAM_READY
		},
		[STATE_MY_TEAM_READY] = {
			STATE_CAN_OPERATE
		},
		[STATE_CAN_OPERATE] = {
			STATE_OPERATING,
			STATE_MY_TEAM_ROUND,
			STATE_GAME_END
		},
		[STATE_OPERATING] = {
			STATE_CAN_OPERATE,
			STATE_MY_TEAM_ROUND
		},
		[STATE_MY_TEAM_ROUND] = {
			STATE_MY_TEAM_SHOW,
			STATE_BLOCK,
			STATE_MY_TEAM_READY,
			STATE_TEAM_ROUND_END
		},
		[STATE_MY_TEAM_SHOW] = {
			STATE_MY_TEAM_ROUND
		},
		[STATE_ENEMY_TEAM_START] = {
			STATE_ENEMY_READY
		},
		[STATE_ENEMY_READY] = {
			STATE_ENEMY_ROUND
		},
		[STATE_ENEMY_ROUND] = {
			STATE_ENEMY_SHOW,
			STATE_ENEMY_READY,
			STATE_BLOCK,
			STATE_TEAM_ROUND_END
		},
		[STATE_ENEMY_SHOW] = {
			STATE_ENEMY_ROUND
		},
		[STATE_TEAM_ROUND_END] = {
			STATE_MY_TEAM_START,
			STATE_ENEMY_TEAM_START,
			STATE_BLOCK
		},
		[STATE_BLOCK] = {
			STATE_START,
			STATE_GAME_END
		},
		[STATE_GAME_END] = {
			STATE_GAME_RUNING
		}
	}

	self._stateMachine:addLinkByLinkedList(linkedList)
end

function MiracleHeroBattleView:_initGameRuning()
	self:initMgr()
	self:initView()
end

function MiracleHeroBattleView:_initGameEnd()
	return
end

function MiracleHeroBattleView:initMgr()
	MiracleHeroUnitMgr.instance:initData(self._activityId, self._challengeId, self._stageId)
	MiracleHeroBuffMgr.instance:initData(self._activityId)
	MiracleHeroRoundMgr.instance:initData(self._activityId)
	MiracleHeroSkillMgr.instance:initData(self._activityId)
end

function MiracleHeroBattleView:initView()
	self._petCellMap = {}
	self._useElementType = {}
	self._playingTeam = nil

	local myTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.MyTeam)

	for i, v in pairs(myTeamMo.pos) do
		local petMo = MiracleHeroUnitMgr.instance:getPet(v)

		self:initPetCell(self._leftPet[i], petMo)

		self._petCellMap[petMo.id] = self._leftPet[i]

		local petCfg = MiracleHeroConfig.instance:getPetCfg(self._activityId, petMo.configId)

		self._useElementType[petCfg.elementId] = true
	end

	for i = 1, 5 do
		GameUtil.SetActive(self._rightPet[i], false)
	end

	local enemyTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.EnemyTeam)

	for i, v in pairs(enemyTeamMo.pos) do
		GameUtil.SetActive(self._rightPet[i], true)

		local petMo = MiracleHeroUnitMgr.instance:getPet(v)

		self:initPetCell(self._rightPet[i], petMo)

		self._petCellMap[petMo.id] = self._rightPet[i]
	end

	self._attrCells = {}

	self:initAttrCell()

	self._isSetAuto = false

	self._autoChange:SetState(self._isSetAuto and 1 or 0)
	GameUtil.setLocalRotation(self._imgAutoBg, 0, 0, 0)

	local assistCfg = MiracleHeroConfig.instance:getAssistCfg(self._activityId, myTeamMo.supportPet)
	local assistSkillCfg = MiracleHeroConfig.instance:getSkillCfg(assistCfg.ultSkillId)

	MaterialMgr.setIcon(self._imgAssistPet, MatType.Pet, assistCfg.faceIds)
	uGuiUtil.setSpriteToImage(self._btnSupport, nil, assistSkillCfg.skillImg)

	local bgEffectPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self._bgEffect = UIEffectManager.instance:playEffect(self, bgEffectPath, nil, 0, 0, true)

	self._bgEffect:setParent(self._bgEffectGo.transform)
	self._bgEffect:setLocalPos(0, 0, 0)
	self._bgEffect:setScale(1)
	GameUtil.SetActive(self._attrAreaTips, false)
	GameUtil.SetActive(self._attrCell, false)
	GameUtil.SetActive(self._skillDesc, false)
	GameUtil.SetActive(self._flyEffectCell, false)
	GameUtil.SetActive(self._damagesText, false)
	GameUtil.SetActive(self._targetArea, false)
	settimer(0.02, self._updateHud, self, true)
end

function MiracleHeroBattleView:initAttrCell()
	MiracleHeroBattleModel.instance:initMapData(self._activityId, self._challengeId, self._stageId, self._useElementType)

	local mapData = MiracleHeroBattleModel.instance:getMapData()
	local selectMap = MiracleHeroBattleModel.instance:getActiveCell()
	local size = MiracleHeroBattleModel.instance:getMapSize()

	for i = 1, size.x do
		for j = 1, size.y do
			local mo = mapData[i][j]
			local _cellType = mo.type
			local cellObj, attrCell = self:genarateAttrCell(_cellType, mo)

			cellObj.transform.localPosition = Vector3.New((self._y_space + self._y_spacing) * (j - 1), (self._x_space + self._x_spacing) * (i - 1))
			self._attrCells[i] = self._attrCells[i] or {}
			self._attrCells[i][j] = attrCell

			if selectMap and selectMap[i] then
				self._attrCells[i][j]:setSelect(selectMap[i][j])
			else
				self._attrCells[i][j]:setSelect(false)
			end
		end
	end

	self:_refreshActiveCell()
end

function MiracleHeroBattleView:initPetCell(cell, petMo)
	local go = cell.gameObject
	local headInfo = goutil.findChild(go, "headInfo")
	local con = goutil.findChild(headInfo, "conMask/con")
	local typeChange = goutil.findChildComponent(headInfo, "petType/type", "UIImageSpriteChange")
	local petCfg = MiracleHeroConfig.instance:getPetCfg(self._activityId, petMo.configId)
	local showRaceId = petCfg.faceIds

	MaterialMgr.resetAll(con)
	MaterialMgr.setIcon(con, MatType.PET_SKIN, showRaceId)

	local raceTypeCfg = MiracleHeroConfig.instance:getRaceType(petCfg.elementId)

	typeChange:SetState(petCfg.elementId - 1)
	GameUtil.addClickHandler(go, function()
		self:_onClickPet(go, petMo.id)
	end, self)
	self:resetPetCell(cell, petMo)
	self:updatePetCell(cell, petMo)
end

function MiracleHeroBattleView:updatePetCell(cell, petMo)
	local go = cell.gameObject
	local headInfo = goutil.findChild(go, "headInfo")
	local con = goutil.findChild(headInfo, "conMask/con")
	local slider = Framework.SliderAdapter.GetFrom(go, "hp/slider")
	local txtBlood = goutil.findChildTextComponent(go, "hp/txt")
	local curHp, maxHp = checkint(petMo.curHp), checkint(petMo:getMaxHp())
	local indexGo = goutil.findChild(headInfo, "index")
	local txtIndex = goutil.findChildTextComponent(indexGo, "txtIndex")
	local imgDeathGo = goutil.findChild(headInfo, "imgDeath")

	txtBlood.text = langPara("%d/%d", curHp, maxHp)

	slider:SetValue(curHp / maxHp)

	local isPetSurvival = MiracleHeroUnitMgr.instance:isPetSurvival(petMo.id)

	GameUtil.SetGray(con, not isPetSurvival)
	GameUtil.SetActive(imgDeathGo, not isPetSurvival)

	if petMo.teamId == MiracleHeroTeamType.MyTeam or not isPetSurvival then
		GameUtil.SetActive(indexGo, false)
	else
		local teamMo = MiracleHeroUnitMgr.instance:getTeamMo(petMo.teamId)
		local index = 0

		for i, v in ipairs(teamMo.actionPet) do
			if MiracleHeroUnitMgr.instance:isPetSurvival(v) then
				index = index + 1
			end

			if v == petMo.id then
				break
			end
		end

		GameUtil.SetActive(indexGo, true)

		txtIndex.text = index
	end

	if isPetSurvival and not self._petTweens[headInfo] then
		local tween = UnityTweens.TweenPosition.StartTween(headInfo, Vector3(0, -5, 0), Vector3(0, 5, 0), math.random() + 2, UnityTweens.EaseType.easeInOutCubic)

		tween.loopType = UnityTweens.LoopType.pingPong
		self._petTweens[headInfo] = tween
	elseif not isPetSurvival and self._petTweens[headInfo] then
		GameUtil.setLocalPos(headInfo, 0, 0, 0)
		UnityTweens.TweenPosition.StopTween(headInfo)

		self._petTweens[headInfo] = nil
	end
end

function MiracleHeroBattleView:resetPetCell(cell)
	local go = cell.gameObject
	local headInfo = goutil.findChild(go, "headInfo")
	local imgTarget = goutil.findChild(go, "headInfo/imgTarget")
	local normalBg = goutil.findChild(headInfo, "bg_1")
	local selectBg = goutil.findChild(headInfo, "bg_2")

	GameUtil.SetActive(imgTarget, false)
	GameUtil.SetActive(normalBg, true)
	GameUtil.SetActive(selectBg, false)
	GameUtil.setLocalScale(headInfo, 1)
end

function MiracleHeroBattleView:clearPetCell(cell)
	local go = cell.gameObject
	local headInfo = goutil.findChild(go, "headInfo")
	local con = goutil.findChild(headInfo, "conMask/con")

	GameUtil.setLocalScale(headInfo, 1)
	GameUtil.rmClickHandler(go)
	MaterialMgr.resetAll(con)
end

function MiracleHeroBattleView:_resetAllPetCell()
	for i, v in pairs(self._leftPet) do
		self:resetPetCell(v)
		v.transform:SetParent(self._leftFormation.transform or nil, true)
	end

	for i, v in pairs(self._rightPet) do
		self:resetPetCell(v)
		v.transform:SetParent(self._rightFormation.transform or nil, true)
	end
end

function MiracleHeroBattleView:_resetAllFlowEffect()
	for i, petMo in pairs(MiracleHeroUnitMgr.instance:getAllPet()) do
		local cell = self._petCellMap[petMo.id]
		local go = cell.gameObject
		local headInfo = goutil.findChild(go, "headInfo")

		if self._petTweens[headInfo] then
			UnityTweens.TweenPosition.StopTween(headInfo)

			self._petTweens[headInfo] = nil

			GameUtil.setLocalPos(headInfo, 0, 0, 0)
		end
	end
end

function MiracleHeroBattleView:_initStart()
	MiracleHeroRoundMgr.instance:startBigRound()

	local myTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.MyTeam)

	self._txtCd.text = langPara("%d", MiracleHeroSkillMgr.instance:getSupportColdDown())

	local supportCfg = MiracleHeroConfig.instance:getAssistCfg(self._activityId, myTeamMo.supportPet)

	self._txtEnergy.text = langPara("%d/%d", MiracleHeroSkillMgr.instance:getEnergy(), supportCfg.energyLimit)

	self._slideEnergy:SetValue(MiracleHeroSkillMgr.instance:getEnergy() / supportCfg.energyLimit)

	local stageCfg = MiracleHeroConfig.instance:getStageCfg(self._activityId, self._challengeId, self._stageId)
	local teamCfg = MiracleHeroConfig.instance:getTeamCfg(self._activityId, stageCfg.creepsMasterId)
	local roundLimit = teamCfg.roundLimit

	self._txtBigRound.text = langPara("%d/%d", MiracleHeroRoundMgr.instance:getBigRound(), roundLimit)
	self._imgSupportBlock.fillAmount = MiracleHeroSkillMgr.instance:getSupportColdDown() / supportCfg.coldDown

	GameUtil.SetActive(self._txtCd, MiracleHeroSkillMgr.instance:getSupportColdDown() > 0)
	GameUtil.SetGray(self._btnSupport, MiracleHeroSkillMgr.instance:getEnergy() < supportCfg.ultCostEnergy)
	GameUtil.SetActive(self._supportBlockGo, MiracleHeroSkillMgr.instance:getSupportColdDown() > 0)
	self:_refreshRoundInfo()

	local firstTeamType = MiracleHeroUnitMgr.instance:getFirstTeamType()

	self._playingTeam = self._playingTeam or firstTeamType

	if firstTeamType == MiracleHeroTeamType.EnemyTeam then
		self._stateMachine:gotoState(STATE_ENEMY_TEAM_START)
	else
		self._stateMachine:gotoState(STATE_MY_TEAM_START)
	end
end

function MiracleHeroBattleView:checkAttrCell()
	local myTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.MyTeam)
	local useElementChange = false

	for i, v in pairs(myTeamMo.pos) do
		local petMo = MiracleHeroUnitMgr.instance:getPet(v)
		local petCfg = MiracleHeroConfig.instance:getPetCfg(self._activityId, petMo.configId)

		if self._useElementType[petCfg.elementId] and not MiracleHeroUnitMgr.instance:isPetSurvival(petMo.id) then
			self._useElementType[petCfg.elementId] = nil
			useElementChange = true
		end
	end

	if useElementChange == true then
		MiracleHeroBattleModel.instance:checkTypeList(self._useElementType)

		local mapData = MiracleHeroBattleModel.instance:getMapData()
		local mapSize = MiracleHeroBattleModel.instance:getMapSize()

		for i = 1, mapSize.x do
			for j = 1, mapSize.y do
				if not self._useElementType[mapData[i][j].type] then
					MiracleHeroBattleModel.instance:addRemoveCell(i, j)
				end
			end
		end

		self:removeAttrCell()
	end
end

function MiracleHeroBattleView:_initMyTeamStart()
	local function handler()
		self._stateMachine:gotoState(STATE_MY_TEAM_READY)
	end

	self._playingTeam = MiracleHeroTeamType.MyTeam
	self._txtStartRoundTips.text = lang("我的回合")

	GameUtil.SetActive(self._startRoundTips, true)

	local tween = UnityTweens.TweenPosition.StartTween(self._startRoundTips, Vector3(0, 0, 0), Vector3(0, 0, 0), ROUND_TIPS_SHOW_TIME)

	tween:AddListener(function()
		GameUtil.SetActive(self._startRoundTips, false)
		handler()
	end)
	self:checkAttrCell()
end

function MiracleHeroBattleView:_initMyTeamReady()
	return
end

function MiracleHeroBattleView:_onWaitAttrCell()
	if not self._startMoveAttrCell then
		self._stateMachine:gotoState(STATE_CAN_OPERATE)
	end
end

function MiracleHeroBattleView:_initCanOpreate()
	self._isAuto = self._isSetAuto
	self._playingTeam = MiracleHeroTeamType.MyTeam

	MiracleHeroRoundMgr.instance:createAndAddEmptyRound()
	self:_refreshRoundInfo()

	if self._isAuto == true then
		settimer(AUTO_SELECT_SHOW_TIME, self._autoSelect, self, false)
	end
end

function MiracleHeroBattleView:_initOpreating()
	GameUtil.SetActive(self._attrAreaTips, not self._isAuto)
	GameUtil.SetActive(self._targetArea, true)
	self:_resetAllFlowEffect()
	self:_showTarget()
end

function MiracleHeroBattleView:_exitOpreating()
	GameUtil.SetActive(self._attrAreaTips, false)
	GameUtil.SetActive(self._targetArea, false)
	GameUtil.SetActive(self._skillDesc, false)
	self:_resetAllPetCell()

	for i, petMo in pairs(MiracleHeroUnitMgr.instance:getAllPet()) do
		local cell = self._petCellMap[petMo.id]

		if MiracleHeroUnitMgr.instance:isPetSurvival(petMo.id) == true then
			self:updatePetCell(cell, petMo)
		end
	end
end

function MiracleHeroBattleView:_showTarget()
	if self._curElementType == 0 or self._curElementNum == 0 then
		self:_resetAllPetCell()
		self:_resetAllFlowEffect()
		GameUtil.SetActive(self._skillDesc, false)

		return
	end

	local ignoredPet = {}
	local targetB, targetA, skillId = MiracleHeroSkillMgr.instance:getSkillTargetByElement(self._curElementType, self._curElementNum)
	local attackHeadInfo = goutil.findChild(self._petCellMap[targetA], "headInfo")

	if not self._petTweens[attackHeadInfo] then
		local tween = UnityTweens.TweenPosition.StartTween(attackHeadInfo, Vector3(0, -5, 0), Vector3(0, 5, 0), math.random() + 2, UnityTweens.EaseType.easeInOutCubic)

		tween.loopType = UnityTweens.LoopType.pingPong
		self._petTweens[attackHeadInfo] = tween

		self._petCellMap[targetA].transform:SetParent(self._targetArea.transform or nil, true)
	end

	ignoredPet[targetA] = true

	GameUtil.setLocalScale(attackHeadInfo, 1.1)

	for i, v in ipairs(targetB) do
		local targetHeadInfo = goutil.findChild(self._petCellMap[v], "headInfo")
		local selectBg = goutil.findChild(targetHeadInfo, "bg_2")
		local normalBg = goutil.findChild(targetHeadInfo, "bg_1")
		local imgTarget = goutil.findChild(targetHeadInfo, "imgTarget")

		if not self._petTweens[targetHeadInfo] then
			local tween = UnityTweens.TweenPosition.StartTween(targetHeadInfo, Vector3(0, -5, 0), Vector3(0, 5, 0), math.random() + 2, UnityTweens.EaseType.easeInOutCubic)

			tween.loopType = UnityTweens.LoopType.pingPong
			self._petTweens[targetHeadInfo] = tween

			self._petCellMap[v].transform:SetParent(self._targetArea.transform or nil, true)
		end

		ignoredPet[v] = true

		GameUtil.setLocalScale(targetHeadInfo, 1)
		GameUtil.SetActive(normalBg, false)
		GameUtil.SetActive(selectBg, true)
		GameUtil.SetActive(imgTarget, true)
	end

	for i, petMo in pairs(MiracleHeroUnitMgr.instance:getAllPet()) do
		local cell = self._petCellMap[petMo.id]
		local go = cell.gameObject

		if not ignoredPet[petMo.id] then
			self:resetPetCell(go)

			local headInfo = goutil.findChild(go, "headInfo")

			if self._petTweens[headInfo] then
				UnityTweens.TweenPosition.StopTween(headInfo)

				self._petTweens[headInfo] = nil

				GameUtil.setLocalPos(headInfo, 0, 0, 0)
			end

			go.transform:SetParent(self._leftFormation.transform or nil, true)
		end
	end

	local skillCfg = MiracleHeroConfig.instance:getSkillCfg(skillId)

	GameUtil.SetActive(self._skillDesc, true)

	self._txtDesc.text = langPara("%s", skillCfg.skillDesc)

	local rateCfg = MiracleHeroConfig.instance:getDamageRateCfg(self._curElementNum)

	self._txtElement.text = langPara("元素加成：<color=#20B376FF>%d", rateCfg.damageRate * 100) .. "%</color>"
end

function MiracleHeroBattleView:_initCalculate()
	self:_startRound()
end

function MiracleHeroBattleView:_initEnemyRound()
	self:_startRound()
end

function MiracleHeroBattleView:_startRound()
	self:_refreshRoundInfo()

	local myTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.MyTeam)
	local enemyTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.EnemyTeam)

	if myTeamMo:getSurvalPetNum() <= 0 then
		self._stateMachine:gotoState(STATE_BLOCK)

		return
	elseif enemyTeamMo:getSurvalPetNum() <= 0 then
		self._stateMachine:gotoState(STATE_BLOCK)

		return
	end

	if MiracleHeroRoundMgr.instance:getTopRound() and MiracleHeroRoundMgr.instance:getTopRound().isInit == true then
		MiracleHeroRoundMgr.instance:startRound()

		if self._stateMachine.currStateName == STATE_ENEMY_ROUND then
			self._stateMachine:gotoState(STATE_ENEMY_SHOW)
		else
			self._stateMachine:gotoState(STATE_MY_TEAM_SHOW)
		end

		return
	end

	local myTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.MyTeam)

	for i, v in pairs(myTeamMo.pos) do
		local petMo = MiracleHeroUnitMgr.instance:getPet(v)

		self:updatePetCell(self._petCellMap[v], petMo)
	end

	local enemyTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.EnemyTeam)

	for i, v in pairs(enemyTeamMo.pos) do
		local petMo = MiracleHeroUnitMgr.instance:getPet(v)

		self:updatePetCell(self._petCellMap[v], petMo)
	end

	local curTeamRound = MiracleHeroRoundMgr.instance:getCurTeamType()

	if not curTeamRound or self._playingTeam and self._playingTeam ~= curTeamRound then
		self._stateMachine:gotoState(STATE_TEAM_ROUND_END)
	elseif curTeamRound == MiracleHeroTeamType.MyTeam then
		self._stateMachine:gotoState(STATE_MY_TEAM_READY)
	else
		self._stateMachine:gotoState(STATE_ENEMY_READY)
	end
end

function MiracleHeroBattleView:_initTeamRoundEnd()
	local curTeamRound = MiracleHeroRoundMgr.instance:getCurTeamType()

	if not curTeamRound then
		self._stateMachine:gotoState(STATE_BLOCK)
	elseif curTeamRound == MiracleHeroTeamType.MyTeam then
		self._stateMachine:gotoState(STATE_MY_TEAM_START)
	else
		self._stateMachine:gotoState(STATE_ENEMY_TEAM_START)
	end
end

function MiracleHeroBattleView:_showRoundEndTips(teamId, callback, callbackTarget)
	local function handler()
		callback(callbackTarget)
	end

	self._txtStartRoundTips.text = teamId == MiracleHeroTeamType.MyTeam and lang("我的回合") or lang("对手回合")

	GameUtil.SetActive(self._startRoundTips, true)

	local tween = UnityTweens.TweenPosition.StartTween(self._startRoundTips, Vector3(0, 0, 0), Vector3(0, 0, 0), ROUND_TIPS_SHOW_TIME)

	tween:AddListener(function()
		self._txtStartRoundTips.text = lang("结束")

		local tween2 = UnityTweens.TweenPosition.StartTween(self._startRoundTips, Vector3(0, 0, 0), Vector3(0, 0, 0), ROUND_TIPS_SHOW_TIME)

		tween2:AddListener(function()
			GameUtil.SetActive(self._startRoundTips, false)
			handler()
		end)
	end)
end

function MiracleHeroBattleView:_initEnemyTeamStart()
	local function handler()
		self._stateMachine:gotoState(STATE_ENEMY_READY)
	end

	self._playingTeam = MiracleHeroTeamType.EnemyTeam
	self._txtStartRoundTips.text = lang("对手回合")

	GameUtil.SetActive(self._startRoundTips, true)

	local tween = UnityTweens.TweenPosition.StartTween(self._startRoundTips, Vector3(0, 0, 0), Vector3(0, 0, 0), ROUND_TIPS_SHOW_TIME)

	tween:AddListener(function()
		GameUtil.SetActive(self._startRoundTips, false)
		handler()
	end)
end

function MiracleHeroBattleView:_initEnemyReady()
	MiracleHeroRoundMgr.instance:createEnemySkill()
	self._stateMachine:gotoState(STATE_ENEMY_ROUND)
end

function MiracleHeroBattleView:_initShow()
	self:_startShow()
end

function MiracleHeroBattleView:_initEnemyShow()
	self:_startShow()
end

function MiracleHeroBattleView:_startShow()
	local myTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.MyTeam)
	local supportCfg = MiracleHeroConfig.instance:getAssistCfg(self._activityId, myTeamMo.supportPet)

	self._txtEnergy.text = langPara("%d/%d", MiracleHeroSkillMgr.instance:getEnergy(), supportCfg.energyLimit)

	self._slideEnergy:SetValue(MiracleHeroSkillMgr.instance:getEnergy() / supportCfg.energyLimit)

	local isShowAssisEffect = MiracleHeroSkillMgr.instance:getEnergy() >= supportCfg.ultCostEnergy and MiracleHeroSkillMgr.instance:getSupportColdDown() <= 0

	if self._assistEffect then
		if not isShowAssisEffect then
			UIEffectManager.instance:stopEffect(self._assistEffect)

			self._assistEffect = nil
		end
	elseif isShowAssisEffect == true then
		local assistEffectPath = "20240628/qijiyongzhe/fx_ui_qjyz_xuanzhong.prefab"

		self._assistEffect = UIEffectManager.instance:playEffect(self, assistEffectPath, nil, 0, 0, true)

		self._assistEffect:setParent(self._btnSupport.transform)
		self._assistEffect:setLocalPos(0, 0, 0)
		self._assistEffect:setScale(1)
	end

	self._imgSupportBlock.fillAmount = MiracleHeroSkillMgr.instance:getSupportColdDown() / supportCfg.coldDown
	self._txtCd.text = MiracleHeroSkillMgr.instance:getSupportColdDown()

	GameUtil.SetActive(self._txtCd, MiracleHeroSkillMgr.instance:getSupportColdDown() > 0)
	GameUtil.SetActive(self._supportBlockGo, MiracleHeroSkillMgr.instance:getSupportColdDown() > 0)
	GameUtil.SetGray(self._btnSupport, MiracleHeroSkillMgr.instance:getEnergy() < supportCfg.ultCostEnergy)

	local roundMo = MiracleHeroRoundMgr.instance:getTopRound()
	local skillMo = roundMo.skillMo
	local showCount = 0

	local function effectEndFunc(type, obj, petId, isNotCount)
		GameUtil.SetActive(obj, false)

		if self._cellPEffectPools[type] then
			self._cellPEffectPools[type]:returnObject(obj)
		end

		if not isNotCount then
			local petMo = MiracleHeroUnitMgr.instance:getPet(petId)

			self:updatePetCell(self._petCellMap[petId], petMo)

			showCount = showCount - 1

			if showCount and showCount <= 0 then
				settimer(0.4, self._endShow, self, false)
			end
		end
	end

	local fromGo = self._petCellMap[skillMo.targetA]

	if skillMo.isSupportSkill == true then
		fromGo = self._assistPetGo
	end

	fromGo = fromGo or self._effectContain

	for i, reportMo in ipairs(skillMo:getReportMoList()) do
		showCount = showCount + 1

		local toGo = self._petCellMap[reportMo.petId]

		if reportMo.createDamage == true or skillMo.isSupportSkill == true then
			self:showFlyEffect(fromGo, toGo, skillMo.skillCfg, effectEndFunc, reportMo)
		elseif #reportMo.buffIds >= 0 then
			local effectName = "buffShow"

			self:showBuffEffect(toGo, reportMo.petId, effectName, effectEndFunc)
		end
	end

	self:removeAttrCell()
	MiracleHeroBattleModel.instance:_removeAllAttrCell()
	self:_refreshActiveCell()
end

function MiracleHeroBattleView:showFlyEffect(fromGo, toGo, skillCfg, handler, reportMo)
	if skillCfg then
		local gameObject = self:genarateEffectCell(skillCfg.flyEffect, self._flyEffectCell)

		local function _clearTrail(handler, eff)
			local trs = eff.effGo:GetComponentsInChildren(typeof(UnityEngine.TrailRenderer))

			for i = 0, trs.Length - 1 do
				trs[i]:Clear()
			end
		end

		local effectPath = string.format("20240628/qijiyongzhe/%s.prefab", skillCfg.flyEffect)
		local boomEffectPath = string.format("20240628/qijiyongzhe/%s.prefab", skillCfg.boomEffect)
		local effectHandler = UIEffectManager.instance:playEffect(self, effectPath, gameObject.transform, 0, 0, true, nil, nil, _clearTrail)
		local startPos = GameUtil.getLocalPos(fromGo)
		local endPos = GameUtil.getLocalPos(toGo)
		local direction = endPos - startPos

		GameUtil.setLocalPos(gameObject, startPos.x, startPos.y, startPos.z)

		if effectHandler then
			effectHandler:setParent(gameObject.transform)
			effectHandler:setLocalPos(0, 0, 0)
			effectHandler:setScale(1)
			effectHandler:setLocalEulerAngle(0, 0, skillCfg.flyEffectRotate - GoUtil.SignedAngleWithX(direction.x, direction.y))

			if effectHandler.effGo then
				local tr = effectHandler.effGo:GetComponentInChildren(typeof(UnityEngine.TrailRenderer))

				tr:Clear()
			end
		end

		self._effectHandlerMap[gameObject] = effectHandler

		local tween = UnityTweens.TweenPosition.StartTween(gameObject, startPos, endPos, FLY_EFFECT_TIME)

		tween:AddListener(function()
			UIEffectManager.instance:stopEffect(effectHandler)

			local boomEffectHandler = UIEffectManager.instance:playEffect(self, boomEffectPath, gameObject.transform, 0, 0, false)

			handler(skillCfg.flyEffect, gameObject, reportMo.petId)
			self:showNum(toGo, reportMo, skillCfg.funtionType)

			if boomEffectHandler then
				boomEffectHandler:setParent(self._effectContain.transform)

				local pos = GameUtil.getPos(toGo)

				boomEffectHandler:setPos(pos.x, pos.y, pos.z)
				boomEffectHandler:setScale(1)
			end
		end)
	end
end

function MiracleHeroBattleView:showBuffEffect(effectGo, petId, effectName, handler, isNotCount)
	if effectName then
		local gameObject = self:genarateEffectCell(effectName, self._flyEffectCell)
		local effectPath = "20240628/qijiyongzhe/fx_ui_qjyz_baokai3.prefab"
		local effectHandler = UIEffectManager.instance:playEffect(self, effectPath, gameObject.transform, 0, 0, false)

		if effectHandler then
			effectHandler:setParent(gameObject.transform)
			effectHandler:setLocalPos(0, 0, 0)
			effectHandler:setScale(1)
		end

		local tween = UnityTweens.TweenPosition.StartTween(gameObject, GameUtil.getLocalPos(effectGo) - Vector3(0, 0, 0), GameUtil.getLocalPos(effectGo), FLY_EFFECT_TIME)

		if handler then
			tween:AddListener(function()
				UIEffectManager.instance:stopEffect(effectHandler)
				handler(effectName, gameObject, petId, isNotCount)
			end)
		else
			tween:AddListener(function()
				UIEffectManager.instance:stopEffect(effectHandler)
			end)
		end
	end
end

function MiracleHeroBattleView:showNum(effectGo, reportMo, funtionType)
	if funtionType == GameEnum.SkillFuncType.BuffOnly then
		return
	end

	local damage = reportMo.attackHps
	local damageNumber = self:genarateDamageText(reportMo.isCritical and "baoji" or "attack")

	damageNumber:setValue(damage)

	local pos = GameUtil.getLocalPos(effectGo)

	GameUtil.setLocalPos(damageNumber._container, pos.x, pos.y, pos.z)

	self._updateHuds[damageNumber._container] = damageNumber

	damageNumber:start(effectGo)
end

function MiracleHeroBattleView:_endShow()
	MiracleHeroRoundMgr.instance:endRound()

	if self._stateMachine.currStateName == STATE_ENEMY_SHOW then
		self._stateMachine:gotoState(STATE_ENEMY_ROUND)
	else
		self._stateMachine:gotoState(STATE_MY_TEAM_ROUND)
	end
end

function MiracleHeroBattleView:_initBlock()
	self._txtDesc.text = ""

	GameUtil.SetActive(self._skillDesc, false)
	MiracleHeroRoundMgr.instance:endBigRound()

	local myTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.MyTeam)
	local enemyTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.EnemyTeam)
	local stageCfg = MiracleHeroConfig.instance:getStageCfg(self._activityId, self._challengeId, self._stageId)
	local cutBigRound = MiracleHeroRoundMgr.instance:getBigRound()
	local teamCfg = MiracleHeroConfig.instance:getTeamCfg(self._activityId, stageCfg.creepsMasterId)
	local roundLimit = teamCfg.roundLimit

	if myTeamMo:getSurvalPetNum() <= 0 then
		MiracleHeroController.instance:sendPM_MiracleHeroSyncBattleReq(self._activityId, cutBigRound, false)
	elseif enemyTeamMo:getSurvalPetNum() <= 0 then
		MiracleHeroController.instance:sendPM_MiracleHeroSyncBattleReq(self._activityId, cutBigRound, true)
	elseif roundLimit <= cutBigRound then
		MiracleHeroController.instance:sendPM_MiracleHeroSyncBattleReq(self._activityId, cutBigRound, false)
	else
		MiracleHeroController.instance:sendPM_MiracleHeroSyncBattleReq(self._activityId, cutBigRound)
	end
end

function MiracleHeroBattleView:genarateEffectCell(type, cloneObject)
	function resetFunc(obj)
		self:_resetFunc(obj)
	end

	function disposeFunc(obj)
		self:_disposeFunc(obj)
	end

	self._cellPEffectPools[type] = self._cellPEffectPools[type] or ObjectPool.New(5, nil, disposeFunc, resetFunc)

	local cellObj

	if self._cellPEffectPools[type] then
		cellObj = self._cellPEffectPools[type]:fetchObject()
	end

	if not cellObj then
		cellObj = goutil.clone(cloneObject)

		if cellObj then
			goutil.addChildToParent(cellObj.gameObject, self._effectContain.gameObject.transform)
		end
	else
		goutil.addChildToParent(cellObj.gameObject, self._effectContain.gameObject.transform)
	end

	GameUtil.SetActive(cellObj, true)

	return cellObj
end

function MiracleHeroBattleView:_resetFunc(obj)
	GameUtil.SetActive(obj, false)
end

function MiracleHeroBattleView:_disposeFunc(obj)
	if self._effectHandlerMap[obj] then
		UIEffectManager.instance:stopEffect(self._effectHandlerMap[obj])

		self._effectHandlerMap[obj] = nil
	end

	goutil.destroy(obj)
end

function MiracleHeroBattleView:genarateDamageText(type)
	function resetFunc(obj)
		self:_resetDamageFunc(obj)
	end

	function disposeFunc(obj)
		self:_disposeDamageFunc(obj)
	end

	self._demageTextPools[type] = self._demageTextPools[type] or ObjectPool.New(5, nil, disposeFunc, resetFunc)

	local cellObj

	if self._demageTextPools[type] then
		cellObj = self._demageTextPools[type]:fetchObject()
	end

	local damageNumber

	if not cellObj then
		local cloneTextObject = goutil.findChild(self._damagesText, type)

		cellObj = goutil.clone(self._damageTextCell)
		cellTextObj = goutil.cloneAndSetParent(cloneTextObject, cellObj.transform)

		cellTextObj.transform:SetParent(cellObj.transform)

		if cellObj then
			goutil.addChildToParent(cellObj.gameObject, self._damageContain.gameObject.transform)

			damageNumber = Framework.LuaComponentContainer.Add(cellObj.gameObject, MiracleHeroDamageNumber)

			damageNumber:initCell(cellTextObj, type)
			GameUtil.setLocalPos(cellObj.gameObject, 0, 0, 0)
		end
	else
		goutil.addChildToParent(cellObj.gameObject, self._damageContain.gameObject.transform)

		damageNumber = Framework.LuaComponentContainer.Get(cellObj.gameObject, MiracleHeroDamageNumber)

		GameUtil.setLocalPos(cellObj.gameObject, 0, 0, 0)
	end

	GameUtil.SetActive(cellObj, false)

	return damageNumber
end

function MiracleHeroBattleView:_resetDamageFunc(obj)
	GameUtil.SetActive(obj, false)
end

function MiracleHeroBattleView:_disposeDamageFunc(obj)
	self._updateHuds[obj] = nil

	goutil.destroy(obj)
end

function MiracleHeroBattleView:_updateHud()
	for i, v in pairs(self._updateHuds) do
		v:update(0.02)

		if v:isDone() == true then
			self._updateHuds[v._container] = nil

			GameUtil.SetActive(v._container, false)
			self._demageTextPools[v._type]:returnObject(v._container)
		end
	end
end

function MiracleHeroBattleView:genarateAttrCell(type, mo)
	function resetFunc(obj)
		self:_resetAttrFunc(obj)
	end

	function disposeFunc(obj)
		self:_disposeAttrFunc(obj)
	end

	self._attrCellPools[type] = self._attrCellPools[type] or ObjectPool.New(20, nil, disposeFunc, resetFunc)

	local cellObj

	if self._attrCellPools[type] then
		cellObj = self._attrCellPools[type]:fetchObject()
	end

	local attrCell

	if not cellObj then
		cellObj = goutil.clone(self._attrCell)

		if cellObj then
			goutil.addChildToParent(cellObj.gameObject, self._attrlContain.gameObject.transform)

			attrCell = Framework.LuaComponentContainer.Add(cellObj.gameObject, MiracleHeroAttrCell)

			attrCell:initCell(self, mo)
		end
	else
		goutil.addChildToParent(cellObj.gameObject, self._attrlContain.gameObject.transform)

		attrCell = Framework.LuaComponentContainer.Get(cellObj.gameObject, MiracleHeroAttrCell)

		attrCell:resetData(cellObj.gameObject, mo)
	end

	GameUtil.SetActive(cellObj, true)

	return cellObj, attrCell
end

function MiracleHeroBattleView:_resetAttrFunc(obj)
	local canvasGroup = obj:GetComponent(ComponentType.CanvasGroup)

	canvasGroup.alpha = 1

	GameUtil.SetActive(obj, false)
end

function MiracleHeroBattleView:_disposeAttrFunc(obj)
	goutil.destroy(obj)
end

function MiracleHeroBattleView:removeAttrCell()
	local _removeCellCount = 0

	local function removeFunc(cell)
		if self._attrCellPools[cell:getType()] then
			self._attrCellPools[cell:getType()]:returnObject(cell:getObj())
		end

		_removeCellCount = _removeCellCount - 1

		if _removeCellCount <= 0 then
			settimer(0.4, self._fallDownAttrCell, self, false)
		end
	end

	local operates = MiracleHeroBattleModel.instance:getOperate()

	if operates:IsEmpty() == true then
		settimer(0.4, self._fallDownAttrCell, self, false)
	else
		self._startMoveAttrCell = true
	end

	operates:ForEach(function(operateMo, index)
		_removeCellCount = _removeCellCount + 1

		local cell = self._attrCells[operateMo.x][operateMo.y]

		cell:onRemove(removeFunc)
		self:_onNormalEffect(cell._container.gameObject, function()
			return
		end)
	end)
end

function MiracleHeroBattleView:_fallDownAttrCell()
	MiracleHeroBattleModel.instance:removeCellData()

	local size = MiracleHeroBattleModel.instance:getMapSize()

	for i = 1, size.x do
		self:_checkCellFallDown(i)
	end

	for i = 1, size.x do
		self:_checkSupplyCell(i)
	end

	MiracleHeroBattleModel.instance:clearOperate()
end

function MiracleHeroBattleView:_checkCellFallDown(i)
	local size = MiracleHeroBattleModel.instance:getMapSize()
	local cellData = MiracleHeroBattleModel.instance:getMapData()
	local from_y, count = -1, 0

	for j = 1, size.y do
		if cellData[i][j].type == EMPTY_ELEMENTID then
			if from_y == -1 then
				count = 0
				from_y = j
			end

			count = count + 1
		elseif from_y ~= -1 then
			self._attrCells[i][j]:onChangePos(i, j - count)

			self._attrCells[i][j - count] = self._attrCells[i][j]

			MiracleHeroBattleModel.instance:setCellData(i, j - count, self._attrCells[i][j - count]:getType())

			self._attrCells[i][j - count].data = cellData[i][j - count]

			MiracleHeroBattleModel.instance:setCellData(i, j, EMPTY_ELEMENTID)
		end
	end
end

function MiracleHeroBattleView:_checkSupplyCell(i)
	local size = MiracleHeroBattleModel.instance:getMapSize()
	local cellData = MiracleHeroBattleModel.instance:getMapData()
	local from_y, count = -1, 0
	local blockIdx = 0
	local isSupply = false

	for j = blockIdx + 1, size.y do
		if cellData[i][j].type == EMPTY_ELEMENTID then
			if from_y == -1 then
				count = 0
				from_y = j
			end

			count = count + 1

			if j == size.y then
				self:_supplyAttrCell(i, from_y, count)

				isSupply = true
			end
		end
	end

	return isSupply
end

function MiracleHeroBattleView:_supplyAttrCell(x, from_y, num)
	local function onMoveCallBack()
		self._supplyNum = self._supplyNum - 1

		self:checkSupplyCellReady()
	end

	local cellData = MiracleHeroBattleModel.instance:getMapData()

	for i = 1, num do
		self._supplyNum = 1 + (self._supplyNum or 0)

		local supplyType = MiracleHeroBattleModel.instance:getSupplyCellType()

		MiracleHeroBattleModel.instance:setCellData(x, from_y + i - 1, supplyType)

		local mo = cellData[x][from_y + i - 1]
		local _cellType = mo.type
		local cellObj, attrCell = self:genarateAttrCell(_cellType, mo)

		cellObj.transform.localPosition = Vector3.New((self._y_space + self._y_spacing) * (10 + mo.y), (self._x_space + self._x_spacing) * (mo.x - 1))

		attrCell:onBuildAction(onMoveCallBack)

		self._attrCells[x][from_y + i - 1] = attrCell
	end
end

function MiracleHeroBattleView:checkSupplyCellReady()
	if self._supplyNum <= 0 then
		self._startMoveAttrCell = false
		self._supplyNum = 0
	end
end

function MiracleHeroBattleView:_checkSelectCell()
	MiracleHeroBattleModel.instance:_removeAllAttrCell()

	local size = MiracleHeroBattleModel.instance:getMapSize()
	local selectList = {}
	local minDistance = math.huge
	local startPos = Vector2(0, 0)

	for i, v in pairs(self._attrCells) do
		for j, k in pairs(v) do
			if self._startPos and self._endPos and k:checkHitAABB(self._startPos, self._endPos) == true then
				local distance = k:getDistanceFromPos(self._startPos)

				if distance < minDistance then
					minDistance = distance
					startPos.x = i
					startPos.y = j
				end

				table.insert(selectList, Vector2(i, j))
			end
		end
	end

	if startPos.x == 0 or startPos.y == 0 then
		return
	end

	MiracleHeroBattleModel.instance:addAttrCell(startPos.x, startPos.y)

	for i, v in ipairs(selectList) do
		MiracleHeroBattleModel.instance:addAttrCell(v.x, v.y)
	end
end

function MiracleHeroBattleView:_checkElementType(selectMap)
	local size = MiracleHeroBattleModel.instance:getMapSize()

	self._curElementType = 0
	self._curElementNum = 0

	for i = 1, size.x do
		for j = 1, size.y do
			if selectMap and selectMap[i] and selectMap[i][j] == true then
				local mapData = MiracleHeroBattleModel.instance:getMapData()

				self._curElementType = mapData[i][j].type
				self._curElementNum = self._curElementNum + 1
			end
		end
	end
end

function MiracleHeroBattleView:_refreshActiveCell()
	local selectMap = MiracleHeroBattleModel.instance:getActiveCell()
	local size = MiracleHeroBattleModel.instance:getMapSize()

	for i = 1, size.x do
		for j = 1, size.y do
			if selectMap and selectMap[i] then
				self._attrCells[i][j]:setSelect(selectMap[i][j])
			else
				self._attrCells[i][j]:setSelect(false)
			end
		end
	end

	return selectMap
end

function MiracleHeroBattleView:_refreshRoundInfo()
	local teamId = MiracleHeroRoundMgr.instance:getCurTeamType()

	if not teamId then
		GameUtil.SetActive(self._minRound, false)

		return
	else
		GameUtil.SetActive(self._minRound, true)
	end

	local teamMo = MiracleHeroUnitMgr.instance:getTeamMo(teamId)
	local maxNum = teamMo:getSurvalPetNum()
	local curStep = MiracleHeroRoundMgr.instance:getCurStepCount()

	if teamId == MiracleHeroTeamType.MyTeam then
		self._txtMinRound.text = lang("我的回合")
	elseif teamId == MiracleHeroTeamType.EnemyTeam then
		self._txtMinRound.text = lang("对手回合")
	else
		GameUtil.SetActive(self._minRound, false)
	end

	self._txtAttackRound.text = langPara("攻击次数:<color=#c2ff00>%d</color>/%d", maxNum - curStep, maxNum)
end

function MiracleHeroBattleView:_autoSelect()
	local myTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.MyTeam)
	local supportCfg = MiracleHeroConfig.instance:getAssistCfg(self._activityId, myTeamMo.supportPet)

	if MiracleHeroSkillMgr.instance:getSupportColdDown() <= 0 and MiracleHeroSkillMgr.instance:getEnergy() >= supportCfg.ultCostEnergy then
		local skillMo = MiracleHeroSkillMgr.instance:getSupportSkill()

		MiracleHeroSkillMgr.instance:useSupportSkill()
		MiracleHeroRoundMgr.instance:addRound(skillMo, MiracleHeroTeamType.MyTeam)
		self._stateMachine:gotoState(STATE_MY_TEAM_ROUND)

		return
	end

	MiracleHeroBattleModel.instance:autoSelectCell()

	local selectMap = self:_refreshActiveCell()
	local size = MiracleHeroBattleModel.instance:getMapSize()

	self._curElementType = 0
	self._curElementNum = 0

	for i = 1, size.x do
		for j = 1, size.y do
			if selectMap and selectMap[i] and selectMap[i][j] == true then
				local mapData = MiracleHeroBattleModel.instance:getMapData()

				MiracleHeroBattleModel.instance:addRemoveCell(i, j)

				self._curElementType = mapData[i][j].type
				self._curElementNum = self._curElementNum + 1
			end
		end
	end

	self._stateMachine:gotoState(STATE_OPERATING)
	settimer(AUTO_CONFIRM_SHOW_TIME, self._autoConfim, self, false)
end

function MiracleHeroBattleView:_autoConfim()
	local skillMo = MiracleHeroSkillMgr.instance:getMyTeamSkill(self._curElementType, self._curElementNum)

	MiracleHeroSkillMgr.instance:useSkill(self._curElementType, self._curElementNum)
	MiracleHeroRoundMgr.instance:addRound(skillMo, MiracleHeroTeamType.MyTeam)
	self._stateMachine:gotoState(STATE_MY_TEAM_ROUND)
end

function MiracleHeroBattleView:_onNormalEffect(cellGo, callback)
	local effName = "fx_ui_sanxiao/fx_ui_sanxiao_xiaochu.prefab"

	UIEffectManager.instance:playEffect(self, effName, cellGo, self._x_space, self._y_space, false, false, nil, callback)
end

function MiracleHeroBattleView:_onPointerDown(eventData)
	if self._stateMachine.currStateName ~= STATE_CAN_OPERATE or self._isAuto == true then
		return
	end

	local rectTransform = self._attrlContain:GetComponent("RectTransform")
	local posEvent = goutil.screenToLocalPos(eventData.position, rectTransform)

	self._startPos = posEvent
	self._endPos = posEvent

	self:_checkSelectCell()

	local selectMap = self:_refreshActiveCell()

	self:_checkElementType(selectMap)
	self._stateMachine:gotoState(STATE_OPERATING)
end

function MiracleHeroBattleView:_onPointerUp(eventData)
	if self._stateMachine.currStateName ~= STATE_OPERATING or self._isAuto == true then
		return
	end

	local rectTransform = self._attrlContain:GetComponent("RectTransform")
	local posEvent = goutil.screenToLocalPos(eventData.position, rectTransform)
	local checkPos = posEvent + GameUtil.getLocalPos(self._attrlContain)
	local freeAreaPos = GameUtil.getLocalPos(self._attrlContain)
	local rectTf = self._attrlContain:GetComponent(typeof(UnityEngine.RectTransform))

	self._endPos = posEvent

	if self._attrlContain and checkPos.x > freeAreaPos.x and checkPos.x < freeAreaPos.x + rectTf.rect.width and checkPos.y > freeAreaPos.y and checkPos.y < freeAreaPos.y + rectTf.rect.height then
		self:_checkSelectCell()
	else
		MiracleHeroBattleModel.instance:_removeAllAttrCell()
	end

	local selectMap = self:_refreshActiveCell()

	self:_checkElementType(selectMap)

	self._startPos = nil
	self._endPos = nil

	self:_showTarget()

	if self._curElementType == 0 or self._curElementNum == 0 then
		MiracleHeroBattleModel.instance:_removeAllAttrCell()
		self:_refreshActiveCell()
		MiracleHeroBattleModel.instance:clearOperate()
		self._stateMachine:gotoState(STATE_CAN_OPERATE)
	else
		local size = MiracleHeroBattleModel.instance:getMapSize()

		for i = 1, size.x do
			for j = 1, size.y do
				if selectMap and selectMap[i] and selectMap[i][j] == true then
					MiracleHeroBattleModel.instance:addRemoveCell(i, j)
				end
			end
		end

		if self._stateMachine.currStateName == STATE_OPERATING then
			local skillMo = MiracleHeroSkillMgr.instance:getMyTeamSkill(self._curElementType, self._curElementNum)

			MiracleHeroSkillMgr.instance:useSkill(self._curElementType, self._curElementNum)
			MiracleHeroRoundMgr.instance:addRound(skillMo, MiracleHeroTeamType.MyTeam)
			self._stateMachine:gotoState(STATE_MY_TEAM_ROUND)
		end
	end
end

function MiracleHeroBattleView:_onDrag(eventData)
	if self._stateMachine.currStateName ~= STATE_CAN_OPERATE and self._stateMachine.currStateName ~= STATE_OPERATING or self._isAuto == true then
		return
	end

	local rectTransform = self._attrlContain:GetComponent("RectTransform")
	local posEvent = goutil.screenToLocalPos(eventData.position, rectTransform)
	local checkPos = posEvent + GameUtil.getLocalPos(self._attrlContain)
	local freeAreaPos = GameUtil.getLocalPos(self._attrlContain)
	local rectTf = self._attrlContain:GetComponent(typeof(UnityEngine.RectTransform))
	local size = MiracleHeroBattleModel.instance:getMapSize()

	self._endPos = posEvent

	if self._attrlContain and checkPos.x > freeAreaPos.x and checkPos.x < freeAreaPos.x + rectTf.rect.width and checkPos.y > freeAreaPos.y and checkPos.y < freeAreaPos.y + rectTf.rect.height then
		self:_checkSelectCell()
	else
		MiracleHeroBattleModel.instance:_removeAllAttrCell()
	end

	local selectMap = self:_refreshActiveCell()

	self:_checkElementType(selectMap)
	self:_showTarget()
end

function MiracleHeroBattleView:_onClickPet(go, petId)
	local petMo = MiracleHeroUnitMgr.instance:getPet(petId)
	local content = StringBuffer.New()
	local activeType = {}

	for i, v in ipairs(petMo.buffList) do
		local buffMo = MiracleHeroBuffMgr.instance:getBuff(v)

		if buffMo.buffType == MiracleHeroBuffType.State then
			activeType.State = true
		elseif buffMo.buffType == MiracleHeroBuffType.PropertyChange then
			activeType[buffMo.proertyType] = buffMo.changeValue + (activeType[buffMo.proertyType] or 0)
		end
	end

	for i, v in pairs(activeType) do
		if i == "State" then
			content:append("嘲讽")
		else
			local type = i

			if type == GameEnum.AttrType.HpRate then
				type = GameEnum.AttrType.Hp
			elseif type == GameEnum.AttrType.AttackRate then
				type = GameEnum.AttrType.Attack
			end

			local name = GameEnum.AttrTypeName[type]

			if v > 0 then
				content:append(langPara("%s+", name))
			elseif v < 0 then
				content:append(langPara("%s-", name))
			end
		end
	end

	local info = {
		raceId = petMo.configId,
		actId = self._activityId,
		buffContent = content:toString("、")
	}

	UIStateManager.instance:open(ViewName.MiracleHeroPettipsView, info)
end

function MiracleHeroBattleView:_onClickSupport()
	if self._stateMachine.currStateName == STATE_CAN_OPERATE and not self._isSetAuto then
		local myTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.MyTeam)
		local supportCfg = MiracleHeroConfig.instance:getAssistCfg(self._activityId, myTeamMo.supportPet)

		if MiracleHeroSkillMgr.instance:getSupportColdDown() > 0 then
			FloatWordMgr.instance:show(lang("冷却中"))

			return
		end

		if MiracleHeroSkillMgr.instance:getEnergy() < supportCfg.ultCostEnergy then
			FloatWordMgr.instance:show(lang("怒气不足"))

			return
		end

		local skillMo = MiracleHeroSkillMgr.instance:getSupportSkill()

		MiracleHeroSkillMgr.instance:useSupportSkill()
		MiracleHeroRoundMgr.instance:addRound(skillMo, MiracleHeroTeamType.MyTeam)
		self._stateMachine:gotoState(STATE_MY_TEAM_ROUND)
	end
end

function MiracleHeroBattleView:_onClickSupportInfo()
	local myTeamMo = MiracleHeroUnitMgr.instance:getTeamMo(MiracleHeroTeamType.MyTeam)
	local supportCfg = MiracleHeroConfig.instance:getAssistCfg(self._activityId, myTeamMo.supportPet)
	local info = {
		assistId = supportCfg.assistId,
		actId = self._activityId
	}

	UIStateManager.instance:open(ViewName.MiracleHeroPettipsView, info)
end

function MiracleHeroBattleView:_onClickAuto()
	local challengCfgs = MiracleHeroConfig.instance:getChallengeCfgs(self._activityId)
	local challengCfg = challengCfgs[self._challengeId]

	if self._stageId < challengCfg.autoUnLock then
		FloatWordMgr.instance:show(langPara("通关当前挑战第%d关解锁自动战斗", challengCfg.autoUnLock))

		return
	end

	self._isSetAuto = not self._isSetAuto

	self._autoChange:SetState(self._isSetAuto and 1 or 0)

	if self._autoBtnTween then
		UnityTweens.TweenRotate.StopTween(self._imgAutoBg)
		GameUtil.setLocalRotation(self._imgAutoBg, 0, 0, 0)

		self._autoBtnTween = nil
	end

	if self._isSetAuto == true then
		self._autoBtnTween = UnityTweens.TweenRotate.StartTween(self._imgAutoBg, Vector3(0, 0, 0), Vector3(0, 0, 3600), 20)
		self._autoBtnTween.loopType = UnityTweens.LoopType.loop
	end

	if self._stateMachine.currStateName == STATE_CAN_OPERATE and self._isAuto == false then
		self._isAuto = true

		settimer(AUTO_SELECT_SHOW_TIME, self._autoSelect, self, false)
	end
end

function MiracleHeroBattleView:_onClickClose()
	if self._isAuto == true then
		FloatWordMgr.instance:show(lang("自动战斗中，无法操作"))
	elseif self._stateMachine.currStateName == STATE_CAN_OPERATE then
		local cutBigRound = MiracleHeroRoundMgr.instance:getBigRound()

		TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否退出战斗，进度将不会保存"), function(...)
			MiracleHeroController.instance:sendPM_MiracleHeroSyncBattleReq(self._activityId, cutBigRound, false)
			self._stateMachine:gotoState(STATE_GAME_END)
			self:close()
		end)
	else
		FloatWordMgr.instance:show(lang("敌方出手中，无法操作"))
	end
end

function MiracleHeroBattleView:_PM_MiracleHeroBattleStartRes()
	MiracleHeroBattleModel.instance:createBattle()
	self._stateMachine:gotoState(STATE_START)
end

function MiracleHeroBattleView:_PM_MiracleHeroSyncBattleRes(msg, isWin)
	if isWin == nil then
		if msg.cause and msg.cause ~= 0 then
			printError("未通过校验")
			self._stateMachine:gotoState(STATE_GAME_END)
			self:close()
		else
			self._stateMachine:gotoState(STATE_START)
		end
	else
		self._stateMachine:gotoState(STATE_GAME_END)

		if isWin == true then
			UIStateManager.instance:open(ViewName.MiracleHeroResultWinView, self._activityId, self._challengeId, self._stageId)
		else
			UIStateManager.instance:open(ViewName.MiracleHeroResultFailView)
		end
	end
end

return MiracleHeroBattleView
