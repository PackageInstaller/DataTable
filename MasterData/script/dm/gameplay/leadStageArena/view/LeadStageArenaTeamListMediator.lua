-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/leadStageArena/view/LeadStageArenaTeamListMediator.lua

LeadStageArenaTeamListMediator = class("LeadStageArenaTeamListMediator", DmAreaViewMediator, _M)

LeadStageArenaTeamListMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
LeadStageArenaTeamListMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
LeadStageArenaTeamListMediator:has("_leadStageArenaSystem", {
	is = "r"
}):injectWith("LeadStageArenaSystem")

local kBtnHandlers = {
	btn_rule = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	},
	["main.node_team.btn_change1"] = {
		clickAudio = "Se_Click_BYYYC_Change",
		func = "onClickChange1"
	},
	["main.node_team.btn_change2"] = {
		clickAudio = "Se_Click_BYYYC_Change",
		func = "onClickChange2"
	},
	["main.Image_7.Button_1"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickSpRule"
	}
}

function LeadStageArenaTeamListMediator:initialize()
	super.initialize(self)
end

function LeadStageArenaTeamListMediator:dispose()
	super.dispose(self)
end

function LeadStageArenaTeamListMediator:onRegister()
	super.onRegister(self)

	self._masterSystem = self._developSystem:getMasterSystem()
	self._bagSystem = self._developSystem:getBagSystem()
	self._shopSystem = self._developSystem:getShopSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._leadStageArena = self._leadStageArenaSystem:getLeadStageArena()
	self._isChanged = false

	local ownTeamInfo = self._leadStageArenaSystem:getOwnTeams()

	self._ownTeamInfoTemp = {}

	table.deepcopy(ownTeamInfo, self._ownTeamInfoTemp)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._btnTeam = self:bindWidget("main.node_btns.btn_team", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onClickBtnTeam, self)
		}
	})

	self._btnTeam:setButtonName(Strings:get("StageArena_PartyUI14"), Strings:get("StageArena_EN01"))

	self._btnQuickChallange = self:bindWidget("main.node_btns.btn_quickChallage", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickBtnQuickChallange, self)
		}
	})

	self._btnQuickChallange:setButtonName(Strings:get("StageArena_PartyUI15"), Strings:get("StageArena_EN02"))

	self._btnChallange = self:bindWidget("main.node_btns.btn_challage", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickBtnChallange, self)
		}
	})

	self._btnChallange:setButtonName(Strings:get("StageArena_PartyUI16"), Strings:get("StageArena_EN03"))
end

function LeadStageArenaTeamListMediator:enterWithData(data)
	self:setupTopInfoWidget()
	self:mapEventListeners()
	self:setupView()
	self:runStartAction()
end

function LeadStageArenaTeamListMediator:resumeWithData(data)
	super.resumeWithData(self, data)

	self._isChanged = false
	self._leadStageArena = self._leadStageArenaSystem:getLeadStageArena()

	local ownTeamInfo = self._leadStageArenaSystem:getOwnTeams()

	self._ownTeamInfoTemp = {}

	table.deepcopy(ownTeamInfo, self._ownTeamInfoTemp)
	self:refreshTeamView()
end

function LeadStageArenaTeamListMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_LEADSTAGE_AEANA_SEASONINFO, self, self.refreshViewDone)
end

function LeadStageArenaTeamListMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	topInfoNode:setLocalZOrder(999)

	local infoConfig = {
		CurrencyIdKind.kStageArenaPower,
		CurrencyIdKind.kStageArenaOldCoin
	}
	local config = {
		style = 1,
		currencyInfo = infoConfig,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("StageArena_PageTitle01")
	}

	self._topInfoWidget = self:autoManageObject(self:getInjector():injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function LeadStageArenaTeamListMediator:setupView()
	self:initWidgetView()
	self:refreshTeamView()
	self:refreshRivalTeamView()
end

function LeadStageArenaTeamListMediator:refreshViewDone()
	self._leadStageArena = self._leadStageArenaSystem:getLeadStageArena()

	local ownTeamInfo = self._leadStageArenaSystem:getOwnTeams()

	self._ownTeamInfoTemp = {}

	table.deepcopy(ownTeamInfo, self._ownTeamInfoTemp)
	self:refreshTeamView()
end

function LeadStageArenaTeamListMediator:initWidgetView()
	self._bg = self._main:getChildByFullName("bg")
	self._teamNode = self._main:getChildByFullName("node_team")
	self._middleNode = self._main:getChildByFullName("node_middle")
	self._movingPet = self._main:getChildByFullName("moving_pet")
	self._movingMaster = self._main:getChildByFullName("moving_master")
	self._touchLayer = self:getView():getChildByFullName("touchLayer")

	self._touchLayer:setLocalZOrder(1000)
	self._touchLayer:setVisible(false)
	self._bg:ignoreContentAdaptWithSize(true)
	self._bg:loadTexture("asset/scene/scene_stagearena_1.jpg")

	local imgbg = self._main:getChildByFullName("Image_83_0")
	local winSize = cc.Director:getInstance():getWinSize()

	imgbg:setContentSize(cc.size(imgbg:getContentSize().width, winSize.height - 90 - 60))
end

function LeadStageArenaTeamListMediator:refreshTeamView()
	local ownTeamInfo = self._ownTeamInfoTemp
	local maxPetNum = self._leadStageArena:getPositionNum()

	self._petNodeList = {}
	self._masterNodeList = {}
	self._masterLeadStageNode = {}

	for i = 1, 3 do
		local index = i

		self._petNodeList[index] = {}

		local node = self._teamNode:getChildByFullName("roleNode" .. i)
		local teamInfo = ownTeamInfo[i]

		if teamInfo ~= nil then
			local textIndex = node:getChildByFullName("text_index")
			local roleNode = node:getChildByFullName("masterPanel")
			local nodeLeadStage = node:getChildByFullName("img_heidi.node_leadStage")
			local herosList = node:getChildByFullName("team_bg")
			local imgHide = node:getChildByFullName("img_heidi")

			textIndex:setString(Strings:get("StageArena_PartyUI0" .. 1 + i))
			roleNode:setTouchEnabled(true)
			roleNode:setTag(index)

			roleNode.id = teamInfo.masterId
			roleNode.index = index
			roleNode.teamIndex = index
			roleNode.kind = "master"

			table.insert(self._masterNodeList, roleNode)
			roleNode:addTouchEventListener(function(sender, eventType)
				self:onClickOnTeamMaster(sender, eventType, index)
			end)
			roleNode:removeAllChildren()

			local id, lv = self._masterSystem:getMasterLeadStatgeLevel(teamInfo.masterId)

			self._masterLeadStageNode[i] = {
				node = imgHide,
				vis = lv > 0
			}

			local roleModel = self._masterSystem:getMasterLeadStageModel(teamInfo.masterId, id or "")
			local sprite = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe6_1",
				id = roleModel
			})

			roleNode:addChild(sprite)
			sprite:setAnchorPoint(cc.p(0, 0))
			sprite:setPosition(cc.p(0, 0))
			sprite:setScale(0.54)
			nodeLeadStage:removeAllChildren()

			local icon = IconFactory:createLeadStageIconVer(id, lv, {
				needBg = 0
			})

			if icon then
				icon:addTo(nodeLeadStage):offset(-6, 6)
				icon:setAnchorPoint(cc.p(0.5, 0.5))
				icon:setScale(0.8)
				imgHide:setVisible(true)
			end

			local showHeros = {}

			for i, v in pairs(teamInfo.heroes) do
				showHeros[#showHeros + 1] = v
			end

			self:sortOnTeamPets(showHeros)

			local length = 10

			for i = 1, length do
				local iconPanel = herosList:getChildByFullName("pet_" .. i)

				iconPanel:removeAllChildren()
				iconPanel:setTag(i)

				iconPanel.id = nil

				if showHeros[i] then
					local emptyIcon = GameStyle:createEmptyIcon(true)

					emptyIcon:addTo(iconPanel):center(iconPanel:getContentSize())
					emptyIcon:setScale(0.6)
					emptyIcon:setName("EmptyIcon")

					local heroInfo = self:getHeroInfoById(showHeros[i])
					local petNode = IconFactory:createHeroLargeIcon(heroInfo, {
						hideStar = true,
						hideName = true,
						rarityAnim = false,
						hideLevel = true
					})

					petNode:setScale(0.4)
					petNode:addTo(iconPanel):center(iconPanel:getContentSize())
					petNode:offset(0, -9)
					petNode:setName("petNode")
					iconPanel:setTouchEnabled(true)

					iconPanel.id = showHeros[i]
					iconPanel.index = index
					iconPanel.teamIndex = index
					self._petNodeList[index][i] = iconPanel

					iconPanel:addTouchEventListener(function(sender, eventType)
						self:onClickOnTeamPet(sender, eventType, index)
					end)
				else
					local emptyIcon = GameStyle:createEmptyIcon(true)

					emptyIcon:addTo(iconPanel):center(iconPanel:getContentSize())
					emptyIcon:setScale(0.6)
					emptyIcon:setName("EmptyIcon")

					if maxPetNum < i then
						local tipLabel = emptyIcon:getChildByName("TipText")

						tipLabel:setString(Strings:get("StageArena_PartyUI09"))
						iconPanel:setTouchEnabled(false)
					else
						local img = ccui.ImageView:create("btn_jiahao.png", ccui.TextureResType.plistType)

						img:addTo(iconPanel):center(iconPanel:getContentSize())
						iconPanel:setTouchEnabled(true)
						iconPanel:addTouchEventListener(function(sender, eventType)
							self:onClickOnAddBtn(sender, eventType, index)
						end)
					end
				end
			end
		end
	end
end

function LeadStageArenaTeamListMediator:getHeroInfoById(id)
	local heroInfo = self._heroSystem:getHeroById(id)

	if not heroInfo then
		return nil
	end

	return {
		id = id,
		rarity = heroInfo:getRarity(),
		type = heroInfo:getType(),
		cost = heroInfo:getCost(),
		roleModel = heroInfo:getModel(),
		awakenLevel = heroInfo:getAwakenStar()
	}
end

function LeadStageArenaTeamListMediator:onClickOnAddBtn(sender, eventType, teamIndex)
	local tag = sender:getTag()

	if tag <= #self._petNodeList[teamIndex] then
		return
	end

	if eventType == ccui.TouchEventType.ended then
		local status = self._leadStageArenaSystem:getArenaState()

		if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason or status == LeadStageArenaState.KShow then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("StageArena_MainUI18")
			}))

			return
		end

		self:onClickBtnAdd(teamIndex, function()
			self._leadStageArenaSystem:enterTeamView(teamIndex)
		end)
	end
end

function LeadStageArenaTeamListMediator:onClickOnTeamMaster(sender, eventType, teamIndex)
	if eventType == ccui.TouchEventType.began then
		self._isOnOwn = false
	elseif eventType == ccui.TouchEventType.moved then
		local beganPos = sender:getTouchBeganPosition()
		local movedPos = sender:getTouchMovePosition()

		if not self._isDrag then
			self._isDrag = self:checkTouchType(beganPos, movedPos)

			if self._isDrag and not self._isOnOwn then
				local masterNode = self._masterNodeList[sender:getTag()]

				masterNode:setVisible(false)

				local leadStageNode = self._masterLeadStageNode[sender:getTag()].node

				leadStageNode:setVisible(false)
				self:createMovingPet(sender)
				self:changeMovingMasterPos(beganPos)
			end
		elseif self._isDrag and not self._isOnOwn then
			self:changeMovingMasterPos(movedPos)
		end
	elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
		local masterNode = self._masterNodeList[sender:getTag()]

		masterNode:setVisible(true)

		local leadStageNode = self._masterLeadStageNode[sender:getTag()].node

		leadStageNode:setVisible(true)

		if self._isDrag and self:checkMasterIsInTeamArea(teamIndex) then
			self:changeOwnMaster(sender)
		end

		self._isDrag = false

		self:cleanMovingPet()
	end
end

function LeadStageArenaTeamListMediator:onClickOnTeamPet(sender, eventType, teamIndex)
	local tag = sender:getTag()

	if tag > #self._petNodeList[teamIndex] then
		return
	end

	if eventType == ccui.TouchEventType.began then
		self._isOnOwn = false

		local ownTeamInfo = self._ownTeamInfoTemp

		if table.nums(ownTeamInfo[teamIndex].heroes) <= 1 then
			self._isOnOwn = true

			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:find("StageArena_PartyUI18")
			}))

			return
		end
	elseif eventType == ccui.TouchEventType.moved then
		local ownTeamInfo = self._ownTeamInfoTemp

		if table.nums(ownTeamInfo[teamIndex].heroes) <= 1 then
			return
		end

		local beganPos = sender:getTouchBeganPosition()
		local movedPos = sender:getTouchMovePosition()

		if not self._isDrag then
			self._isDrag = self:checkTouchType(beganPos, movedPos)

			if self._isDrag and not self._isOnOwn then
				local heroNode = self._petNodeList[teamIndex][sender:getTag()]

				if heroNode:getChildByName("petNode") then
					heroNode:getChildByName("petNode"):setVisible(false)
				end

				self:createMovingPet(sender)
				self:changeMovingPetPos(beganPos)
			end
		elseif self._isDrag and not self._isOnOwn then
			self:changeMovingPetPos(movedPos)
		end
	elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
		local heroNode = self._petNodeList[teamIndex][sender:getTag()]

		if heroNode:getChildByName("petNode") then
			heroNode:getChildByName("petNode"):setVisible(true)
		end

		if self._isDrag and self:checkIsInTeamArea(teamIndex) then
			self:changeOwnPet(sender)
		end

		self._isDrag = false

		self:cleanMovingPet()
	end
end

function LeadStageArenaTeamListMediator:checkTouchType(pos1, pos2)
	local xOffset = math.abs(pos1.x - pos2.x)
	local yOffset = math.abs(pos1.y - pos2.y)

	if xOffset > 10 or yOffset > 10 then
		local dragDeg1 = math.deg((math.atan(yOffset / xOffset)))
		local dragDeg2 = math.deg((math.atan(xOffset / yOffset)))

		if dragDeg1 > 30 or dragDeg2 > 30 then
			return true
		end
	end

	return false
end

function LeadStageArenaTeamListMediator:createMovingPet(cell)
	local petNode

	if cell.kind and cell.kind == "master" then
		local ownTeamInfo = self._ownTeamInfoTemp
		local teamInfo = ownTeamInfo[cell.index]
		local roleNode = self._movingMaster:getChildByFullName("masterPanel")
		local nodeLeadStage = self._movingMaster:getChildByFullName("node_leadStage")
		local imgHide = self._movingMaster:getChildByFullName("img_heidi")

		roleNode:removeAllChildren()

		local id, lv = self._masterSystem:getMasterLeadStatgeLevel(teamInfo.masterId)
		local roleModel = self._masterSystem:getMasterLeadStageModel(teamInfo.masterId, id or "")
		local sprite = IconFactory:createRoleIconSpriteNew({
			frameId = "bustframe6_1",
			id = roleModel
		})

		roleNode:addChild(sprite)
		sprite:setAnchorPoint(cc.p(0, 0))
		sprite:setPosition(cc.p(0, 0))
		sprite:setScale(0.54)
		nodeLeadStage:removeAllChildren()

		local icon = IconFactory:createLeadStageIconVer(id, lv, {
			needBg = 0
		})

		if icon then
			icon:addTo(nodeLeadStage):offset(0, 4)
			icon:setAnchorPoint(cc.p(0.5, 0.5))
			icon:setScale(0.8)
			imgHide:setVisible(true)
		end
	else
		local heroInfo = self:getHeroInfoById(cell.id)
		local petNode = IconFactory:createHeroLargeIcon(heroInfo, {
			hideStar = true,
			hideName = true,
			rarityAnim = false,
			hideLevel = true
		})

		petNode:setScale(0.4)
		self._movingPet:removeAllChildren()
		petNode:setAnchorPoint(cc.p(0.5, 0.5))
		petNode:addTo(self._movingPet):center(self._movingPet:getContentSize())
	end
end

function LeadStageArenaTeamListMediator:changeMovingMasterPos(pos)
	local movedPos = self._movingMaster:getParent():convertToNodeSpace(pos)

	self._movingMaster:setPosition(movedPos)
end

function LeadStageArenaTeamListMediator:checkMasterIsInTeamArea(teamIndex)
	local targetIndex

	for i = 1, 3 do
		if i ~= teamIndex then
			local node = self._teamNode:getChildByFullName("roleNode" .. i)
			local iconBg = node:getChildByName("masterPanel")

			if self:checkCollision(self._movingMaster, iconBg) then
				targetIndex = i

				break
			end
		end
	end

	return targetIndex
end

function LeadStageArenaTeamListMediator:changeOwnMaster(cell)
	local id = cell.id
	local teamIndex = cell.teamIndex
	local targetIndex, targetTeamIndex

	for i = 1, 3 do
		if i ~= teamIndex then
			local node = self._teamNode:getChildByFullName("roleNode" .. i)
			local iconBg = node:getChildByName("masterPanel")

			if self:checkCollision(self._movingMaster, iconBg) then
				targetIndex = i
				targetTeamIndex = i

				break
			end
		end
	end

	if not targetIndex or not targetTeamIndex then
		return
	end

	local targetId = self._ownTeamInfoTemp[targetTeamIndex].masterId

	if not targetId then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Pickup", false)

	self._isChanged = true

	if targetId then
		self._ownTeamInfoTemp[targetTeamIndex].masterId = id
		self._ownTeamInfoTemp[teamIndex].masterId = targetId

		self:refreshTeamView()
	end
end

function LeadStageArenaTeamListMediator:changeMovingPetPos(pos)
	local movedPos = self._movingPet:getParent():convertToNodeSpace(pos)

	self._movingPet:setPosition(movedPos)
end

function LeadStageArenaTeamListMediator:checkIsInTeamArea(teamIndex)
	local maxPetNum = self._leadStageArena:getPositionNum()
	local targetIndex

	for i = 1, 3 do
		local index = i

		if i ~= teamIndex then
			local node = self._teamNode:getChildByFullName("roleNode" .. i)

			for i = 1, maxPetNum do
				local petBg = node:getChildByFullName("team_bg")
				local iconBg = petBg:getChildByName("pet_" .. i)

				if self:checkCollision(nil, iconBg) then
					targetIndex = i
					targetTeamIndex = index

					break
				end
			end
		end
	end

	return targetIndex
end

function LeadStageArenaTeamListMediator:checkCollision(srcPanel, targetPanel)
	srcPanel = srcPanel or self._movingPet

	local checkPos = cc.p(srcPanel:getPositionX(), srcPanel:getPositionY())

	checkPos = srcPanel:getParent():convertToWorldSpace(checkPos)
	checkPos = targetPanel:getParent():convertToNodeSpace(checkPos)

	if cc.rectContainsPoint(targetPanel:getBoundingBox(), checkPos) then
		return true
	end

	return false
end

function LeadStageArenaTeamListMediator:changeOwnPet(cell)
	local maxPetNum = self._leadStageArena:getPositionNum()
	local id = cell.id
	local teamIndex = cell.teamIndex
	local targetIndex, targetTeamIndex

	for i = 1, 3 do
		local index = i

		if i ~= teamIndex then
			local node = self._teamNode:getChildByFullName("roleNode" .. i)

			for i = 1, maxPetNum do
				local petBg = node:getChildByFullName("team_bg")
				local iconBg = petBg:getChildByName("pet_" .. i)

				if self:checkCollision(nil, iconBg) then
					targetIndex = i
					targetTeamIndex = index

					break
				end
			end
		end
	end

	if not targetIndex or not targetTeamIndex then
		return
	end

	local targetTeamInfo = self._ownTeamInfoTemp[targetTeamIndex].heroes

	if not targetTeamInfo then
		return
	end

	local targetId = targetTeamInfo[targetIndex]

	AudioEngine:getInstance():playEffect("Se_Click_Pickup", false)

	self._isChanged = true

	if targetId then
		self._ownTeamInfoTemp[targetTeamIndex].heroes[targetIndex] = id

		local index = table.indexof(self._ownTeamInfoTemp[teamIndex].heroes, id)

		if index then
			self._ownTeamInfoTemp[teamIndex].heroes[index] = targetId
		end

		self:refreshTeamView()
	else
		local cellIndex = table.indexof(self._ownTeamInfoTemp[teamIndex].heroes, id)

		if cellIndex then
			table.remove(self._ownTeamInfoTemp[teamIndex].heroes, cellIndex)
		end

		local total = #self._ownTeamInfoTemp[targetTeamIndex].heroes

		self._ownTeamInfoTemp[targetTeamIndex].heroes[total + 1] = id

		self:refreshTeamView()
	end
end

function LeadStageArenaTeamListMediator:onClickChange1()
	self:changeTeam(1, 2)
end

function LeadStageArenaTeamListMediator:onClickChange2()
	self:changeTeam(2, 3)
end

function LeadStageArenaTeamListMediator:changeTeam(curTeamIndex, targetTeamIndex)
	self._isChanged = true

	local temp = {}

	table.deepcopy(self._ownTeamInfoTemp[curTeamIndex], temp)

	self._ownTeamInfoTemp[curTeamIndex].masterId = self._ownTeamInfoTemp[targetTeamIndex].masterId
	self._ownTeamInfoTemp[curTeamIndex].heroes = self._ownTeamInfoTemp[targetTeamIndex].heroes
	self._ownTeamInfoTemp[targetTeamIndex].masterId = temp.masterId
	self._ownTeamInfoTemp[targetTeamIndex].heroes = temp.heroes

	self:refreshTeamView()
end

function LeadStageArenaTeamListMediator:cleanMovingPet()
	self._movingPet:removeAllChildren()
	self._movingPet:setPositionX(-500)
	self._movingMaster:setPositionX(-500)
end

function LeadStageArenaTeamListMediator:refreshRivalTeamView()
	local rivalTeamInfo = self._leadStageArena:getRival().rivalTeams
	local maxPetNum = self._leadStageArena:getPositionNum()

	for i = 1, 3 do
		local node = self._middleNode:getChildByFullName("roleNode" .. i)
		local teamInfo = rivalTeamInfo["STAGE_ARENA_" .. i]

		if teamInfo ~= nil then
			local textIndex = node:getChildByFullName("roleNode.text_index")
			local roleNode = node:getChildByFullName("roleNode.masterPanel")
			local nodeLeadStage = node:getChildByFullName("roleNode.node_leadStage")
			local textHide = node:getChildByFullName("roleNode.text_hide")
			local herosList = node:getChildByFullName("team_bg")
			local imgHide = node:getChildByFullName("roleNode.img_heidi")

			textHide:setVisible(false)
			textIndex:setString(Strings:get("StageArena_PartyUI0" .. 1 + i))
			roleNode:removeAllChildren()

			local roleModel = self._masterSystem:getMasterLeadStageModel(teamInfo.masterId, teamInfo.leadId)
			local sprite = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe6_1",
				id = roleModel
			})

			roleNode:addChild(sprite)
			sprite:setAnchorPoint(cc.p(0, 0))
			sprite:setPosition(cc.p(0, 0))
			sprite:setScale(0.54)
			nodeLeadStage:removeAllChildren()

			local hidden = self._leadStageArenaSystem:getRivalHidden()

			if table.indexof(hidden, i) then
				textHide:setPositionX(70)
				textHide:setVisible(true)
				imgHide:setVisible(true)
			elseif teamInfo.leadId and teamInfo.leadId ~= "" then
				local icon = IconFactory:createLeadStageIconVer(teamInfo.leadId, teamInfo.leadLv, {
					needBg = 0
				})

				if icon then
					icon:addTo(nodeLeadStage):offset(-1, 6)
					icon:setAnchorPoint(cc.p(0.5, 0.5))
					icon:setScale(0.8)
					imgHide:setVisible(true)
				end
			end

			local showHeros = {}

			for i, v in pairs(teamInfo.heroes) do
				showHeros[#showHeros + 1] = v
			end

			self:sortOnTeamPets(showHeros)

			local length = 10

			for i = 1, length do
				local iconPanel = herosList:getChildByFullName("pet_" .. i)

				iconPanel:removeAllChildren()

				if showHeros[i] then
					local heroInfo = {
						id = showHeros[i]
					}
					local petNode = IconFactory:createHeroLargeIcon(heroInfo, {
						hideStar = true,
						hideName = true,
						rarityAnim = false,
						hideLevel = true
					})

					petNode:setScale(0.4)
					petNode:addTo(iconPanel):center(iconPanel:getContentSize())
					petNode:offset(0, -9)
				else
					local emptyIcon = GameStyle:createEmptyIcon(true)

					emptyIcon:addTo(iconPanel):center(iconPanel:getContentSize())
					emptyIcon:setScale(0.6)

					if maxPetNum < i then
						local tipLabel = emptyIcon:getChildByName("TipText")

						tipLabel:setString(Strings:get("StageArena_PartyUI09"))
					end
				end
			end
		end
	end
end

function LeadStageArenaTeamListMediator:getSendData()
	local sendData = {}

	for k, v in pairs(self._ownTeamInfoTemp) do
		if not next(v.heroes) then
			return nil
		end

		local heros = {}

		for k, v in ipairs(v.heroes) do
			heros[k] = {}
			heros[k].id = v
		end

		sendData[v.teamId] = {}
		sendData[v.teamId].masterId = v.masterId
		sendData[v.teamId].heros = heros
	end

	return sendData
end

function LeadStageArenaTeamListMediator:onClickBtnAdd(teamIndex, func)
	local status = self._leadStageArenaSystem:getArenaState()

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason or status == LeadStageArenaState.KShow then
		self._isChanged = false
	end

	local function callback()
		if DisposableObject:isDisposed(self) then
			return
		end

		if self._isChanged then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Team_StorageSuccessTips")
			}))

			self._isChanged = false
		end

		if func then
			func()
		end
	end

	if self._isChanged then
		local sendData = self:getSendData()

		if not sendData then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:find("StageArena_PartyUI18")
			}))

			return nil
		end

		self._leadStageArenaSystem:requestLineUp(sendData, callback, false)
	else
		callback()
	end

	return true
end

function LeadStageArenaTeamListMediator:sortOnTeamPets(hros)
	self._heroSystem:sortOnTeamPets(hros)
end

function LeadStageArenaTeamListMediator:onClickSpRule()
	self:createSpRuleTip()
end

function LeadStageArenaTeamListMediator:onClickBtnTeam()
	local status = self._leadStageArenaSystem:getArenaState()

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason or status == LeadStageArenaState.KShow then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI18")
		}))

		return
	end

	local tindex = 1

	self:onClickBtnAdd(tindex, function()
		self._leadStageArenaSystem:enterTeamView(tindex)
	end)
end

function LeadStageArenaTeamListMediator:onClickBtnQuickChallange()
	local status = self._leadStageArenaSystem:getArenaState()

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason or status == LeadStageArenaState.KShow then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI18")
		}))

		return
	end

	local function callback()
		local bossView = self:getInjector():getInstance("MasterCutInView")

		local function willCloseFunc()
			self._touchLayer:setVisible(true)

			local anim = cc.MovieClip:create("dajia_zhujuedajia")

			anim:addTo(self:getView(), 101):center(self:getView():getContentSize())

			local delay = cc.DelayTime:create(1)
			local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
				self._leadStageArena = self._leadStageArenaSystem:getLeadStageArena()

				local rivalData = self._leadStageArena:getRival()

				self._leadStageArenaSystem:requestQuickBeginBattle(rivalData.rivalId, function(rsdata)
					if not tolua.isnull(anim) then
						-- block empty
					end
				end, true)
			end))

			self:getView():runAction(sequence)
		end

		local friend = {
			leadStageId = "",
			leadStageLevel = 0,
			waves = {
				{
					master = {
						modelId = "Master_FuHun"
					}
				}
			}
		}
		local enemy = {
			leadStageId = "",
			leadStageLevel = 0,
			waves = {
				{
					master = {
						modelId = "Master_FuHun"
					}
				}
			}
		}
		local leadStageLevel_l = 0
		local rivalTeamInfo = self._leadStageArena:getRival().rivalTeams

		for i = 1, 3 do
			local teamInfo = rivalTeamInfo["STAGE_ARENA_" .. i]

			if i == 1 then
				enemy.waves[1].master.modelId = ConfigReader:getDataByNameIdAndKey("MasterBase", teamInfo.masterId, "RoleModel")
			end

			if teamInfo and teamInfo.leadId and teamInfo.leadId ~= "" and leadStageLevel_l < teamInfo.leadLv then
				leadStageLevel_l = teamInfo.leadLv
				enemy.leadStageLevel = teamInfo.leadLv
				enemy.leadStageId = teamInfo.leadId
				enemy.waves[1].master.modelId = ConfigReader:getDataByNameIdAndKey("MasterBase", teamInfo.masterId, "RoleModel")
			end
		end

		local leadStageLevel = 0
		local leadStageId = ""
		local rivalTeamInfo = self._leadStageArenaSystem:getOwnTeams()

		for i = 1, 3 do
			local teamInfo = rivalTeamInfo[i]

			if i == 1 then
				friend.waves[1].master.modelId = ConfigReader:getDataByNameIdAndKey("MasterBase", teamInfo.masterId, "RoleModel")
			end

			if teamInfo then
				local id, lv = self._masterSystem:getMasterLeadStatgeLevel(teamInfo.masterId)

				if id and id ~= "" and leadStageLevel < lv then
					leadStageLevel = lv
					leadStageId = id
					friend.leadStageLevel = lv
					friend.leadStageId = id
					friend.waves[1].master.modelId = ConfigReader:getDataByNameIdAndKey("MasterBase", teamInfo.masterId, "RoleModel")
				end
			end
		end

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, nil, {
			friend = friend,
			enemy = enemy,
			closeCallFunc = willCloseFunc
		}, popupDelegate))
	end

	self:onClickBtnAdd(1, callback)
end

function LeadStageArenaTeamListMediator:onClickBtnChallange()
	local status = self._leadStageArenaSystem:getArenaState()

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason or status == LeadStageArenaState.KShow then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI18")
		}))

		return
	end

	local function callback()
		self._leadStageArena = self._leadStageArenaSystem:getLeadStageArena()

		local rivalData = self._leadStageArena:getRival()

		self._leadStageArenaSystem:requestBeginBattle(rivalData.rivalId)
	end

	self:onClickBtnAdd(1, callback)
end

function LeadStageArenaTeamListMediator:onClickBack()
	if self:onClickBtnAdd(1) then
		if self._isChanged then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Team_StorageSuccessTips")
			}))
		end

		self._isChanged = false

		self:dismiss()
	end
end

function LeadStageArenaTeamListMediator:createSpRuleTip()
	local panel = self:getView():getChildByFullName("ruleTip")

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
		bg:setAnchorPoint(cc.p(0.5, 0))
		bg:addTo(panel):setPosition(cc.p(680, 240))
		bg:setName("ruleTip")

		local config = self._leadStageArena:getConfig()

		if config then
			if not config.SeasonRule.rule then
				local key = ""

				if config then
					if not config.SeasonRule.config then
						local value = {
							0,
							0
						}
						local contentText = ccui.RichText:createWithXML(Strings:get(key, {
							fontSize = 18,
							fontName = TTF_FONT_FZYH_R,
							num1 = value[1] * 100,
							num2 = value[2] * 100,
							num3 = value[2] * 3 * 100
						}), {})

						contentText:setAnchorPoint(cc.p(0, 1))
						contentText:renderContent(240, 0)

						local size = contentText:getContentSize()
						local height = size.height

						bg:setContentSize(cc.size(260, height + 30))
						contentText:addTo(bg):posite(15, height + 15)
					end
				end
			end
		end
	end

	panel:setVisible(true)
end

function LeadStageArenaTeamListMediator:onClickRule()
	local st = TimeUtil:localDate("%Y.%m.%d", self._leadStageArena:getStartTime())
	local et = TimeUtil:localDate("%Y.%m.%d", self._leadStageArena:getEndTime())
	local oldCoin = self._leadStageArenaSystem:getOldCoin()
	local powerMax = self._leadStageArena:getConfig().ChipMax
	local reset = ConfigReader:getRecordById("Reset", "StageArenaStamina_Reset").ResetSystem
	local ruleReplaceInfo = {
		starttime = st,
		endtime = et,
		gold = oldCoin,
		min = reset.cd / 60 .. Strings:get("Arena_UI109"),
		num = reset.limit,
		max = powerMax
	}
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StageArena_RuleTranslate", "content")
	local view = self:getInjector():getInstance("ArenaRuleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		useParam = true,
		rule = Rule.Desc,
		extraParams = ruleReplaceInfo
	}, nil)

	self:dispatch(event)
end

function LeadStageArenaTeamListMediator:runStartAction()
	local animNode = self._main:getChildByFullName("node_bgAnim")
	local anim = cc.MovieClip:create("zhanduivs02_buyeyiyouchuanzhanduivs")

	anim:addTo(animNode):posite(0, 0)
	anim:gotoAndPlay(0)
	anim:setPlaySpeed(2)

	local nodeToActionMap = {}
	local mc_top = anim:getChildByFullName("mc_top")
	local mc_zi = anim:getChildByFullName("mc_zi")
	local mc_teshu = anim:getChildByFullName("mc_teshu")
	local mc_banzi = anim:getChildByFullName("mc_banzi")
	local mc_anniu = anim:getChildByFullName("mc_anniu")
	local mc_bottom = anim:getChildByFullName("mc_bottom")
	local mc_bg = anim:getChildByFullName("mc_bg")

	mc_anniu:offset(0, -10)

	local node_top = self:getView():getChildByFullName("topinfo_node")
	local node_zi = self._main:getChildByFullName("Text_11")
	local node_teshu = self._main:getChildByFullName("Image_7")
	local node_banzi = self._main:getChildByFullName("Image_83_0")
	local node_anniu = self._main:getChildByFullName("node_btns")
	local node_bottom = self._main:getChildByFullName("bg_bottom_0")
	local node_bg = self._main:getChildByFullName("bg")

	nodeToActionMap[node_top] = mc_top
	nodeToActionMap[node_zi] = mc_zi
	nodeToActionMap[node_teshu] = mc_teshu
	nodeToActionMap[node_banzi] = mc_banzi
	nodeToActionMap[node_anniu] = mc_anniu
	nodeToActionMap[node_bottom] = mc_bottom
	nodeToActionMap[node_bg] = mc_bg

	local rivalTeamInfo = self._leadStageArena:getRival().rivalTeams

	for i = 1, 3 do
		local node = self._middleNode:getChildByFullName("roleNode" .. i)
		local teamInfo = rivalTeamInfo["STAGE_ARENA_" .. i]
		local rivalAnim = anim:getChildByFullName("mc_rteam" .. i)

		rivalAnim:gotoAndPlay(0)

		if teamInfo ~= nil then
			local herosList = node:getChildByFullName("team_bg")
			local length = 10

			for i = 1, length do
				local mc_pet = rivalAnim:getChildByFullName("mc_pet" .. i)
				local petNode = herosList:getChildByFullName("pet_" .. i)

				nodeToActionMap[petNode] = mc_pet
			end

			local mc_master = rivalAnim:getChildByFullName("mc_master")
			local maserNode = node:getChildByFullName("roleNode")

			nodeToActionMap[maserNode] = mc_master

			local mc_di = rivalAnim:getChildByFullName("mc_di")
			local diNode = node:getChildByFullName("Image_15")

			nodeToActionMap[diNode] = mc_di
		end
	end

	local ownTeamInfo = self._ownTeamInfoTemp

	for i = 1, 3 do
		local node = self._teamNode:getChildByFullName("roleNode" .. i)
		local teamInfo = ownTeamInfo[i]
		local rivalAnim = anim:getChildByFullName("mc_lteam" .. i)

		rivalAnim:gotoAndPlay(0)

		if teamInfo ~= nil then
			local herosList = node:getChildByFullName("team_bg")
			local length = 10

			for i = 1, length do
				local mc_pet = rivalAnim:getChildByFullName("mc_pet" .. i)
				local petNode = herosList:getChildByFullName("pet_" .. 10 - i + 1)

				nodeToActionMap[petNode] = mc_pet
			end

			local mc_master = rivalAnim:getChildByFullName("mc_master")

			mc_master:offset(-10, 0)

			local maserNode = node:getChildByFullName("masterPanel")
			local Panel_53 = node:getChildByFullName("Panel_53")
			local Image_137 = node:getChildByFullName("Image_137")
			local text_index = node:getChildByFullName("text_index")
			local img_heidi = node:getChildByFullName("img_heidi")
			local node_btn1 = self._teamNode:getChildByFullName("btn_change1")
			local node_btn2 = self._teamNode:getChildByFullName("btn_change2")

			Image_137:setScaleX(-1)

			nodeToActionMap[maserNode] = mc_master
			nodeToActionMap[Panel_53] = mc_master
			nodeToActionMap[Image_137] = mc_master
			nodeToActionMap[text_index] = mc_master
			nodeToActionMap[img_heidi] = mc_master
			nodeToActionMap[node_btn1] = mc_master
			nodeToActionMap[node_btn2] = mc_master

			local mc_di = rivalAnim:getChildByFullName("mc_di")
			local diNode = node:getChildByFullName("Image_12")

			nodeToActionMap[diNode] = mc_di
		end
	end

	local startFunc, stopFunc = CommonUtils.bindNodeToActionNode(nodeToActionMap, animNode)

	startFunc()
	anim:addEndCallback(function()
		anim:stop()
		stopFunc()
	end)
end
