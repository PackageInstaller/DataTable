-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/projectash/view/ProjectAshRewardView.lua

module("logic.extensions.projectash.view.ProjectAshRewardView", package.seeall)

local ProjectAshRewardView = class("ProjectAshRewardView", ViewComponent)

function ProjectAshRewardView:ctor()
	ProjectAshRewardView.super.ctor(self)
end

function ProjectAshRewardView:buildUI()
	ProjectAshRewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._rankCell = self:getGo("container/cell")
	self._rankTableview = self:getGo("container/tableview")
	self._rewardScrollList = ScrollerList.create(self._rankTableview, self._rankCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function ProjectAshRewardView:bindEvents()
	ProjectAshRewardView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function ProjectAshRewardView:unbindEvents()
	ProjectAshRewardView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ProjectAshRewardView:onEnter()
	ProjectAshRewardView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.ProjectAshGainPrizeRes, self._onProjectAshGainPrizeRes, self)

	self._activityId = self:getFirstParam()
	self._cfgActivity = ProjectAshConfig.instance:getActivityCfg(self._activityId)
	self._stage2DamagePrizePlanId = self._cfgActivity.stage2DamagePrizePlanId

	self:_updateCfgs()
end

function ProjectAshRewardView:onExit()
	ProjectAshRewardView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ProjectAshGainPrizeRes, self._onProjectAshGainPrizeRes, self)
	self._rewardScrollList:dispose()
end

function ProjectAshRewardView:_onProjectAshGainPrizeRes()
	self:_updateCfgs()
end

function ProjectAshRewardView:_updateRankCell(view, cell, data, tag)
	local cls = GameUtil.AddLuaOnce(cell.gameObject, ProjectAshRewardItem)

	cls:init(data, self._activityId)
end

function ProjectAshRewardView:_clearRankCell(cell)
	local cls = GameUtil.AddLuaOnce(cell.gameObject, ProjectAshRewardItem)

	cls:reset()
end

function ProjectAshRewardView:_updateCfgs()
	local cfgs = ProjectAshConfig.instance:getProgressPrizeCfgList(self._stage2DamagePrizePlanId)

	self._rewardScrollList:reloadData(cfgs)
end

return ProjectAshRewardView
