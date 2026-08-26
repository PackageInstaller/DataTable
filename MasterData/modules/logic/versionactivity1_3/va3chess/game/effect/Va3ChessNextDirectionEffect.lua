-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/effect/Va3ChessNextDirectionEffect.lua

module("modules.logic.versionactivity1_3.va3chess.game.effect.Va3ChessNextDirectionEffect", package.seeall)

local Va3ChessNextDirectionEffect = class("Va3ChessNextDirectionEffect", Va3ChessEffectBase)

function Va3ChessNextDirectionEffect:refreshEffect()
	return
end

function Va3ChessNextDirectionEffect:onDispose()
	return
end

function Va3ChessNextDirectionEffect:refreshNextDirFlag()
	if self._target.originData.data and self._target.originData.data.alertArea then
		local curX, curY = self._target.originData.posX, self._target.originData.posY
		local alertArea = self._target.originData.data.alertArea
		local needRefreshFace = #alertArea == 1

		if needRefreshFace then
			local tarX, tarY = alertArea[1].x, alertArea[1].y
			local srcX, srcY = self._target.originData.posX, self._target.originData.posY
			local dir = Va3ChessMapUtils.ToDirection(srcX, srcY, tarX, tarY)

			self._target:getHandler():faceTo(dir)
		end
	end
end

function Va3ChessNextDirectionEffect:onAvatarLoaded()
	local loader = self._loader

	if not self._loader then
		return
	end

	local go = loader:getInstGO()

	if not gohelper.isNil(go) then
		local avatar = self._target.avatar

		for _, dir in ipairs(Va3ChessInteractObject.DirectionList) do
			local godir = gohelper.findChild(go, "dir_" .. dir)

			avatar.goNextDirection = go
			avatar["goMovetoDir" .. dir] = godir

			gohelper.setActive(godir, false)
		end
	end

	self:refreshNextDirFlag()
end

return Va3ChessNextDirectionEffect
