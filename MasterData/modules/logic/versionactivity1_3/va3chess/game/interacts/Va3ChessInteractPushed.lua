-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/interacts/Va3ChessInteractPushed.lua

module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractPushed", package.seeall)

local Va3ChessInteractPushed = class("Va3ChessInteractPushed", Va3ChessInteractBase)

function Va3ChessInteractPushed:checkCanBlock(fromDir, targetObjType)
	if targetObjType == Va3ChessEnum.InteractType.AssistPlayer then
		return true
	end

	if self._target.originData.data.status then
		return true
	end

	local nextPosX, nextPosY = Va3ChessMapUtils.CalNextCellPos(self._target.originData.posX, self._target.originData.posY, fromDir)
	local isNextPosNoTile = self:checkNoTileByXY(nextPosX, nextPosY)

	if isNextPosNoTile then
		return true
	end

	local count = Va3ChessGameController.instance:searchInteractByPos(nextPosX, nextPosY)

	if count > 0 then
		return true
	end
end

function Va3ChessInteractPushed:checkNoTileByXY(x, y)
	if not Va3ChessGameModel.instance:isPosInChessBoard(x, y) then
		return true
	end

	local tileMO = Va3ChessGameModel.instance:getTileMO(x, y)

	if not tileMO or tileMO.tileType == Va3ChessEnum.TileBaseType.None or tileMO:isFinishTrigger(Va3ChessEnum.TileTrigger.PoSui) then
		return true
	end

	return false
end

function Va3ChessInteractPushed:showStateView(objState, params)
	if objState == Va3ChessEnum.ObjState.Idle then
		self:showIdleStateView()
	elseif objState == Va3ChessEnum.ObjState.Interoperable then
		self:showPushableStateView(params)
	end
end

function Va3ChessInteractPushed:showIdleStateView()
	self:setArrawDir(0)
end

function Va3ChessInteractPushed:showPushableStateView(params)
	local dir = params.dir

	self:setArrawDir(dir)
end

function Va3ChessInteractPushed:onAvatarLoaded()
	Va3ChessInteractPushed.super.onAvatarLoaded(self)

	local go = self._target.avatar.loader:getInstGO()

	for _, dir in ipairs(Va3ChessInteractObject.DirectionList) do
		self._target.avatar["arraw" .. dir] = gohelper.findChild(go, "icon/icon_direction/dir_" .. dir)
	end
end

function Va3ChessInteractPushed:setArrawDir(dir)
	if self._target.avatar then
		for i, tmpDir in ipairs(Va3ChessInteractObject.DirectionList) do
			local child = self._target.avatar["arraw" .. tmpDir]

			if not gohelper.isNil(child) then
				gohelper.setActive(child, dir == tmpDir)
			end
		end
	end
end

local smokeEffect = "vx_smoke"

function Va3ChessInteractPushed:onMoveBegin()
	local go = self._target.avatar.loader:getInstGO()
	local smokeGo = gohelper.findChild(go, smokeEffect)

	gohelper.setActive(smokeGo, false)
	gohelper.setActive(smokeGo, true)
	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.PushStone)
end

return Va3ChessInteractPushed
