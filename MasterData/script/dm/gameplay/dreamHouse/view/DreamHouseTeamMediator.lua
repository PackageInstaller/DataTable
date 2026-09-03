-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamHouse/view/DreamHouseTeamMediator.lua

require("dm.gameplay.stage.view.CommonTeamMediator")

DreamHouseTeamMediator = class("DreamHouseTeamMediator", CommonTeamMediator, _M)

DreamHouseTeamMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
DreamHouseTeamMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
DreamHouseTeamMediator:has("_dreamSystem", {
	is = "r"
}):injectWith("DreamHouseSystem")

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
local posTeamImg = {
	bp = "sz_nuqihuifu.png",
	def = "sz_fangyu.png",
	on = "sz_kefangzhi.png",
	atk = "sz_gongji.png",
	off = "sz_jinzhi.png"
}

function DreamHouseTeamMediator:onRegister()
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

function DreamHouseTeamMediator:enterWithData(data)
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

	if not self._dreamSystem:isSaved(self._battleId .. "@@SpecialRuleShow") then
		self:onClickRule()
		self._dreamSystem:save(self._battleId .. "@@SpecialRuleShow")
	end
end

function DreamHouseTeamMediator:resumeWithData()
	super.resumeWithData(self)
	self._costBtn:setVisible(self:showCostBtn())

	self._maxTeamPetNum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "DreamHouseHeroNum", "content")
	self._costMaxNum = self._stageSystem:getCostInit() + self._developSystem:getBuildingCostEffValue()

	self._costTotalLabel2:setString("/" .. self._costMaxNum)
	self:initLockIconsByDreamChallenge()
end

function DreamHouseTeamMediator:initData(data)
	self._data = data or {}
	self._mapId = data.mapId
	self._pointId = data.pointId
	self._battleId = data.battleId

	if data and data.stageType then
		self._stageType = data.stageType or ""
	end

	self._forbidMasters = {}
	self._masterList = self._masterSystem:getShowMasterList()
	self._recomandMasterList = {}

	assert(#self._masterList > 0, "上阵的主角不能为空！！！！")

	self._showChangeMaster = #self._masterList > 1
	self._isDrag = false
	self._costTotal = 0
	self._costMaxNum = self._stageSystem:getCostInit() + self._developSystem:getBuildingCostEffValue()
	self._forceTeam = ConfigReader:getDataByNameIdAndKey("DreamHouseMap", self._mapId, "HeroId")

	local tmpTeam = table.deepcopy(self._forceTeam, {})
	local starCond = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", self._battleId, "Star")
	local recomandTeam = self._dreamSystem:getPointRecomandTeam(starCond)

	for i = 1, #recomandTeam do
		if self._heroSystem:getHeroById(recomandTeam[i]) then
			local isIn = false

			for j = 1, #tmpTeam do
				if tmpTeam[j] == recomandTeam[i] then
					isIn = true
				end
			end

			if not isIn and not self._dreamSystem:checkHeroTired(self._mapId, self._pointId, recomandTeam[i]) then
				table.insert(tmpTeam, recomandTeam[i])
			end
		end
	end

	self._tmpTeam = tmpTeam
	self._maxTeamPetNum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "DreamHouseHeroNum", "content")

	self._stageSystem:setSortExtand(0)

	self._ignoreReloadData = true
	self._curTeam = self._data.team

	local cjson = require("cjson.safe")
	local customDataSystem = self:getInjector():getInstance(CustomDataSystem)
	local data = customDataSystem:getValue(PrefixType.kGlobal, "DreamHouseTeamStates", "BattleSuccess")

	if data ~= self._battleId .. "BattleFailed" then
		self._curTeam:setHeroes(tmpTeam)
	end

	self._curMasterId = self._curTeam:getMasterId()
	self._oldMasterId = self._curMasterId

	local teamPetIndex = 1

	self._teamPets = {}
	self._tempTeams = {}

	local teamHeros = self:removeExceptHeros(self._curTeam:getHeroes())

	for _, v in pairs(teamHeros) do
		self._teamPets[teamPetIndex] = v
		self._tempTeams[teamPetIndex] = v
		teamPetIndex = teamPetIndex + 1
	end

	local petList = self._stageSystem:getNotOnTeamPet(self._teamPets)
	local campCond = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", self._battleId, "Camp")

	if campCond == nil or #campCond == 0 then
		self._petList = petList
		self._petListAll = {}

		table.copy(self._petList, self._petListAll)
	else
		self._petList = {}

		for i = 1, #petList do
			local heroId = petList[i]
			local heroInfo = self._heroSystem:getHeroById(heroId)

			for j = 1, #campCond do
				if heroInfo and heroInfo:getParty() == campCond[j] then
					table.insert(self._petList, heroId)
				end
			end
		end

		self._petListAll = {}

		table.copy(self._petList, self._petListAll)
	end
end

function DreamHouseTeamMediator:updateData()
	local petList = self._stageSystem:getNotOnTeamPet(self._teamPets)
	local campCond = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", self._battleId, "Camp")

	if campCond == nil or #campCond == 0 then
		self._petList = petList
		self._petListAll = {}

		table.copy(self._petList, self._petListAll)
	else
		self._petList = {}

		for i = 1, #petList do
			local heroId = petList[i]
			local heroInfo = self._heroSystem:getHeroById(heroId)

			for j = 1, #campCond do
				if heroInfo and heroInfo:getParty() == campCond[j] then
					table.insert(self._petList, heroId)
				end
			end
		end

		self._petListAll = {}

		table.copy(self._petList, self._petListAll)
	end
end

function DreamHouseTeamMediator:removeExceptHeros(heros)
	local showHeros = {}

	for k, v in pairs(heros) do
		if not self._dreamSystem:checkHeroTired(self._mapId, self._pointId, v) then
			showHeros[k + 1] = v
		end
	end

	return showHeros
end

function DreamHouseTeamMediator:showOneKeyHeros()
	local orderPets = self._heroSystem:getTeamPrepared(self._teamPets, self._petList)

	self._orderPets = table.deepcopy(self._tmpTeam, {})
	self._leavePets = {}

	local canRecommendNum = 0

	for i = 1, #orderPets do
		if self._dreamSystem:checkHeroRecomand(self._battleId, orderPets[i]) and self._dreamSystem:checkHeroTired(self._mapId, self._pointId, orderPets[i]) == false then
			canRecommendNum = canRecommendNum + 1
		end
	end

	local tbRecommandIds = {}
	local notRecommendNum = self._maxTeamPetNum - canRecommendNum

	notRecommendNum = notRecommendNum > 0 and notRecommendNum or 0

	for i = 1, #orderPets do
		local isDream = false

		for j = 1, #self._tmpTeam do
			if orderPets[i] == self._tmpTeam[j] then
				isDream = true
			end
		end

		if not isDream then
			if self._dreamSystem:checkHeroRecomand(self._battleId, orderPets[i]) then
				local isTired = self._dreamSystem:checkHeroTired(self._mapId, self._pointId, orderPets[i])

				if #self._orderPets < self._maxTeamPetNum and isTired == false then
					self._orderPets[#self._orderPets + 1] = orderPets[i]

					table.insert(tbRecommandIds, orderPets[i])
				else
					self._leavePets[#self._leavePets + 1] = orderPets[i]
				end
			else
				local isTired = self._dreamSystem:checkHeroTired(self._mapId, self._pointId, orderPets[i])

				if #self._orderPets < self._maxTeamPetNum and notRecommendNum > 0 and isTired == false then
					self._orderPets[#self._orderPets + 1] = orderPets[i]
					notRecommendNum = notRecommendNum - 1
				else
					self._leavePets[#self._leavePets + 1] = orderPets[i]
				end
			end
		end
	end
end

function DreamHouseTeamMediator:setupView()
	self:initLockIcons()
	self:initLockIconsByDreamChallenge()
	self:refreshPetNode()
	self:refreshMasterInfo()
	self:initView()
	self:refreshListView()
	self:createSortView()
end

function DreamHouseTeamMediator:initWidgetInfo()
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

	local ruleData = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", self._battleId, "SpecialRuleShow")
	local ruleBtn = self._main:getChildByName("ruleBtn")

	ruleBtn:setVisible(ruleData and #ruleData > 0)

	self._teamPosPanel = self._main:getChildByFullName("teamPosPanel")
	self._teamPosInfoTip = self._main:getChildByFullName("teamPosInfo")
	self._fightInfoTip = self._main:getChildByFullName("fightInfo")

	local teamPosData = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", self._battleId, "PositionLimit")
	local blockBattleConfig = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", self._battleId, "BlockBattleConfig")
	local passiveParmData = ConfigReader:getDataByNameIdAndKey("BlockBattle", blockBattleConfig, "FriendSpecialPassiveParm")

	self._teamPosPanel:setVisible(false)

	if teamPosData and #teamPosData > 0 or passiveParmData and passiveParmData.cellcfg then
		self._teamPosPanel:setVisible(true)

		for i = 1, 9 do
			local on = self._teamPosPanel:getChildByFullName("on_" .. i)

			on:loadTexture(posTeamImg.on, ccui.TextureResType.plistType)
		end

		if passiveParmData and passiveParmData.cellcfg then
			for i = 1, #passiveParmData.cellcfg do
				local data = passiveParmData.cellcfg[i]

				if data then
					if data.type == 1 then
						self._teamPosPanel:getChildByFullName("on_" .. data.cell):loadTexture(posTeamImg.atk, ccui.TextureResType.plistType)
					elseif data.type == 2 then
						self._teamPosPanel:getChildByFullName("on_" .. data.cell):loadTexture(posTeamImg.def, ccui.TextureResType.plistType)
					elseif data.type == 3 then
						self._teamPosPanel:getChildByFullName("on_" .. data.cell):loadTexture(posTeamImg.bp, ccui.TextureResType.plistType)
					end
				end
			end
		end

		if teamPosData and #teamPosData > 0 then
			for i = 1, 9 do
				local on = self._teamPosPanel:getChildByFullName("on_" .. i)

				for index, value in ipairs(teamPosData) do
					if value == i then
						on:loadTexture(posTeamImg.off, ccui.TextureResType.plistType)
					end
				end
			end
		end
	end

	self._teamPosPanel:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			for i = 1, 9 do
				local on = self._teamPosInfoTip:getChildByFullName("teamPos.on_" .. i)

				on:loadTexture(posTeamImg.on, ccui.TextureResType.plistType)
			end

			if passiveParmData and passiveParmData.cellcfg then
				for i = 1, #passiveParmData.cellcfg do
					local data = passiveParmData.cellcfg[i]

					if data then
						if data.type == 1 then
							self._teamPosInfoTip:getChildByFullName("teamPos.on_" .. data.cell):loadTexture(posTeamImg.atk, ccui.TextureResType.plistType)
						elseif data.type == 2 then
							self._teamPosInfoTip:getChildByFullName("teamPos.on_" .. data.cell):loadTexture(posTeamImg.def, ccui.TextureResType.plistType)
						elseif data.type == 3 then
							self._teamPosInfoTip:getChildByFullName("teamPos.on_" .. data.cell):loadTexture(posTeamImg.bp, ccui.TextureResType.plistType)
						end
					end
				end
			end

			dump(teamPosData, "teamPosData >>>>>>")

			if teamPosData and #teamPosData > 0 then
				for i = 1, 9 do
					local on = self._teamPosInfoTip:getChildByFullName("teamPos.on_" .. i)

					for index, value in ipairs(teamPosData) do
						if value == i then
							on:loadTexture(posTeamImg.off, ccui.TextureResType.plistType)
						end
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

	self._teamName:setString(Strings:get("DreamHouse_Second_UI12"))
	self:setLabelEffect()
	self:ignoreSafeArea()
end

function DreamHouseTeamMediator:ignoreSafeArea()
	AdjustUtils.ignorSafeAreaRectForNode(self._heroPanel, AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._myPetPanel:getChildByName("sortPanel"), AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._main:getChildByFullName("btnPanel"), AdjustUtils.kAdjustType.Right)

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._heroPanel:setContentSize(cc.size(winSize.width - 177, 220))
end

function DreamHouseTeamMediator:createTeamCell(cell, index)
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

function DreamHouseTeamMediator:setLabelEffect()
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

function DreamHouseTeamMediator:onClickCell(sender, eventType, index)
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

function DreamHouseTeamMediator:changeOwnPet(cell)
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
		if targetIndex <= #self._forceTeam then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("DreamHouse_Second_UI19")
			}))

			return
		end

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
end

function DreamHouseTeamMediator:insertTeamPet(cell, isDrag)
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

function DreamHouseTeamMediator:createMovingPet(cell, type)
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

function DreamHouseTeamMediator:sortOnTeamPets()
	self._heroSystem:sortOnTeamPets(self._teamPets)
end

function DreamHouseTeamMediator:onClickOnTeamPet(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		local tag = sender:getTag()

		if #self._forceTeam > 0 and tag <= #self._forceTeam then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("DreamHouse_Second_UI19")
			}))

			return
		end

		self._isOnOwn = false
	elseif eventType == ccui.TouchEventType.moved then
		local tag = sender:getTag()
		local npcNum = #self._forceTeam

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
		local npcNum = #self._forceTeam

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
					self:removeTeamPet(tag)
				else
					self:changeTeamPet(tag, endPos)
				end
			else
				self:removeTeamPet(tag)
			end
		end

		self._isDrag = false

		self:cleanMovingPet()
	end
end

function DreamHouseTeamMediator:changeTeamPet(index, endPos)
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

function DreamHouseTeamMediator:removeTeamPet(index)
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

function DreamHouseTeamMediator:refreshViewBySort()
	self:updateData()
	self:refreshMasterInfo()
	self:refreshListView()
	self:refreshPetNode()
end

function DreamHouseTeamMediator:refreshView()
	self:initData()
	self:refreshMasterInfo()
	self:refreshListView()
	self:refreshPetNode()
	self._costBtn:setVisible(self:showCostBtn())
end

function DreamHouseTeamMediator:refreshListView(ignoreAdjustOffset)
	self._petListAll = self._stageSystem:getSortExtendIds(self._petList)

	local sortType = self._stageSystem:getCardSortType()
	local tbRecommandIds = {}
	local tbTiredIds = {}

	for i = 1, #self._petListAll do
		if self._dreamSystem:checkHeroRecomand(self._battleId, self._petListAll[i]) then
			table.insert(tbRecommandIds, self._petListAll[i])
		end

		if self._dreamSystem:checkHeroTired(self._mapId, self._pointId, self._petListAll[i]) then
			table.insert(tbTiredIds, self._petListAll[i])
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

function DreamHouseTeamMediator:initHero(node, info)
	local heroId = info.id

	super.initHero(self, node, info)

	local isShow = self._dreamSystem:checkHeroRecomand(self._battleId, heroId)
	local except = node:getChildByName("except")

	except:setVisible(isShow)

	if isShow then
		local text = except:getChildByName("text")

		text:setString(Strings:get("clubBoss_46"))
		text:setColor(cc.c3b(255, 203, 63))
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

		node:getChildByName("fatigueBg"):setCascadeColorEnabled(false)
		node:getChildByName("fatigueBg"):setVisible(isTired)
		node:setColor(isTired and cc.c3b(150, 150, 150) or cc.c3b(250, 250, 250))
	end

	local tiredLabel = node:getChildByName("tiredNum")

	tiredLabel:setVisible(false)

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

function DreamHouseTeamMediator:refreshPetNode()
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

		local id = self._teamPets[i]
		local heroInfo = self:getHeroInfoById(id)

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

function DreamHouseTeamMediator:initTeamHero(node, info)
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

	local textNumEffect = node:getChildByName("textNumEffect")
	local except_0 = node:getChildByName("except_0")
	local help = node:getChildByName("help")

	help:setVisible(false)

	local tiredNum = node:getChildByName("tiredNum")
	local isNotDreamer = true

	for i = 1, #self._forceTeam do
		if self._forceTeam[i] == heroId then
			isNotDreamer = false
		end
	end

	tiredNum:setVisible(isNotDreamer)
	tiredNum:setVisible(false)
	textNumEffect:setVisible(false)

	if not isNotDreamer then
		textNumEffect:setVisible(true)
		except_0:setVisible(true)
		textNumEffect:setString(Strings:get("DreamHouse_Main_UI20"))
		textNumEffect:setColor(cc.c3b(170, 144, 255))
	else
		local isShow = self._dreamSystem:checkHeroRecomand(self._battleId, heroId)

		textNumEffect:setVisible(isShow)
		except_0:setVisible(isShow)

		if textNumEffect then
			textNumEffect:setString(Strings:get("clubBoss_46"))
			textNumEffect:setColor(cc.c3b(255, 203, 63))
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
end

function DreamHouseTeamMediator:refreshCombatAndCost()
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

function DreamHouseTeamMediator:changeMasterId(event)
	self._oldMasterId = self._curMasterId
	self._curMasterId = event:getData().masterId

	self:refreshMasterInfo()
	self:checkMasterSkillActive()
	self:refreshPetNode()
end

function DreamHouseTeamMediator:refreshMasterInfo()
	local masterData = self._masterSystem:getMasterById(self._curMasterId)

	self._masterBtn:setVisible(self._showChangeMaster)
	self._masterImage:setVisible(true)
	self._masterImage:removeAllChildren()
	self._masterImage:addChild(masterData:getHalfImage())
	self:refreshCombatAndCost()
	self:refreshButtons()
end

function DreamHouseTeamMediator:refreshButtons()
	self._teamBreakBtn:setVisible(self:checkButtonVisible())
	self._teamOneKeyBtn:setVisible(not self:checkButtonVisible())
end

function DreamHouseTeamMediator:checkButtonVisible()
	if #self._teamPets < self._maxTeamPetNum then
		return false
	end

	return true
end

function DreamHouseTeamMediator:hasChangeTeam()
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

function DreamHouseTeamMediator:sendSpChangeTeam(callBack, ignoreTip)
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

function DreamHouseTeamMediator:onClickRule()
	local config = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", self._battleId, "SpecialRuleShow")

	if config and #config > 0 then
		local view = self:getInjector():getInstance("StagePracticeSpecialRuleView")
		local tab = config
		local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			ruleList = tab
		})

		self:dispatch(event)
	end
end

function DreamHouseTeamMediator:onClickOneKeyBreak()
	self._teamView:stopScroll()

	local petListTemp = self._stageSystem:getNotOnTeamPet(self._forceTeam)
	local campCond = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", self._battleId, "Camp")

	if campCond == nil or #campCond == 0 then
		self._teamPets = table.deepcopy(self._forceTeam, {})
		self._petList = {}

		table.copy(petListTemp, self._petList)
	else
		self._teamPets = table.deepcopy(self._forceTeam, {})
		self._petList = {}

		local tmpHeros = {}

		for i = 1, #petListTemp do
			local heroId = petListTemp[i]
			local heroInfo = self._heroSystem:getHeroById(heroId)

			for j = 1, #campCond do
				if campCond and heroInfo:getParty() == campCond[j] then
					table.insert(tmpHeros, heroId)
				end
			end
		end

		table.copy(tmpHeros, self._petList)
	end

	self:refreshListView(true)
	self:refreshPetNode()
end

function DreamHouseTeamMediator:onClickBack()
	self:dismiss()
end

function DreamHouseTeamMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local oneKeyBtn = self:getView():getChildByFullName("main.info_bg.button_one_key_embattle")

	if oneKeyBtn then
		storyDirector:setClickEnv("DreamHouseTeamMediator.OneKeyBtn", oneKeyBtn, function(sender, eventType)
			AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
			self:onClickOneKeyEmbattle()
		end)
	end

	local btnBack = self:getView():getChildByFullName("topinfo_node.back_btn")

	storyDirector:setClickEnv("DreamHouseTeamMediator.btnBack", btnBack, function(sender, eventType)
		AudioEngine:getInstance():playEffect("Se_Click_Close_1", false)
		self:onClickBack()
	end)

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		storyDirector:notifyWaiting("enter_DreamHouseTeamMediator")
	end))

	oneKeyBtn:runAction(sequence)
end

function DreamHouseTeamMediator:onClickFight(sender, eventType)
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
			self._dreamSystem:enterBattle(response.data)
		end
	end)
end

function DreamHouseTeamMediator:isSelectCanceledByClick(id)
	local num = #self._teamPets

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

function DreamHouseTeamMediator:onClickOneKeyEmbattle()
	self._teamView:stopScroll()
	self:showOneKeyHeros()

	self._teamPets = {}
	self._petList = {}

	table.deepcopy(self._orderPets, self._teamPets)
	table.deepcopy(self._leavePets, self._petList)
	self:refreshListView(true)
	self:refreshPetNode()

	for i = 1 + #self._forceTeam, self._maxTeamPetNum do
		if self._petNodeList[i] then
			local iconBg = self._teamBg:getChildByName("pet_" .. i)

			if iconBg:getChildByName("EmptyIcon") then
				iconBg:getChildByName("EmptyIcon"):setVisible(false)
			end
		end
	end
end

function DreamHouseTeamMediator:initLockIconsByDreamChallenge()
	local maxShowNum = 10

	for i = self._maxTeamPetNum + 1, maxShowNum do
		local condition, buildId
		local type, showAnim, unlockLevel, conditions = "", false, 0, {}
		local iconBg = self._teamBg:getChildByName("pet_" .. i)

		iconBg:removeAllChildren()

		local emptyIcon = GameStyle:createEmptyIcon(true)

		emptyIcon:addTo(iconBg):center(iconBg:getContentSize())

		local tipLabel = emptyIcon:getChildByName("TipText")

		tipLabel:setString(Strings:get("DreamHouse_Second_UI18"))

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
	end
end

function DreamHouseTeamMediator:onClickMasterSkill()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local params = {
		isFromDream = true,
		masterId = self._curMasterId,
		active = self._skillActive
	}
	local view = self:getInjector():getInstance("MasterLeaderSkillView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, params))
end

function DreamHouseTeamMediator:checkMasterSkillActive()
	self._masterSkillPanel:removeAllChildren()

	self._skillActive = {}

	local skills = self._masterSystem:getMasterLeaderSkillList(self._curMasterId)

	for i = 1, #skills do
		local skill = skills[i]
		local skillId = skill:getId()
		local info = {
			levelHide = true,
			id = skillId,
			skillType = skill:getSkillType()
		}
		local newSkillNode = IconFactory:createMasterSkillIcon(info)

		newSkillNode:setScale(0.36)
		self._masterSkillPanel:addChild(newSkillNode, 2)

		local index = i <= 3 and i or i - 3
		local posX = 20 + (index - 1) * 55
		local posY = i <= 3 and 61 or 10

		newSkillNode:setPosition(cc.p(posX, posY))

		local conditions = skill:getActiveCondition()
		local isActive = true

		newSkillNode:setGray(not isActive)

		if isActive then
			self._skillActive[i] = true

			local shangceng = cc.MovieClip:create("shangceng_jinengjihuo")

			shangceng:addTo(newSkillNode)
			shangceng:setPosition(cc.p(46.5, 46.5))
			shangceng:setScale(1.42)
		else
			newSkillNode:setGray(true)

			self._skillActive[i] = false
		end
	end
end
