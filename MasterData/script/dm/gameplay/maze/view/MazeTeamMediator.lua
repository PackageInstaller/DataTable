-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeTeamMediator.lua

MazeTeamMediator = class("MazeTeamMediator", DmPopupViewMediator, _M)

MazeTeamMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")
MazeTeamMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
MazeTeamMediator:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")

local kBtnHandlers = {
	["main.bg.nomasterPanel.button"] = "onClickChangeMaster",
	["main.spStagePanel.fightBtn"] = "onClickFight",
	["main.bg.masterBtn"] = "onClickChangeMaster"
}

function MazeTeamMediator:initialize()
	super.initialize(self)
end

function MazeTeamMediator:dispose()
	super.dispose(self)
end

function MazeTeamMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TEAM_CHANGE_MASTER, self, self.changeMasterId)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TEAM_REFRESH_PETS, self, self.refreshListView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshCombatAndCost)
end

function MazeTeamMediator:enterWithData(data)
	self._replace = false

	if data and data.replace then
		self._replace = data.replace
		self._buyId = data.buyId
		self._index = data.index
		self._eventName = data.eventName
		self._optype = data.optype
	end

	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()
	self._data = data

	if data and data.stageType then
		self._stageType = data.stageType or ""
	end

	self._isDrag = false
	self._uuid = ""
	self._costTotal = 0
	self._costMaxNum = 99
	self._maxTeamPetNum = 10

	self:initData()
	self:setupView()
end

function MazeTeamMediator:initData()
	self._curTeam = self._mazeSystem._player._mazeTeam

	local modelTmp = {
		_heroes = self._mazeSystem._player._mazeTeam:getHeros(),
		_masterId = self._mazeSystem:getSelectMasterId()
	}
	local model = {}

	table.deepcopy(modelTmp, model)

	self._curMasterId = model._masterId
	self._oldMasterId = self._curMasterId

	local teamPetIndex = 1

	self._teamPets = {}

	for _, v in pairs(model._heroes) do
		self._teamPets[teamPetIndex] = v
		teamPetIndex = teamPetIndex + 1
	end

	self._tempTeams = {}

	table.deepcopy(self._teamPets, self._tempTeams)

	self._nowName = self._curTeam:getName()
	self._oldName = self._nowName
	self._petList = self._teamPets
	self._petListAll = self._teamPets
end

function MazeTeamMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("PansLabNormal")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		title = "爬塔卡组",
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickExit, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function MazeTeamMediator:removeExceptHeros()
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

function MazeTeamMediator:setupView()
	self:initWigetInfo()
	self:initLockIcons()
	self:refreshPetNode()
	self:refreshMasterInfo()
	self:refreshListView()
	self:setupTopInfoWidget()

	local replacepanel = self:getView():getChildByFullName("Image_2")

	self:initClickCheckReplace()
	replacepanel:setVisible(self._replace)
end

function MazeTeamMediator:initWigetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._bg = self:getView():getChildByFullName("main.bg")
	self._roleName = self._bg:getChildByName("mastername")
	self._myPetPanel = self._main:getChildByFullName("my_pet_bg")
	self._myPetPanel = self._main:getChildByFullName("my_pet_bg")
	self._masterImage = self._bg:getChildByName("role")
	self._noMasterPanel = self._bg:getChildByFullName("nomasterPanel")
	self._masterBtn = self._bg:getChildByFullName("masterBtn")
	self._roleName = self._bg:getChildByName("role_name")
	self._teamBg = self._bg:getChildByName("team_bg")
	self._labelCombat = self._bg:getChildByFullName("info_bg.combatBg.combatLabel")
	self._costAverageLabel = self._bg:getChildByFullName("info_bg.label_preference")
	self._costTotalLabel = self._bg:getChildByFullName("info_bg.cost1")
	self._costTotalLimitLabel = self._bg:getChildByFullName("info_bg.cost2")

	self._costTotalLimitLabel:setString("/" .. self._costMaxNum)

	self._onLinePetNumber = self._bg:getChildByFullName("info_bg.is_on_number")
	self._movingPet = self:getView():getChildByFullName("moving_pet")
	self._arenaSaveBtn = self._main:getChildByFullName("spStagePanel.saveBtn")
	self._myPetPanel = self._main:getChildByFullName("my_pet_bg")
	self._heroPanel = self._myPetPanel:getChildByFullName("heroPanel")
	self._myPetClone = self:getView():getChildByName("myPetClone")

	self._myPetClone:setVisible(false)

	self._teamPetClone = self:getView():getChildByName("teamPetClone")

	self._teamPetClone:setVisible(false)
	self:setLabelEffect()
end

function MazeTeamMediator:setLabelEffect()
	local lineGradiantVec1 = {
		{
			ratio = 0.2,
			color = cc.c4b(100, 60, 50, 255)
		},
		{
			ratio = 0.8,
			color = cc.c4b(130, 60, 30, 255)
		}
	}

	GameStyle:setGoldCommonEffect(self._labelCombat)
	GameStyle:setGoldCommonEffect(self._main:getChildByFullName("spStagePanel.combatBg.text"))
	GameStyle:setGoldCommonEffect(self._main:getChildByFullName("spStagePanel.combatBg.combatLabel"))
end

function MazeTeamMediator:initLockIcons()
	local lockDesc = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum_Desc", "content")
	local maxShowNum = 10

	for i = self._maxTeamPetNum + 1, maxShowNum do
		local iconBg = self._teamBg:getChildByName("pet_" .. i)
		local emptyIcon = GameStyle:createEmptyIcon(true)

		emptyIcon:addTo(iconBg):center(iconBg:getContentSize())

		local tipLabel = cc.Label:createWithTTF("", TTF_FONT_FZY3JW, 18)

		iconBg:addChild(tipLabel)
		tipLabel:setAnchorPoint(cc.p(0.5, 0.5))
		tipLabel:setPosition(cc.p(iconBg:getContentSize().width / 2, iconBg:getContentSize().height / 2 + 3))
		tipLabel:setString(Strings:get(lockDesc[i]))
		tipLabel:setColor(cc.c3b(80, 50, 20))
		tipLabel:setRotation(-10.5)
	end
end

function MazeTeamMediator:createCardsGroupName()
	local nameDi = self._bg:getChildByName("nameBg")

	self._editBox = nameDi:getChildByFullName("TextField")
	self._nowName = self._curTeam:getName()
	self._oldName = self._nowName

	nameDi:setTouchEnabled(true)
	nameDi:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._editBox:openKeyboard()
		end
	end)

	local maxLength = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Name_MaxWords", "content")

	if self._editBox:getDescription() == "TextField" then
		self._editBox:setMaxLength(maxLength)
		self._editBox:setMaxLengthEnabled(true)
		self._editBox:setTouchAreaEnabled(not self:isSpStage())
		self._editBox:setString(self._nowName)
	end

	if not self:isSpStage() then
		self._editBox = convertTextFieldToEditBox(self._editBox, nil, MaskWordType.CHAT)

		self._editBox:setText(self._nowName)
		self._editBox:onEvent(function(eventName, sender)
			if eventName == "began" then
				placeHolder = self._editBox:getPlaceHolder()
			elseif eventName == "ended" then
				-- block empty
			elseif eventName == "return" then
				local spaceCount = string.find(self._nowName, "%s")

				if spaceCount ~= nil then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("setting_tips1")
					}))

					self._nowName = self._oldName

					self._editBox:setText(self._oldName)

					return
				end

				if self._nowName ~= self._oldName then
					local teaminfo = {
						name = self._nowName,
						teamId = self._curTeamId
					}

					self._stageSystem:requestChangeTeamName(teaminfo, function()
						self._oldName = self._nowName
					end, false)
				end
			elseif eventName == "changed" then
				self._nowName = self._editBox:getText()
			elseif eventName == "ForbiddenWord" then
				self:getEventDispatcher():dispatchEvent(ShowTipEvent({
					tip = Strings:get("Common_Tip1")
				}))
			elseif eventName == "Exceed" then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Tips_WordNumber_Limit", {
						number = sender:getMaxLength()
					})
				}))
			end
		end)
	end
end

function MazeTeamMediator:onClickCell(sender, eventType, oppoRecord)
	if eventType == ccui.TouchEventType.began then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		if #self._teamPets >= self._maxTeamPetNum then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("Stage_Team_UI7")
			}))

			self._selectCanceled = true

			return true
		end

		self._isOnTeam = false
	elseif eventType == ccui.TouchEventType.moved then
		if not self._selectCanceled then
			local beganPos = sender:getTouchBeganPosition()
			local movedPos = sender:getTouchMovePosition()

			if not self._isDrag then
				self._isDrag = self:checkTouchType(beganPos, movedPos)

				if self._isDrag and not self._isOnTeam then
					self:createMovingPet(sender, 0.6)
					self:changeMovingPetPos(beganPos)

					if self._listView:getItem(sender:getTag() - 1) then
						self._listView:getItem(sender:getTag() - 1):setVisible(false)
					end
				end
			elseif self._isDrag and not self._isOnTeam then
				self:changeMovingPetPos(movedPos)

				local isContainPos = self._teamBg:getParent():convertToNodeSpace(movedPos)

				if self:checkCollision(self._teamBg, isContainPos) then
					self._isDrag = false
					self._isOnTeam = true

					self:insertTeamPet(sender)
				end
			end
		end
	elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
		if not self._selectCanceled then
			if self._listView:getItem(sender:getTag() - 1) then
				self._listView:getItem(sender:getTag() - 1):setVisible(true)
			end

			self._isDrag = false

			local endPostion = sender:getTouchEndPosition()
			local isContainPos = self._teamBg:getParent():convertToNodeSpace(endPostion)

			if not self._isOnTeam and self:checkCollision(self._teamBg, isContainPos) then
				self._isOnTeam = true

				self:insertTeamPet(sender)
			end

			self._movingPet:removeAllChildren()
		end

		self._selectCanceled = false
	end
end

function MazeTeamMediator:insertTeamPet(cell)
	self._movingPet:removeAllChildren()

	for k, v in pairs(self._petList) do
		if v == cell.id then
			table.remove(self._petList, k)
		end
	end

	self._teamPets[#self._teamPets + 1] = cell.id

	self:refreshListView()
	self:refreshPetNode()
end

function MazeTeamMediator:createMovingPet(cell, scaleNum)
	local petId = cell.id
	local heroInfo = self:getHeroInfoById(petId)
	local petNode = IconFactory:createHeroIcon(heroInfo, {
		isRect = true
	})

	if petNode then
		petNode:setAnchorPoint(cc.p(0.5, 0.5))
		petNode:addTo(self._movingPet):center(self._movingPet:getContentSize())
		self._movingPet:setScale(scaleNum)
	end
end

function MazeTeamMediator:changeMovingPetPos(pos)
	local movedPos = self._movingPet:getParent():convertToWorldSpace(pos)

	self._movingPet:setPosition(movedPos)
end

function MazeTeamMediator:checkCollision(targetPanel, pos)
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

function MazeTeamMediator:checkTouchType(pos1, pos2)
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

function MazeTeamMediator:initClickCheckReplace()
	local checkreplace = self:getView():getChildByFullName("Image_2.checkBtn")

	checkreplace:addTouchEventListener(function(sender, eventType)
		if self._uuid == "" then
			return
		end

		local data = self._optype and {
			type = self._optype,
			removeId = self._uuid
		} or {
			buyId = self._buyId,
			removeId = self._uuid
		}
		local cjson = require("cjson.safe")
		local paramsData = cjson.encode(data)

		self._mazeSystem:setOptionEventName(self._eventName)
		self._mazeSystem:requestMazestStartOption(self._index, paramsData)
		self:close()
	end)
end

function MazeTeamMediator:onClickOnTeamPet(sender, eventType, oppoRecord, info)
	if eventType == ccui.TouchEventType.began then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		self._isOnOwn = false

		if self._replace then
			local replacepanel = self:getView():getChildByFullName("Image_2.replacecell")

			replacepanel:removeAllChildren()

			local cell = sender
			local replace = cell:clone()

			replace:setPosition(0, 0)

			info.id = info.roleModel

			local img = IconFactory:createRoleIconSpriteNew({
				iconType = 1,
				id = info.roleModel
			})

			img = IconFactory:addStencilForIcon(img, 1, cc.size(100, 100))

			img:setPosition(64, 70)
			replace:getChildByFullName("teamPetClone.bg"):addChild(img)
			replacepanel:addChild(replace)

			self._uuid = sender.id.uuid
		end
	elseif eventType == ccui.TouchEventType.moved then
		-- block empty
	elseif eventType ~= ccui.TouchEventType.ended and eventType == ccui.TouchEventType.canceled then
		-- block empty
	end
end

function MazeTeamMediator:removeTeamPet(index)
	self._movingPet:removeAllChildren()
	self:cleanTeamPet(#self._teamPets)

	self._petList[#self._petList + 1] = self._teamPets[index]

	table.remove(self._teamPets, index)
	self:refreshListView()
	self:refreshPetNode()
end

function MazeTeamMediator:cleanTeamPet(num)
	local teamBg = self._bg:getChildByName("team_bg")

	for i = 1, num do
		local iconBg = teamBg:getChildByName("pet_" .. i)

		iconBg:removeAllChildren()
	end
end

function MazeTeamMediator:refreshView()
	self:initData()
	self:refreshMasterInfo()
	self:refreshListView()
	self:refreshPetNode()
	self._editBox:setText(self._nowName)
end

function MazeTeamMediator:refreshListView()
	return
end

function MazeTeamMediator:initView()
	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		if idx + 1 == 1 then
			return self._myPetClone:getContentSize().width - 40, self._myPetClone:getContentSize().height
		end

		return self._myPetClone:getContentSize().width, self._myPetClone:getContentSize().height
	end

	local function numberOfCellsInTableView(table)
		return #self._petListAll + 1
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local node = self._myPetClone:clone()

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
	self._heroPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:reloadData()
end

function MazeTeamMediator:createTeamCell(cell, index)
	local node = cell:getChildByTag(12138)
	local children = node:getChildren()

	for i = 1, #children do
		children[i]:setVisible(index ~= 1)
	end

	if index == 1 then
		return
	end

	node:setVisible(true)

	local id = self._petListAll[index - 1]

	node.id = id

	local isExcept = self._stageSystem:isHeroExcept(self._cardsExcept, id)

	node:setTouchEnabled(not isExcept)
	node:setSwallowTouches(false)
	node:addTouchEventListener(function(sender, eventType)
		if self._teamType == 2 then
			return
		end

		self:onClickCell(sender, eventType)
	end)

	local heroInfo = self:getHeroInfoById(id)

	self:initHero(node, heroInfo)
	node:getChildByName("except"):setVisible(false)

	if self._stageSystem:isHeroExcept(self._cardsExcept, id) then
		node:getChildByName("except"):setVisible(true)
	end
end

function MazeTeamMediator:initHero(node, info)
	info.id = info.roleModel

	local heroImg = IconFactory:createRoleIconSpriteNew(info)
	local heroPanel = node:getChildByName("hero")

	heroPanel:removeAllChildren()
	heroPanel:addChild(heroImg)
	heroImg:setScale(1.3)
	heroImg:setAnchorPoint(cc.p(0.5, 0.5))
	heroImg:setPosition(heroPanel:getContentSize().width / 2, heroPanel:getContentSize().height / 2 + 10)

	local bg = node:getChildByName("bg")

	bg:loadTexture(GameStyle:getHeroQualityRectFile(info.quality)[3])

	local rarity = node:getChildByName("rarity")

	rarity:loadTexture(GameStyle:getHeroRarityImage(info.rareity), 1)
	rarity:ignoreContentAdaptWithSize(true)

	local cost = node:getChildByName("cost")

	cost:setString(info.cost)

	local occupationName, occupationImg = GameStyle:getHeroOccupation(info.type)
	local occupation = node:getChildByName("occupation")

	occupation:loadTexture(occupationImg)

	local level = node:getChildByName("level")

	level:setString("Lv." .. info.level)

	local starBg = node:getChildByName("starBg")

	for i = 1, 7 do
		starBg:getChildByName("star_" .. i):setVisible(i <= info.star)
	end

	local namePanel = node:getChildByName("namePanel")
	local name = namePanel:getChildByName("name")
	local qualityLevel = namePanel:getChildByName("qualityLevel")

	name:setString(info.name)
	qualityLevel:setString(info.qualityLevel == 0 and "" or " +" .. info.qualityLevel)
	name:setPositionX(0)
	qualityLevel:setPositionX(name:getContentSize().width)
	namePanel:setContentSize(cc.size(name:getContentSize().width + qualityLevel:getContentSize().width, 30))
end

function MazeTeamMediator:refreshPetNode()
	self:refreshCombatAndCost()
	self:refreshButtons()
	self:sortOnTeamPets(self._teamPets)

	self._petNodeList = {}

	for i = 1, self._maxTeamPetNum do
		local iconBg = self._teamBg:getChildByName("pet_" .. i)

		iconBg:removeAllChildren()
		iconBg:setTag(i)
		iconBg:addTouchEventListener(function(sender, eventType)
			self:onClickOnTeamPet(sender, eventType, oppoRecord, self:getHeroInfoById(self._teamPets[i].id))
		end)

		local emptyIcon = GameStyle:createEmptyIcon()

		emptyIcon:addTo(iconBg):center(iconBg:getContentSize())

		if self._teamPets[i] then
			local heroInfo = self:getHeroInfoById(self._teamPets[i].id)

			self._petNodeList[i] = self._teamPetClone:clone()

			self._petNodeList[i]:setVisible(true)
			self:initTeamHero(self._petNodeList[i], heroInfo)
			self._petNodeList[i]:addTo(iconBg):center(iconBg:getContentSize())
			self._petNodeList[i]:offset(0, -4)
			iconBg:setTouchEnabled(true)

			iconBg.id = self._teamPets[i]
		else
			iconBg:setTouchEnabled(false)
		end
	end
end

function MazeTeamMediator:initTeamHero(node, info)
	info.id = info.roleModel
	info.clipType = 4

	local heroImg = IconFactory:createRoleIconSprite(info)

	heroImg = IconFactory:addStencilForIcon(heroImg, info.clipType, cc.size(102, 103.1))

	local heroPanel = node:getChildByName("hero")

	heroPanel:removeAllChildren()
	heroPanel:addChild(heroImg)
	heroImg:setPosition(heroPanel:getContentSize().width / 2, heroPanel:getContentSize().height / 2)

	local bg = node:getChildByName("bg")

	bg:loadTexture(GameStyle:getHeroQualityRectFile(info.quality)[4])

	local rarity = node:getChildByName("rarity")

	rarity:loadTexture(GameStyle:getHeroRarityImage(info.rareity), 1)
	rarity:ignoreContentAdaptWithSize(true)

	local cost = node:getChildByFullName("costBg.cost")

	cost:setString(info.cost)

	local occupationName, occupationImg = GameStyle:getHeroOccupation(info.type)
	local occupation = node:getChildByName("occupation")

	occupation:loadTexture(occupationImg)
end

function MazeTeamMediator:refreshCombatAndCost()
	local totalCombat = 0
	local totalCost = 0
	local averageCost = 0

	for k, v in pairs(self._teamPets) do
		local heroInfo = self._mazeSystem:getHeroById(v.id)

		totalCost = totalCost + heroInfo:getCost()
		totalCombat = totalCombat + heroInfo:getCombat()
	end

	local masterData = self._masterSystem:getMasterById(self._curMasterId)

	totalCombat = masterData and totalCombat + masterData:getCombat() or totalCombat
	self._costTotal = totalCost
	averageCost = #self._teamPets == 0 and 0 or math.floor(totalCost * 10 / #self._teamPets + 0.5) / 10

	self._labelCombat:setString(totalCombat)
	self._costAverageLabel:setString(averageCost)
	self._costTotalLabel:setString(self._costTotal)
end

function MazeTeamMediator:changeMasterId(event)
	self._oldMasterId = self._curMasterId
	self._curMasterId = event:getData().masterId

	self:refreshMasterInfo()
end

function MazeTeamMediator:refreshMasterInfo()
	local masterData = self._masterSystem:getMasterById(self._curMasterId)

	self._noMasterPanel:setVisible(false)
	self._masterImage:setVisible(true)
	self._masterImage:removeAllChildren()
	self._masterImage:addChild(self:getHalfImage())
	self._roleName:setString(self:getName())
	self:refreshCombatAndCost()
	self:refreshButtons()
end

function MazeTeamMediator:refreshButtons()
	self._arenaSaveBtn:setGray(not self:hasChangeTeam())
	self._arenaSaveBtn:setTouchEnabled(self:hasChangeTeam())
end

function MazeTeamMediator:getHeroInfoById(id)
	local heroInfo = self._mazeSystem:getHeroById(id)

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
		maxStar = heroInfo:getMaxStar(),
		littleStar = heroInfo:getLittleStar()
	}
end

function MazeTeamMediator:sortOnTeamPets(idList)
	local heroList = {}
	local ids = {}

	for i = 1, #idList do
		heroList[#heroList + 1] = self._mazeSystem:getHeroById(idList[i].id)
	end

	table.sort(heroList, function(a, b)
		if a:getCost() == b:getCost() then
			if a:getRarity() == b:getRarity() then
				return a:getId() < b:getId()
			end

			return a:getRarity() < b:getRarity()
		end

		return a:getCost() < b:getCost()
	end)

	for i = 1, #heroList do
		for k, v in pairs(self._teamPets) do
			if v.id == heroList[i]._id then
				ids[i] = v

				break
			end
		end
	end

	self._teamPets = ids
end

function MazeTeamMediator:onClickExit(data, func)
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			if outSelf:isSpStage() then
				outSelf:sendSpChangeTeam(func)
			else
				if outSelf._stageType ~= "" then
					local teaminfo = {
						teamType = outSelf._stageType,
						teamId = outSelf._curTeamId
					}

					outSelf._stageSystem:requestStageTeam(teaminfo, function()
						return
					end, false)
				end

				outSelf:sendChangeTeam(func)
			end
		elseif data.response == "cancel" then
			if func then
				func()
			end
		elseif data.response == "close" then
			-- block empty
		end
	end

	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		animation = PopViewAction:new(view)
	}, data, delegate))
end

function MazeTeamMediator:getSendData()
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

	return {
		type = 0,
		teamId = self._curTeamId,
		masterId = self._curMasterId,
		heros = sendData
	}
end

function MazeTeamMediator:hasChangeTeam()
	if self._oldMasterId ~= self._curMasterId then
		return true
	end

	if #self._tempTeams ~= #self._teamPets then
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

function MazeTeamMediator:sendSpChangeTeam(callBack)
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

	local params = {
		teamType = self._stageType,
		masterId = self._curMasterId,
		heros = sendData
	}

	self._stageSystem:requestSPChangeTeam(params, function()
		if callBack then
			callBack()
		end
	end, false, {
		ignoreTip = true
	})
end

function MazeTeamMediator:sendChangeTeam(callBack)
	local params = self:getSendData()

	self._stageSystem:requestChangeTeam(params, function()
		if callBack then
			callBack()
		end
	end, false)

	if self._stageType ~= "" then
		local teaminfo = {
			teamType = self._stageType,
			teamId = self._curTeamId
		}

		self._stageSystem:requestStageTeam(teaminfo, function()
			return
		end, false)
	end
end

function MazeTeamMediator:getHalfImage()
	local modleid = ConfigReader:getDataByNameIdAndKey("EnemyMaster", self._mazeSystem:getSelectMasterId(), "RoleModel")
	local sprite = IconFactory:createRoleIconSprite({
		stencil = 6,
		iconType = "Bust6",
		id = modleid,
		size = cc.size(560, 265)
	})

	sprite:setAnchorPoint(cc.p(0, 0))
	sprite:setPosition(cc.p(0, -4))

	return sprite
end

function MazeTeamMediator:getName()
	return Strings:get(ConfigReader:getDataByNameIdAndKey("MasterBase", self._mazeSystem:getSelectMasterId(), "Name"))
end

function MazeTeamMediator:onClickChangeMaster(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local view = self:getInjector():getInstance("ChangeMasterView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			animation = PopViewAction:new(view)
		}, {
			masterId = self._curMasterId,
			masterList = self._masterList,
			sys = self._masterSystem
		}, nil))
	end
end

function MazeTeamMediator:onClickExit(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:close()
	end
end
