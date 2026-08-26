-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/event/Va3ChessStateNormal.lua

module("modules.logic.versionactivity1_3.va3chess.game.event.Va3ChessStateNormal", package.seeall)

local Va3ChessStateNormal = class("Va3ChessStateNormal", Va3ChessStateBase)

function Va3ChessStateNormal:start()
	logNormal("Va3ChessStateNormal start")
	Va3ChessGameController.instance:resetObjStateOnNewRound()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EventStart, self:getStateType())
end

function Va3ChessStateNormal:onClickPos(x, y, manualClick)
	local len, result = Va3ChessGameController.instance:searchInteractByPos(x, y, Va3ChessGameController.filterSelectable)
	local clickStatus = Va3ChessGameController.instance:getClickStatus()

	if clickStatus == Va3ChessEnum.SelectPosStatus.None then
		self:onClickInNoneStatus(len, result, manualClick)
	elseif clickStatus == Va3ChessEnum.SelectPosStatus.SelectObjWaitPos then
		self:onClickInSelectObjWaitPosStatus(x, y, len, result, manualClick)
	end
end

function Va3ChessStateNormal:onClickInNoneStatus(clickObjLength, result, manualClick)
	if clickObjLength >= 1 then
		if clickObjLength > 1 then
			if not result[1] then
				local clickObj = result

				if clickObj.objType ~= Va3ChessEnum.InteractType.Player and clickObj.objType ~= Va3ChessEnum.InteractType.AssistPlayer then
					GameFacade.showToast(ToastEnum.ChessCanNotSelect)
				else
					Va3ChessGameController.instance:setSelectObj(clickObj)

					self._lastSelectObj = Va3ChessGameController.instance:getSelectObj()
				end
			end
		end
	end
end

function Va3ChessStateNormal:onClickInSelectObjWaitPosStatus(x, y, len, result, manualClick)
	local obj = Va3ChessGameController.instance:getSelectObj()

	self._lastSelectObj = obj

	if obj and obj:getHandler() then
		local rs = obj:getHandler():onSelectPos(x, y)

		if rs then
			self:onClickPos(x, y, manualClick)
		end
	else
		logError("select obj missing!")
	end
end

return Va3ChessStateNormal
