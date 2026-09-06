-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/controller/FamilytpFlynuoGameController.lua

module("logic.extensions.familyteamplay.controller.FamilytpFamilytpFlynuoGameController", package.seeall)

local FamilytpFlynuoGameController = class("FamilytpFlynuoGameController", BaseController)

FamilytpFlynuoGameController.ScoreChange = "FamilytpFlynuoGameController.ScoreChange"
FamilytpFlynuoGameController.HpChange = "FamilytpFlynuoGameController.HpChange"

function FamilytpFlynuoGameController:ctor()
	return
end

function FamilytpFlynuoGameController:onInit()
	self._uiCamera = goutil.find("UICamera"):GetComponent(ComponentType.Camera)

	self:onReset()
end

function FamilytpFlynuoGameController:onReset()
	self._isInit = false
	self._isGameStart = false
	self._isGameOver = false
	self._isPause = false
	self._isDoReliveState = false
	self._gameId = 0

	removetimer(self._update, self)

	if self._pipeFactory then
		self._pipeFactory:destroyPipe()
	end
end

function FamilytpFlynuoGameController:gameInit(gameId, playerView, player, pipeParent, pipeCellGo)
	self:onReset()

	self._gameId = gameId
	self._pipeFactory = self._pipeFactory or FlynuoPipeFactory.New()
	self._playerView = playerView
	self._player = player
	self._isInit = true

	self._pipeFactory:init(self._player, pipeParent, pipeCellGo, true)

	self._gamePlayTime = 0

	settimer(0.02, self._update, self, true)
end

function FamilytpFlynuoGameController:_startGame()
	self._pipeInitSpeed = FlyNuoConfig.instance:getPipeInitSpeed()
	self._pipeSpeed = self._pipeInitSpeed

	self:_checkPlayerState()
	self._playerView:startGame()

	self._gamePlayTime = 0
	self._isGameStart = true
end

function FamilytpFlynuoGameController:endGame()
	if self._isGameOver then
		return
	end

	removetimer(self._update, self)
	removetimer(self._endFly, self)

	self._isGameStart = false
	self._isGameOver = true
	self._isPause = false
	self._isDoReliveState = false

	self:_doEndGameAnim()
end

function FamilytpFlynuoGameController:_doEndGameAnim()
	local function finishiCallBack()
		local score = FamilyteamplayModel.instance:getFlynuoScore()

		if score and score > 0 then
			FamilyteamplayModel.instance:setFlynuoScoreToTemp(score)
		end

		FamilyteamplayController.instance:csSendTeamPlaySmallGameEndReq(self._gameId, score)

		if self._playerView then
			self._playerView:close()
		end
	end

	self._player:doDied(finishiCallBack)
end

function FamilytpFlynuoGameController:realEngGame()
	removetimer(self._update, self)
	self._pipeFactory:destroyPipe()

	self._playerView = nil
	self._player = nil
end

function FamilytpFlynuoGameController:_update()
	if not self._isInit then
		return
	end

	if self._isGameOver then
		return
	end

	if self._isPause then
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

	self._gamePlayTime = self._gamePlayTime + Time.deltaTime
	self._pipeSpeed = self._pipeInitSpeed + self._gamePlayTime * FlyNuoConfig.instance:getPipeAcceleration()
	self._pipeSpeed = math.min(self._pipeSpeed, FlyNuoConfig.instance:getPipeMaxSpeed())

	self._pipeFactory:changeSpeed(self._pipeSpeed)
	self:_checkHitBox()
	self._player:update()
end

function FamilytpFlynuoGameController:_jump()
	self._player:jump()
end

local isHitState = false
local isPassState = false

function FamilytpFlynuoGameController:_checkHitBox()
	isHitState = self._pipeFactory:isPlayerHit(self._player:getBound())

	if isHitState then
		FamilyteamplayModel.instance:reduceFlyNuoHp()
		self._player:isHit()
		self._playerView:isHit()
		GlobalDispatcher:dispatch(FamilytpFlynuoGameController.HpChange)
	end

	local hp = FamilyteamplayModel.instance:getFlyNuoHp()

	if hp <= 0 then
		self:_pauseGame()
		self:endGame()

		return
	end

	self:_checkHitPass()
end

function FamilytpFlynuoGameController:_checkHitPass()
	isPassState = self._pipeFactory:isPlayerPass()

	if not self._isGameOver and isPassState then
		FamilyteamplayModel.instance:addFlynuoPipeScore()
		GlobalDispatcher:dispatch(FamilytpFlynuoGameController.ScoreChange)
	end
end

function FamilytpFlynuoGameController:worldPosToScreenPos(pos)
	return self._uiCamera:WorldToScreenPoint(pos)
end

function FamilytpFlynuoGameController:_checkPlayerState()
	local speed = self._pipeInitSpeed

	self._player:endFly()
	self._pipeFactory:startPipe(speed)
end

function FamilytpFlynuoGameController:_endFly()
	removetimer(self._endFly, self)
	self._player:endFly()
	self._pipeFactory:playerEndFly(self._pipeSpeed)
end

function FamilytpFlynuoGameController:_pauseGame()
	self._isPause = true

	self._pipeFactory:changeSpeed(0)
	self._player:pause()
end

FamilytpFlynuoGameController.instance = FamilytpFlynuoGameController.New()

return FamilytpFlynuoGameController
