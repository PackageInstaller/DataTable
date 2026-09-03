-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerTeamBattleMediator.lua

require("dm.gameplay.stage.view.CommonTeamMediator")

TowerTeamBattleMediator = class("TowerTeamBattleMediator", CommonTeamMediator, _M)

TowerTeamBattleMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
TowerTeamBattleMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
TowerTeamBattleMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
TowerTeamBattleMediator:has("_towerSystem", {
	is = "r"
}):injectWith("TowerSystem")

local costType = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_Cost_Type", "content")
local StarBuffNum = tonumber(ConfigReader:getRecordById("ConfigValue", "Tower_1_Star_Buff_Minimum_Star").content)
local kBtnHandlers = {
	["main.button_rule"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRule"
	},
	["main.spStagePanel.Button_hecheng"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickCompose"
	},
	["main.spStagePanel.Button_jiesuan"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickAccount"
	},
	["main.spStagePanel.Button_jiangli"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickAwards"
	},
	["main.spStagePanel.Button_buff"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickBuff"
	},
	["main.spStagePanel.Button_difang"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickEnemy"
	}
}
local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}
local petScale = 0.7
local teamScale = 0.64

function TowerTeamBattleMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._fightBtn = self:bindWidget("main.btnPanel.fightBtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onClickFight, self)
		}
	})
end

function TowerTeamBattleMediator:enterWithData(data)
	self:initData()
	self:setupTopInfoWidget()
	self:updateTopInfoTitle(Strings:get(self._towerData:getTowerBase():getConfig().Name))
	self:initWidgetInfo()
	self:setupView(true)

	local delayTime = 0.001

	performWithDelay(self:getView(), function()
		self:reloadListView()
		self:runStartAction()
	end, delayTime)
end

function TowerTeamBattleMediator:resumeWithData()
	self:refreshView()
end

function TowerTeamBattleMediator:initData()
	local tower = self._towerSystem:getTowerDataById(self._towerSystem:getCurTowerId())

	self._towerData = tower

	local point = tower:getBattlePointData()
	local towerEnemy = point:getTowerEnemy()

	self._isDrag = false
	self._costTotal = 0
	self._costMaxNum = towerEnemy:getPlayerCost()
	self._maxTeamPetNum = towerEnemy:getPlayerCardAmount()
	self._curTeam = tower:getTeam()
	self._enemyCombat = tower:getBattlePointData():getCombat()
	self._curMasterData = self._curTeam:getMaster()
	self._masterData = self._curMasterData
	self._curMasterId = self._curMasterData:getId()
	self._name = towerEnemy:getName()
	self._enemyIndex = tower:getBattleIndex()
	self._teamPets = {}
	self._tempTeams = {}

	local d = self._curTeam:getTeamHeroes()

	for id, v in pairs(d) do
		self._teamPets[id] = v
		self._tempTeams[id] = v
	end

	self._petList = {}

	for id, v in pairs(self._curTeam:getUnTeamHeroes()) do
		self._petList[#self._petList + 1] = v
	end

	self:sortOnTeamPets(self._petList)

	self._petListAll = {}

	table.copy(self._petList, {})
end

function TowerTeamBattleMediator:setupView(ignoreReloadData)
	self:initLockIcons()
	self:refreshPetNode()
	self:initView()
	self:refreshListView(ignoreReloadData)
	self:createSortView()
	self:setMasterView()
	self:updateChallengeNum()
end

function TowerTeamBattleMediator:setMasterView()
	local data = self._curMasterData

	if not data then
		return
	end

	local panel = self:getView():getChildByFullName("main.roleClone")
	local detail = panel:getChildByFullName("Button_Details")

	detail.data = data

	detail:addClickEventListener(function(sender)
		self:onClickDetails(sender)
	end)

	local info = {
		frameId = "bustframe4_2",
		id = data:getModel()
	}
	local masterIcon = IconFactory:createRoleIconSpriteNew(info)

	masterIcon:setAnchorPoint(cc.p(0, 0))
	masterIcon:setPosition(cc.p(0, 0))
	panel:getChildByFullName("Panel_role_image"):addChild(masterIcon)
	masterIcon:setScale(1)
	panel:getChildByFullName("Text_name"):setString(data:getName())
	panel:getChildByFullName("Text_desc"):setString(data:getFeature())
	self:checkMasterSkillActive()

	local panelSkill = self:getView():getChildByFullName("main.roleClone.Panel_skill")

	panelSkill:setTouchEnabled(true)
	panelSkill:setSwallowTouches(true)
	panelSkill:addClickEventListener(function()
		self:onClickMasterSkill()
	end)
	GameStyle:setCommonOutlineEffect(panel:getChildByFullName("Text_147_0_0"))
	GameStyle:setCommonOutlineEffect(panel:getChildByFullName("Text_147_1"))
	GameStyle:setCommonOutlineEffect(panel:getChildByFullName("Text_desc"))
end

function TowerTeamBattleMediator:onClickMasterSkill()
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

function TowerTeamBattleMediator:checkMasterSkillActive()
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
				masterId = self._curMasterId,
				heroType = kActiveHeroType.kTower
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

function TowerTeamBattleMediator:clickSkill(sender)
	local skill = sender.data

	self._skillWidget = self:autoManageObject(self:getInjector():injectInto(SkillDescWidget:new(SkillDescWidget:createWidgetNode(), {
		skill = skill,
		mediator = self
	})))

	self._skillWidget:getView():setAnchorPoint(cc.p(0, 0))
	self._skillWidget:getView():addTo(self:getView())

	local pos = sender:convertToWorldSpace(cc.p(0, 0))
	local winSize = cc.Director:getInstance():getWinSize()
	local s = self._skillWidget:getView():getContentSize()

	s.width = 316
	s.height = 254

	local offset = 20

	if pos.x - s.width / 2 < 0 then
		if not (s.width / 2 + offset) then
			local posx = pos.x

			posx = posx + s.width > winSize.width and winSize.width - s.width or posx

			if pos.y - s.height / 2 < 0 then
				if not (s.height / 2 + offset) then
					local posy = pos.y

					posy = posy + s.height > winSize.height and winSize.height - s.height or posy

					self._skillWidget:getView():setPosition(cc.p(posx, posy))
					self._skillWidget:refreshInfo(skill, nil, true)
					self._skillWidget:show()
				end
			end
		end
	end
end

function TowerTeamBattleMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._qipao = self:getView():getChildByFullName("qipao")

	self._qipao:setVisible(false)
	self._qipao:setLocalZOrder(100)

	self._touchPanel = self:getView():getChildByFullName("touchPanel")

	self._touchPanel:setVisible(false)

	self._myPetPanel = self._main:getChildByFullName("my_pet_bg")
	self._heroPanel = self._myPetPanel:getChildByFullName("heroPanel")
	self._sortType = self._myPetPanel:getChildByFullName("sortPanel.sortBtn.text")

	self._myPetPanel:getChildByFullName("sortPanel.screenBtn"):setVisible(false)

	self._teamBg = self._main:getChildByName("team_bg")
	self._labelCombat = self._main:getChildByFullName("info_bg.combatLabel")
	self._costAverageLabel = self._main:getChildByFullName("info_bg.averageLabel")
	self._costTotalLabel1 = self._main:getChildByFullName("info_bg.cost1")
	self._costTotalLabel2 = self._main:getChildByFullName("info_bg.cost2")

	self._main:getChildByFullName("info_bg.titleIndx"):setString(Strings:get("Tower_Point_Num", {
		num = self._enemyIndex + 1
	}))
	self._main:getChildByFullName("info_bg.titleName"):setString(Strings:get(self._name))

	self._costTouch = self._main:getChildByFullName("info_bg.costTouch")

	self._costTouch:addClickEventListener(function()
		self:createCostTip()
	end)

	self._movingPet = self._main:getChildByFullName("moving_pet")
	self._spPanel = self._main:getChildByName("spStagePanel")
	self._btnPanel = self._main:getChildByName("btnPanel")
	self._textCurFightValue = self._spPanel:getChildByFullName("textCurFightValue")
	self._textAllFightValue = self._spPanel:getChildByFullName("textAllFightValue")
	self._teamBreakBtn = self._main:getChildByFullName("info_bg.button_one_key_break")
	self._teamOneKeyBtn = self._main:getChildByFullName("info_bg.button_one_key_embattle")

	self._teamBreakBtn:setVisible(false)
	self._teamOneKeyBtn:setVisible(false)

	self._myPetClone = self:getView():getChildByName("myPetClone")

	self._myPetClone:setVisible(false)

	self._petSize = self._myPetClone:getChildByFullName("myPetClone"):getContentSize()

	self._myPetClone:setScale(petScale)

	self._petSize = cc.size(self._petSize.width * petScale, self._petSize.height * petScale)
	self._teamPetClone = self:getView():getChildByName("teamPetClone")

	self._teamPetClone:setVisible(false)
	self._teamPetClone:setScale(teamScale)

	self._skillDescPanel = self:getView():getChildByFullName("skillDescPanel")

	self._skillDescPanel:setSwallowTouches(false)
	self._skillDescPanel:addClickEventListener(function()
		if self._skillDescPanel:isVisible() then
			self._skillDescPanel:setVisible(false)
		end
	end)
	self:ignoreSafeArea()
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("info_bg.titleIndx"))
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("info_bg.titleName"))
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("info_bg.text"))
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("info_bg.cost1"))
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("info_bg.text_prior"))
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("info_bg.averageLabel"))
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("spStagePanel.text_prior"))
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("spStagePanel.textCurFightValue"))
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("spStagePanel.text_prior_0"))
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("spStagePanel.textAllFightValue"))
	self:setPatternAndOutline(self._main:getChildByFullName("spStagePanel.Button_jiesuan.Text_97_0"))
	self:setPatternAndOutline(self._main:getChildByFullName("spStagePanel.Button_jiangli.Text_97_0"))
	self:setPatternAndOutline(self._main:getChildByFullName("spStagePanel.Button_buff.Text_97_0"))
	self:setPatternAndOutline(self._main:getChildByFullName("spStagePanel.Button_difang.Text_97_0"))

	local button_rule = self:getView():getChildByFullName("main.button_rule")

	button_rule:setPositionX(self._topInfoWidget:getTitleWidth() + 20)
end

function TowerTeamBattleMediator:setPatternAndOutline(text)
	local lineGradiantVec = {
		{
			ratio = 0.8,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.2,
			color = cc.c4b(167, 186, 255, 255)
		}
	}

	text:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec, {
		x = 0,
		y = -1
	}))
	text:enableOutline(cc.c4b(50, 37, 69, 191.25), 1)
end

function TowerTeamBattleMediator:ignoreSafeArea()
	AdjustUtils.ignorSafeAreaRectForNode(self._heroPanel, AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._myPetPanel:getChildByName("sortPanel"), AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._main:getChildByFullName("btnPanel"), AdjustUtils.kAdjustType.Right)

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._heroPanel:setContentSize(cc.size(winSize.width - 177, 154))
end

function TowerTeamBattleMediator:createTeamCell(cell, index)
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

	local heroInfo, heroObj = self:getHeroInfoById(id)

	self:initHero(node, heroInfo, heroObj)
	self:updateNode(node, heroInfo, 2)

	local detailBtn = node:getChildByFullName("detailBtn")

	detailBtn:addClickEventListener(function()
		self:onClickHeroDetail(id)
	end)
	detailBtn:setVisible(false)
	node:getChildByFullName("level"):setVisible(false)
	node:getChildByName("except"):setVisible(false)
	node:getChildByName("levelImage"):setVisible(false)
end

function TowerTeamBattleMediator:onClickCell(sender, eventType, index)
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

function TowerTeamBattleMediator:hasSamePet(list, targetId)
	if self._curTeam:hasSamePet(list, targetId) then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Tower_1_HeroError")
		}))

		return true
	end

	return false
end

function TowerTeamBattleMediator:changeOwnPet(cell)
	local id = cell.id

	if self:hasSamePet(self._teamPets, id) then
		return
	end

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

function TowerTeamBattleMediator:insertTeamPet(cell, isDrag)
	local id = cell.id

	if self:hasSamePet(self._teamPets, id) then
		return
	end

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

function TowerTeamBattleMediator:updateNode(petNode, heroInfo, type)
	if type == 1 then
		local r = petNode:getChildByFullName("text_compose_ratio")
		local scale = 1 / teamScale

		petNode:getChildByFullName("rarityBg"):setScale(scale * 0.8)
		petNode:getChildByFullName("image_num_bg.Text_num"):setScale(scale)
		r:setScale(scale)
		r:setString(heroInfo.expRatio * 100 .. "%")

		if heroInfo.expRatio < 1 then
			r:setTextColor(cc.c3b(255, 255, 255))
		else
			r:setTextColor(cc.c3b(191, 241, 26))
		end

		local v = heroInfo.expRatio < 1

		petNode:getChildByFullName("ratioBg"):setVisible(v)
		petNode:getChildByFullName("ratioBg100"):setVisible(not v)
	elseif type == 2 then
		local scale = 1 / petScale
		local r = petNode:getChildByFullName("image_combat_bg.text_compose_ratio")
		local b = petNode:getChildByFullName("image_combat_bg.text_combat")
		local bonusType_bg = petNode:getChildByFullName("bonusType_bg")
		local bonusType = petNode:getChildByFullName("bonusType_bg.bonusType")

		bonusType_bg:setVisible(heroInfo.awakenLevel > 0 or heroInfo.star >= StarBuffNum)

		if heroInfo.awakenLevel > 0 then
			bonusType:loadTexture("pt_word_juexing.png", ccui.TextureResType.plistType)
		elseif heroInfo.star >= StarBuffNum then
			bonusType:loadTexture("pt_word_jingjie.png", ccui.TextureResType.plistType)
		end

		petNode:getChildByFullName("rarityBg"):setScale(scale * 0.8)
		r:setScale(scale)
		b:setScale(scale)
		r:setString(heroInfo.expRatio * 100 .. "%")
		b:setString(heroInfo.combat)

		if heroInfo.expRatio < 1 then
			r:setTextColor(cc.c3b(255, 255, 255))
		else
			r:setTextColor(cc.c3b(191, 241, 26))
		end

		local v = heroInfo.expRatio < 1

		petNode:getChildByFullName("image_combat_bg.ratioBg"):setVisible(v)
		petNode:getChildByFullName("image_combat_bg.ratioBg100"):setVisible(not v)
		GameStyle:setCommonOutlineEffect(b)
	end
end

function TowerTeamBattleMediator:createMovingPet(cell, type)
	local petNode
	local heroInfo, heroObj = self:getHeroInfoById(cell.id)

	if type == 1 then
		petNode = self._teamPetClone:clone()

		petNode:setVisible(true)
		self:initTeamHero(petNode, heroInfo, heroObj)

		if cell:getChildByName("EmptyIcon") then
			cell:getChildByName("EmptyIcon"):setVisible(true)
		end
	elseif type == 2 then
		petNode = self._myPetClone:getChildByFullName("myPetClone"):clone()

		petNode:setVisible(true)
		self:initHero(petNode, heroInfo, heroObj)
		petNode:getChildByFullName("level"):setVisible(false)
		petNode:getChildByName("except"):setVisible(false)
		petNode:getChildByName("levelImage"):setVisible(false)
		petNode:getChildByName("detailBtn"):setVisible(false)
	end

	if petNode then
		self._movingPet:removeAllChildren()
		petNode:setAnchorPoint(cc.p(0.5, 0.5))
		petNode:addTo(self._movingPet):center(self._movingPet:getContentSize())
		self:updateNode(petNode, heroInfo, type)
	end
end

function TowerTeamBattleMediator:sortOnTeamPets(list, sortType)
	self._curTeam:sortOnTeamPets(list, sortType)
end

function TowerTeamBattleMediator:onClickOnTeamPet(sender, eventType)
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

function TowerTeamBattleMediator:changeTeamPet(index, endPos)
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

	self:sendUpdateTowerTeam1(function()
		return
	end)
end

function TowerTeamBattleMediator:removeTeamPet(index)
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

function TowerTeamBattleMediator:refreshViewBySort()
	self:initData()
	self:refreshListView()
	self:refreshPetNode()
end

function TowerTeamBattleMediator:refreshView()
	self:initData()
	self:refreshListView()
	self:refreshPetNode()
	self:updateChallengeNum()
end

function TowerTeamBattleMediator:updateChallengeNum()
	local lifeText = self:getView():getChildByFullName("main.btnPanel.Text_count")

	lifeText:setString(Strings:get("Tower_Revive_Time") .. self._towerData:getReviveTimes() .. "/" .. self._towerData:getChallengeNum())

	local isFight = not self._towerSystem:checkTowerBuffChoose(false) and not self._towerSystem:checkTowerCardsChoose(false)

	self._fightBtn:setVisible(isFight)
	self._btnPanel:setVisible(isFight)
	lifeText:setVisible(isFight)
end

function TowerTeamBattleMediator:refreshListView(ignoreReloadData)
	self._stageSystem:setSortExtand(0)

	self._petListAll = self._stageSystem:getSortExtendIds(self._petList)

	local sortType = self._stageSystem:getTowerCardSortType()

	self._towerSystem:sortHeroes(self._petListAll, sortType, nil, true)

	if not ignoreReloadData then
		self:reloadListView()
	end
end

function TowerTeamBattleMediator:reloadListView()
	local s = self._teamView:getContentOffset()
	local offsetX = self._teamView:getContentOffset().x + self._petSize.width

	if offsetX > 0 then
		offsetX = 0
	end

	self._teamView:reloadData()
	self._teamView:setContentOffset(cc.p(offsetX, 0))
end

function TowerTeamBattleMediator:initHero(node, info, heroObj)
	local heroId = info.id

	super.initHero(self, node, info)

	local skillPanel = node:getChildByName("skillPanel")
	local skill = heroObj:checkHasKeySkill(heroId)

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

function TowerTeamBattleMediator:refreshPetNode()
	self:refreshCombatAndCost()
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
			local heroInfo, heroObj = self:getHeroInfoById(id)

			self._petNodeList[i] = self._teamPetClone:clone()

			self._petNodeList[i]:setVisible(true)

			self._petNodeList[i].id = id

			self:initTeamHero(self._petNodeList[i], heroInfo, heroObj)
			self:updateNode(self._petNodeList[i], heroInfo, 1)
			self._petNodeList[i]:addTo(iconBg):center(iconBg:getContentSize())
			self._petNodeList[i]:offset(0, -9)
			iconBg:setTouchEnabled(true)

			iconBg.id = self._teamPets[i]

			if self._qipao:isVisible() and self._qipao.id == id then
				local targetPos = self._petNodeList[i]:getParent():convertToWorldSpace(cc.p(self._petNodeList[i]:getPosition()))

				targetPos = self._qipao:getParent():convertToNodeSpace(targetPos)

				self._qipao:setPosition(cc.p(targetPos.x - 50, targetPos.y + 60))
			end

			self._petNodeList[i]:getChildByFullName("image_num_bg.Text_num"):setString(i)
		else
			iconBg:setTouchEnabled(false)
		end
	end

	self:initLockIcons()
end

function TowerTeamBattleMediator:initTeamHero(node, info, heroObj)
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

	local bonusType_bg = node:getChildByFullName("bonusType_bg")
	local bonusType = node:getChildByFullName("bonusType_bg.bonusType")

	bonusType:loadTexture("pt_word_jingjie.png", ccui.TextureResType.plistType)
	bonusType_bg:setVisible(info.awakenLevel > 0 or info.star >= StarBuffNum)

	if info.awakenLevel > 0 then
		bonusType:loadTexture("pt_word_juexing.png", ccui.TextureResType.plistType)
	elseif info.star >= StarBuffNum then
		bonusType:loadTexture("pt_word_jingjie.png", ccui.TextureResType.plistType)
	end

	local cost = node:getChildByFullName("costBg.cost")

	cost:setString(info.cost)

	local occupationName, occupationImg = GameStyle:getHeroOccupation(info.type)
	local occupation = node:getChildByName("occupation")

	occupation:loadTexture(occupationImg)

	local skillPanel = node:getChildByName("skillPanel")
	local skill, condition = heroObj:checkHasKeySkill()

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

			image:addTo(skillPanel):center(skillPanel:getContentSize())
			image:setName("KeyMark")
			image:setScale(0.85)
			image:offset(0, -5)
		end

		local isActive = self._stageSystem:checkIsKeySkillActive(condition, self._teamPets, {
			masterId = self._curMasterId,
			heroType = kActiveHeroType.kTower
		})

		skillPanel:setGray(not isActive)
	end
end

function TowerTeamBattleMediator:refreshCombatAndCost()
	local totalCombat = 0
	local totalCost = 0

	for idx, heroId in pairs(self._teamPets) do
		local d = self:getHeroInfoById(heroId)

		totalCost = totalCost + d.cost
		totalCombat = totalCombat + d.combat
	end

	self._costTotal = totalCost

	self._costAverageLabel:setString(#self._teamPets == 0 and 0 or math.floor(totalCost * 10 / #self._teamPets + 0.5) / 10)
	self._costTotalLabel1:setString(self._costTotal)
	self._costTotalLabel2:setString("/" .. self._costMaxNum)

	local color = self._costTotal <= self._costMaxNum and cc.c3b(255, 255, 255) or cc.c3b(255, 65, 51)

	self._costTotalLabel1:setTextColor(color)
	self._costTotalLabel2:setPositionX(self._costTotalLabel1:getPositionX() + self._costTotalLabel1:getContentSize().width)
	self._textCurFightValue:setString(totalCombat)
	self._textAllFightValue:setString(self._enemyCombat)
	self._textAllFightValue:setTextColor(cc.c3b(255, 218, 89))

	if totalCombat >= self._enemyCombat then
		self._textCurFightValue:setTextColor(cc.c3b(170, 235, 29))
	elseif totalCombat < self._enemyCombat then
		self._textCurFightValue:setTextColor(cc.c3b(255, 85, 85))
	else
		self._textCurFightValue:setTextColor(cc.c3b(255, 218, 89))
	end
end

function TowerTeamBattleMediator:hasChangeTeam()
	if #self._tempTeams ~= #self._teamPets then
		return true
	end

	for k, v in pairs(self._teamPets) do
		local idx = table.indexof(self._tempTeams, v)

		if idx ~= k then
			return true
		end
	end

	return false
end

function TowerTeamBattleMediator:onClickFight(sender, eventType)
	if #self._teamPets < 1 then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("ARENA_TEMA_EMPTY")
		}))

		return false
	end

	if self._towerData:getReviveTimes() < 1 then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Tower_ReviveTimeLock")
		}))

		return false
	end

	if self._towerSystem:checkTowerBuffChoose() then
		return
	end

	if self._towerSystem:checkTowerCardsChoose() then
		return
	end

	if self:hasChangeTeam() then
		self:sendUpdateTowerTeam()
	else
		self:sendEnterBattle()
	end
end

function TowerTeamBattleMediator:sendUpdateTowerTeam()
	local towerId = self._towerSystem:getCurTowerId()
	local heroIds = self._teamPets

	self._towerSystem:requestUpdateTowerTeam(towerId, heroIds, function()
		self:refreshView()
		self:sendEnterBattle()
	end)
end

function TowerTeamBattleMediator:sendEnterBattle()
	local towerId = self._towerSystem:getCurTowerId()

	self._towerSystem:requestBeforeTowerBattle(towerId, function(data)
		self:fightRequestCallBack(self._towerSystem:getCurTowerId(), data)
	end)
end

function TowerTeamBattleMediator:fightRequestCallBack(towerId, data)
	self:onClickBack()
	self._towerSystem:enterBattleView(towerId, data)
end

function TowerTeamBattleMediator:onClickBack()
	self:sendUpdateTowerTeam1(function()
		if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(self:getView()) then
			return
		end

		self:dismiss()
	end)
end

function TowerTeamBattleMediator:sendUpdateTowerTeam1(callback)
	if #self._teamPets < 1 then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("ARENA_TEMA_EMPTY")
		}))

		return false
	end

	if self:hasChangeTeam() then
		local towerId = self._towerSystem:getCurTowerId()
		local heroIds = self._teamPets

		self._towerSystem:requestUpdateTowerTeam(towerId, heroIds, function()
			callback()
		end)
	else
		callback()
	end
end

function TowerTeamBattleMediator:onClickRule()
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

function TowerTeamBattleMediator:onClickCompose()
	self:sendUpdateTowerTeam1(function()
		self._towerSystem:showTowerStrengthView()
	end)
end

function TowerTeamBattleMediator:onClickAccount()
	local data = {
		title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
		content = Strings:get("Tower_1_UI_16"),
		sureBtn = {},
		cancelBtn = {}
	}
	local outself, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			outself._towerSystem:requestExitTower(outself._towerSystem:getCurTowerId(), function(data)
				outself._towerSystem:enterTowerFinishView(data)
			end)
		end
	end

	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function TowerTeamBattleMediator:onClickAwards()
	self._towerSystem:showTowerAwardView()
end

function TowerTeamBattleMediator:onClickBuff()
	self._towerSystem:showTowerBuffView()
end

function TowerTeamBattleMediator:onClickEnemy()
	self._towerSystem:showTowerEnemyView()
end

function TowerTeamBattleMediator:onClickDetails(sender)
	local params = {
		master = self._curMasterData,
		towerData = self._towerData
	}

	self._towerSystem:showMasterDetailsView(params)
end

function TowerTeamBattleMediator:getHeroInfoById(id)
	local heroInfo = self._curTeam:getHeroInfoById(id)

	if not heroInfo then
		return nil
	end

	local heroData = {
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
		combat = heroInfo:getCombat(),
		baseId = heroInfo:getBaseId(),
		maxStar = heroInfo:getMaxStar(),
		expRatio = heroInfo:getExpRatio(),
		awakenLevel = heroInfo:getAwakenStar(),
		identityAwakenLevel = heroInfo:getIdentityAwakenLevel()
	}

	return heroData, heroInfo
end

function TowerTeamBattleMediator:playInsertEffect(heroId)
	local specialSound = self._curTeam:getTeamSpecialSound(heroId, self._teamPets)

	self._qipao:setVisible(false)

	if self._specialSound then
		AudioEngine:getInstance():stopEffect(self._specialSound)
	end

	if specialSound then
		local desc = ConfigReader:getDataByNameIdAndKey("Sound", specialSound, "SoundDesc")

		desc = Strings:get(desc)

		if desc ~= "" then
			self._qipao:setVisible(true)

			self._qipao.id = heroId

			local content = self._qipao:getChildByName("content")

			content:getVirtualRenderer():setDimensions(114, 0)
			content:setString(desc)
			self._qipao:setContentSize(cc.size(126, content:getContentSize().height + 24))

			for i = 1, #self._teamPets do
				local node = self._petNodeList[i]

				if node and node.id and node.id == heroId then
					local targetPos = node:getParent():convertToWorldSpace(cc.p(node:getPosition()))

					targetPos = self._qipao:getParent():convertToNodeSpace(targetPos)

					self._qipao:setPosition(cc.p(targetPos.x - 50, targetPos.y + 60))
				end
			end
		end

		self._specialSound = AudioEngine:getInstance():playRoleEffect(specialSound, false, function()
			self._qipao:setVisible(false)
		end)
	else
		local info = self:getHeroInfoById(heroId)

		self._specialSound = AudioEngine:getInstance():playRoleEffect("Voice_" .. info.baseId .. "_61", false)
	end
end

function TowerTeamBattleMediator:initLockIcons()
	local maxShowNum = 10

	for i = #self._teamPets + 1, maxShowNum do
		local iconBg = self._teamBg:getChildByName("pet_" .. i)

		iconBg:removeAllChildren()

		local emptyIcon = GameStyle:createEmptyIcon(true)

		emptyIcon:addTo(iconBg):center(iconBg:getContentSize())

		local width, height = iconBg:getContentSize().width, iconBg:getContentSize().height

		if i > self._maxTeamPetNum then
			local lockImg = ccui.ImageView:create("suo_icon_s_battle.png", 1)

			lockImg:addTo(iconBg):posite(width - 7, height - 6)
		end

		local textbg = ccui.ImageView:create("asset/common/bd_bg_bhd.png", 0)

		textbg:addTo(iconBg):center(iconBg:getContentSize()):offset(40, -40)

		local text = ccui.Text:create(i, CustomFont_FZYH_R, 30)

		text:setTextColor(cc.c3b(195, 195, 195))
		text:enableOutline(cc.c4b(0, 0, 0, 255), 1)
		text:addTo(iconBg):center(iconBg:getContentSize()):offset(40, -35)
	end
end

function TowerTeamBattleMediator:createSortView()
	local sortType = self._stageSystem:getTowerCardSortType()

	local function callBack(data)
		local sortStr = self._stageSystem:getSortTypeStr(data.sortType)

		self._sortType:setString(sortStr)
		self._stageSystem:setTowerCardSortType(data.sortType)
		self._teamView:stopScroll()
		self:refreshListView(false)
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

function TowerTeamBattleMediator:onClickSort()
	self._stageSystem:setSortExtand(0)
	self._sortComponent:getRootNode():setVisible(true)
	self._sortComponent:refreshView()
	self._teamView:stopScroll()
	self:refreshListView(true)
end

function TowerTeamBattleMediator:onClickScreen()
	return
end

function TowerTeamBattleMediator:onClickSortType()
	return
end
