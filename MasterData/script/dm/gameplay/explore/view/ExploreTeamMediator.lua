-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExploreTeamMediator.lua

require("dm.gameplay.stage.view.CommonTeamMediator")

ExploreTeamMediator = class("ExploreTeamMediator", CommonTeamMediator, _M)

ExploreTeamMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
ExploreTeamMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ExploreTeamMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
ExploreTeamMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")

local kBtnHandlers = {
	tipBtn = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickTip"
	}
}
local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}

function ExploreTeamMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._teamBreakBtn = self:bindWidget("main.btnPanel.oneKeyBreakBtn", TwoLevelMainButton, {
		ignoreAddKerning = true,
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onClickOneKeyBreak, self)
		}
	})
	self._teamOneKeyBtn = self:bindWidget("main.btnPanel.oneKeyBtn", TwoLevelMainButton, {
		ignoreAddKerning = true,
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onClickOneKeyEmbattle, self)
		}
	})
	self._fightBtn = self:bindWidget("main.btnPanel.enterBtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onClickFight, self)
		}
	})
	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_TEAM_CHANGE_MASTER, self, self.changeMasterId)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TEAM_REFRESH_PETS, self, self.refreshView)
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

function ExploreTeamMediator:enterWithData(data)
	data = data or {}
	self._data = data
	self._stageType = data.stageType or ""
	self._spData = data.data or {}
	self._cardsOneKeyExcept = {}
	self._cardsRecommend = self._spData.cardsRecommend or {}
	self._pointData = data.pointData
	self._masterList = self._masterSystem:getShowMasterList()
	self._curMasterId = ""

	local num = 0

	for i = 1, #self._masterList do
		if not self._masterList[i]:getIsLock() then
			num = num + 1

			if self._curMasterId == "" then
				self._curMasterId = self._masterList[i]:getId()
			end
		end
	end

	self._showChangeMaster = num > 1
	self._isDrag = false
	self._costTotal = 0
	self._costMaxNum = self._stageSystem:getCostInit() + self._developSystem:getBuildingCostEffValue()
	self._maxTeamPetNum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum", "content") + self._developSystem:getBuildingCardEffValue()
	self._teamUnlockConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Stage_Team_Unlock", "content")

	self._stageSystem:setSortExtand(0)

	self._ignoreReloadData = true

	self:initTeamListData()
	self:initData()
	self:setupTopInfoWidget()
	self:initWigetInfo()
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

	local tipBtn = self:getView():getChildByFullName("tipBtn")

	tipBtn:setPositionX(self._topInfoWidget:getTitleWidth() + 30)
end

function ExploreTeamMediator:initTeamListData()
	self._currentTeamId = 1
	self._tempTeamList = {}
	self._teamList = {}

	local teamList = self._pointData:getTeams()

	for i = 1, #teamList do
		local team = teamList[i]

		self._teamList[i] = {}
		self._teamList[i].id = team:getId()
		self._teamList[i].masterId = team:getMasterId()
		self._teamList[i].heroes = {}
		self._tempTeamList[i] = {}
		self._tempTeamList[i].id = team:getId()
		self._tempTeamList[i].masterId = team:getMasterId()
		self._tempTeamList[i].heroes = {}

		local heroes = team:getHeroes()

		for j = 1, #heroes do
			local hero = heroes[j]

			table.insert(self._teamList[i].heroes, hero)
			table.insert(self._tempTeamList[i].heroes, hero)
		end
	end
end

function ExploreTeamMediator:initData()
	self._curTeam = self._teamList[self._currentTeamId]
	self._curTeamId = self._curTeam.id

	local modelTmp = {
		_heroes = self:removeExceptHeros(),
		_masterId = self._curTeam.masterId
	}

	if modelTmp._masterId ~= "" and modelTmp._masterId ~= 0 and not self._changeMaster then
		self._curMasterId = modelTmp._masterId
	end

	local teamPetIndex = 1

	self._teamPets = {}
	self._tempTeams = {}

	for _, v in pairs(modelTmp._heroes) do
		self._teamPets[teamPetIndex] = v
		self._tempTeams[teamPetIndex] = v
		teamPetIndex = teamPetIndex + 1
	end

	self._petList = self._stageSystem:getNotOnTeamPet(self._teamPets)
	self._petListAll = {}

	table.copy(self._petList, self._petListAll)
end

function ExploreTeamMediator:removeExceptHeros()
	local heros = self._curTeam.heroes
	local showHeros = {}

	for i = 1, #heros do
		showHeros[#showHeros + 1] = heros[i]
	end

	return showHeros
end

function ExploreTeamMediator:showOneKeyHeros()
	self._cardsOneKeyExcept = {}

	for i = 1, #self._teamList do
		local team = self._teamList[i]
		local heroes = team.heroes

		if i ~= self._currentTeamId then
			for index, id in ipairs(heroes) do
				self._cardsOneKeyExcept[#self._cardsOneKeyExcept + 1] = id
			end
		end
	end

	local orderPets = self._heroSystem:getTeamPrepared(self._teamPets, self._petList, self._cardsRecommend)

	self._orderPets = {}
	self._leavePets = {}

	for i = 1, #orderPets do
		local isOneKeyExcept = table.indexof(self._cardsOneKeyExcept, orderPets[i])

		if #self._orderPets < self._maxTeamPetNum and not isOneKeyExcept then
			self._orderPets[#self._orderPets + 1] = orderPets[i]
		else
			self._leavePets[#self._leavePets + 1] = orderPets[i]
		end
	end
end

function ExploreTeamMediator:setupView()
	self:initLockIcons()
	self:refreshPetNode()
	self:refreshMasterInfo()
	self:initTeamList()
	self:initView()
	self:refreshListView()
	self:createSortView()
end

function ExploreTeamMediator:initWigetInfo()
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
	self._masterImage = self._bg:getChildByName("role")
	self._teamBg = self._bg:getChildByName("team_bg")
	self._teamListPanel = self._main:getChildByFullName("info_bg")
	self._movingPet = self._main:getChildByFullName("moving_pet")
	self._btnPanel = self._main:getChildByName("btnPanel")
	self._myPetClone = self:getView():getChildByName("myPetClone")

	self._myPetClone:setVisible(false)

	self._petSize = self._myPetClone:getChildByFullName("myPetClone"):getContentSize()
	self._teamPetClone = self:getView():getChildByName("teamPetClone")

	self._teamPetClone:setVisible(false)
	self._teamPetClone:setScale(0.64)

	self._infoText = self._main:getChildByFullName("rulePanel.text1")

	self._infoText:setString(Strings:get("EXPLORE_UI15"))
	self:setLabelEffect()
	self:ignoreSafeArea()
end

function ExploreTeamMediator:setLabelEffect()
	for i = 1, 3 do
		local teamPanel = self._teamListPanel:getChildByFullName("team_" .. i)
		local combatLabel = teamPanel:getChildByFullName("combatLabel")
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

		combatLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
			x = 0,
			y = -1
		}))
	end
end

function ExploreTeamMediator:ignoreSafeArea()
	AdjustUtils.ignorSafeAreaRectForNode(self._heroPanel, AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._myPetPanel:getChildByName("sortPanel"), AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._main:getChildByFullName("btnPanel"), AdjustUtils.kAdjustType.Right)

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._heroPanel:setContentSize(cc.size(winSize.width - 177, 220))
end

function ExploreTeamMediator:initTeamList()
	for i = 1, #self._teamList do
		local teamPanel = self._teamListPanel:getChildByFullName("team_" .. i)

		if teamPanel then
			teamPanel:setVisible(true)
			teamPanel:getChildByFullName("selectImg"):setVisible(i == self._currentTeamId)
			teamPanel:addClickEventListener(function()
				self:onClickTeamChoose(i)
			end)
		end
	end
end

function ExploreTeamMediator:createTeamCell(cell, index)
	local node = cell:getChildByTag(12138)

	node = node:getChildByFullName("myPetClone")

	node:setVisible(false)

	cell.id = nil

	if index == 1 then
		node:setTouchEnabled(false)

		return
	end

	node:setVisible(true)

	local id = self._petListAll[index - 1]

	node.id = id
	cell.id = id

	node:setTouchEnabled(true)
	node:setSwallowTouches(false)
	node:addTouchEventListener(function(sender, eventType)
		self:onClickCell(sender, eventType)
	end)

	local heroInfo = self:getHeroInfoById(id)

	self:initHero(node, heroInfo)
	node:getChildByName("recommond"):setVisible(self:checkIsRecommend(id))

	local isShow, teamNum = self:checkIsInTeam(id)

	node:getChildByFullName("teamNum"):setVisible(isShow)

	if isShow then
		node:getChildByFullName("teamNum.text"):setString(teamNum)
	end

	local detailBtn = node:getChildByFullName("detailBtn")

	detailBtn:addClickEventListener(function()
		local attrAdds = {}

		if self:checkIsRecommend(id) then
			attrAdds[#attrAdds + 1] = {}
			attrAdds[#attrAdds].title = Strings:get("Team_Hero_Title")
			attrAdds[#attrAdds].desc = Strings:get("EXPLORE_UI15")
			attrAdds[#attrAdds].type = StageAttrAddType.HERO
		end

		self:onClickHeroDetail(id, attrAdds)
	end)
end

function ExploreTeamMediator:onClickCell(sender, eventType)
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

function ExploreTeamMediator:changeOwnPet(cell)
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

		self:refreshTeamListData()
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

		self:refreshTeamListData()
		self:refreshPetNode()
		self:runInsertTeamAction(id)
		self:refreshListView()
		self:runInsertAction((index and self._petListAll[index + 1] or nil) and self._petListAll[index + 1])
	end
end

function ExploreTeamMediator:insertTeamPet(cell, isDrag)
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

	self:refreshTeamListData()
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

function ExploreTeamMediator:refreshTeamListData()
	local heroes = {}

	for i = 1, #self._teamPets do
		local heroId = self._teamPets[i]

		heroes[i] = heroId

		local isInTeam, teamId = self:checkIsInTeam(heroId)

		if isInTeam then
			table.removebyvalue(self._teamList[teamId].heroes, heroId)
		end
	end

	self._teamList[self._currentTeamId].heroes = {}

	table.copy(heroes, self._teamList[self._currentTeamId].heroes)
end

function ExploreTeamMediator:createMovingPet(cell, type)
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

	petNode:getChildByName("recommond"):setVisible(self:checkIsRecommend(cell.id))

	local text = petNode:getChildByName("recommond"):getChildByName("text")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		text:setScale(1.5)
	else
		text:setScale(1)
	end

	if petNode then
		self._movingPet:removeAllChildren()
		petNode:setAnchorPoint(cc.p(0.5, 0.5))
		petNode:addTo(self._movingPet):center(self._movingPet:getContentSize())
	end
end

function ExploreTeamMediator:sortOnTeamPets()
	self._heroSystem:sortOnTeamPets(self._teamPets)
end

function ExploreTeamMediator:checkIsRecommend(id)
	for i = 1, #self._cardsRecommend do
		if self._cardsRecommend[i] == id then
			return true
		end
	end

	return false
end

function ExploreTeamMediator:checkIsInTeam(id)
	for i = 1, #self._teamList do
		local heroes = self._teamList[i].heroes

		if table.keyof(heroes, id) then
			return true, i
		end
	end

	return false
end

function ExploreTeamMediator:onClickOnTeamPet(sender, eventType)
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

function ExploreTeamMediator:removeTeamPet(index)
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

	self:refreshTeamListData()
	self:refreshListView()
	self:refreshPetNode()
	self:runRemoveAction(id)
	self:runRemovePetAction(id)
end

function ExploreTeamMediator:refreshView()
	self:initData()
	self:refreshMasterInfo()
	self:refreshListView()
	self:refreshPetNode()
end

function ExploreTeamMediator:refreshListView(ignoreAdjustOffset)
	self._petListAll = self._stageSystem:getSortExtendIds(self._petList)

	local sortType = self._stageSystem:getCardSortType()

	self._heroSystem:sortHeroes(self._petListAll, sortType, self._cardsRecommend)

	self._cardsOneKeyExcept = {}

	for i = 1, #self._teamList do
		local team = self._teamList[i]
		local heroes = team.heroes

		if i ~= self._currentTeamId then
			for index, id in ipairs(heroes) do
				self._cardsOneKeyExcept[#self._cardsOneKeyExcept + 1] = id
			end
		end
	end

	if #self._cardsOneKeyExcept > 0 then
		local heros1 = {}
		local heros2 = {}

		for i = 1, #self._petListAll do
			local isOneKeyExcept = table.indexof(self._cardsOneKeyExcept, self._petListAll[i])

			if isOneKeyExcept then
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

function ExploreTeamMediator:initHero(node, info)
	local heroId = info.id

	super.initHero(self, node, info)

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

function ExploreTeamMediator:refreshPetNode()
	self:refreshCombatAndCost()
	self:refreshButtons()
	self:sortOnTeamPets()
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

			self._petNodeList[i]:getChildByName("recommond"):setVisible(self:checkIsRecommend(id))

			local text = self._petNodeList[i]:getChildByName("recommond"):getChildByName("text")

			if getCurrentLanguage() ~= GameLanguageType.CN then
				text:setScale(1.4)
			else
				text:setScale(1)
			end

			self:initTeamHero(self._petNodeList[i], heroInfo)
			self._petNodeList[i]:addTo(iconBg):center(iconBg:getContentSize())
			self._petNodeList[i]:offset(0, -9)
			iconBg:setTouchEnabled(true)

			iconBg.id = id

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

function ExploreTeamMediator:initTeamHero(node, info)
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

	local recommond = node:getChildByName("recommond")
	local text = node:getChildByFullName("recommond.text")
	local textSize = text:getContentSize()

	recommond:setContentSize(cc.size(textSize.width + 8, textSize.height + 6))
	text:setPosition(cc.p(textSize.width / 2 + 4, textSize.height / 2 + 3))
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
	local dicengEff, shangcengEff

	skillPanel:setVisible(not not skill)

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
end

function ExploreTeamMediator:refreshCombatAndCost()
	local leadConfig = self._masterSystem:getMasterCurLeadStageConfig(self._curMasterId)

	if leadConfig then
		if not leadConfig.LeadFightHero then
			local addPercent = 0

			for i = 1, #self._teamList do
				local heroes = self._teamList[i].heroes
				local totalCombat = 0
				local totalCost = 0

				for k, v in pairs(heroes) do
					local heroInfo = self._heroSystem:getHeroById(v)

					totalCost = totalCost + heroInfo:getCost()
					totalCombat = totalCombat + heroInfo:getSceneCombatByType(SceneCombatsType.kAll)
				end

				totalCombat = leadConfig and math.ceil((addPercent + 1) * totalCombat) or totalCombat

				local masterData = self._masterSystem:getMasterById(self._curMasterId)

				totalCombat = masterData and totalCombat + masterData:getCombat() or totalCombat

				if self._currentTeamId == i then
					self._costTotal = totalCost
				end

				local teamPanel = self._teamListPanel:getChildByFullName("team_" .. i)

				if teamPanel then
					teamPanel:getChildByFullName("combatLabel"):setString(totalCombat)

					local cost1 = teamPanel:getChildByFullName("cost1")
					local cost2 = teamPanel:getChildByFullName("cost")

					cost1:setString(totalCost)
					cost2:setString("/" .. self._costMaxNum)
					cost1:setPositionX(cost2:getPositionX() - cost2:getContentSize().width)

					local color = self._costTotal <= self._costMaxNum and cc.c3b(255, 255, 255) or cc.c3b(255, 65, 51)

					cost1:setTextColor(color)

					local infoBtn = teamPanel:getChildByFullName("infoBtn")

					infoBtn:setVisible(leadConfig ~= nil and addPercent > 0)
					infoBtn:addTouchEventListener(function(sender, eventType)
						local fightTip = teamPanel:getChildByFullName("fightInfo")

						self:onClickInfo(eventType, fightTip)
					end)
				end
			end
		end
	end
end

function ExploreTeamMediator:changeMasterId(event)
	self._curMasterId = event:getData().masterId
	self._changeMaster = true

	self:refreshMasterInfo()
	self:checkMasterSkillActive()
	self:refreshPetNode()
end

function ExploreTeamMediator:refreshMasterInfo()
	local masterData = self._masterSystem:getMasterById(self._curMasterId)

	self._masterBtn:setVisible(self._showChangeMaster)
	self._masterImage:setVisible(true)
	self._masterImage:removeAllChildren()
	self._masterImage:addChild(masterData:getHalfImage())
	self:refreshCombatAndCost()
	self:refreshButtons()
end

function ExploreTeamMediator:refreshButtons()
	self._teamBreakBtn:setVisible(true)
	self._teamOneKeyBtn:setVisible(true)
	self._teamOneKeyBtn:getButton():setGray(false)

	local team = self._teamList[self._currentTeamId]
	local heroes = team.heroes
	local canShow = self:checkButtonVisible()

	if not canShow then
		self._teamBreakBtn:setVisible(false)
	elseif #heroes == 0 then
		self._teamBreakBtn:setVisible(false)
		self._teamOneKeyBtn:getButton():setGray(true)
	else
		self._teamOneKeyBtn:setVisible(false)
	end
end

function ExploreTeamMediator:checkButtonVisible()
	local hasHero = false

	for i = 1, #self._petList do
		local heroId = self._petList[i]
		local inTeam, index = self:checkIsInTeam(heroId)

		if not inTeam then
			hasHero = true

			break
		end
	end

	if not hasHero then
		return true
	end

	if #self._teamPets < self._maxTeamPetNum then
		return false
	end

	return true
end

function ExploreTeamMediator:getSendData()
	local sendData = {}

	for i = 1, #self._teamList do
		local teamIndex = #sendData + 1

		sendData[teamIndex] = {}

		local heroes = self._teamList[i].heroes

		for index, id in ipairs(heroes) do
			sendData[teamIndex][index] = id
		end
	end

	return {
		pointId = self._pointData:getId(),
		masterId = self._curMasterId,
		heroes = sendData
	}
end

function ExploreTeamMediator:sendChangeTeam(callBack, ignoreTip)
	local hasChange = self:hasChangeTeam()

	if not ignoreTip and hasChange then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Team_StorageSuccessTips")
		}))
	end

	local params = self:getSendData()

	self._exploreSystem:requestSaveTeam(function()
		if DisposableObject:isDisposed(self) then
			return
		end

		if callBack then
			callBack()
		end
	end, params)
end

function ExploreTeamMediator:hasChangeTeam()
	for i = 1, #self._tempTeamList do
		local oldTeam = self._tempTeamList[i]
		local curTeam = self._teamList[i]
		local oldMasterId = oldTeam.masterId
		local curMasterId = curTeam.masterId

		if oldMasterId ~= curMasterId then
			return true
		end

		local oldHeroes = oldTeam.heroes
		local curHeroes = curTeam.heroes

		if #oldHeroes ~= #curHeroes then
			return true
		end

		local tempTab = {}

		for k, v in pairs(oldHeroes) do
			tempTab[v] = k
		end

		for k, v in pairs(curHeroes) do
			if not tempTab[v] then
				return true
			end
		end
	end

	return false
end

function ExploreTeamMediator:checkTeamHeroesIsEmpty()
	for i = 1, #self._teamList do
		local heroes = self._teamList[i].heroes

		if #heroes == 0 then
			return true, i
		end
	end

	return false
end

function ExploreTeamMediator:onClickOneKeyEmbattle()
	self._teamView:stopScroll()
	self:showOneKeyHeros()

	self._teamPets = {}
	self._petList = {}

	table.copy(self._orderPets, self._teamPets)
	table.copy(self._leavePets, self._petList)
	self:refreshTeamListData()
	self:refreshListView(true)
	self:refreshPetNode()

	for i = 1, self._maxTeamPetNum do
		if self._petNodeList[i] then
			local iconBg = self._teamBg:getChildByName("pet_" .. i)

			iconBg:removeChildByName("EmptyIcon")
		end
	end
end

function ExploreTeamMediator:onClickOneKeyBreak()
	self._teamView:stopScroll()

	local ids = self._heroSystem:getTeamPrepared(self._teamPets, self._petList, self._cardsRecommend)

	self._teamPets = {}
	self._petList = {}

	table.copy(ids, self._petList)
	self:refreshTeamListData()
	self:refreshListView(true)
	self:refreshPetNode()
end

function ExploreTeamMediator:onClickFight(sender, eventType)
	local canExit, index = self:checkTeamHeroesIsEmpty()

	if canExit then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("EXPLORE_UI74", {
				teamId = index
			})
		}))

		return false
	end

	local function func()
		if self._spData.callback then
			self._spData.callback()
		end
	end

	self:sendChangeTeam(func, true)
end

function ExploreTeamMediator:onClickBack()
	local function func()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		storyDirector:notifyWaiting("exit_stageTeam_view")
		self:dismiss()
	end

	local noExit, index = self:checkTeamHeroesIsEmpty()

	if not noExit then
		self:sendChangeTeam(func)
	end

	func()
end

function ExploreTeamMediator:onClickTip()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Map_Team_Rule", "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule
	}))
end

function ExploreTeamMediator:onClickTeamChoose(teamId)
	for i = 1, #self._teamList do
		local teamPanel = self._teamListPanel:getChildByFullName("team_" .. i)

		if teamPanel then
			local select = i == teamId

			teamPanel:getChildByFullName("selectImg"):setVisible(select)
		end
	end

	self._currentTeamId = teamId

	self._stageSystem:setSortExtand(0)
	self:refreshView()
end

function ExploreTeamMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local oneKeyBtn = self:getView():getChildByFullName("main.btnPanel.oneKeyBtn")

	if oneKeyBtn then
		storyDirector:setClickEnv("exploreTeam.OneKeyBtn", oneKeyBtn, function(sender, eventType)
			self:onClickOneKeyEmbattle()
		end)
	end

	local fightBtn = self:getView():getChildByFullName("main.btnPanel.enterBtn")

	if fightBtn then
		storyDirector:setClickEnv("exploreTeam.fightBtn", fightBtn, function(sender, eventType)
			self:onClickFight()
		end)
	end

	local sequence = cc.Sequence:create(cc.DelayTime:create(0.001), cc.CallFunc:create(function()
		storyDirector:notifyWaiting("enter_exploreTeam_view")
	end))

	oneKeyBtn:runAction(sequence)
end
