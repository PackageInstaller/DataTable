-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starscratch/view/StarScratchTaskView.lua

module("logic.extensions.starscratch.view.StarScratchTaskView", package.seeall)

local StarScratchTaskView = class("StarScratchTaskView", EventTaskTabFrameView)

function StarScratchTaskView:ctor()
	StarScratchTaskView.super.ctor(self)
end

function StarScratchTaskView:unbindEvents()
	StarScratchTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose, self.close, self)
end

function StarScratchTaskView:bindEvents()
	StarScratchTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function StarScratchTaskView:buildUI()
	StarScratchTaskView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._con = self:getGo("con")
	self._txtTime = self:getTxt("time/txt")
end

function StarScratchTaskView:onExit()
	StarScratchTaskView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._roleObj)
end

function StarScratchTaskView:onEnter()
	StarScratchTaskView.super.onEnter(self)

	local actCfg = StarScratchConfig.instance:getActivityCfg(self._activityId)

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, 11019, self._con)
	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.StarScratch, self._activityId)
end

return StarScratchTaskView
