-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepDeleteObject.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepDeleteObject", package.seeall)

local Va3ChessStepDeleteObject = class("Va3ChessStepDeleteObject", Va3ChessStepBase)
local DEFAULT_DIE_ANIM_TIME = 0.1
local BULLET_HIT_DIE_ANIM_TIME = 1
local PLAYER_DELETE_ANIM_TIME = 0.7

function Va3ChessStepDeleteObject:start()
	local objId = self.originData.id
	local interactMgr = Va3ChessGameController.instance.interacts
	local interactObj = interactMgr and interactMgr:get(objId) or nil

	if interactObj and interactObj.config then
		local interactType = interactObj.config.interactType
		local deleteReason = self.originData.reason

		if interactType == Va3ChessEnum.InteractType.Player or interactType == Va3ChessEnum.InteractType.AssistPlayer then
			if self:checkPlayDisappearAnim(interactObj, deleteReason) then
				return
			end
		elseif interactObj:getHandler().playDeleteObjView then
			interactObj:getHandler():playDeleteObjView(deleteReason)
			TaskDispatcher.runDelay(self.removeFinish, self, (deleteReason == Va3ChessEnum.DeleteReason.Arrow or deleteReason == Va3ChessEnum.DeleteReason.FireBall or deleteReason == Va3ChessEnum.DeleteReason.MoveKill or nil) and BULLET_HIT_DIE_ANIM_TIME)

			return
		end
	end

	self:removeFinish()
end

local DeleteReason2Show = {
	[Va3ChessEnum.DeleteReason.Falling] = {
		anim = "down"
	},
	[Va3ChessEnum.DeleteReason.EnemyKill] = {
		anim = "die",
		audio = AudioEnum.chess_activity142.Die
	},
	[Va3ChessEnum.DeleteReason.Change] = {
		anim = Activity142Enum.SWITCH_CLOSE_ANIM
	}
}

function Va3ChessStepDeleteObject:checkPlayDisappearAnim(interactObj, deleteReason)
	if interactObj.avatar and interactObj.avatar.goSelected then
		local anim = interactObj.avatar.goSelected:GetComponent(typeof(UnityEngine.Animator))

		if anim then
			anim:Play("close", 0, 0)
		end
	end

	if deleteReason == Va3ChessEnum.DeleteReason.Change then
		local curX, curY = interactObj.originData.posX, interactObj.originData.posY

		Activity142Controller.instance:dispatchEvent(Activity142Event.PlaySwitchPlayerEff, curX, curY)
	end

	local go = interactObj:tryGetGameObject()

	if not gohelper.isNil(go) then
		local goVfx = gohelper.findChild(go, "vx_disappear")

		gohelper.setActive(goVfx, true)

		local goTracked = gohelper.findChild(go, "piecea/vx_tracked")

		if not gohelper.isNil(goTracked) then
			local animTracked = goTracked:GetComponent(typeof(UnityEngine.Animator))

			if animTracked then
				animTracked:Play("close", 0, 0)
			end
		end

		local animator = go:GetComponent(typeof(UnityEngine.Animator))

		if animator then
			if not DeleteReason2Show[deleteReason] then
				local showData = {}

				if not showData.anim then
					local animName = "close"

					animator:Play(animName, 0, 0)

					local audioId = showData.audio

					if audioId then
						AudioMgr.instance:trigger(audioId)
					end
				end
			end
		end

		TaskDispatcher.runDelay(self.removeFinish, self, PLAYER_DELETE_ANIM_TIME)

		return true
	end

	return false
end

function Va3ChessStepDeleteObject:removeFinish()
	local objId = self.originData.id

	Va3ChessGameModel.instance:removeObjectById(objId)
	Va3ChessGameController.instance:deleteInteractObj(objId)

	if self.originData and self.originData.refreshAllKillEff then
		Va3ChessGameController.instance:refreshAllInteractKillEff()
	end

	self:finish()
end

function Va3ChessStepDeleteObject:dispose()
	Va3ChessStepDeleteObject.super.dispose(self)
	TaskDispatcher.cancelTask(self.removeFinish, self)
end

return Va3ChessStepDeleteObject
