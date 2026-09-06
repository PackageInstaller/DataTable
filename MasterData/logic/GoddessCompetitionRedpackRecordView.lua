-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionRedpackRecordView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionRedpackRecordView", package.seeall)

local GoddessCompetitionRedpackRecordView = class("GoddessCompetitionRedpackRecordView", ViewComponent)

function GoddessCompetitionRedpackRecordView:ctor()
	GoddessCompetitionRedpackRecordView.super.ctor(self)
end

function GoddessCompetitionRedpackRecordView:unbindEvents()
	GoddessCompetitionRedpackRecordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._goldBarAdd)
end

function GoddessCompetitionRedpackRecordView:bindEvents()
	GoddessCompetitionRedpackRecordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._goldBarAdd, self._onClickAdd, self)
end

function GoddessCompetitionRedpackRecordView:buildUI()
	GoddessCompetitionRedpackRecordView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._goEmpty = self:getGo("emptyGo")
	self._goldBar = self:getGo("goldBar")

	local tableviewGo = self:getGo("tableview")
	local cellGo = self:getGo("tablecell")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._goldBarItem = self:getGo("goldBar/img")
	self._goldBarNum = self:getTxt("goldBar/txt")
	self._goldBarAdd = self:getGo("goldBar/add")
	self._txtTips = self:getTxt("txtTips")
end

function GoddessCompetitionRedpackRecordView:onExit()
	GoddessCompetitionRedpackRecordView.super.onExit(self)
	self._tableview:dispose()
	MaterialMgr.resetAll(self._goldBarItem)
end

function GoddessCompetitionRedpackRecordView:onEnter()
	GoddessCompetitionRedpackRecordView.super.onEnter(self)

	self._activityId = GoddessCompetitionModel.instance:getCurActId()
	self._subTabs = {}

	GoddessCompetitionController.instance:getRedPackRecord(self._activityId)
	self.addGEvent(self, GlobalNotify.GoddessCompetitionGetRedPackRecordRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._updateMatCount, self)
	self:_updateUIByCfg()
end

function GoddessCompetitionRedpackRecordView:_updateUIByCfg()
	self._actCfg = GoddessCompetitionConfig.instance:getActCfg(self._activityId)
	self._txtTips.text = string.format("仅展示最近%s条领取记录", self._actCfg.saveRecordCount)
	self._voteItem = self._actCfg.voteItem

	local matType, matId = MaterialMgr.getMatParams(self._voteItem)

	MaterialMgr.setIcon(self._goldBarItem, matType, matId)
	self:_updateMatCount()
end

function GoddessCompetitionRedpackRecordView:_updateMatCount()
	local matType, matId = MaterialMgr.getMatParams(self._voteItem)

	self._goldBarNum.text = MaterialModel.instance:getMaterialsNumber(matType, matId)
end

function GoddessCompetitionRedpackRecordView:_updateUIByInfo()
	local baseInfo = GoddessCompetitionModel.instance:getCurActBaseInfo()
	local curStepId = baseInfo.curStepId

	self._curGoddessInfoList = GoddessCompetitionModel.instance:getCurGoddessList(curStepId)

	local recordInfo = GoddessCompetitionModel.instance:getRpRecordInfo(self._activityId)

	if not recordInfo.recordList then
		local recordList = {}

		goutil.setActive(self._goEmpty, #recordList == 0)
		self._tableview:reloadData(recordList)
	end
end

function GoddessCompetitionRedpackRecordView:_updateCell(view, cell, data)
	local btnVote = goutil.findChild(cell.gameObject, "btnVote")
	local goHead = goutil.findChild(cell.gameObject, "headGo")
	local goVoteEnd = goutil.findChild(cell.gameObject, "voteEnd")
	local goKing = goutil.findChild(cell.gameObject, "kingGo")
	local txtTime = goutil.findChildTextComponent(cell.gameObject, "txtTime")
	local txtArea = goutil.findChildTextComponent(cell.gameObject, "arean/txtAera")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtGoddess = goutil.findChildTextComponent(cell.gameObject, "txtGoddess")
	local type1 = goutil.findChild(cell.gameObject, "type1")
	local goGet = goutil.findChild(cell.gameObject, "type1/goGet")
	local txtGet = goutil.findChildTextComponent(cell.gameObject, "type1/txtGet")
	local type2 = goutil.findChild(cell.gameObject, "type2")
	local subTab = self._subTabs[cell.gameObject]

	if not subTab then
		local item = goutil.findChild(cell.gameObject, "type2/item")
		local Scrollerview = goutil.findChild(cell.gameObject, "type2/Scrollerview")

		subTab = ScrollerList.create(Scrollerview, item, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		subTab:setCenterMode(true)

		self._subTabs[cell.gameObject] = subTab
	end

	txtArea.text = data.senderHeadInfo.areaName
	txtName.text = data.senderHeadInfo.userName

	HeadItemController.instance:setHeadCellByInfo(goHead, data.senderHeadInfo)

	local faceId = checknumber(data.goddessFaceId)

	txtGoddess.text = string.format("支持女神：\n%s", PetSkinConfig.instance:getPetSkinName(faceId))

	local time = GameUtil.time2date(checknumber(data.grabTime) / 1000)

	txtTime.text = langPara("text_timeinfo", time.month, time.day, time.hour, time.min, time.sec)

	GameUtil.SetActive(goKing, data.isBestLuck)
	GameUtil.addClickHandler(btnVote, GameUtil.handler(self._onClickVote, self, data))

	local isStepMatch = false

	for i, goddessInfo in ipairs(self._curGoddessInfoList) do
		if faceId == goddessInfo.faceId then
			isStepMatch = true

			break
		end
	end

	if GoddessCompetitionController.instance:isDisplayStep(self._activityId) then
		isStepMatch = false
	end

	GameUtil.SetActive(btnVote, isStepMatch)
	GameUtil.SetActive(goVoteEnd, not isStepMatch)

	local redPackDefineId = data.redPackDefineId
	local rpCfg = GoddessCompetitionConfig.instance:getRedPackCfg(self._activityId, redPackDefineId)

	GameUtil.SetActive(type1, false)
	GameUtil.SetActive(type2, false)

	local cfgParams = string.split(rpCfg.param, "&")
	local subParam = data.param

	if rpCfg.type == 1 then
		GameUtil.SetActive(type1, true)

		local matStr = cfgParams[1]
		local matType, matId = MaterialMgr.getMatParams(matStr)

		MaterialMgr.setIcon(goGet, matType, matId)

		txtGet.text = subParam
	elseif rpCfg.type == 2 then
		local prizeId = checknumber(subParam)
		local matStr = cfgParams[1]
		local planId = checknumber(cfgParams[2])
		local cfgs = GoddessCompetitionConfig.instance:getPoolCfgs(planId)
		local content = cfgs[prizeId].content
		local prizeList = string.split(content .. "#" .. matStr, "#")

		GameUtil.SetActive(type2, true)
		subTab:reloadData(prizeList)
	end
end

function GoddessCompetitionRedpackRecordView:_clearCell(cell)
	local btnVote = goutil.findChild(cell.gameObject, "btnVote")
	local goHead = goutil.findChild(cell.gameObject, "headGo")
	local goGet = goutil.findChild(cell.gameObject, "type1/goGet")

	HeadItemController.resetHeadCell(goHead)
	GameUtil.rmClickHandler(btnVote)

	local subTab = self._subTabs[cell.gameObject]

	if subTab then
		subTab:dispose()
	end

	MaterialMgr.resetAll(goGet)
end

function GoddessCompetitionRedpackRecordView:_onClickVote(data)
	local faceId = checknumber(data.goddessFaceId)
	local isStepMatch = false

	for i, goddessInfo in ipairs(self._curGoddessInfoList) do
		if faceId == goddessInfo.faceId then
			isStepMatch = true

			break
		end
	end

	if not isStepMatch then
		FloatWordMgr.instance:show("当前阶段不可对该女神投票")

		return
	end

	UIStateManager.instance:push(ViewName.GoddessCompetitionVoteView, faceId)
end

function GoddessCompetitionRedpackRecordView:_updateItemCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function GoddessCompetitionRedpackRecordView:_clearItemCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function GoddessCompetitionRedpackRecordView:_onClickAdd()
	self:close()
	MaterialMgr.openGetSourceByStr(self._voteItem)
end

return GoddessCompetitionRedpackRecordView
