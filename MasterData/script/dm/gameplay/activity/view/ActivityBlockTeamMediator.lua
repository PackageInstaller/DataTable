-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityBlockTeamMediator.lua

require("dm.gameplay.stage.view.CommonTeamMediator")

ActivityBlockTeamMediator = class("ActivityBlockTeamMediator", CommonTeamMediator, _M)

ActivityBlockTeamMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
ActivityBlockTeamMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityBlockTeamMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
ActivityBlockTeamMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.info_bg.costBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickCost"
	},
	["main.left.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickCardsTurnLeft"
	},
	["main.right.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickCardsTurnRight"
	},
	["main.spStagePanel.ruleBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	}
}
local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}

function ActivityBlockTeamMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._fightBtn = self:bindWidget("main.btnPanel.fightBtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onClickFight, self)
		}
	})
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
	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_TEAM_CHANGE_MASTER, self, self.changeMasterId)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TEAM_REFRESH_PETS, self, self.refreshViewBySort)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHANGE_TEAM_BYMODE_SUCC, self, self.changeTeamByMode)
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

function ActivityBlockTeamMediator:doReset()
	local model = self._activitySystem:getActivityById(self._activityId)

	if not model then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return true
	end

	if model.getBlockMapActivity then
		local activity = model:getBlockMapActivity()

		if not activity then
			self:onClickBack()

			return true
		end

		if model:getType() == ActivityType.KWorldBoss then
			self:refreshViewBySort()
		end
	end
end

function ActivityBlockTeamMediator:enterWithData(data)
	data = data or {}
	self._data = data
	self._activityId = self._data.activityId
	self._activityModel = self._activitySystem:getActivityById(self._activityId)
	self._uiType = self._activityModel:getUI()
	self._activity = self._data.activity
	self._param = self._data.param or {}

	if self._param and self._param.pointId then
		self._pointId = self._param.pointId or nil
	end

	self._cardsExcept = {}
	self._cardsRecommend, self._maxCardsRecommend = self._activitySystem:getRecommendHeroes(self._activity)
	self._masterList = self._masterSystem:getShowMasterList()
	self._canChange = true

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

	self._hasForceChangeTeam = false
	self._ignoreReloadData = true

	self:initData()
	self:setupTopInfoWidget()
	self:initWidgetInfo()
	self:createCardsGroupName()
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
	end, delayTime)
	self._costBtn:setVisible(self:showCostBtn())
end

function ActivityBlockTeamMediator:resumeWithData()
	local quit = self:doReset()

	if quit then
		return
	end

	super.resumeWithData(self)
	self._costBtn:setVisible(self:showCostBtn())

	self._costMaxNum = self._stageSystem:getCostInit() + self._developSystem:getBuildingCostEffValue()

	self._costTotalLabel2:setString("/" .. self._costMaxNum)
end

function ActivityBlockTeamMediator:getOwnMasterId(pointid)
	local masterid = ConfigReader:getDataByNameIdAndKey("ActivityBlockPoint", pointid, "Master")

	if masterid ~= "" then
		return masterid
	end

	return nil
end

function ActivityBlockTeamMediator:getOwnMasterRoleModel(masterid)
	return (ConfigReader:getDataByNameIdAndKey("EnemyMaster", masterid, "RoleModel"))
end

function ActivityBlockTeamMediator:initData(team)
	self._curTeam = team and team or self._activity:getTeam()

	local modelTmp = {
		_heroes = self:removeExceptHeros(),
		_masterId = self._curTeam:getMasterId()
	}

	self._heroes = modelTmp._heroes
	self._curMasterId = modelTmp._masterId

	local ownMasterId = self:getOwnMasterId(self._pointId)

	if ownMasterId then
		self._curMasterId = ownMasterId
		self._showChangeMaster = false
	end

	if self._curMasterId == "" or self._curMasterId == 0 then
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

	self._nowName = self._curTeam:getName()
	self._petList = self._stageSystem:getNotOnTeamPet(self._teamPets)
	self._petListAll = {}

	table.copy(self._petList, {})
	self:initAssistData()
end

function ActivityBlockTeamMediator:updateData()
	self._petList = self._stageSystem:getNotOnTeamPet(self._teamPets)
	self._petListAll = {}

	table.copy(self._petList, {})
end

function ActivityBlockTeamMediator:removeExceptHeros()
	local heros = self._curTeam:getHeroes()
	local showHeros = {}

	for i = 1, #heros do
		local isExcept = self._stageSystem:isHeroExcept(self._cardsExcept, heros[i])

		if not isExcept then
			showHeros[#showHeros + 1] = heros[i]
		end
	end

	return showHeros
end

function ActivityBlockTeamMediator:showOneKeyHeros()
	local orderPets = self._heroSystem:getTeamPrepared(self._teamPets, self._petList, self._cardsRecommend, self._maxCardsRecommend)

	self._orderPets = {}
	self._leavePets = {}

	for i = 1, #orderPets do
		local isExcept = self._stageSystem:isHeroExcept(self._cardsExcept, orderPets[i])

		if #self._orderPets < self._maxTeamPetNum and not isExcept and not table.indexof(self._assistHero, orderPets[i]) then
			self._orderPets[#self._orderPets + 1] = orderPets[i]
		else
			self._leavePets[#self._leavePets + 1] = orderPets[i]
		end
	end
end

function ActivityBlockTeamMediator:setupView()
	self:initLockIcons()
	self:initAssistView()
	self:refreshPetNode()
	self:refreshMasterInfo()
	self:initView()
	self:refreshListView()
	self:createSortView()
	self:showSetButton(true)
end

function ActivityBlockTeamMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._qipao = self:getView():getChildByFullName("qipao")

	self._qipao:setVisible(false)
	self._qipao:setLocalZOrder(100)

	self._touchPanel = self:getView():getChildByFullName("touchPanel")

	self._touchPanel:setVisible(false)

	self._bg = self:getView():getChildByFullName("main.bg")
	self._teamTurnLeft = self._main:getChildByName("left")
	self._teamTurnRight = self._main:getChildByName("right")

	self._teamTurnLeft:setVisible(false)
	self._teamTurnRight:setVisible(false)

	self._myPetPanel = self._main:getChildByFullName("my_pet_bg")
	self._heroPanel = self._myPetPanel:getChildByFullName("heroPanel")
	self._sortType = self._myPetPanel:getChildByFullName("sortPanel.sortBtn.text")
	self._masterImage = self._bg:getChildByName("role")
	self._teamBg = self._bg:getChildByName("team_bg")
	self._labelCombat = self._main:getChildByFullName("info_bg.combatLabel")
	self._infoBtn = self._main:getChildByFullName("infoBtn")
	self._fightInfoTip = self._main:getChildByFullName("fightInfo")

	self._fightInfoTip:setVisible(false)

	self._costAverageLabel = self._main:getChildByFullName("info_bg.averageLabel")
	self._costTotalLabel1 = self._main:getChildByFullName("info_bg.cost1")
	self._costTotalLabel2 = self._main:getChildByFullName("info_bg.cost2")
	self._movingPet = self._main:getChildByFullName("moving_pet")
	self._spPanel = self._main:getChildByName("spStagePanel")

	self._spPanel:setVisible(false)

	local spRuleLabel = self._spPanel:getChildByFullName("ruleLabel")

	GameStyle:setCommonOutlineEffect(spRuleLabel)

	self._btnPanel = self._main:getChildByName("btnPanel")
	self._teamBreakBtn = self._main:getChildByFullName("info_bg.button_one_key_break")
	self._teamOneKeyBtn = self._main:getChildByFullName("info_bg.button_one_key_embattle")
	self._costTouch = self._main:getChildByFullName("info_bg.costTouch")

	self._costTouch:addClickEventListener(function()
		self:createCostTip()
	end)

	self._costBtn = self._main:getChildByFullName("info_bg.costBtn")
	self._myPetClone = self:getView():getChildByName("myPetClone")

	self._myPetClone:setVisible(false)

	self._petSize = self._myPetClone:getChildByFullName("myPetClone"):getContentSize()
	self._teamPetClone = self:getView():getChildByName("teamPetClone")

	self._teamPetClone:setVisible(false)
	self._teamPetClone:setScale(0.64)
	self._myPetClone:getChildByFullName("myPetClone.fatigueBg"):setVisible(false)

	self._pageTipPanel = self._main:getChildByFullName("pageTipPanel")

	self._pageTipPanel:removeAllChildren()
	self:setLabelEffect()
	self:checkStageType()
	self:ignoreSafeArea()
end

function ActivityBlockTeamMediator:ignoreSafeArea()
	AdjustUtils.ignorSafeAreaRectForNode(self._heroPanel, AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._myPetPanel:getChildByName("sortPanel"), AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._main:getChildByFullName("btnPanel"), AdjustUtils.kAdjustType.Right)
	AdjustUtils.ignorSafeAreaRectForNode(self._spPanel:getChildByFullName("combatBg"), AdjustUtils.kAdjustType.Right)

	local director = cc.Director:getInstance()

	self._winSize = director:getWinSize()

	self._heroPanel:setContentSize(cc.size(self._winSize.width, 220))
end

function ActivityBlockTeamMediator:createTeamCell(cell, index)
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

	local isExcept = self._stageSystem:isHeroExcept(self._cardsExcept, id)

	node:setTouchEnabled(not isExcept)
	node:setSwallowTouches(false)
	node:addTouchEventListener(function(sender, eventType)
		self:onClickCell(sender, eventType, index)
	end)

	local heroInfo = self:getHeroInfoById(id)

	self:initHero(node, heroInfo)

	local detailBtn = node:getChildByFullName("detailBtn")

	detailBtn:addClickEventListener(function()
		self:onClickHeroDetail(id)
	end)
	self:initAssistHero(node, heroInfo)
end

function ActivityBlockTeamMediator:checkStageType()
	if self._activity:getType() ~= ActivityType.KWorldBoss then
		self._spPanel:setVisible(true)
		self._spPanel:getChildByName("ruleBtn"):setVisible(true)

		local ruleBtn = self._spPanel:getChildByFullName("ruleBtn")
		local spRuleLabel = self._spPanel:getChildByFullName("ruleLabel")

		spRuleLabel:setString(Strings:get("ActivityBlock_UI_2"))
	end
end

function ActivityBlockTeamMediator:setLabelEffect()
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

function ActivityBlockTeamMediator:createCardsGroupName()
	local nameDi = self._main:getChildByName("nameBg")

	self._editBox = nameDi:getChildByFullName("TextField")
	self._teamName = nameDi:getChildByFullName("teamName")

	self._teamName:setVisible(false)

	self._nowName = self._curTeam:getName()

	self._teamName:setString(self._nowName)
	nameDi:getChildByFullName("nameBtn"):setVisible(false)

	local maxLength = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Team_Name_MaxWords", "content")

	if self._editBox:getDescription() == "TextField" then
		self._editBox:setMaxLength(maxLength)
		self._editBox:setMaxLengthEnabled(true)
		self._editBox:setTouchAreaEnabled(false)
		self._editBox:setString(self._nowName)
	end
end

function ActivityBlockTeamMediator:onClickCell(sender, eventType, index)
	local isMovePetSucc = false

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

		if self._guildCallback and not self._isDrag then
			self._isOnTeam = true
		end

		if not self._isOnTeam then
			if not self._isDrag then
				local selectCanceled = self:isSelectCanceledByClick(sender.id)

				if self._isReturn and not selectCanceled then
					self:insertTeamPet(sender)
				end
			elseif self:checkIsInTeamArea() then
				self:changeOwnPet(sender)

				isMovePetSucc = true
			end
		end

		self._isDrag = false

		self:cleanMovingPet()
	end

	return isMovePetSucc
end

function ActivityBlockTeamMediator:changeOwnPet(cell)
	local id = cell.id
	local targetIndex

	for i = 1, self._maxTeamPetNum do
		if self:checkCollision(self:getPetNode(i)) then
			targetIndex = i

			break
		end
	end

	if not targetIndex then
		return
	end

	if self._guildCallback and targetIndex ~= 2 then
		return
	end

	local iconBg = self:getPetNode(targetIndex)
	local targetId = iconBg.id
	local selectCanceled = self:isSelectCanceledByDray(id, targetId)

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

	if self._guildCallback then
		self._guildCallback()
	end
end

function ActivityBlockTeamMediator:insertTeamPet(cell, isDrag)
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

function ActivityBlockTeamMediator:createMovingPet(cell, type)
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

function ActivityBlockTeamMediator:sortOnTeamPets()
	self._heroSystem:sortOnTeamPets(self._teamPets)
end

function ActivityBlockTeamMediator:onClickOnTeamPet(sender, eventType)
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

		self:removeTeamPet(sender:getTag())

		self._isDrag = false

		self:cleanMovingPet()
	end
end

function ActivityBlockTeamMediator:removeTeamPet(index)
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

function ActivityBlockTeamMediator:refreshViewBySort()
	self:updateData()
	self:refreshMasterInfo()
	self:refreshListView()
	self:refreshPetNode()
end

function ActivityBlockTeamMediator:refreshView()
	self:initData()
	self:refreshMasterInfo()
	self:refreshListView()
	self:refreshPetNode()
	self._costBtn:setVisible(self:showCostBtn())
end

function ActivityBlockTeamMediator:refreshListView(ignoreAdjustOffset)
	self._petListAll = self._stageSystem:getSortExtendIds(self._petList)

	local sortType = self._stageSystem:getCardSortType()

	self._heroSystem:sortHeroes(self._petListAll, sortType, self._cardsRecommend, nil, nil, nil, nil, self._maxCardsRecommend)
	self:sortAssistHero(self._petListAll)

	if table.nums(self._cardsExcept) > 0 then
		local heros1 = {}
		local heros2 = {}

		for i = 1, #self._petListAll do
			local isExcept = self._stageSystem:isHeroExcept(self._cardsExcept, self._petListAll[i])

			if isExcept then
				heros2[#heros2 + 1] = self._petListAll[i]
			else
				heros1[#heros1 + 1] = self._petListAll[i]
			end
		end

		self._petListAll = {}

		table.copy(heros1, self._petListAll)

		for i = 1, #heros2 do
			self._petListAll[#self._petListAll + 1] = heros2[i]
		end
	end

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

function ActivityBlockTeamMediator:initHero(node, info)
	local heroId = info.id

	super.initHero(self, node, info)
	node:getChildByName("rarityBg"):setLocalZOrder(1)
	node:getChildByName("costBg"):setLocalZOrder(1)

	local exceptMark = node:getChildByName("except")

	exceptMark:setVisible(false)

	if self._stageSystem:isHeroExcept(self._cardsExcept, heroId) then
		exceptMark:setVisible(true)
	end

	local recommond = node:getChildByName("recommond")

	if recommond then
		recommond:setVisible(false)
	end

	node:removeChildByName("AttrAddMark")

	local recommendData = self._activitySystem:checkIsRecommend(heroId, self._activity)

	if recommendData.isRecommend then
		if recommendData.showType == "recommend" then
			if recommond then
				recommond:setVisible(true)

				local text = recommond:getChildByFullName("text")

				text:setString(recommendData.desc)

				if recommendData.color then
					text:setTextColor(recommendData.color)
				end
			end
		else
			local pos = {
				x = exceptMark:getPositionX(),
				y = exceptMark:getPositionY()
			}

			self:createAttrAddMark(node, pos)
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

function ActivityBlockTeamMediator:createAttrAddMark(node, pos)
	local image = ccui.ImageView:create("asset/common/hd_ygdmh_biandui_upbg.png")

	image:addTo(node)
	image:setName("AttrAddMark")
	image:setLocalZOrder(0)
	image:setPosition(cc.p(pos.x, pos.y + 5))

	local text = cc.Label:createWithTTF(Strings:get("ActivityBlock_UI_15"), TTF_FONT_FZYH_M, 24)

	text:addTo(image):center(image:getContentSize()):offset(0, 3)
	text:setName("AttrAddLabel")
	text:enableOutline(cc.c4b(1, 71, 0, 255), 1)

	local lineGradiantVec2 = {
		{
			ratio = 0,
			color = cc.c4b(255, 253, 147, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(179, 255, 0, 255)
		}
	}

	text:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))

	return image
end

function ActivityBlockTeamMediator:refreshPetNode()
	self:refreshCombatAndCost()
	self:refreshButtons()
	self:sortOnTeamPets()
	self:checkMasterSkillActive()

	self._petNodeList = {}

	for i = 1, self._maxTeamPetNum do
		local iconBg = self:getPetNode(i)

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

function ActivityBlockTeamMediator:initTeamHero(node, info)
	local heroId = info.id

	super.initTeamHero(self, node, info)

	local heroImg = IconFactory:createRoleIconSpriteNew({
		id = info.roleModel
	})

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

	local recommond = node:getChildByName("recommond")

	if recommond then
		recommond:setVisible(false)
	end

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

		if dicengEff then
			dicengEff:setVisible(isActive)
		end

		if shangcengEff then
			shangcengEff:setVisible(isActive)
		end

		skillPanel:setGray(not isActive)
	end

	node:getChildByName("rarityBg"):setLocalZOrder(1)
	node:getChildByName("costBg"):setLocalZOrder(1)
	node:removeChildByName("AttrAddMark")

	local recommendData = self._activitySystem:checkIsRecommend(heroId, self._activity)

	if recommendData.isRecommend then
		if recommendData.showType == "recommend" then
			if recommond then
				recommond:setVisible(true)

				local text = recommond:getChildByFullName("text")

				text:setString(recommendData.desc)

				if recommendData.color then
					text:setTextColor(recommendData.color)
				end

				recommond:setContentSize(text:getContentSize())
				text:setPosition(cc.p(recommond:getContentSize().width / 2, recommond:getContentSize().height / 2 + 3))
			end
		else
			local pos = {
				x = 97,
				y = 182
			}
			local image = self:createAttrAddMark(node, pos, recommendData)

			image:getChildByName("AttrAddLabel"):setScale(1.2)
			image:getChildByName("AttrAddLabel"):offset(0, -5)
		end
	end
end

function ActivityBlockTeamMediator:onClickMasterSkill()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local params = {
		masterId = self._curMasterId,
		active = self._skillActive
	}
	local ownMasterId = self:getOwnMasterId(self._pointId)

	if ownMasterId then
		params.ownSkills = self._ownerSkillList
		params.ownMasterRoleModel = self._ownMasterRoleModel
	end

	local view = self:getInjector():getInstance("MasterLeaderSkillView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, params))
end

function ActivityBlockTeamMediator:checkMasterSkillActive()
	local ownMasterId = self:getOwnMasterId(self._pointId)

	if ownMasterId then
		local kConditonKey = {
			TeamSkill5 = "TeamSkillCondition5",
			TeamSkill4 = "TeamSkillCondition4",
			TeamSkill6 = "TeamSkillCondition6",
			TeamSkill3 = "TeamSkillCondition3",
			TeamSkill2 = "TeamSkillCondition2",
			TeamSkill1 = "TeamSkillCondition1"
		}

		self._masterSkillPanel:removeAllChildren()

		self._skillActive = {}

		local masterConfig = ConfigReader:getRecordById("MasterBase", tostring("Master_LiMing"))
		local skillShowType = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Master_TeamSkillShow", "content")

		self._skillIndex = {}
		self._skills = {}

		for i = 1, #skillShowType do
			local skillId = masterConfig[skillShowType[i]]
			local conditionKey = kConditonKey[skillShowType[i]]
			local condition = masterConfig[conditionKey]

			if skillId and skillId ~= "" then
				table.insert(self._skillIndex, skillId)

				self._skills[skillId] = MasterSkill:new(skillId)

				self._skills[skillId]:createAttrEffect(self, self._player, AttrSystemName.kMasterSkill)
				self._skills[skillId]:setActiveCondition(condition)
			end
		end

		local skills = {}

		for k, v in pairs(self._skills) do
			skills[#skills + 1] = v
		end

		self._ownerSkillList = skills

		for i = 1, #skills do
			local skill = skills[i]
			local skillId = skill:getId()
			local info = {
				levelHide = true,
				id = skillId,
				skillType = skill:getSkillType()
			}
			local newSkillNode = IconFactory:createMasterSkillIcon(info)

			newSkillNode:setScale(0.36)
			self._masterSkillPanel:addChild(newSkillNode, 2)

			local index = i <= 3 and i or i - 3
			local posX = 20 + (index - 1) * 55
			local posY = i <= 3 and 61 or 10

			newSkillNode:setPosition(cc.p(posX, posY))

			local conditions = skill:getActiveCondition()
			local isActive = self._stageSystem:checkIsKeySkillActive(conditions, self._teamPets, {
				masterId = self._curMasterId
			})

			newSkillNode:setGray(not isActive)

			if isActive then
				self._skillActive[i] = true

				local shangceng = cc.MovieClip:create("shangceng_jinengjihuo")

				shangceng:addTo(newSkillNode)
				shangceng:setPosition(cc.p(46.5, 46.5))
				shangceng:setScale(1.42)
			else
				newSkillNode:setGray(true)

				self._skillActive[i] = false
			end
		end
	else
		super.checkMasterSkillActive(self)
	end
end

function ActivityBlockTeamMediator:refreshCombatAndCost()
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
			self._costTotalLabel1:setString(self._costTotal)

			local color = self._costTotal <= self._costMaxNum and cc.c3b(255, 255, 255) or cc.c3b(255, 65, 51)

			self._costTotalLabel1:setTextColor(color)
			self._costTotalLabel2:setString("/" .. self._costMaxNum)
			self._costTotalLabel2:setPositionX(self._costTotalLabel1:getPositionX() + self._costTotalLabel1:getContentSize().width)
			self._infoBtn:setVisible(leadConfig ~= nil and addPercent > 0)
			self._infoBtn:addTouchEventListener(function(sender, eventType)
				self:onClickInfo(eventType)
			end)
		end
	end
end

function ActivityBlockTeamMediator:changeMasterId(event)
	self._oldMasterId = self._curMasterId
	self._curMasterId = event:getData().masterId

	self:refreshMasterInfo()
	self:checkMasterSkillActive()
	self:refreshPetNode()
end

function ActivityBlockTeamMediator:getMasterName(masterid)
	return Strings:get(ConfigReader:getDataByNameIdAndKey("MasterBase", masterid, "Name"))
end

function ActivityBlockTeamMediator:refreshMasterInfo()
	local ownMasterId = self:getOwnMasterId(self._pointId)

	if ownMasterId then
		local roleModel = self:getOwnMasterRoleModel(ownMasterId)
		local sprite = IconFactory:createRoleIconSpriteNew({
			frameId = "bustframe6_3",
			id = roleModel
		})

		sprite:setAnchorPoint(cc.p(0, 0))
		self._masterImage:addChild(sprite)

		self._ownMasterRoleModel = roleModel
	else
		local masterData = self._masterSystem:getMasterById(self._curMasterId)

		self._masterImage:removeAllChildren()
		self._masterImage:addChild(masterData:getHalfImage())
	end

	self._masterBtn:setVisible(self._showChangeMaster)
	self._masterImage:setVisible(true)
	self:refreshCombatAndCost()
	self:refreshButtons()
	self:setLeadStageInfo()
end

function ActivityBlockTeamMediator:refreshButtons()
	self._teamBreakBtn:setVisible(self:checkButtonVisible())
	self._teamOneKeyBtn:setVisible(not self:checkButtonVisible())
end

function ActivityBlockTeamMediator:checkButtonVisible()
	if #self._teamPets < self._maxTeamPetNum then
		for i = 1, #self._petList do
			local isExcept = self._stageSystem:isHeroExcept(self._cardsExcept, self._petList[i])

			if not isExcept then
				return false
			end
		end
	end

	return true
end

function ActivityBlockTeamMediator:checkToExit(func, isIgnore, translateId)
	if #self._teamPets < 1 then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("ARENA_TEMA_EMPTY")
		}))

		return false
	end

	self:sendChangeTeam(func)

	return false
end

function ActivityBlockTeamMediator:getSendData()
	local sendData = {}
	local hasHero = false

	for k, v in pairs(self._teamPets) do
		table.insert(sendData, v)

		hasHero = true
	end

	local masterId = self._curMasterId

	if self:getOwnMasterId(self._pointId) then
		masterId = self._developSystem:getStageTeamById(1):getMasterId()
	end

	if not hasHero then
		table.insert(sendData, {})
	end

	return {
		masterId = masterId,
		heroes = sendData
	}
end

function ActivityBlockTeamMediator:hasChangeTeam()
	if self._oldMasterId ~= self._curMasterId then
		return true
	end

	if #self._tempTeams ~= #self._teamPets then
		return true
	end

	if #self._tempTeams ~= #self._heroes then
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

function ActivityBlockTeamMediator:sendChangeTeam(callBack)
	local hasChange = self:hasChangeTeam()
	local params = self:getSendData()

	local function callback1(response)
		if checkDependInstance(self) then
			if hasChange or self._hasForceChangeTeam then
				self:dispatch(Event:new(EVT_ARENA_CHANGE_TEAM_SUCC))
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Team_StorageSuccessTips")
				}))
			end

			if callBack then
				callBack()
			end
		end
	end

	if self._activity:getType() == ActivityType.KWorldBoss then
		params.doActivityType = self._param.doActivityType

		self._activitySystem:requestDoActivity(self._activityId, params, callback1)
	else
		params.doActivityType = "101"

		self._activitySystem:requestDoChildActivity(self._activityId, self._activity:getId(), params, callback1)
	end
end

function ActivityBlockTeamMediator:onClickRule()
	local rules = self._activity:getActivityConfig().BonusHeroDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivityBlockTeamMediator:onClickOneKeyBreak()
	self._teamView:stopScroll()

	local ids = self._heroSystem:getTeamPrepared(self._teamPets, self._petList, self._cardsRecommend, self._maxCardsRecommend)

	self._teamPets = {}
	self._petList = {}

	table.copy(ids, self._petList)
	self:refreshListView(true)
	self:refreshPetNode()
end

function ActivityBlockTeamMediator:onClickBack(sender, eventType, onClickFightCallback)
	local function func()
		if onClickFightCallback then
			onClickFightCallback()
		else
			self:dismiss()
		end
	end

	if self:checkToExit(func, false, "Stage_Team_UI10") then
		func()
	end
end

local assitEnemyTag = 100

function ActivityBlockTeamMediator:getPetNode(idx)
	return self._teamBg:getChildByName("pet_" .. idx + self._presetTeamPetNum)
end

function ActivityBlockTeamMediator:initAssistData()
	local showNpcTeam = self._activityModel:getActivityConfig().ShowNpcTeam
	local pointData = self._activity:getPointById(self._pointId)

	if not pointData or not showNpcTeam then
		self._assistEnemy = {}
		self._presetTeamPetNum = 0
		self._assistHero = {}

		return
	end

	self._assistEnemy = pointData and pointData:getAssistEnemy() or {}
	self._presetTeamPetNum = #self._assistEnemy
	self._maxTeamPetNum = self._maxTeamPetNum - self._presetTeamPetNum
	self._assistHero = pointData and pointData:getAssistHero() or {}

	for i, id in ipairs(self._assistHero) do
		local idx = table.indexof(self._teamPets, id)

		if idx then
			table.remove(self._teamPets, idx)
			table.remove(self._tempTeams, idx)
		end
	end

	for idx = self._maxTeamPetNum + 1, #self._teamPets do
		table.remove(self._teamPets, idx)
		table.remove(self._tempTeams, idx)
	end
end

function ActivityBlockTeamMediator:initAssistView()
	for i, enemyId in ipairs(self._assistEnemy) do
		local enemyData = self._activity:getAssistEnemyInfo(enemyId)

		if enemyData then
			local iconBg = self._teamBg:getChildByName("pet_" .. i)

			iconBg:removeAllChildren()
			iconBg:setTag(assitEnemyTag + i)
			iconBg:addTouchEventListener(function(sender, eventType)
				self:onClickOnTeamEnemy(sender, eventType)
			end)

			local emptyIcon = GameStyle:createEmptyIcon()

			emptyIcon:addTo(iconBg):center(iconBg:getContentSize())
			emptyIcon:setName("EmptyIcon")

			iconBg.id = enemyId

			local node = self._teamPetClone:clone()

			node:setVisible(true)

			node.id = enemyId

			self:initTeamHero(node, enemyData)
			node:addTo(iconBg):center(iconBg:getContentSize())
			node:offset(0, -9)
			iconBg:setTouchEnabled(true)

			local flag = ccui.ImageView:create("asset/common/kazu_bg_yuan.png", ccui.TextureResType.localType)

			flag:addTo(node):offset(94, 182)
		end
	end

	self._btnPanel:setVisible(self._pointId and true or false)
	self._heroPanel:setContentSize(cc.size((self._pointId or nil) and (self._winSize.width - 177 or self._winSize.width), 220))
end

function ActivityBlockTeamMediator:onClickOnTeamEnemy(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("DreamChallenge_Team_Helper_Info")
		}))
	end
end

function ActivityBlockTeamMediator:initAssistHero(node, info)
	local heroId = info.id

	node:setColor(cc.c3b(255, 255, 255))

	local fatigueBg = node:getChildByFullName("fatigueBg")

	fatigueBg:setVisible(false)

	if not table.indexof(self._assistHero, heroId) then
		return
	end

	fatigueBg:setVisible(true)
	fatigueBg:getChildByName("fatigueTxt"):setString(Strings:get("DreamChallenge_Point_Team_Npc_Name"))
	node:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("DreamChallenge_Point_Team_Npc_Forbid")
			}))
		end
	end)
	node:setColor(cc.c3b(150, 150, 150))
end

function ActivityBlockTeamMediator:sortAssistHero(list)
	for i, v in ipairs(self._assistHero) do
		if table.indexof(list, v) then
			table.remove(list, table.indexof(list, v))
			table.insert(list, #list + 1, v)
		end
	end
end

function ActivityBlockTeamMediator:onClickFight(sender, eventType)
	local function callback()
		self._curTeam = self._activity:getTeam()

		AudioTimerSystem:playStartBattleVoice(self._curTeam)
		self._activitySystem:setBattleTeamInfo(self._curTeam)

		if self._activity:getType() == ActivityType.KWorldBoss then
			local maxHurtNum

			self._activity:setOldMaxHurtNum(self._param.type == WorldBossPointType.kVanguard and self._activity:getMaxVanguardHurt() or self._activity:getMaxBossHurt())
			self._activitySystem:requestDoActivity(self._activityId, {
				doActivityType = 102,
				pointType = self._param.type
			}, function(rsdata)
				if rsdata.resCode == GS_SUCCESS then
					self._param.parent:onClickBack()
					self:dismiss()

					local data = rsdata.data

					data.isWorldBoss = true
					data.pointType = self._param.type, self._activitySystem:enterActstageBattle(data, self._activityId)
				end
			end, true)
		elseif self._activity:getType() == ActivityType.KActivityBlockMapNew then
			local point = self._activity:getSubPointById(self._pointId)

			self._param.parent._parent._data.enterBattlePointId = point:getOwner():getId()

			self._activitySystem:requestDoChildActivity(self._activityId, self._activity:getId(), {
				doActivityType = 102,
				type = self._param.type,
				mapId = self._param.mapId,
				pointId = self._pointId
			}, function(rsdata)
				if rsdata.resCode == GS_SUCCESS then
					local function endFunc()
						self._param.parent:onClickBack()
						self:dismiss()
						self._activitySystem:enterActstageBattle(rsdata.data, self._activityId, self._activity:getId())
					end

					local pointConfig = point:getConfig()
					local storyLink = pointConfig.StoryLink
					local storynames = storyLink and storyLink.enter
					local storyDirector = self:getInjector():getInstance(story.StoryDirector)
					local storyAgent = storyDirector:getStoryAgent()

					storyAgent:setSkipCheckSave(false)
					storyAgent:trigger(storynames, nil, endFunc)
				end
			end, true)
		else
			local point = self._activity:getPointById(self._pointId)

			point:recordOldStar()
			point:recordHpRate()

			self._param.parent._parent._data.stageType = self._param.parent._parent._stageType
			self._param.parent._parent._data.enterBattlePointId = self._pointId

			self._activitySystem:requestDoChildActivity(self._activityId, self._activity:getId(), {
				doActivityType = 102,
				type = self._param.type,
				mapId = self._param.mapId,
				pointId = self._pointId
			}, function(rsdata)
				if rsdata.resCode == GS_SUCCESS then
					self._param.parent:onClickBack()
					self:dismiss()
					self._activitySystem:enterActstageBattle(rsdata.data, self._activityId, self._activity:getId())
				end
			end, true)
		end
	end

	self:onClickBack(nil, nil, callback)
end

function ActivityBlockTeamMediator:changeTeamByMode(event)
	local teamData = event:getData()

	self:initData(teamData)
	self:initAssistView()
	self:refreshPetNode()
	self:refreshMasterInfo()
	self:refreshListView()
	self:createSortView()

	self._hasForceChangeTeam = true
end
