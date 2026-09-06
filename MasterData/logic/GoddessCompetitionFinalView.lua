-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionFinalView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionFinalView", package.seeall)

local GoddessCompetitionFinalView = class("GoddessCompetitionFinalView", ViewComponent)

function GoddessCompetitionFinalView:ctor()
	GoddessCompetitionFinalView.super.ctor(self)
end

function GoddessCompetitionFinalView:unbindEvents()
	GoddessCompetitionFinalView.super.unbindEvents(self)

	for i, cell in ipairs(self._petList) do
		GameUtil.rmClickHandler(cell.btnSelect)
	end

	GameUtil.rmClickHandler(self._btnVote)
end

function GoddessCompetitionFinalView:bindEvents()
	GoddessCompetitionFinalView.super.bindEvents(self)

	for i, cell in ipairs(self._petList) do
		GameUtil.addClickHandler(cell.btnSelect, GameUtil.handler(self._switchCurPet, self, i))
	end

	GameUtil.addClickHandler(self._btnVote, self._onClickVote, self)
end

function GoddessCompetitionFinalView:buildUI()
	GoddessCompetitionFinalView.super.buildUI(self)

	self._btnVote = self:getGo("btnVote")
	self._con = self:getGo("con")
	self._petList = {}

	for i = 1, 4 do
		local cell = {}

		cell.go = self:getGo("goddesslist/pet_" .. i)
		cell.select = goutil.findChild(cell.go, "select")
		cell.icon = goutil.findChild(cell.go, "icon")
		cell.btnSelect = goutil.findChild(cell.go, "btnSelect")
		cell.txt = goutil.findChildTextComponent(cell.go, "vote/txt")
		cell.curRank = goutil.findChild(cell.go, "curRank")
		cell.txtRank = goutil.findChildTextComponent(cell.go, "curRank/txtRank")
		cell.curRankChange = goutil.findChildComponent(cell.go, "curRank", "UIImageSpriteChange")
		self._petList[i] = cell
	end

	self._txtCurVote = self:getTxt("myVote/txtCurVote")
	self._fanList = {}

	for i = 1, 5 do
		local cell = {}

		cell.go = self:getGo("fanlist/fan_" .. i)
		cell.icon = goutil.findChild(cell.go, "icon")
		cell.my = goutil.findChild(cell.go, "my")
		cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
		cell.txtVote = goutil.findChildTextComponent(cell.go, "vote/txt")
		self._fanList[i] = cell
	end
end

function GoddessCompetitionFinalView:onExit()
	GoddessCompetitionFinalView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	for i, cell in ipairs(self._petList) do
		MaterialMgr.resetAll(cell.icon)
	end

	for i, cell in ipairs(self._fanList) do
		HeadItemController.instance:resetHeadCell(cell.icon)
	end

	removetimer(self._switchGoddess, self)
end

function GoddessCompetitionFinalView:onEnter()
	GoddessCompetitionFinalView.super.onEnter(self)

	self._curSortId = nil
	self._activityId = GoddessCompetitionModel.instance:getCurActId()
	self._curShowStepId = checknumber(self:getFirstParam())

	GoddessCompetitionController.instance:getInfo(self._activityId)
	self.addGEvent(self, GlobalNotify.GoddessCompetitionGetBaseInfoRes, self._updateUIByInfo, self)

	self._userId = tostring(RoleModel.instance:getUserId())
end

function GoddessCompetitionFinalView:_updateUIByInfo()
	local baseInfo = GoddessCompetitionModel.instance:getCurActBaseInfo()

	if not baseInfo.myPopularityList then
		self._curPopularityMap = {}

		for _, info in ipairs(baseInfo.myPopularityList) do
			self._curPopularityMap[info.faceId] = checknumber(info.popularity)
		end

		self._curShowInfoList = GoddessCompetitionModel.instance:getCurGoddessList(self._curShowStepId)
		self._sortList = {}

		for i, cell in ipairs(self._petList) do
			local info = self._curShowInfoList[i]

			MaterialMgr.resetAll(cell.icon)
			MaterialMgr.setIcon(cell.icon, MatType.PET_SKIN, info.faceId)

			cell.txt.text = info.popularity

			table.insert(self._sortList, info)
		end

		ArraySort.sortOn(self._sortList, {
			function(a)
				return checknumber(a.popularity)
			end,
			function(a)
				return checknumber(a.timestamp)
			end,
			function(a)
				return GoddessCompetitionConfig.instance:getGoddessSortId(self._activityId, a.faceId)
			end
		}, {
			ArraySort.DESCENDING,
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		})

		for i, cell in ipairs(self._petList) do
			local info = self._curShowInfoList[i]
			local sortId = table.indexof(self._sortList, info)

			cell.txtRank.text = sortId

			if sortId then
				cell.curRankChange:SetState(sortId - 1)
			end

			goutil.setActive(cell.curRank, checknumber(info.popularity) ~= 0)
		end

		if checknumber(self._curSortId) == 0 then
			self._curSortId = Mathf.Random(1, 4)
		end

		self:_updateCurPet()
		goutil.setActive(self._btnVote, not GoddessCompetitionController.instance:isDisplayStep(self._activityId))
	end
end

function GoddessCompetitionFinalView:_switchCurPet(sortId)
	if self._curSortId ~= sortId then
		self._curSortId = sortId

		self:_updateCurPet()
	end
end

function GoddessCompetitionFinalView:_updateCurPet()
	for i, cell in ipairs(self._petList) do
		goutil.setActive(cell.select, self._curSortId == i)
	end

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	local showInfo = self._curShowInfoList[self._curSortId]
	local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("display", showInfo.faceId)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, showInfo.faceId, self._con, displayBagOffset[3], nil, true, displayBagOffset[1], displayBagOffset[2])

	local curVoteValue = checknumber(self._curPopularityMap[showInfo.faceId])

	self._txtCurVote.text = string.format("%s", curVoteValue)

	if not showInfo.superFansList then
		local fansList = {}

		for i, cell in ipairs(self._fanList) do
			local fanInfo = fansList[i]

			if fanInfo then
				HeadItemController.instance:resetHeadCell(cell.icon)
				goutil.setActive(cell.go, true)

				cell.txtVote.text = fanInfo.popularity
				cell.txtName.text = fanInfo.headInfo.userName

				HeadItemController.instance:setHeadCellByInfo(cell.icon, fanInfo.headInfo, true)
				goutil.setActive(cell.my, fanInfo.headInfo.userId == self._userId)
			else
				goutil.setActive(cell.go, false)
			end
		end
	end
end

function GoddessCompetitionFinalView:_onClickVote()
	local showInfo = self._curShowInfoList[self._curSortId]

	UIStateManager.instance:push(ViewName.GoddessCompetitionVoteView, showInfo.faceId)
end

function GoddessCompetitionFinalView:_switchGoddess()
	self._curSortId = self._curSortId + 1

	if self._curSortId > #self._petList then
		self._curSortId = 1
	end

	self:_updateCurPet()
end

return GoddessCompetitionFinalView
