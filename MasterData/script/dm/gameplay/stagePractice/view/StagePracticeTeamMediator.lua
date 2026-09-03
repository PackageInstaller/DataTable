-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/view/StagePracticeTeamMediator.lua

StagePracticeTeamMediator = class("StagePracticeTeamMediator", DmAreaViewMediator, _M)

StagePracticeTeamMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
StagePracticeTeamMediator:has("_stagePracticeSystem", {
	is = "r"
}):injectWith("StagePracticeSystem")
StagePracticeTeamMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
StagePracticeTeamMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}
local kBtnHandlers = {
	["main.btn_turn_left"] = "onClickShowMy",
	["main.btn_turn_right"] = "onClickShowEnemy"
}

function StagePracticeTeamMediator:initialize()
	super.initialize(self)
end

function StagePracticeTeamMediator:dispose()
	super.dispose(self)
end

function StagePracticeTeamMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_TEAM_CHANGE_MASTER, self, self.changeMasterId)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TEAM_REFRESH_PETS, self, self.refreshListView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshCombatAndCost)

	self._fightWidget = self:bindWidget("main.spStagePanel.fightBtn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Battle",
			func = bind1(self.onClickFight, self)
		}
	})

	self:bindWidget("main.button_stageGuide", ThreeLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickGuide, self)
		}
	})
end

function StagePracticeTeamMediator:enterWithData(data)
	self._stagePoint = data.stagePoint
	self._practiceType = data.practiceType or 1
	self._consumeNum = 100
	self._isDrag = false
	self._costTotal = 0
	self._costItemId = "IR_Gold"
	self._battleCostIcon = "icon_jinbi_1.png"

	if self._practiceType == 1 then
		self._costMaxNum = self:getMaxTeamCost(self._stagePoint:getId())
		self._maxTeamPetNum = self:getMaxTeamHeroNum(self._stagePoint:getId())

		local battleCost = self:getBattleCost(self._stagePoint:getId())

		if battleCost then
			self._consumeNum = battleCost.amount
			self._costItemId = battleCost.id
			self._battleCostIcon = "icon_jinbi_1.png"
		end
	else
		self._costMaxNum = self._stagePoint._config.CostCount
		self._maxTeamPetNum = self._stagePoint._config.HeroNumber

		local battleCost = self:getNormalBattleCost(self._stagePoint:getId())

		if battleCost then
			self._consumeNum = battleCost
			self._costItemId = "IR_Power"
			self._battleCostIcon = "icon_tili_1.png"
		end
	end

	self._maxTeamEnemyHeroNum = 10

	self:initData()
	self:setupView()
	self:setupClickEnvs()

	if self._practiceType == 1 then
		self:onClickGuide()
	end
end

function StagePracticeTeamMediator:initData()
	self._curTeam = self._stagePoint:getTeam()

	local modelTmp = {
		_heroes = self:removeExceptHeros(),
		_masterId = self._curTeam:getMasterId()
	}
	local model = {}

	table.deepcopy(modelTmp, model)

	self._curMasterId = self._practiceType == 1 and self:getOwnMasterId(self._stagePoint:getId()) or self._stagePoint:getOwnMaster()

	if self._curMasterId == "" or self._curMasterId == 0 then
		self._curMasterId = self._developSystem:getStageTeamById(1):getMasterId()
	end

	self._oldMasterId = self._curMasterId

	local teamPetIndex = 1

	self._teamPets = {}
	self._enemyTeamPets = {}

	for _, v in pairs(model._heroes) do
		self._teamPets[teamPetIndex] = v
		teamPetIndex = teamPetIndex + 1
	end

	self._tempTeams = {}

	table.deepcopy(self._teamPets, self._tempTeams)
	self:initDefaultOnHero(self._stagePoint:getId())
	self:getEnemyHeros(self._stagePoint:getId())

	self._nowName = self._curTeam:getName()
	self._oldName = self._nowName
	self._petList = {}
	self._petListAll = {}

	table.deepcopy(self:getConfigDefaultNotOnHero(), self._petList)
	table.deepcopy(self:getConfigDefaultNotOnHero(), self._petListAll)

	self._teamType = 1
end

function StagePracticeTeamMediator:getOwnMasterId(pointid)
	local masterid = ConfigReader:getDataByNameIdAndKey("StagePracticePoint", pointid, "SelfMaster")[1]
	local rid = ConfigReader:getDataByNameIdAndKey("EnemyMaster", masterid, "RoleModel")

	return ConfigReader:getDataByNameIdAndKey("RoleModel", rid, "Model")
end

function StagePracticeTeamMediator:getConfigMasterId(pointid)
	return ConfigReader:getDataByNameIdAndKey("StagePracticePoint", pointid, "SelfMaster")[1]
end

function StagePracticeTeamMediator:getEnemyHeros(pointid)
	local enemyFixHeroid = ""

	enemyFixHeroid = self._practiceType == 1 and ConfigReader:getDataByNameIdAndKey("StagePracticePoint", pointid, "EnemyHero") or self._stagePoint:getEnemyHero()

	local enemyFirstHeros = ConfigReader:getDataByNameIdAndKey("EnemyCard", enemyFixHeroid, "FirstFormation")
	local enemyFixHeros = ConfigReader:getDataByNameIdAndKey("EnemyCard", enemyFixHeroid, "CardCollection")
	local count = 1

	for i = 1, #enemyFixHeros do
		self._enemyTeamPets[i] = enemyFixHeros[i]
		count = count + 1
	end

	for k, v in pairs(enemyFirstHeros) do
		self._enemyTeamPets[count] = v[2]
		count = count + 1
	end
end

function StagePracticeTeamMediator:initDefaultOnHero(pointid)
	self._defaultFixHero = self._practiceType == 1 and ConfigReader:getDataByNameIdAndKey("StagePracticePoint", pointid, "SelfFixedHero") or self._stagePoint._config.SelfFixedHero

	for i = 1, #self._defaultFixHero do
		self._teamPets[i] = self._defaultFixHero[i]
	end
end

function StagePracticeTeamMediator:checkIsDefaultHero(heroid)
	local ison = false

	for k, v in pairs(self._defaultFixHero) do
		if heroid.id == v then
			ison = true

			break
		end
	end

	print("是否固定英魂--->", ison)

	return ison
end

function StagePracticeTeamMediator:getMaxTeamHeroNum(pointId)
	return ConfigReader:getDataByNameIdAndKey("StagePracticePoint", pointId, "HeroNumber")
end

function StagePracticeTeamMediator:getMaxTeamCost(pointId)
	return ConfigReader:getDataByNameIdAndKey("StagePracticePoint", pointId, "CostCount")
end

function StagePracticeTeamMediator:getBattleCost(pointId)
	return ConfigReader:getDataByNameIdAndKey("StagePracticePoint", pointId, "Cost")
end

function StagePracticeTeamMediator:getNormalBattleCost(pointId)
	return ConfigReader:getDataByNameIdAndKey("BlockPracticePoint", pointId, "StaminaCost")
end

function StagePracticeTeamMediator:getConfigDefaultNotOnHero()
	local allheros = {}

	allheros = self._practiceType == 1 and ConfigReader:getDataByNameIdAndKey("StagePracticePoint", self._stagePoint:getId(), "SelfAlterHero") or self._stagePoint._config.SelfAlterHero

	local list = {}

	for i = 1, #allheros do
		list[i] = ConfigReader:getDataByNameIdAndKey("EnemyHero", allheros[i], "RoleModel")
	end

	return allheros
end

function StagePracticeTeamMediator:removeExceptHeros()
	local heros = self._curTeam:getHeroes()
	local showHeros = {}

	for i = 1, #heros do
		showHeros[#showHeros + 1] = heros[i]
	end

	return showHeros
end

function StagePracticeTeamMediator:setupView()
	self:setupTopInfoWidget()
	self:initWigetInfo()
	self:initView()
	self:initLockIcons()
	self:refreshPetNode()
	self:refreshMasterInfo()
	self:refreshListView()
end

function StagePracticeTeamMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Stage_Practice")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = bind1(self.onClickBack, self),
		title = Strings:get("StagePractice_Btn_Title")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function StagePracticeTeamMediator:initWigetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._bg = self:getView():getChildByFullName("main.bg")
	self._panelInTeam = self:getView():getChildByFullName("main.Panel_inTeam")

	self._bg:removeChildByName("masterBtn")

	self._myPetPanel = self._main:getChildByFullName("my_pet_bg")

	self._myPetPanel:removeChildByName("sortPanel")

	self._heroPanel = self._myPetPanel:getChildByFullName("heroPanel")
	self._consumePanel = self._main:getChildByFullName("spStagePanel.coinpanel")
	self._consumeNode = self._consumePanel:getChildByFullName("coinnum")

	self._consumeNode:setString(" " .. self._consumeNum)
	self._consumePanel:getChildByName("coinimg"):loadTexture(self._battleCostIcon, ccui.TextureResType.plistType)

	self._masterImage = self._bg:getChildByName("role")
	self._masterSkillPanel = self._bg:getChildByName("masterSkillPanel")
	self._roleName = self._main:getChildByFullName("nameBg.masterName")
	self._teamBg = self._bg:getChildByName("team_bg")
	self._infoBg = self._main:getChildByName("info_bg")
	self._costAverageLabel = self._main:getChildByFullName("info_bg.averageLabel")
	self._costTotalLabel = self._main:getChildByFullName("info_bg.cost1")
	self._costTotalLimitLabel = self._main:getChildByFullName("info_bg.cost2")

	self._costTotalLimitLabel:setString("/" .. self._costMaxNum)

	self._costTouch = self._main:getChildByFullName("info_bg.costTouch")

	self._costTouch:addClickEventListener(function()
		self:createCostTip()
	end)

	self._movingPet = self:getView():getChildByFullName("moving_pet")
	self._fightBtn = self._main:getChildByFullName("spStagePanel.fightBtn")
	self._tipImage = self._main:getChildByFullName("tipImage")
	self._enemyBtn_my = self._main:getChildByFullName("btn_turn_left")
	self._enemyBtn_enemy = self._main:getChildByFullName("btn_turn_right")
	self.titlelabel = ccui.RichText:createWithXML("", {})

	self.titlelabel:addTo(self._main)
	self.titlelabel:setAnchorPoint(cc.p(0, 1))
	self.titlelabel:setPosition(cc.p(500, 300))

	self._myPetClone = self:getView():getChildByName("myPetClone")

	self._myPetClone:setVisible(false)

	self._teamPetClone = self:getView():getChildByName("teamPetClone")

	self._teamPetClone:setVisible(false)
	self._teamPetClone:setScale(0.64)

	self._skillDescPanel = self:getView():getChildByFullName("skillDescPanel")

	self._skillDescPanel:setSwallowTouches(false)
	self._skillDescPanel:addClickEventListener(function()
		if self._skillDescPanel:isVisible() then
			self._skillDescPanel:setVisible(false)
		end
	end)
	self.titlelabel:setVisible(false)
end

function StagePracticeTeamMediator:ignoreSafeArea()
	AdjustUtils.ignorSafeAreaRectForNode(self._heroPanel, AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._main:getChildByFullName("btnPanel"), AdjustUtils.kAdjustType.Right)

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._heroPanel:setContentSize(cc.size(winSize.width - 177, 220))
end

function StagePracticeTeamMediator:initView()
	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		return self._myPetClone:getContentSize().width, self._myPetClone:getContentSize().height
	end

	local function numberOfCellsInTableView(table)
		return #self._petListAll
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local node = self._myPetClone:clone()

			node:setTouchEnabled(true)
			node:setVisible(true)
			cell:addChild(node)
			node:setAnchorPoint(cc.p(0, 0))
			node:setPosition(cc.p(0, 0))
			node:setTag(12138)
		end

		self:createTeamCell(cell, idx + 1)

		return cell
	end

	local tableView = cc.TableView:create(self._heroPanel:getContentSize())

	tableView:setTag(1234)

	self._teamView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	tableView:setMaxBounceOffset(20)
	self._heroPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:reloadData()
end

function StagePracticeTeamMediator:createTeamCell(cell, index)
	local node = cell:getChildByTag(12138)

	node:setVisible(true)

	local id = self._petListAll[index]

	node.id = id
	cell.id = self._petListAll[index]

	node:setSwallowTouches(false)
	node:addTouchEventListener(function(sender, eventType)
		if self._teamType == 2 then
			return
		end

		self:onClickCell(sender, eventType)
	end)

	local heroInfo = self:getHeroInfoById(id)

	self:initHero(node:getChildByName("myPetClone"), heroInfo)
end

function StagePracticeTeamMediator:initLockIcons()
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

function StagePracticeTeamMediator:onClickCell(sender, eventType, oppoRecord)
	if eventType == ccui.TouchEventType.began then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		self._selectCanceled = false

		if #self._teamPets >= self._maxTeamPetNum then
			self._selectCanceled = true
		end

		self._isReturn = true
		self._isOnTeam = false
	elseif eventType == ccui.TouchEventType.moved then
		if not self._selectCanceled then
			local beganPos = sender:getTouchBeganPosition()
			local movedPos = sender:getTouchMovePosition()

			if self._isReturn and not self._isDrag then
				self._isDrag = self:checkTouchType(beganPos, movedPos)

				if self._isDrag and not self._isOnTeam then
					self:createMovingPet(sender, 1, 2)
					self:changeMovingPetPos(beganPos)
					sender:setVisible(false)
				end
			elseif self._isDrag and not self._isOnTeam then
				self:changeMovingPetPos(movedPos)
				self._teamView:setTouchEnabled(false)

				local worldPos = self._panelInTeam:convertToWorldSpace(cc.p(0, 0))
				local panelSize = self._panelInTeam:getContentSize()

				self._isReturn = movedPos.x < worldPos.x + panelSize.width and movedPos.x > worldPos.x and movedPos.y > worldPos.y and movedPos.y < worldPos.y + panelSize.height
			end
		end
	elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
		sender:setVisible(true)

		if self._isReturn and not self._selectCanceled then
			if not self._isOnTeam then
				self._isOnTeam = true

				self:insertTeamPet(sender)
			end

			self._movingPet:removeAllChildren()
		end

		if self._isReturn then
			-- block empty
		end

		self._isDrag = false

		self._movingPet:removeAllChildren()

		self._selectCanceled = false

		self._teamView:setTouchEnabled(true)
	end
end

function StagePracticeTeamMediator:insertTeamPet(cell)
	self._movingPet:removeAllChildren()

	local animId

	for k, v in pairs(self._petList) do
		if v == cell.id then
			table.remove(self._petList, k)

			animId = table.remove(self._petListAll, k)
		end
	end

	self._teamPets[#self._teamPets + 1] = cell.id

	self:refreshListView()
	self:refreshPetNode()
	self:runInsertTeamAction(cell.id)
end

function StagePracticeTeamMediator:createMovingPet(cell, scaleNum, type)
	local petNode
	local heroInfo = self:getHeroInfoById(cell.id)

	if type == 1 then
		petNode = self._teamPetClone:clone()

		petNode:setVisible(true)
		self:initTeamHero(petNode, heroInfo)
	elseif type == 2 then
		petNode = self._myPetClone:clone()

		petNode:setVisible(true)
		self:initHero(petNode:getChildByName("myPetClone"), heroInfo)
	end

	if petNode then
		self._movingPet:removeAllChildren()
		petNode:setAnchorPoint(cc.p(0.5, 0.5))
		petNode:addTo(self._movingPet):center(self._movingPet:getContentSize())
		self._movingPet:setScale(scaleNum)
	end
end

function StagePracticeTeamMediator:changeMovingPetPos(pos)
	local movedPos = self._movingPet:getParent():convertToWorldSpace(pos)

	self._movingPet:setPosition(movedPos)
end

function StagePracticeTeamMediator:checkCollision(targetPanel, pos)
	local offsetX = self._movingPet:getContentSize().width / 2
	local offsetY = self._movingPet:getContentSize().height / 2
	local checkPos = cc.p(0, 0)

	checkPos.x = pos.x - offsetX
	checkPos.y = pos.y - offsetY

	if cc.rectContainsPoint(targetPanel:getBoundingBox(), checkPos) then
		return true
	end

	checkPos.x = pos.x - offsetX
	checkPos.y = pos.y + offsetY

	if cc.rectContainsPoint(targetPanel:getBoundingBox(), checkPos) then
		return true
	end

	checkPos.x = pos.x + offsetX
	checkPos.y = pos.y - offsetY

	if cc.rectContainsPoint(targetPanel:getBoundingBox(), checkPos) then
		return true
	end

	checkPos.x = pos.x + offsetX
	checkPos.y = pos.y + offsetY

	if cc.rectContainsPoint(targetPanel:getBoundingBox(), checkPos) then
		return true
	end

	return false
end

function StagePracticeTeamMediator:checkTouchType(pos1, pos2)
	local xOffset = math.abs(pos1.x - pos2.x)
	local yOffset = math.abs(pos1.y - pos2.y)

	if xOffset > 10 or yOffset > 10 then
		local dragDeg = math.deg((math.atan(yOffset / xOffset)))

		if dragDeg > 30 then
			return true
		end
	end

	return false
end

function StagePracticeTeamMediator:onClickOnTeamPet(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		self._isOnOwn = false
	elseif eventType == ccui.TouchEventType.moved then
		if self:checkIsDefaultHero(sender) then
			return
		end

		local beganPos = sender:getTouchBeganPosition()
		local movedPos = sender:getTouchMovePosition()

		if not self._isDrag then
			self._isDrag = self:checkTouchType(beganPos, movedPos)

			if self._isDrag and not self._isOnOwn then
				self:createMovingPet(sender, 1, 1)
				self:changeMovingPetPos(beganPos)

				if self._petNodeList[sender:getTag()] then
					self._petNodeList[sender:getTag()]:setVisible(false)
				end
			end
		elseif self._isDrag and not self._isOnOwn then
			self:changeMovingPetPos(movedPos)
		end
	elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
		if self:checkIsDefaultHero(sender) then
			return
		end

		if self._petNodeList[sender:getTag()] then
			self._petNodeList[sender:getTag()]:setVisible(true)
		end

		self._isDrag = false

		if not self._isOnOwn then
			self._isOnOwn = true

			self:removeTeamPet(sender:getTag())
		end

		self._movingPet:removeAllChildren()
	end
end

function StagePracticeTeamMediator:removeTeamPet(index)
	self._movingPet:removeAllChildren()
	self:cleanTeamPet(#self._teamPets)

	local id = self._teamPets[index]

	self._petList[#self._petList + 1] = self._teamPets[index]
	self._petListAll[#self._petListAll + 1] = self._teamPets[index]

	table.remove(self._teamPets, index)
	self:refreshListView()
	self:refreshPetNode()
	self:runRemovePetAction(id)
end

function StagePracticeTeamMediator:cleanTeamPet(num)
	local teamBg = self._bg:getChildByName("team_bg")

	for i = 1, num do
		local iconBg = teamBg:getChildByName("pet_" .. i)

		iconBg:removeAllChildren()
	end
end

function StagePracticeTeamMediator:refreshView()
	self:initData()
	self:refreshMasterInfo()
	self:refreshListView()
	self:refreshPetNode()
end

function StagePracticeTeamMediator:refreshListView()
	local offsetX = self._teamView:getContentOffset().x + self._myPetClone:getContentSize().width

	if offsetX > 0 then
		offsetX = 0
	end

	self._teamView:reloadData()

	local minOffsetX = self._teamView:minContainerOffset().x

	self._teamView:setContentOffset(cc.p(offsetX, 0))
end

function StagePracticeTeamMediator:initHero(node, info)
	info.id = info.roleModel

	local heroImg = IconFactory:createRoleIconSpriteNew(info)

	heroImg:setScale(0.68)

	local heroPanel = node:getChildByName("hero")

	heroPanel:removeAllChildren()
	heroImg:addTo(heroPanel):center(heroPanel:getContentSize())

	local bg1 = node:getChildByName("bg1")
	local bg2 = node:getChildByName("bg2")

	bg1:loadTexture(GameStyle:getHeroRarityBg(info.rareity)[1])
	bg2:loadTexture(GameStyle:getHeroRarityBg(info.rareity)[2])
	bg1:removeAllChildren()
	bg2:removeAllChildren()

	if kHeroRarityBgAnim[info.rareity] then
		local anim = cc.MovieClip:create(kHeroRarityBgAnim[info.rareity])

		anim:addTo(bg1):center(bg1:getContentSize())
		anim:setPosition(cc.p(bg1:getContentSize().width / 2 - 1, bg1:getContentSize().height / 2 - 30))

		if info.rareity == 15 then
			anim:setPosition(cc.p(bg1:getContentSize().width / 2 - 3, bg1:getContentSize().height / 2))
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

	rarity:removeAllChildren()

	local rarityAnim = IconFactory:getHeroRarityAnim(info.rareity)

	rarityAnim:addTo(rarity):posite(25, 15)

	local cost = node:getChildByFullName("costBg.cost")

	cost:setString(info.cost)

	local occupationName, occupationImg = GameStyle:getHeroOccupation(info.type)
	local occupation = node:getChildByName("occupation")

	occupation:loadTexture(occupationImg)

	local levelImage = node:getChildByName("levelImage")
	local level = node:getChildByName("level")

	level:setString(Strings:get("Strenghten_Text78", {
		level = info.level
	}))

	local levelImageWidth = levelImage:getContentSize().width
	local levelWidth = level:getContentSize().width

	levelImage:setScaleX((levelWidth + 20) / levelImageWidth)

	local starBg = node:getChildByName("starBg")

	for i = 1, HeroStarCountMax do
		local star = starBg:getChildByName("star_" .. i)

		star:setVisible(i <= info.maxStar)

		local starImage = i <= info.star and "asset/common/common_icon_small01.png" or "asset/common/common_icon_small02.png"

		star:loadTexture(starImage)
	end

	local namePanel = node:getChildByFullName("namePanel")
	local name = namePanel:getChildByName("name")
	local qualityLevel = namePanel:getChildByName("qualityLevel")

	name:setString(info.name)
	qualityLevel:setString(info.qualityLevel == 0 and "" or " +" .. info.qualityLevel)
	name:setPositionX(0)
	qualityLevel:setPositionX(name:getContentSize().width)
	namePanel:setContentSize(cc.size(name:getContentSize().width + qualityLevel:getContentSize().width, 30))
	GameStyle:setHeroNameByQuality(name, info.quality)
	GameStyle:setHeroNameByQuality(qualityLevel, info.quality)
end

function StagePracticeTeamMediator:refreshPetNode()
	self:refreshCombatAndCost()

	self._petNodeList = {}

	for i = 1, self._maxTeamPetNum do
		local iconBg = self._teamBg:getChildByName("pet_" .. i)

		iconBg:removeAllChildren()
		iconBg:setTag(i)
		iconBg:addTouchEventListener(function(sender, eventType)
			self:onClickOnTeamPet(sender, eventType)
		end)

		if self._teamPets[i] then
			local heroInfo = self:getHeroInfoById(self._teamPets[i])

			self._petNodeList[i] = self._teamPetClone:clone()

			self._petNodeList[i]:setVisible(true)
			self:initTeamHero(self._petNodeList[i], heroInfo)
			self._petNodeList[i]:addTo(iconBg):center(iconBg:getContentSize())
			self._petNodeList[i]:offset(0, -9)

			self._petNodeList[i].id = self._teamPets[i]

			iconBg:setTouchEnabled(true)

			iconBg.id = self._teamPets[i]
		else
			local emptyIcon = GameStyle:createEmptyIcon()

			emptyIcon:addTo(iconBg):center(iconBg:getContentSize())

			local tipLabel = emptyIcon:getChildByName("TipText")

			tipLabel:setString("")
			iconBg:setTouchEnabled(false)
		end
	end
end

function StagePracticeTeamMediator:refreshEnemyHero()
	self._enemyHeroList = {}

	for i = 1, self._maxTeamEnemyHeroNum do
		local iconBg = self._teamBg:getChildByName("pet_" .. i)

		iconBg:removeAllChildren()
		iconBg:setTouchEnabled(false)
		iconBg:setTag(i)

		if self._enemyTeamPets[i] then
			local heroInfo = self:getHeroInfoById(self._enemyTeamPets[i])

			self._enemyHeroList[i] = self._teamPetClone:clone()

			self._enemyHeroList[i]:setVisible(true)
			self:initTeamHero(self._enemyHeroList[i], heroInfo)
			self._enemyHeroList[i]:addTo(iconBg):center(iconBg:getContentSize())
			self._enemyHeroList[i]:offset(0, -9)

			iconBg.id = self._enemyTeamPets[i]
		else
			local emptyIcon = GameStyle:createEmptyIcon()

			emptyIcon:addTo(iconBg):center(iconBg:getContentSize())
		end
	end
end

function StagePracticeTeamMediator:initTeamHero(node, info)
	info.heroBaseId = info.id
	info.id = info.roleModel

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

	if info.heroBaseId ~= "BBLMa" then
		return
	end

	local skillPanel = node:getChildByName("skillPanel")
	local passiveSkill = ConfigReader:getDataByNameIdAndKey("EnemyHero", info.rawId, "PassiveSkill")

	skillPanel:setVisible(false)

	if passiveSkill then
		local config = ConfigReader:getRecordById("Skill", passiveSkill[1])

		if config then
			local skill = {}

			function skill:getType()
				return "BATTLEPASSIVE"
			end

			function skill:getName()
				return Strings:get(config.Name)
			end

			function skill:getDesc()
				return Strings:get(config.Desc)
			end

			function skill:getSkillProId()
				return passiveSkill[1]
			end

			function skill:getLevel()
				return 1
			end

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

					image:addTo(skillPanel):center(skillPanel:getContentSize())
					image:setName("KeyMark")
					image:setScale(0.85)
					image:offset(0, -5)
				end
			end
		end
	end
end

function StagePracticeTeamMediator:onClickHeroSkill(skill, sender, adjustPos)
	self._skillDescPanel:setVisible(true)

	if not self._skillWidget then
		self._skillWidget = self:autoManageObject(self:getInjector():injectInto(SkillTipWidget:new(SkillTipWidget:createWidgetNode(), {
			skill = skill,
			mediator = self
		})))

		self._skillWidget:getView():addTo(self._skillDescPanel)
	end

	self._skillWidget:refreshInfo(skill, true)

	local targetPos = sender:getParent():convertToWorldSpace(cc.p(sender:getPosition()))

	targetPos = self._skillWidget:getView():getParent():convertToNodeSpace(targetPos)

	local posX = targetPos.x - 15
	local posY = 330 + self._skillWidget:getHeight()

	if adjustPos then
		posX = targetPos.x - self._skillWidget:getWidth() - 20
		posY = targetPos.y + 60
	end

	self._skillWidget:getView():setPosition(cc.p(posX, posY))
end

function StagePracticeTeamMediator:refreshCombatAndCost()
	local totalCost = 0

	for k, v in pairs(self._teamPets) do
		local heroInfo = self._stagePracticeSystem:getEnemyHeroById(v)

		totalCost = totalCost + heroInfo:getCost()
	end

	self._costTotal = totalCost

	self._costAverageLabel:setString(#self._teamPets == 0 and 0 or math.floor(totalCost * 10 / #self._teamPets + 0.5) / 10)
	self._costTotalLabel:setString(self._costTotal)
	self._costTotalLimitLabel:setPositionX(self._costTotalLabel:getPositionX() + self._costTotalLabel:getContentSize().width)
end

function StagePracticeTeamMediator:changeMasterId(event)
	self._oldMasterId = self._curMasterId
	self._curMasterId = event:getData().masterId

	self:refreshMasterInfo()
end

function StagePracticeTeamMediator:refreshMasterInfo()
	self._masterImage:removeAllChildren()

	local roleModel = IconFactory:getRoleModelByKey("MasterBase", self._curMasterId)
	local sprite = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe6_3",
		id = roleModel
	})

	sprite:setAnchorPoint(cc.p(0, 0))
	self._masterImage:addChild(sprite)
	self._roleName:setString(self:getName(self._curMasterId))
	self:refreshCombatAndCost()

	local masterBaseId
	local info = ConfigReader:getRecordById("EnemyMaster", self._practiceType == 1 and self:getConfigMasterId(self._stagePoint:getId()) or self._stagePoint:getSelfMaster())
	local passiveSkill = info.PassiveSkill

	if passiveSkill and #passiveSkill ~= 0 and not self._masterSkillPanel:getChildByName("KeyMark") then
		local icon1, icon2 = self._masterSystem:getSkillTypeIcon("PassiveSkill")
		local image = ccui.ImageView:create(icon1)

		image:addTo(self._masterSkillPanel)
		image:setName("KeyMark")
		image:setPosition(cc.p(30, 0))
		image:setTouchEnabled(true)
		image:addClickEventListener(function()
			local skill = {}

			function skill:getName()
				local strId = ConfigReader:getDataByNameIdAndKey("Skill", passiveSkill[1], "Name")

				return Strings:get(strId)
			end

			function skill:getLevel()
				return 1
			end

			function skill:getSkillType()
				return "PassiveSkill"
			end

			function skill:getMasterSkillDescKey()
				local pf = PrototypeFactory:getInstance():getSkillPrototype(passiveSkill[1])
				local config = pf:getConfig()

				return config.Desc
			end

			function skill:getId()
				return passiveSkill[1]
			end

			function skill:getSkillProId()
				return passiveSkill[1]
			end

			self:onClickMasterSkill(skill)
		end)
	end
end

function StagePracticeTeamMediator:onClickMasterSkill(skill)
	self._skillDescPanel:setVisible(true)

	if not self._skillWidget then
		self._skillWidget = self:autoManageObject(self:getInjector():injectInto(SkillTipWidget:new(SkillTipWidget:createWidgetNode(), {
			skill = skill,
			mediator = self
		})))

		self._skillWidget:getView():addTo(self._skillDescPanel)
	end

	local targetPos = self._masterSkillPanel:getParent():convertToWorldSpace(cc.p(self._masterSkillPanel:getPosition()))

	targetPos = self._skillWidget:getView():getParent():convertToNodeSpace(targetPos)

	local posX = targetPos.x - 25

	self._skillWidget:refreshInfo(skill)
	self._skillWidget:getView():setPosition(cc.p(posX, 670))
end

function StagePracticeTeamMediator:refreshEnemyMasterInfo()
	self._masterImage:removeAllChildren()

	local roleModel = IconFactory:getRoleModelByKey("MasterBase", self._curMasterId)
	local sprite = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe6_3",
		id = roleModel
	})

	sprite:setAnchorPoint(cc.p(0, 0))
	self._masterImage:addChild(sprite)
	self._roleName:setString(self:getName(self._curMasterId))
end

function StagePracticeTeamMediator:getHeroInfoById(id)
	local heroInfo = self._stagePracticeSystem:getEnemyHeroById(id)

	if not heroInfo then
		return nil
	end

	return {
		id = string.split(heroInfo:getId(), "_")[2],
		level = heroInfo:getLevel(),
		star = heroInfo:getStar(),
		quality = heroInfo:getQuality(),
		rareity = heroInfo:getRarity(),
		qualityLevel = heroInfo:getQualityLevel(),
		name = heroInfo:getName(),
		roleModel = heroInfo:getModel(),
		type = heroInfo:getType(),
		cost = heroInfo:getCost(),
		maxStar = heroInfo:getMaxStar(),
		littleStar = heroInfo:getLittleStar()
	}
end

function StagePracticeTeamMediator:getName(masterid)
	return Strings:get(ConfigReader:getDataByNameIdAndKey("MasterBase", masterid, "Name"))
end

function StagePracticeTeamMediator:createCostTip()
	local panel = self:getView():getChildByFullName("CostTip")

	if not panel then
		panel = ccui.Widget:create()

		panel:setAnchorPoint(cc.p(0.5, 0.5))
		panel:setContentSize(cc.size(1386, 852))
		panel:setTouchEnabled(true)
		panel:setSwallowTouches(false)
		panel:addClickEventListener(function()
			if panel:isVisible() then
				panel:setVisible(false)
			end
		end)
		panel:addTo(self:getView()):posite(568, 320)

		local bg = ccui.Scale9Sprite:createWithSpriteFrameName("common_bg_tips.png")

		bg:setCapInsets(cc.rect(5, 5, 5, 5))
		bg:setAnchorPoint(cc.p(0, 1))
		bg:addTo(panel):setPosition(cc.p(365, 603))
		bg:setName("CostTipBg")

		local value = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Fight_MaxCostBuff_Rule", "content")
		local contentText = ccui.RichText:createWithXML(Strings:get(value, {
			fontName = TTF_FONT_FZYH_R
		}), {})

		contentText:setAnchorPoint(cc.p(0, 1))
		contentText:renderContent(486, 0)

		local size = contentText:getContentSize()
		local height = size.height

		bg:setContentSize(cc.size(516, height + 30))
		contentText:addTo(bg):posite(15, height + 15)
	end

	panel:setVisible(true)
end

function StagePracticeTeamMediator:onClickFight(sender, eventType)
	if #self._teamPets < 1 then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("ARENA_TEMA_EMPTY")
		}))

		return false
	end

	self:sendSpChangeTeam()
end

function StagePracticeTeamMediator:sendSpChangeTeam()
	local sendData = {}
	local hasHero = false

	for k, v in pairs(self._teamPets) do
		sendData[k] = {}
		sendData[k].id = v
		hasHero = true
	end

	if not hasHero then
		table.insert(sendData, {})
	end

	local masterId = self._practiceType == 1 and self:getConfigMasterId(self._stagePoint:getId()) or self._stagePoint:getSelfMaster()
	local params = {
		mapId = self._stagePoint._mapId,
		pointId = self._stagePoint._id,
		masterId = masterId,
		heros = sendData
	}

	if self._practiceType == 1 then
		self._stagePracticeSystem:requestPracticeBattleBefor(params.mapId, params.pointId, params.heros, params.masterId, nil)
	else
		self._stagePracticeSystem:requestStageBattleBefore(params.pointId, params.heros, params.masterId, nil)
	end
end

function StagePracticeTeamMediator:onClickBack(sender, eventType, oppoRecord)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:dispatch(Event:new(EVT_RETURN_VIEW))
		self:dismiss()
	end
end

function StagePracticeTeamMediator:onClickShowEnemy()
	if self._teamType == 1 then
		self._teamType = 2

		self._infoBg:setVisible(false)
		self:refreshBtnLabel(self._teamType)
		self:refreshEnemyHero()
		self:refreshEnemyMasterInfo()
	end
end

function StagePracticeTeamMediator:onClickShowMy()
	self._teamType = 1

	self._infoBg:setVisible(true)
	self:refreshBtnLabel(self._teamType)
	self:initLockIcons()
	self:refreshPetNode()
	self:refreshMasterInfo()
end

function StagePracticeTeamMediator:refreshBtnLabel(teamType)
	if teamType == 1 then
		self._tipImage:setPositionX(self._enemyBtn_my:getPositionX())
		self._enemyBtn_my:getChildByFullName("text"):setColor(cc.c3b(255, 255, 255))
		self._enemyBtn_my:getChildByFullName("text"):setFontSize(24)
		self._enemyBtn_enemy:getChildByFullName("text"):setColor(cc.c3b(195, 195, 195))
		self._enemyBtn_enemy:getChildByFullName("text"):setFontSize(20)
	elseif teamType == 2 then
		self._tipImage:setPositionX(self._enemyBtn_enemy:getPositionX())
		self._enemyBtn_enemy:getChildByFullName("text"):setColor(cc.c3b(255, 255, 255))
		self._enemyBtn_enemy:getChildByFullName("text"):setFontSize(24)
		self._enemyBtn_my:getChildByFullName("text"):setColor(cc.c3b(195, 195, 195))
		self._enemyBtn_my:getChildByFullName("text"):setFontSize(20)
	end
end

function StagePracticeTeamMediator:onClickGuide(sender, eventType)
	local descs = self._stagePoint:getGuideDesc()
	local view = self:getInjector():getInstance("StagePracticeSpecialRuleView")
	local tab = {}

	tab[1] = self._stagePoint:getName()
	tab[2] = descs

	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		ruleList = tab
	})

	self:dispatch(event)
end

function StagePracticeTeamMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local fightBtn = self:getView():getChildByFullName("main.spStagePanel.fightBtn")

		if fightBtn then
			storyDirector:setClickEnv("StagePracStagePracticeTeamtice.fightBtn", fightBtn, function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Click_Battle", false)
				self:onClickFight(sender, eventType)
			end)
		end

		storyDirector:notifyWaiting("enter_StagePracticeTeam_view")
	end))

	self:getView():runAction(sequence)
end

function StagePracticeTeamMediator:runRemovePetAction(id)
	local index, child
	local children = self._teamView:getContainer():getChildren()

	for i = 1, #children do
		if id == children[i].id then
			index = i

			break
		end
	end

	if not index then
		return
	end

	print(" runRemovePetAction child______ " .. index)

	if not self._removeAction then
		-- block empty
	end

	local node = children[index]:getChildByTag(12138)

	child = node:getChildByFullName("myPetClone")

	if child then
		child:setVisible(false)
		self._main:removeChildByName("CloneNode2")

		local cloneNode = child:clone()

		cloneNode:setVisible(true)
		cloneNode:addTo(self._main)
		cloneNode:setAnchorPoint(cc.p(0.5, 0.5))
		cloneNode:setName("CloneNode2")

		local targetPos = child:getParent():convertToWorldSpace(cc.p(child:getPosition()))

		targetPos = cloneNode:getParent():convertToNodeSpace(targetPos)

		cloneNode:setPosition(cc.p(targetPos.x, targetPos.y))

		local heroNode = cloneNode:getChildByFullName("hero")

		heroNode:removeAllChildren()

		local anim = cc.MovieClip:create("changkapianfanzhuan_biandui")

		anim:addTo(heroNode)
		anim:setPosition(cc.p(65, 100))

		heroNode = anim:getChildByFullName("hero")

		heroNode:removeAllChildren()

		local id = node.id
		local heroInfo = self:getHeroInfoById(id)

		heroInfo.id = heroInfo.roleModel

		local heroImg = IconFactory:createRoleIconSpriteNew(heroInfo)

		heroImg:setScale(0.68)
		heroImg:addTo(heroNode)
		heroImg:offset(2.5, -31.5)

		local starBg_node = cloneNode:getChildByFullName("starBg")
		local star1_node = starBg_node:getChildByFullName("star_1")
		local star2_node = starBg_node:getChildByFullName("star_2")
		local star3_node = starBg_node:getChildByFullName("star_3")
		local star4_node = starBg_node:getChildByFullName("star_4")
		local star5_node = starBg_node:getChildByFullName("star_5")
		local star6_node = starBg_node:getChildByFullName("star_6")
		local levelImage_node = cloneNode:getChildByFullName("levelImage")
		local level_node = cloneNode:getChildByFullName("level")
		local costBg_node = cloneNode:getChildByFullName("costBg")
		local bg_bg = cloneNode:getChildByFullName("bg1")
		local bg2_bg = cloneNode:getChildByFullName("bg2")
		local rarity_node = cloneNode:getChildByFullName("rarityBg")
		local nameBg1_node = cloneNode:getChildByFullName("nameBg")
		local occupationBg_node = cloneNode:getChildByFullName("occupationBg")
		local occupation_node = cloneNode:getChildByFullName("occupation")
		local skillPanel_node = cloneNode:getChildByFullName("skillPanel")
		local nameBg_node = cloneNode:getChildByFullName("namePanel")
		local recommond_node = cloneNode:getChildByFullName("recommond")
		local except_node = cloneNode:getChildByFullName("except")
		local detailBtn_node = cloneNode:getChildByFullName("detailBtn")
		local teamNum_node = cloneNode:getChildByFullName("teamNum")

		anim:gotoAndPlay(4)
		anim:setPlaySpeed(1.2)

		local starBg = anim:getChildByName("starBg")
		local level = anim:getChildByName("level")
		local costBg = anim:getChildByName("costBg")
		local bg = anim:getChildByFullName("bg")
		local rarity = anim:getChildByFullName("rarity")
		local occupation = anim:getChildByFullName("occupation")
		local star1 = starBg_node:getChildByFullName("star_1")
		local star2 = starBg_node:getChildByFullName("star_2")
		local star3 = starBg_node:getChildByFullName("star_3")
		local star4 = starBg_node:getChildByFullName("star_4")
		local nodeToActionNodeMap = {}

		nodeToActionNodeMap[starBg_node] = starBg
		nodeToActionNodeMap[levelImage_node] = level
		nodeToActionNodeMap[level_node] = level
		nodeToActionNodeMap[costBg_node] = costBg
		nodeToActionNodeMap[bg_bg] = bg
		nodeToActionNodeMap[bg2_bg] = bg
		nodeToActionNodeMap[rarity_node] = rarity
		nodeToActionNodeMap[occupation_node] = occupation
		nodeToActionNodeMap[occupationBg_node] = occupation
		nodeToActionNodeMap[nameBg1_node] = occupation
		nodeToActionNodeMap[nameBg_node] = occupation
		nodeToActionNodeMap[star1_node] = star1
		nodeToActionNodeMap[star2_node] = star2
		nodeToActionNodeMap[star3_node] = star3
		nodeToActionNodeMap[star4_node] = star4
		nodeToActionNodeMap[star5_node] = starBg_node:getChildByFullName("star_5")
		nodeToActionNodeMap[star6_node] = starBg_node:getChildByFullName("star_6")

		if recommond_node then
			nodeToActionNodeMap[recommond_node] = occupation
		end

		if except_node then
			nodeToActionNodeMap[except_node] = occupation
		end

		if teamNum_node then
			nodeToActionNodeMap[teamNum_node] = occupation
		end

		if detailBtn_node then
			nodeToActionNodeMap[detailBtn_node] = occupation
		end

		local startfunc, stopfunc = CommonUtils.bindNodeToActionNode(nodeToActionNodeMap, self._main)

		startfunc()
		anim:addCallbackAtFrame(17, function()
			anim:stop()
			child:setVisible(true)
			stopfunc()
			self._main:removeChildByName("CloneNode2")

			if self._removeAction then
				self._removeAction = false
			end
		end)
	end
end

function StagePracticeTeamMediator:runInsertTeamAction(id)
	local index

	for i = 1, #self._petNodeList do
		local node = self._petNodeList[i]

		if node and node.id == id then
			index = i

			break
		end
	end

	if not index then
		return
	end

	self._runInsertTeamAction = true

	self._petNodeList[index]:setVisible(false)
	print(" runInsertTeamAction child______ ")
	self._main:removeChildByName("CloneNode1")

	local cloneNode = self._petNodeList[index]:clone()

	cloneNode:setVisible(true)
	cloneNode:addTo(self._main)
	cloneNode:setAnchorPoint(cc.p(0.5, 0.5))
	cloneNode:setName("CloneNode1")

	local targetPos = self._petNodeList[index]:getParent():convertToWorldSpace(cc.p(self._petNodeList[index]:getPosition()))

	targetPos = cloneNode:getParent():convertToNodeSpace(targetPos)

	cloneNode:setPosition(cc.p(targetPos.x, targetPos.y))

	local heroNode = cloneNode:getChildByFullName("hero")

	heroNode:removeAllChildren()

	local anim = cc.MovieClip:create("rubian_biandui")

	anim:addTo(heroNode)
	anim:setPosition(cc.p(68, 63.5))

	heroNode = anim:getChildByFullName("hero")

	heroNode:removeAllChildren()

	local heroInfo = self:getHeroInfoById(id)

	heroInfo.id = heroInfo.roleModel

	local heroImg = IconFactory:createRoleIconSpriteNew(heroInfo)

	heroImg:addTo(heroNode)
	heroImg:setScale(0.68)

	local costBg_node = cloneNode:getChildByFullName("costBg")
	local bg_bg1 = cloneNode:getChildByFullName("bg1")
	local bg_bg2 = cloneNode:getChildByFullName("bg2")
	local rarity_node = cloneNode:getChildByFullName("rarityBg")
	local occupationBg = cloneNode:getChildByFullName("occupationBg")
	local occupation_node = cloneNode:getChildByFullName("occupation")
	local skillPanel_node = cloneNode:getChildByFullName("skillPanel")
	local recommond_node = cloneNode:getChildByFullName("recommond")

	anim:gotoAndPlay(0)
	anim:setPlaySpeed(1.2)

	local costBg = anim:getChildByName("costBg")
	local bg = anim:getChildByFullName("bg")
	local rarity = anim:getChildByFullName("rarity")
	local occupation = anim:getChildByFullName("occupation")
	local nodeToActionNodeMap = {}

	nodeToActionNodeMap[costBg_node] = costBg
	nodeToActionNodeMap[bg_bg1] = bg
	nodeToActionNodeMap[bg_bg2] = bg
	nodeToActionNodeMap[rarity_node] = rarity
	nodeToActionNodeMap[occupation_node] = occupation
	nodeToActionNodeMap[occupationBg] = occupation
	nodeToActionNodeMap[skillPanel_node] = occupation

	if recommond_node then
		nodeToActionNodeMap[recommond_node] = occupation
	end

	local startfunc, stopfunc = CommonUtils.bindNodeToActionNode(nodeToActionNodeMap, self._main)

	startfunc()
	anim:addCallbackAtFrame(19, function()
		anim:stop()
		self._petNodeList[index]:setVisible(true)

		if self._petNodeList[index]:getParent():getChildByName("EmptyIcon") then
			self._petNodeList[index]:getParent():getChildByName("EmptyIcon"):setVisible(false)
		end

		stopfunc()
		self._main:removeChildByName("CloneNode1")

		self._runInsertTeamAction = false

		if self._runInsertAction then
			self._runInsertPetAction = nil
			self._runInsertAction = false
		end
	end)
end
