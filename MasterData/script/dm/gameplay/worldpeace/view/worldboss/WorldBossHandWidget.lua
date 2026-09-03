-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/worldboss/WorldBossHandWidget.lua

WorldBossHandWidget = class("WorldBossHandWidget", WorldPeaceHandWidget)

local StateRes = {
	Protecting = "CB_icon_dun.png",
	Battling = "CB_icon_zhandou.png",
	Recovering = "CB_icon_huifu.png"
}

function WorldBossHandWidget:initialize(view, parent, isHome)
	super.initialize(self, view, parent, isHome)

	self._startPos = isHome and cc.p(256, 35) or cc.p(256, 35)
	self._gap = isHome and 108 or 125
end

function WorldBossHandWidget:onItemClick(item, sender)
	if self._wordPeaceGame:getDisplayMode() == K_RENDER_DISPLAYMODE.MULTILEVEL then
		return
	end

	item.collPanel:setVisible(false)
	item:getChildByName("collflag"):setVisible(false)

	for k, v in pairs(self._playerItems) do
		local select_nd = v:getChildByName("select")
		local bress = 0

		canAttack = true

		if not canAttack and self._parent._bossId then
			bress = -80
		end

		if v.collstate then
			bress = -80
		end

		select_nd:setVisible(false)
		v.itemTouchSelect:setVisible(false)

		local forceAction = cc.Sequence:create(cc.Spawn:create(cc.MoveTo:create(0.2, cc.p(v._orgPos.x, v._orgPos.y)), cc.ScaleTo:create(0.2, 0.8)), BrightnessTo:create(0.2, bress), cc.CallFunc:create(function()
			return
		end))

		if v.collstate and v ~= item then
			v.collPanel:setVisible(false)
			v:getChildByName("collflag"):setVisible(true)
		end

		v:runAction(forceAction)
	end

	item:stopAllActions()

	local bress = 0
	local canAttack = self._worldPeaceSystem:checkCanAttack(self._parent._bossId, item.teamInfo.camp)
	local canAttack = true

	if not canAttack and self._parent._bossId then
		bress = -80
	end

	if self._worldPeaceSystem:getTeamState(item.teamInfo.teamKey) == k_TEAM_STATE.REST and canAttack then
		local forceAction = cc.Sequence:create(cc.Spawn:create(cc.MoveTo:create(0.2, cc.p(item._orgPos.x, item._orgPos.y + 30)), cc.ScaleTo:create(0.2, 1)), BrightnessTo:create(0.2, (item.collstate or nil) and -80), cc.CallFunc:create(function()
			return
		end))

		item:runAction(forceAction)

		if item.collstate then
			item.collPanel:setVisible(true)
			item:getChildByName("collflag"):setVisible(false)
		end
	end

	local select_nd = item:getChildByName("select")

	select_nd:setVisible(true)
	item.itemTouchSelect:setVisible(true)

	self._selectNode = item
	self._selectNode.teamHpEnough = item.teamHpEnough
	self._selectNode.masterHpEnough = self._playerHpState
	self._selectNode.state = item.state

	if self._parent and self._parent.refreshOprateBtn then
		self._parent:refreshOprateBtn(self._selectNode)
	end
end

function WorldBossHandWidget:sortTeamList(teamList)
	local sortIndex = {
		XD = 4,
		BSNCT = 3,
		DWH = 1,
		MNJH = 2,
		WNSXJ = 5,
		SSZS = 6
	}
	local list = {}

	for k, v in pairs(teamList) do
		list[#list + 1] = v
	end

	table.sort(list, function(a, b)
		return sortIndex[a.camp] < sortIndex[b.camp]
	end)

	return list
end

function WorldBossHandWidget:updateInfo(playerInfo, isGuide)
	self._playerInfo = playerInfo
	self._handCardPos = self._handCardPos or {}
	self._teamDataList = self._playerInfo:getTeamDataList()

	local worldBoss = self._worldPeaceSystem:getWorldBoss()
	local startAttackTime = worldBoss:getLastAttackTime() * 0.001
	local masterData = self._playerInfo:getMasterData()

	if masterData then
		local playerBar = self._view:getChildByFullName("progress.bar")

		playerBar:setPercent(masterData.hp / masterData.maxHp * 100)

		self._playerHpState = masterData.hp / masterData.maxHp > self._clubMapBattleMasterLimit
	end

	local i = 0
	local teamList = self:sortTeamList(playerInfo:getTeamDataList())

	for k, v in pairs(teamList) do
		i = i + 1

		if not self._playerItems[v.teamKey] then
			local item = self._cloneCell:clone()
			local itemTouch = self._cloneTouch:clone()
			local collPanel = self._collPanel:clone()

			item:setPosition(self._startPos.x + (i - 1) * self._gap, self._startPos.y + 30)
			itemTouch:setPosition(self._startPos.x + (i - 1) * self._gap, self._startPos.y + 30)
			collPanel:setPosition(self._startPos.x + (i - 1) * self._gap, self._startPos.y - 48 + 30)
			collPanel:setVisible(false)

			item.collPanel = collPanel

			item:setScale(0.8)

			local iconroot = item:getChildByName("icon")
			local modelId = ConfigReader:getRecordById("HeroBase", v.topHero).RoleModel
			local heroType = ConfigReader:getRecordById("HeroBase", v.topHero).Type
			local head = ConfigReader:getRecordById("RoleModel", modelId).HeadMain2

			reapath = head .. "_wordpeace.png"

			iconroot:loadTexture(reapath, ccui.TextureResType.plistType)
			itemTouch:getChildByName("select"):setVisible(false)

			item.itemTouchSelect = itemTouch:getChildByName("select")
			item.timeleft = itemTouch:getChildByName("Text_45")

			itemTouch:setSwallowTouches(false)
			itemTouch:setClickEffectUnVisible(true)
			itemTouch:addClickEventListener(function()
				self:onItemClick(item, sender)
			end)
			item:setSwallowTouches(true)

			local selectnode = item:getChildByName("select")
			local Text_combat = item:getChildByName("Text_combat")
			local totalCombat = 0
			local heroDataList = v.heroDataList

			for k, v in pairs(heroDataList) do
				if playerInfo:getHeroCombat() and playerInfo:getHeroCombat()[k] then
					totalCombat = totalCombat + playerInfo:getHeroCombat()[k]
				end
			end

			Text_combat:setString(totalCombat)
			selectnode:setVisible(false)

			local occupationImg = IconFactory:getHeroPartyPath(v.topHero, "building")
			local occupation = ccui.ImageView:create(occupationImg, 0)

			occupation:setLocalZOrder(2)
			occupation:setScale(0.5)
			occupation:setPosition(19.93, 90.24)
			occupation:addTo(item)
			itemTouch:addTo(self._view)
			item:addTo(self._view)
			collPanel:addTo(self._view)

			item._orgPos = cc.p(item:getPosition())
			item.index = i
			self._playerItems[v.teamKey] = item
			self._handCardPos[v.teamKey] = self._playerItems[v.teamKey]:getParent():convertToWorldSpace(cc.p(self._playerItems[v.teamKey]:getPosition()))
		end

		self._playerItems[v.teamKey].state = playerInfo:getTeamStatus()[v.teamKey]
		self._playerItems[v.teamKey].teamInfo = v

		local hp = 0
		local maxhp = 0

		for k, v in pairs(v.heroDataList) do
			hp = hp + v.hp
			maxhp = maxhp + v.maxHp
		end

		local progress = self._playerItems[v.teamKey]:getChildByFullName("progress.bar")

		progress:setPercent(hp / maxhp * 100)
		self._playerItems[v.teamKey]:getChildByFullName("progress"):setVisible(false)

		self._playerItems[v.teamKey].curHp = hp / maxhp

		local preState = self._playerItems[v.teamKey]._prestate

		if preState ~= nil and preState ~= "REST" and self._playerItems[v.teamKey].state == "REST" then
			self:backToCard(v.teamKey)
		end

		self._playerItems[v.teamKey].teamHpEnough = true

		self._playerItems[v.teamKey]:setVisible(true)
		self._playerItems[v.teamKey]:getChildByName("state"):setVisible(true)

		if self._worldPeaceSystem:getTeamState(v.teamKey) == k_TEAM_STATE.REST then
			if hp / maxhp < self._clubMapBattleHeroLimit then
				self._playerItems[v.teamKey]:getChildByName("icon"):setBrightness(-80)

				self._playerItems[v.teamKey].teamHpEnough = false

				self._playerItems[v.teamKey]:getChildByName("state"):loadTexture(StateRes.Recovering, 1)
			else
				self._playerItems[v.teamKey]:getChildByName("icon"):setBrightness(0)

				self._playerItems[v.teamKey].teamHpEnough = true

				self._playerItems[v.teamKey]:getChildByName("state"):setVisible(false)
			end
		elseif self._worldPeaceSystem:getTeamState(v.teamKey) == k_TEAM_STATE.BATTLEING then
			self._playerItems[v.teamKey]:getChildByName("icon"):setBrightness(0)
			self._playerItems[v.teamKey]:getChildByName("icon"):setBrightness(-80)
			self._playerItems[v.teamKey]:getChildByName("state"):loadTexture(StateRes.Battling, 1)

			local atackBoss = self._playerInfo:getTeamStatus()[v.teamKey]

			if self:canOprate() and self._parent._bossId == atackBoss then
				self._playerItems[v.teamKey]:setVisible(false)
			end
		elseif self._worldPeaceSystem:getTeamState(v.teamKey) == k_TEAM_STATE.PROTECTING then
			self._playerItems[v.teamKey]:getChildByName("icon"):setBrightness(-80)
			self._playerItems[v.teamKey]:getChildByName("state"):loadTexture(StateRes.Protecting, 1)
		end

		self._playerItems[v.teamKey]._prestate = self._playerItems[v.teamKey].state
		self._playerItems[v.teamKey].limitFobid = false

		self._playerItems[v.teamKey]:getChildByName("info"):setTouchEnabled(true)
		self._playerItems[v.teamKey]:getChildByName("info"):addClickEventListener(function()
			local dispatcher = DmGame:getInstance()
			local view = dispatcher._injector:getInstance("WordPeaceTeamInfoView")

			dispatcher:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, self._playerItems[v.teamKey].teamInfo))
		end)
		self._playerItems[v.teamKey]:getChildByName("shou"):setTouchEnabled(true)
		self._playerItems[v.teamKey]:getChildByName("shou"):addClickEventListener(function()
			local atackBoss = self._playerInfo:getTeamStatus()[self._playerItems[v.teamKey].teamInfo.teamKey]

			self._parent:onHuiShou(atackBoss, v.teamKey)
		end)

		if self:canOprate() then
			self._playerItems[v.teamKey]:getChildByName("info"):setVisible(false)
			self._playerItems[v.teamKey]:getChildByName("shou"):setVisible(false)
		else
			local isShow = self._worldPeaceSystem:getTeamState(v.teamKey) == k_TEAM_STATE.BATTLEING or self._worldPeaceSystem:getTeamState(v.teamKey) == k_TEAM_STATE.PROTECTING

			self._playerItems[v.teamKey]:getChildByName("info"):setVisible(not isShow)
			self._playerItems[v.teamKey]:getChildByName("shou"):setVisible(isShow)
		end

		self:addEffect(self._playerItems[v.teamKey], self._worldPeaceSystem:getTeamState(v.teamKey), hp / maxhp < self._clubMapBattleHeroLimit)

		self._playerItems[v.teamKey].canAttack = true

		local curTime = self._gameServerAgent:remoteTimestamp()
		local challengeTime = ConfigReader:getRecordById("ConfigValue", "WorldBoss_ChallengeTime").content

		if curTime > challengeTime + startAttackTime then
			self._playerItems[v.teamKey].limitFobid = true
			self._playerItems[v.teamKey].canAttack = false

			self._playerItems[v.teamKey]:setVisible(true)
		end
	end

	for k, v in pairs(self._playerItems) do
		if v.index == 1 and (v.canAttack and not self._initView or isGuide) then
			self:onItemClick(v)

			self._initView = true
			isGuide = false

			break
		end
	end
end
