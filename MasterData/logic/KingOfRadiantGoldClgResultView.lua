-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingofradiantgoldclg/view/KingOfRadiantGoldClgResultView.lua

module("logic.extensions.kingofradiantgoldclg.view.KingOfRadiantGoldClgResultView", package.seeall)

local KingOfRadiantGoldClgResultView = class("KingOfRadiantGoldClgResultView", ViewComponent)

function KingOfRadiantGoldClgResultView:ctor()
	KingOfRadiantGoldClgResultView.super.ctor(self)
end

function KingOfRadiantGoldClgResultView:buildUI()
	KingOfRadiantGoldClgResultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._emptyMax = self:getGo("emptyMax")
	self._emptyCur = self:getGo("emptyCur")
	self._txtCur = self:getTxt("txtCur")
	self._txtMax = self:getTxt("txtMax")
	self._failTitle = self:getGo("failTitle")
	self._successTitle = self:getGo("successTitle")
end

function KingOfRadiantGoldClgResultView:bindEvents()
	KingOfRadiantGoldClgResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnClose, self)
end

function KingOfRadiantGoldClgResultView:unbindEvents()
	KingOfRadiantGoldClgResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function KingOfRadiantGoldClgResultView:onEnter()
	KingOfRadiantGoldClgResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._clgMo = KingOfRadiantGoldClgController.instance:getClgMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_NotifyKingOfRadiantGoldClgFinishRes, self._onUpdate, self)
	self:_onUpdate()
end

function KingOfRadiantGoldClgResultView:onExit()
	KingOfRadiantGoldClgResultView.super.onExit(self)
end

function KingOfRadiantGoldClgResultView:_onUpdate()
	local msg = self._clgMo:getFinishMsg()
	local activityId, challengeId, stageId = msg.activityId, msg.challengeId, msg.stageId

	if msg:HasField("number") then
		if not msg.number then
			local number = 0

			if msg:HasField("curScore") then
				if not msg.curScore then
					if msg:HasField("bestScore") then
						if not msg.bestScore then
							local stageData = KingOfRadiantGoldClgConfig.instance:getStageData(activityId, challengeId, stageId)
							local scoreData = KingOfRadiantGoldClgConfig.instance:getScoreDataByNum(activityId, challengeId, stageId, number)

							if scoreData then
								if not scoreData.score then
									local score = 0

									self._txtMax.text = string.format("符文数量：%s", msg.bestScore)
									self._txtCur.text = string.format("%s：%s；符文数：%s", stageData.desc, number, score)

									GameUtil.SetActive(self._successTitle, msg.isWin)
									GameUtil.SetActive(self._failTitle, not msg.isWin)
								end
							end
						end
					end
				end
			end
		end
	end
end

function KingOfRadiantGoldClgResultView:_onClickBtnClose()
	self:close()
	BattleController.instance:endBattle()
end

return KingOfRadiantGoldClgResultView
