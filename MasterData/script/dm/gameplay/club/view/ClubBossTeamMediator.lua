-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubBossTeamMediator.lua

require("dm.gameplay.stage.view.CommonTeamMediator")

ClubBossTeamMediator = class("ClubBossTeamMediator", CommonTeamMediator, _M)

ClubBossTeamMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
ClubBossTeamMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubBossTeamMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
ClubBossTeamMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {
	["main.info_bg.costBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickCost"
	},
	["main.my_pet_bg.sortPanel.sortBtn"] = {
		clickAudio = "Se_Click_Fold_1",
		func = "onClickSort"
	}
}
local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}

function ClubBossTeamMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._oneKeyWidget = self:bindWidget("main.info_bg.button_one_key_embattle", ThreeLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onClickOneKeyEmbattle, self)
		}
	})
	self._oneKeyWidget = self:bindWidget("main.info_bg.button_one_key_break", ThreeLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onClickOneKeyBreak, self)
		}
	})
	self._fightBtn = self:bindWidget("main.btnPanel.fightBtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onClickFight, self)
		}
	})
	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_TEAM_CHANGE_MASTER, self, self.changeMasterId)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TEAM_REFRESH_PETS, self, self.refreshViewBySort)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ARENA_CHANGE_TEAM_SUCC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_STAGE_CHANGENAME_SUCC, self, self.refreshTeamName)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_KILLED, self, self.doBossKilledLogic)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_FORCEDLEVEL, self, self.onForcedLevel)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshCombatAndCost)

	local touchPanel = self:getView():getChildByFullName("main.bg.touchPanel")

	touchPanel:addClickEventListener(function()
		self:onClickChangeMaster()
	end)

	self._masterBtn = touchPanel
	self._skillDescPanel = self:getView():getChildByFullName("skillDescPanel")

	self._skillDescPanel:setSwallowTouches(false)
	self._skillDescPanel:addClickEventListener(function()
		if self._skillDescPanel:isVisible() then
			self._skillDescPanel:setVisible(false)
		end
	end)

	self._masterSkillPanel = self:getView():getChildByFullName("main.bg.masterSkillPanel")

	self._masterSkillPanel:setVisible(true)
	self:getView():getChildByFullName("main.bg.masterSkillBg"):setVisible(true)
	self._masterSkillPanel:addClickEventListener(function()
		self:onClickMasterSkill()
	end)
end

function ClubBossTeamMediator:onClickFight(sender, eventType)
	if #self._teamPets < 1 then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("ARENA_TEMA_EMPTY")
		}))

		return false
	end

	local heros = {}

	for k, v in pairs(self._teamPets) do
		table.insert(heros, v)
	end

	local towerId = self._clubSystem:getCurTowerId(self._viewType)

	AudioTimerSystem:playStartBattleVoice(self._curTeam)
	AudioEngine:getInstance():playEffect("Se_Click_Battle", false)

	if self:hasChangeTeam() then
		self:sendUpdateTowerTeam()
	else
		self:sendEnterBattle()
	end
end

function ClubBossTeamMediator:sendUpdateTowerTeam()
	local towerId = self._clubSystem:getCurTowerId(self._viewType)
	local sendData = {}

	for k, v in pairs(self._teamPets) do
		sendData[k] = v
	end

	local params = {
		masterId = self._curMasterId,
		heros = sendData
	}

	params.activityId = self._viewType == ClubHallType.kActivityBoss and self._clubSystem:getClubBossSummerActivityID() or ""

	self._clubSystem:requestUpdateTeam(params, function(response)
		if DisposableObject:isDisposed(self) then
			return
		end

		if response.resCode == GS_SUCCESS then
			local paramsData = {
				pointId = towerId,
				maseterId = self._curMasterId,
				heros = self._teamPets
			}

			paramsData.activityId = self._viewType == ClubHallType.kActivityBoss and self._clubSystem:getClubBossSummerActivityID() or ""

			self._clubSystem:requestStartBossBattle(paramsData, function(data)
				if data.ErrorCode and data.ErrorCode == 11466 then
					self:dispatch(ShowTipEvent({
						duration = 0.35,
						tip = Strings:get("Error_11466")
					}))
					self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

					return
				end

				self._clubSystem:enterBattle(data, self._viewType)
			end)
		end
	end, false, {
		ignoreTip = true
	})
end

function ClubBossTeamMediator:sendEnterBattle()
	local towerId = self._clubSystem:getCurTowerId(self._viewType)
	local paramsData = {
		pointId = towerId,
		maseterId = self._curMasterId,
		heros = self._teamPets
	}

	paramsData.activityId = self._viewType == ClubHallType.kActivityBoss and self._clubSystem:getClubBossSummerActivityID() or ""

	self._clubSystem:requestStartBossBattle(paramsData, function(data)
		if data.ErrorCode and data.ErrorCode == 11466 then
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = Strings:get("Error_11466")
			}))
			self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

			return
		end

		self._clubSystem:enterBattle(data, self._viewType)
	end)
end

function ClubBossTeamMediator:fightRequestCallBack(towerId, data)
	self:onClickBack()
	self._clubSystem:enterBattleView(towerId, data)
end

function ClubBossTeamMediator:enterWithData(data)
	data = data or {}
	self._data = data

	if data and data.viewType then
		self._viewType = data.viewType
	end

	if data and data.stageType then
		self._stageType = data.stageType or ""
	end

	self._masterList = self._masterSystem:getShowMasterList()

	local num = 0

	for i = 1, #self._masterList do
		if not self._masterList[i]:getIsLock() then
			num = num + 1
		end
	end

	self._showChangeMaster = num > 1
	self._isDrag = false
	self._costTotal = 0
	self._costMaxNum = self._stageSystem:getCostInit() + self._developSystem:getBuildingCostEffValue()
	self._maxTeamPetNum = self._stageSystem:getPlayerInit() + self._developSystem:getBuildingCardEffValue()
	self._teamUnlockConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Stage_Team_Unlock", "content")

	self._stageSystem:setSortExtand(0)

	self._ignoreReloadData = true

	self:initData()
	self:setupTopInfoWidget()
	self:initWidgetInfo()

	local nameDi = self._main:getChildByName("nameBg")

	self._editBox = nameDi:getChildByFullName("TextField")

	self._editBox:setVisible(false)

	self._teamName = nameDi:getChildByFullName("teamName")

	self._teamName:setString(self._nowName)
	self:setupView()

	local delayTime = 0.001

	performWithDelay(self:getView(), function()
		local offsetX = self._teamView:getContentOffset().x + self._petSize.width

		if offsetX > 0 then
			offsetX = 0
		end

		self._teamView:reloadData()
		self._teamView:setContentOffset(cc.p(offsetX, 0))
		self:runStartAction()
		self:setupClickEnvs()
	end, delayTime)
	self._costBtn:setVisible(self:showCostBtn())
end

function ClubBossTeamMediator:resumeWithData()
	super.resumeWithData(self)
	self._costBtn:setVisible(self:showCostBtn())

	self._costMaxNum = self._stageSystem:getCostInit() + self._developSystem:getBuildingCostEffValue()

	self._costTotalLabel2:setString("/" .. self._costMaxNum)
end

function ClubBossTeamMediator:initData()
	self._teamList = self._developSystem:getAllUnlockTeams()
	self._curTeam = self._data.team

	local modelTmp = {
		_heroes = self:removeExceptHeros(),
		_masterId = self._curTeam.masterId
	}

	self._curMasterId = modelTmp._masterId

	if self._curMasterId == "" or self._curMasterId == 0 or self._curMasterId == nil then
		self._curMasterId = self._developSystem:getStageTeamById(1):getMasterId()
	end

	self._oldMasterId = self._curMasterId

	local teamPetIndex = 1

	self._teamPets = {}
	self._tempTeams = {}

	for _, v in pairs(modelTmp._heroes) do
		self._teamPets[teamPetIndex] = v
		self._tempTeams[teamPetIndex] = v
		teamPetIndex = teamPetIndex + 1
	end

	self._nowName = self._clubSystem:getClubBoss(self._viewType):getName()
	self._oldName = self._nowName
	self._petList = self._stageSystem:getNotOnTeamPet(self._teamPets)
	self._petListAll = {}

	table.copy(self._petList, self._petListAll)
end

function ClubBossTeamMediator:updateData()
	self._petList = self._stageSystem:getNotOnTeamPet(self._teamPets)
	self._petListAll = {}

	table.copy(self._petList, self._petListAll)
end

function ClubBossTeamMediator:removeExceptHeros()
	local showHeros = {}
	local heros = self._curTeam.heroes

	for k, v in pairs(heros) do
		if not self._clubSystem:getHeroIsTired(v, self._viewType) then
			showHeros[k + 1] = v
		end
	end

	return showHeros
end

function ClubBossTeamMediator:showOneKeyHeros()
	local orderPets = self._heroSystem:getTeamPrepared(self._teamPets, self._petList)

	self._orderPets = {}
	self._leavePets = {}

	local canRecommendNum = 0

	for i = 1, #orderPets do
		if self._clubSystem:getIsRecommend(orderPets[i], self._viewType) then
			canRecommendNum = canRecommendNum + 1
		end
	end

	local tbRecommandIds = {}
	local notRecommendNum = self._maxTeamPetNum - canRecommendNum

	notRecommendNum = notRecommendNum > 0 and notRecommendNum or 0

	for i = 1, #orderPets do
		if self._clubSystem:getIsRecommend(orderPets[i], self._viewType) then
			if #self._orderPets < self._maxTeamPetNum then
				self._orderPets[#self._orderPets + 1] = orderPets[i]

				table.insert(tbRecommandIds, orderPets[i])
			else
				self._leavePets[#self._leavePets + 1] = orderPets[i]
			end
		elseif notRecommendNum > 0 and self._clubSystem:getHeroIsTired(orderPets[i], self._viewType) == false then
			self._orderPets[#self._orderPets + 1] = orderPets[i]
			notRecommendNum = notRecommendNum - 1
		else
			self._leavePets[#self._leavePets + 1] = orderPets[i]
		end
	end

	local sortType = self._stageSystem:getCardSortType()

	self._heroSystem:sortHeroes(self._orderPets, sortType, tbRecommandIds, false, nil)
end

function ClubBossTeamMediator:setupView()
	self:initLockIcons()
	self:refreshPetNode()
	self:refreshMasterInfo()
	self:initView()
	self:refreshListView()
	self:createSortView()
end

function ClubBossTeamMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._qipao = self:getView():getChildByFullName("qipao")

	self._qipao:setVisible(false)
	self._qipao:setLocalZOrder(100)

	self._touchPanel = self:getView():getChildByFullName("touchPanel")

	self._touchPanel:setVisible(false)

	self._bg = self:getView():getChildByFullName("main.bg")
	self._myPetPanel = self._main:getChildByFullName("my_pet_bg")
	self._heroPanel = self._myPetPanel:getChildByFullName("heroPanel")
	self._sortType = self._myPetPanel:getChildByFullName("sortPanel.sortBtn.text")
	self._sortOrder = self._myPetPanel:getChildByFullName("sortPanel.sortTypeBtn.text")
	self._masterImage = self._bg:getChildByName("role")
	self._teamBg = self._bg:getChildByName("team_bg")
	self._labelCombat = self._main:getChildByFullName("info_bg.combatLabel")
	self._costAverageTitleLabel = self._main:getChildByFullName("info_bg.text_prior")
	self._infoBtn = self._main:getChildByFullName("infoBtn")
	self._fightInfoTip = self._main:getChildByFullName("fightInfo")

	self._fightInfoTip:setVisible(false)

	self._costAverageLabel = self._main:getChildByFullName("info_bg.averageLabel")
	self._costTotalLabel = self._main:getChildByFullName("info_bg.text")
	self._costTotalLabel1 = self._main:getChildByFullName("info_bg.cost1")
	self._costTotalLabel2 = self._main:getChildByFullName("info_bg.cost2")
	self._movingPet = self._main:getChildByFullName("moving_pet")
	self._spPanel = self._main:getChildByName("spStagePanel")

	self._spPanel:setVisible(false)

	self._spBuffInfo = self._main:getChildByName("spBuffInfo")

	local buffInfo = self._spBuffInfo:getChildByName("buffInfo")

	buffInfo:setString(Strings:get("clubBoss_Tips"))

	self._teamBreakBtn = self._main:getChildByFullName("info_bg.button_one_key_break")
	self._teamOneKeyBtn = self._main:getChildByFullName("info_bg.button_one_key_embattle")
	self._costBtn = self._main:getChildByFullName("info_bg.costBtn")
	self._costTouch = self._main:getChildByFullName("info_bg.costTouch")

	self._costTouch:addClickEventListener(function()
		self:createCostTip()
	end)

	self._myPetClone = self:getView():getChildByName("myPetClone")

	self._myPetClone:setVisible(false)

	self._petSize = self._myPetClone:getChildByFullName("myPetClone"):getContentSize()
	self._teamPetClone = self:getView():getChildByName("teamPetClone")

	self._teamPetClone:setVisible(false)
	self._teamPetClone:setScale(0.64)
	self:setLabelEffect()
	self:ignoreSafeArea()
end

function ClubBossTeamMediator:ignoreSafeArea()
	AdjustUtils.ignorSafeAreaRectForNode(self._heroPanel, AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._myPetPanel:getChildByName("sortPanel"), AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._main:getChildByFullName("btnPanel"), AdjustUtils.kAdjustType.Right)

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._heroPanel:setContentSize(cc.size(winSize.width - 177, 220))
end

function ClubBossTeamMediator:createTeamCell(cell, index)
	local node = cell:getChildByTag(12138)

	node = node:getChildByFullName("myPetClone")

	node:setVisible(false)

	cell.id = nil

	if index == 1 then
		return
	end

	node:setVisible(true)

	local id = self._petListAll[index - 1]

	node.id = id
	cell.id = id

	node:setTouchEnabled(true)
	node:setSwallowTouches(false)
	node:addTouchEventListener(function(sender, eventType)
		self:onClickCell(sender, eventType, index)
	end)

	local heroInfo = self:getHeroInfoById(id)

	self:initHero(node, heroInfo)

	local detailBtn = node:getChildByFullName("detailBtn")

	detailBtn:addClickEventListener(function()
		local recommendData = self._clubSystem:checkIsRecommend(id, heroInfo, self._viewType)

		self:onClickHeroDetail(id, recommendData.attrAdds)
	end)
end

function ClubBossTeamMediator:setLabelEffect()
	local lineGradiantVec2 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(129, 118, 113, 255)
		}
	}

	self._labelCombat:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
end

function ClubBossTeamMediator:onClickCell(sender, eventType, index)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
		self._isOnTeam = false
	elseif eventType == ccui.TouchEventType.moved then
		local beganPos = sender:getTouchBeganPosition()
		local movedPos = sender:getTouchMovePosition()

		if self._isReturn and not self._isDrag then
			self._isDrag = self:checkCellTouchType(beganPos, movedPos)

			if self._isDrag and not self._isOnTeam then
				self:createMovingPet(sender, 2)
				self:changeMovingPetPos(beganPos)
				sender:setVisible(false)
				sender:setSwallowTouches(true)
			end
		elseif self._isDrag and not self._isOnTeam then
			self:changeMovingPetPos(movedPos)
		end
	elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
		sender:setVisible(true)
		sender:setSwallowTouches(false)

		if not self._isOnTeam then
			if not self._isDrag then
				local selectCanceled = self:isSelectCanceledByClick(sender.id)

				if self._isReturn and not selectCanceled then
					self:insertTeamPet(sender)
				end
			elseif self:checkIsInTeamArea() then
				self:changeOwnPet(sender)
			end
		end

		self._isDrag = false

		self:cleanMovingPet()
	end
end

function ClubBossTeamMediator:changeOwnPet(cell)
	local id = cell.id
	local targetIndex

	for i = 1, self._maxTeamPetNum do
		local iconBg = self._teamBg:getChildByName("pet_" .. i)

		if self:checkCollision(iconBg) then
			targetIndex = i

			break
		end
	end

	if not targetIndex then
		return
	end

	local iconBg = self._teamBg:getChildByName("pet_" .. targetIndex)
	local targetId = iconBg.id
	local selectCanceled = self:isSelectCanceledByDray(id, iconBg.id)

	if selectCanceled then
		return
	end

	self:playInsertEffect(id)
	AudioEngine:getInstance():playEffect("Se_Click_Pickup", false)

	if targetId then
		self._teamPets[targetIndex] = id

		local index = table.indexof(self._petList, id)

		if index then
			self._petList[index] = targetId
		end

		self:refreshPetNode()
		self:refreshListView()
	else
		local animId
		local index = table.indexof(self._petListAll, id)
		local cellIndex = table.indexof(self._petList, id)

		if cellIndex then
			table.remove(self._petList, cellIndex)
		end

		self._teamPets[#self._teamPets + 1] = id

		self:refreshPetNode()
		self:runInsertTeamAction(id)
		self:refreshListView()
		self:runInsertAction((index and self._petListAll[index + 1] or nil) and self._petListAll[index + 1])
	end
end

function ClubBossTeamMediator:insertTeamPet(cell, isDrag)
	local id = cell.id
	local animId
	local index = table.indexof(self._petListAll, id)

	if index and self._petListAll[index + 1] then
		animId = self._petListAll[index + 1]
	end

	for k, v in pairs(self._petList) do
		if v == id then
			table.remove(self._petList, k)
		end
	end

	self._teamPets[#self._teamPets + 1] = id

	self:refreshPetNode()
	self:playInsertEffect(id)
	AudioEngine:getInstance():playEffect("Se_Click_Pickup", false)

	if isDrag then
		self:runInsertTeamAction(id)
		self:refreshListView()
		self:runInsertAction(animId)

		return
	end

	self:runInsertTeamAction(cell.id)
	self:runInsertPetAction(cell, function()
		self:refreshListView()
		self:runInsertAction(animId)
	end)
end

function ClubBossTeamMediator:createMovingPet(cell, type)
	local petNode
	local heroInfo = self:getHeroInfoById(cell.id)

	if type == 1 then
		petNode = self._teamPetClone:clone()

		petNode:setVisible(true)
		self:initTeamHero(petNode, heroInfo)

		if cell:getChildByName("EmptyIcon") then
			cell:getChildByName("EmptyIcon"):setVisible(true)
		end
	elseif type == 2 then
		petNode = self._myPetClone:getChildByFullName("myPetClone"):clone()

		petNode:setVisible(true)
		self:initHero(petNode, heroInfo)
	end

	if petNode then
		self._movingPet:removeAllChildren()
		petNode:setAnchorPoint(cc.p(0.5, 0.5))
		petNode:addTo(self._movingPet):center(self._movingPet:getContentSize())
	end
end

function ClubBossTeamMediator:sortOnTeamPets()
	self._heroSystem:sortOnTeamPets(self._teamPets)
end

function ClubBossTeamMediator:onClickOnTeamPet(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		self._isOnOwn = false
	elseif eventType == ccui.TouchEventType.moved then
		local beganPos = sender:getTouchBeganPosition()
		local movedPos = sender:getTouchMovePosition()

		if not self._isDrag then
			self._isDrag = self:checkTouchType(beganPos, movedPos)

			if self._isDrag and not self._isOnOwn then
				self:createMovingPet(sender, 1)
				self:changeMovingPetPos(beganPos)

				if self._petNodeList[sender:getTag()] then
					self._petNodeList[sender:getTag()]:setVisible(false)
				end
			end
		elseif self._isDrag and not self._isOnOwn then
			self:changeMovingPetPos(movedPos)
		end
	elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
		if self._petNodeList[sender:getTag()] then
			self._petNodeList[sender:getTag()]:setVisible(true)
		end

		if not self._isOnOwn then
			if self._isDrag then
				local endPos = sender:getTouchEndPosition()

				if not self:checkIsInTeamArea(endPos) then
					self:removeTeamPet(sender:getTag())
				else
					self:changeTeamPet(sender:getTag(), endPos)
				end
			else
				self:removeTeamPet(sender:getTag())
			end
		end

		self._isDrag = false

		self:cleanMovingPet()
	end
end

function ClubBossTeamMediator:changeTeamPet(index, endPos)
	AudioEngine:getInstance():playEffect("Se_Click_Putdown", false)

	local iconBg = self._teamBg:getChildByName("pet_" .. index)

	if self:checkCollision(iconBg) then
		return
	end

	local targetIndex

	for i = 1, self._maxTeamPetNum do
		if index ~= i then
			iconBg = self._teamBg:getChildByName("pet_" .. i)

			if self:checkCollision(iconBg) then
				targetIndex = i

				break
			end
		end
	end

	if not targetIndex then
		return
	end

	local id = self._teamPets[index]
	local targetId = self._teamPets[targetIndex]

	if not targetId then
		table.remove(self._teamPets, index)

		self._teamPets[#self._teamPets + 1] = id
	else
		self._teamPets[index] = targetId
		self._teamPets[targetIndex] = id
	end

	self:refreshPetNode()

	for i = 1, self._maxTeamPetNum do
		if self._petNodeList[i] then
			local iconBg = self._teamBg:getChildByName("pet_" .. i)

			if iconBg:getChildByName("EmptyIcon") then
				iconBg:getChildByName("EmptyIcon"):setVisible(false)
			end
		end
	end
end

function ClubBossTeamMediator:removeTeamPet(index)
	AudioEngine:getInstance():playEffect("Se_Click_Putdown", false)

	local id = self._teamPets[index]
	local cellId = self:checkIsInOwnArea()

	if cellId then
		local idIndex = table.indexof(self._petList, cellId)
		local selectCanceled = self:isSelectCanceledByDray(cellId, id)

		if idIndex and not selectCanceled then
			table.remove(self._petList, idIndex)

			self._teamPets[index] = cellId
		else
			table.remove(self._teamPets, index)
		end
	else
		table.remove(self._teamPets, index)
	end

	self._petList[#self._petList + 1] = id

	if self._qipao:isVisible() and self._qipao.id == id then
		self._qipao:setVisible(false)

		if self._specialSound then
			AudioEngine:getInstance():stopEffect(self._specialSound)
		end
	end

	self:refreshListView()
	self:refreshPetNode()
	self:runRemoveAction(id)
	self:runRemovePetAction(id)
end

function ClubBossTeamMediator:refreshViewBySort()
	self:updateData()
	self:refreshMasterInfo()
	self:refreshListView()
	self:refreshPetNode()
end

function ClubBossTeamMediator:refreshView()
	self:initData()
	self:refreshMasterInfo()
	self:refreshListView()
	self:refreshPetNode()
	self._costBtn:setVisible(self:showCostBtn())
end

function ClubBossTeamMediator:refreshListView(ignoreAdjustOffset)
	self._petListAll = self._stageSystem:getSortExtendIds(self._petList)

	local sortType = self._stageSystem:getCardSortType()
	local tbRecommandIds = {}
	local tbTiredIds = {}

	for i = 1, #self._petListAll do
		if self._clubSystem:getIsRecommend(self._petListAll[i], self._viewType) then
			table.insert(tbRecommandIds, self._petListAll[i])
		end

		if self._clubSystem:getHeroIsTired(self._petListAll[i], self._viewType) then
			table.insert(tbTiredIds, self._petListAll[i])
		end
	end

	self._heroSystem:sortHeroes(self._petListAll, sortType, tbRecommandIds, false, tbTiredIds)

	if not self._ignoreReloadData then
		local offsetX = self._teamView:getContentOffset().x + self._petSize.width

		if offsetX > 0 then
			offsetX = 0
		end

		self._teamView:reloadData()

		if not ignoreAdjustOffset then
			self._teamView:setContentOffset(cc.p(offsetX, 0))
		end
	end

	self._ignoreReloadData = false
end

function ClubBossTeamMediator:initHero(node, info)
	local heroId = info.id

	super.initHero(self, node, info)

	local isShow = self._clubSystem:getIsRecommend(heroId, self._viewType)
	local effectNum = tonumber(self._clubSystem:getHeroEffectNum(heroId, self._viewType))
	local except = node:getChildByName("except")

	except:setVisible(isShow or effectNum > 0)

	local text = except:getChildByName("text")
	local textNum = except:getChildByName("textNum")
	local textNumEffect = except:getChildByName("textNumEffect")

	text:setVisible(isShow)

	if textNum then
		textNum:setVisible(isShow and effectNum > 0)
		textNum:setVisible(false)
		text:setString(Strings:get("clubBoss_46"))
		text:setColor(cc.c3b(255, 203, 63))
	end

	if textNumEffect then
		textNumEffect:setVisible(not isShow and effectNum > 0)
		textNumEffect:setString(Strings:get("LOGIN_UI13"))
		textNumEffect:setColor(cc.c3b(255, 255, 255))
	end

	if node:getChildByName("fatigueBg") then
		local isTired = self._clubSystem:getHeroIsTired(heroId, self._viewType)

		node:getChildByName("fatigueBg"):setCascadeColorEnabled(false)
		node:getChildByName("fatigueBg"):setVisible(isTired)
		node:setColor(isTired and cc.c3b(150, 150, 150) or cc.c3b(250, 250, 250))

		local fatigueTxt = node:getChildByName("fatigueBg"):getChildByName("fatigueTxt")

		if fatigueTxt then
			fatigueTxt:setString(Strings:get("clubBoss_49"))
		end

		if isTired then
			node:addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("clubBoss_heroTired")
					}))
				end
			end)
		end
	end

	local skillPanel = node:getChildByName("skillPanel")
	local skill = self._heroSystem:checkHasKeySkill(heroId)

	skillPanel:setVisible(not not skill)

	if skill then
		skillPanel:setVisible(true)
		skillPanel:setSwallowTouches(true)
		skillPanel:addClickEventListener(function()
			self:onClickHeroSkill(skill, skillPanel)
		end)

		if not skillPanel:getChildByName("KeyMark") then
			local skillType = skill:getType()
			local icon1, icon2 = self._heroSystem:getSkillTypeIcon(skillType)
			local image = ccui.ImageView:create(icon1)

			image:addTo(skillPanel):center(skillPanel:getContentSize())
			image:setName("KeyMark")
			image:setScale(0.85)
			image:offset(0, -5)
		end
	end
end

function ClubBossTeamMediator:refreshPetNode()
	self:refreshCombatAndCost()
	self:refreshButtons()
	self:checkMasterSkillActive()

	self._petNodeList = {}

	for i = 1, self._maxTeamPetNum do
		local iconBg = self._teamBg:getChildByName("pet_" .. i)

		iconBg:removeAllChildren()
		iconBg:setTag(i)
		iconBg:addTouchEventListener(function(sender, eventType)
			self:onClickOnTeamPet(sender, eventType)
		end)

		local emptyIcon = GameStyle:createEmptyIcon()

		emptyIcon:addTo(iconBg):center(iconBg:getContentSize())
		emptyIcon:setName("EmptyIcon")

		iconBg.id = nil

		local id = self._teamPets[i]

		if id then
			local heroInfo = self:getHeroInfoById(id)

			self._petNodeList[i] = self._teamPetClone:clone()

			self._petNodeList[i]:setVisible(true)

			self._petNodeList[i].id = id

			self:initTeamHero(self._petNodeList[i], heroInfo)
			self._petNodeList[i]:addTo(iconBg):center(iconBg:getContentSize())
			self._petNodeList[i]:offset(0, -9)
			iconBg:setTouchEnabled(true)

			iconBg.id = self._teamPets[i]

			if self._qipao:isVisible() and self._qipao.id == id then
				local targetPos = self._petNodeList[i]:getParent():convertToWorldSpace(cc.p(self._petNodeList[i]:getPosition()))

				targetPos = self._qipao:getParent():convertToNodeSpace(targetPos)

				self._qipao:setPosition(cc.p(targetPos.x - 50, targetPos.y + 60))
			end
		else
			iconBg:setTouchEnabled(false)
		end
	end
end

function ClubBossTeamMediator:initTeamHero(node, info)
	local heroId = info.id

	info.id = info.roleModel

	super.initTeamHero(self, node, info)

	local heroImg = IconFactory:createRoleIconSpriteNew(info)

	heroImg:setScale(0.68)

	local heroPanel = node:getChildByName("hero")

	heroPanel:removeAllChildren()
	heroPanel:addChild(heroImg)
	heroImg:setPosition(heroPanel:getContentSize().width / 2, heroPanel:getContentSize().height / 2)

	local bg1 = node:getChildByName("bg1")
	local bg2 = node:getChildByName("bg2")

	bg1:loadTexture(GameStyle:getHeroRarityBg(info.rareity)[1])
	bg2:loadTexture(GameStyle:getHeroRarityBg(info.rareity)[2])
	bg1:removeAllChildren()
	bg2:removeAllChildren()

	if kHeroRarityBgAnim[info.rareity] then
		local anim = cc.MovieClip:create(kHeroRarityBgAnim[info.rareity])

		anim:addTo(bg1):center(bg1:getContentSize())

		if info.rareity <= 14 then
			anim:offset(-1, -29)
		else
			anim:offset(-3, 0)
		end

		if info.rareity >= 14 then
			local anim = cc.MovieClip:create("ssrlizichai_yingxiongxuanze")

			anim:addTo(bg2):center(bg2:getContentSize()):offset(5, -20)
		end
	else
		local sprite = ccui.ImageView:create(GameStyle:getHeroRarityBg(info.rareity)[1])

		sprite:addTo(bg1):center(bg1:getContentSize())
	end

	local rarity = node:getChildByFullName("rarityBg.rarity")
	local rarityAnim = IconFactory:getHeroRarityAnim(info.rareity)

	rarityAnim:addTo(rarity):posite(25, 15)

	local isShow = self._clubSystem:getIsRecommend(heroId, self._viewType)
	local effectNum = tonumber(self._clubSystem:getHeroEffectNum(heroId, self._viewType))
	local exceptBg = node:getChildByName("except_bg")
	local textNumEffect = node:getChildByName("textNumEffect")

	textNumEffect:setVisible(effectNum > 0)
	exceptBg:setVisible(effectNum > 0)

	if textNumEffect then
		if isShow then
			textNumEffect:setString(Strings:get("clubBoss_46"))
			textNumEffect:setColor(cc.c3b(255, 203, 63))
		else
			textNumEffect:setString(Strings:get("LOGIN_UI13"))
			textNumEffect:setColor(cc.c3b(255, 255, 255))
		end
	end

	exceptBg:setContentSize(textNumEffect:getContentSize())

	local cost = node:getChildByFullName("costBg.cost")

	cost:setString(info.cost)

	local occupationName, occupationImg = GameStyle:getHeroOccupation(info.type)
	local occupation = node:getChildByName("occupation")

	occupation:loadTexture(occupationImg)

	local levelImage = node:getChildByFullName("levelImage")
	local levelLabel = node:getChildByFullName("level")

	levelLabel:setString(Strings:get("Strenghten_Text78", {
		level = info.level
	}))

	local levelImageWidth = levelImage:getContentSize().width
	local levelWidth = levelLabel:getContentSize().width

	levelImage:setScaleX((levelWidth + 40) / levelImageWidth)

	local skillPanel = node:getChildByName("skillPanel")
	local skill, condition = self._heroSystem:checkHasKeySkill(heroId)

	skillPanel:setVisible(not not skill)

	local dicengEff, shangcengEff

	if skill then
		skillPanel:setVisible(true)
		skillPanel:setSwallowTouches(true)
		skillPanel:addClickEventListener(function()
			self:onClickHeroSkill(skill, skillPanel, true)
		end)

		if not skillPanel:getChildByName("KeyMark") then
			local skillType = skill:getType()
			local icon1, icon2 = self._heroSystem:getSkillTypeIcon(skillType)
			local image = ccui.ImageView:create(icon1)

			dicengEff = cc.MovieClip:create("diceng_jinengjihuo")

			dicengEff:setAnchorPoint(0.5, 0.5)
			dicengEff:setScale(0.38)
			dicengEff:setVisible(false)

			shangcengEff = cc.MovieClip:create("shangceng_jinengjihuo")

			shangcengEff:setAnchorPoint(0.5, 0.5)
			shangcengEff:setScale(0.38)
			shangcengEff:setVisible(false)
			dicengEff:addTo(skillPanel):center(skillPanel:getContentSize()):offset(-1.5, -2)
			image:addTo(skillPanel):center(skillPanel:getContentSize())
			shangcengEff:addTo(skillPanel):center(skillPanel:getContentSize()):offset(-1.5, -2)
			image:setName("KeyMark")
			image:setScale(0.85)
			image:offset(0, -5)
		end

		local isActive = self._stageSystem:checkIsKeySkillActive(condition, self._teamPets, {
			masterId = self._curMasterId
		})

		skillPanel:setGray(not isActive)

		if dicengEff then
			dicengEff:setVisible(isActive)
		end

		if shangcengEff then
			shangcengEff:setVisible(isActive)
		end
	end
end

function ClubBossTeamMediator:refreshCombatAndCost()
	local leadConfig = self._masterSystem:getMasterCurLeadStageConfig(self._curMasterId)

	if leadConfig then
		if not leadConfig.LeadFightHero then
			local addPercent = 0
			local totalCombat = 0
			local totalCost = 0
			local averageCost = 0

			for k, v in pairs(self._teamPets) do
				local heroInfo = self._heroSystem:getHeroById(v)

				totalCost = totalCost + heroInfo:getCost()
				totalCombat = totalCombat + heroInfo:getSceneCombatByType(SceneCombatsType.kAll)
			end

			totalCombat = leadConfig and math.ceil((addPercent + 1) * totalCombat) or totalCombat

			local masterData = self._masterSystem:getMasterById(self._curMasterId)

			totalCombat = masterData and totalCombat + masterData:getCombat() or totalCombat
			self._costTotal = totalCost
			averageCost = #self._teamPets == 0 and 0 or math.floor(totalCost * 10 / #self._teamPets + 0.5) / 10

			self._labelCombat:setString(totalCombat)
			self._costAverageLabel:setString(averageCost)
			self._costAverageLabel:setPositionX(self._costAverageTitleLabel:getPositionX() + self._costAverageTitleLabel:getContentSize().width)
			self._costTotalLabel1:setString(self._costTotal)
			self._costTotalLabel2:setString("/" .. self._costMaxNum)

			local color = self._costTotal <= self._costMaxNum and cc.c3b(255, 255, 255) or cc.c3b(255, 65, 51)

			self._costTotalLabel1:setTextColor(color)
			self._costTotalLabel1:setPositionX(self._costTotalLabel:getPositionX() + self._costTotalLabel:getContentSize().width)
			self._costTotalLabel2:setPositionX(self._costTotalLabel1:getPositionX() + self._costTotalLabel1:getContentSize().width)
			self._infoBtn:setVisible(leadConfig ~= nil and addPercent > 0)
			self._infoBtn:addTouchEventListener(function(sender, eventType)
				self:onClickInfo(eventType)
			end)
		end
	end
end

function ClubBossTeamMediator:changeMasterId(event)
	self._oldMasterId = self._curMasterId
	self._curMasterId = event:getData().masterId

	self:refreshMasterInfo()
	self:checkMasterSkillActive()
	self:refreshPetNode()
end

function ClubBossTeamMediator:refreshMasterInfo()
	local masterData = self._masterSystem:getMasterById(self._curMasterId)

	self._masterBtn:setVisible(self._showChangeMaster)
	self._masterImage:setVisible(true)
	self._masterImage:removeAllChildren()
	self._masterImage:addChild(masterData:getHalfImage())
	self:refreshCombatAndCost()
	self:refreshButtons()
end

function ClubBossTeamMediator:refreshButtons()
	self._teamBreakBtn:setVisible(self:checkButtonVisible())
	self._teamOneKeyBtn:setVisible(not self:checkButtonVisible())
end

function ClubBossTeamMediator:checkButtonVisible()
	if #self._teamPets < self._maxTeamPetNum then
		return false
	end

	return true
end

function ClubBossTeamMediator:checkToExit()
	if #self._teamPets < 1 then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("ARENA_TEMA_EMPTY")
		}))

		return false
	end

	return true
end

function ClubBossTeamMediator:hasChangeTeam()
	if self._oldMasterId ~= self._curMasterId then
		return true
	end

	local tempTab = {}

	for k, v in pairs(self._tempTeams) do
		tempTab[v] = k
	end

	for k, v in pairs(self._teamPets) do
		if not tempTab[v] then
			return true
		end
	end

	return false
end

function ClubBossTeamMediator:sendSpChangeTeam(callBack)
	local sendData = {}

	for k, v in pairs(self._teamPets) do
		sendData[k] = v
	end

	local params = {
		masterId = self._curMasterId,
		heros = sendData
	}

	params.activityId = self._viewType == ClubHallType.kActivityBoss and self._clubSystem:getClubBossSummerActivityID() or ""

	local hasChange = self:hasChangeTeam()

	self._clubSystem:requestUpdateTeam(params, function()
		if DisposableObject:isDisposed(self) then
			return
		end

		if hasChange then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Team_StorageSuccessTips")
			}))
		end

		if callBack then
			callBack()
		end
	end, false, {
		ignoreTip = true
	})
end

function ClubBossTeamMediator:onClickRule()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_Order_Rule", "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule
	}))
end

function ClubBossTeamMediator:onClickOneKeyBreak()
	self._teamView:stopScroll()

	local ids = self._heroSystem:getTeamPrepared(self._teamPets, self._petList)

	self._teamPets = {}
	self._petList = {}

	table.copy(ids, self._petList)
	self:refreshListView(true)
	self:refreshPetNode()
end

function ClubBossTeamMediator:onClickBack()
	local function func()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		storyDirector:notifyWaiting("exit_ClubBossTeamMediator")
		self:dispatch(Event:new(EVT_CLUBBOSS_BACKMAINVIEW, {
			viewType = self._viewType
		}))
		self:dismiss()
	end

	if self._clubSystem:checkIsAllHeroIsTired(self._viewType) then
		func()

		return
	end

	if self:checkToExit() then
		self:sendSpChangeTeam(func)
	end
end

function ClubBossTeamMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local oneKeyBtn = self:getView():getChildByFullName("main.info_bg.button_one_key_embattle")

	if oneKeyBtn then
		storyDirector:setClickEnv("ClubBossTeamMediator.OneKeyBtn", oneKeyBtn, function(sender, eventType)
			AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
			self:onClickOneKeyEmbattle()
		end)
	end

	local btnBack = self:getView():getChildByFullName("topinfo_node.back_btn")

	storyDirector:setClickEnv("ClubBossTeamMediator.btnBack", btnBack, function(sender, eventType)
		AudioEngine:getInstance():playEffect("Se_Click_Close_1", false)
		self:onClickBack()
	end)

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		storyDirector:notifyWaiting("enter_ClubBossTeamMediator")
	end))

	oneKeyBtn:runAction(sequence)
end

function ClubBossTeamMediator:onForcedLevel(event)
	self:dismiss()
end

function ClubBossTeamMediator:doBossKilledLogic(event)
	local data = event:getData()

	if data and data.viewType ~= self._viewType then
		return
	end

	self:dispatch(Event:new(EVT_CLUBBOSS_BACKMAINVIEW, {
		viewType = self._viewType
	}))
	self:dismiss()
end
