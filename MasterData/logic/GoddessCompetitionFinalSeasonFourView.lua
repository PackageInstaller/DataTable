-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionFinalSeasonFourView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionFinalSeasonFourView", package.seeall)

local GoddessCompetitionFinalSeasonFourView = class("GoddessCompetitionFinalSeasonFourView", ViewComponent)

function GoddessCompetitionFinalSeasonFourView:ctor()
	GoddessCompetitionFinalSeasonFourView.super.ctor(self)
end

function GoddessCompetitionFinalSeasonFourView:unbindEvents()
	GoddessCompetitionFinalSeasonFourView.super.unbindEvents(self)
end

function GoddessCompetitionFinalSeasonFourView:bindEvents()
	GoddessCompetitionFinalSeasonFourView.super.bindEvents(self)
end

function GoddessCompetitionFinalSeasonFourView:buildUI()
	GoddessCompetitionFinalSeasonFourView.super.buildUI(self)

	self._goddessView = self:getGo("goddessView")

	local childGo = self:getGo("goddessCell")

	GameUtil.SetActive(childGo, false)

	for idx = 1, 4 do
		local mainGo = goutil.clone(childGo, string.format("%s_%s", childGo.name, idx))

		goutil.addChildToParent(mainGo, self._goddessView.transform)
	end

	self._goddessView:GetComponent("TestRecordPos"):LoadPlan(0)

	self._goddessCellList = {}

	for i = 0, self._goddessView.transform.childCount - 1 do
		local cell = {}

		cell.go = self._goddessView.transform:GetChild(i).gameObject
		cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
		cell.maskCon = goutil.findChild(cell.go, "mask")
		cell.con = goutil.findChild(cell.go, "mask/con")
		cell.btnVote = goutil.findChild(cell.go, "btnVote")
		cell.imgRank = goutil.findChild(cell.go, "imgRank")
		cell.txtScore = goutil.findChildTextComponent(cell.go, "txtScore")

		table.insert(self._goddessCellList, cell)
	end
end

function GoddessCompetitionFinalSeasonFourView:onExit()
	GoddessCompetitionFinalSeasonFourView.super.onExit(self)
	removetimer(self._onAutoRefresh, self)

	for i, cell in ipairs(self._goddessCellList) do
		uGuiUtil.clearImage(cell.con)
		GameUtil.rmClickHandler(cell.btnVote)
	end
end

function GoddessCompetitionFinalSeasonFourView:onEnter()
	GoddessCompetitionFinalSeasonFourView.super.onEnter(self)

	self._activityId = GoddessCompetitionModel.instance:getCurActId()
	self._curShowStepId = GoddessCompetitionConfig.instance:getStepIdByStepType(self._activityId, GoddessCompetitionController.Step_finals)

	GoddessCompetitionController.instance:getInfo(self._activityId)
	self.addGEvent(self, GlobalNotify.GoddessCompetitionGetBaseInfoRes, self._updateUIByInfo, self)
	settimer(120, self._onAutoRefresh, self, true)
end

function GoddessCompetitionFinalSeasonFourView:_updateUIByInfo()
	local baseInfo = GoddessCompetitionModel.instance:getCurActBaseInfo()
	local curStepId = baseInfo.curStepId

	self._curShowInfoList = GoddessCompetitionModel.instance:getCurGoddessList(self._curShowStepId)

	local sortList = {}

	for i, info in ipairs(self._curShowInfoList) do
		table.insert(sortList, info)
	end

	ArraySort.sortOn(sortList, {
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

	for i, cell in ipairs(self._goddessCellList) do
		local info = sortList[i]

		if info then
			if not info.faceId then
				local faceId = 0

				GameUtil.SetActive(cell.go, true)

				cell.txtName.text = PetSkinConfig.instance:getPetSkinName(faceId)

				local modelCo = CharacterConfig.instance:getModelCo(faceId)

				if modelCo == nil then
					printError(string.format("精灵faceId缺失模型配置:%s", faceId))
					uGuiUtil.clearImage(cell.con)
				else
					uGuiUtil.setSpriteToImage(cell.con, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
				end

				GameUtil.SetActive(cell.maskCon, faceId > 0)
				GameUtil.setUIImageSpriteIdx(cell.imgRank, i - 1)

				cell.txtScore.text = string.format("当前票数：%s", info.popularity)

				goutil.setActive(cell.btnVote, self._curShowStepId == curStepId)
				GameUtil.addClickHandler(cell.btnVote, GameUtil.handler(self._onClickVote, self, i, faceId))
			end
		end
	end
end

function GoddessCompetitionFinalSeasonFourView:_onClickVote(index, faceId)
	if faceId <= 0 then
		return
	end

	UIStateManager.instance:push(ViewName.GoddessCompetitionVoteView, faceId)
end

function GoddessCompetitionFinalSeasonFourView:_onAutoRefresh()
	GoddessCompetitionController.instance:getInfo(self._activityId)
end

return GoddessCompetitionFinalSeasonFourView
