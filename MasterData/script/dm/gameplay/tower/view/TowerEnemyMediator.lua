-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerEnemyMediator.lua

TowerEnemyMediator = class("TowerEnemyMediator", DmPopupViewMediator, _M)

TowerEnemyMediator:has("_towerSystem", {
	is = "rw"
}):injectWith("TowerSystem")

local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}
local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBack"
	}
}

function TowerEnemyMediator:initialize()
	super.initialize(self)
end

function TowerEnemyMediator:dispose()
	super.dispose(self)
end

function TowerEnemyMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function TowerEnemyMediator:enterWithData(data)
	local data = self._towerSystem:getTowerDataById(self._towerSystem:getCurTowerId())
	local towerPoint = data:getBattlePointData()
	local towerEnemy = towerPoint:getTowerEnemy()
	local towerEnemyConfig = towerEnemy:getConfig()

	self._enemyMasterRoleModel = towerEnemy:getEnemyMasterRoleModel()
	self._enemyCombat = data:getBattlePointData():getCombat()
	self._teamPets = towerEnemy:getEnemyTeamPets()
	self._name = towerEnemy:getName()
	self._index = data:getBattleIndex()

	self:initContent()
end

function TowerEnemyMediator:initContent()
	self._teamBg = self:getView():getChildByFullName("main.team_bg")

	GameStyle:setCommonOutlineEffect(self:getView():getChildByFullName("main.textGuanIndex"))
	GameStyle:setCommonOutlineEffect(self:getView():getChildByFullName("main.textGuanName"))
	GameStyle:setCommonOutlineEffect(self:getView():getChildByFullName("main.Text_147_0_0"))
	GameStyle:setCommonOutlineEffect(self:getView():getChildByFullName("main.textPowerNum"))
	self:getView():getChildByFullName("main.textGuanIndex"):setString(Strings:get("Tower_Point_Num", {
		num = self._index + 1
	}))
	self:getView():getChildByFullName("main.textGuanName"):setString(Strings:get(self._name))
	self:getView():getChildByFullName("main.textPowerNum"):setString(self._enemyCombat)

	local roleNode = self:getView():getChildByFullName("main.roleClone.Panel_role_image")
	local info = {
		frameId = "bustframe7_1",
		id = self._enemyMasterRoleModel
	}
	local masterIcon = IconFactory:createRoleIconSpriteNew(info)

	masterIcon:setAnchorPoint(cc.p(0.5, 0.5))
	masterIcon:addTo(roleNode):center(roleNode:getContentSize()):offset(10, -50)
	masterIcon:setScale(0.9)
	self:refreshPetNode()
	self:initLockIcons()
end

function TowerEnemyMediator:refreshPetNode()
	local teamPetClone = self:getView():getChildByFullName("main.teamPetClone")

	teamPetClone:setVisible(false)

	self._petNodeList = {}

	for i = 1, #self._teamPets do
		local iconBg = self._teamBg:getChildByName("pet_" .. i)

		if not iconBg then
			return
		end

		iconBg:removeAllChildren()
		iconBg:setTag(i)
		iconBg:addTouchEventListener(function(sender, eventType)
			return
		end)

		local emptyIcon = GameStyle:createEmptyIcon()

		emptyIcon:addTo(iconBg):center(iconBg:getContentSize())
		emptyIcon:setName("EmptyIcon")

		iconBg.id = nil

		local id = self._teamPets[i]

		if id then
			self._petNodeList[i] = teamPetClone:clone()

			self._petNodeList[i]:setVisible(true)

			self._petNodeList[i].id = id

			local heroInfo = self:getHeroInfoById(id)

			self:initTeamHero(self._petNodeList[i], heroInfo)
			self._petNodeList[i]:addTo(iconBg):center(iconBg:getContentSize())
			self._petNodeList[i]:offset(0, -9)
			iconBg:setTouchEnabled(true)

			iconBg.id = self._teamPets[i]

			self._petNodeList[i]:setScale(0.65)
		else
			iconBg:setTouchEnabled(false)
		end
	end
end

function TowerEnemyMediator:getHeroInfoById(id)
	local heroInfo = ConfigReader:requireRecordById("EnemyHero", id)

	if not heroInfo then
		return nil
	end

	return {
		id = heroInfo.Id,
		level = heroInfo.Level,
		star = heroInfo.Star,
		quality = heroInfo.Quality,
		rareity = heroInfo.Rarity,
		qualityLevel = heroInfo.QualityLevel,
		name = heroInfo.Name,
		roleModel = heroInfo.RoleModel,
		type = heroInfo.Type,
		cost = heroInfo.Cost,
		combat = heroInfo.Combat
	}
end

function TowerEnemyMediator:initTeamHero(node, info)
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
end

function TowerEnemyMediator:onClickBack()
	self:close()
end

function TowerEnemyMediator:initLockIcons()
	local maxShowNum = 10

	if maxShowNum <= #self._teamPets then
		return
	end

	for i = #self._teamPets + 1, maxShowNum do
		local iconBg = self._teamBg:getChildByName("pet_" .. i)

		iconBg:removeAllChildren()

		local emptyIcon = GameStyle:createEmptyIcon(true)

		emptyIcon:addTo(iconBg):center(iconBg:getContentSize())
	end
end
