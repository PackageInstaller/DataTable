-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceHandWidget.lua

WorldPeaceHandWidget = class("WorldPeaceHandWidget", BaseWidget, _M)

WorldPeaceHandWidget:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WorldPeaceHandWidget:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
WorldPeaceHandWidget:has("_handCardPos", {
	is = "rw"
})

local StateRes = {
	Protecting = "CB_icon_dun.png",
	Battling = "CB_icon_zhandou.png",
	Recovering = "CB_icon_huifu.png"
}

function WorldPeaceHandWidget:getScrollView()
	if not self._parent.getScrollView then
		return nil
	end

	return self._parent:getScrollView()
end

function WorldPeaceHandWidget:getBossLayer()
	return self._parent:getBossLayer()
end

function WorldPeaceHandWidget:getBossChildren()
	return self:getBossLayer():getChildren()
end

function WorldPeaceHandWidget:initialize(view, parent, isHome)
	super.initialize(self, view)

	self._view = view
	self._parent = parent
	self._wordPeaceGame = parent._wordPeaceGame

	local playerIcon = self._view:getChildByName("Player")
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
	local player = developSystem:getPlayer()

	self._movingPet = self._view:getChildByFullName("moving_pet")

	local playerIcon = self._view:getChildByName("mask")
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local headicon = IconFactory:createRoleIconSpriteNew({
		id = "Model_Master_XueZhan",
		frameId = "bustframe7_2"
	})

	headicon:setScale(0.2)
	headicon:addTo(playerIcon)
	headicon:center(playerIcon:getContentSize())
	playerIcon:setScale(2.35)

	self._playerIcon = playerIcon

	playerIcon:setTouchEnabled(false)

	local sp = ccui.Text:create("", TTF_FONT_FZYH_M, 20)

	setTextWithFontStyle(sp, "FontZWMBText")
	sp:addTo(playerIcon:getParent())
	sp:setAnchorPoint(cc.p(0.5, 0.5))

	local pos = isHome and cc.p(130, 65) or cc.p(110, 70)
	local offset = isHome and cc.p(-25, -40) or cc.p(-32, -45)
	local scale = isHome and 2 or 2.35

	headicon:offset(offset.x, offset.y)
	playerIcon:setScale(scale)
	sp:setPosition(pos)

	self._masterHuiFU = sp
	self._playerItems = {}
	self._scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(dt)
		self:update(dt)
	end, 0.5, false)
	self._gameServerAgent = DmGame:getInstance()._injector:getInstance("GameServerAgent")
	self._clubMapBattleMasterLimit = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapBattleMasterLimit", "content")
	self._clubMapBattleHeroLimit = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapBattleHeroLimit", "content")
	self._cloneCell = self._view:getChildByName("item01")
	self._cloneTouch = self._view:getChildByName("touch")
	self._collPanel = self._view:getChildByName("coll")
	self._startPos = isHome and cc.p(320, 60) or cc.p(256, 60)
	self._gap = isHome and 108 or 125

	local campRes = {
		"CB_img_hongqizhi.png",
		"CB_img_huangqizhi.png",
		"CB_img_lanqizhi.png"
	}
	local campImg = self._view:getChildByName("Image_camp")

	if campImg then
		local worldPeaceSystem = DmGame:getInstance()._injector:getInstance(WorldPeaceSystem)
		local playerInfo = worldPeaceSystem:getMainPlayer()
		local gInfo = playerInfo:getGroupInfo()

		campImg:loadTexture(campRes[gInfo.gIndex], 1)
	end
end

function WorldPeaceHandWidget:getSelectNode()
	return self._selectNode
end

function WorldPeaceHandWidget:canOprate()
	return self._wordPeaceGame:getDisplayMode() == K_RENDER_DISPLAYMODE.ALL or self._wordPeaceGame:getDisplayMode() == K_RENDER_DISPLAYMODE.WORLDBOSS
end

function WorldPeaceHandWidget:onItemClick(item, sender)
	if self._wordPeaceGame:getDisplayMode() == K_RENDER_DISPLAYMODE.MULTILEVEL then
		if self._worldPeaceSystem:getTeamState(item.teamInfo.teamKey) == k_TEAM_STATE.REST then
			local dispatcher = DmGame:getInstance()
			local view = dispatcher._injector:getInstance("WordPeaceTeamInfoView")

			dispatcher:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, self._playerItems[item.teamInfo.teamKey].teamInfo))
		else
			local bossId = self._playerInfo:getTeamStatus()[item.teamInfo.teamKey]

			if bossId then
				local dispatcher = DmGame:getInstance()
				local view = self:getInjector():getInstance("WordPeaceBattleView")

				dispatcher:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
					bossId = bossId,
					closeCallBack = function()
						return
					end
				}))
			end
		end

		return
	end

	if item.limitFobid then
		return
	end

	item.collPanel:setVisible(false)

	for k, v in pairs(self._playerItems) do
		local select_nd = v:getChildByName("select")
		local bress = 0
		local canAttack = self._worldPeaceSystem:checkCanAttack(self._parent._bossId, v.teamInfo.camp)

		if not canAttack and self._parent._bossId then
			bress = -80
		end

		select_nd:setVisible(false)
		v.itemTouchSelect:setVisible(false)

		local forceAction = cc.Sequence:create(cc.Spawn:create(cc.MoveTo:create(0.2, cc.p(v._orgPos.x, v._orgPos.y)), cc.ScaleTo:create(0.2, 1)), BrightnessTo:create(0.2, bress), cc.CallFunc:create(function()
			return
		end))

		if v.collstate and v ~= item then
			v.collPanel:setVisible(false)
		end

		v:runAction(forceAction)
	end

	item:stopAllActions()

	local canAttack = self._worldPeaceSystem:checkCanAttack(self._parent._bossId, item.teamInfo.camp)

	if self._worldPeaceSystem:getTeamState(item.teamInfo.teamKey) == k_TEAM_STATE.REST and canAttack or self._worldPeaceSystem:getTeamState(item.teamInfo.teamKey) == k_TEAM_STATE.PROTECTING then
		local forceAction = cc.Sequence:create(cc.Spawn:create(cc.MoveTo:create(0.2, cc.p(item._orgPos.x, item._orgPos.y + 30)), cc.ScaleTo:create(0.2, 1.2)), BrightnessTo:create(0.2, (not canAttack and self._parent._bossId or nil) and -80), cc.CallFunc:create(function()
			return
		end))

		item:runAction(forceAction)
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

local dragDegActor = 15

function WorldPeaceHandWidget:checkCellTouchType(pos1, pos2)
	local xOffset = math.abs(pos1.x - pos2.x)
	local yOffset = math.abs(pos1.y - pos2.y)

	if xOffset > 10 or yOffset > 10 then
		local dragDeg1 = math.deg((math.atan(yOffset / xOffset)))

		if dragDeg1 > dragDegActor then
			return true
		end
	end

	return false
end

function WorldPeaceHandWidget:createMovingPet(cell)
	local petNode = cell:clone()

	petNode:setVisible(true)

	local children = petNode:getChildren()

	for i = 1, #children do
		local child = children[i]

		child:setVisible(false)

		if child:getName() == "icon" or child:getName() == "select" then
			child:setVisible(true)
		end
	end

	dump("createMovingPet____createMovingPet")

	if petNode then
		self._movingPet:setVisible(true)
		self._movingPet:removeAllChildren()
		petNode:setAnchorPoint(cc.p(0.5, 0.5))
		petNode:addTo(self._movingPet):center(self._movingPet:getContentSize())
	end
end

function WorldPeaceHandWidget:changeMovingPetPos(pos)
	local movedPos = self._movingPet:getParent():convertToNodeSpace(pos)

	self._movingPet:setPosition(movedPos)
end

function WorldPeaceHandWidget:getAttackFunction()
	return self._worldPeaceSystem.attackBoss
end

function WorldPeaceHandWidget:updateInfo(playerInfo)
	self._playerInfo = playerInfo
	self._handCardPos = self._handCardPos or {}
	self._teamDataList = self._playerInfo:getTeamDataList()
	self._lastCalCureTime = self._playerInfo:getLastCalCureTime()

	local masterData = self._playerInfo:getMasterData()

	if masterData then
		local playerBar = self._view:getChildByFullName("progress.bar")

		playerBar:setPercent(masterData.hp / masterData.maxHp * 100)

		self._playerHpState = masterData.hp / masterData.maxHp > self._clubMapBattleMasterLimit
	end

	local i = 0

	for k, v in pairs(playerInfo:getTeamDataList()) do
		i = i + 1

		if not self._playerItems[v.teamKey] then
			local item = self._cloneCell:clone()
			local itemTouch = self._cloneTouch:clone()
			local collPanel = self._collPanel:clone()

			item:setPosition(self._startPos.x + (i - 1) * self._gap, self._startPos.y)
			itemTouch:setPosition(self._startPos.x + (i - 1) * self._gap, self._startPos.y)
			collPanel:setPosition(self._startPos.x + (i - 1) * self._gap, self._startPos.y - 48)
			collPanel:setVisible(false)

			item.collPanel = collPanel

			local iconroot = item:getChildByName("icon")
			local modelId = ConfigReader:getRecordById("HeroBase", v.topHero).RoleModel
			local heroType = ConfigReader:getRecordById("HeroBase", v.topHero).Type
			local head = ConfigReader:getRecordById("RoleModel", modelId).HeadMain2

			reapath = head .. "_wordpeace.png"

			iconroot:loadTexture(reapath, ccui.TextureResType.plistType)
			itemTouch:getChildByName("select"):setVisible(false)

			item.itemTouchSelect = itemTouch:getChildByName("select")

			itemTouch:setSwallowTouches(true)
			itemTouch:setClickEffectUnVisible(true)
			itemTouch:addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.began then
					self._canOnSupport = false

					if self._worldPeaceSystem:getTeamState(v.teamKey) == k_TEAM_STATE.REST and not self._playerItems[v.teamKey].collstate then
						self._canOnSupport = true
					end

					if not self._movingPet then
						self._canOnSupport = false
					end
				elseif eventType == ccui.TouchEventType.moved then
					if not self._canOnSupport then
						return
					end

					local beganPos = sender:getTouchBeganPosition()
					local movedPos = sender:getTouchMovePosition()

					if not self._isDrag then
						self._isDrag = self:checkCellTouchType(beganPos, movedPos)

						if self._isDrag then
							self:createMovingPet(item)
							self:changeMovingPetPos(beganPos)
						end
					elseif self._isDrag then
						self:changeMovingPetPos(movedPos)

						if self:getScrollView() then
							self:getScrollView():setTouchEnabled(false)
						end
					end
				elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
					local beganPos = sender:getTouchBeganPosition()
					local movedPos = sender:getTouchMovePosition()
					local endPos = sender:getTouchEndPosition()

					if not self._isDrag then
						self:onItemClick(item, sender)

						return
					end

					self._isDrag = false

					if self:getScrollView() then
						self:getScrollView():setTouchEnabled(true)
					end

					local children = self:getBossChildren()

					for i = 1, #children do
						local node = children[i]
						local bossId = node.id
						local content = children[i]:getChildByFullName("content")

						if content then
							node = content:getChildByFullName("touchpanel")
							bossId = content.id
						end

						local checkPos = cc.p(self._movingPet:getPositionX(), self._movingPet:getPositionY())

						checkPos = self._movingPet:getParent():convertToWorldSpace(checkPos)
						checkPos = node:getParent():convertToNodeSpace(checkPos)

						if cc.rectContainsPoint(node:getBoundingBox(), checkPos) then
							node:setVisible(false)

							if not self._handIn then
								self._wordPeaceGame:setHandLogic(self)
								self:getAttackFunction()(self._worldPeaceSystem, {
									bossId = bossId,
									teamId = v.teamKey
								}, true, function(response)
									if response.resCode == 0 then
										local selectNode = item

										if DisposableObject:isDisposed(self) then
											return
										end

										local playerInfo = self._worldPeaceSystem:getMainPlayer()
										local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
										local player = developSystem:getPlayer()
										local heroCfg = ConfigReader:getRecordById("HeroBase", v.topHero)
										local debugData = {
											def = 0,
											sp = 1,
											isMyth = true,
											gId = "3",
											nickName = player:getNickName(),
											teamKey = v.teamKey,
											atk = playerInfo:getHeroCombat()[v.topHero],
											heroId = v.topHero,
											hpr = selectNode.curHp,
											st = v.st,
											ra = v.ra,
											cPos = playerInfo:getCPos(),
											mPhase = playerInfo:getMPhase()
										}
										local boss = self._worldPeaceSystem:getBattlefield():getBossById(bossId)

										if response.data.indef then
											local bossInstance = self._wordPeaceGame:getMemberFactory():getMemberById(bossId)

											boss:getDTeams()[v.teamKey] = Boll:new(v.teamKey)

											boss:getDTeams()[v.teamKey]:synchronize(debugData)
											boss:getDTeams()[v.teamKey]:setIsProtect(true)
											boss:getDTeams()[v.teamKey]:setGInfo(playerInfo:getGroupInfo())

											local protect = bossInstance:getProtects()

											boss:getDTeams()[v.teamKey]:setOrder(#protect + 1)
											self._wordPeaceGame:addBollForBoss(bossId, boss:getDTeamByKey(v.teamKey), 0.5)
										else
											local boss = self._worldPeaceSystem:getBattlefield():getBossById(bossId)

											boss:getATeams()[v.teamKey] = Boll:new(v.teamKey)

											boss:getATeams()[v.teamKey]:synchronize(debugData)
											boss:getATeams()[v.teamKey]:setGInfo(playerInfo:getGroupInfo())
											boss:getATeams()[v.teamKey]:setIsProtect(false)
											boss:getATeams()[v.teamKey]:setOrder(1)
											DmGame:getInstance():dispatch(Event:new(EVT_WORDPEACE_BATTLEFEILD_REFRESH, data))
										end

										self:updateInfo(playerInfo)
									end
								end)
							else
								self:onItemClick(item, sender)
								self._parent:onSupportByDray()
							end

							break
						end
					end

					self._movingPet:setVisible(false)
				end
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
			occupation:setScale(1.2)
			occupation:setPosition(19.93, 90.24)
			occupation:addTo(item)

			local sp = ccui.Text:create(Strings:get("ClubMapBoss_Recover_Hero"), TTF_FONT_FZYH_M, 18)

			setTextWithFontStyle(sp, "FontZWMBText")
			sp:addTo(item)
			sp:setAnchorPoint(cc.p(0.5, 0.5))
			sp:setPosition(72, 70)
			sp:setName("huifuStr")

			local timeText = ccui.Text:create(Strings:get(""), TTF_FONT_FZYH_M, 18)

			setTextWithFontStyle(timeText, "FontLSTCHText")
			timeText:addTo(item)
			timeText:setAnchorPoint(cc.p(0.5, 0.5))
			timeText:setPosition(72, 65)
			timeText:setName("timeText")
			itemTouch:addTo(self._view)
			item:addTo(self._view)
			collPanel:addTo(self._view)

			item._orgPos = cc.p(item:getPosition())
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

		self._playerItems[v.teamKey].curHp = hp / maxhp

		local preState = self._playerItems[v.teamKey]._prestate

		if preState ~= nil and preState ~= "REST" and self._playerItems[v.teamKey].state == "REST" then
			self:backToCard(v.teamKey)
		end

		self._playerItems[v.teamKey]._tipStr = Strings:get("ClubMapBoss_Recover_Hero")

		self._playerItems[v.teamKey]:getChildByName("huifuStr"):setVisible(false)

		self._playerItems[v.teamKey].teamHpEnough = true

		self._playerItems[v.teamKey]:setVisible(true)
		self._playerItems[v.teamKey]:getChildByName("huifuStr"):setPositionY(70)
		self._playerItems[v.teamKey]:getChildByName("state"):setVisible(true)

		if self._worldPeaceSystem:getTeamState(v.teamKey) == k_TEAM_STATE.REST then
			if hp / maxhp < self._clubMapBattleHeroLimit then
				self._playerItems[v.teamKey]:getChildByName("icon"):setBrightness(-80)
				self._playerItems[v.teamKey]:getChildByName("huifuStr"):setVisible(true)

				self._playerItems[v.teamKey].teamHpEnough = false

				self._playerItems[v.teamKey]:getChildByName("state"):loadTexture(StateRes.Recovering, 1)
				self._playerItems[v.teamKey]:getChildByName("huifuStr"):setString(Strings:get("ClubMapBoss_Recover_Hero"))

				local lastCureTime = self._lastCalCureTime[v.teamKey]
				local cureHpLimit = maxhp * self._clubMapBattleHeroLimit
				local cd = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapHealCD", "content")
				local cureNum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapHealHero", "content")
				local cdCure = maxhp * cureNum
				local time = math.ceil((cureHpLimit - hp) / cdCure) * cd
				local recoverTime = lastCureTime * 0.001 + time + 2
				local curTime = self._gameServerAgent:remoteTimestamp()
				local remainTime = math.max(0, recoverTime - curTime)
				local timeTxt = self._playerItems[v.teamKey]:getChildByName("timeText")

				timeTxt:setVisible(true)
				timeTxt:setString(TimeUtil:formatTime("${H}:${M}:${S}", remainTime))
				self._playerItems[v.teamKey]:getChildByName("huifuStr"):setPositionY(85)
				timeTxt:stopAllActions()
				timeTxt:runAction(cc.RepeatForever:create(DelayAction:create(function()
					local curTime = self._gameServerAgent:remoteTimestamp()
					local remainTime = math.max(0, recoverTime - curTime)

					timeTxt:setString(TimeUtil:formatTime("${H}:${M}:${S}", remainTime))
				end, 1)))
			else
				self._playerItems[v.teamKey]:getChildByName("icon"):setBrightness(0)
				self._playerItems[v.teamKey]:getChildByName("huifuStr"):setVisible(false)

				self._playerItems[v.teamKey].teamHpEnough = true

				self._playerItems[v.teamKey]:getChildByName("state"):setVisible(false)

				local timeTxt = self._playerItems[v.teamKey]:getChildByName("timeText")

				timeTxt:setVisible(false)
			end
		elseif self._worldPeaceSystem:getTeamState(v.teamKey) == k_TEAM_STATE.BATTLEING then
			self._playerItems[v.teamKey]._tipStr = Strings:get("ClubMapBoss_Battle_Hero")

			self._playerItems[v.teamKey]:getChildByName("huifuStr"):setVisible(true)
			self._playerItems[v.teamKey]:getChildByName("huifuStr"):setString(Strings:get("ClubMapBoss_Battle_Hero"))
			self._playerItems[v.teamKey]:getChildByName("icon"):setBrightness(0)
			self._playerItems[v.teamKey]:getChildByName("icon"):setBrightness(-80)
			self._playerItems[v.teamKey]:getChildByName("state"):loadTexture(StateRes.Battling, 1)

			local atackBoss = self._playerInfo:getTeamStatus()[v.teamKey]

			if self:canOprate() and self._parent._bossId == atackBoss then
				self._playerItems[v.teamKey]:setVisible(false)
			end
		elseif self._worldPeaceSystem:getTeamState(v.teamKey) == k_TEAM_STATE.PROTECTING then
			self._playerItems[v.teamKey]._tipStr = Strings:get("ClubMapBoss_Garrison_Hero")

			self._playerItems[v.teamKey]:getChildByName("huifuStr"):setVisible(true)
			self._playerItems[v.teamKey]:getChildByName("huifuStr"):setString(Strings:get("ClubMapBoss_Garrison_Hero"))
			self._playerItems[v.teamKey]:getChildByName("icon"):setBrightness(0)
			self._playerItems[v.teamKey]:getChildByName("icon"):setBrightness(-80)
			self._playerItems[v.teamKey]:getChildByName("state"):loadTexture(StateRes.Protecting, 1)
		end

		self._playerItems[v.teamKey]._prestate = self._playerItems[v.teamKey].state
		self._playerItems[v.teamKey].limitFobid = false

		local canAttack = self._worldPeaceSystem:checkCanAttack(self._parent._bossId, v.camp)

		if not canAttack and self._parent._bossId then
			self._playerItems[v.teamKey]:setBrightness(-80)

			self._playerItems[v.teamKey]._tipStr = Strings:get("ClubMapBoss_limit_Hero")

			self._playerItems[v.teamKey]:getChildByName("huifuStr"):setVisible(true)
			self._playerItems[v.teamKey]:getChildByName("huifuStr"):setString(Strings:get("ClubMapBoss_limit_Hero"))

			self._playerItems[v.teamKey].limitFobid = true
		end

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

		self._playerItems[v.teamKey].canAttack = canAttack

		if self._playerInfo:getTeamLastRecallTime()[v.teamKey] and not self._playerItems[v.teamKey].limitFobid and hp / maxhp > self._clubMapBattleHeroLimit then
			local curTime = self._gameServerAgent:remoteTimeMillis() / 1000
			local colltime = self._playerInfo:getTeamLastRecallTime()[v.teamKey] / 1000
			local times = self._playerInfo:getClubMapActionCD()

			if times > curTime - colltime then
				self._playerItems[v.teamKey]:getChildByName("icon"):setBrightness(-110)

				self._playerItems[v.teamKey].collstate = true

				local timeTxt = self._playerItems[v.teamKey]:getChildByName("timeText")

				timeTxt:setVisible(true)

				local t = math.max(0, times - (curTime - colltime))

				timeTxt:setString(TimeUtil:formatTime("${M}:${S}", t))
				timeTxt:stopAllActions()
				timeTxt:runAction(cc.RepeatForever:create(DelayAction:create(function()
					t = t - 1

					if t >= 1 then
						t = t or 1
					end

					timeTxt:setString(TimeUtil:formatTime("${M}:${S}", t))
				end, 1)))
				self._playerItems[v.teamKey].collPanel:setVisible(false)
				self._playerItems[v.teamKey]:getChildByName("huifuStr"):setPositionY(85)
				self._playerItems[v.teamKey]:getChildByName("huifuStr"):setVisible(true)
				self._playerItems[v.teamKey]:getChildByName("huifuStr"):setString(Strings:get("ClubMapBoss_reconditioning"))
			else
				self._playerItems[v.teamKey]:getChildByName("icon"):setBrightness(0)

				self._playerItems[v.teamKey].collstate = false

				local coll = self._playerItems[v.teamKey]:getChildByName("coll")

				self._playerItems[v.teamKey].collPanel:setVisible(false)
				self._playerItems[v.teamKey]:getChildByName("timeText"):setVisible(false)
			end
		end
	end

	for k, v in pairs(self._playerItems) do
		if v.canAttack and not self._initView and self._wordPeaceGame:getDisplayMode() ~= K_RENDER_DISPLAYMODE.MULTILEVEL then
			self:onItemClick(v)

			self._initView = true

			break
		end
	end

	if not self._playerHpState then
		self._playerIcon:setBrightness(-80)
		self._masterHuiFU:setBrightness(-80)
		self._masterHuiFU:setVisible(true)
		self._masterHuiFU:setString(Strings:get("ClubMapBoss_Recover_Hero"))
	else
		self._playerIcon:setBrightness(0)
		self._masterHuiFU:setVisible(true)
		self._masterHuiFU:setBrightness(0)
		self._masterHuiFU:setString("")
	end
end

function WorldPeaceHandWidget:addEffect(item, state, isLowHp)
	local anim

	if state == k_TEAM_STATE.PROTECTING then
		anim = "zhushou_qiuqiuzhandou"
	elseif state == k_TEAM_STATE.BATTLEING then
		anim = "zhandou_qiuqiuzhandou"
	elseif state == k_TEAM_STATE.REST then
		if isLowHp then
			anim = "huifu_qiuqiuzhandou"
		elseif item.__playingAnim then
			item.__playingAnim:removeFromParent()

			item.__playingAnim = nil
			item.__playingAnimName = nil
		end
	elseif item.__playingAnim then
		item.__playingAnim:removeFromParent()

		item.__playingAnim = nil
		item.__playingAnimName = nil
	end

	if anim then
		if item.__playingAnimName and item.__playingAnimName == anim then
			return
		end

		if item.__playingAnim then
			item.__playingAnim:removeFromParent()

			item.__playingAnim = nil
		end

		local animObj = cc.MovieClip:create(anim)

		animObj:addTo(item)
		animObj:center(item:getContentSize())

		item.__playingAnim = animObj
		item.__playingAnimName = anim
	end
end

function WorldPeaceHandWidget:getTargetNode(teamKey)
	return self._playerItems[teamKey]
end

function WorldPeaceHandWidget:backToCard(teamKey, node)
	if self._parent.backToCard then
		self._parent:backToCard(teamKey, node)
	end
end

function WorldPeaceHandWidget:dispose()
	super.dispose(self)

	if self._scheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._scheduler)

		self._scheduler = nil
	end
end

function WorldPeaceHandWidget:update()
	return
end

WorldPeaceHandInWidget = class("WorldPeaceHandInWidget", WorldPeaceHandWidget, _M)

function WorldPeaceHandInWidget:getBossChildren()
	return {
		self._parent:getBossLayer()
	}
end

function WorldPeaceHandInWidget:initialize(view, parent, isHome)
	super.initialize(self, view, parent, isHome)

	self._handIn = true
end
