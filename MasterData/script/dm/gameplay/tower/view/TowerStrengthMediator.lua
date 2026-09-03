-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerStrengthMediator.lua

require("dm.gameplay.stage.view.CommonTeamMediator")

TowerStrengthMediator = class("TowerStrengthMediator", DmAreaViewMediator, _M)

TowerStrengthMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
TowerStrengthMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
TowerStrengthMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
TowerStrengthMediator:has("_towerSystem", {
	is = "r"
}):injectWith("TowerSystem")

local costType = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_Cost_Type", "content")
local heroGrowBuff = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tower_1_HeroGrowBuff", "content")
local kBtnHandlers = {
	button_rule = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRule"
	},
	["main.strengthPanel.info_bg.button_rule_tip"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickTip"
	},
	["main.strengthPanel.info_bg.awardBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickAwardBtn"
	}
}
local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}
local V_NUM = 4
local KPetType = {
	ALL = 1,
	STRENGTHEN_LIST = 3,
	STRENGTHEN = 2
}
local KPetTypeScale = {
	ALL = 0.7,
	STRENGTHEN_LIST = 0.6,
	STRENGTHEN = 0.9
}
local KTeamNum = 6

function TowerStrengthMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._sureBtn = self:bindWidget("main.strengthPanel.info_bg.btnPanel.sureBtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onClickSure, self)
		}
	})
end

function TowerStrengthMediator:enterWithData(data)
	self:initData()
	self:setupView()
end

function TowerStrengthMediator:resumeWithData()
	return
end

function TowerStrengthMediator:initData()
	self._towerData = self._towerSystem:getTowerDataById(self._towerSystem:getCurTowerId())
	self._curTeam = self._towerData:getTeam()

	self:getData()

	self._strengthPetId = nil
	self._strengthPetList = {}
end

function TowerStrengthMediator:getData()
	self._petList = {}
	self._teamPets = {}

	for id, petId in pairs(self._curTeam:getTeamHeroes()) do
		self._teamPets[id] = petId
		self._petList[#self._petList + 1] = petId
	end

	local unPetList = {}

	for id, petId in pairs(self._curTeam:getUnTeamHeroes()) do
		unPetList[#unPetList + 1] = petId
	end

	for id, petId in pairs(unPetList) do
		self._petList[#self._petList + 1] = petId
	end

	table.sort(self._petList, function(a, b)
		local v = table.indexof(self._teamPets, id)
		local infoA = self._curTeam:getHeroInfoById(a)
		local infoB = self._curTeam:getHeroInfoById(b)
		local vA = table.indexof(self._teamPets, a) and 1 or 0
		local vB = table.indexof(self._teamPets, b) and 1 or 0

		if vA == vB then
			if infoA:getRarity() == infoB:getRarity() then
				return infoA:getCombat() > infoB:getCombat()
			else
				return infoA:getRarity() > infoB:getRarity()
			end
		else
			return vB < vA
		end
	end)
end

function TowerStrengthMediator:setupView()
	self:setupTopInfoWidget()
	self:initWidgetInfo()
	self:initTabView()
	self:refreshStrengthPanel()
end

function TowerStrengthMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Hero_Group")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local var_8_0 = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}

	var_8_0.title = Strings:get(self._towerData:getTowerBase():getConfig().Name)

	local config = var_8_0
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)

	local button_rule = self:getView():getChildByFullName("button_rule")

	button_rule:setPositionX(self._topInfoWidget:getTitleWidth() + 20)
end

function TowerStrengthMediator:onClickBack()
	self:dismiss()
end

function TowerStrengthMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._movingPet = self._main:getChildByFullName("moving_pet")
	self._heroPanel = self._main:getChildByFullName("heroPanel")
	self._myPetClone = self:getView():getChildByName("myPetClone")

	self._myPetClone:setVisible(false)

	self._petSize = self._myPetClone:getContentSize()
	self._strengthPanel = self._main:getChildByFullName("strengthPanel")
	self._teamBg = self._strengthPanel:getChildByName("team_bg")
	self._infoBg = self._strengthPanel:getChildByFullName("info_bg")
	self._nullTip = self._strengthPanel:getChildByFullName("Image_null")
	self._contentPanel = self._main:getChildByFullName("strengthPanel.info_bg.content_panel")
	self._contentPanelNull = self._main:getChildByFullName("strengthPanel.info_bg.content_panel_null")

	self._main:getChildByFullName("strengthPanel.info_bg.awardBtn_Null.notHaveReward"):setString(Strings:get("notHaveReward"))

	local winSize = cc.Director:getInstance():getWinSize()

	self._main:getChildByFullName("Image_line"):setPositionY(winSize.height - 65)
	self._main:getChildByFullName("strengthPanel.Image_null.tip"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._infoBg:getChildByFullName("Image_max"):setVisible(false)
	self:setOutLine()
	self:refreshStrengthPanel()
	self:ignoreSafeArea()
end

function TowerStrengthMediator:setOutLine()
	self._main:getChildByFullName("strengthPanel.info_bg.upTip"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._main:getChildByFullName("strengthPanel.info_bg.upTipNum"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._main:getChildByFullName("strengthPanel.info_bg.content_panel.skillName"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._main:getChildByFullName("strengthPanel.info_bg.button_rule_tip.ruleTip"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._main:getChildByFullName("strengthPanel.info_bg.content_panel_null.skillName"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._main:getChildByFullName("strengthPanel.info_bg.content_panel.skillDes"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._main:getChildByFullName("strengthPanel.Image_null.tip"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._main:getChildByFullName("strengthPanel.info_bg.awardBtn_Null.notHaveReward"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._main:getChildByFullName("strengthPanel.info_bg.content_panel.bestReward.desc_text_1"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._main:getChildByFullName("strengthPanel.info_bg.content_panel.bestReward.desc_text_2"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._main:getChildByFullName("strengthPanel.info_bg.content_panel_null.bestReward.desc_text_1"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._main:getChildByFullName("strengthPanel.info_bg.content_panel_null.bestReward.desc_text_2"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
end

function TowerStrengthMediator:ignoreSafeArea()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
end

local scrollBottom = false

function TowerStrengthMediator:initTabView()
	local function scrollViewDidScroll(table)
		self._isReturn = false

		local offY = table:getContentOffset().y

		if offY == 0 and not scrollBottom then
			scrollBottom = true
		end
	end

	local function cellSizeForTable(table, idx)
		return self._petSize.width * KPetTypeScale.ALL * V_NUM, self._petSize.height * KPetTypeScale.ALL
	end

	local function numberOfCellsInTableView(table)
		return math.ceil(#self._petList / V_NUM)
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		self:createTeamCell(cell, idx)

		scrollBottom = false

		return cell
	end

	local tableView = cc.TableView:create(self._heroPanel:getContentSize())

	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setAnchorPoint(0, 1)
	tableView:setDelegate()
	tableView:setMaxBounceOffset(20)
	self._heroPanel:addChild(tableView, 1)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:reloadData()

	self._teamView = tableView
end

function TowerStrengthMediator:createTeamCell(cell, index)
	cell:removeAllChildren()

	local petIds = {}
	local vindex = index * V_NUM

	for i = 1, V_NUM do
		local idx = vindex + i

		if idx <= #self._petList then
			local node = self._myPetClone:clone()

			node:setVisible(true)
			cell:addChild(node)
			node:setAnchorPoint(cc.p(0, 0))
			node:setTag(12138 + idx)
			node:setScale(KPetTypeScale.ALL)
			node:setPosition(cc.p((i - 1) * self._petSize.width * KPetTypeScale.ALL, 0))

			node.id = self._petList[idx]

			self:createPet(node, idx, KPetType.ALL)

			petIds[#petIds + 1] = self._petList[idx]
		end
	end

	cell.petIds = petIds
end

function TowerStrengthMediator:createPet(node1, index, type)
	node1:getChildByFullName("selectImg"):setVisible(false)
	node1:getChildByFullName("selectImgCur"):setVisible(false)
	node1:getChildByFullName("selectImg"):setTag(99)
	node1:getChildByFullName("selectImgCur"):setTag(100)

	node1.type = type

	local id = node1.id
	local node = node1:getChildByFullName("myPetClone")

	node.id = id
	node.type = type

	local heroInfo = self:getHeroInfoById(id)

	self:initHero(node, heroInfo)
	node:setTouchEnabled(true)
	node:setSwallowTouches(false)
	node:addTouchEventListener(function(sender, eventType)
		self:onClickPetNode(sender, eventType, index)
	end)

	local v = table.indexof(self._teamPets, id)

	node:getChildByFullName("except"):setVisible(v and true or false)
	node:getChildByFullName("except.text"):setString(Strings:get("heroshow_UI29"))
	node:getChildByFullName("addExpBg"):setVisible(false)

	if type == KPetType.ALL then
		self:petNodeSelectStatus(node1)
		self:refreshExp(node1)
		node:getChildByFullName("nameBg"):setVisible(true)
		node:getChildByFullName("namePanel"):setVisible(true)
	elseif type == KPetType.STRENGTHEN then
		node:getChildByFullName("nameBg"):setVisible(false)
		node:getChildByFullName("namePanel"):setVisible(false)
	elseif type == KPetType.STRENGTHEN_LIST then
		node:getChildByFullName("nameBg"):setVisible(false)
		node:getChildByFullName("namePanel"):setVisible(false)
		node:getChildByFullName("addExpBg"):setVisible(true)
		node:getChildByFullName("addExpBg"):setPositionY(0)
		node:getChildByFullName("addExpBg.jiantou"):setVisible(false)

		local exp, type, card = self:getAddExp(id)

		node:getChildByFullName("addExpBg.addExpNum"):setString(Strings:get("Tower_1_UI_14") .. " +" .. exp)
		node:getChildByFullName("addExpBg.addExpNum"):setColor(cc.c3b(255, 255, 255))

		if type or card then
			node:getChildByFullName("addExpBg.addExpNum"):setColor(cc.c3b(118, 241, 58))
		end
	end
end

function TowerStrengthMediator:petNodeSelectStatus(node)
	if not node then
		return
	end

	local petId = node.id

	node:getChildByFullName("myPetClone"):setGray(false)
	node:getChildByName("selectImg"):setVisible(false)
	node:getChildByName("selectImgCur"):setVisible(false)

	local v = table.indexof(self._strengthPetList, petId)

	if v then
		node:getChildByFullName("myPetClone"):setGray(true)
		node:getChildByFullName("selectImg"):setVisible(true)
	end

	if self._strengthPetId == petId then
		node:getChildByFullName("myPetClone"):setGray(true)
		node:getChildByFullName("selectImgCur"):setVisible(true)
	end
end

function TowerStrengthMediator:refreshPetNodeExp(sender)
	if not self._strengthPetId then
		for k, node in pairs(self._petListNode) do
			node = node:getChildByFullName("myPetClone")

			node:getChildByFullName("addExpBg"):setVisible(false)
		end

		return
	end

	for k, node in pairs(self._petListNode) do
		if node then
			self:refreshExp(node)
		end
	end
end

function TowerStrengthMediator:refreshExp(node)
	if not self._strengthPetId then
		return
	end

	if not node then
		return
	end

	node = node:getChildByFullName("myPetClone")

	local petId = node.id

	if petId == self._strengthPetId then
		node:getChildByFullName("addExpBg"):setVisible(false)
	else
		node:getChildByFullName("addExpBg"):setVisible(true)
		node:getChildByFullName("addExpBg.bg"):setVisible(false)
		node:getChildByFullName("addExpBg.jiantou"):setVisible(false)

		local exp, type, card = self:getAddExp(petId)

		node:getChildByFullName("addExpBg.addExpNum"):setString(Strings:get("Tower_1_UI_14") .. " +" .. exp)
		node:getChildByFullName("addExpBg.addExpNum"):setColor(cc.c3b(255, 255, 255))

		if type or card then
			node:getChildByFullName("addExpBg.jiantou"):setVisible(true)
			node:getChildByFullName("addExpBg.addExpNum"):setColor(cc.c3b(118, 241, 58))
		end
	end
end

function TowerStrengthMediator:onClickPetNode(sender, eventType, index)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.moved then
		-- block empty
	elseif eventType == ccui.TouchEventType.ended then
		if self._isReturn then
			self:checkPetClickByType(sender)
		end
	elseif eventType == ccui.TouchEventType.canceled then
		-- block empty
	end
end

function TowerStrengthMediator:checkPetClickByType(sender)
	local petId = sender.id
	local type = sender.type

	if type == KPetType.ALL then
		if self._strengthPetId == petId then
			self._strengthPetId = nil
			self._strengthPetList = {}

			self:reloadData()
			self:refreshStrengthPanel(petId)

			return
		end

		if self._strengthPetId == nil then
			self._strengthPetId = petId

			self:reloadData()
			self:refreshStrengthPanel(petId, true)

			return
		end

		local cellIndex = table.indexof(self._strengthPetList, petId)

		if cellIndex then
			table.remove(self._strengthPetList, cellIndex)
			self:reloadData()
			self:refreshStrengthPanel(petId)

			return
		else
			if self:fullExp(self._strengthPetId) then
				return
			end

			if #self._strengthPetList >= KTeamNum then
				self:dispatch(ShowTipEvent({
					duration = 0.2,
					tip = Strings:get("Tower_1_Tips2")
				}))

				return
			end

			self._strengthPetList[#self._strengthPetList + 1] = petId

			self:reloadData()
			self:refreshStrengthPanel(petId)
		end
	end

	if type == KPetType.STRENGTHEN then
		self._strengthPetId = nil
		self._strengthPetList = {}

		self:reloadData()
		self:refreshStrengthPanel(petId)

		return
	end

	if type == KPetType.STRENGTHEN_LIST then
		local cellIndex = table.indexof(self._strengthPetList, petId)

		if cellIndex then
			table.remove(self._strengthPetList, cellIndex)
			self:reloadData()
			self:refreshStrengthPanel(petId)
		end

		return
	end
end

function TowerStrengthMediator:reloadData()
	local offsetY = self._teamView:getContentOffset().y

	self._teamView:reloadData()
	self._teamView:setContentOffset(cc.p(0, offsetY))
end

function TowerStrengthMediator:fullExp(petId)
	local upExpRatio, greenRatio, yelloRatio, curAddExp = self:getStrengthExpValue()

	if yelloRatio >= 1 then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Tower_1_Tips1")
		}))

		return true
	end

	return false
end

function TowerStrengthMediator:refreshStrengthPanel(petId, createPet)
	self:refreshTeam(petId, createPet)
	self._infoBg:setVisible(true)
	self._nullTip:setVisible(not self._strengthPetId)
	self._contentPanelNull:setVisible(not self._strengthPetId)
	self._infoBg:getChildByFullName("button_rule_tip"):setVisible(not self._strengthPetId)
	self._contentPanel:setVisible(self._strengthPetId ~= nil)
	self._infoBg:getChildByFullName("Image_name_bg"):setVisible(self._strengthPetId ~= nil)
	self._infoBg:getChildByFullName("upTip"):setVisible(self._strengthPetId ~= nil)
	self._infoBg:getChildByFullName("upTipNum"):setVisible(self._strengthPetId ~= nil)
	self._infoBg:getChildByFullName("Image_name_bg"):setVisible(self._strengthPetId ~= nil)

	local awardData = self._towerSystem:checkIsAwardData(self._strengthPetId)

	self._infoBg:getChildByFullName("awardBtn"):setVisible(self._strengthPetId ~= nil and #awardData > 0)
	self._infoBg:getChildByFullName("awardBtn_Null"):setVisible(self._strengthPetId ~= nil and #awardData == 0)

	if self._strengthPetId == nil then
		self._infoBg:getChildByFullName("awardBtn_Null"):setGray(true)
		self._infoBg:getChildByFullName("btnPanel"):setVisible(true)
		self._infoBg:getChildByFullName("Image_max"):setVisible(false)
		self._infoBg:getChildByFullName("expBg.LoadingBar_yellow"):setPercent(0)
		self._infoBg:getChildByFullName("expBg.rateValue"):setString(0 .. "/" .. 100)
		self._infoBg:getChildByFullName("expBg.LoadingBar_yellow.LoadingBar_green"):setPercent(0)

		return
	end

	local info = self:getHeroInfoById(self._strengthPetId)

	self:addSkill(self._contentPanel, heroGrowBuff[info.type])

	local upExpRatio, greenRatio, yelloRatio, curAddExp = self:getStrengthExpValue()

	self._infoBg:getChildByFullName("upTipNum"):setString(math.floor(upExpRatio * 100) .. "%")
	self._infoBg:getChildByFullName("expBg.LoadingBar_yellow.LoadingBar_green"):setPercent(greenRatio * 100)
	self._infoBg:getChildByFullName("expBg.LoadingBar_yellow"):setPercent(yelloRatio * 100)
	self._infoBg:getChildByFullName("expBg.rateValue"):setString(curAddExp .. "/" .. info.maxExp)

	local full = info.expRatio >= 1

	self._infoBg:getChildByFullName("btnPanel"):setVisible(not full)
	self._infoBg:getChildByFullName("button_rule_tip"):setVisible(not full)
	self._infoBg:getChildByFullName("Image_max"):setVisible(full)
	self._infoBg:getChildByFullName("Image_name_bg.roleName"):setString(info.name)
end

function TowerStrengthMediator:addSkill(panel, skillId)
	local imageIcon = panel:getChildByFullName("image_icon")
	local title = panel:getChildByFullName("skillName")
	local content = panel:getChildByFullName("skillDes")
	local info = {
		id = skillId
	}
	local newSkillNode = IconFactory:createMasterSkillIcon(info, {
		hideLevel = true
	})

	newSkillNode:setScale(0.5)
	newSkillNode:setPosition(cc.p(18, 16))
	newSkillNode:addTo(imageIcon)

	local name = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Name")

	title:setString(Strings:get(name))

	local text = Strings:get(ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Desc"))

	content:setString(text)
end

function TowerStrengthMediator:getValue()
	local value = {}

	value.combat = 0
	value.atk = 0
	value.def = 0
	value.hp = 0
	value.speed = 0

	for idx, petId in pairs(self._strengthPetList) do
		local info = self:getHeroInfoById(petId)

		value.combat = value.combat + info.combat
		value.atk = value.atk + info.atk
		value.def = value.def + info.def
		value.hp = value.hp + info.hp
		value.speed = value.speed + info.speed
	end

	return value
end

function TowerStrengthMediator:refreshTeam(petId, createPet)
	if self._strengthPetId then
		if createPet then
			local iconBg = self._teamBg:getChildByName("pet_0")

			iconBg:removeAllChildren()
			self:createTeamPet(iconBg, KPetType.STRENGTHEN, self._strengthPetId)
		end
	else
		local iconBg = self._teamBg:getChildByName("pet_0")

		iconBg:removeAllChildren()

		local emptyIcon = GameStyle:createAddImgEmptyIcon(true, {
			showAddImg = true
		})

		emptyIcon:addTo(iconBg):center(iconBg:getContentSize())
		emptyIcon:setScale(1.6)
	end

	for i = 1, KTeamNum do
		local iconBg = self._teamBg:getChildByName("pet_" .. i)

		iconBg:setScale(0.9)
		iconBg:removeAllChildren()

		if i > #self._strengthPetList then
			local emptyIcon = GameStyle:createAddImgEmptyIcon(true, {
				showAddImg = true
			})

			emptyIcon:addTo(iconBg):center(iconBg:getContentSize())
		else
			self:createTeamPet(iconBg, KPetType.STRENGTHEN_LIST, self._strengthPetList[i])
		end
	end
end

function TowerStrengthMediator:createTeamPet(iconBg, type, petId)
	if type == KPetType.STRENGTHEN then
		if not KPetTypeScale.STRENGTHEN then
			local scale = KPetTypeScale.STRENGTHEN_LIST
			local pos = type == KPetType.STRENGTHEN and cc.p(83, 50) or cc.p(45, 28)
			local node = self._myPetClone:clone()

			node:setVisible(true)
			iconBg:addChild(node)
			node:setAnchorPoint(cc.p(0.5, 0.5))
			node:setTag(100 + petId)
			node:setScale(scale)
			node:setPosition(pos)

			node.id = petId

			self:createPet(node, 200 + petId, type)
		end
	end
end

function TowerStrengthMediator:initHero(node, info)
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

	local namePanel = node:getChildByFullName("namePanel")
	local name = namePanel:getChildByName("name")
	local qualityLevel = namePanel:getChildByName("qualityLevel")

	name:setString(info.name)
	qualityLevel:setString(info.qualityLevel == 0 and "" or " +" .. info.qualityLevel)
	name:setPositionX(name:getContentSize().width / 2)
	qualityLevel:setPositionX(name:getContentSize().width)
	namePanel:setContentSize(cc.size(name:getContentSize().width + qualityLevel:getContentSize().width, 30))
	GameStyle:setHeroNameByQuality(name, info.quality)
	GameStyle:setHeroNameByQuality(qualityLevel, info.quality)
	node:getChildByFullName("image_combat_bg.text_combat"):setString(info.combat)

	local r = node:getChildByFullName("image_combat_bg.text_compose_ratio")

	r:setString(math.floor(info.expRatio * 100) .. "%")

	if info.expRatio < 1 then
		r:setTextColor(cc.c3b(255, 255, 255))
	else
		r:setTextColor(cc.c3b(191, 241, 26))
	end

	local weak = node:getChildByName("weak")
	local weakTop = node:getChildByName("weak")

	weak:removeAllChildren()
	weakTop:removeAllChildren()

	if info.awakenLevel > 0 then
		local anim = cc.MovieClip:create("dikuang_yinghunxuanze")

		anim:addTo(weak):center(weak:getContentSize())
		anim:setScale(2)
		anim:offset(-5, 18)

		anim = cc.MovieClip:create("shangkuang_yinghunxuanze")

		anim:addTo(weakTop):center(weakTop:getContentSize())
		anim:setScale(2)
		anim:offset(-5, 18)
	end
end

function TowerStrengthMediator:getHeroInfoById(id)
	local heroInfo = self._curTeam:getHeroInfoById(id)

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
		combat = heroInfo:getCombat(),
		baseId = heroInfo:getBaseId(),
		expRatio = heroInfo:getExpRatio(),
		atk = heroInfo:getAtk(),
		def = heroInfo:getDef(),
		hp = heroInfo:getHp(),
		speed = heroInfo:getSpeed(),
		rate = heroInfo:getRate(),
		def = heroInfo:getDef(),
		baseId = heroInfo:getBaseId(),
		exp = heroInfo:getExp(),
		maxExp = heroInfo:getMaxExp(),
		expGrowRareityBase = heroInfo:getExpGrowRareityBase(),
		expGrowSameType = heroInfo:getExpGrowSameType(),
		expGrowSameCard = heroInfo:getExpGrowSameCard(),
		growValue = heroInfo:getGrowValue(),
		maxSkillId = heroInfo:getMaxSkillId(),
		awakenLevel = heroInfo:getAwakenStar()
	}
end

function TowerStrengthMediator:getStrengthExpValue()
	local addTotalExp = 0
	local upExpRatio, greenRatio, yelloRatio, curAddExp = 0, 0, 0, 0
	local info = self:getHeroInfoById(self._strengthPetId)

	greenRatio = info.expRatio
	greenRatio = info.expRatio > 1 and 1 or greenRatio
	addTotalExp = addTotalExp + info.exp

	for idx, petId in pairs(self._strengthPetList) do
		local exp, type, card = self:getAddExp(petId)

		addTotalExp = addTotalExp + exp
	end

	curAddExp = addTotalExp
	curAddExp = addTotalExp > info.maxExp and info.maxExp or curAddExp
	yelloRatio = addTotalExp / info.maxExp
	yelloRatio = addTotalExp / info.maxExp > 1 and 1 or yelloRatio
	upExpRatio = yelloRatio
	upExpRatio = yelloRatio * info.growValue
	upExpRatio = yelloRatio * info.growValue > 1 and 1 or upExpRatio

	return upExpRatio, greenRatio, yelloRatio, curAddExp
end

function TowerStrengthMediator:getAddExp(petId)
	if not self._strengthPetId then
		return
	end

	local exp, type, card = 0, false, false
	local info1 = self:getHeroInfoById(self._strengthPetId)
	local info2 = self:getHeroInfoById(petId)

	exp = exp + info2.exp + info2.expGrowRareityBase

	if info1.type == info2.type then
		type = true
		exp = exp + info2.expGrowSameType
	end

	if info1.baseId == info2.baseId then
		card = true
		exp = exp + info2.expGrowSameCard
	end

	return exp, type, card
end

function TowerStrengthMediator:onClickRule()
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

function TowerStrengthMediator:onClickAwardBtn()
	self._towerSystem:showTowerStrengthAwardView(self._strengthPetId)
end

function TowerStrengthMediator:onClickTip()
	return
end

function TowerStrengthMediator:onClickSure()
	if #self._strengthPetList <= 0 then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Tower_1_Tips3")
		}))

		return
	end

	local info = self:getHeroInfoById(self._strengthPetId)

	self._towerSystem:requestFeedUpHero(self._towerSystem:getCurTowerId(), self._strengthPetId, self._strengthPetList, function()
		self:refreshView()

		local info1 = self:getHeroInfoById(self._strengthPetId)

		self._towerSystem:showTowerStrengthEndTipView({
			old = info,
			new = info1
		})
	end)
end

function TowerStrengthMediator:refreshView()
	self:getData()
	self._teamView:reloadData()

	self._strengthPetList = {}

	self:refreshStrengthPanel(self._strengthPetId, true)
end
