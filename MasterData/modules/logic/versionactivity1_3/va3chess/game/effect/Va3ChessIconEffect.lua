-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/effect/Va3ChessIconEffect.lua

module("modules.logic.versionactivity1_3.va3chess.game.effect.Va3ChessIconEffect", package.seeall)

local Va3ChessIconEffect = class("Va3ChessIconEffect", Va3ChessEffectBase)

function Va3ChessIconEffect:onAvatarLoaded()
	if not self._loader then
		return
	end

	local go = self._loader:getInstGO()

	if not gohelper.isNil(go) then
		gohelper.setLayer(go, UnityLayer.Scene, true)

		local goTrack = gohelper.findChild(go, "icon_tanhao")

		self._target.avatar.goTrack = goTrack

		gohelper.setActive(goTrack, false)

		local goTracked = gohelper.findChild(go, "icon_jianshi")

		self._target.avatar.goTracked = goTracked

		gohelper.setActive(goTracked, false)

		self.moveKillIcon = gohelper.findChild(go, "icon_kejisha")

		gohelper.setActive(self.moveKillIcon, false)

		self.willKillPlayerIcon = gohelper.findChild(go, "icon_yuxi")

		gohelper.setActive(self.willKillPlayerIcon, false)

		self.fireBallKillIcon = gohelper.findChild(go, "icon_huoyanbiaoji")

		gohelper.setActive(self.fireBallKillIcon, false)
	end

	self._dirPointGODict = {}
	self._dirCanFireKillEffGODict = {}

	for _, tmpDir in pairs(Va3ChessEnum.Direction) do
		local child = self._target.avatar["goFaceTo" .. tmpDir]

		if not gohelper.isNil(child) then
			self._dirPointGODict[tmpDir] = gohelper.findChild(child, self._effectCfg.piontName)

			local dirCanFireKillEffGO = gohelper.findChild(child, "selected")

			self._dirCanFireKillEffGODict[tmpDir] = dirCanFireKillEffGO

			gohelper.setActive(dirCanFireKillEffGO, false)
		end
	end

	self:refreshEffectFaceTo()
end

function Va3ChessIconEffect:refreshEffectFaceTo()
	if not self._dirPointGODict then
		return
	end

	local dir = self._target.originData:getDirection()
	local dirPointGO = self._dirPointGODict[dir]

	if not gohelper.isNil(dirPointGO) then
		local posX, posY, posZ = transformhelper.getPos(dirPointGO.transform)

		transformhelper.setPos(self.effectGO.transform, posX, posY, posZ)
	end

	self:refreshKillEffect()
end

function Va3ChessIconEffect:refreshKillEffect()
	local willKillPlayer = false
	local alertAreaData = {}

	if self._target and self._target.originData and self._target.originData.data then
		alertAreaData = self._target.originData.data.alertArea
	end

	if alertAreaData and #alertAreaData > 0 then
		for _, alertAreaPos in ipairs(alertAreaData) do
			local playerNextPosDict = Va3ChessGameController.instance:getPlayerNextCanWalkPosDict()
			local posHashKey = Activity142Helper.getPosHashKey(alertAreaPos.x, alertAreaPos.y)

			willKillPlayer = playerNextPosDict[posHashKey]

			if playerNextPosDict[posHashKey] then
				break
			end
		end
	end

	gohelper.setActive(self.willKillPlayerIcon, willKillPlayer)

	local canBeFireBallKill = Activity142Helper.isCanFireKill(self._target)

	gohelper.setActive(self.fireBallKillIcon, canBeFireBallKill)
	self:refreshCanMoveKillEffect()
	self:refreshCanFireBallKillEffect(canBeFireBallKill)
end

function Va3ChessIconEffect:refreshCanMoveKillEffect()
	local isCanMoveKill = Activity142Helper.isCanMoveKill(self._target)

	gohelper.setActive(self.moveKillIcon, isCanMoveKill)
end

function Va3ChessIconEffect:refreshCanFireBallKillEffect(isCanFireKill)
	if not self._dirCanFireKillEffGODict then
		return
	end

	local dir = self._target.originData:getDirection()

	for tmpDir, effGO in pairs(self._dirCanFireKillEffGODict) do
		gohelper.setActive(effGO, isCanFireKill and dir == tmpDir)
	end
end

function Va3ChessIconEffect:isShowEffect(isShow)
	if not self._loader then
		return
	end

	local go = self._loader:getInstGO()

	if not gohelper.isNil(go) then
		gohelper.setActive(go, isShow)
	end
end

function Va3ChessIconEffect:onDispose()
	if self._dirPointGODict then
		for _, dirPointGO in pairs(self._dirPointGODict) do
			dirPointGO = nil
		end

		self._dirPointGODict = nil
	end

	if self._dirCanFireKillEffGODict then
		for _, effGO in pairs(self._dirCanFireKillEffGODict) do
			effGO = nil
		end

		self._dirCanFireKillEffGODict = nil
	end
end

return Va3ChessIconEffect
