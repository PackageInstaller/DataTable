-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerChallengeEndMediator.lua

TowerChallengeEndMediator = class("TowerChallengeEndMediator", DmAreaViewMediator, _M)

TowerChallengeEndMediator:has("_towerSystem", {
	is = "r"
}):injectWith("TowerSystem")
TowerChallengeEndMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	mTouchLayout = "onTouchLayout"
}
local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}

function TowerChallengeEndMediator:initialize()
	super.initialize(self)
end

function TowerChallengeEndMediator:dispose()
	super.dispose(self)
end

function TowerChallengeEndMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function TowerChallengeEndMediator:onRemove()
	super.onRemove(self)
end

function TowerChallengeEndMediator:enterWithData(data)
	self:initData(data)
	self:initWidget()
	self:refreshView()
end

function TowerChallengeEndMediator:userInject()
	self._heroSystem = self._developSystem:getHeroSystem()
end

function TowerChallengeEndMediator:initData(data)
	self._data = data
	self._showRewards = false
	self._touchClose = false
	self._scrollHeight = {}
	self._rewardScrollHeight = {}
	self._totalWin = self._data.totalWin
	self._infoTableView = nil
	self._rewardTableView = nil
	self._buff = {}

	for _, v in pairs(self._data.gotBuffs) do
		table.insert(self._buff, v)
	end

	self._curTeam = {}

	for _, v in pairs(self._data.teamHeroes) do
		table.insert(self._curTeam, v)
	end

	self._rewards = self._data.finalReward

	for _, v in pairs(self._data.baseReward) do
		v.id = v.code

		table.insert(self._rewards, v)
	end

	self._rewards = self._towerSystem:sortRewards(self._rewards, true)
	self._fragment = {}

	for k, v in pairs(self._data.fragment) do
		local fragment = {}

		fragment.code = k
		fragment.amount = v
		fragment.type = 2

		table.insert(self._fragment, fragment)
	end

	self._fragment = self._towerSystem:sortRewards(self._fragment, true)
end

function TowerChallengeEndMediator:initWidget()
	self._main = self:getView():getChildByName("content")
	self._missionInfo = self._main:getChildByName("mission_info_clone")
	self._infoCellClone = self._main:getChildByName("buff_info_clone")
	self._teamPetClone = self._main:getChildByName("myPetClone")
	self._buffClone = self._main:getChildByName("buff_clone")
end

function TowerChallengeEndMediator:refreshView()
	self:createShowInfo()
	self:createRewardList()
	self:showHeroPanel()
end

function TowerChallengeEndMediator:showHeroPanelAnim()
	local animNode = self._main:getChildByName("heroAndBgPanel")
	local anim = cc.MovieClip:create("tiaozhanjieshu_fubenjiesuan")

	anim:addEndCallback(function()
		anim:stop()
	end)

	local winNode = anim:getChildByFullName("winNode")
	local winAnim = cc.MovieClip:create("shengliz_jingjijiesuan")

	winAnim:addEndCallback(function()
		winAnim:stop()
	end)
	winAnim:addTo(winNode)

	local winPanel = winAnim:getChildByFullName("winTitle")
	local title = ccui.ImageView:create("zyfb_tzjs.png", 1)

	title:addTo(winPanel)

	local mvpSpritePanel = anim:getChildByName("roleNode")

	mvpSpritePanel:addChild(self._mvpSprite)
	self._mvpSprite:setPosition(cc.p(cc.p(-200, -200)))
	anim:addTo(animNode):center(animNode:getContentSize())
	anim:gotoAndPlay(1)

	local callFunc = cc.CallFunc:create(function()
		self._infoTableView:setVisible(true)

		self._showRewards = false
		self._touchClose = true
	end)
	local fadeIn = cc.FadeIn:create(0.4)
	local delay = cc.DelayTime:create(0.7)
	local seq = cc.Sequence:create(delay, callFunc, fadeIn)

	self._infoTableView:runAction(seq)
end

function TowerChallengeEndMediator:showHeroPanel()
	local tower = self._towerSystem:getTowerDataById(self._towerSystem:getCurTowerId())
	local team = tower:getTeam()
	local master = team:getMaster()
	local towerMasterId
	local enemyMaster = ConfigReader:getDataByNameIdAndKey("TowerMaster", (team or nil) and team:getMasterId(), "Master")
	local model = ConfigReader:getDataByNameIdAndKey("EnemyMaster", enemyMaster, "RoleModel")

	model = IconFactory:getSpMvpBattleEndMid(model)

	local mvpSprite = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe17",
		id = model
	})

	mvpSprite:setScale(0.8)

	self._mvpSprite = mvpSprite

	local roleId = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Hero")
	local heroMvpText

	self._main:getChildByFullName("role_text.text_1"):setString(master:getName())
	self._main:getChildByFullName("role_text.text_2"):setString(master:getFeature())

	local textPanel = self._main:getChildByFullName("role_text")

	textPanel:runAction(cc.FadeIn:create(0.6))
	self:showHeroPanelAnim()
end

function TowerChallengeEndMediator:leaveWithData()
	self:onTouchLayout()
end

function TowerChallengeEndMediator:onTouchLayout(sender, eventType)
	if not self._touchClose then
		return
	end

	if self._showRewards then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, {
			viewName = "TowerMainView"
		}))
	else
		self:showRewardListAnim()
	end
end

function TowerChallengeEndMediator:showMissionInfo(cell)
	cell:setVisible(true)

	local text = cell:getChildByName("text")
	local text1 = cell:getChildByName("text1")
	local text2 = cell:getChildByName("text_2")

	text:setString(self._totalWin)
	text:setPositionX(text1:getPositionX() + text1:getContentSize().width + 10)
	text2:setPositionX(text:getPositionX() + text:getContentSize().width + 6)
end

function TowerChallengeEndMediator:showBuffInfo(cell)
	cell:setVisible(true)
	cell:setContentSize(cc.size(508, self._scrollHeight[1] - 20))
	cell:getChildByFullName("Image_127"):setPositionY(self._scrollHeight[1] - 30)
	cell:getChildByFullName("Image_127.title"):setString(Strings:get("Tower_Settle_Buff"))

	local baseView = cell:getChildByFullName("buff_bg")

	baseView:removeAllChildren()

	local buffs = self._buff

	for i = 1, #buffs do
		local itemCell = self._buffClone:clone()

		itemCell:setScale(0.9)
		itemCell:setPosition(cc.p((i - 1) * 61 + 21, 0))

		local buffNode = itemCell:getChildByName("buff")
		local skill = ConfigReader:getRecordById("Skill", buffs[i])
		local info = {
			levelHide = true,
			id = skill.Id,
			skillType = skill.Type
		}
		local newSkillNode = IconFactory:createMasterSkillIcon(info)

		newSkillNode:setAnchorPoint(0.5, 0.5)
		newSkillNode:setScale(0.5)
		newSkillNode:addTo(buffNode):center(buffNode:getContentSize()):offset(0, 20)

		local buffName = itemCell:getChildByName("name")

		buffName:setString(Strings:get(skill.Name))
		buffName:setPosition(65, 55)
		baseView:addChild(itemCell)
	end
end

function TowerChallengeEndMediator:showCardInfo(cell)
	cell:setVisible(true)
	cell:setContentSize(cc.size(508, self._scrollHeight[2]))
	cell:getChildByFullName("buff_bg"):setContentSize(cc.size(508, self._scrollHeight[2] - 20))
	cell:getChildByFullName("Image_127"):setPositionY(self._scrollHeight[2] - 30)
	cell:getChildByFullName("Image_127.title"):setString(Strings:get("Tower_Settle_Team"))

	local baseView = cell:getChildByFullName("buff_bg")

	baseView:removeAllChildren()

	local heros = self._curTeam
	local heroNum = #heros
	local index = 1

	for k, v in ipairs(heros) do
		local cardCell = self._teamPetClone:clone()

		cardCell:setScale(0.5)

		local r = index
		local l = 2

		if heroNum <= 5 then
			l = 1
		end

		if index > 5 then
			r = index - 5
			l = 1
		end

		local posX = (r - 1) * 82 + 65 + (r - 1) * 15
		local posY = 110 * (l - 1) + 60

		cardCell:setPosition(cc.p(posX, posY))

		local heroInfo = self:getHeroInfoById(v)

		self:initHero(cardCell, heroInfo)
		baseView:addChild(cardCell)

		index = index + 1
	end
end

function TowerChallengeEndMediator:getHeroInfoById(data)
	local heroInfo = TowerHero:new()

	heroInfo:synchronize(data)

	return {
		id = heroInfo:getId(),
		level = heroInfo:getLevel(),
		star = heroInfo:getStar(),
		quality = heroInfo:getQuality(),
		rarity = heroInfo:getRarity(),
		qualityLevel = heroInfo:getQualityLevel(),
		name = heroInfo:getName(),
		roleModel = heroInfo:getRoleModel(),
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
		def = heroInfo:getDef()
	}
end

function TowerChallengeEndMediator:initHero(node, info)
	info.id = info.roleModel

	local heroImg = IconFactory:createRoleIconSpriteNew(info)

	heroImg:setScale(0.68)

	local heroPanel = node:getChildByName("hero")

	heroPanel:removeAllChildren()
	heroImg:addTo(heroPanel):center(heroPanel:getContentSize())

	local bg1 = node:getChildByName("bg1")
	local bg2 = node:getChildByName("bg2")

	bg1:loadTexture(GameStyle:getHeroRarityBg(info.rarity)[1])
	bg2:loadTexture(GameStyle:getHeroRarityBg(info.rarity)[2])
	bg1:removeAllChildren()
	bg2:removeAllChildren()

	if kHeroRarityBgAnim[info.rarity] then
		local anim = cc.MovieClip:create(kHeroRarityBgAnim[info.rarity])

		anim:addTo(bg1):center(bg1:getContentSize())
		anim:setPosition(cc.p(bg1:getContentSize().width / 2 - 1, bg1:getContentSize().height / 2 - 30))

		if info.rareity == 15 then
			anim:setPosition(cc.p(bg1:getContentSize().width / 2 - 3, bg1:getContentSize().height / 2))
		end

		if info.rarity >= 14 then
			local anim = cc.MovieClip:create("ssrlizichai_yingxiongxuanze")

			anim:addTo(bg2):center(bg2:getContentSize()):offset(5, -20)
		end
	else
		local sprite = ccui.ImageView:create(GameStyle:getHeroRarityBg(info.rarity)[1])

		sprite:addTo(bg1):center(bg1:getContentSize())
	end

	local rarity = node:getChildByFullName("rarityBg.rarity")

	rarity:removeAllChildren()

	local rarityAnim = IconFactory:getHeroRarityAnim(info.rarity)

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

	local expRato = node:getChildByFullName("image_combat_bg.text_compose_ratio")

	expRato:setString(tostring(math.ceil(info.expRatio * 100)) .. "%")

	if info.expRatio < 1 then
		expRato:setTextColor(cc.c3b(255, 255, 255))
	else
		expRato:setTextColor(cc.c3b(191, 241, 26))
	end

	local v = info.expRatio < 1

	node:getChildByFullName("image_combat_bg.ratioBg"):setVisible(v)
	node:getChildByFullName("image_combat_bg.ratioBg100"):setVisible(not v)

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

function TowerChallengeEndMediator:createShowInfo()
	local scrollLayer = self._main:getChildByName("scrollView")

	scrollLayer:setVisible(false)

	local viewSize = scrollLayer:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	self._scrollHeight = {}

	local function numberOfCells(view)
		return 3
	end

	local function cellTouched(table, cell)
		self:showRewardListAnim()
	end

	local function cellSize(table, idx)
		local kCellWidth = 508
		local kCellHeight = 0

		if idx == 2 then
			kCellHeight = 35
		elseif idx == 1 then
			local heroNum = #self._curTeam

			heroNum = math.max(heroNum, 1)
			kCellHeight = math.ceil(heroNum / 5) * 110 + 50 - 7
		elseif idx == 0 then
			kCellHeight = 114
		end

		self._scrollHeight[idx + 1] = kCellHeight

		return kCellWidth, kCellHeight
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		cell = cell or cc.TableViewCell:new()

		cell:removeAllChildren()
		self:updateTableCell(cell, idx)

		return cell
	end

	local function onScroll()
		return
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setPosition(scrollLayer:getPosition())
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	scrollLayer:getParent():addChild(tableView)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:reloadData()

	self._infoTableView = tableView

	self._infoTableView:setOpacity(0)
	self._infoTableView:setVisible(false)
end

function TowerChallengeEndMediator:updateTableCell(cell, index)
	local itemCell

	if index == 2 then
		itemCell = self._missionInfo:clone()

		cell:addChild(itemCell)
		self:showMissionInfo(itemCell)
	elseif index == 1 then
		itemCell = self._infoCellClone:clone()

		cell:addChild(itemCell)
		self:showCardInfo(itemCell)
	elseif index == 0 then
		itemCell = self._infoCellClone:clone()

		cell:addChild(itemCell)
		self:showBuffInfo(itemCell)
	end

	itemCell:setPosition(cc.p(0, 0))
end

function TowerChallengeEndMediator:createRewardList()
	local scrollLayer = self._main:getChildByName("scrollView")

	scrollLayer:setVisible(false)

	local viewSize = scrollLayer:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	self._rewardScrollHeight = {}

	local function numberOfCells(view)
		local num1 = #self._rewards
		local num2 = #self._fragment

		if num1 > 0 and num2 > 0 then
			return 2
		else
			return 1
		end
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		local kCellWidth = 508
		local kCellHeight = 0
		local num = 0

		if idx == 0 then
			num = math.max(#self._rewards, 1)
		elseif idx == 1 then
			num = math.max(#self._fragment, 1)
		end

		kCellHeight = math.ceil(num / 5) * 100 + 30
		self._rewardScrollHeight[idx + 1] = kCellHeight

		return kCellWidth, kCellHeight
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		cell = cell or cc.TableViewCell:new()

		cell:removeAllChildren()
		self:updateRewardTableCell(cell, idx)

		return cell
	end

	local function onScroll()
		return
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setPosition(scrollLayer:getPosition())
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	scrollLayer:getParent():addChild(tableView)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:reloadData()

	self._rewardTableView = tableView

	self._rewardTableView:setOpacity(0)
	self._rewardTableView:setVisible(false)
end

function TowerChallengeEndMediator:showRewardListAnim()
	self._showRewards = true

	self._infoTableView:setVisible(false)
	self._rewardTableView:setVisible(true)
	self._rewardTableView:setOpacity(255)
end

function TowerChallengeEndMediator:updateRewardTableCell(cell, index)
	local itemCell

	if index == 0 then
		itemCell = self._infoCellClone:clone()

		cell:addChild(itemCell)
		self:showMissonRewardList(itemCell)
	elseif index == 1 then
		itemCell = self._infoCellClone:clone()

		cell:addChild(itemCell)
		self:showSynthRewardList(itemCell)
	end

	itemCell:setPosition(cc.p(0, 0))
end

function TowerChallengeEndMediator:showSynthRewardList(cell)
	cell:setVisible(true)
	cell:setContentSize(cc.size(508, self._rewardScrollHeight[2]))
	cell:getChildByFullName("buff_bg"):setContentSize(cc.size(508, self._rewardScrollHeight[2] - 20))
	cell:getChildByFullName("Image_127"):setPositionY(self._rewardScrollHeight[2] - 25)
	cell:getChildByFullName("Image_127.title"):setString(Strings:get("Tower_Settle_Synthetize_Reward"))

	local baseView = cell:getChildByFullName("buff_bg")

	baseView:removeAllChildren()

	local rewards = self._fragment
	local num = #rewards
	local maxRow = math.max(1, math.ceil(num / 5))

	for i = 1, num do
		local reward = IconFactory:createRewardIcon(rewards[i], {
			isWidget = true
		})

		IconFactory:bindTouchHander(reward, IconTouchHandler:new(self), rewards[i], {
			needDelay = true
		})
		reward:setScale(0.7)

		local row = maxRow + 1 - math.max(1, math.ceil(i / 5))
		local line = math.fmod(i, 5)

		if line == 0 then
			line = 5
		end

		local posX = (line - 1) * 82 + 65 + (line - 1) * 15
		local posY = 90 * (row - 1) + 45

		reward:setPosition(cc.p(posX, posY))
		baseView:addChild(reward)
	end
end

function TowerChallengeEndMediator:showMissonRewardList(cell)
	cell:setVisible(true)
	cell:setContentSize(cc.size(508, self._rewardScrollHeight[1]))
	cell:getChildByFullName("buff_bg"):setContentSize(cc.size(508, self._rewardScrollHeight[1] - 20))
	cell:getChildByFullName("Image_127"):setPositionY(self._rewardScrollHeight[1] - 30)
	cell:getChildByFullName("Image_127.title"):setString(Strings:get("Tower_Settle_Point_Reward"))

	local baseView = cell:getChildByFullName("buff_bg")

	baseView:removeAllChildren()

	local rewards = self._rewards
	local num = #rewards
	local maxRow = math.max(1, math.ceil(num / 5))

	for i = 1, num do
		local reward = IconFactory:createRewardIcon(rewards[i], {
			isWidget = true
		})

		IconFactory:bindTouchHander(reward, IconTouchHandler:new(self), rewards[i], {
			needDelay = true
		})
		reward:setScale(0.7)

		local row = maxRow + 1 - math.max(1, math.ceil(i / 5))
		local line = math.fmod(i, 5)

		if line == 0 then
			line = 5
		end

		local posX = (line - 1) * 82 + 65 + (line - 1) * 15
		local posY = 90 * (row - 1) + 45

		reward:setPosition(cc.p(posX, posY))
		baseView:addChild(reward)
	end
end
