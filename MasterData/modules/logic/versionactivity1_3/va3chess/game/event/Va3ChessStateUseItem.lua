-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/event/Va3ChessStateUseItem.lua

module("modules.logic.versionactivity1_3.va3chess.game.event.Va3ChessStateUseItem", package.seeall)

local Va3ChessStateUseItem = class("Va3ChessStateUseItem", Va3ChessStateBase)

function Va3ChessStateUseItem:start()
	logNormal("Va3ChessStateUseItem start")
	self:startNotifyView()
end

function Va3ChessStateUseItem:startNotifyView()
	local interactId = self.originData.interactId
	local range = self.originData.range

	if not range or not interactId then
		logError("Va3ChessStateUseItem range = " .. tostring(range) .. ", interactId = " .. tostring(interactId))

		return
	end

	local interactMgr = Va3ChessGameController.instance.interacts

	if interactMgr then
		local interactObj = interactMgr:get(interactId)

		if interactObj then
			local go = interactObj:tryGetGameObject()

			if not gohelper.isNil(go) then
				local goVfx = gohelper.findChild(go, "vx_daoju")

				gohelper.setActive(goVfx, true)
			end

			if interactObj.goToObject then
				interactObj.goToObject:setMarkAttract(true)
			end
		end
	end

	AudioMgr.instance:trigger(AudioEnum.ChessGame.PickUpBottle)
	TaskDispatcher.runDelay(self.delayCallChoosePos, self, 1)
end

function Va3ChessStateUseItem:delayCallChoosePos()
	TaskDispatcher.cancelTask(self.delayCallChoosePos, self)

	local interactId = self.originData.interactId
	local range = self.originData.range
	local interactMgr = Va3ChessGameController.instance.interacts

	if interactMgr then
		local interactObj = interactMgr:get(interactId)

		if interactObj then
			local posX, posY = interactObj.originData.posX, interactObj.originData.posY

			self._centerX, self._centerY = posX, posY

			self:packEventObjs(posX, posY, range)
		end
	end
end

function Va3ChessStateUseItem:packEventObjs(posX, posY, range)
	local evtObj = {
		visible = true,
		posXList = {},
		posYList = {},
		selfPosX = posX,
		selfPosY = posY,
		selectType = Va3ChessEnum.ChessSelectType.UseItem
	}

	for x = posX - range, posX + range do
		for y = posY - range, posY + range do
			if self:checkCanThrow(posX, posY, x, y) then
				table.insert(evtObj.posXList, x)
				table.insert(evtObj.posYList, y)
			end
		end
	end

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetCenterHintText, {
		visible = true,
		text = luaLang("versionact_109_itemplace_hint")
	})
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, evtObj)
end

function Va3ChessStateUseItem:checkCanThrow(srcX, srcY, tarX, tarY)
	if srcX ~= tarX or srcY ~= tarY then
		return Va3ChessGameController.instance:posCanWalk(tarX, tarY)
	end

	return false
end

function Va3ChessStateUseItem:onClickPos(x, y, manualClick)
	if not self._centerX then
		logNormal("Va3ChessStateUseItem no interact pos found !")

		return
	end

	local range = self.originData.range
	local deltaX, deltaY = math.abs(x - self._centerX), math.abs(y - self._centerY)

	if self:checkCanThrow(self._centerX, self._centerY, x, y) and deltaX <= range and deltaY <= range then
		local actId = self.originData.activityId

		Va3ChessRpcController.instance:sendActUseItemRequest(actId, x, y, self.onReceiveReply, self)
	end
end

function Va3ChessStateUseItem:onReceiveReply(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetCenterHintText, {
		visible = false
	})
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EventFinishPlay, self)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.SetItem)
end

function Va3ChessStateUseItem:hideAttractEffect()
	local interactId = self.originData.interactId
	local interactMgr = Va3ChessGameController.instance.interacts
	local interactObj = interactMgr:get(interactId)

	if interactObj and interactObj.goToObject then
		interactObj.goToObject:setMarkAttract(false)
	end
end

function Va3ChessStateUseItem:dispose()
	self:hideAttractEffect()
	TaskDispatcher.cancelTask(self.delayCallChoosePos, self)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetCenterHintText, {
		visible = false
	})
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
	Va3ChessStateUseItem.super.dispose(self)
end

return Va3ChessStateUseItem
