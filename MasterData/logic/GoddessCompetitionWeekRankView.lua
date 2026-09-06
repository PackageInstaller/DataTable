-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionWeekRankView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionWeekRankView", package.seeall)

local GoddessCompetitionWeekRankView = class("GoddessCompetitionWeekRankView", ViewComponent)
local FINAL_STEPID = 4

function GoddessCompetitionWeekRankView:ctor()
	GoddessCompetitionWeekRankView.super.ctor(self)
end

function GoddessCompetitionWeekRankView:unbindEvents()
	GoddessCompetitionWeekRankView.super.unbindEvents(self)
end

function GoddessCompetitionWeekRankView:bindEvents()
	GoddessCompetitionWeekRankView.super.bindEvents(self)
end

function GoddessCompetitionWeekRankView:buildUI()
	GoddessCompetitionWeekRankView.super.buildUI(self)

	self._rankTableCell = self:getGo("cell")
	self._rankTableView = self:getGo("rankScrollRect")
	self._rankTableList = ScrollerList.create(self._rankTableView, self._rankTableCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._goEmpty = self:getGo("goEmpty")
	self._petTableview = self:getGo("bottom/tableview")
	self._petTableCell = self:getGo("bottom/pet")
	self._petTableList = ScrollerList.create(self._petTableview, self._petTableCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._txtMyScore = self:getTxt("myRank/txtMyScore")
end

function GoddessCompetitionWeekRankView:onExit()
	GoddessCompetitionWeekRankView.super.onExit(self)

	self._curFaceId = nil

	self._rankTableList:dispose()
	self._petTableList:dispose()
end

function GoddessCompetitionWeekRankView:onEnter()
	GoddessCompetitionWeekRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.GoddessCompetitionRankViewRes, self._refreshView, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._stepId = checknumber(params[2])

	local goddessInfo = GoddessCompetitionModel.instance:getCurGoddessList(self._stepId)
	local goddessCfg = GoddessCompetitionConfig.instance:getGoddessCfgs(self._activityId)

	if goddessInfo then
		self:_onClickPet(goddessInfo[1].faceId)
	else
		self:_onClickPet(goddessCfg[1].goddessFaceId)
	end
end

function GoddessCompetitionWeekRankView:_refreshView()
	local rankInfo, myRank, myScore = GoddessCompetitionModel.instance:getRankInfo()

	rankInfo = rankInfo or {}

	self._rankTableList:reloadData(rankInfo)
	GameUtil.SetActive(self._goEmpty, #rankInfo <= 0)

	self._petRank = {}
	self._showRank = false

	local stepCfg = GoddessCompetitionConfig.instance:getStepCfgByStepId(self._activityId, self._stepId)
	local goddessInfo = GoddessCompetitionModel.instance:getCurGoddessList(self._stepId)

	if GameUtil.string2time(stepCfg.endTime) <= ServerTime.now() and self._stepId == FINAL_STEPID and goddessInfo then
		local petScoreList = {}

		for i, v in ipairs(goddessInfo) do
			table.insert(petScoreList, {
				score = checknumber(v.popularity),
				faceId = v.faceId,
				timestamp = checknumber(v.timestamp)
			})
		end

		ArraySort.sortOn(petScoreList, {
			function(a)
				return a.score
			end,
			function(a)
				return a.timestamp
			end,
			function(a)
				return GoddessCompetitionConfig.instance:getGoddessSortId(self._activityId, a.faceId)
			end
		}, {
			ArraySort.DESCENDING,
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		})

		for i, v in ipairs(petScoreList) do
			self._petRank[v.faceId] = i
		end

		self._showRank = true
	end

	local goddessCfg = GoddessCompetitionConfig.instance:getGoddessCfgs(self._activityId)
	local goddessList = {}

	if goddessInfo then
		for i, v in ipairs(goddessInfo) do
			table.insert(goddessList, GoddessCompetitionConfig.instance:getGoddessCfg(self._activityId, v.faceId))
		end
	else
		for i, v in ipairs(goddessCfg) do
			table.insert(goddessList, v)
		end
	end

	self._petTableList:reloadData(goddessList)

	self._txtMyRank.text = checknumber(myRank) > 0 and myRank or lang("未上榜")
	self._txtMyScore.text = myScore
end

function GoddessCompetitionWeekRankView:_updateRankCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtArea = goutil.findChildTextComponent(go, "txtArea")
	local rankInfo = data

	txtRank.text = rankInfo.rank

	GameUtil.SetActive(imgChangeRank, rankInfo.rank <= 3 and rankInfo.rank > 0)

	if rankInfo.rank <= 3 and rankInfo.rank > 0 then
		imgChangeRank:SetState(rankInfo.rank - 1)
		GameUtil.SetActive(imgChangeRank, true)
		GameUtil.SetActive(txtRank, false)
	else
		GameUtil.SetActive(imgChangeRank, false)
		GameUtil.SetActive(txtRank, true)
	end

	HeadItemController.instance:setHeadCellByInfo(imgIcon, rankInfo.headInfo, true)

	txtName.text = rankInfo.headInfo.userName
	txtScore.text = rankInfo.value
	txtArea.text = rankInfo.headInfo.areaName
end

function GoddessCompetitionWeekRankView:_clearRankCell(cell)
	local go = cell.gameObject

	HeadItemController.instance:resetHeadCell(go)
end

function GoddessCompetitionWeekRankView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "petContainer")
	local rank = goutil.findChild(go, "rank")
	local txtRank = goutil.findChildTextComponent(go, "rank/txtRank")
	local proxy = MaterialMgr.setCell(MatType.Pet, data.goddessFaceId, con)

	if proxy then
		proxy.binder:setAutoTips(false)
		proxy.binder:setSelected(data.goddessFaceId == self._curFaceId)
		proxy.binder:setCallBack(function()
			self:_onClickPet(data.goddessFaceId)
		end)
	end

	if self._petRank[data.goddessFaceId] ~= nil then
		txtRank.text = self._petRank[data.goddessFaceId]

		GameUtil.SetActive(rank, self._showRank)
	else
		GameUtil.SetActive(rank, false)
	end
end

function GoddessCompetitionWeekRankView:_clearPetCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "petContainer")

	MaterialMgr.resetAll(con)
end

function GoddessCompetitionWeekRankView:_onClickPet(faceId)
	if self._curFaceId ~= faceId then
		self._curFaceId = faceId

		local stepCfg = GoddessCompetitionConfig.instance:getStepCfgByStepId(self._activityId, self._stepId)

		if GameUtil.string2time(stepCfg.openTime) < ServerTime.now() then
			GoddessCompetitionAgent.instance:sendPM_GoddessCompetitionPopularityRankViewReq(self._activityId, self._stepId, self._curFaceId)
		else
			GoddessCompetitionModel.instance:resetRankInfo()
			self:_refreshView()
		end
	end
end

return GoddessCompetitionWeekRankView
