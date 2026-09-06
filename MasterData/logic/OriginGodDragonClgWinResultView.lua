-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/view/OriginGodDragonClgWinResultView.lua

module("logic.extensions.origingoddragonclg.view.OriginGodDragonClgWinResultView", package.seeall)

local OriginGodDragonClgWinResultView = class("OriginGodDragonClgWinResultView", ViewComponent)

function OriginGodDragonClgWinResultView:buildUI()
	OriginGodDragonClgWinResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._txtCurCircle = self:getTxt("txtCurCircle")
	self._txtLeftCircle = self:getTxt("txtLeftCircle")
end

function OriginGodDragonClgWinResultView:bindEvents()
	OriginGodDragonClgWinResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function OriginGodDragonClgWinResultView:unbindEvents()
	OriginGodDragonClgWinResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function OriginGodDragonClgWinResultView:onEnter()
	OriginGodDragonClgWinResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._subMo = OriginGodDragonClgController.instance:getSubMo(self._activityId)

	local fightMsg = self._subMo:getFightResultMsg()

	if fightMsg then
		if not fightMsg.zoneId then
			local zoneId = 0

			if fightMsg then
				if not fightMsg.circleNum then
					local circleNum = 0
					local leftCircleNum = self._subMo:getLeftCircleNum(zoneId)

					leftCircleNum = Mathf.Max(0, leftCircleNum - circleNum)
					self._txtCurCircle.text = string.format("%d回合", circleNum)
					self._txtLeftCircle.text = string.format("%d回合", leftCircleNum)
				end
			end
		end
	end
end

function OriginGodDragonClgWinResultView:onExit()
	OriginGodDragonClgWinResultView.super.onExit(self)
end

function OriginGodDragonClgWinResultView:_onClickBtnSure()
	self:close()
	BattleController.instance:endBattle()
end

return OriginGodDragonClgWinResultView
