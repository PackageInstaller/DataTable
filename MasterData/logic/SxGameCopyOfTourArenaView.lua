-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/copy/sxgame/SxGameCopyOfTourArenaView.lua

module("logic.extensions.tourarena.view.copy.sxgame.SxGameCopyOfTourArenaView", package.seeall)

local SxGameCopyOfTourArenaView = class("SxGameCopyOfTourArenaView", SxGameView)

function SxGameCopyOfTourArenaView:onEnter()
	SxGameCopyOfTourArenaView.super.onEnter(self)
	GameUtil.SetActive(self.txtNumGo, false)
	GameUtil.SetActive(self._btnHelp, false)
	GameUtil.SetActive(self._tips, false)
	GameUtil.SetActive(self.con, false)
end

function SxGameCopyOfTourArenaView:_popSxGameResult()
	local isGameEnd = SxGameModel.instance:getCurStep() == 0
	local info = {}

	info.isPass = true
	info.gameScore = self:_calcScore()

	if isGameEnd then
		GameUtil.callBack(self._finishCallBack, info)
		self:close()
	else
		local tipsContent = "退出将立即结算并扣除游戏次数，是否退出？"

		local function okFunc()
			GameUtil.callBack(self._finishCallBack, info)
			self:close()
		end

		local function cencelFunc()
			return
		end

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确认退出", "继续游戏")
	end
end

return SxGameCopyOfTourArenaView
