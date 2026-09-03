-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/StoryStageTeamMediator.lua

require("dm.gameplay.stage.view.CommonTeamMediator")

StoryStageTeamMediator = class("StoryStageTeamMediator", CommonTeamMediator, _M)

StoryStageTeamMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
StoryStageTeamMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
StoryStageTeamMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kBtnHandlers = {}
local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}

function StoryStageTeamMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._fightBtn = self:bindWidget("main.btnPanel.fightBtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onClickFight, self)
		}
	})

	self:getView():getChildByFullName("main.info_bg.button_one_key_embattle"):setVisible(false)
	self:getView():getChildByFullName("main.info_bg.button_one_key_break"):setVisible(false)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_TEAM_REFRESH_PETS, self, self.refreshViewBySort)
end

function StoryStageTeamMediator:enterWithData(data)
	self._data = data
	self._pointId = data.pointId
	self._heroId = data.heroId
	self._config = ConfigReader:getRecordById("HeroStoryPoint", self._pointId)
	self._cardsExcept = self._config.RemoveHero
	self._costMaxNum = self._config.PlayerCost
	self._maxTeamPetNum = self._config.TeamAmount
	self._playerMasterMode = self._config.PlayerMasterMode
	self._curMasterId = self._config.PlayerMaster
	self._masterConfig = ConfigReader:getRecordById("EnemyMaster", self._curMasterId)
	self._playerEnemyHero = self._config.PlayerEnemyHero
	self._useOwnHero = self._config.OtherHero == 1
	self._cardsExcept[#self._cardsExcept + 1] = self._heroId
	self._isDrag = false
	self._costTotal = 0
	self._ignoreReloadData = true

	self._stageSystem:setSortExtand(0)

	self._robotLength = 0

	self:initData()
	self:setupTopInfoWidget()
	self:initWidgetInfo()
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
end

function StoryStageTeamMediator:initData()
	self._teamPets = {}

	if not self._useOwnHero then
		self._petList = {}
		self._petListAll = {}
	else
		self._petList = self._stageSystem:getNotOnTeamPet(self._cardsExcept)
		self._petListAll = self._stageSystem:getNotOnTeamPet(self._cardsExcept)
	end
end

function StoryStageTeamMediator:updateData()
	if not self._useOwnHero then
		self._teamPets = {}
		self._petList = {}
		self._petListAll = {}
	else
		local teamPets = table.copy(self._teamPets, {})

		teamPets[#teamPets + 1] = self._heroId
		self._petList = self._stageSystem:getNotOnTeamPet(teamPets)
		self._petListAll = self._stageSystem:getNotOnTeamPet(teamPets)
	end
end

function StoryStageTeamMediator:showOneKeyHeroes()
	if not self._useOwnHero then
		return
	end

	local orderPets = self._heroSystem:getTeamPrepared(self._teamPets, self._petList)

	self._orderPets = {}
	self._leavePets = {}

	local cost = 0
	local maxTeamPetNum = self._maxTeamPetNum - #self._playerEnemyHero
	local costMaxNum = self._costMaxNum

	for i = 1, #self._playerEnemyHero do
		local config = ConfigReader:getRecordById("EnemyHero", self._playerEnemyHero[i])

		costMaxNum = costMaxNum - config.Cost
	end

	if self._playerMasterMode == 1 then
		maxTeamPetNum = maxTeamPetNum - 1

		local hero = self._heroSystem:getHeroById(self._heroId)

		costMaxNum = costMaxNum - hero:getCost()
	end

	for i = 1, #orderPets do
		do
			local isExcept = self._stageSystem:isStoryHeroExcept(self._cardsExcept, orderPets[i])

			if maxTeamPetNum > #self._orderPets and not isExcept then
				if costMaxNum >= cost + self._heroSystem:getHeroById(orderPets[i]):getCost() then
					cost = cost + self._heroSystem:getHeroById(orderPets[i]):getCost()
					self._orderPets[#self._orderPets + 1] = orderPets[i]

					goto label_6_0
				end
			end

			self._leavePets[#self._leavePets + 1] = orderPets[i]
		end

		::label_6_0::
	end
end

function StoryStageTeamMediator:setupView()
	self:initLockIcons()
	self:refreshPetNode()
	self:refreshMasterInfo()
	self:initView()
	self:refreshListView()
	self:createSortView()
end

function StoryStageTeamMediator:initLockIcons()
	local maxShowNum = 10

	for i = self._maxTeamPetNum + 1, maxShowNum do
		local iconBg = self._teamBg:getChildByName("pet_" .. i)

		iconBg:removeAllChildren()

		local emptyIcon = GameStyle:createEmptyIcon(true)

		emptyIcon:addTo(iconBg):center(iconBg:getContentSize())

		local tipLabel = emptyIcon:getChildByName("TipText")

		tipLabel:setString(Strings:get("StagePractice_UI_Lock"))
	end
end

function StoryStageTeamMediator:initWidgetInfo()
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
	self._costAverageLabel = self._main:getChildByFullName("info_bg.averageLabel")
	self._costTotalLabel1 = self._main:getChildByFullName("info_bg.cost1")
	self._costTotalLabel2 = self._main:getChildByFullName("info_bg.cost2")
	self._costTouch = self._main:getChildByFullName("info_bg.costTouch")

	self._costTouch:addClickEventListener(function()
		self:createCostTip()
	end)

	self._movingPet = self._main:getChildByFullName("moving_pet")
	self._rulePanel = self._main:getChildByName("rulePanel")
	self._btnPanel = self._main:getChildByName("btnPanel")
	self._myPetClone = self:getView():getChildByName("myPetClone")

	self._myPetClone:setVisible(false)

	self._petSize = self._myPetClone:getChildByFullName("myPetClone"):getContentSize()
	self._teamPetClone = self:getView():getChildByName("teamPetClone")

	self._teamPetClone:setVisible(false)
	self._teamPetClone:setScale(0.64)
	self:ignoreSafeArea()
end

function StoryStageTeamMediator:ignoreSafeArea()
	AdjustUtils.ignorSafeAreaRectForNode(self._heroPanel, AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._myPetPanel:getChildByName("sortPanel"), AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._main:getChildByFullName("btnPanel"), AdjustUtils.kAdjustType.Right)

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._heroPanel:setContentSize(cc.size(winSize.width - 177, 220))
end

function StoryStageTeamMediator:createTeamCell(cell, index)
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
		self:onClickHeroDetail(id)
	end)
end

function StoryStageTeamMediator:onClickCell(sender, eventType, index)
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

function StoryStageTeamMediator:changeOwnPet(cell)
	local id = cell.id
	local targetIndex

	for i = self._robotLength + 1, self._maxTeamPetNum do
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
		self._teamPets[targetIndex - self._robotLength] = id

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

function StoryStageTeamMediator:insertTeamPet(cell, isDrag)
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

function StoryStageTeamMediator:checkIsInTeamArea()
	local targetIndex

	for i = self._robotLength + 1, self._maxTeamPetNum do
		local iconBg = self._teamBg:getChildByName("pet_" .. i)

		if self:checkCollision(iconBg) then
			targetIndex = i

			break
		end
	end

	return targetIndex
end

function StoryStageTeamMediator:isSelectCanceledByClick(id)
	local length = self._robotLength + #self._teamPets

	if length >= self._maxTeamPetNum then
		if not self._runInsertPetAction and self._isReturn then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Stage_Team_UI7")
			}))
		end

		return true
	end

	return false
end

function StoryStageTeamMediator:isSelectCanceledByDray(addId, removeId)
	local selectCanceled = false

	if selectCanceled and self._isReturn then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Stage_Team_Overload")
		}))
	end

	return selectCanceled
end

function StoryStageTeamMediator:createMovingPet(cell, type)
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

function StoryStageTeamMediator:sortOnTeamPets()
	self._heroSystem:sortOnTeamPets(self._teamPets)
end

function StoryStageTeamMediator:onClickOnTeamPet(sender, eventType)
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

function StoryStageTeamMediator:removeTeamPet(index)
	AudioEngine:getInstance():playEffect("Se_Click_Putdown", false)

	local teamNum = #self._playerEnemyHero

	if self._playerMasterMode == 1 then
		teamNum = teamNum + 1
	end

	local indexTemp = index - teamNum
	local id = self._teamPets[indexTemp]
	local cellId = self:checkIsInOwnArea()

	if cellId then
		local idIndex = table.indexof(self._petList, cellId)
		local selectCanceled = self:isSelectCanceledByDray(cellId, id)

		if idIndex and not selectCanceled then
			table.remove(self._petList, idIndex)

			self._teamPets[indexTemp] = cellId
		else
			table.remove(self._teamPets, indexTemp)
		end
	else
		table.remove(self._teamPets, indexTemp)
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

function StoryStageTeamMediator:refreshViewBySort()
	self:updateData()
	self:refreshMasterInfo()
	self:refreshListView()
	self:refreshPetNode()
end

function StoryStageTeamMediator:refreshListView(ignoreAdjustOffset)
	self._petListAll = self._stageSystem:getSortExtendIds(self._petList)

	local sortType = self._stageSystem:getCardSortType()

	self._heroSystem:sortHeroes(self._petListAll, sortType)

	if table.nums(self._cardsExcept) > 0 then
		local heros1 = {}
		local heros2 = {}

		for i = 1, #self._petListAll do
			local isExcept = self._stageSystem:isStoryHeroExcept(self._cardsExcept, self._petListAll[i])

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

function StoryStageTeamMediator:refreshPetNode()
	self:refreshCost()
	self:refreshButtons()
	self:sortOnTeamPets()

	self._petNodeList = {}

	local teamPets = {}

	if self._playerMasterMode == 1 then
		teamPets[#teamPets + 1] = self._heroId
	end

	for i = 1, #self._playerEnemyHero do
		teamPets[#teamPets + 1] = self._playerEnemyHero[i]
	end

	self._robotLength = #teamPets

	for i = 1, #self._teamPets do
		teamPets[#teamPets + 1] = self._teamPets[i]
	end

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

		local id = teamPets[i]

		if id then
			local heroInfo = self:getHeroInfoById(id)

			self._petNodeList[i] = self._teamPetClone:clone()

			self._petNodeList[i]:setVisible(true)

			self._petNodeList[i].id = id

			local isRobot = table.indexof(self._playerEnemyHero, id)
			local isMainHero = id == self._heroId

			iconBg:setTouchEnabled(true)

			if isRobot then
				local image = ccui.ImageView:create("hb_icon_robot.png", 1)

				image:addTo(self._petNodeList[i])
				image:setPosition(cc.p(103, 30))

				self._petNodeList[i].robot = true

				iconBg:setTouchEnabled(false)
			end

			if isMainHero then
				local image = ccui.ImageView:create("hb_icon_zj.png", 1)

				image:addTo(self._petNodeList[i])
				image:setPosition(cc.p(103, 30))

				self._petNodeList[i].robot = true

				iconBg:setTouchEnabled(false)
			end

			self:initTeamHero(self._petNodeList[i], heroInfo)
			self._petNodeList[i]:addTo(iconBg):center(iconBg:getContentSize())
			self._petNodeList[i]:offset(0, -9)

			iconBg.id = self._teamPets[i - self._robotLength]

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

function StoryStageTeamMediator:initTeamHero(node, info)
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

	local cost = node:getChildByFullName("costBg.cost")

	cost:setString(info.cost)

	local occupationName, occupationImg = GameStyle:getHeroOccupation(info.type)
	local occupation = node:getChildByName("occupation")

	occupation:loadTexture(occupationImg)
end

function StoryStageTeamMediator:refreshCost()
	local totalCost = 0
	local length1 = #self._playerEnemyHero

	for i = 1, length1 do
		local id = self._playerEnemyHero[i]
		local heroConfig = ConfigReader:getRecordById("EnemyHero", id)

		totalCost = totalCost + heroConfig.Cost
	end

	if self._playerMasterMode == 1 then
		local heroInfo = self._heroSystem:getHeroById(self._heroId)

		totalCost = totalCost + heroInfo:getCost()
	end

	local length2 = #self._teamPets

	for i = 1, length2 do
		local id = self._teamPets[i]
		local heroInfo = self._heroSystem:getHeroById(id)

		totalCost = totalCost + heroInfo:getCost()
	end

	self._costTotal = totalCost

	self._costAverageLabel:setString(length2 + length1 == 0 and 0 or math.floor(totalCost * 10 / (length2 + length1) + 0.5) / 10)
	self._costTotalLabel1:setString(self._costTotal)
	self._costTotalLabel2:setString("/" .. self._costMaxNum)

	local color = self._costTotal <= self._costMaxNum and cc.c3b(255, 255, 255) or cc.c3b(255, 65, 51)

	self._costTotalLabel1:setTextColor(color)
	self._costTotalLabel2:setPositionX(self._costTotalLabel1:getPositionX() + self._costTotalLabel1:getContentSize().width)
end

function StoryStageTeamMediator:refreshMasterInfo()
	local model = self._masterConfig.RoleModel
	local img = self._playerMasterMode == 1 and IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe6_2",
		id = model
	}) or IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe6_2",
		id = model
	})

	img:setAnchorPoint(cc.p(0, 0))
	self._masterImage:setVisible(true)
	self._masterImage:removeAllChildren()
	self._masterImage:addChild(img)
	self:refreshCost()
	self:refreshButtons()
end

function StoryStageTeamMediator:refreshButtons()
	return
end

function StoryStageTeamMediator:checkButtonVisible()
	local length = #self._teamPets + #self._playerEnemyHero

	if self._playerMasterMode == 1 then
		length = length + 1
	end

	if length < self._maxTeamPetNum then
		for i = 1, #self._petList do
			local isExcept = self._stageSystem:isStoryHeroExcept(self._cardsExcept, self._petList[i])

			if not isExcept then
				return false
			end
		end
	end

	return true
end

function StoryStageTeamMediator:getHeroInfoById(id)
	if table.indexof(self._playerEnemyHero, id) then
		local config = ConfigReader:getRecordById("EnemyHero", id)

		return {
			qualityLevel = "",
			id = id,
			level = config.Level,
			star = config.Star,
			quality = config.Quality,
			rareity = config.Rarity,
			name = Strings:get(config.Name),
			roleModel = config.RoleModel,
			type = config.Type,
			cost = config.Cost
		}
	end

	local heroInfo = self._heroSystem:getHeroById(id)

	if not heroInfo then
		return nil
	end

	return {
		id = heroInfo:getId(),
		level = heroInfo:getLevel(),
		star = heroInfo:getStar(),
		quality = heroInfo:getQuality(),
		rareity = heroInfo:getRarity(),
		qualityLevel = heroInfo:getQualityLevel(),
		name = heroInfo:getName(),
		roleModel = heroInfo:getModel(),
		type = heroInfo:getType(),
		cost = heroInfo:getCost(),
		maxStar = heroInfo:getMaxStar()
	}
end

function StoryStageTeamMediator:onClickOneKeyBreak()
	if not self._useOwnHero then
		return
	end

	self._teamView:stopScroll()

	local ids = self._heroSystem:getTeamPrepared(self._teamPets, self._petList)

	self._teamPets = {}
	self._petList = {}

	table.copy(ids, self._petList)
	self:refreshListView(true)
	self:refreshPetNode()
end

function StoryStageTeamMediator:onClickFight(sender, eventType)
	local sendData = table.copy(self._playerEnemyHero, {})

	if self._playerMasterMode == 1 then
		sendData[#sendData + 1] = self._heroId
	end

	local length2 = #self._teamPets

	for i = 1, length2 do
		sendData[#sendData + 1] = self._teamPets[i]
	end

	if #sendData == 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("ARENA_TEMA_EMPTY")
		}))

		return
	end

	local data = {}

	data.heroIds = sendData
	data.masterId = self._curMasterId
	data.pointId = self._pointId
	data.heroId = self._heroId

	local mapId = ConfigReader:getDataByNameIdAndKey("HeroStoryPoint", self._pointId, "Map")

	self._stageSystem:requestEnterHeroStory(data, function(rsdata)
		self._stageSystem:enterHeroStoryBattle(data.pointId, mapId, rsdata.playerData)
	end, true)
end

function StoryStageTeamMediator:onClickBack()
	self:dismiss()
end
