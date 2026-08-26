-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/interacts/Va3ChessInteractOncePushed.lua

module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractOncePushed", package.seeall)

local Va3ChessInteractOncePushed = class("Va3ChessInteractOncePushed", Va3ChessInteractBase)

function Va3ChessInteractOncePushed:checkCanBlock(fromDir, targetObjType)
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

	local count, rs = Va3ChessGameController.instance:searchInteractByPos(nextPosX, nextPosY)

	if count > 0 then
		if count == 1 then
			return rs and rs:getObjType() ~= Va3ChessEnum.InteractType.DestroyableTrap
		else
			return true
		end
	end
end

function Va3ChessInteractOncePushed:checkNoTileByXY(x, y)
	if not Va3ChessGameModel.instance:isPosInChessBoard(x, y) then
		return true
	end

	local tileMO = Va3ChessGameModel.instance:getTileMO(x, y)

	if not tileMO or tileMO.tileType == Va3ChessEnum.TileBaseType.None or tileMO:isFinishTrigger(Va3ChessEnum.TileTrigger.PoSui) then
		return true
	end

	return false
end

function Va3ChessInteractOncePushed:showStateView(objState, params)
	if objState == Va3ChessEnum.ObjState.Idle then
		self:showIdleStateView()
	elseif objState == Va3ChessEnum.ObjState.Interoperable then
		self:showPushableStateView(params)
	end
end

function Va3ChessInteractOncePushed:showIdleStateView()
	self:setArrawDir(0)
end

function Va3ChessInteractOncePushed:showPushableStateView(params)
	local dir = params.dir

	self:setArrawDir(dir)
end

function Va3ChessInteractOncePushed:setArrawDir(dir)
	if self._target.avatar then
		for i, tmpDir in ipairs(Va3ChessInteractObject.DirectionList) do
			local child = self._target.avatar["arraw" .. tmpDir]

			if not gohelper.isNil(child) then
				gohelper.setActive(child, dir == tmpDir)
			end
		end
	end
end

local breakenAniName = "idle_b"

function Va3ChessInteractOncePushed:onAvatarLoaded()
	Va3ChessInteractOncePushed.super.onAvatarLoaded(self)

	local loader = self._target.avatar.loader

	if not loader then
		return
	end

	local go = loader:getInstGO()

	if not gohelper.isNil(go) then
		self._animator = go:GetComponent(typeof(UnityEngine.Animator))

		for _, dir in ipairs(Va3ChessInteractObject.DirectionList) do
			self._target.avatar["arraw" .. dir] = gohelper.findChild(go, "icon/icon_direction/dir_" .. dir)
		end
	end

	if self._target.originData.data.status and self._animator then
		self._animator:Play(breakenAniName)
	end
end

function Va3ChessInteractOncePushed:onMoveCompleted()
	Va3ChessInteractOncePushed.super.onMoveCompleted(self)
	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.VatPushDown)

	if self._animator then
		self._animator:Play(UIAnimationName.Close, 0, 0)
	end
end

return Va3ChessInteractOncePushed
