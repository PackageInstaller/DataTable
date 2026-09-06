-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/ChallengePassView.lua

module("logic.extensions.common.view.ChallengePassView", package.seeall)

local ChallengePassView = class("ChallengePassView", ViewComponent)

function ChallengePassView:unbindEvents()
	ChallengePassView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btn)
end

function ChallengePassView:bindEvents()
	ChallengePassView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btn, self._onClickBtn, self)
end

function ChallengePassView:buildUI()
	ChallengePassView.super.buildUI(self)

	self._btn = self:getBtn("btn")
end

function ChallengePassView:onExit()
	ChallengePassView.super.onExit(self)
end

function ChallengePassView:onEnter()
	ChallengePassView.super.onEnter(self)

	self._changeSetId = self:getFirstParam()
end

function ChallengePassView:_onClickBtn()
	if self._changeSetId then
		MaterialController.instance:showChangeSetInTemp(self._changeSetId)
	end

	self:close()
end

return ChallengePassView
