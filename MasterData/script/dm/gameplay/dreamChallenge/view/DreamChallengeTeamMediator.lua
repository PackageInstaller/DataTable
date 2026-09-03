-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamChallenge/view/DreamChallengeTeamMediator.lua

require("dm.gameplay.stage.view.CommonTeamMediator")

DreamChallengeTeamMediator = class("DreamChallengeTeamMediator", CommonTeamMediator, _M)

DreamChallengeTeamMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
DreamChallengeTeamMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
DreamChallengeTeamMediator:has("_dreamSystem", {
	is = "r"
}):injectWith("DreamChallengeSystem")

local kBtnHandlers = {
	["main.info_bg.costBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickCost"
	},
	["main.ruleBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	}
}
local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}

function DreamChallengeTeamMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

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
	self._fightBtn = self:bindWidget("main.btnPanel.fightBtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onClickFight, self)
		}
	})
	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_TEAM_CHANGE_MASTER, self, self.changeMasterId)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TEAM_REFRESH_PETS, self, self.refreshViewBySort)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ARENA_CHANGE_TEAM_SUCC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_STAGE_CHANGENAME_SUCC, self, self.refreshTeamName)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshCombatAndCost)

	local touchPanel = self:getView():getChildByFullName("main.bg.touchPanel")

	touchPanel:addClickEventListener(function()
		self:onClickChangeMaster()
	end)

	self._masterBtn = touchPanel
	self._skillDescPanel = self:getView():getChildByFullName("skillDescPanel")

	self._skillDescPanel:setSwallowTouches(false)
	self._skillDescPanel:addClickEventListener(function()
		if self._skillDescPanel:isVisible() then
			self._skillDescPanel:setVisible(false)
		end
	end)

	self._masterSkillPanel = self:getView():getChildByFullName("main.bg.masterSkillPanel")

	self._masterSkillPanel:setVisible(true)
	self:getView():getChildByFullName("main.bg.masterSkillBg"):setVisible(true)
	self._masterSkillPanel:addClickEventListener(function()
		self:onClickMasterSkill()
	end)
end

function DreamChallengeTeamMediator:enterWithData(data)
	self:initData(data)
	self:setupTopInfoWidget()
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
		self:setupClickEnvs()
	end, delayTime)
	self._costBtn:setVisible(self:showCostBtn())
end

function DreamChallengeTeamMediator:resumeWithData()
	super.resumeWithData(self)
	self._costBtn:setVisible(self:showCostBtn())

	self._maxTeamPetNum = math.min(self._stageSystem:getPlayerInit() + self._developSystem:getBuildingCardEffValue(), self._dreamSystem:getTeamPetNumLimit(self._battleId))
	self._costMaxNum = self._stageSystem:getCostInit() + self._developSystem:getBuildingCostEffValue()

	self._costTotalLabel2:setString("/" .. self._costMaxNum)
	self:initLockIconsByDreamChallenge()
end

function DreamChallengeTeamMediator:initData(data)
	self._data = data or {}
	self._mapId = data.mapId
	self._pointId = data.pointId
	self._battleId = data.battleId

	if data and data.stageType then
		self._stageType = data.stageType or ""
	end

	self._forbidMasters = {}
	self._masterList = {}

	local masterAvail = self._dreamSystem:getMasterList(self._mapId, self._pointId)
	local allMasterData = self._masterSystem:getShowMasterList()
	local tmpMaster = {}

	for i = 1, #allMasterData do
		local master = allMasterData[i]

		table.insert(self._forbidMasters, master:getId())

		if not master:getIsLock() then
			for i = 1, #masterAvail do
				if masterAvail[i] == master:getId() then
					table.remove(self._forbidMasters, #self._forbidMasters)
				end
			end

			table.insert(self._masterList, master)
		end
	end

	table.sort(self._masterList, function(a, b)
		local astate = kMasterState.Forbidden
		local bstate = kMasterState.Forbidden

		for i = 1, #masterAvail do
			if masterAvail[i] == a:getId() then
				astate = kMasterState.Normal
			end

			if masterAvail[i] == b:getId() then
				bstate = kMasterState.Normal
			end
		end

		return bstate < astate
	end)

	self._recomandMasterList = self._dreamSystem:getRecomandMaster(self._mapId, self._pointId)

	assert(#self._masterList > 0, "上阵的主角不能为空！！！！")

	tmpMaster = nil
	self._showChangeMaster = #self._masterList > 1
	self._isDrag = false
	self._costTotal = 0
	self._costMaxNum = self._stageSystem:getCostInit() + self._developSystem:getBuildingCostEffValue()
	self._npc = self._dreamSystem:getNpc(self._mapId, self._pointId, self._battleId)
	self._npcForbid = self._dreamSystem:getNpcForbidId(self._mapId, self._pointId, self._battleId)
	self._maxTeamPetNum = math.min(self._stageSystem:getPlayerInit() + self._developSystem:getBuildingCardEffValue(), self._dreamSystem:getTeamPetNumLimit(self._battleId))
	self._teamUnlockConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Stage_Team_Unlock", "content")

	self._stageSystem:setSortExtand(0)

	self._ignoreReloadData = true
	self._curTeam = self._data.team
	self._curMasterId = self._curTeam:getMasterId()

	local checkAvail = false

	for i = 1, #masterAvail do
		if self._curMasterId == masterAvail[i] then
			checkAvail = true
		end
	end

	if not checkAvail then
		self._curMasterId = masterAvail[1]
	end

	self._oldMasterId = self._curMasterId

	local teamPetIndex = 1

	self._teamPets = {}
	self._tempTeams = {}
	self._teamList = self._developSystem:getAllUnlockTeams()

	local teamTmpHeros = self:removeExceptHeros(self._curTeam:getHeroes())
	local teamHeros = self:removeOverNumHeros(self:removeLockedHeros(teamTmpHeros))

	for _, v in pairs(teamHeros) do
		self._teamPets[teamPetIndex] = v
		self._tempTeams[teamPetIndex] = v
		teamPetIndex = teamPetIndex + 1
	end

	self._petList = self:removeLockedHeros(self._stageSystem:getNotOnTeamPet(self._teamPets))
	self._petListAll = {}

	table.copy(self._petList, self._petListAll)
end

function DreamChallengeTeamMediator:updateData()
	self._petList = self:removeLockedHeros(self._stageSystem:getNotOnTeamPet(self._teamPets))
	self._petListAll = {}

	table.copy(self._petList, self._petListAll)
end

function DreamChallengeTeamMediator:removeExceptHeros(heros)
	local showHeros = {}

	local function isNpc(heroId)
		for i = 1, #self._npcForbid do
			if self._npcForbid[i] == heroId then
				return true
			end
		end

		return false
	end

	for k, v in pairs(heros) do
		if not self._dreamSystem:checkHeroTired(self._mapId, self._pointId, v) and not isNpc(v) then
			showHeros[k + 1] = v
		end
	end

	return showHeros
end

function DreamChallengeTeamMediator:removeLockedHeros(heros)
	local showHeros = {}
	local index = 1

	for k, v in pairs(heros) do
		local isNpc = false

		if not self._dreamSystem:checkHeroLocked(self._mapId, self._pointId, v) and not isNpc then
			showHeros[index] = v
			index = index + 1
		end
	end

	return showHeros
end

function DreamChallengeTeamMediator:removeOverNumHeros(heros)
	local limitNum = math.min(self._maxTeamPetNum, self._dreamSystem:getTeamPetNumLimit(self._battleId)) - #self._npc
	local showHeros = {}

	for i = 1, limitNum do
		if heros[i] then
			showHeros[i] = heros[i]
		end
	end

	return showHeros
end

function DreamChallengeTeamMediator:showOneKeyHeros()
	local orderPets = self._heroSystem:getTeamPrepared(self._teamPets, self._petList)

	self._orderPets = {}
	self._leavePets = {}

	local function isNpc(heroId, npcForbids)
		for j = 1, #npcForbids do
			if npcForbids[j] == heroId then
				return true
			end
		end

		return false
	end

	local canRecommendNum = 0

	for i = 1, #orderPets do
		if self._dreamSystem:checkHeroRecomand(self._mapId, self._pointId, orderPets[i]) and self._dreamSystem:checkHeroTired(self._mapId, self._pointId, orderPets[i]) == false and isNpc(orderPets[i], self._npcForbid) == false then
			canRecommendNum = canRecommendNum + 1
		end
	end

	local tbRecommandIds = {}
	local notRecommendNum = self._maxTeamPetNum - canRecommendNum

	notRecommendNum = notRecommendNum > 0 and notRecommendNum or 0

	for i = 1, #orderPets do
		if self._dreamSystem:checkHeroRecomand(self._mapId, self._pointId, orderPets[i]) then
			local isTired = self._dreamSystem:checkHeroTired(self._mapId, self._pointId, orderPets[i])

			if #self._orderPets < self._maxTeamPetNum - #self._npc and isTired == false and isNpc(orderPets[i], self._npcForbid) == false then
				self._orderPets[#self._orderPets + 1] = orderPets[i]

				table.insert(tbRecommandIds, orderPets[i])
			else
				self._leavePets[#self._leavePets + 1] = orderPets[i]
			end
		else
			local isTired = self._dreamSystem:checkHeroTired(self._mapId, self._pointId, orderPets[i])

			if #self._orderPets < self._maxTeamPetNum - #self._npc and notRecommendNum > 0 and isTired == false and isNpc(orderPets[i], self._npcForbid) == false then
				self._orderPets[#self._orderPets + 1] = orderPets[i]
				notRecommendNum = notRecommendNum - 1
			else
				self._leavePets[#self._leavePets + 1] = orderPets[i]
			end
		end
	end

	local sortType = self._stageSystem:getCardSortType()

	self._heroSystem:sortHeroes(self._orderPets, sortType, tbRecommandIds, false, nil)
end

function DreamChallengeTeamMediator:setupView()
	self:initLockIcons()
	self:initLockIconsByDreamChallenge()
	self:refreshPetNode()
	self:refreshMasterInfo()
	self:initView()
	self:refreshListView()
	self:createSortView()
end

function DreamChallengeTeamMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._qipao = self:getView():getChildByFullName("qipao")

	self._qipao:setVisible(false)
	self._qipao:setLocalZOrder(100)

	self._touchPanel = self:getView():getChildByFullName("touchPanel")

	self._touchPanel:setVisible(false)

	self._bg = self:getView():getChildByFullName("main.bg")
	self._myPetPanel = self._main:getChildByFullName("my_pet_bg")
	self._heroPanel = self._myPetPanel:getChildByFullName("heroPanel")
	self._sortType = self._myPetPanel:getChildByFullName("sortPanel.sortBtn.text")
	self._sortOrder = self._myPetPanel:getChildByFullName("sortPanel.sortTypeBtn.text")
	self._masterImage = self._bg:getChildByName("role")
	self._teamBg = self._bg:getChildByName("team_bg")
	self._labelCombat = self._main:getChildByFullName("info_bg.combatLabel")
	self._costAverageLabel = self._main:getChildByFullName("info_bg.averageLabel")
	self._costTotalLabel1 = self._main:getChildByFullName("info_bg.cost1")
	self._costTotalLabel2 = self._main:getChildByFullName("info_bg.cost2")
	self._movingPet = self._main:getChildByFullName("moving_pet")
	self._combatInfoBtn = self._main:getChildByFullName("info_bg.infoBtn")
	self._spPanel = self._main:getChildByName("ruleBtn")
	self._spBuffInfo = self._main:getChildByName("spBuffInfo")

	local buffInfo = self._spBuffInfo:getChildByName("buffInfo")
	local num = self._dreamSystem:getPointFatigue(self._mapId, self._pointId)
	local buffStr = self._dreamSystem:getTeamBuffStr(self._battleId)

	if buffStr and buffStr ~= "" then
		buffInfo:setString(Strings:get(buffStr, {
			num = num
		}))
	else
		buffInfo:setString(Strings:get("DreamChallenge_Team_Info", {
			num = num
		}))
	end

	self._teamPosPanel = self._main:getChildByFullName("teamPosPanel")
	self._teamPosInfoTip = self._main:getChildByFullName("teamPosInfo")
	self._fightInfoTip = self._main:getChildByFullName("fightInfo")

	local teamPosData = ConfigReader:getDataByNameIdAndKey("DreamChallengeBattle", self._battleId, "PositionLimit")

	self._teamPosPanel:setVisible(false)

	if teamPosData and #teamPosData > 0 then
		self._teamPosPanel:setVisible(true)

		for i = 1, 9 do
			local on = self._teamPosPanel:getChildByFullName("on_" .. i)
			local off = self._teamPosPanel:getChildByFullName("off_" .. i)

			on:setVisible(true)
			off:setVisible(false)

			for index, value in ipairs(teamPosData) do
				if value == i then
					on:setVisible(false)
					off:setVisible(true)
				end
			end
		end
	end

	self._teamPosPanel:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			for i = 1, 9 do
				local on = self._teamPosInfoTip:getChildByFullName("teamPos.on_" .. i)
				local off = self._teamPosInfoTip:getChildByFullName("teamPos.off_" .. i)

				on:setVisible(true)
				off:setVisible(false)

				for index, value in ipairs(teamPosData) do
					if value == i then
						on:setVisible(false)
						off:setVisible(true)
					end
				end
			end

			self._teamPosInfoTip:setVisible(true)
		elseif eventType == ccui.TouchEventType.moved then
			-- block empty
		elseif eventType == ccui.TouchEventType.canceled then
			self._teamPosInfoTip:setVisible(false)
		elseif eventType == ccui.TouchEventType.ended then
			self._teamPosInfoTip:setVisible(false)
		end
	end)

	self._teamBreakBtn = self._main:getChildByFullName("info_bg.button_one_key_break")
	self._teamOneKeyBtn = self._main:getChildByFullName("info_bg.button_one_key_embattle")
	self._costBtn = self._main:getChildByFullName("info_bg.costBtn")
	self._costTouch = self._main:getChildByFullName("info_bg.costTouch")

	self._costTouch:addClickEventListener(function()
		self:createCostTip()
	end)

	self._myPetClone = self:getView():getChildByName("myPetClone")

	self._myPetClone:setVisible(false)

	self._petSize = self._myPetClone:getChildByFullName("myPetClone"):getContentSize()
	self._teamPetClone = self:getView():getChildByName("teamPetClone")

	self._teamPetClone:setVisible(false)
	self._teamPetClone:setScale(0.64)

	local nameDi = self._main:getChildByName("nameBg")

	self._editBox = nameDi:getChildByFullName("TextField")

	self._editBox:setVisible(false)

	self._teamName = nameDi:getChildByFullName("teamName")

	self._teamName:setString(self._data.team:getName())
	self:setLabelEffect()
	self:ignoreSafeArea()
end

function DreamChallengeTeamMediator:ignoreSafeArea()
	AdjustUtils.ignorSafeAreaRectForNode(self._heroPanel, AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._myPetPanel:getChildByName("sortPanel"), AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._main:getChildByFullName("btnPanel"), AdjustUtils.kAdjustType.Right)

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._heroPanel:setContentSize(cc.size(winSize.width - 177, 220))
end

function DreamChallengeTeamMediator:createTeamCell(cell, index)
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

function DreamChallengeTeamMediator:setLabelEffect()
	local lineGradiantVec2 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(129, 118, 113, 255)
		}
	}

	self._labelCombat:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
end

function DreamChallengeTeamMediator:onClickCell(sender, eventType, index)
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

		if not self._isOnTeam then
			if not self._isDrag then
				local selectCanceled = self:isSelectCanceledByClick(sender.id)

				if self._isReturn and not selectCanceled then
					self:insertTeamPet(sender)
				end
			elseif self:checkIsInTeamArea() then
				self:changeOwnPet(sender)
			end
		end

		self._isDrag = false

		self:cleanMovingPet()
	end
end

function DreamChallengeTeamMediator:changeOwnPet(cell)
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

	local iconBg = self._teamBg:getChildByName("pet_" .. targetIndex)
	local targetId = iconBg.id
	local selectCanceled = self:isSelectCanceledByDray(id, iconBg.id)

	if selectCanceled then
		return
	end

	self:playInsertEffect(id)
	AudioEngine:getInstance():playEffect("Se_Click_Pickup", false)

	if targetId then
		if targetIndex <= #self._npc then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("DreamChallenge_Team_Helper_Info")
			}))

			return
		end

		self._teamPets[targetIndex - #self._npc] = id

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
end

function DreamChallengeTeamMediator:insertTeamPet(cell, isDrag)
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

function DreamChallengeTeamMediator:createMovingPet(cell, type)
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

function DreamChallengeTeamMediator:sortOnTeamPets()
	self._heroSystem:sortOnTeamPets(self._teamPets)
end

function DreamChallengeTeamMediator:onClickOnTeamPet(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		local tag = sender:getTag()

		if #self._npc > 0 and tag <= #self._npc then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("DreamChallenge_Team_Helper_Info")
			}))

			return
		end

		self._isOnOwn = false
	elseif eventType == ccui.TouchEventType.moved then
		local tag = sender:getTag()
		local npcNum = #self._npc

		if npcNum > 0 and tag <= npcNum then
			return
		end

		local beganPos = sender:getTouchBeganPosition()
		local movedPos = sender:getTouchMovePosition()

		if not self._isDrag then
			self._isDrag = self:checkTouchType(beganPos, movedPos)

			if self._isDrag and not self._isOnOwn then
				self:createMovingPet(sender, 1)
				self:changeMovingPetPos(beganPos)

				if self._petNodeList[tag] then
					self._petNodeList[tag]:setVisible(false)
				end
			end
		elseif self._isDrag and not self._isOnOwn then
			self:changeMovingPetPos(movedPos)
		end
	elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
		local tag = sender:getTag()
		local npcNum = #self._npc

		if npcNum > 0 and tag <= npcNum then
			return
		end

		if self._petNodeList[tag] then
			self._petNodeList[tag]:setVisible(true)
		end

		if not self._isOnOwn then
			if self._isDrag then
				local endPos = sender:getTouchEndPosition()

				if not self:checkIsInTeamArea(endPos) then
					self:removeTeamPet(tag - npcNum)
				else
					self:changeTeamPet(tag - npcNum, endPos)
				end
			else
				self:removeTeamPet(tag - npcNum)
			end
		end

		self._isDrag = false

		self:cleanMovingPet()
	end
end

function DreamChallengeTeamMediator:changeTeamPet(index, endPos)
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
end

function DreamChallengeTeamMediator:removeTeamPet(index)
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

function DreamChallengeTeamMediator:refreshViewBySort()
	self:updateData()
	self:refreshMasterInfo()
	self:refreshListView()
	self:refreshPetNode()
end

function DreamChallengeTeamMediator:refreshView()
	self:initData()
	self:refreshMasterInfo()
	self:refreshListView()
	self:refreshPetNode()
	self._costBtn:setVisible(self:showCostBtn())
end

function DreamChallengeTeamMediator:refreshListView(ignoreAdjustOffset)
	self._petListAll = self._stageSystem:getSortExtendIds(self._petList)

	local sortType = self._stageSystem:getCardSortType()
	local tbRecommandIds = {}
	local tbTiredIds = {}

	for i = 1, #self._petListAll do
		if self._dreamSystem:checkHeroRecomand(self._mapId, self._pointId, self._petListAll[i]) then
			table.insert(tbRecommandIds, self._petListAll[i])
		end

		if self._dreamSystem:checkHeroTired(self._mapId, self._pointId, self._petListAll[i]) then
			table.insert(tbTiredIds, self._petListAll[i])
		end

		if #self._npcForbid > 0 then
			for j = 1, #self._npcForbid do
				if self._npcForbid[j] == self._petListAll[i] then
					table.insert(tbTiredIds, self._petListAll[i])
				end
			end
		end
	end

	self._heroSystem:sortHeroes(self._petListAll, sortType, tbRecommandIds, false, tbTiredIds)

	if not self._ignoreReloadData then
		local offsetX = self._teamView:getContentOffset().x + self._petSize.width

		if offsetX > 0 then
			offsetX = 0
		end

		self._teamView:reloadData()

		if not ignoreAdjustOffset then
			self._teamView:setContentOffset(cc.p(offsetX, 0))
		end
	end

	self._ignoreReloadData = false
end

function DreamChallengeTeamMediator:initHero(node, info)
	local heroId = info.id

	super.initHero(self, node, info)

	local isShow = self._dreamSystem:checkHeroRecomand(self._mapId, self._pointId, heroId)
	local isAwaken = self._dreamSystem:checkHeroAwaken(heroId)
	local isFullStar = self._dreamSystem:checkHeroFullStar(heroId)
	local except = node:getChildByName("except")

	except:setVisible(isShow or isAwaken or isFullStar)

	if isShow or isAwaken or isFullStar then
		local text = except:getChildByName("text")

		if isShow then
			text:setString(Strings:get("clubBoss_46"))
			text:setColor(cc.c3b(255, 203, 63))
		else
			text:setString(Strings:get("LOGIN_UI13"))
			text:setColor(cc.c3b(255, 255, 255))
		end
	end

	if node:getChildByName("fatigueBg") then
		local isTired = self._dreamSystem:checkHeroTired(self._mapId, self._pointId, heroId)

		if isTired then
			local fatigueTxt = node:getChildByName("fatigueBg"):getChildByName("fatigueTxt")

			if fatigueTxt then
				fatigueTxt:setString(Strings:get("clubBoss_49"))
			end

			node:addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("DreamTower_TiredTip")
					}))
				end
			end)
		end

		local isNpc = false

		for i = 1, #self._npcForbid do
			if self._npcForbid[i] == heroId then
				isNpc = true
			end
		end

		if isNpc then
			local fatigueTxt = node:getChildByName("fatigueBg"):getChildByName("fatigueTxt")

			if fatigueTxt then
				fatigueTxt:setString(Strings:get("DreamChallenge_Point_Team_Npc_Name"))
			end

			node:addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("DreamChallenge_Point_Team_Npc_Forbid")
					}))
				end
			end)
		end

		node:getChildByName("fatigueBg"):setCascadeColorEnabled(false)
		node:getChildByName("fatigueBg"):setVisible(isTired or isNpc)
		node:setColor((isTired or isNpc) and cc.c3b(150, 150, 150) or cc.c3b(250, 250, 250))
	end

	local tiredLabel = node:getChildByName("tiredNum")

	tiredLabel:setString(tostring(self._dreamSystem:getPointFatigueByHeroId(self._mapId, self._pointId, heroId)) .. "/" .. tostring(self._dreamSystem:getPointFatigue(self._mapId, self._pointId)))

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

function DreamChallengeTeamMediator:refreshPetNode()
	self:refreshCombatAndCost()
	self:refreshButtons()
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

		local id, heroInfo

		if i <= #self._npc then
			id = self._npc[i]
			heroInfo = self._dreamSystem:getNpcInfo(self._npc[i])
		else
			id = self._teamPets[i - #self._npc]
			heroInfo = self:getHeroInfoById(self._teamPets[i - #self._npc])
		end

		if id then
			self._petNodeList[i] = self._teamPetClone:clone()

			self._petNodeList[i]:setVisible(true)

			self._petNodeList[i].id = id

			self:initTeamHero(self._petNodeList[i], heroInfo)
			self._petNodeList[i]:addTo(iconBg):center(iconBg:getContentSize())
			self._petNodeList[i]:offset(0, -9)
			iconBg:setTouchEnabled(true)

			iconBg.id = id

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

function DreamChallengeTeamMediator:initTeamHero(node, info)
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
	local rarityAnim = IconFactory:getHeroRarityAnim(info.rareity)

	rarityAnim:addTo(rarity):posite(25, 15)

	if not info.isNpc then
		local isShow = self._dreamSystem:checkHeroRecomand(self._mapId, self._pointId, heroId)
		local isAwaken = self._dreamSystem:checkHeroAwaken(heroId)
		local isFullStar = self._dreamSystem:checkHeroFullStar(heroId)
		local textNumEffect = node:getChildByName("textNumEffect")
		local except_0 = node:getChildByName("except_0")
		local help = node:getChildByName("help")

		help:setVisible(false)

		local tiredNum = node:getChildByName("tiredNum")

		tiredNum:setVisible(true)
		tiredNum:setString(tostring(self._dreamSystem:getPointFatigueByHeroId(self._mapId, self._pointId, heroId)) .. "/" .. tostring(self._dreamSystem:getPointFatigue(self._mapId, self._pointId)))
		textNumEffect:setVisible(isShow or isAwaken or isFullStar)
		except_0:setVisible(isShow or isAwaken or isFullStar)

		if textNumEffect then
			if isShow then
				textNumEffect:setString(Strings:get("clubBoss_46"))
				textNumEffect:setColor(cc.c3b(255, 203, 63))
			else
				textNumEffect:setString(Strings:get("LOGIN_UI13"))
				textNumEffect:setColor(cc.c3b(255, 255, 255))
			end
		end

		local cost = node:getChildByFullName("costBg.cost")

		cost:setString(info.cost)

		local occupationName, occupationImg = GameStyle:getHeroOccupation(info.type)
		local occupation = node:getChildByName("occupation")

		occupation:loadTexture(occupationImg)

		local levelImage = node:getChildByFullName("levelImage")
		local levelLabel = node:getChildByFullName("level")

		levelLabel:setString(Strings:get("Strenghten_Text78", {
			level = info.level
		}))

		local levelImageWidth = levelImage:getContentSize().width
		local levelWidth = levelLabel:getContentSize().width

		levelImage:setScaleX((levelWidth + 40) / levelImageWidth)

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

				image:addTo(skillPanel):center(skillPanel:getContentSize())
				image:setName("KeyMark")
				image:setScale(0.85)
				image:offset(0, -5)
			end

			local isActive = self._stageSystem:checkIsKeySkillActive(condition, self._teamPets, {
				masterId = self._curMasterId
			})

			skillPanel:setGray(not isActive)
		end
	else
		local textNumEffect = node:getChildByName("textNumEffect")
		local except_0 = node:getChildByName("except_0")
		local help = node:getChildByName("help")

		help:loadTexture("asset/common/kazu_bg_yuan.png")
		help:setVisible(true)
		textNumEffect:setVisible(false)
		except_0:setVisible(false)

		local tiredNum = node:getChildByName("tiredNum")

		tiredNum:setVisible(false)

		local occupationName, occupationImg = GameStyle:getHeroOccupation(info.type)
		local occupation = node:getChildByName("occupation")

		occupation:loadTexture(occupationImg)

		local cost = node:getChildByFullName("costBg.cost")

		cost:setString(info.cost)
	end
end

function DreamChallengeTeamMediator:refreshCombatAndCost()
	local leadConfig = self._masterSystem:getMasterCurLeadStageConfig(self._curMasterId)

	if leadConfig then
		if not leadConfig.LeadFightHero then
			local addPercent = 0
			local totalCombat = 0
			local totalCost = 0
			local averageCost = 0

			for k, v in pairs(self._teamPets) do
				local heroInfo = self._heroSystem:getHeroById(v)

				totalCost = totalCost + heroInfo:getCost()
				totalCombat = totalCombat + heroInfo:getSceneCombatByType(SceneCombatsType.kAll)
			end

			totalCombat = leadConfig and math.ceil((addPercent + 1) * totalCombat) or totalCombat

			local masterData = self._masterSystem:getMasterById(self._curMasterId)

			totalCombat = masterData and totalCombat + masterData:getCombat() or totalCombat
			self._costTotal = totalCost
			averageCost = #self._teamPets == 0 and 0 or math.floor(totalCost * 10 / #self._teamPets + 0.5) / 10

			self._labelCombat:setString(totalCombat)
			self._costAverageLabel:setString(averageCost)
			self._costTotalLabel1:setString(self._costTotal)
			self._costTotalLabel2:setString("/" .. self._costMaxNum)

			local color = self._costTotal <= self._costMaxNum and cc.c3b(255, 255, 255) or cc.c3b(255, 65, 51)

			self._costTotalLabel1:setTextColor(color)
			self._costTotalLabel2:setPositionX(self._costTotalLabel1:getPositionX() + self._costTotalLabel1:getContentSize().width)

			local fightId = ConfigReader:getDataByNameIdAndKey("DreamChallengeBattle", self._battleId, "ConfigLevelLimitID")

			self._combatInfoBtn:setVisible(false)

			if fightId and fightId ~= "" then
				self._combatInfoBtn:setVisible(true)
				self._labelCombat:setString(Strings:get("SpPower_ShowName"))
				self._combatInfoBtn:loadTextureNormal("asset/common/common_btn_xq.png")
				self._combatInfoBtn:loadTexturePressed("asset/common/common_btn_xq.png")
			end

			if self._combatInfoBtn:isVisible() then
				self._combatInfoBtn:addTouchEventListener(function(sender, eventType)
					if eventType == ccui.TouchEventType.began then
						self._fightInfoTip:removeAllChildren()

						local level = DataReader:getDataByNameIdAndKey("ConfigLevelLimit", fightId, "StandardLv")
						local desc = Strings:get("SpPower_ShowDescTitle", {
							fontSize = 20,
							fontName = TTF_FONT_FZYH_M,
							level = level
						})
						local richText = ccui.RichText:createWithXML(desc, {})

						richText:setAnchorPoint(cc.p(0, 0))
						richText:setPosition(cc.p(10, 10))
						richText:addTo(self._fightInfoTip)
						richText:renderContent(440, 0, true)

						local size = richText:getContentSize()

						self._fightInfoTip:setContentSize(460, size.height + 20)
						self._fightInfoTip:setVisible(true)
					elseif eventType == ccui.TouchEventType.moved then
						-- block empty
					elseif eventType == ccui.TouchEventType.canceled then
						self._fightInfoTip:setVisible(false)
					elseif eventType == ccui.TouchEventType.ended then
						self._fightInfoTip:setVisible(false)
					end
				end)
			else
				self._combatInfoBtn:setVisible(leadConfig ~= nil and addPercent > 0)
				self._combatInfoBtn:addTouchEventListener(function(sender, eventType)
					self:onClickInfo(eventType)
				end)
			end
		end
	end
end

function DreamChallengeTeamMediator:changeMasterId(event)
	self._oldMasterId = self._curMasterId
	self._curMasterId = event:getData().masterId

	self:refreshMasterInfo()
	self:checkMasterSkillActive()
	self:refreshPetNode()
end

function DreamChallengeTeamMediator:refreshMasterInfo()
	local masterData = self._masterSystem:getMasterById(self._curMasterId)

	self._masterBtn:setVisible(self._showChangeMaster)
	self._masterImage:setVisible(true)
	self._masterImage:removeAllChildren()
	self._masterImage:addChild(masterData:getHalfImage())
	self:refreshCombatAndCost()
	self:refreshButtons()
end

function DreamChallengeTeamMediator:refreshButtons()
	self._teamBreakBtn:setVisible(self:checkButtonVisible())
	self._teamOneKeyBtn:setVisible(not self:checkButtonVisible())
end

function DreamChallengeTeamMediator:checkButtonVisible()
	if #self._teamPets + #self._npc < self._maxTeamPetNum then
		return false
	end

	return true
end

function DreamChallengeTeamMediator:hasChangeTeam()
	if self._oldMasterId ~= self._curMasterId then
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

function DreamChallengeTeamMediator:sendSpChangeTeam(callBack, ignoreTip)
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
	local hasChange = self:hasChangeTeam()

	self._stageSystem:requestSPChangeTeam(params, function()
		if DisposableObject:isDisposed(self) then
			return
		end

		if not ignoreTip and hasChange then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Team_StorageSuccessTips")
			}))
		end

		if callBack then
			callBack()
		end
	end, false, {
		ignoreTip = true
	})
end

function DreamChallengeTeamMediator:onClickRule()
	local view = self:getInjector():getInstance("DreamChallengeBuffDetailView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		mapId = self._mapId,
		pointId = self._pointId
	}))
end

function DreamChallengeTeamMediator:onClickOneKeyBreak()
	self._teamView:stopScroll()

	local ids = self._heroSystem:getTeamPrepared(self._teamPets, self._petList)

	self._teamPets = {}
	self._petList = {}

	table.copy(ids, self._petList)
	self:refreshListView(true)
	self:refreshPetNode()
end

function DreamChallengeTeamMediator:onClickBack()
	self:dismiss()
end

function DreamChallengeTeamMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local oneKeyBtn = self:getView():getChildByFullName("main.info_bg.button_one_key_embattle")

	if oneKeyBtn then
		storyDirector:setClickEnv("DreamChallengeTeamMediator.OneKeyBtn", oneKeyBtn, function(sender, eventType)
			AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
			self:onClickOneKeyEmbattle()
		end)
	end

	local btnBack = self:getView():getChildByFullName("topinfo_node.back_btn")

	storyDirector:setClickEnv("DreamChallengeTeamMediator.btnBack", btnBack, function(sender, eventType)
		AudioEngine:getInstance():playEffect("Se_Click_Close_1", false)
		self:onClickBack()
	end)

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		storyDirector:notifyWaiting("enter_DreamChallengeTeamMediator")
	end))

	oneKeyBtn:runAction(sequence)
end

function DreamChallengeTeamMediator:onClickFight(sender, eventType)
	local isUnLock, tip = self._dreamSystem:checkMapLock(self._mapId)

	if not isUnLock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("ActivityBlock_UI_8")
		}))
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return
	end

	if #self._teamPets < 1 then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("ARENA_TEMA_EMPTY")
		}))

		return false
	end

	local heros = {}

	for k, v in pairs(self._teamPets) do
		heros[k] = {}
		heros[k].id = v
	end

	self._dreamSystem:requestEnterBattle(heros, self._curMasterId, self._mapId, self._pointId, self._battleId, function(response)
		if response.resCode == GS_SUCCESS then
			local guideData = ConfigReader:getDataByNameIdAndKey("DreamChallengeBattle", self._battleId, "StoryLink")

			if guideData and guideData.enter and #guideData.enter > 0 then
				local function checkGuide(guideName)
					local storyDirector = self:getInjector():getInstance(story.StoryDirector)
					local guideAgent = storyDirector:getStoryAgent()

					guideAgent:setSkipCheckSave(false)
					guideAgent:trigger(guideName, nil, function()
						self._dreamSystem:enterBattle(response.data)
					end)
				end

				checkGuide(guideData.enter)
			else
				self._dreamSystem:enterBattle(response.data)
			end
		end
	end)
end

function DreamChallengeTeamMediator:isSelectCanceledByClick(id)
	local num = #self._teamPets + #self._npc

	if num >= self._maxTeamPetNum then
		if not self._runInsertPetAction and self._isReturn then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Stage_Team_UI7")
			}))
		end

		return true
	end

	return false
end

function DreamChallengeTeamMediator:onClickOneKeyEmbattle()
	self._teamView:stopScroll()
	self:showOneKeyHeros()

	self._teamPets = {}
	self._petList = {}

	table.deepcopy(self._orderPets, self._teamPets)
	table.deepcopy(self._leavePets, self._petList)
	self:refreshListView(true)
	self:refreshPetNode()

	for i = 1 + #self._npc, self._maxTeamPetNum do
		if self._petNodeList[i] then
			local iconBg = self._teamBg:getChildByName("pet_" .. i)

			if iconBg:getChildByName("EmptyIcon") then
				iconBg:getChildByName("EmptyIcon"):setVisible(false)
			end
		end
	end
end

function DreamChallengeTeamMediator:initLockIconsByDreamChallenge()
	local maxShowNum = 10
	local dreamLockNum = self._dreamSystem:getTeamPetNumLimit(self._battleId)

	for i = dreamLockNum + 1, maxShowNum do
		local condition, buildId
		local type, showAnim, unlockLevel, conditions = "", false, 0, {}
		local iconBg = self._teamBg:getChildByName("pet_" .. i)

		iconBg:removeAllChildren()

		local emptyIcon = GameStyle:createEmptyIcon(true)

		emptyIcon:addTo(iconBg):center(iconBg:getContentSize())

		local tipLabel = emptyIcon:getChildByName("TipText")

		tipLabel:setString(Strings:get("DreamChallenge_Battle_Unlock"))

		local width, height = iconBg:getContentSize().width, iconBg:getContentSize().height
		local widget = ccui.Widget:create()

		widget:setContentSize(cc.size(width, height))
		widget:setTouchEnabled(false)
		widget:addClickEventListener(function()
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("DreamChallenge_Battle_Unlock")
			}))
		end)
		widget:addTo(iconBg):center(iconBg:getContentSize())

		local lockImg = ccui.ImageView:create("suo_icon_s_battle.png", 1)

		lockImg:addTo(iconBg):posite(width - 7, height - 6)
	end
end
