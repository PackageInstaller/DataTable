-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/projectash/view/ProjectAshRankView.lua

module("logic.extensions.projectash.view.ProjectAshRankView", package.seeall)

local ProjectAshRankView = class("ProjectAshRankView", ViewComponent)

function ProjectAshRankView:ctor()
	ProjectAshRankView.super.ctor(self)
end

function ProjectAshRankView:buildUI()
	ProjectAshRankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtMyRank = self:getTxt("container/myRank/txtMyRank")
	self._txtMyScore = self:getTxt("container/myRank/txtMyScore")
	self._myRewardCell = self:getGo("container/myRank/myRewardList/item")
	self._myRewardTableview = self:getGo("container/myRank/myRewardList")
	self._myRewardScrollList = ScrollerList.create(self._myRewardTableview, self._myRewardCell, GameUtil.handler(self._updateMyRewardCell, self), GameUtil.handler(self._clearMyRewardCell, self))
	self._rankCell = self:getGo("container/cell")
	self._rankTableview = self:getGo("container/tableview")
	self._rankScrollList = ScrollerList.create(self._rankTableview, self._rankCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._emptyGo = self:getGo("container/empty")
end

function ProjectAshRankView:bindEvents()
	ProjectAshRankView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function ProjectAshRankView:unbindEvents()
	ProjectAshRankView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ProjectAshRankView:onEnter()
	ProjectAshRankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.ProjectAshStage2GetRankInfoRes, self._onRankInfoRes, self)

	self._activityId = self:getFirstParam()

	ProjectAshAgent.instance:sendPM_ProjectAshStage2GetRankInfoReq(self._activityId)

	self._txtMyRank.text = "未上榜"
	self._txtMyScore.text = 0

	goutil.setActive(self._emptyGo, false)
end

function ProjectAshRankView:onExit()
	ProjectAshRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ProjectAshStage2GetRankInfoRes, self._onRankInfoRes, self)
	self._myRewardScrollList:dispose()
	self._rankScrollList:dispose()
end

function ProjectAshRankView:_onRankInfoRes()
	self:_initMyRank()
	self:_initAllRanks()
end

function ProjectAshRankView:_initAllRanks()
	local list = ProjectAshModel.instance:getRankInfos()

	self._rankScrollList:reloadData(list)
	goutil.setActive(self._emptyGo, #list == 0)
end

function ProjectAshRankView:_initMyRank()
	local myRank = ProjectAshModel.instance:getMyRank()

	self._txtMyRank.text = myRank > 0 and myRank or "未上榜"
	self._txtMyScore.text = ProjectAshModel.instance:getMyScore()

	local list = ProjectAshController.instance:getMyRewardStrList(myRank, self._activityId)

	self._myRewardScrollList:reloadData(list)
end

function ProjectAshRankView:_updateMyRewardCell(view, cell, data, tag)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.setCellByCfg(data, node)
end

function ProjectAshRankView:_clearMyRewardCell(cell)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.resetAll()
end

function ProjectAshRankView:_updateRankCell(view, cell, data, tag)
	local cls = GameUtil.AddLuaOnce(cell.gameObject, ProjectAshRankItem)

	cls:init(data, self._activityId)
end

function ProjectAshRankView:_clearRankCell(cell)
	local cls = GameUtil.AddLuaOnce(cell.gameObject, ProjectAshRankItem)

	cls:reset()
end

return ProjectAshRankView
