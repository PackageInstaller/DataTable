-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventMainView.lua

module("logic.extensions.jieshenevent.view.JieShenEventMainView", package.seeall)

local JieShenEventMainView = class("JieShenEventMainView", ViewComponent)
local INFORMER_TYPE_NORMAL = 1

function JieShenEventMainView:ctor()
	JieShenEventMainView.super.ctor(self)
end

function JieShenEventMainView:unbindEvents()
	JieShenEventMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTimeline)
	GameUtil.rmClickHandler(self._btnClue)
	GameUtil.rmClickHandler(self._btnRelationship)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
end

function JieShenEventMainView:bindEvents()
	JieShenEventMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTimeline, self._onClickTimeline, self)
	GameUtil.addClickHandler(self._btnClue, self._onClickClue, self)
	GameUtil.addClickHandler(self._btnRelationship, self._onClickRelationship, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
end

function JieShenEventMainView:buildUI()
	JieShenEventMainView.super.buildUI(self)

	self._mapInfo = self:getGo("mapInfo")
	self._btnTimeline = self:getGo("btnTimeline")
	self._redPointTimeline = self:getGo("btnTimeline/redPoint")
	self._btnClue = self:getGo("btnClue")
	self._redPointClue = self:getGo("btnClue/redPoint")
	self._btnRelationship = self:getGo("btnRelationship")
	self._redPointRelationship = self:getGo("btnRelationship/redPoint")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("btnRule")
	self._placeCellList = {}

	for i = 1, self._mapInfo.transform.childCount do
		local cellGo = goutil.findChild(self._mapInfo, "placeCell_" .. i)

		if cellGo then
			self._placeCellList[i] = cellGo

			GameUtil.SetActive(cellGo, false)
		else
			break
		end
	end

	self._placeView = self:getGo("mapInfo/placeView")
	self._placeViewContainer = self:getGo("mapInfo/placeViewContainer")
	self._placeObjsInView = {}
	self._placePool = {}
	self._informeCellList = {}

	for i = 1, self._mapInfo.transform.childCount do
		local cellGo = goutil.findChild(self._mapInfo, "informerCell_" .. i)

		if cellGo then
			self._informeCellList[i] = cellGo

			GameUtil.SetActive(cellGo, false)
		else
			break
		end
	end

	self._informerView = self:getGo("mapInfo/informerView")
	self._informerViewContainer = self:getGo("mapInfo/informerViewContainer")
	self._recordPosInformer = self._informerView:GetComponent(ComponentType.TestRecordPos)
	self._informerObjsInView = {}
	self._informerPool = {}
	self._petCon = self:getGo("petCon")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtViewTime = self:getTxt("viewTime/txtViewTime")
	self._bubbleItems = self:getGo("bubbleItems")
	self._bubbleItemList = {}

	for i = 1, self._bubbleItems.transform.childCount do
		local bubble = {}

		bubble.go = goutil.findChild(self._bubbleItems, "bubble_" .. i)
		bubble.con = goutil.findChild(bubble.go, "con")
		self._bubbleItemList[i] = bubble
	end
end

function JieShenEventMainView:destroyUI()
	JieShenEventMainView.super.destroyUI(self)

	for i, v in ipairs(self._informerPool) do
		self:_clearInformerCell(v)
	end

	for i, v in ipairs(self._placePool) do
		self:_clearPlaceCell(v)
	end

	table.clear(self._informerPool)
	table.clear(self._placePool)
end

function JieShenEventMainView:onExit()
	JieShenEventMainView.super.onExit(self)

	for i, v in ipairs(self._informerPool) do
		goutil.addChildToParent(v, self._informerViewContainer)
		GameUtil.SetActive(v, false)
	end

	for i, v in ipairs(self._placePool) do
		goutil.addChildToParent(v, self._placeViewContainer)
		GameUtil.SetActive(v, false)
	end

	table.clear(self._informerObjsInView)
	table.clear(self._placeObjsInView)
	RoleObjectPool.instance:removeRole(self._roleObj)
	RedPointController.instance:unregRedPoint(self._redPointRelationship)
end

function JieShenEventMainView:onEnter()
	JieShenEventMainView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self.addGEvent(self, GlobalNotify.PM_JieShenEventGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_JieShenEventFinishGameRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_JieShenEvnetGainCluePrizeRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_JieShenEvnetGainTimelinePrizeRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.EndStory, self._onClickRule, self)

	self._activityId = self._activityId or JieShenEventModel.instance:getCurrActId()
	self._activityCfg = JieShenEventConfig.instance:getActivityCfg(self._activityId)
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._activityCfg.raceId, self._petCon)
	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.JieShenEvent, self._activityId)

	self:_initPlace()
	JieShenEventAgent.instance:sendPM_JieShenEventGetInfoReq(self._activityId)

	if not JieShenEventModel.instance:getIsShowEnterStory(self._activityId) then
		JieShenEventModel.instance:saveIsShowEnterStory(self._activityId)
		GlobalDispatcher:dispatch(GlobalNotify.StartStory, self._activityCfg.storyId)
	end

	RedPointController.instance:regRedPoint(self._redPointRelationship, RedPointModel.ID_ROLE_RELATIONSHIP_PRIZE)
end

function JieShenEventMainView:_refreshView()
	local tabCfgs = JieShenEventConfig.instance:getClueTabCfgs(self._activityId)

	GameUtil.SetActive(self._redPointClue, false)

	for i, v in ipairs(tabCfgs) do
		if not JieShenEventModel.instance:isGainClueTab(self._activityId, v.tabId) and JieShenEventController.instance:isTabCollectClueComplete(self._activityId, v.tabId) == true then
			GameUtil.SetActive(self._redPointClue, true)

			break
		end
	end

	local timeList = JieShenEventModel.instance:getTimelineSaveList(self._activityId)

	GameUtil.SetActive(self._redPointTimeline, #timeList > 0)

	local viewTime = JieShenEventModel.instance:getTodayViewTimes(self._activityId)

	self._txtViewTime.text = langPara("剩余访问次数:%d/%d", self._activityCfg.dailyViewTimes - viewTime, self._activityCfg.dailyViewTimes)

	self:_refreshInformer()
end

function JieShenEventMainView:_refreshInformer()
	for i, v in ipairs(self._informerObjsInView) do
		goutil.addChildToParent(v, self._informerViewContainer)
		GameUtil.rmClickHandler(v)
		GameUtil.SetActive(v, false)
	end

	table.clear(self._informerObjsInView)

	local list = JieShenEventModel.instance:getShowInfomerIds(self._activityId)

	for i, v in ipairs(list) do
		local informerCfg = JieShenEventConfig.instance:getInformerCfg(self._activityId, v)
		local type = informerCfg.type
		local go = goutil.findChild(self._informerViewContainer, "informerCell_" .. type)

		if not go then
			go = goutil.cloneAndSetParent(self._informeCellList[type], self._informerView.transform, "informerCell_" .. type)

			table.insert(self._informerPool, go)
		else
			goutil.addChildToParent(go, self._informerView)
		end

		GameUtil.SetActive(go, true)
		table.insert(self._informerObjsInView, go)
		self:_updateInformerCell(go, informerCfg, i)
	end

	self._recordPosInformer:LoadPlan(0)
end

function JieShenEventMainView:_initPlace()
	for i, v in ipairs(self._placeObjsInView) do
		goutil.addChildToParent(v, self._placeViewContainer)
		GameUtil.SetActive(v, false)
	end

	table.clear(self._placeObjsInView)

	local list = JieShenEventConfig.instance:getPlaceCfgs(self._activityId)

	for i, v in ipairs(list) do
		local type = v.type
		local go = goutil.findChild(self._placeViewContainer, "placeCell_" .. type)

		if not go then
			go = goutil.cloneAndSetParent(self._placeCellList[type], self._placeView.transform, "placeCell_" .. type)

			table.insert(self._placePool, go)
		else
			goutil.addChildToParent(go, self._placeView)
		end

		GameUtil.SetActive(go, true)
		table.insert(self._placeObjsInView, go)
		self:_updatePlaceCell(go, v, i)
	end
end

function JieShenEventMainView:_updateInformerCell(cell, data, index)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
	MaterialMgr.setIcon(con, MatType.PET_SKIN, data.raceId)
	GameUtil.rmClickHandler(cell)
	GameUtil.addClickHandler(cell, function()
		self:_onClickInformer(data.informerId)
	end, self)
end

function JieShenEventMainView:_clearInformerCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(cell)
	goutil.destroy(cell)
end

function JieShenEventMainView:_updatePlaceCell(cell, data, index)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txt")

	txtName.text = langPara(data.name)

	GameUtil.setAnchoredPos(go, data.pos[1], data.pos[2])
	GameUtil.rmClickHandler(cell)
	GameUtil.addClickHandler(cell, function()
		self:_onClickPlace(data.placeId)
	end, self)
end

function JieShenEventMainView:_clearPlaceCell(cell)
	GameUtil.rmClickHandler(cell)
	goutil.destroy(cell)
end

function JieShenEventMainView:_onClickTimeline()
	UIStateManager.instance:push(ViewName.JieShenEventTimelineView, self._activityId)
end

function JieShenEventMainView:_onClickClue()
	UIStateManager.instance:push(ViewName.JieShenEventClueView, self._activityId)
end

function JieShenEventMainView:_onClickRelationship()
	UIStateManager.instance:push(ViewName.JieShenEventRelationshipView, self._activityCfg.relationshipActId)
end

function JieShenEventMainView:_onClickPlace(placeId)
	UIStateManager.instance:push(ViewName.JieShenEventPlaceView, self._activityId, placeId)
end

function JieShenEventMainView:_onClickInformer(informerId)
	local viewTime = JieShenEventModel.instance:getTodayViewTimes(self._activityId)

	if viewTime >= self._activityCfg.dailyViewTimes then
		FloatWordMgr.instance:show(lang("已达次数限制"))

		return
	end

	local cfg = JieShenEventConfig.instance:getInformerCfg(self._activityId, informerId)

	if cfg.type == INFORMER_TYPE_NORMAL then
		self:_openNormalInformerView(informerId)
	else
		self:_openImportantInformerView(informerId)
	end
end

function JieShenEventMainView:_openNormalInformerView(informerId)
	local informerCfg = JieShenEventConfig.instance:getInformerCfg(self._activityId, informerId)
	local clueId = checknumber(informerCfg.param)

	UIStateManager.instance:push(ViewName.JieShenEventClueTipsView, self._activityId, clueId)
	JieShenEventAgent.instance:sendPM_JieShenEventFinishGameReq(self._activityId, informerId)
end

function JieShenEventMainView:_openImportantInformerView(informerId)
	UIStateManager.instance:push(ViewName.JieShenEventGameView, self._activityId, informerId)
end

function JieShenEventMainView:_onClickRule()
	TipsFacade.instance:openRulesView("jie_shen_event_rule")
end

return JieShenEventMainView
