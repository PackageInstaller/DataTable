-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionRoomFocusBlock.lua

module("modules.logic.guide.controller.action.impl.GuideActionRoomFocusBlock", package.seeall)

local GuideActionRoomFocusBlock = class("GuideActionRoomFocusBlock", BaseGuideAction)

function GuideActionRoomFocusBlock:onStart(context)
	GuideActionRoomFocusBlock.super.onStart(self, context)

	if self.actionParam then
		local posOffset = string.splitToNumber(self.actionParam, "#")

		if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
			local goPath = GuideModel.instance:getStepGOPath(self.guideId, self.stepId)
			local blockGO = gohelper.find(goPath)
			local entity = blockGO and MonoHelper.getLuaComFromGo(blockGO, RoomMapBlockEntity)

			entity = entity or blockGO and MonoHelper.getLuaComFromGo(blockGO, RoomEmptyBlockEntity)
			entity = entity or blockGO and MonoHelper.getLuaComFromGo(blockGO, RoomBuildingEntity)

			local mo = entity and entity:getMO()

			if mo then
				local pos = HexMath.hexToPosition(mo.hexPoint, RoomBlockEnum.BlockSize)
				local var_1_1 = {}

				var_1_1.focusX = pos.x + ((posOffset or nil) and (posOffset[1] or 0))
				var_1_1.focusY = pos.y + ((posOffset or nil) and (posOffset[2] or 0))

				local cameraParam = var_1_1

				GameSceneMgr.instance:getCurScene().camera:tweenCamera(cameraParam)
				TaskDispatcher.runDelay(self._onDone, self, 0.7)
			else
				self:onDone(true)
			end
		else
			logError("不在小屋场景，指引失败 " .. self.guideId .. "_" .. self.stepId)
			self:onDone(true)
		end
	end
end

function GuideActionRoomFocusBlock:_onDone(percent)
	self:onDone(true)
end

function GuideActionRoomFocusBlock:clearWork()
	TaskDispatcher.cancelTask(self._onDone, self)
end

return GuideActionRoomFocusBlock
