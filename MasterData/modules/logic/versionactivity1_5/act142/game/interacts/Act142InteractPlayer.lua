-- chunkname: @modules/logic/versionactivity1_5/act142/game/interacts/Act142InteractPlayer.lua

module("modules.logic.versionactivity1_5.act142.game.interacts.Act142InteractPlayer", package.seeall)

local Act142InteractPlayer = class("Act142InteractPlayer", Va3ChessInteractBase)

function Act142InteractPlayer:init(targetObj)
	Act142InteractPlayer.super.init(self, targetObj)

	self._fireBallTweenMoveId = nil
	self._isFiring = false
end

function Act142InteractPlayer:onAvatarLoaded()
	Act142InteractPlayer.super.onAvatarLoaded(self)

	local loader = self._target.avatar.loader

	if not loader then
		return
	end

	local go = loader:getInstGO()

	if not gohelper.isNil(go) then
		local fireballParent = gohelper.findChild(go, "fireball")

		gohelper.setActive(fireballParent, true)

		for i = 1, Activity142Enum.MAX_FIRE_BALL_NUM do
			local name = "goFireBall" .. i
			local showFireBallGO = gohelper.findChild(go, "fireball/fireball" .. i)

			if not gohelper.isNil(showFireBallGO) then
				self._target.avatar[name] = showFireBallGO

				gohelper.setActive(showFireBallGO, false)
			end
		end

		self._animSelf = go:GetComponent(Va3ChessEnum.ComponentType.Animator)

		if self._animSelf then
			local mo = Va3ChessGameModel.instance:getObjectDataById(self._target.id)

			if mo and mo:getHaveBornEff() then
				self._animSelf:Play(Activity142Enum.SWITCH_OPEN_ANIM, 0, 0)
				mo:setHaveBornEff(false)
			end
		end
	end

	self:updateFireBallCount()
	loadAbAsset(Va3ChessEnum.Bullet.FireBall.path, false, self._onLoadFireBallBulletComplete, self)
end

function Act142InteractPlayer:onSelected()
	Va3ChessGameController.instance:setClickStatus(Va3ChessEnum.SelectPosStatus.SelectObjWaitPos)

	local x, y = self._target.originData.posX, self._target.originData.posY
	local evtObj = {
		visible = true,
		posXList = {},
		posYList = {},
		selfPosX = x,
		selfPosY = y,
		selectType = Va3ChessEnum.ChessSelectType.Normal
	}

	self:insertPosToList(x + 1, y, evtObj.posXList, evtObj.posYList)
	self:insertPosToList(x - 1, y, evtObj.posXList, evtObj.posYList)
	self:insertPosToList(x, y + 1, evtObj.posXList, evtObj.posYList)
	self:insertPosToList(x, y - 1, evtObj.posXList, evtObj.posYList)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, evtObj)
end

function Act142InteractPlayer:insertPosToList(x, y, posXList, posYList)
	local curX, curY = self._target.originData.posX, self._target.originData.posY
	local dir = Va3ChessMapUtils.ToDirection(curX, curY, x, y)

	if Va3ChessGameController.instance:posCanWalk(x, y, dir, self._target.objType) then
		table.insert(posXList, x)
		table.insert(posYList, y)
	end
end

function Act142InteractPlayer:onCancelSelect()
	Va3ChessGameController.instance:setClickStatus(Va3ChessEnum.SelectPosStatus.None)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
end

function Act142InteractPlayer:onSelectPos(x, y)
	local canFire, targetId = self:isCanFire(x, y)

	if canFire and targetId then
		self:requestFire(x, y, targetId)
	else
		self:requestBeginRound(x, y)
	end
end

function Act142InteractPlayer:requestBeginRound(x, y)
	local curX, curY = self._target.originData.posX, self._target.originData.posY
	local isSurroundPlayer = Activity142Helper.isSurroundPlayer(x, y)

	if not isSurroundPlayer then
		GameFacade.showToast(ToastEnum.ChessCanNotMoveHere)

		return
	end

	local dir = Va3ChessMapUtils.ToDirection(curX, curY, x, y)
	local posCanWalk = Va3ChessGameController.instance:posCanWalk(x, y, dir, self._target.objType)

	if not posCanWalk then
		GameFacade.showToast(ToastEnum.ChessCanNotMoveHere)

		return
	end

	local optData = {
		id = self._target.originData.id,
		dir = Va3ChessMapUtils.ToDirection(curX, curY, x, y)
	}

	Va3ChessGameModel.instance:appendOpt(optData)

	local actId = Va3ChessGameModel.instance:getActId()
	local optList = Va3ChessGameModel.instance:getOptList()

	Va3ChessRpcController.instance:sendActBeginRoundRequest(actId, optList, self.onMoveSuccess, self)
	Va3ChessGameController.instance:saveTempSelectObj()
	Va3ChessGameController.instance:setSelectObj(nil)

	local evtMgr = Va3ChessGameController.instance.event

	if evtMgr then
		evtMgr:setLockEvent()
	end
end

function Act142InteractPlayer:updateFireBallCount()
	local hasFireBallCount = Va3ChessGameModel.instance:getFireBallCount()

	for index = 1, Activity142Enum.MAX_FIRE_BALL_NUM do
		local name = "goFireBall" .. index
		local showFireBallGO = self._target.avatar[name]

		if not gohelper.isNil(showFireBallGO) then
			gohelper.setActive(showFireBallGO, index <= hasFireBallCount)
		end
	end
end

function Act142InteractPlayer:_onLoadFireBallBulletComplete(assetItem)
	if assetItem and assetItem.IsLoadSuccess then
		local parentGO
		local playerSceneGO = self._target:tryGetSceneGO()

		if not gohelper.isNil(playerSceneGO) then
			local playerSceneTrans = playerSceneGO.transform

			parentGO = playerSceneTrans.parent and playerSceneTrans.parent.gameObject or nil
		end

		if self._fireBallBulletAssetItem then
			self._fireBallBulletAssetItem:Release()
		end

		self._fireBallBulletAssetItem = assetItem

		self._fireBallBulletAssetItem:Retain()

		local fireBallBulletGO = gohelper.clone(self._fireBallBulletAssetItem:GetResource(Va3ChessEnum.Bullet.FireBall.path), parentGO)

		if not gohelper.isNil(fireBallBulletGO) then
			self.fireBallBulletItem = {}
			self.fireBallBulletItem.go = fireBallBulletGO
			self.fireBallBulletItem.dir2GO = {}

			for _, tmpDir in pairs(Va3ChessEnum.Direction) do
				self.fireBallBulletItem.dir2GO[tmpDir] = gohelper.findChild(self.fireBallBulletItem.go, string.format("dir_%s", tmpDir))
			end

			self:_setFireBallDirGOActive()

			self.fireBallBulletItem.hitEffect = gohelper.findChild(self.fireBallBulletItem.go, "vx_fire_hit")

			gohelper.setActive(self.fireBallBulletItem.hitEffect, false)
		else
			logError("Act142InteractPlayer._onLoadFireBallBulletComplete error, get bulletGO fail")
		end
	end
end

function Act142InteractPlayer:isCanFire(x, y)
	local result = false
	local interactId

	if self._isFiring then
		return result, interactId
	end

	local fireKillLen, searchResult = Va3ChessGameController.instance:searchInteractByPos(x, y, Activity142Helper.filterCanFireKill)
	local targetInteractObj = fireKillLen == 1 and searchResult or searchResult and searchResult[1] or nil

	result = Activity142Helper.isCanFireKill(targetInteractObj)
	interactId = result and targetInteractObj.id or nil

	return result, interactId
end

function Act142InteractPlayer:requestFire(x, y, targetId)
	if self._isFiring then
		logError("Act142InteractPlayer:requestFire error, cannot repeat fire")

		return
	end

	local fireBallCount = Va3ChessGameModel.instance:getFireBallCount()
	local notHasFireBall = fireBallCount < 0

	if notHasFireBall then
		logError("Act142InteractPlayer:requestFire error, not have fireBall showing")

		return
	end

	local actId = Activity142Model.instance:getActivityId()
	local curPlayerX, curPlayerY = self._target.originData.posX, self._target.originData.posY

	Activity142Rpc.instance:sendAct142UseFireballRequest(actId, curPlayerX, curPlayerY, x, y, targetId, self.playFireBallTween, self)
end

function Act142InteractPlayer:playFireBallTween(_, resultCode, msg)
	if resultCode ~= 0 or string.nilorempty(msg.useFireball) then
		return
	end

	self:updateFireBallCount()

	local data = cjson.decode(msg.useFireball)

	if not data then
		return
	end

	local targetId = data.targetId

	if not targetId or targetId <= 0 then
		return
	end

	if not self.fireBallBulletItem or gohelper.isNil(self.fireBallBulletItem.go) then
		return
	end

	if not data.y1 then
		local startX, startY = data.x1 or 0, 0

		if not data.y2 then
			local endX, endY = data.x2 or 0, 0
			local w, h = Va3ChessGameModel.instance:getGameSize()

			endX = Mathf.Clamp(endX, 0, w - 1)
			endY = Mathf.Clamp(endY, 0, h - 1)

			local dir = Va3ChessMapUtils.ToDirection(startX, startY, endX, endY)

			self:_setFireBallDirGOActive(dir)

			local fireBallTrans = self.fireBallBulletItem.go.transform
			local playerX, playerY, playerZ = Va3ChessGameController.instance:calcTilePosInScene(startX, startY)

			transformhelper.setLocalPos(fireBallTrans, playerX, playerY, playerZ)
			Activity142Helper.setAct142UIBlock(true, Activity142Enum.FIRING_BALL)

			self._tmpTargetId = targetId

			local pedalId = data.pedalObjectId

			if pedalId and pedalId > 0 then
				self._tmpPedalId = pedalId
				self._tmpPedalStatus = data.pedalStatus
			end

			self._isFiring = true

			local flyTime = Va3ChessMapUtils.calBulletFlyTime(Va3ChessEnum.Bullet.FireBall.speed, startX, startY, endX, endY)
			local sceneX, sceneY, sceneZ = Va3ChessGameController.instance:calcTilePosInScene(endX, endY)

			self._fireBallTweenMoveId = ZProj.TweenHelper.DOLocalMove(fireBallTrans, sceneX, sceneY, sceneZ, flyTime, self.onFireBallTweenComplete, self, nil, EaseType.Linear)

			AudioMgr.instance:trigger(AudioEnum.chess_activity142.FireBall)
		end
	end
end

function Act142InteractPlayer:_setFireBallDirGOActive(dir)
	if not self.fireBallBulletItem or not self.fireBallBulletItem.dir2GO then
		return
	end

	for goDir, dirGO in pairs(self.fireBallBulletItem.dir2GO) do
		gohelper.setActive(dirGO, goDir == dir)
	end
end

function Act142InteractPlayer:onFireBallTweenComplete()
	self._fireBallTweenMoveId = nil

	local eventMgr = Va3ChessGameController.instance.event

	if eventMgr then
		if self._tmpTargetId then
			local deleteJsonData = {}

			deleteJsonData.param = string.format("{\"stepType\":%s,\"id\":%s,\"reason\":%s,\"refreshAllKillEff\":%s}", Va3ChessEnum.GameStepType.DeleteObject, self._tmpTargetId, Va3ChessEnum.DeleteReason.FireBall, 1)

			eventMgr:insertStep(deleteJsonData)

			local interactFinishJsonData = {}

			interactFinishJsonData.param = string.format("{\"stepType\":%s,\"id\":%s}", Va3ChessEnum.GameStepType.InteractFinish, self._tmpTargetId)

			eventMgr:insertStep(interactFinishJsonData)
			gohelper.setActive(self.fireBallBulletItem.hitEffect, false)
			gohelper.setActive(self.fireBallBulletItem.hitEffect, true)
			AudioMgr.instance:trigger(AudioEnum.chess_activity142.MonsterBeHit)
		end

		if self._tmpPedalId then
			local refreshPedalJsonData = {}

			refreshPedalJsonData.param = string.format("{\"stepType\":%s,\"id\":%s,\"pedalStatus\":%s}", Va3ChessEnum.GameStepType.RefreshPedalStatus, self._tmpPedalId, self._tmpPedalStatus)

			eventMgr:insertStep(refreshPedalJsonData)
		end
	end

	self:_setFireBallDirGOActive()

	self._isFiring = false
	self._tmpTargetId = nil
	self._tmpPedalId = nil
	self._tmpPedalStatus = nil

	Activity142Helper.setAct142UIBlock(false, Activity142Enum.FIRING_BALL)
end

function Act142InteractPlayer:dispose()
	if self._fireBallBulletAssetItem then
		self._fireBallBulletAssetItem:Release()

		self._fireBallBulletAssetItem = nil
	end

	if self._fireBallTweenMoveId then
		ZProj.TweenHelper.KillById(self._fireBallTweenMoveId)

		self._fireBallTweenMoveId = nil
	end

	self:onFireBallTweenComplete()

	if self.fireBallBulletItem then
		if self.fireBallBulletItem.dir2GO then
			for _, dirGO in pairs(self.fireBallBulletItem.dir2GO) do
				dirGO = nil
			end

			self.fireBallBulletItem.dir2GO = nil
		end

		self.fireBallBulletItem.hitEffect = nil

		gohelper.destroy(self.fireBallBulletItem.go)

		self.fireBallBulletItem.go = nil
	end

	self.fireBallBulletItem = {}
	self._isFiring = false
	self._tmpTargetId = nil
	self._tmpPedalId = nil
	self._tmpPedalStatus = nil

	Act142InteractPlayer.super.dispose(self)
end

return Act142InteractPlayer
