-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergartenJobTendencyView.lua

module("logic.extensions.kindergarten.view.KindergartenJobTendencyView", package.seeall)

local KindergartenJobTendencyView = class("KindergartenJobTendencyView", ViewComponent)

function KindergartenJobTendencyView:buildUI()
	KindergartenJobTendencyView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self._jobTypeName = {
		KindergartenConfig.instance:getCommonValue("JOB_NAME1"),
		KindergartenConfig.instance:getCommonValue("JOB_NAME2"),
		KindergartenConfig.instance:getCommonValue("JOB_NAME3"),
		KindergartenConfig.instance:getCommonValue("JOB_NAME4"),
		(KindergartenConfig.instance:getCommonValue("JOB_NAME5"))
	}
end

function KindergartenJobTendencyView:bindEvents()
	KindergartenJobTendencyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function KindergartenJobTendencyView:unbindEvents()
	KindergartenJobTendencyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function KindergartenJobTendencyView:onEnter()
	KindergartenJobTendencyView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.KindergartenGetJobInfoRes, self._onGetJobInfoRes, self)

	self._activityId = self:getFirstParam()

	KindergartenAgent.instance:sendPM_KindergartenGetJobInfoReq(self._activityId)
	self:_initJobInfo()
end

function KindergartenJobTendencyView:onExit()
	KindergartenJobTendencyView.super.onExit(self)
	self._scrollList:dispose()
end

function KindergartenJobTendencyView:_onGetJobInfoRes()
	self:_updateJobInfoList()
end

function KindergartenJobTendencyView:_updateCell(view, cell, data, tag)
	local cls = GameUtil.AddLuaOnce(cell.gameObject, KJobTendencyCell)

	cls:init(self._activityId, data)
end

function KindergartenJobTendencyView:clearCell(cell)
	local cls = GameUtil.AddLuaOnce(cell.gameObject, KJobTendencyCell)

	cls:reset()
end

function KindergartenJobTendencyView:_initJobInfo()
	self._moduleInfoList = {}

	for i = 1, #self._jobTypeName do
		self._moduleInfoList[i] = {}
		self._moduleInfoList[i].name = self._jobTypeName[i]
		self._moduleInfoList[i].jobList = {}
		self._moduleInfoList[i].totalNums = 0
	end
end

function KindergartenJobTendencyView:_updateJobInfoList()
	local jobCfgs = KindergartenConfig.instance:getJobCfgs(self._activityId)

	for i, cfgJob in ipairs(jobCfgs) do
		local index = self:_getIndexByJobMode(cfgJob.jobMode)

		table.insert(self._moduleInfoList[index].jobList, {
			count = 0,
			jobId = cfgJob.jobId
		})
	end

	local jobResultList = KindergartenModel.instance:getJobResultList()

	for i, jobInfo in ipairs(jobResultList) do
		local cfgJob = KindergartenConfig.instance:getJobCfg(self._activityId, jobInfo.jobId)
		local index = self:_getIndexByJobMode(cfgJob.jobMode)

		for j, emptyjobInfo in ipairs(self._moduleInfoList[index].jobList) do
			if emptyjobInfo.jobId == jobInfo.jobId then
				emptyjobInfo.count = jobInfo.count
			end
		end

		self._moduleInfoList[index].totalNums = self._moduleInfoList[index].totalNums + jobInfo.count
	end

	self._scrollList:reloadData(self._moduleInfoList)
end

function KindergartenJobTendencyView:_getIndexByJobMode(name)
	return table.indexof(self._jobTypeName, name)
end

return KindergartenJobTendencyView
