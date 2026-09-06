-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdPetChildRankView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdPetChildRankView", package.seeall)

local YouthArenaThirdPetChildRankView = class("YouthArenaThirdPetChildRankView", ViewComponent)

function YouthArenaThirdPetChildRankView:buildUI()
	YouthArenaThirdPetChildRankView.super.buildUI(self)

	self._rankScrollList = ScrollerList.create(self:getGo("rankCol/scrView"), self:getGo("rankCol/scrCell"), GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._emptyGo = self:getGo("rankCol/emptyGo")
	self._txtRankValueTitle = self:getTxt("rankCol/titleCol/txtField3")
end

function YouthArenaThirdPetChildRankView:onEnter()
	YouthArenaThirdPetChildRankView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._rankStage = checknumber(params[2])
	self._rankType = checknumber(params[3])
	self._subMo = YouthArenaThirdController.instance:getSubMo(self._activityId)
	self._rankList = {}

	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3QualifierPetRaceRankRes, self._handlePetRankRes, self)
	self:_refreshStaticInfo()
	self:_sendRankReq()
end

function YouthArenaThirdPetChildRankView:onExit()
	YouthArenaThirdPetChildRankView.super.onExit(self)

	if self._rankScrollList then
		self._rankScrollList:dispose()
	end
end

function YouthArenaThirdPetChildRankView:_sendRankReq()
	if self._activityId <= 0 or not self:_isPetRank() then
		self:_refreshRankView({})

		return
	end

	if not YouthArenaThirdController.instance:isRankStageOpen(self._activityId, self._rankStage) then
		self:_refreshRankView({})

		return
	end

	local stepId = self:_getMatchStepId()

	if stepId <= 0 then
		self:_refreshRankView({})

		return
	end

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3QualifierPetRaceRankReq(self._activityId, stepId, self:_isPetWinRank())
end

function YouthArenaThirdPetChildRankView:_handlePetRankRes()
	local stepId = self:_getMatchStepId()

	if self._subMo then
		local info = self._subMo:getQualifierPetRankInfo(stepId, self:_isPetWinRank())

		if not self._subMo then
			return
		end

		local rankList = {}

		for _, petInfo in ipairs(self._subMo.infoList or {}) do
			table.insert(rankList, self:_buildPetRankData(petInfo))
		end

		self:_refreshRankView(rankList)
	end
end

function YouthArenaThirdPetChildRankView:_refreshStaticInfo()
	if not self._txtRankValueTitle then
		return
	end

	self._txtRankValueTitle.text = self:_isPetWinRank() and "胜率" or "上阵次数"
end

function YouthArenaThirdPetChildRankView:_refreshRankView(rankList)
	self._rankList = rankList or {}

	GameUtil.SetActive(self._emptyGo, #self._rankList <= 0)
	self._rankScrollList:reloadData(self._rankList)
	self._rankScrollList:MoveCellInView(0, true)
end

function YouthArenaThirdPetChildRankView:_buildPetRankData(info)
	local raceId = checknumber(info and info.raceId)
	local value = checknumber(info and info.fightTimes)

	return {
		rank = checknumber(info and info.rank),
		raceId = raceId,
		name = self:_getPetName(raceId),
		value = (self:_isPetWinRank() or nil) and string.format("%s%%", checknumber(info and info.winRate)),
		winTimes = checknumber(info and info.winTimes)
	}
end

function YouthArenaThirdPetChildRankView:_updateRankCell(view, cell, data, tag)
	if not cell.gameObject then
		local go = cell
		local imgRank = goutil.findChildComponent(go, "imgRank", ComponentType.UIImageSpriteChange)
		local txtRank = goutil.findChildTextComponent(go, "txtRank")
		local headRoot = goutil.findChild(go, "headRoot")
		local txtName = goutil.findChildTextComponent(go, "txtName")
		local txtValue = goutil.findChildTextComponent(go, "txtValue")
		local txtWinTimes = goutil.findChildTextComponent(go, "txtWinTimes")
		local rank = checknumber(data and data.rank)
		local isTop3 = rank >= 1 and rank <= 3

		self:_clearPetHead(headRoot)

		if imgRank then
			imgRank.gameObject:SetActive(isTop3)

			if isTop3 then
				imgRank:SetState(rank - 1)
			end
		end

		if txtRank then
			txtRank.gameObject:SetActive(not isTop3)

			txtRank.text = tostring(rank)
		end

		if headRoot and data and checknumber(data.raceId) > 0 then
			MaterialMgr.setCell(MatType.Pet, data.raceId, headRoot)
		end

		if data then
			txtName.text = data.name or ""
		end

		txtValue.text = tostring((data or nil) and (data.value or ""))
		txtWinTimes.text = tostring((data or nil) and (data.winTimes or ""))
	end
end

function YouthArenaThirdPetChildRankView:_clearRankCell(cell)
	if not cell.gameObject then
		self:_clearPetHead(goutil.findChild(cell.gameObject, "headRoot"))
	end
end

function YouthArenaThirdPetChildRankView:_getMatchStepId()
	if self._rankStage == YouthArenaThirdEnum.RankStage.Qualifier then
		return YouthArenaThirdEnum.MatchStepId.Qualifier
	end

	if self._rankStage == YouthArenaThirdEnum.RankStage.ScoreMatch then
		return YouthArenaThirdEnum.MatchStepId.ScoreMatch
	end

	return 0
end

function YouthArenaThirdPetChildRankView:_isPetRank()
	return self._rankType == YouthArenaThirdEnum.RankType.PetWinRate or self._rankType == YouthArenaThirdEnum.RankType.PetUse
end

function YouthArenaThirdPetChildRankView:_isPetWinRank()
	return self._rankType == YouthArenaThirdEnum.RankType.PetWinRate
end

function YouthArenaThirdPetChildRankView:_getPetName(raceId)
	local cfg = MaterialMgr.getMatCfg(MatType.Pet, raceId)

	return (cfg or nil) and (cfg.name or "")
end

function YouthArenaThirdPetChildRankView:_clearPetHead(headRoot)
	if headRoot then
		MaterialMgr.resetAll(headRoot)
	end
end

return YouthArenaThirdPetChildRankView
