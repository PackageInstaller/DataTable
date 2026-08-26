-- chunkname: @modules/logic/activity/controller/chessmap/event/ActivityChessStateNormal.lua

module("modules.logic.activity.controller.chessmap.event.ActivityChessStateNormal", package.seeall)

local ActivityChessStateNormal = class("ActivityChessStateNormal", ActivityChessStateBase)

function ActivityChessStateNormal:start()
	logNormal("ActivityChessStateNormal start")
end

function ActivityChessStateNormal:onClickPos(x, y, manualClick)
	local len, result = ActivityChessGameController.instance:searchInteractByPos(x, y, ActivityChessGameController.filterSelectable)
	local clickStatus = ActivityChessGameController.instance:getClickStatus()

	if clickStatus == ActivityChessEnum.SelectPosStatus.None then
		self:onClickInNoneStatus(len, result, manualClick)
	elseif clickStatus == ActivityChessEnum.SelectPosStatus.SelectObjWaitPos then
		self:onClickInSelectObjWaitPosStatus(x, y, len, result, manualClick)
	end
end

function ActivityChessStateNormal:onClickInNoneStatus(clickObjLength, result, manualClick)
	if clickObjLength >= 1 then
		if clickObjLength > 1 then
			if not result[1] then
				local clickObj = result

				if clickObj.objType ~= ActivityChessEnum.InteractType.Player then
					GameFacade.showToast(ToastEnum.ChessCanNotSelect)
				else
					if self._lastSelectObj ~= clickObj and manualClick then
						if clickObj.config.avatar == ActivityChessEnum.RoleAvatar.Apple then
							AudioMgr.instance:trigger(AudioEnum.ChessGame.SelectApple)
						elseif clickObj.config.avatar == ActivityChessEnum.RoleAvatar.PKLS then
							AudioMgr.instance:trigger(AudioEnum.ChessGame.SelectPKLS)
						elseif clickObj.config.avatar == ActivityChessEnum.RoleAvatar.WJYS then
							AudioMgr.instance:trigger(AudioEnum.ChessGame.SelectWJYS)
						end
					end

					ActivityChessGameController.instance:setSelectObj(clickObj)

					self._lastSelectObj = ActivityChessGameController.instance:getSelectObj()
				end
			end
		end
	end
end

function ActivityChessStateNormal:onClickInSelectObjWaitPosStatus(x, y, len, result, manualClick)
	local obj = ActivityChessGameController.instance:getSelectObj()

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

return ActivityChessStateNormal
