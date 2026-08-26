-- chunkname: @modules/logic/activity/controller/chessmap/interacts/ActivityChessInteractPlayer.lua

module("modules.logic.activity.controller.chessmap.interacts.ActivityChessInteractPlayer", package.seeall)

local ActivityChessInteractPlayer = class("ActivityChessInteractPlayer", ActivityChessInteractBase)

function ActivityChessInteractPlayer:onSelectCall()
	ActivityChessGameController.instance:setClickStatus(ActivityChessEnum.SelectPosStatus.SelectObjWaitPos)

	local x, y = self._target.originData.posX, self._target.originData.posY
	local evtObj = {
		visible = true,
		posXList = {},
		posYList = {},
		selfPosX = x,
		selfPosY = y,
		selectType = ActivityChessEnum.ChessSelectType.Normal
	}

	ActivityChessInteractPlayer.insertPosToList(x + 1, y, evtObj.posXList, evtObj.posYList)
	ActivityChessInteractPlayer.insertPosToList(x - 1, y, evtObj.posXList, evtObj.posYList)
	ActivityChessInteractPlayer.insertPosToList(x, y + 1, evtObj.posXList, evtObj.posYList)
	ActivityChessInteractPlayer.insertPosToList(x, y - 1, evtObj.posXList, evtObj.posYList)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, evtObj)

	self._isPlayerSelected = true

	self:refreshPlayerSelected()
end

function ActivityChessInteractPlayer.insertPosToList(x, y, posXList, posYList)
	if ActivityChessGameController.instance:posCanWalk(x, y) then
		table.insert(posXList, x)
		table.insert(posYList, y)
	end
end

function ActivityChessInteractPlayer:onCancelSelect()
	ActivityChessGameController.instance:setClickStatus(ActivityChessEnum.SelectPosStatus.None)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})

	self._isPlayerSelected = false

	self:refreshPlayerSelected()
end

function ActivityChessInteractPlayer:onSelectPos(x, y)
	local curX, curY = self._target.originData.posX, self._target.originData.posY
	local canWalk = ActivityChessGameModel.instance:getBaseTile(x, y)

	if (curX == x and math.abs(curY - y) == 1 or curY == y and math.abs(curX - x) == 1) and ActivityChessGameController.instance:posCanWalk(x, y) then
		local optData = {
			id = self._target.originData.id,
			dir = ActivityChessMapUtils.ToDirection(curX, curY, x, y)
		}

		ActivityChessGameModel.instance:appendOpt(optData)

		local actId = ActivityChessGameModel.instance:getActId()
		local optList = ActivityChessGameModel.instance:getOptList()

		Activity109Rpc.instance:sendAct109BeginRoundRequest(actId, optList, self.onMoveSuccess, self)
		ActivityChessGameController.instance:saveTempSelectObj()
		ActivityChessGameController.instance:setSelectObj(nil)

		local evtMgr = ActivityChessGameController.instance.event

		if evtMgr then
			evtMgr:setLockEvent()
		end
	else
		local len, result = ActivityChessGameController.instance:searchInteractByPos(x, y)

		if len > 1 then
			if not result[1] then
				local clickObj = result

				if clickObj then
					if clickObj.config and clickObj.config.interactType ~= ActivityChessEnum.InteractType.Player then
						-- block empty
					else
						ActivityChessGameController.instance:setSelectObj(nil)

						return true
					end
				else
					GameFacade.showToast(ToastEnum.ChessCanNotMoveHere)
				end
			end
		end
	end
end

function ActivityChessInteractPlayer:onMoveSuccess(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function ActivityChessInteractPlayer:moveTo(x, y, callback, callbackObj)
	ActivityChessInteractPlayer.super.moveTo(self, x, y, callback, callbackObj)

	if self._animSelf then
		self._animSelf:Play("jump", 0, 0)
	end
end

function ActivityChessInteractPlayer:refreshPlayerSelected()
	return
end

function ActivityChessInteractPlayer:onAvatarLoaded()
	ActivityChessInteractPlayer.super.onAvatarLoaded(self)

	local loader = self._target.avatar.loader

	if not loader then
		return
	end

	local go = loader:getInstGO()

	if not gohelper.isNil(go) then
		self._animSelf = go:GetComponent(typeof(UnityEngine.Animator))
	end

	self._target.avatar.goSelected = gohelper.findChild(loader:getInstGO(), "piecea/vx_select")

	gohelper.setActive(self._target.avatar.goSelected, true)
	self:refreshPlayerSelected()
end

return ActivityChessInteractPlayer
