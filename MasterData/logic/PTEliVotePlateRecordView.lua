-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/PTEliVotePlateRecordView.lua

module("logic.extensions.peaktournament.view.eliminator.PTEliVotePlateRecordView", package.seeall)

local PTEliVotePlateRecordView = class("PTEliVotePlateRecordView", ViewComponent)

function PTEliVotePlateRecordView:buildUI()
	PTEliVotePlateRecordView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._tabScrollerview = goutil.findChild(self.mainGO, "tabCol/tabScrollerview")
	self._tabScrollercell = goutil.findChild(self.mainGO, "tabCol/tabScrollercell")
	self._recordScrollerview = goutil.findChild(self.mainGO, "recordCol/recordScrollerview")
	self._recordScrollercell = goutil.findChild(self.mainGO, "recordCol/recordScrollercell")
	self._imgEmpty = goutil.findChild(self.mainGO, "recordCol/imgEmpty")
	self._tabScrollList = ScrollerList.create(self._tabScrollerview, self._tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._recordScrollList = ScrollerList.create(self._recordScrollerview, self._recordScrollercell, GameUtil.handler(self._updateRecordCell, self), GameUtil.handler(self._clearRecordCell, self))
end

function PTEliVotePlateRecordView:bindEvents()
	PTEliVotePlateRecordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PTEliVotePlateRecordView:unbindEvents()
	PTEliVotePlateRecordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PTEliVotePlateRecordView:onEnter()
	PTEliVotePlateRecordView.super.onEnter(self)

	self._activityId = PeakTournamentController.instance:getCurActivityId()

	if self._activityId == 0 then
		FloatWordMgr.instance:show("缺失活动id")
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentKnockoutGainGuessRecordRes, self._onUpdateRecordColUI, self)
	self:_onUpdate()
end

function PTEliVotePlateRecordView:onExit()
	PTEliVotePlateRecordView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentKnockoutGainGuessRecordRes, self._onUpdateRecordColUI, self)
	self._tabScrollList:dispose()
	self._recordScrollList:dispose()
end

function PTEliVotePlateRecordView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function PTEliVotePlateRecordView:_onUpdateData()
	self:_onUpdateTabColData()
end

function PTEliVotePlateRecordView:_onUpdateUI()
	self:_onUpdateTabColUI()
	self:_onUpdateRecordColUI()
end

function PTEliVotePlateRecordView:_sendAndGetInfo()
	local tabInfo = self:_getTabViewInfo(self._curTabIndex) or {}

	if tabInfo and tabInfo.data then
		local eliRoundId = tabInfo.data.eliRoundId

		PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGainGuessRecordReq(self._activityId, eliRoundId)
	end
end

function PTEliVotePlateRecordView:_onUpdateTabColData()
	self._tabInfoList = {}

	local roundCfg = PeakTournamentConfig.instance:getPtEliRoundCfgById(self._activityId)

	for _, data in ipairs(roundCfg) do
		local info = {
			isUnlock = true,
			data = data
		}

		table.insert(self._tabInfoList, info)
	end

	self:_updateCurTabIndex()
	self:_sendAndGetInfo()
end

function PTEliVotePlateRecordView:_updateCurTabIndex()
	self._curTabIndex = self._curTabIndex or 0

	local curInfo = self:_getTabViewInfo(self._curTabIndex)

	if curInfo == nil or not curInfo.isUnlock then
		for tabIndex, info in ipairs(self._tabInfoList) do
			if info.isUnlock == true then
				self._curTabIndex = tabIndex

				break
			end
		end
	end
end

function PTEliVotePlateRecordView:_getTabViewInfo(tabIndex)
	return self._tabInfoList[checknumber(tabIndex)]
end

function PTEliVotePlateRecordView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(self._tabInfoList)

	if self._curTabIndex > 0 then
		local idx = self._curTabIndex - 1
		local isMotion = true

		self._tabScrollList:MoveCellInView(idx, isMotion)
	end
end

function PTEliVotePlateRecordView:_updateTabCell(view, cell, info, tag)
	local isUnlock = info.isUnlock
	local data = info.data
	local index = cell.index + 1
	local mainGo = cell.gameObject
	local changeGroup = mainGo:GetComponent(ComponentType.UIChangeGroup)
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local lock = goutil.findChild(mainGo, "lock")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	GameUtil.SetActive(redPoint, false)
	GameUtil.SetActive(lock, not isUnlock)

	if changeGroup then
		local isSelected = self._curTabIndex == index

		changeGroup:SetState(isSelected and 1 or 0)
	end

	if txtName then
		txtName.text = data.processDesc or ""
	end

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickTabCell, self, mainGo, index))
end

function PTEliVotePlateRecordView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function PTEliVotePlateRecordView:_clickTabCell(mainGo, tabIndex)
	local info = self:_getTabViewInfo(tabIndex)

	if not info.isUnlock then
		FloatWordMgr.instance:show("赛程未开放")

		return
	end

	if self._curTabIndex == tabIndex then
		return
	end

	self._curTabIndex = tabIndex

	self:_onUpdateUI()
	self:_sendAndGetInfo()
end

function PTEliVotePlateRecordView:_onUpdateRecordColUI()
	local tabInfo = self:_getTabViewInfo(self._curTabIndex)
	local eliRoundId = tabInfo.data.eliRoundId

	self._eliRoundId = eliRoundId

	local infoList = PeakTournamentModel.instance:getGuessRecordInfoList(eliRoundId)

	self._recordScrollList:reloadData(infoList)
	GameUtil.SetActive(self._imgEmpty, infoList == nil or #infoList == 0)
end

function PTEliVotePlateRecordView:_updateRecordCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local imgTag = goutil.findChild(mainGo, "imgTag")
	local imgTagSpriteChange = goutil.findChildComponent(mainGo, "imgTag", ComponentType.UIImageSpriteChange)
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local leftHead = goutil.findChild(mainGo, "leftHead")
	local rightHead = goutil.findChild(mainGo, "rightHead")

	imgTagSpriteChange:SetState(1)

	local cfg = PeakTournamentConfig.instance:getPtEliRoundDataById(self._activityId, self._eliRoundId) or {}

	txtScore.text = cfg.processDesc

	if not data.userInfos then
		local userInfos = {}

		if userInfos[1] and userInfos[2] and userInfos[1].winRound > userInfos[2].winRound then
			imgTagSpriteChange:SetState(0)
		end

		local arr = {
			leftHead,
			rightHead
		}

		for idx, headGo in ipairs(arr) do
			local headIcon = goutil.findChild(headGo, "headIcon")
			local txtName = goutil.findChildTextComponent(headGo, "txtName")
			local txtVoteNum = goutil.findChildTextComponent(headGo, "txtVoteNum")

			txtName.text = ""
			txtVoteNum.text = ""

			local info = userInfos[idx]

			if info then
				HeadItemController.instance:setHeadCellByInfo(headIcon, info.headInfo)

				txtName.text = info.headInfo.userName
				txtVoteNum.text = info.winGuessNums
			end
		end
	end
end

function PTEliVotePlateRecordView:_clearRecordCell(cell)
	local mainGo = cell.gameObject
	local imgTag = goutil.findChild(mainGo, "imgTag")
	local imgTagSpriteChange = goutil.findChildComponent(mainGo, "imgTag", ComponentType.UIImageSpriteChange)
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local leftHead = goutil.findChild(mainGo, "leftHead")
	local rightHead = goutil.findChild(mainGo, "rightHead")

	for _, headGo in ipairs({
		leftHead,
		rightHead
	}) do
		local headIcon = goutil.findChild(headGo, "headIcon")
		local btnAid = goutil.findChild(headGo, "btnAid")
		local txtName = goutil.findChild(headGo, "txtName")
		local txtVoteNum = goutil.findChildTextComponent(headGo, "txtVoteNum")

		HeadItemController.instance:resetHeadCell(headIcon)
		GameUtil.rmClickHandler(btnAid)
	end
end

return PTEliVotePlateRecordView
