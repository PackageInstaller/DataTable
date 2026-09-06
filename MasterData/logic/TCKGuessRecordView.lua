-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKGuessRecordView.lua

module("logic.extensions.teenchampionking.view.TCKGuessRecordView", package.seeall)

local TCKGuessRecordView = class("TCKGuessRecordView", ViewComponent)

function TCKGuessRecordView:ctor()
	TCKGuessRecordView.super.ctor(self)
end

function TCKGuessRecordView:unbindEvents()
	TCKGuessRecordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TCKGuessRecordView:bindEvents()
	TCKGuessRecordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TCKGuessRecordView:buildUI()
	TCKGuessRecordView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tabtableviewGo = self:getGo("tabtableview")
	self._tabtablecellGo = self:getGo("tabtablecell")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tabScrollerList = ScrollerList.create(self._tabtableviewGo, self._tabtablecellGo, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._emptyGo = self:getGo("empty")
	self._finals = self:getGo("finals")
	self._txtShowInfo = self:getTxt("finals/txtShowInfo")
	self._infoCellList = {}

	for i = 1, 8 do
		local cell = {}

		cell.go = self:getGo("finals/info/rank_" .. i)
		cell.playerinfo = goutil.findChild(cell.go, "playerinfo")
		cell.result = goutil.findChild(cell.go, "result")
		cell.match = goutil.findChild(cell.result, "match")
		cell.noMatch = goutil.findChild(cell.result, "noMatch")
		cell.txtRankReal = goutil.findChildTextComponent(cell.result, "txtRank")
		cell.empty = goutil.findChild(cell.go, "empty")
		cell.icon = goutil.findChild(cell.go, "playerinfo/icon")
		cell.txtName = goutil.findChildTextComponent(cell.go, "playerinfo/txtName")
		cell.empty = goutil.findChild(cell.go, "empty")
		cell.txtRank = goutil.findChildTextComponent(cell.go, "rank/txtRank")
		cell.info = nil

		table.insert(self._infoCellList, cell)
	end
end

function TCKGuessRecordView:onExit()
	TCKGuessRecordView.super.onExit(self)

	for i, cell in ipairs(self._infoCellList) do
		HeadItemController.instance:resetHeadCell(cell.icon)
	end
end

function TCKGuessRecordView:onEnter()
	TCKGuessRecordView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params and params[1]

	if self._activityId <= 0 then
		self._activityId = 501001
	end

	self.addGEvent(self, GlobalNotify.PM_TCKGetKnockoutGuessRecord, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_TCKGetChampionshipGuessRecord, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_TCKKnockoutSchedule, self._handleGetSchedule, self)

	local curRoundId = TeenChampionKingController.ROUND_KNOCKOUT_MIN
	local info = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)

	if info then
		curRoundId = TeenChampionKingConfig.instance:getRoundIdByStepId(self._activityId, info.curStepId)
	end

	self._inChampionRound = false

	if curRoundId >= TeenChampionKingController.ROUND_CHAMPIONSHIP_MIN and curRoundId <= TeenChampionKingController.ROUND_CHAMPIONSHIP_MAX then
		curRoundId = TeenChampionKingController.ROUND_CHAMPIONSHIP_MIN

		TeenChampionKingController.instance:getKnockoutSchedule(self._activityId, 1, TeenChampionKingController.ROUND_CHAMPIONSHIP_MIN)

		self._inChampionRound = true
	end

	self._curSelectTab = curRoundId

	self:_updateTab()
end

function TCKGuessRecordView:_updateUI()
	self:_updateTab()
end

function TCKGuessRecordView:_handleGetSchedule()
	self._playerInfoMap = {}

	local scheduleInfo = TeenChampionKingModel.instance:getKnockoutScheduleInfo(self._activityId, 1, TeenChampionKingController.ROUND_CHAMPIONSHIP_MIN)

	if scheduleInfo then
		if not scheduleInfo.groupList then
			for _, matchInfo in ipairs(scheduleInfo.groupList) do
				self._playerInfoMap[checknumber(matchInfo.playerA.headInfo.headInfo.userId)] = matchInfo.playerA.headInfo.headInfo
				self._playerInfoMap[checknumber(matchInfo.playerB.headInfo.headInfo.userId)] = matchInfo.playerB.headInfo.headInfo
			end
		end
	end

	self:_updateTab()
end

function TCKGuessRecordView:_getPlayerInfo(userId)
	local userId = checknumber(userId)

	if self._playerInfoMap and self._playerInfoMap[userId] then
		return self._playerInfoMap[userId]
	end
end

function TCKGuessRecordView:_updateTab()
	local roundCfgs = TeenChampionKingConfig.instance:getRoundCfgsByActId(self._activityId)
	local dataList = {}

	for i, v in ipairs(roundCfgs) do
		if v.gussPlanId > 0 then
			table.insert(dataList, v)
		end
	end

	local data = {}

	data.roundName = "决赛"
	data.roundId = TeenChampionKingController.ROUND_CHAMPIONSHIP_MIN

	table.insert(dataList, data)
	self._tabScrollerList:reloadData(dataList)

	local curData

	for _, data in ipairs(dataList) do
		if data.roundId == self._curSelectTab then
			curData = data

			break
		end
	end

	if curData then
		self:_onClickTabCell(curData.roundId)
	else
		self:_onClickTabCell(dataList[1].roundId)
	end
end

function TCKGuessRecordView:_updateCell(view, cell, data)
	local _Img_Tag = goutil.findChild(cell, "Img_Tag")
	local change_Tag = _Img_Tag:GetComponent("UIImageSpriteChange")
	local txt_Tag = goutil.findChild(cell, "txt_Tag")
	local _Left_Head = goutil.findChild(cell, "Head_Left/Img_Head")
	local _Right_Head = goutil.findChild(cell, "Head_Right/Img_Head")
	local _Right_Name = goutil.findChild(cell, "Head_Right/Txt_Name"):GetComponent("Text")
	local _Left_Name = goutil.findChild(cell, "Head_Left/Txt_Name"):GetComponent("Text")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local showValueGo = goutil.findChild(cell, "showValue")
	local txtSupport = goutil.findChildTextComponent(showValueGo, "txtSupport")
	local resultGo = goutil.findChild(showValueGo, "result")
	local resultChange = resultGo:GetComponent("UIImageSpriteChange")
	local txtResult = goutil.findChildTextComponent(resultGo, "txtValue")

	HeadItemController.instance:setHeadCellByInfo(_Right_Head, data.playerB)
	HeadItemController.instance:setHeadCellByInfo(_Left_Head, data.playerA)

	_Right_Name.text = data.playerB.userName
	_Left_Name.text = data.playerA.userName
	txtSupport.text = string.format("应援:%s", data.guessNum)

	local isLeft = checknumber(data.targetPlayerId) == checknumber(data.playerA.userId)

	if isLeft then
		GameUtil.setAnchoredPos(showValueGo, 250, 20)
	else
		GameUtil.setAnchoredPos(showValueGo, 615, 20)
	end

	if data.result and data.result ~= 0 then
		txtScore.text = ""

		goutil.setActive(resultGo, true)

		if data.result > 0 then
			txtResult.text = string.format("+%s", data.result)

			resultChange:SetState(0)
		else
			txtResult.text = data.result

			resultChange:SetState(1)
		end

		goutil.setActive(_Img_Tag, true)

		local isWin = data.playerAWin

		change_Tag:SetState(isWin and 0 or 1)
		goutil.setActive(txt_Tag, false)
	else
		goutil.setActive(resultGo, false)
		goutil.setActive(_Img_Tag, false)
		goutil.setActive(txt_Tag, true)

		txtScore.text = ""
	end
end

function TCKGuessRecordView:_clearCell(cell)
	local _Left_Head = goutil.findChild(cell, "Head_Left/Img_Head")
	local _Right_Head = goutil.findChild(cell, "Head_Right/Img_Head")

	HeadItemController.instance:resetHeadCell(_Right_Head)
	HeadItemController.instance:resetHeadCell(_Left_Head)
end

function TCKGuessRecordView:_updateTabCell(view, cell, cfg, tag)
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txt")
	local change = cell.gameObject:GetComponent(ComponentType.UIChangeGroup)

	txtDesc.text = cfg.roundName

	change:SetState(self._curSelectTab == cfg.roundId and 0 or 1)
	btn:AddClickListener(function()
		self:_onClickTabCell(cfg.roundId)
	end)
end

function TCKGuessRecordView:_clearTabCell(cell)
	return
end

function TCKGuessRecordView:_onClickTabCell(roundId)
	self._curSelectTab = roundId

	if roundId >= TeenChampionKingController.ROUND_CHAMPIONSHIP_MIN and roundId <= TeenChampionKingController.ROUND_CHAMPIONSHIP_MAX then
		if self._inChampionRound then
			TeenChampionKingController.instance:getChampionshipGuessRecord(self._activityId)
		else
			self:_updateUIByInfo()
		end
	else
		TeenChampionKingController.instance:getKnockoutGuessRecord(self._activityId, roundId)
	end

	self._tabScrollerList:refresh()
end

function TCKGuessRecordView:_updateUIByInfo()
	goutil.setActive(self._tableviewGo, false)
	goutil.setActive(self._finals, false)
	goutil.setActive(self._emptyGo, false)

	self._guessPlayerIds = {}
	self._realRankPlayerIds = {}
	self._rankMapByPlayerId = {}
	self._matchCount = 0
	self._guessCount = 0
	self._result = 0
	self._championshipGuessCount = 0

	if self._curSelectTab == TeenChampionKingController.ROUND_CHAMPIONSHIP_MIN then
		local info = TeenChampionKingModel.instance:getChampionshipGuessRecordInfo(self._activityId)

		if info then
			if not info.guessRankPlayerIds then
				do
					local guessRankPlayerIds = {}

					self._guessPlayerIds = guessRankPlayerIds
					self._realRankPlayerIds = info.realRankPlayerIds or {}
					self._result = info.result or 0
					self._championshipGuessCount = info.championshipGuessCount or 0

					for i, userId in ipairs(self._realRankPlayerIds) do
						local realUserId = checknumber(userId)

						if realUserId > 0 then
							self._rankMapByPlayerId[realUserId] = i
						end

						if realUserId == checknumber(self._guessPlayerIds[i]) then
							self._matchCount = self._matchCount + 1
						end
					end

					for i, userId in ipairs(guessRankPlayerIds) do
						local guessUserId = checknumber(userId)

						if guessUserId > 0 then
							self._guessCount = self._guessCount + 1
						end
					end
				end

				if self._guessCount <= 0 then
					goutil.setActive(self._emptyGo, true)
					goutil.setActive(self._finals, false)
				else
					local isExistResult = #self._realRankPlayerIds > 0

					if isExistResult then
						for i, cell in ipairs(self._infoCellList) do
							local playerId = checknumber(self._guessPlayerIds[i])
							local headInfo = self:_getPlayerInfo(playerId)

							if headInfo then
								goutil.setActive(cell.empty, false)
								goutil.setActive(cell.playerinfo, true)
								HeadItemController.instance:setHeadCellByInfo(cell.icon, headInfo)

								cell.txtName.text = headInfo.userName

								goutil.setActive(cell.match, i == self._rankMapByPlayerId[playerId])
								goutil.setActive(cell.noMatch, i ~= self._rankMapByPlayerId[playerId])

								if not self._rankMapByPlayerId[playerId] then
									cell.txtRankReal.text = string.format("实际排名:%s", self._rankMapByPlayerId[playerId])
								end
							else
								goutil.setActive(cell.empty, true)
								goutil.setActive(cell.playerinfo, false)
							end

							cell.txtRank.text = i

							goutil.setActive(cell.result, true)
						end

						self._txtShowInfo.text = string.format("预测命中%d位奥奇的最终排名，共获得%d应援", self._matchCount, self._result)
					else
						for i, cell in ipairs(self._infoCellList) do
							local playerId = checknumber(self._guessPlayerIds[i])
							local headInfo = self:_getPlayerInfo(playerId)

							if headInfo then
								goutil.setActive(cell.empty, false)
								goutil.setActive(cell.playerinfo, true)
								HeadItemController.instance:setHeadCellByInfo(cell.icon, headInfo)

								cell.txtName.text = headInfo.userName
							else
								goutil.setActive(cell.empty, true)
								goutil.setActive(cell.playerinfo, false)
							end

							cell.txtRank.text = i

							goutil.setActive(cell.result, false)
						end

						self._txtShowInfo.text = string.format("已预测%d位奥奇的最终排名，共应援%d", self._guessCount, self._championshipGuessCount)
					end

					goutil.setActive(self._emptyGo, false)
					goutil.setActive(self._finals, true)
				end
			end
		end
	else
		goutil.setActive(self._tableviewGo, true)

		local info = TeenChampionKingModel.instance:getKnockoutGuessRecord(self._activityId, self._curSelectTab)

		if info then
			if not info.recordList then
				local recordList = {}

				self._scrollerList:reloadData(recordList)
				goutil.setActive(self._emptyGo, #recordList <= 0)
			end
		else
			self._scrollerList:reloadData({})
		end
	end
end

return TCKGuessRecordView
