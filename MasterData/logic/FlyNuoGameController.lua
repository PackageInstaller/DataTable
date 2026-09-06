-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/controller/FlyNuoGameController.lua

module("logic.extensions.flyingnuo.controller.FlyNuoGameController", package.seeall)

local FlyNuoGameController = class("FlyNuoGameController", BaseController)

FlyNuoGameController.ScoreChange = "FlyNuoGameController.ScoreChange"
FlyNuoGameController.HpChange = "FlyNuoGameController.HpChange"
FlyNuoGameController.ShieldChange = "FlyNuoGameController.ShieldChange"
FlyNuoGameController.ShieldState = {
	Add = 1,
	Delete = 2
}

function FlyNuoGameController:ctor()
	return
end

function FlyNuoGameController:onInit()
	self._pipeFactory = FlynuoPipeFactory.New()
	self._uiCamera = goutil.find("UICamera"):GetComponent(ComponentType.Camera)

	self:onReset()
end

function FlyNuoGameController:onReset()
	self._isInit = false
	self._isGameStart = false
	self._isGameOver = false
	self._isPause = false
	self._isDoReliveState = false

	removetimer(self._update, self)

	if self._pipeFactory then
		self._pipeFactory:onReset()
	end

	GlobalDispatcher:removeListener(FlyingNuoAgent.ReliveRes, self._relive, self)
end

function FlyNuoGameController:gameInit(playerView, player, pipeParent, pipeCellGo)
	self:onReset()

	self._playerView = playerView
	self._player = player
	self._isInit = true

	self._pipeFactory:init(self._player, pipeParent, pipeCellGo)
	GlobalDispatcher:addListener(FlyingNuoAgent.ReliveRes, self._relive, self)

	self._gamePlayTime = 0

	settimer(0.02, self._update, self, true)
end

function FlyNuoGameController:_startGame()
	self._pipeInitSpeed = FlyNuoConfig.instance:getPipeInitSpeed()
	self._pipeSpeed = self._pipeInitSpeed

	self:_checkPlayerState()
	self._playerView:startGame()

	self._gamePlayTime = 0
	self._isGameStart = true
end

function FlyNuoGameController:endGame()
	removetimer(self._update, self)
	removetimer(self._endFly, self)

	self._isGameStart = false
	self._isGameOver = true
	self._isPause = false
	self._isDoReliveState = false

	self:_doEndGameAnim()
end

function FlyNuoGameController:_doEndGameAnim()
	local function finishiCallBack()
		FlyNuoController.instance:endGame()
	end

	self._player:doDied(finishiCallBack)
	self._pipeFactory:stopPipe()
end

function FlyNuoGameController:realEngGame()
	self._pipeFactory:destroyPipe()
	self._playerView:close()

	self._playerView = nil
	self._player = nil
end

function FlyNuoGameController:_update()
	if not FlyNuoModel.instance.playViewIsOpen then
		return
	end

	if not self._isInit then
		return
	end

	if self._isGameOver then
		return
	end

	if self._isPause and not self._isReliveState then
		return
	end

	if self._isDoReliveState then
		return
	end

	if UGUIToolHelper.IsTouchDown() then
		if self._isGameStart then
			self:_jump()
		else
			self:_startGame()
			self:_jump()
		end
	end

	if not self._isGameStart then
		return
	end

	if self._isReliveState then
		return
	end

	if not self._player:isWudiFly() then
		self._gamePlayTime = self._gamePlayTime + Time.deltaTime
		self._pipeSpeed = self._pipeInitSpeed + self._gamePlayTime * FlyNuoConfig.instance:getPipeAcceleration()
		self._pipeSpeed = math.min(self._pipeSpeed, FlyNuoConfig.instance:getPipeMaxSpeed())

		self._pipeFactory:changeSpeed(self._pipeSpeed)
	end

	self:_checkHitBox()
	self._player:update()
end

function FlyNuoGameController:_jump()
	if self._isReliveState then
		self._isReliveState = false

		self._pipeFactory:startPipe(self._pipeSpeed)
	end

	self._playerView:hideClickEffect()
	self._player:jump()
end

local isHitState = false
local isPassState = false

function FlyNuoGameController:_checkHitBox()
	isHitState = not self._player:isWudi() and self._pipeFactory:isPlayerHit(self._player:getBound())

	if isHitState then
		FlyNuoModel.instance:reduceHp()
		self._player:isHit()
		self._playerView:isHit()
		GlobalDispatcher:dispatch(FlyNuoGameController.HpChange)
	end

	local hp = FlyNuoModel.instance:getHp()

	if hp <= 0 then
		self:_pauseGame()

		local canRelive = self:_checkCanRelive()

		if canRelive then
			self:_doRelive()
		else
			self:endGame()
		end

		return
	end

	self:_checkHitPropItem()
	self:_checkHitPass()
end

function FlyNuoGameController:_checkHitPropItem()
	self._pipeFactory:checkPlayerHitPropItem()
end

function FlyNuoGameController:_checkHitPass()
	isPassState = self._pipeFactory:isPlayerPass()

	if not self._isGameOver and isPassState then
		FlyNuoModel.instance:addPipeScore()
		GlobalDispatcher:dispatch(FlyNuoGameController.ScoreChange)
	end
end

function FlyNuoGameController:_checkCanRelive()
	local canReliveTime = FlyNuoConfig.instance:getCanReliveTime()
	local reliveTime = FlyNuoModel.instance:getReliveTime()

	return reliveTime < canReliveTime
end

function FlyNuoGameController:_doRelive()
	local reliveTime = FlyNuoModel.instance:getReliveTime()
	local matStr = FlyNuoConfig.instance:getReliveCostCfgByTime(reliveTime + 1)
	local popupView = false

	if matStr then
		local isEnough = MaterialFacade.instance:isMatsEnough(matStr)

		if isEnough then
			popupView = true
			self._isDoReliveState = true

			local function okFunc()
				FlyingNuoAgent.instance:sendPM_ReliveReq()
			end

			local function cencelFunc()
				self:endGame()
			end

			local info = FlyNuoModel.instance:getActivityInfo()
			local t = GameUtil.parseMatStr2Table(matStr)
			local name = MaterialMgr.getMaterialsName(t[1], t[2])
			local cost = MaterialFacade.instance:getGoodCostByStr(matStr)
			local score = FlyNuoModel.instance:getScore()
			local canReliveTime = FlyNuoConfig.instance:getCanReliveTime()
			local reliveTime = FlyNuoModel.instance:getReliveTime()
			local content = string.format("是否消耗<color=red>%s钻石</color>，复活<color=red>1次</color>?\n每局游戏可复活<color=red>%s次</color>，当前第<color=red>%s次</color>", cost, canReliveTime, reliveTime + 1)

			TipsFacade.instance:openPopupWindow("购买确认", content, okFunc, cencelFunc)
		end
	end

	if not popupView then
		self:endGame()
	end
end

function FlyNuoGameController:worldPosToScreenPos(pos)
	return self._uiCamera:WorldToScreenPoint(pos)
end

function FlyNuoGameController:_checkPlayerState()
	local useWudi = FlyNuoModel.instance:isUseGameStartItem()
	local speed = self._pipeInitSpeed

	if useWudi then
		local flyTime = FlyNuoConfig.instance:getWudiFlyTime()

		speed = FlyNuoConfig.instance:getPipeMaxSpeed()

		self._player:startFly(flyTime)
		settimer(flyTime, self._endFly, self, false)
	else
		self._player:endFly()
	end

	self._pipeFactory:startPipe(speed)
end

function FlyNuoGameController:_endFly()
	removetimer(self._endFly, self)
	self._player:endFly()
	self._pipeFactory:playerEndFly(self._pipeSpeed)
end

function FlyNuoGameController:_pauseGame()
	self._isPause = true

	self._pipeFactory:changeSpeed(0)
	self._player:pause()
end

function FlyNuoGameController:_relive()
	self._isPause = false
	self._isGameOver = false
	self._isDoReliveState = false

	self._player:relive()
	self._playerView:relive()
	self._pipeFactory:changeSpeed(0)
	self._pipeFactory:_resetItems()

	self._isReliveState = true
end

FlyNuoGameController.instance = FlyNuoGameController.New()

return FlyNuoGameController
