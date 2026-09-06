-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupredpack/view/GroupRedpackRecordView.lua

module("logic.extensions.groupredpack.view.GroupRedpackRecordView", package.seeall)

local GroupRedpackRecordView = class("GroupRedpackRecordView", ViewComponent)

function GroupRedpackRecordView:ctor()
	GroupRedpackRecordView.super.ctor(self)
end

function GroupRedpackRecordView:unbindEvents()
	GroupRedpackRecordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._goldBarAdd)
end

function GroupRedpackRecordView:bindEvents()
	GroupRedpackRecordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._goldBarAdd, self._onClickAdd, self)
end

function GroupRedpackRecordView:buildUI()
	GroupRedpackRecordView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._goEmpty = self:getGo("emptyGo")
	self._goldBarItem = self:getGo("goldBar/img")
	self._goldBarNum = self:getTxt("goldBar/txt")
	self._goldBarAdd = self:getGo("goldBar/add")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function GroupRedpackRecordView:onExit()
	GroupRedpackRecordView.super.onExit(self)
	self._scrollList:dispose()
	MaterialMgr.resetAll(self._goldBarItem)
	GlobalDispatcher:removeListener(GlobalNotify.GroupRedPackGetRecordsRes, self._reloadData, self)
end

function GroupRedpackRecordView:onEnter()
	GroupRedpackRecordView.super.onEnter(self)

	self._activityId = GroupRedpackModel.instance:getActivityId()
	self._cfgs = GroupRedpackConfig.instance:getGroupRedpackCfgsByActId(self._activityId)

	self:_initView()
	GlobalDispatcher:addListener(GlobalNotify.GroupRedPackGetRecordsRes, self._reloadData, self)
	GroupRedpackController.instance:sendGroupRedPackGetRecordsReq(self._activityId)
end

function GroupRedpackRecordView:_initView()
	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.Goddess_Contest)

	if actCfg then
		self._goddessContestActId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end
end

function GroupRedpackRecordView:_reloadData()
	local directorVoteItemId = GoddessContestConfig.instance:getActCfgByActId(self._goddessContestActId).directorVoteItemId
	local type, id, num = MaterialMgr.getMatParams(directorVoteItemId)
	local haveNum = MaterialFacade.instance:getMatNumber(type, id)

	MaterialMgr.setCellByCfg(directorVoteItemId, self._goldBarItem)

	self._goldBarNum.text = haveNum

	local recordList = GroupRedpackModel.instance:getRecordList()

	self._scrollList:reloadData(recordList)
	GameUtil.SetActive(self._goEmpty, #recordList == 0)
end

function GroupRedpackRecordView:_updateCell(view, goCell, data, tag)
	local cell = self:_clearCell(goCell)
	local time = GameUtil.time2date(checknumber(data.timestamp) / 1000)
	local voteNum = data.otherMsg
	local canVote = GroupRedpackController.instance:getIsTime(self._goddessContestActId, "CAMPAIGN_VOTE_TIME") and not string.nilorempty(voteNum)

	HeadItemController.instance:setHeadCellByInfo(cell.goHead, data.headInfo)
	GameUtil.SetActive(cell.goKing, data.isBestLuck)
	GameUtil.SetActive(cell.goVoteEnd, not canVote)

	cell.txtTicket.text = not string.nilorempty(voteNum) and checknumber(voteNum) or "未参加竞选"
	cell.txtTime.text = langPara("text_timeinfo", time.month, time.day, time.hour, time.min, time.sec)
	cell.txtGet.text = data.amount
	cell.txtArea.text = string.format("%s", data.headInfo.areaName)
	cell.txtName.text = data.headInfo.userName

	local _, timePeriod = GroupRedpackController.instance:getIsTime(self._goddessContestActId, "CAMPAIGN_VOTE_TIME")

	GameUtil.SetActive(cell.goVoteEnd, timePeriod == GameUtil.afterTimePeriod)
	GameUtil.SetActive(cell.btnVote, canVote)
	GameUtil.addClickHandler(cell.btnVote, GameUtil.handler(self._onClickVote, self, data))
end

function GroupRedpackRecordView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.goHead = goutil.findChild(goCell, "headGo")
	cell.goKing = goutil.findChild(goCell, "kingGo")
	cell.goVoteEnd = goutil.findChild(goCell, "voteEnd")
	cell.txtTicket = goutil.findChildTextComponent(goCell, "txtTicket")
	cell.txtTime = goutil.findChildTextComponent(goCell, "txtTime")
	cell.txtGet = goutil.findChildTextComponent(goCell, "txtGet")
	cell.txtArea = goutil.findChildTextComponent(goCell, "arean/txtAera")
	cell.txtName = goutil.findChildTextComponent(goCell, "txtName")
	cell.btnVote = goutil.findChildButtonComponent(goCell, "btnVote")

	HeadItemController.resetHeadCell(cell.goHead)
	GameUtil.rmClickHandler(cell.btnVote)

	return cell
end

function GroupRedpackRecordView:_onClickClose()
	self:close()
end

function GroupRedpackRecordView:_onClickVote(data)
	if GroupRedpackController.instance:getIsTime(self._goddessContestActId, "CAMPAIGN_VOTE_TIME") then
		local directorVoteItemId = GoddessContestConfig.instance:getActCfgByActId(self._goddessContestActId).directorVoteItemId
		local costParms = string.splitToNumber(directorVoteItemId, ":")
		local costType = costParms[1]
		local costId = costParms[2]
		local costNum = 1
		local content = langPara("确定花费%s%s进行1次投票吗？", costNum, MaterialMgr.getMaterialsName(costType, costId))

		TipsFacade.instance:openPopupCostMatViewNew(costType, costId, costNum, content, function()
			FloatWordMgr.instance:show("投票成功")
			GoddessContestController.instance:voteToDirector(data.headInfo.userId, nil, self._goddessContestActId)
			GroupRedpackController.instance:sendGroupRedPackGetRecordsReq(self._activityId)
		end)
	else
		FloatWordMgr.instance:show("投票活动未开始或已结束")
	end
end

function GroupRedpackRecordView:_onClickAdd()
	local directorVoteItemId = GoddessContestConfig.instance:getActCfgByActId(self._goddessContestActId).directorVoteItemId

	MaterialMgr.openGetSourceByStr(directorVoteItemId)
end

return GroupRedpackRecordView
