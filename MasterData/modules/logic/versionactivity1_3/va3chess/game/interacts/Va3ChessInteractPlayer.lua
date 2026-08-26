-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/interacts/Va3ChessInteractPlayer.lua

module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractPlayer", package.seeall)

local Va3ChessInteractPlayer = class("Va3ChessInteractPlayer", Va3ChessInteractBase)

function Va3ChessInteractPlayer:onSelected()
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

	self._isPlayerSelected = true

	self:refreshPlayerSelected()
end

function Va3ChessInteractPlayer:insertPosToList(x, y, posXList, posYList)
	local curX, curY = self._target.originData.posX, self._target.originData.posY
	local dir = Va3ChessMapUtils.ToDirection(curX, curY, x, y)

	if Va3ChessGameController.instance:posCanWalk(x, y, dir, self._target.objType) then
		table.insert(posXList, x)
		table.insert(posYList, y)
	end
end

function Va3ChessInteractPlayer:onCancelSelect()
	Va3ChessGameController.instance:setClickStatus(Va3ChessEnum.SelectPosStatus.None)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})

	self._isPlayerSelected = false

	self:refreshPlayerSelected()
end

function Va3ChessInteractPlayer:onSelectPos(x, y)
	local curX, curY = self._target.originData.posX, self._target.originData.posY
	local canWalk = Va3ChessGameModel.instance:getBaseTile(x, y)
	local dir = Va3ChessMapUtils.ToDirection(curX, curY, x, y)

	if (curX == x and math.abs(curY - y) == 1 or curY == y and math.abs(curX - x) == 1) and Va3ChessGameController.instance:posCanWalk(x, y, dir, self._target.objType) then
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
	else
		local len, result = Va3ChessGameController.instance:searchInteractByPos(x, y)

		if len > 1 then
			if not result[1] then
				local clickObj = result

				if clickObj then
					if clickObj.config and clickObj.config.interactType ~= Va3ChessEnum.InteractType.Player and clickObj.config.interactType ~= Va3ChessEnum.InteractType.AssistPlayer then
						-- block empty
					else
						Va3ChessGameController.instance:setSelectObj(nil)

						return true
					end

					GameFacade.showToast(ToastEnum.ChessCanNotMoveHere)
				else
					GameFacade.showToast(ToastEnum.ChessCanNotMoveHere)
				end
			end
		end
	end
end

function Va3ChessInteractPlayer:onMoveSuccess(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function Va3ChessInteractPlayer:moveTo(x, y, callback, callbackObj)
	Va3ChessInteractPlayer.super.moveTo(self, x, y, callback, callbackObj)

	if self._animSelf then
		self._animSelf:Play("jump", 0, 0)
	end
end

function Va3ChessInteractPlayer:showHitAni()
	if self._animSelf then
		self._animSelf:Play("hit", 0, 0)
	end
end

function Va3ChessInteractPlayer:refreshPlayerSelected()
	return
end

function Va3ChessInteractPlayer:onAvatarLoaded()
	Va3ChessInteractPlayer.super.onAvatarLoaded(self)

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

return Va3ChessInteractPlayer
