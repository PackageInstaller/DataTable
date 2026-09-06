-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownEliminateVoteRecordView.lua

module("logic.extensions.showdown.view.ShowDownEliminateVoteRecordView", package.seeall)

local ShowDownEliminateVoteRecordView = class("ShowDownEliminateVoteRecordView", ViewComponent)

function ShowDownEliminateVoteRecordView:ctor()
	ShowDownEliminateVoteRecordView.super.ctor(self)
end

function ShowDownEliminateVoteRecordView:unbindEvents()
	ShowDownEliminateVoteRecordView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ShowDownEliminateVoteRecordView:bindEvents()
	ShowDownEliminateVoteRecordView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function ShowDownEliminateVoteRecordView:buildUI()
	ShowDownEliminateVoteRecordView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._empty = self:getGo("colRecord/goEmpty")

	local cellGoRecord = self:getGo("colRecord/cell")
	local tableviewGoRecord = self:getGo("colRecord/tableview")

	self._tableviewRecord = ScrollerList.create(tableviewGoRecord, cellGoRecord, GameUtil.handler(self._updateCellRecord, self), GameUtil.handler(self._clearCellRecord, self))

	local cellGoTab = self:getGo("colTab/cell")
	local tableviewGoTab = self:getGo("colTab/tableview")

	self._tableviewTab = ScrollerList.create(tableviewGoTab, cellGoTab, GameUtil.handler(self._updateCellTab, self), GameUtil.handler(self._clearCellTab, self))
end

function ShowDownEliminateVoteRecordView:onExit()
	ShowDownEliminateVoteRecordView.super.onExit(self)

	self._curSelectId = nil

	self._tableviewRecord:dispose()
	self._tableviewTab:dispose()
end

function ShowDownEliminateVoteRecordView:onEnter()
	ShowDownEliminateVoteRecordView.super.onEnter(self)

	self._activityId = checkint(self:getFirstParam())

	ShowDownController.instance:sendPM_ShowDown_GetGuessRecordReq(self._activityId)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetGuessRecordRes, self._refreshRecordTableview, self)
	self:_onClickTab(1)
end

function ShowDownEliminateVoteRecordView:_updateCellRecord(view, cellGo, data)
	local cell = self:_clearCellRecord(cellGo)

	HeadItemController.instance:setHeadCellByInfo(cell.headIcon, data.teamInfo.leaderHeadInfo)

	cell.txtName.text = data.teamInfo.teamInfo.teamName

	local iconData = ShowDownConfig.instance:getTeamIconData(self._activityId, data.teamInfo.teamInfo.teamLogo)
	local path = GameUrl.getItemIconUrl(iconData.iconPath)

	if not GameUtil.isEmptyString(path) then
		uGuiUtil.setSpriteToImage(cell.emblem, uGuiUtil.SpriteType.BigBg, path)
	end

	local result = data.result
	local isUnknow = not result

	cell.txtGuessNum.text = data.guessValue

	if isUnknow then
		goutil.setActive(cell.stateUnknow, true)
		goutil.setActive(cell.stateWin, false)
		goutil.setActive(cell.stateLose, false)
		goutil.setActive(cell.txtGuessNum.gameObject, false)
		goutil.setActive(cell.voteTip, true)

		cell.txtVoteNum.text = data.guessValue
	else
		goutil.setActive(cell.stateUnknow, false)
		goutil.setActive(cell.txtGuessNum.gameObject, true)
		goutil.setActive(cell.voteTip, false)

		result = checknumber(result)

		if result > 0 then
			cell.txtVoteNum.text = "+" .. result or result
		end

		local rank = self._guessShowHash[data]

		if rank then
			goutil.setActive(cell.guessRankList[rank], true)

			cell.txtStateLose.text = "未晋级三强"

			if result > 0 then
				goutil.setActive(cell.stateWin, true)
				goutil.setActive(cell.stateLose, false)

				local actData = ShowDownConfig.instance:getActData(self._activityId)

				cell.txtStateWin.text = result + checknumber(data.guessValue) == actData.finalMatchGuessFloorNum and "未猜中名次" or "胜出"
			elseif result == -checknumber(data.guessValue) then
				goutil.setActive(cell.stateWin, false)
				goutil.setActive(cell.stateLose, true)
			else
				goutil.setActive(cell.stateWin, true)
				goutil.setActive(cell.stateLose, false)

				cell.txtStateWin.text = "未猜中名次"
			end
		else
			cell.txtStateLose.text = "已淘汰"
			cell.txtStateWin.text = "胜出"

			goutil.setActive(cell.stateWin, result > 0)
			goutil.setActive(cell.stateLose, result < 0)
		end
	end
end

function ShowDownEliminateVoteRecordView:_clearCellRecord(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.headIcon = goutil.findChild(cell.go, "teamHeadIcon/icon")

	HeadItemController.instance:resetHeadCell(cell.headIcon)

	cell.emblem = goutil.findChild(cell.go, "teamHeadIcon/emblem")

	uGuiUtil.clearImage(cell.emblem)

	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.stateUnknow = goutil.findChild(cell.go, "state/unknow")
	cell.stateWin = goutil.findChild(cell.go, "state/win")
	cell.txtStateWin = goutil.findChildTextComponent(cell.go, "state/win")
	cell.stateLose = goutil.findChild(cell.go, "state/lose")
	cell.txtStateLose = goutil.findChildTextComponent(cell.go, "state/lose")
	cell.txtVoteNum = goutil.findChildTextComponent(cell.go, "txtVoteNum")
	cell.txtGuessNum = goutil.findChildTextComponent(cell.go, "txtGuessNum")
	cell.voteTip = goutil.findChild(cell.go, "txtVoteTip")
	cell.guessRankCom = goutil.findChild(cell.go, "guess")
	cell.guessRankList = {}

	for i = 1, 3 do
		cell.guessRankList[i] = goutil.findChild(cell.guessRankCom, "rank_" .. i)

		goutil.setActive(cell.guessRankList[i], false)
	end

	return cell
end

function ShowDownEliminateVoteRecordView:_updateCellTab(view, cellGo, data)
	local cell = self:_clearCellTab(cellGo)

	cell.txtName.text = data.tabShowTxt

	cell.uiChangeGroup:SetState(data.tabId == self._curSelectId and 1 or 0)
	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickTab, self, data.tabId))
end

function ShowDownEliminateVoteRecordView:_clearCellTab(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.uiChangeGroup = cell.go:GetComponent("UIChangeGroup")

	return cell
end

function ShowDownEliminateVoteRecordView:_refreshRecordTableview()
	local dataList = self:_getCurRecordDataList()

	goutil.setActive(self._empty, #dataList <= 0)
	self._tableviewRecord:reloadData(dataList)
end

function ShowDownEliminateVoteRecordView:_onClickTab(tabId)
	if self._curSelectId ~= tabId then
		self._curSelectId = tabId

		self._tableviewTab:reloadData(self:_getCurTabDataList())
		self:_refreshRecordTableview()
	end
end

function ShowDownEliminateVoteRecordView:_getCurTabDataList()
	self._tabDataList = self._tabDataList or {
		{
			tabShowTxt = "组队应援",
			tabId = 1
		},
		{
			tabShowTxt = "512进64",
			tabId = 2
		},
		{
			tabShowTxt = "64进8",
			tabId = 3
		},
		{
			tabShowTxt = "决赛",
			tabId = 4
		}
	}

	return self._tabDataList
end

function ShowDownEliminateVoteRecordView:_getCurRecordDataList()
	self._guessShowHash = {}

	local mo = ShowDownController.instance:getShowDownMo(self._activityId)
	local temInfos = mo and mo:getGuessInfos()
	local infoHash = mo and mo:getFinalRoundGuessInfoHash() or {}
	local infos = temInfos or {}
	local datalist = {}

	for _, info in ipairs(infos) do
		if self._curSelectId == 1 and info.roundId == ShowDownEnum.Round_Eliminate_Group then
			table.insert(datalist, info)
		elseif self._curSelectId == 2 and info.roundId == ShowDownEnum.Round_Eliminate_512To64 then
			table.insert(datalist, info)
		elseif self._curSelectId == 3 and info.roundId == ShowDownEnum.Round_Eliminate_64To8 then
			table.insert(datalist, info)
		elseif self._curSelectId == 4 and info.roundId >= ShowDownEnum.Round_Final_01 and info.roundId <= ShowDownEnum.Round_Final_07 then
			for rank, guessInfo in pairs(infoHash) do
				if guessInfo and guessInfo.simpleMo:getTeamId() == info.teamInfo.teamInfo.teamId then
					self._guessShowHash[info] = rank
				end
			end

			table.insert(datalist, info)
		end
	end

	return datalist
end

return ShowDownEliminateVoteRecordView
