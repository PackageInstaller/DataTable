-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/CommonScrollerBattleSettlementView.lua

module("logic.extensions.youtharenathird.view.CommonScrollerBattleSettlementView", package.seeall)

local CommonScrollerBattleSettlementView = class("CommonScrollerBattleSettlementView", ViewComponent)
local MIN_PET_CELL_COUNT = 5

function CommonScrollerBattleSettlementView:ctor()
	CommonScrollerBattleSettlementView.super.ctor(self)
end

function CommonScrollerBattleSettlementView:buildUI()
	CommonScrollerBattleSettlementView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._win = self:getGo("win")
	self._fail = self:getGo("fail")
	self._dogFall = self:getGo("dogFall")
	self._txtScore = self:getTxt("score/txt")
	self._scoreCol = self:getGo("scoreCol")
	self._scoreScrollerList = ScrollerList.create(self:getGo("scoreCol/scrView"), self:getGo("scoreCol/scrCell"), GameUtil.handler(self._updateScoreCell, self), nil)
	self._formsViewport = self:getGo("forms/scrView/viewport")
	self._formsScrollerList = ScrollerList.create(self:getGo("forms/scrView"), self:getGo("forms/scrCell"), GameUtil.handler(self._updateFormCell, self), GameUtil.handler(self._clearFormCell, self))
	self._petScrollerListDic = {}
	self._playerCells = {}

	for _, path in ipairs({
		"players/player_1",
		"players/player_2"
	}) do
		local playerGo = self:getGo(path)

		table.insert(self._playerCells, {
			head = goutil.findChild(playerGo, "pointHead"),
			txtUserName = goutil.findChildTextComponent(playerGo, "txtUserName"),
			txtTotalForce = goutil.findChildTextComponent(playerGo, "txtTotalForce")
		})
	end
end

function CommonScrollerBattleSettlementView:bindEvents()
	CommonScrollerBattleSettlementView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._formsViewport, self._onClickClose, self)
end

function CommonScrollerBattleSettlementView:unbindEvents()
	CommonScrollerBattleSettlementView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._formsViewport)
end

function CommonScrollerBattleSettlementView:onEnter()
	CommonScrollerBattleSettlementView.super.onEnter(self)

	local params = self:getOpenParam()

	self._btlResults = params[1]
	self._leftTeamId = params[2]

	if not params[3] then
		local param = {}

		if self._leftTeamId == GameEnum.BattleTeam.Left then
			self._rightTeamId = GameEnum.BattleTeam.Right or GameEnum.BattleTeam.Left
		end

		self._results = param.results or {}
		self._totalScores = param.totalScores
		self._scoreText = param.scoreText
		self._scoreItems = param.scoreItems or {}
		self._petStates = param.petStates or {}
		self._viewDatas = self:_buildViewDatas()

		self:_refreshPlayers()
		self:_refreshScore()
		self:_refreshScoreItems()
		self._formsScrollerList:reloadData(self._viewDatas)
	end
end

function CommonScrollerBattleSettlementView:onExit()
	CommonScrollerBattleSettlementView.super.onExit(self)
	self:_resetPlayerHeads()
	self._scoreScrollerList:dispose()
	self._formsScrollerList:dispose()
	self:_disposePetScrollerLists()

	self._totalScores = nil
	self._scoreText = nil
	self._petStates = nil
end

function CommonScrollerBattleSettlementView:_buildViewDatas()
	local list = {}

	for idx, btlResult in ipairs(self._btlResults) do
		local leftTeam = self:_getTeamView(btlResult, self._leftTeamId)
		local rightTeam = self:_getTeamView(btlResult, self._rightTeamId)
		local result = self._results[idx]

		if result == GameEnum.BattleResult.ExpSuccess then
			result = GameEnum.BattleResult.Success
		elseif result == nil then
			result = btlResult.activityWinner == self._leftTeamId and GameEnum.BattleResult.Success or btlResult.activityWinner == self._rightTeamId and GameEnum.BattleResult.Failed or GameEnum.BattleResult.DogFall
		end

		table.insert(list, {
			index = idx,
			result = result,
			leftPlayerView = leftTeam and leftTeam.playerView,
			rightPlayerView = rightTeam and rightTeam.playerView,
			leftPetCells = self:_buildPetCells(leftTeam and leftTeam.playerView, self._leftTeamId, idx),
			rightPetCells = self:_buildPetCells(rightTeam and rightTeam.playerView, self._rightTeamId, idx)
		})
	end

	return list
end

function CommonScrollerBattleSettlementView:_getTeamView(btlResult, teamId)
	if btlResult and btlResult.originalStates then
		if not btlResult.originalStates.teams then
			local teams = {}

			for _, team in ipairs(teams) do
				if team.teamId == teamId then
					return team
				end
			end
		end
	end
end

function CommonScrollerBattleSettlementView:_buildPetCells(playerView, teamId, battleIndex)
	local petCells = {}

	if playerView then
		if not playerView.characterViews then
			local characterViews = {}

			if not self._petStates[battleIndex] then
				local battleStates = {}

				if not battleStates[teamId] then
					local teamStates = {}

					for _, petView in ipairs(characterViews) do
						local petMo = FightingPowerPetMo.createPetByLevel(checknumber(petView.raceId), checknumber(petView.lv), checknumber(petView.awakenLv), checknumber(petView.curFaceId))

						petMo.hideZdl = true

						local petId = checknumber(petView.id)
						local petState = teamStates[petId]
						local var_9_3 = petCells
						local var_9_4 = {
							teamId = teamId,
							petId = petId,
							petMo = petMo,
							zdl = checknumber(petView.zdl)
						}

						if petState then
							var_9_4.isDead = petState.isDead or false
						end

						table.insert(var_9_3, var_9_4)
					end

					table.sort(petCells, function(a, b)
						return a.zdl > b.zdl
					end)

					for _ = #petCells + 1, MIN_PET_CELL_COUNT do
						table.insert(petCells, {
							teamId = teamId
						})
					end

					return petCells
				end
			end
		end
	end
end

function CommonScrollerBattleSettlementView:_refreshPlayers()
	self:_resetPlayerHeads()

	local leftPlayerView, rightPlayerView

	for _, data in ipairs(self._viewDatas) do
		leftPlayerView = leftPlayerView or data.leftPlayerView
		rightPlayerView = rightPlayerView or data.rightPlayerView

		if leftPlayerView and rightPlayerView then
			break
		end
	end

	self:_updatePlayer(self._playerCells[1], leftPlayerView)
	self:_updatePlayer(self._playerCells[2], rightPlayerView)
end

function CommonScrollerBattleSettlementView:_updatePlayer(cell, playerView)
	if playerView == nil then
		HeadItemController.instance:resetHeadCell(cell.head)

		cell.txtUserName.text = ""
		cell.txtTotalForce.text = 0

		return
	end

	HeadItemController.instance:setHeadCellByInfo(cell.head, {
		userId = playerView.id,
		userName = playerView.name,
		playerLv = playerView.playerLv,
		headIconId = playerView.headIcon,
		headFrameId = playerView.headFrame
	})

	cell.txtUserName.text = playerView.name
	cell.txtTotalForce.text = checknumber(playerView.fightPower)
end

function CommonScrollerBattleSettlementView:_resetPlayerHeads()
	for _, cell in ipairs(self._playerCells) do
		HeadItemController.instance:resetHeadCell(cell.head)
	end
end

function CommonScrollerBattleSettlementView:_refreshScore()
	local leftWinCount = 0
	local rightWinCount = 0

	for _, data in ipairs(self._viewDatas) do
		if data.result == GameEnum.BattleResult.Success then
			leftWinCount = leftWinCount + 1
		elseif data.result == GameEnum.BattleResult.Failed then
			rightWinCount = rightWinCount + 1
		end
	end

	local leftScore = leftWinCount
	local rightScore = rightWinCount

	if self._totalScores then
		leftScore = checknumber(self._totalScores.left)
		rightScore = checknumber(self._totalScores.right)
	end

	self._txtScore.text = self._scoreText and self._scoreText or string.format("%s  :  %s", leftScore, rightScore)

	local isWin = rightScore < leftScore or leftScore == rightScore and rightWinCount < leftWinCount
	local isFail = leftScore < rightScore or leftScore == rightScore and leftWinCount < rightWinCount

	GameUtil.SetActive(self._win, isWin)
	GameUtil.SetActive(self._fail, isFail)
	GameUtil.SetActive(self._dogFall, not isWin and not isFail)
end

function CommonScrollerBattleSettlementView:_refreshScoreItems()
	GameUtil.SetActive(self._scoreCol, #self._scoreItems > 0)
	self._scoreScrollerList:reloadData(self._scoreItems)
end

function CommonScrollerBattleSettlementView:_updateScoreCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtTitle = goutil.findChildTextComponent(mainGo, "txt1")
	local txtOld = goutil.findChildTextComponent(mainGo, "txtOld")
	local txtNew = goutil.findChildTextComponent(mainGo, "txtNew")
	local tagAdd = goutil.findChild(mainGo, "tagAdd")
	local tagReduce = goutil.findChild(mainGo, "tagReduce")
	local oldValue = data.oldValue
	local newValue = data.newValue

	txtTitle.text = data.title
	txtOld.text = oldValue
	txtNew.text = newValue

	local changeValue = checknumber(newValue) - checknumber(oldValue)

	GameUtil.SetActive(tagAdd, changeValue > 0)
	GameUtil.SetActive(tagReduce, changeValue < 0)
end

function CommonScrollerBattleSettlementView:_updateFormCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local leftForm = goutil.findChild(mainGo, "leftForm")
	local rightForm = goutil.findChild(mainGo, "rightForm")

	self:_updateOneForm(mainGo, leftForm, data.index, data.leftPlayerView, data.leftPetCells, self._leftTeamId)
	self:_updateOneForm(mainGo, rightForm, data.index, data.rightPlayerView, data.rightPetCells, self._rightTeamId)
	self:_updateResultTag(mainGo, data.result)
end

function CommonScrollerBattleSettlementView:_updateOneForm(cellGo, formGo, index, playerView, petCells, teamId)
	local txtTotalForce = goutil.findChildTextComponent(formGo, "txtTotalForce")
	local txtTeam = goutil.findChildTextComponent(formGo, "txtTeam")
	local petsGo = goutil.findChild(formGo, "pets")
	local scrView = goutil.findChild(petsGo, "scrView")
	local scrCell = goutil.findChild(petsGo, "scrCell")

	txtTotalForce.text = checknumber(playerView and playerView.fightPower)
	txtTeam.text = string.format("队伍%s", index)

	if not self._petScrollerListDic[cellGo] then
		local cache = {}

		self._petScrollerListDic[cellGo] = cache

		local petScrollerList = cache[teamId]

		if petScrollerList == nil then
			petScrollerList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

			petScrollerList:dragNotifyParent()

			cache[teamId] = petScrollerList
		end

		petScrollerList:reloadData(petCells)
	end
end

function CommonScrollerBattleSettlementView:_updateResultTag(mainGo, result)
	local tagResult = goutil.findChild(mainGo, "tagResult")
	local isDraw = result == GameEnum.BattleResult.DogFall

	GameUtil.SetActive(tagResult, not isDraw)

	if not isDraw then
		local state = result == GameEnum.BattleResult.Success and 0 or 1

		GameUtil.setUIImageSpriteIdx(tagResult, state)
	end
end

function CommonScrollerBattleSettlementView:_clearFormCell(cell)
	local mainGo = cell.gameObject
	local cache = self._petScrollerListDic[mainGo]

	if cache == nil then
		return
	end

	self._petScrollerListDic[mainGo] = nil

	for _, petScrollerList in pairs(cache) do
		petScrollerList:dispose()
	end
end

function CommonScrollerBattleSettlementView:_updatePetCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local forceGo = goutil.findChild(mainGo, "force")
	local txtForce = goutil.findChildTextComponent(mainGo, "force/txtForce")
	local pointPet = goutil.findChild(mainGo, "pointPet")
	local tagDead = goutil.findChild(mainGo, "tagDead")
	local petMo = data.petMo

	MaterialMgr.resetAll(pointPet)
	GameUtil.SetActive(forceGo, petMo ~= nil)
	GameUtil.SetActive(tagDead, petMo ~= nil and data.isDead == true)

	if petMo then
		txtForce.text = data.zdl

		local proxy = MaterialMgr.setCellByData(MatType.Pet, petMo, pointPet)

		if proxy then
			proxy:setAutoTips(false)
			proxy.binder:setLvl(petMo.level)
			proxy.binder:setStars(petMo.awakenLv)
			proxy.binder:setIconDirection(data.teamId == self._leftTeamId)
		end
	end
end

function CommonScrollerBattleSettlementView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local pointPet = goutil.findChild(mainGo, "pointPet")
	local tagDead = goutil.findChild(mainGo, "tagDead")

	GameUtil.SetActive(tagDead, false)
	MaterialMgr.resetAll(pointPet)
end

function CommonScrollerBattleSettlementView:_disposePetScrollerLists()
	for _, cache in pairs(self._petScrollerListDic) do
		for _, petScrollerList in pairs(cache) do
			petScrollerList:dispose()
		end
	end

	self._petScrollerListDic = {}
end

function CommonScrollerBattleSettlementView:_onClickClose()
	BattleController.instance:endBattle()
end

return CommonScrollerBattleSettlementView
