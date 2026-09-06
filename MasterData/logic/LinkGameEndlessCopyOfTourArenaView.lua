-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/copy/link/LinkGameEndlessCopyOfTourArenaView.lua

module("logic.extensions.tourarena.view.copy.link.LinkGameEndlessCopyOfTourArenaView", package.seeall)

local LinkGameEndlessCopyOfTourArenaView = class("LinkGameEndlessCopyOfTourArenaView", LinkGameEndlessView)

function LinkGameEndlessCopyOfTourArenaView:_onClickClose()
	self:_pauseGame(self._gameTime)
	TipsFacade.instance:openPopupWindow(lang("提示"), lang("退出将立即结算并扣除游戏次数，是否退出？"), function()
		self:_recoverGame()
		self:_endGame()
	end, function()
		self:_recoverGame()
	end)
end

function LinkGameEndlessCopyOfTourArenaView:_doFinfishCallBack(isPass, removePairs)
	local info = {}

	info.isPass = true
	info.gameScore = removePairs

	GameUtil.callBack(self._finishCallBack, info)
end

return LinkGameEndlessCopyOfTourArenaView
