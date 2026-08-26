-- chunkname: @modules/logic/chessgame/game/event/ChessStateNormal.lua

module("modules.logic.chessgame.game.event.ChessStateNormal", package.seeall)

local ChessStateNormal = class("ChessStateNormal", ChessStateBase)

function ChessStateNormal:start()
	logNormal("ChessStateNormal start")
	ChessGameController.instance:dispatchEvent(ChessGameEvent.EventStart, self:getStateType())
end

function ChessStateNormal:onClickPos(x, y, manualClick)
	local len, result = ChessGameController.instance:searchInteractByPos(x, y, ChessGameController.filterSelectable)
	local clickStatus = ChessGameController.instance:getClickStatus()

	if clickStatus == ChessGameEnum.SelectPosStatus.None then
		self:onClickInNoneStatus(len, result, manualClick)
	elseif clickStatus == ChessGameEnum.SelectPosStatus.SelectObjWaitPos then
		self:onClickInSelectObjWaitPosStatus(x, y, len, result, manualClick)
	elseif clickStatus == ChessGameEnum.SelectPosStatus.CatchObj then
		self:onClickCatchObjWaitPosStatus(x, y, len, result, manualClick)
	elseif clickStatus == ChessGameEnum.SelectPosStatus.ShowTalk then
		self:onClickShowTalkWaitPosStatus()
	end
end

function ChessStateNormal:onClickInNoneStatus(clickObjLength, result, manualClick)
	if clickObjLength >= 1 then
		if clickObjLength > 1 then
			if not result[1] then
				local clickObj = result

				if clickObj.objType ~= ChessGameEnum.InteractType.Role then
					GameFacade.showToast(ToastEnum.ChessCanNotSelect)
				else
					ChessGameController.instance:setSelectObj(clickObj)

					self._lastSelectObj = ChessGameController.instance:getSelectObj()
				end
			end
		end
	end
end

function ChessStateNormal:onClickInSelectObjWaitPosStatus(x, y, len, result, manualClick)
	local obj = ChessGameController.instance:getSelectObj()

	self._lastSelectObj = obj

	if obj and obj:getHandler() then
		local rs = obj:getHandler():onSelectPos(x, y)

		if rs then
			if ChessGameController.instance.eventMgr:isPlayingFlow() then
				return
			end

			self:onClickPos(x, y, manualClick)
		end
	else
		logError("select obj missing!")
	end
end

function ChessStateNormal:onClickCatchObjWaitPosStatus(x, y, len, result, manualClick)
	local obj = ChessGameController.instance:getSelectObj()

	self._lastSelectObj = obj

	if obj and obj:getHandler() then
		local rs = obj:getHandler():onSetPosWithCatchObj(x, y)

		if rs then
			self:onClickPos(x, y, manualClick)
		end
	else
		logError("select obj missing!")
	end
end

function ChessStateNormal:onClickShowTalkWaitPosStatus()
	ChessGameController.instance:dispatchEvent(ChessGameEvent.ClickOnTalking)
end

return ChessStateNormal
