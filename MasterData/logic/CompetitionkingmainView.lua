-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/competitionking/view/CompetitionkingmainView.lua

module("logic.extensions.competitionking.view.CompetitionkingmainView", package.seeall)

local CompetitionkingmainView = class("CompetitionkingmainView", TabFrameWorkMainView)

function CompetitionkingmainView:ctor()
	CompetitionkingmainView.super.ctor(self)
end

function CompetitionkingmainView:unbindEvents()
	CompetitionkingmainView.super.unbindEvents(self)
end

function CompetitionkingmainView:bindEvents()
	CompetitionkingmainView.super.bindEvents(self)
end

function CompetitionkingmainView:buildUI()
	CompetitionkingmainView.super.buildUI(self)
end

function CompetitionkingmainView:onExit()
	CompetitionkingmainView.super.onExit(self)
end

function CompetitionkingmainView:onEnter()
	CompetitionkingmainView.super.onEnter(self)
end

function CompetitionkingmainView:_getFrameId()
	return 4
end

function CompetitionkingmainView:_updateHeadTabCell(mainGo, headTabIndex)
	CompetitionkingmainView.super._updateHeadTabCell(self, mainGo, headTabIndex)

	local info = self:_getHeadTabViewInfo(headTabIndex)
	local isUnlock = info.isUnlock
	local bubble = goutil.findChildTextComponent(mainGo, "bubble")
	local txtBubble = goutil.findChildTextComponent(mainGo, "bubble/txt")
	local recStr = info.data.exTabParams
	local isNeedRec = isUnlock and not string.nilorempty(recStr)

	GameUtil.SetActive(bubble.gameObject, isNeedRec)

	if isNeedRec then
		bubble.text = recStr
		txtBubble.text = recStr
	end
end

function CompetitionkingmainView:_updateSecTabCell(mainGo, headTabIndex, secTabIndex)
	CompetitionkingmainView.super._updateSecTabCell(self, mainGo, headTabIndex, secTabIndex)

	local info = self:_getSecTabViewInfo(headTabIndex, secTabIndex)
	local isUnlock = info.isUnlock
	local bubble = goutil.findChildTextComponent(mainGo, "bubble")
	local txtBubble = goutil.findChildTextComponent(mainGo, "bubble/txt")
	local recStr = info.data.exTabParams
	local isNeedRec = isUnlock and not string.nilorempty(recStr)

	GameUtil.SetActive(bubble.gameObject, isNeedRec)

	if isNeedRec then
		bubble.text = recStr
		txtBubble.text = recStr
	end
end

return CompetitionkingmainView
