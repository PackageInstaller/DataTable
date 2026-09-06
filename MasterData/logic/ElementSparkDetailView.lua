-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkDetailView.lua

module("logic.extensions.elementspark.view.ElementSparkDetailView", package.seeall)

local ElementSparkDetailView = class("ElementSparkDetailView", ViewComponent)

function ElementSparkDetailView:ctor()
	ElementSparkDetailView.super.ctor(self)
end

function ElementSparkDetailView:unbindEvents()
	ElementSparkDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnWrite)
	GameUtil.rmClickHandler(self._btnPower)
	GameUtil.rmClickHandler(self._btnOrder)
	GameUtil.rmClickHandler(self._btnChunkDetail)

	for i, v in ipairs(self._commandList) do
		GameUtil.rmClickHandler(v.btnLeader)
	end
end

function ElementSparkDetailView:bindEvents()
	ElementSparkDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnWrite, self._onClickWrite, self)
	GameUtil.addClickHandler(self._btnPower, self._onClickPower, self)
	GameUtil.addClickHandler(self._btnOrder, self._onClickOrder, self)
	GameUtil.addClickHandler(self._btnChunkDetail, self._onClickChunkDetail, self)

	for i, v in ipairs(self._commandList) do
		GameUtil.addClickHandler(v.btnLeader, GameUtil.handler(self._onClickCommand, self, i))
	end
end

function ElementSparkDetailView:buildUI()
	ElementSparkDetailView.super.buildUI(self)

	self._btnWrite = self:getBtn("detail/announcement/btnWrite")
	self._txtCamp = self:getTxt("detail/txtCamp")
	self._txtCount = self:getTxt("detail/txtCount")
	self._txtAnnouncement = self:getTxt("detail/announcement/txtAnnouncement")
	self._commandList = {}

	for i = 1, 3 do
		local leader = {}

		leader.btnLeader = self:getBtn("detail/leader/btnLeader_" .. i)
		leader.txtName = self:getTxt("detail/leader/btnLeader_" .. i .. "/txtName")
		leader.infoCon = self:getGo("detail/leader/btnLeader_" .. i .. "/infoCon")
		leader.headCon = self:getGo("detail/leader/btnLeader_" .. i .. "/head")

		table.insert(self._commandList, leader)
	end

	self._txtCampScore = self:getTxt("campInfo/txtCampScore")
	self._txtPersonScore = self:getTxt("campInfo/txtPersonScore")
	self._txtCampRate = self:getTxt("campInfo/txtCampRate")
	self._txtPersonRate = self:getTxt("campInfo/txtPersonRate")
	self._txtTotalChunk = self:getTxt("campInfo/chunkDetail/txtTotal")
	self._btnChunkDetail = self:getBtn("campInfo/chunkDetail/txtTotal/btnDetail")
	self._txtChunkList = {}

	for i = 1, 5 do
		local txt = self:getTxt("campInfo/chunkDetail/txtChunk_" .. i)

		table.insert(self._txtChunkList, txt)
	end

	self._btnPower = self:getBtn("orderInfo/btnPower")
	self._btnOrder = self:getBtn("orderInfo/btnOrder")
	self._txtMinPower = self:getTxt("orderInfo/txtMinPower")
	self._tableViewGo = self:getGo("orderInfo/tableview")
	self._cell = self:getGo("orderInfo/cell")
	self._empty = self:getGo("orderInfo/empty")
	self._tableView = ScrollerList.create(self._tableViewGo, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ElementSparkDetailView:onExit()
	ElementSparkDetailView.super.onExit(self)
	self._tableView:dispose()

	for k, v in pairs(self._commandList) do
		HeadItemController.instance:resetHeadCell(v.headCon)
	end
end

function ElementSparkDetailView:onEnter()
	ElementSparkDetailView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.EleSparkGetCampInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.EleSparkModifyBoardRes, self._refreshBoard, self)
	self.addGEvent(self, GlobalNotify.EleSparkPublishCommandRes, self._refreshOrder, self)
	self.addGEvent(self, GlobalNotify.EleSparkModifyMinDefenseFormZdlRes, self._refreshPower, self)

	self._activityId = ElementSparkController.instance:getActivityId()
	self._isCommander = ElementSparkController.instance:isCommander()
	self._modifyBoardCdEndTime = 0
	self._addCommandCdEndTime = 0
	self._modifyMinZdlCdEndTime = 0

	self:_sendInfoReq()
end

function ElementSparkDetailView:_sendInfoReq()
	ElementSparkController.instance:sendPM_EleSparkGetCampInfoReq(self._activityId)
end

function ElementSparkDetailView:_refresh()
	self._campInfo = ElementSparkModel.instance:getCampInfo()
	self._modifyBoardCdEndTime = checknumber(self._campInfo.modifyBoardCdEndMillis)
	self._addCommandCdEndTime = checknumber(self._campInfo.addCommandCdEndMillis)
	self._modifyMinZdlCdEndTime = checknumber(self._campInfo.modifyMinZdlCdEndMillis)

	self:_refreshDetail()
	self:_refreshBoard(self._modifyBoardCdEndTime)
	self:_refreshCamp()
	self:_refreshOrder()
	self:_refreshPower(self._modifyMinZdlCdEndTime)
end

function ElementSparkDetailView:_refreshDetail()
	local commandInfo = ElementSparkModel.instance:getCommanderInfo()
	local userId = RoleModel.instance:getUserId()

	for i, v in ipairs(self._commandList) do
		goutil.setActive(v.btnLeader.gameObject, commandInfo[i])

		if commandInfo[i] then
			v.txtName.text = ""

			HeadItemController.instance:setHeadCellByInfo(v.headCon, commandInfo[i], true)

			v.txtName.text = commandInfo[i].userId == userId and string.format("<color=#20b376>%s</color>", commandInfo[i].userName) or commandInfo[i].userName
		end
	end

	self._txtCamp.text = "-" .. ElementSparkController.instance:getMyCampName() .. "-"
	self._txtCount.text = string.format("当前阵营成员：<color=#FCDB96FF>%d人</color>", self._campInfo.campPlayerCount or 0)
end

function ElementSparkDetailView:_refreshBoard(endTime)
	self._modifyBoardCdEndTime = checknumber(endTime)
	self._txtAnnouncement.text = ElementSparkModel.instance:getBoardInfo()
end

function ElementSparkDetailView:_refreshCamp()
	if not self._campInfo.campScore then
		if not self._campInfo.personScore then
			local personScore = 0

			self._txtCampScore.text = string.format("阵营积分：<color=#FCDB96FF>%d</color>", self._campInfo.campScore)
			self._txtPersonScore.text = string.format("个人积分：<color=#FCDB96FF>%d</color>", personScore)
			self._txtCampRate.text = string.format("阵营积分：<color=#FCDB96FF>%d/分钟</color>", self._campInfo.autoCampScoreRate or 0)
			self._txtPersonRate.text = string.format("个人积分：<color=#FCDB96FF>%d/分钟</color>", self._campInfo.autoPersonScoreRate or 0)

			local chunkInfoDesc = ElementSparkController.instance:getBelongMeChunkDesc()
			local contentArr = string.split(chunkInfoDesc, "：")
			local detailArr = string.split(contentArr[2], ",")

			self._txtTotalChunk.text = contentArr[1]

			for i, txt in ipairs(self._txtChunkList) do
				txt.text = detailArr[i]
			end
		end
	end
end

function ElementSparkDetailView:_refreshOrder()
	local commands = ElementSparkModel.instance:getCommands()

	if TableUtil.isTableEmpty(commands) then
		GameUtil.SetActive(self._empty, true)
		GameUtil.SetActive(self._tableviewGo, false)
	else
		GameUtil.SetActive(self._empty, false)
		GameUtil.SetActive(self._tableviewGo, true)

		local commandCd = ElementSparkConfig.instance:getCommonCfgByKey("ADD_COMMAND_CD_SEC", true)

		self._addCommandCdEndTime = checknumber(commands[1].commandTimeMillis / 1000) + commandCd

		self._tableView:reloadData(commands)
	end
end

function ElementSparkDetailView:_updateCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")
	local txtCommand = goutil.findChildTextComponent(cell, "txtCommand")

	txtName.text = checknumber(data.areaId) .. "-" .. data.commanderName

	local timeDate = GameUtil.time2date(data.commandTimeMillis / 1000)

	txtTime.text = string.format("%04d.%02d.%02d %02d点", timeDate.year, timeDate.month, timeDate.day, timeDate.hour)
	txtCommand.text = data.command
end

function ElementSparkDetailView:_clearCell(cell)
	return
end

function ElementSparkDetailView:_refreshPower(endTime)
	self._modifyMinZdlCdEndTime = checknumber(endTime)
	self._txtMinPower.text = ElementSparkModel.instance:getPowerValue()
end

function ElementSparkDetailView:_onClickCommand(i)
	local userId = self._campInfo.commanderHeadInfos[i].userId

	FriendController.instance:showInfoView(userId, self._commandList[i].infoCon)
end

function ElementSparkDetailView:_onClickChunkDetail()
	UIStateManager.instance:push(ViewName.ElementSparkOccupiedEffectView)
end

function ElementSparkDetailView:_onClickWrite()
	if ElementSparkController.instance:checkResultTime() then
		return
	end

	if self._modifyBoardCdEndTime > ServerTime.nowMs() then
		local cutDown = self._modifyBoardCdEndTime - ServerTime.nowMs()

		if cutDown > 0 then
			local desc = string.format("信息发送过于频繁，请在%d秒后再试", math.ceil(cutDown / 1000))

			FloatWordMgr.instance:show(desc)

			return
		end
	end

	if self._isCommander then
		UIStateManager.instance:push(ViewName.ElementSparkEditView, 1)
	else
		FloatWordMgr.instance:show("仅指挥官可编辑公告哦")
	end
end

function ElementSparkDetailView:_onClickPower()
	if ElementSparkController.instance:checkResultTime() then
		return
	end

	if self._modifyMinZdlCdEndTime > ServerTime.nowMs() then
		local cutDown = self._modifyMinZdlCdEndTime - ServerTime.nowMs()

		if cutDown > 0 then
			local desc = string.format("信息发送过于频繁，请在%d秒后再试", math.ceil(cutDown / 1000))

			FloatWordMgr.instance:show(desc)

			return
		end
	end

	if self._isCommander then
		UIStateManager.instance:push(ViewName.ElementSparkPowerView)
	else
		FloatWordMgr.instance:show("仅指挥官可设置战力哦")
	end
end

function ElementSparkDetailView:_onClickOrder()
	if ElementSparkController.instance:checkResultTime() then
		return
	end

	if self._addCommandCdEndTime > ServerTime.now() then
		local cutDown = self._addCommandCdEndTime - ServerTime.now()

		if cutDown > 0 then
			local desc = string.format("信息发送过于频繁，请在%d秒后再试", math.ceil(cutDown))

			FloatWordMgr.instance:show(desc)

			return
		end
	end

	if self._isCommander then
		UIStateManager.instance:push(ViewName.ElementSparkEditView, 2)
	else
		FloatWordMgr.instance:show("仅指挥官可发布指令哦")
	end
end

return ElementSparkDetailView
