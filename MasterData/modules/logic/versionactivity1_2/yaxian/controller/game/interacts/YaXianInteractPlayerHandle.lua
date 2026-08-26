-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/interacts/YaXianInteractPlayerHandle.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.interacts.YaXianInteractPlayerHandle", package.seeall)

local YaXianInteractPlayerHandle = class("YaXianInteractPlayerHandle", YaXianInteractHandleBase)

function YaXianInteractPlayerHandle:onSelectCall()
	YaXianGameController.instance:dispatchEvent(YaXianEvent.ShowCanWalkGround, true)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshInteractStatus, true)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshAllInteractAlertArea, true)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshInteractPath, true)
end

function YaXianInteractPlayerHandle:onCancelSelect()
	YaXianGameController.instance:dispatchEvent(YaXianEvent.ShowCanWalkGround, false)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshInteractStatus, false)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshAllInteractAlertArea, false)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshInteractPath, false)
end

function YaXianInteractPlayerHandle:onSelectPos(x, y)
	for moveDirection, pos in pairs(YaXianGameModel.instance:getCanWalkTargetPosDict()) do
		if pos.x == x and pos.y == y then
			local optData = {
				id = self._interactObject.interactMo.id,
				dir = moveDirection
			}

			Activity115Rpc.instance:sendAct115BeginRoundRequest(YaXianGameEnum.ActivityId, {
				optData
			})
			YaXianGameController.instance:setSelectObj()

			return
		end
	end

	return true
end

return YaXianInteractPlayerHandle
