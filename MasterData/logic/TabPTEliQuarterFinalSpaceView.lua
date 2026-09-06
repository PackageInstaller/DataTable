-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/space/TabPTEliQuarterFinalSpaceView.lua

module("logic.extensions.peaktournament.view.eliminator.tab.space.TabPTEliQuarterFinalSpaceView", package.seeall)

local TabPTEliQuarterFinalSpaceView = class("TabPTEliQuarterFinalSpaceView", TabPTEliBaseSpaceView)

function TabPTEliQuarterFinalSpaceView:_getEliRoundIdList()
	return {
		6
	}
end

function TabPTEliQuarterFinalSpaceView:_getGroupCount()
	return 1
end

function TabPTEliQuarterFinalSpaceView:_updateThroneColUI()
	local throneCell_1 = goutil.findChild(self.mainGO, "contentCol/throneCol/throneCell1")
	local throneCell_2 = goutil.findChild(self.mainGO, "contentCol/throneCol/throneCell2")
	local var_3_0 = goutil.findChild(self.mainGO, "txtGlobalRaceTips")

	GameUtil.SetActive(zoneRaceTips, self._eliRoundCfg and self._eliRoundCfg[self._curEliRoundId].spaceKnockout == false)

	for stageId, throneCellMainGo in ipairs({
		throneCell_1,
		throneCell_2
	}) do
		local mainGo = throneCellMainGo
		local imgNilSeat = goutil.findChild(mainGo, "imgNilSeat")
		local headcell = goutil.findChild(mainGo, "headcell")
		local headIcon = goutil.findChild(mainGo, "headcell/headIcon")
		local txtName = goutil.findChildTextComponent(mainGo, "headcell/txtName")
		local winTag = goutil.findChild(mainGo, "headcell/winTag")
		local myTag = goutil.findChild(mainGo, "headcell/myTag")
		local tag = goutil.findChild(mainGo, "headcell/tag")
		local tagUIImageSpriteChange = goutil.findChild(mainGo, "headcell/tag/img"):GetComponent("UIImageSpriteChange")
		local lastEliRoundId = self._eliRoundIdList[#self._eliRoundIdList]
		local resultInfoMo = PeakTournamentModel.instance:getResultInfoMo(lastEliRoundId, self._curGroupIndex, stageId)
		local isMe = true

		if resultInfoMo then
			isMe = resultInfoMo:isWin(isMe) == true
		end

		local isNilSeat = true

		isNilSeat = resultInfoMo and (lastEliRoundId > self._curEliRoundId and true or self._curPeriodId <= EliminatorMgr.PeriodId.Performance) or true

		GameUtil.SetActive(imgNilSeat, isNilSeat)
		GameUtil.SetActive(headcell, not isNilSeat)

		if not isNilSeat and resultInfoMo then
			local headInfo = resultInfoMo:getHeadInfo(isMe)

			if headInfo then
				HeadItemController.instance:setHeadCellByInfo(headIcon, headInfo, true)
			else
				HeadItemController.instance:resetHeadCell(headIcon)
			end

			local userName = resultInfoMo:getUserNameAddAreaId(isMe)
			local userId = resultInfoMo:getUserId(isMe)

			if userId == self._myUserId then
				userName = string.format("<color=#3E8F4E>%s</color>", userName)
			end

			txtName.text = userName

			GameUtil.SetActive(tag, true)
			tagUIImageSpriteChange:SetState(2)
			GameUtil.SetActive(winTag, false)
			GameUtil.SetActive(myTag, userId == self._myUserId)
		else
			HeadItemController.instance:resetHeadCell(headIcon)
		end
	end
end

function TabPTEliQuarterFinalSpaceView:_clearThroneColUI()
	local throneCell_1 = goutil.findChild(self.mainGO, "contentCol/throneCol/throneCell1")
	local throneCell_2 = goutil.findChild(self.mainGO, "contentCol/throneCol/throneCell2")

	for _, throneCellMainGo in ipairs({
		throneCell_1,
		throneCell_2
	}) do
		local mainGo = throneCellMainGo
		local headIcon = goutil.findChild(mainGo, "headcell/headIcon")

		HeadItemController.instance:resetHeadCell(headIcon)
	end
end

return TabPTEliQuarterFinalSpaceView
