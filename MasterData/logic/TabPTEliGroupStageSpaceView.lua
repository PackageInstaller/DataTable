-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/space/TabPTEliGroupStageSpaceView.lua

module("logic.extensions.peaktournament.view.eliminator.tab.space.TabPTEliGroupStageSpaceView", package.seeall)

local TabPTEliGroupStageSpaceView = class("TabPTEliGroupStageSpaceView", TabPTEliBaseSpaceView)

function TabPTEliGroupStageSpaceView:_getEliRoundIdList()
	return {
		1,
		2,
		3
	}
end

function TabPTEliGroupStageSpaceView:_getGroupCount()
	return 16
end

function TabPTEliGroupStageSpaceView:_updateThroneColUI()
	local mainGo = goutil.findChild(self.mainGO, "contentCol/throneCol/throneCell")
	local imgNilSeat = goutil.findChild(mainGo, "imgNilSeat")
	local headcell = goutil.findChild(mainGo, "headcell")
	local headIcon = goutil.findChild(mainGo, "headcell/headIcon")
	local txtName = goutil.findChildTextComponent(mainGo, "headcell/txtName")
	local winTag = goutil.findChild(mainGo, "headcell/winTag")
	local myTag = goutil.findChild(mainGo, "headcell/myTag")
	local tag = goutil.findChild(mainGo, "headcell/tag")
	local lastEliRoundId = self._eliRoundIdList[#self._eliRoundIdList]
	local resultInfoMo = PeakTournamentModel.instance:getResultInfoMo(lastEliRoundId, self._curGroupIndex, 1)
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

		GameUtil.SetActive(tag, false)
		GameUtil.SetActive(winTag, true)
		GameUtil.SetActive(myTag, userId == self._myUserId)
	else
		HeadItemController.instance:resetHeadCell(headIcon)
	end
end

function TabPTEliGroupStageSpaceView:_clearThroneColUI()
	local mainGo = goutil.findChild(self.mainGO, "contentCol/throneCol/throneCell")
	local headIcon = goutil.findChild(mainGo, "headcell/headIcon")

	HeadItemController.instance:resetHeadCell(headIcon)
end

return TabPTEliGroupStageSpaceView
