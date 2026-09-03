-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerTeamMediator.lua

require("dm.gameplay.stage.view.CommonTeamMediator")

TowerTeamMediator = class("TowerTeamMediator", CommonTeamMediator, _M)

TowerTeamMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
TowerTeamMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
TowerTeamMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
TowerTeamMediator:has("_towerSystem", {
	is = "r"
}):injectWith("TowerSystem")

local kBtnHandlers = {
	["main.button_rule"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRule"
	}
}
local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}
local StarBuffNum = ConfigReader:getRecordById("ConfigValue", "Tower_1_Star_Buff_Minimum_Star").content

function TowerTeamMediator:onRegister()
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

	self.mapEventListener(self, self:getEventDispatcher(), EVT_TEAM_REFRESH_PETS, self, self.refreshViewBySort)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ARENA_CHANGE_TEAM_SUCC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshCombatAndCost)
end

function TowerTeamMediator:enterWithData(data)
	data = data or {
		stageType = StageTeamType.STAGE_NORMAL
	}
	self._data = data

	if data and data.stageType then
		self._stageType = data.stageType or ""
	end

	if data and data.tabType then
		self._curTabType = data.tabType or 1
	end

	self._stageSystem:setTowerCardSortType(1)

	self._isDrag = false
	self._costTotal = 0
	self._costMaxNum = 9999999
	self._maxTeamPetNum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tower_1_HeroValue", "content")
	self._teamUnlockConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Stage_Team_Unlock", "content")

	self._stageSystem:setSortExtand(0)
	self:initData()
	self:setupTopInfoWidget()
	self:updateTopInfoTitle(Strings:get(self._towerData:getTowerBase():getConfig().Name))
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

function TowerTeamMediator:resumeWithData()
	return
end

function TowerTeamMediator:initData()
	self._curMasterId = self._towerSystem:getCurMasterId()

	local d = self._towerSystem:getTowerDataById(self._towerSystem:getCurTowerId())

	if not d then
		return
	end

	self._towerData = d
	self._masterData = d:getInitMasterDataByMasterId(self._curMasterId)
	self._teamMaster = d:getTeam():getMaster()
	self._teamPets = {}
	self._tempTeams = {}
	self._petList = self._stageSystem:getNotOnTeamPet(self._teamPets)
	self._petListAll = {}

	table.copy(self._petList, {})
end

function TowerTeamMediator:updateData()
	self._petList = self._stageSystem:getNotOnTeamPet(self._teamPets)
	self._petListAll = {}

	table.copy(self._petList, {})
end

function TowerTeamMediator:showOneKeyHeroes()
	local orderPets = self._towerSystem:getTeamPrepared(self._teamPets, self._petList)

	self._orderPets = {}
	self._leavePets = {}

	local cost = 0

	for i = 1, #orderPets do
		if #self._orderPets < self._maxTeamPetNum then
			if cost + self._heroSystem:getHeroById(orderPets[i]):getCost() <= self._costMaxNum then
				cost = cost + self._heroSystem:getHeroById(orderPets[i]):getCost()
				self._orderPets[#self._orderPets + 1] = orderPets[i]

				goto label_7_0
			end
		end

		self._leavePets[#self._leavePets + 1] = orderPets[i]

		::label_7_0::
	end
end

function TowerTeamMediator:setupView()
	self:initLockIcons()
	self:refreshPetNode()
	self:initView()
	self:refreshListView()
	self:createSortView()
	self:setMasterView()
end

function TowerTeamMediator:initLockIcons()
	local maxShowNum = 10

	for i = self._maxTeamPetNum + 1, maxShowNum do
		local iconBg = self._teamBg:getChildByName("pet_" .. i)

		iconBg:removeAllChildren()

		local emptyIcon = GameStyle:createEmptyIcon(true)

		emptyIcon:addTo(iconBg):center(iconBg:getContentSize())

		local tipLabel = emptyIcon:getChildByName("TipText")

		tipLabel:setString(Strings:get("StagePractice_UI_Lock"))

		local width, height = iconBg:getContentSize().width, iconBg:getContentSize().height
		local lockImg = ccui.ImageView:create("suo_icon_s_battle.png", 1)

		lockImg:addTo(iconBg):posite(width - 7, height - 6)
	end
end

function TowerTeamMediator:setMasterView()
	local panel = self:getView():getChildByFullName("main.roleClone")
	local detail = panel:getChildByFullName("Button_Details")

	detail:addClickEventListener(function(sender)
		self:onClickDetails(sender)
	end)

	local info = {
		frameId = "bustframe4_3",
		id = self._masterData:getModel()
	}
	local masterIcon = IconFactory:createRoleIconSpriteNew(info)

	masterIcon:setAnchorPoint(cc.p(0, 0))
	masterIcon:setPosition(cc.p(0, 0))
	panel:getChildByFullName("Panel_role_image"):addChild(masterIcon)
	masterIcon:setScale(1)
	panel:getChildByFullName("Text_name"):setString(self._masterData:getName())
	panel:getChildByFullName("Text_desc"):setString(self._masterData:getFeature())

	local panelSkill = self:getView():getChildByFullName("main.roleClone.Panel_skill")

	panelSkill:setTouchEnabled(true)
	panelSkill:setSwallowTouches(true)
	panelSkill:addClickEventListener(function()
		self:onClickMasterSkill()
	end)
	self:checkMasterSkillActive()
	GameStyle:setCommonOutlineEffect(panel:getChildByFullName("Text_147_0_0"))
	GameStyle:setCommonOutlineEffect(panel:getChildByFullName("Text_147_1"))
	GameStyle:setCommonOutlineEffect(panel:getChildByFullName("Text_desc"))
end

function TowerTeamMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")

	self._main:getChildByFullName("text"):setString(Strings:get("Tower_1_UI_1", {
		Num = self._maxTeamPetNum
	}))

	self._qipao = self:getView():getChildByFullName("qipao")

	self._qipao:setVisible(false)
	self._qipao:setLocalZOrder(100)

	self._touchPanel = self:getView():getChildByFullName("touchPanel")

	self._touchPanel:setVisible(false)

	self._myPetPanel = self._main:getChildByFullName("my_pet_bg")
	self._heroPanel = self._myPetPanel:getChildByFullName("heroPanel")
	self._sortType = self._myPetPanel:getChildByFullName("sortPanel.sortBtn.text")
	self._teamBg = self._main:getChildByName("team_bg")
	self._labelCombat = self._main:getChildByFullName("info_bg.combatLabel")
	self._costAverageLabel = self._main:getChildByFullName("info_bg.averageLabel")
	self._costTotalLabel1 = self._main:getChildByFullName("info_bg.cost1")
	self._movingPet = self._main:getChildByFullName("moving_pet")
	self._btnPanel = self._main:getChildByName("btnPanel")
	self._textDes = self._main:getChildByFullName("text_des")

	self._textDes:setString(Strings:get("Tower_New_UI_20"))

	self._teamBreakBtn = self._main:getChildByFullName("info_bg.button_one_key_break")
	self._teamOneKeyBtn = self._main:getChildByFullName("info_bg.button_one_key_embattle")
	self._myPetClone = self:getView():getChildByName("myPetClone")

	self._myPetClone:setVisible(false)

	self._petSize = self._myPetClone:getChildByFullName("myPetClone"):getContentSize()
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
	self:setLabelEffect()
	self:ignoreSafeArea()

	local button_rule = self:getView():getChildByFullName("main.button_rule")

	button_rule:setPositionX(self._topInfoWidget:getTitleWidth() + 20)
end

function TowerTeamMediator:ignoreSafeArea()
	AdjustUtils.ignorSafeAreaRectForNode(self._heroPanel, AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._myPetPanel:getChildByName("sortPanel"), AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._main:getChildByFullName("btnPanel"), AdjustUtils.kAdjustType.Right)

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._heroPanel:setContentSize(cc.size(winSize.width - 177, 220))
end

function TowerTeamMediator:createTeamCell(cell, index)
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

function TowerTeamMediator:setLabelEffect()
	GameStyle:setCommonOutlineEffect(self._labelCombat)
	GameStyle:setCommonOutlineEffect(self._costTotalLabel1)
	GameStyle:setCommonOutlineEffect(self._costAverageLabel)
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("info_bg.text"))
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("info_bg.text_prior"))
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("text"))
end

function TowerTeamMediator:onClickCell(sender, eventType, index)
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

function TowerTeamMediator:changeOwnPet(cell)
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

	if self._guildCallback and targetIndex ~= 2 then
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

	if self._guildCallback then
		self._guildCallback()
	end
end

function TowerTeamMediator:insertTeamPet(cell, isDrag)
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

function TowerTeamMediator:createMovingPet(cell, type)
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

function TowerTeamMediator:sortOnTeamPets()
	return
end

function TowerTeamMediator:onClickOnTeamPet(sender, eventType)
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

function TowerTeamMediator:removeTeamPet(index)
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

function TowerTeamMediator:refreshViewBySort()
	self:updateData()
	self:refreshListView()
	self:refreshPetNode()
end

function TowerTeamMediator:refreshView()
	self:initData()
	self:refreshListView()
	self:refreshPetNode()
end

function TowerTeamMediator:refreshListView(ignoreAdjustOffset)
	self._petListAll = self._stageSystem:getSortExtendIds(self._petList)

	local sortType = self._stageSystem:getTowerCardSortType()

	self._heroSystem:sortHeroes(self._petListAll, sortType)

	local offsetX = self._teamView:getContentOffset().x + self._petSize.width

	if offsetX > 0 then
		offsetX = 0
	end

	self._teamView:reloadData()

	if not ignoreAdjustOffset then
		self._teamView:setContentOffset(cc.p(offsetX, 0))
	end
end

function TowerTeamMediator:initHero(node, info)
	local heroId = info.id

	super.initHero(self, node, info)
	node:getChildByName("level"):setVisible(false)
	node:getChildByName("levelImage"):setVisible(false)

	local text_combat = node:getChildByFullName("image_combat_bg.text_combat")
	local bonusType_bg = node:getChildByFullName("bonusType_bg")
	local bonusType = node:getChildByFullName("bonusType_bg.bonusType")

	bonusType_bg:setVisible(info.awakenLevel > 0 or info.star >= StarBuffNum)

	if info.awakenLevel > 0 then
		bonusType:loadTexture("pt_word_juexing.png", ccui.TextureResType.plistType)
	elseif info.star >= StarBuffNum then
		bonusType:loadTexture("pt_word_jingjie.png", ccui.TextureResType.plistType)
	end

	text_combat:setString(self._towerSystem:getHeroTowerCombat()[heroId])
	GameStyle:setCommonOutlineEffect(text_combat)

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

function TowerTeamMediator:refreshPetNode()
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

function TowerTeamMediator:initTeamHero(node, info)
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
	local bonusType_bg = node:getChildByFullName("bonusType_bg")
	local bonusType = node:getChildByFullName("bonusType_bg.bonusType")

	bonusType:loadTexture("pt_word_jingjie.png", ccui.TextureResType.plistType)
	bonusType_bg:setVisible(info.awakenLevel > 0 or info.star >= StarBuffNum)

	if info.awakenLevel > 0 then
		bonusType:loadTexture("pt_word_juexing.png", ccui.TextureResType.plistType)
	elseif info.star >= StarBuffNum then
		bonusType:loadTexture("pt_word_jingjie.png", ccui.TextureResType.plistType)
	end

	local rarityAnim = IconFactory:getHeroRarityAnim(info.rareity)

	rarityAnim:addTo(rarity):posite(25, 15)

	local cost = node:getChildByFullName("costBg.cost")

	cost:setString(info.cost)

	local occupationName, occupationImg = GameStyle:getHeroOccupation(info.type)
	local occupation = node:getChildByName("occupation")

	occupation:loadTexture(occupationImg)

	local skillPanel = node:getChildByName("skillPanel")
	local skill, condition = self._heroSystem:checkHasKeySkill(heroId)

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

		skillPanel:setGray(not isActive)

		if dicengEff then
			dicengEff:setVisible(isActive)
		end

		if shangcengEff then
			shangcengEff:setVisible(isActive)
		end
	end
end

function TowerTeamMediator:refreshCombatAndCost()
	local totalCombat = 0
	local totalCost = 0
	local averageCost = 0

	for k, v in pairs(self._teamPets) do
		local heroInfo = self._heroSystem:getHeroById(v)

		totalCost = totalCost + heroInfo:getCost()

		local curTowerCombat = self._towerSystem:getHeroTowerCombat()[v] or 0

		totalCombat = totalCombat + curTowerCombat
	end

	self._costTotal = totalCost
	averageCost = #self._teamPets == 0 and 0 or math.floor(totalCost * 10 / #self._teamPets + 0.5) / 10

	self._labelCombat:setString(totalCombat)
	self._costAverageLabel:setString(averageCost)
	self._costTotalLabel1:setString(self._costTotal)
end

function TowerTeamMediator:checkMasterSkillActive()
	self._skillActive = {}

	local panelSkill = self:getView():getChildByFullName("main.roleClone.Panel_skill")

	panelSkill:removeAllChildren()

	local skills = self._masterData:getSkillList()

	for i = 1, #skills do
		local skill = skills[i]

		if skill then
			local skillId = skill:getId()
			local info = {
				levelHide = true,
				id = skillId,
				skillType = skill:getSkillType()
			}
			local newSkillNode = IconFactory:createMasterSkillIcon(info)

			newSkillNode:setScale(0.33)
			newSkillNode:addTo(panelSkill)
			newSkillNode:setPosition(cc.p(12 + 46 * (i - 1), 15))

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
				self._skillActive[i] = false

				newSkillNode:setGray(true)
			end
		end
	end
end

function TowerTeamMediator:refreshButtons()
	self._teamBreakBtn:setVisible(self:checkButtonVisible())
	self._teamOneKeyBtn:setVisible(not self:checkButtonVisible())
end

function TowerTeamMediator:checkButtonVisible()
	if #self._teamPets < self._maxTeamPetNum then
		for i = 1, #self._petList do
			local cost = self._heroSystem:getHeroById(self._petList[i]):getCost()

			if self._costTotal + cost <= self._costMaxNum then
				return false
			end
		end
	end

	return true
end

function TowerTeamMediator:onClickOneKeyBreak()
	self._teamView:stopScroll()

	local ids = self._heroSystem:getTeamPrepared(self._teamPets, self._petList)

	self._teamPets = {}
	self._petList = {}

	table.copy(ids, self._petList)
	self:refreshListView()
	self:refreshPetNode()
end

function TowerTeamMediator:onClickFight(sender, eventType)
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

	local towerId = self._towerSystem:getCurTowerId()
	local masterId = self._curMasterId
	local heroIds = heros

	self._towerSystem:requestInitTowerTeam(towerId, masterId, heroIds, function()
		self:fightRequestCallBack()
	end)
end

function TowerTeamMediator:fightRequestCallBack()
	local towerId = self._towerSystem:getCurTowerId()

	self._towerSystem:showTowerPointView(towerId)
end

function TowerTeamMediator:onClickHeroDetail(id)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._towerSystem:showHeroDetailsView(id)
end

function TowerTeamMediator:onClickDetails(sender)
	local params = {
		master = self._masterData,
		towerData = self._towerData
	}

	self._towerSystem:showMasterDetailsView(params)
end

function TowerTeamMediator:onClickBack()
	self:dismiss()
end

function TowerTeamMediator:onClickRule()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tower_1_RuleText", "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule,
		ruleReplaceInfo = {
			time = TimeUtil:getSystemResetDate()
		}
	}))
end

function TowerTeamMediator:onClickMasterSkill()
	local params = {
		towerMaster = true,
		master = self._masterData,
		active = self._skillActive
	}
	local view = self:getInjector():getInstance("MasterLeaderSkillView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, params))
end

function TowerTeamMediator:onClickOneKeyEmbattle()
	self:showOneKeyHeroes()

	self._teamPets = {}
	self._petList = {}

	table.deepcopy(self._orderPets, self._teamPets)
	table.deepcopy(self._leavePets, self._petList)
	self:refreshListView()
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

function TowerTeamMediator:createSortView()
	local sortType = self._stageSystem:getTowerCardSortType()

	local function callBack(data)
		local sortStr = self._stageSystem:getSortTypeStr(data.sortType)

		self._sortType:setString(sortStr)
		self._stageSystem:setTowerCardSortType(data.sortType)
		self._teamView:stopScroll()
		self:refreshListView(true)
	end

	self._sortComponent = SortHeroListComponent:new({
		isHide = true,
		sortType = sortType,
		mediator = self,
		callBack = callBack
	})

	local sortStr = self._stageSystem:getSortTypeStr(sortType)

	self._sortType:setString(sortStr)
	self._sortComponent:getRootNode():addTo(self._myPetPanel:getChildByFullName("sortPanel"))
end

function TowerTeamMediator:onClickSort()
	self._stageSystem:setSortExtand(0)
	self._sortComponent:getRootNode():setVisible(true)
	self._sortComponent:refreshView()
	self._sortComponent:showNormal()
	self._teamView:stopScroll()
	self:refreshListView(true)
end

function TowerTeamMediator:onClickSortType()
	local sortOrder = self._stageSystem:getCardSortOrder()

	sortOrder = sortOrder == 1 and 2 or 1

	self._stageSystem:setCardSortOrder(sortOrder)
	self._teamView:stopScroll()
	self:refreshListView(true)
end
