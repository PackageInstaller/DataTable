-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/interpreter/UnitTLInterpreter.lua

UnitTLInterpreter = class("UnitTLInterpreter", TLInterpreter, _M)

UnitTLInterpreter:has("_context", {
	is = "rw"
})

local specId = ""

function UnitTLInterpreter:initialize(viewContext)
	super.initialize(self)

	self._context = viewContext
	self._bubbles = {}
	self._skillStateTag = {}
	self._battleGround = viewContext:getValue("BattleGroundLayer")
	self._battleUIMediator = viewContext:getValue("BattleUIMediator")
	self._unitManager = viewContext:getValue("BattleUnitManager")
	self._changeWidget = viewContext:getValue("BattleChangeWidget")
	self._skelAnimGroup = viewContext:getValue("SkeletonAnimGroup")

	self._context:addEventListener(EVT_Battle_UnitDie, self, self.onUnitDie)
end

function UnitTLInterpreter:doAction(action, args, mode)
	local role = self._unitManager:getUnitById(self:getId())

	if role == nil and action ~= "SpawnUnit" and action ~= "RebornUnit" and action ~= "CallUnit" and action ~= "Revive" and action ~= "CallMasterUnit" then
		return
	end

	local func = self["act_" .. action]

	if func == nil then
		cclog("warning", "'%s' skipped action '%s'", self._id, action)
		assert(false, self._id .. " don't have action " .. action)

		return
	end

	if self:getId() == specId then
		Bdump("doAction", action, args)
	end

	return func(self, action, args, mode)
end

function UnitTLInterpreter:setUnitObject(unit)
	self._unit = unit
end

function UnitTLInterpreter:setMasterWidget(masterWidget)
	self._masterWidget = masterWidget

	self._unit:setMasterWidget(masterWidget)
end

function UnitTLInterpreter:setHeadWidget(headWidget)
	self._headWidget = headWidget

	self._unit:setHeadWidget(headWidget)
end

function UnitTLInterpreter:setHeroHeadWidget(headWidget)
	self._heroHeadWidget = headWidget

	self._unit:setHeroHeadWidget(headWidget)
end

function UnitTLInterpreter:setEquipHpWidget(equipHpWidget)
	self._equipHpWidget = equipHpWidget

	self._unit:setEquipHpWidget(equipHpWidget)
end

function UnitTLInterpreter:setDataModel(model)
	self._dataModel = model
end

function UnitTLInterpreter:syncMainViewMaster()
	if self._masterWidget then
		self._masterWidget:setRp(self._dataModel:getRp())
		self._masterWidget:setHp(self._dataModel:getHp())
	end

	if self._headWidget then
		self._headWidget:setHp(self._dataModel:getHp())
		self._headWidget:setRp(self._dataModel:getRp(), self._dataModel:getMaxRp())
	end
end

function UnitTLInterpreter:act_ChangeFlags(action, args)
	local flags = args.flags

	self._dataModel:setFlags(flags)
end

function UnitTLInterpreter:act_IsSummond(action, args)
	local isSummoned = args.isSummoned

	self._dataModel:setIsSummond(isSummoned)
end

function UnitTLInterpreter:act_SpawnUnit(action, args)
	self._mainPlayerSide = self._context:getValue("IsTeamAView")
	self._mainPlayerId = self._context:getValue("CurMainPlayerId")

	local id = args.id
	local modelId = args.model
	local roleType = args.roleType
	local cellId = args.cell
	local isLeft = true

	isLeft = not not (self._mainPlayerSide and cellId > 0 or not self._mainPlayerSide and cellId < 0)

	local posInArr = math.abs(cellId)
	local roleDataModel = BattleRoleModel:new(self._context)

	roleDataModel:setShield(0)
	roleDataModel:setRoleId(id)
	roleDataModel:setHp(args.hp)
	roleDataModel:setRp(args.anger)
	roleDataModel:setMaxHp(args.maxHp)
	roleDataModel:setMaxRp(args.maxAnger)
	roleDataModel:setRoleType(args.roleType)
	roleDataModel:setCellId(isLeft and posInArr or -posInArr)
	roleDataModel:setStar(args.star)
	roleDataModel:setModelId(modelId)
	roleDataModel:setCost(args.cost)
	roleDataModel:setGenre(args.genre)
	roleDataModel:setIsProcessingBoss(args.isProcessingBoss)
	roleDataModel:setAwakenLevel(args.awakenLevel or 0)
	roleDataModel:setModelScale(args.modelScale)
	roleDataModel:setConfigId(args.cid)
	roleDataModel:setIsSummond(args.isSummoned)
	roleDataModel:setSide(args.side)
	roleDataModel:setFlags(args.flags)
	roleDataModel:setIsBattleField(args.isBattleField)

	local pos = self._battleGround:relPositionFor(isLeft, posInArr)
	local role = BattleRoleObject:new(id, roleDataModel, self._context)

	role:setHomePlace(pos)
	role:setRelPosition(pos, nil, 0)
	role:setIsTeamFlipped(not self._mainPlayerSide)
	self._battleGround:getGroundLayer():addChild(role:getView())
	self._unitManager:addUnit(role, roleDataModel)

	local anim = args.anim
	local occupy = true

	if anim and anim.name == "init" then
		-- block empty
	elseif anim and anim.name == "reinforce" then
		-- block empty
	elseif anim and anim.name == "reborn" then
		-- block empty
	elseif self._mainPlayerId and args.owner ~= self._mainPlayerId then
		role:hideRole(0)

		occupy = false
	else
		role:hideRole(args.opacity or 180)
	end

	if occupy then
		self._battleGround:resetGroundCell(roleDataModel:getCellId(), GroundCellStatus.OCCUPIED)
		self._battleGround:setCellOccupiedHero(roleDataModel:getCellId(), roleDataModel)
	end

	self:setUnitObject(role)
	self:setDataModel(roleDataModel)

	if self._battleUIMediator.getEquipHpWidget then
		local equipHpWidget = self._battleUIMediator:getEquipHpWidget()

		if self._battleUIMediator.getEquipHpWidget then
			if self._battleUIMediator.getEquipHpWidget:getView():isVisible() then
				self:setEquipHpWidget(self._battleUIMediator.getEquipHpWidget)
			end
		end

		if roleType == RoleType.Master then
			local data = {
				modelId = modelId,
				hp = roleDataModel:getHp(),
				mp = args.anger,
				maxHp = args.maxHp,
				maxMp = args.maxAnger,
				skills = args.skills
			}

			if self._mainPlayerId and args.owner == self._mainPlayerId then
				local masterWidget = self._battleUIMediator:getMasterWidget()

				if masterWidget then
					masterWidget:updateMasterInfo(data)
				end

				self:setMasterWidget(masterWidget)

				local headWidget = self._battleUIMediator:getLeftHeadWidget()

				headWidget:updateHeadInfo(data, roleDataModel)
				self:setHeadWidget(headWidget)
			else
				local headWidget = self._battleUIMediator:getRightHeadWidget()

				headWidget:updateHeadInfo(data, roleDataModel)
				self:setHeadWidget(headWidget)
			end

			if self._equipHpWidget and isLeft then
				self._equipHpWidget:addMasterHpInfo(id, args.hp, args.maxHp)
			end
		else
			if self._mainPlayerId and args.owner == self._mainPlayerId then
				local headWidget = self._battleUIMediator:getLeftHeadWidget()

				if headWidget.spawnHero and headWidget:spawnHero(roleDataModel) then
					self:setHeroHeadWidget(headWidget)
				end
			else
				local headWidget = self._battleUIMediator:getRightHeadWidget()

				if headWidget.spawnHero and headWidget:spawnHero(roleDataModel) then
					self:setHeroHeadWidget(headWidget)
				end
			end

			if self._equipHpWidget and isLeft then
				self._equipHpWidget:addHeroHpInfo(id, args.cid, args.hp, args.maxHp)
			end
		end

		if args.heroShow and args.heroShow ~= "" then
			local battleShowQueue = self._context:getValue("BattleShowQueue")

			if battleShowQueue then
				battleShowQueue:addHeroShow(args.heroShow)
			end
		end
	end
end

function UnitTLInterpreter:act_RebornUnit(action, args)
	self._mainPlayerSide = self._context:getValue("IsTeamAView")
	self._mainPlayerId = self._context:getValue("CurMainPlayerId")

	local id = args.id
	local modelId = args.model
	local roleType = args.roleType
	local cellId = args.cell
	local isLeft = true

	isLeft = not not (self._mainPlayerSide and cellId > 0 or not self._mainPlayerSide and cellId < 0)

	local posInArr = math.abs(cellId)
	local role = self._unitManager:getUnitById(id)

	if role then
		self:setUnitObject(role)

		local dataModel = role:getDataModel()

		dataModel:setHp(args.hp)
		dataModel:setRp(args.anger)
		dataModel:setMaxHp(args.maxHp)
		dataModel:setMaxRp(args.maxAnger)
		dataModel:setStar(args.star)
		self:setDataModel(dataModel)

		if dataModel:getCellId() ~= (isLeft and posInArr or -posInArr) then
			local prevCellId = dataModel:getCellId()

			dataModel:setCellId(isLeft and posInArr or -posInArr)

			local pos = self._battleGround:relPositionFor(isLeft, posInArr)

			role:setHomePlace(pos)
			role:setRelPosition(pos, nil, 0)
			role:setIsTeamFlipped(not self._mainPlayerSide)
		end

		if roleType ~= dataModel:getRoleType() then
			dataModel:setRoleType(roleType)
			role:setRoleType(roleType)
		end

		if modelId ~= dataModel:getModelId() then
			dataModel:setModelId(modelId)
		end

		role:doReborn(args)
	else
		args.anim = {
			name = "reborn"
		}

		self:act_SpawnUnit("SpawnUnit", args)
	end

	if self._heroHeadWidget and self._heroHeadWidget.spawnHero and self._heroHeadWidget:spawnHero(roleDataModel) then
		self:setHeadHeadWidget(self._heroHeadWidget)
	end
end

function UnitTLInterpreter:act_CallUnit(action, args)
	self:act_SpawnUnit("SpawnUnit", args)
end

function UnitTLInterpreter:act_CallMasterUnit(action, args)
	args.opacity = 0

	self:act_SpawnUnit("SpawnUnit", args)
end

function UnitTLInterpreter:act_Revive(action, args)
	self:act_SpawnUnit("SpawnUnit", args)
end

function UnitTLInterpreter:act_Settled(action, args, mode)
	self._unit:settle()
end

function UnitTLInterpreter:act_Transform(action, args, mode)
	local modelId = args.model
	local roleType = args.roleType
	local dataModel = self._dataModel

	dataModel:setShield(0)
	dataModel:updateMaxHp(args.maxHp, args.hp)
	dataModel:setRp(args.anger)
	dataModel:setMaxRp(args.maxAnger)
	dataModel:setRoleType(args.roleType)
	dataModel:setStar(args.star)
	dataModel:setModelId(modelId)
	dataModel:setCost(args.cost)
	dataModel:setIsProcessingBoss(args.isProcessingBoss)
	self._unit:cleanBuff()
	self._unit:transform()

	if args.heroShow and args.heroShow ~= "" then
		local battleShowQueue = self._context:getValue("BattleShowQueue")

		if battleShowQueue then
			battleShowQueue:addHeroShow(args.heroShow)
		end
	end

	if self._unit._roleType == RoleType.Master and not self._unit:isLeft() and self._changeWidget then
		self._changeWidget:addChangeNum(1)
	end

	if roleType == RoleType.Master and args.owner ~= self._mainPlayerId then
		local headWidget = self._battleUIMediator:getRightHeadWidget()

		headWidget:setMasterIcon(modelId)
	end
end

function UnitTLInterpreter:act_TransportExt(action, args, mode)
	local cellId = args.cell

	if not (args.duration / 1000) then
		local duration = 500

		if not args.timeScale then
			local timeScale = 1

			if not args.ignoreSwitch then
				local ignoreSwitch = false
				local posInArr = math.abs(cellId)
				local isLeft = true

				isLeft = not not (self._mainPlayerSide and cellId > 0 or not self._mainPlayerSide and cellId < 0)

				local pos = self._battleGround:relPositionFor(isLeft, posInArr)
				local role = self._unit
				local dataModel = self._dataModel
				local oldCellId = dataModel:getCellId()

				dataModel:setCellId(isLeft and posInArr or -posInArr)
				role:setHomePlace(pos)

				local from = role:getRelPosition()
				local to = pos

				if math.abs(to.x - from.x) > 0 then
					role:switchState("run", {
						loop = -1
					})

					if to.x == role._homePlace.x then
						role:setLookat((to.x - from.x) * (isLeft and 1 or -1))
					end
				end

				local oldTimeScale = role:getRoleAnim():getTimeScale()

				role:getRoleAnim():setTimeScale(timeScale)
				role:setBusyState(true)
				role:moveWithDuration(pos, duration, function()
					role:setBusyState(false)

					if not ignoreSwitch then
						self._unitManager:exchange(oldCellId, dataModel:getCellId())
					end

					self._battleGround:resetGroundCell(oldCellId, GroundCellStatus.NORMAL)
					self._battleGround:resetGroundCell(self._dataModel:getCellId(), GroundCellStatus.OCCUPIED)
					role:getRoleAnim():setTimeScale(oldTimeScale)
				end)

				if not ignoreSwitch then
					self._battleGround:swipCellOccupiedHero(oldCellId, dataModel:getCellId())
				end
			end
		end
	end
end

function UnitTLInterpreter:act_Transport(action, args, mode)
	local cellId = args.cell
	local posInArr = math.abs(cellId)
	local isLeft = true

	isLeft = not not (self._mainPlayerSide and cellId > 0 or not self._mainPlayerSide and cellId < 0)

	local pos = self._battleGround:relPositionFor(isLeft, posInArr)
	local role = self._unit
	local dataModel = self._dataModel
	local oldCellId = dataModel:getCellId()

	dataModel:setCellId(isLeft and posInArr or -posInArr)
	role:setHomePlace(pos)
	role:setRelPosition(pos, nil, 0)
	self._unitManager:exchange(oldCellId, dataModel:getCellId())
	self._battleGround:resetGroundCell(oldCellId, GroundCellStatus.NORMAL)
	self._battleGround:resetGroundCell(self._dataModel:getCellId(), GroundCellStatus.OCCUPIED)
end

function UnitTLInterpreter:loadSkillMovie(movieId)
	local config = ConfigReader:getRecordById("SkillMovie", movieId)

	if not config then
		CommonUtils.uploadDataToBugly("UnitTLInterpreter:loadSkillMovie", "movieId:" .. movieId)

		return
	end

	local loads = config.Load

	for _, picname in ipairs(loads) do
		MemCacheUtils:asyncAddPlist("asset/anim/" .. picname .. ".plist", "battle")
	end
end

function UnitTLInterpreter:act_BeginSkill(action, args, mode)
	local actId = args.act
	local model = args.model
	local proud = args.proud
	local load = args.load
	local skill = args.skill

	if load then
		for _, movieId in ipairs(load) do
			self:loadSkillMovie(movieId)
		end
	end

	local skillAction = BattleRoleSkillAction:new(actId)

	skillAction:setState(BattleRoleSkillState.Begin)
	self._context:addSkillAction(actId, skillAction)

	local data = {
		id = self._dataModel:getRoleId(),
		type = args.type
	}

	if self._masterWidget then
		self._masterWidget:onDoSkill(data)
	end

	self._unit:setBarAndBuffVisble(false)

	while model and model ~= "" do
		local flag, skillId, anim = unpack(string.split(model, "#"))

		flag = tonumber(flag)

		if type(flag) ~= "number" then
			break
		end

		skillAction:setIsInSupering(true)

		if flag == 0 then
			break
		end

		local effectLayer = self._context:getValue("BattleScreenEffectLayer")
		local modelConfig = self._dataModel:getModelConfig()
		local modelId = modelConfig.Id
		local model = modelConfig.Model
		local isAwakenEffect = self._dataModel:getAwakenLevel() > 0

		if isAwakenEffect then
			do
				local configId = self._dataModel:getConfigId()
				local awakeSkillId, _ = unpack(string.split(skill, ":"))
				local skillDesc = ConfigReader:getDataByNameIdAndKey("Skill", awakeSkillId, "SkillPic")
				local awakePortrait = ConfigReader:getDataByNameIdAndKey("HeroBase", configId, "AwakePic")
				local roleModelId = ConfigReader:getDataByNameIdAndKey("HeroBase", configId, "RoleModel")
				local _modelId = ConfigReader:getDataByNameIdAndKey("RoleModel", roleModelId, "Model")

				effectLayer:pushPortraitEffect(_modelId, flag, skillDesc, not self._unit:isLeft(), isAwakenEffect, awakePortrait, configId)
			end

			break
		end

		do
			local skillDesc = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "SkillPic")
			local configId = self._dataModel:getConfigId()
			local rareity = ConfigReader:getDataByNameIdAndKey("HeroBase", configId, "Rareity")

			if not rareity then
				local enemyInfo = ConfigReader:getRecordById("EnemyHero", configId)

				if enemyInfo then
					rareity = enemyInfo.Rarity
				end
			end

			if not rareity then
				local enemyInfo = ConfigReader:getRecordById("EnemyMaster", configId)

				if enemyInfo then
					rareity = enemyInfo.Rarity
				end
			end

			if rareity == 15 then
				effectLayer:pushPortraitEffect(model .. "/" .. modelConfig.CutIn, flag, skillDesc, not self._unit:isLeft(), isAwakenEffect, nil, nil, true)

				break
			end

			effectLayer:pushPortraitEffect(modelId, flag, skillDesc, not self._unit:isLeft(), isAwakenEffect, nil, nil, false)
		end

		break
	end

	while proud and proud ~= "" do
		local skillId = proud
		local icon = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Icon")

		if icon == nil or icon == "" then
			break
		end

		local skillName = Strings:get(ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Name"))
		local image = cc.Sprite:create("asset/skillIcon/" .. icon .. ".png")

		image:setScale(0.25)

		local anim = cc.MovieClip:create("xdh_xiaojinengtishi", "BattleMCGroup")

		anim:addEndCallback(function(cid, mc)
			mc:stop()
			mc:removeFromParent(true)
		end)
		image:offset(0, 3):addTo(anim:getChildByName("icon"))

		local label = ccui.Text:create(skillName, TTF_FONT_FZYH_R, 18)

		label:enableOutline(cc.c4b(35, 15, 5, 255), 1)
		label:addTo(anim:getChildByName("name"))
		label:offset(label:getContentSize().width / 2 - 36)
		self._unit:addActiveNode(anim, {
			x = 0.5,
			y = 1
		}, "cover", 1)
		anim:setScale(1)

		if not self._unit:isLeft() then
			anim:setScaleX(-1)
		end

		break
	end
end

function UnitTLInterpreter:act_EndSkill(action, args, mode)
	local actId = args.act

	if args.reason then
		local abort = not (args.reason ~= "abort" and args.reason ~= "finish")
		local skillAction = self._context:getSkillAction(actId)

		if not skillAction then
			return
		end

		skillAction:setState(BattleRoleSkillState.End)

		local performAct = self._dataModel:getPerformAct()
		local isPerforming = actId == performAct

		self._unit:setBarAndBuffVisble(true)

		if skillAction:isInSupering() then
			local mainMediator = self._context:getValue("BattleMainMediator")

			mainMediator:clearGroundEffect(actId)

			local camera = self._context:getValue("Camera")
			local cameraActId = self._context:getValue("CameraActId")

			if cameraActId == actId then
				camera:focusOn(display.cx, display.cy, 1, 0.2)
			end

			self._battleGround:subGroundBlackCount()
			skillAction:setIsInSupering(false)
			self._battleGround:cancelTarget(actId)
		end

		local behaviorNode = skillAction:getBehaviorNode()

		if abort and behaviorNode then
			behaviorNode:abort()

			if isPerforming then
				self._unit:setBusyState(false)
				self._dataModel:setPerformAct(nil)
			end
		end

		if isPerforming and behaviorNode and not behaviorNode:isRunning() then
			self._unit:goBack()
		end

		if behaviorNode == nil or not behaviorNode:isRunning() then
			self._unit:clearSkillEffect(actId)
			self._unit:clearSkillMovie(actId)
			self._context:delSkillAction(actId)

			if isPerforming then
				self._dataModel:setPerformAct(nil)
			end
		end
	end
end

function UnitTLInterpreter:act_Perform(action, args, mode)
	local actId = args.act
	local animation = args.anim
	local autoStand = args.autoStand

	self:stopRunningPerform(actId)

	local skillAction = self._context:getSkillAction(actId)

	if not skillAction then
		return
	end

	skillAction:setState(BattleRoleSkillState.Perform)

	local behaviorNode = self._unit:createBehaviorNode(animation)

	skillAction:setBehaviorNode(behaviorNode)
	self._unit:setBusyState(true)
	self._dataModel:setPerformAct(actId)
	behaviorNode:run(self._unit, function()
		self._unit:setBusyState(false)

		if skillAction:getState() == BattleRoleSkillState.End then
			self._dataModel:setPerformAct(nil)
			self._context:delSkillAction(actId)
			self._unit:goBack()
			self._unit:clearSkillEffect(actId)
			self._unit:clearSkillMovie(actId)
		elseif autoStand then
			self._unit:switchState("stand", {
				loop = -1
			})
		end
	end)
end

function UnitTLInterpreter:stopRunningPerform(nextAct)
	local performAct = self._dataModel:getPerformAct()

	if performAct then
		local skillAction = self._context:getSkillAction(performAct)

		if not skillAction then
			return
		end

		local behaviorNode = skillAction:getBehaviorNode()
		local targets = skillAction:getTargets()

		if performAct ~= nextAct and skillAction:isInSupering() then
			local mainMediator = self._context:getValue("BattleMainMediator")

			mainMediator:clearGroundEffect(performAct)
			skillAction:setIsInSupering(false)
			self._battleGround:cancelTarget(performAct)
		end

		if behaviorNode and behaviorNode:isRunning() then
			behaviorNode:abort()
			self._unit:setBusyState(false)
			self._unit:clearSkillEffect(performAct)
			self._unit:clearSkillMovie(actId)

			if skillAction:getState() == BattleRoleSkillState.End then
				self._context:delSkillAction(performAct)
			end
		end

		for roleId, flags in pairs(targets) do
			local role = self._unitManager:getUnitById(roleId)

			if role then
				role:subActivateNums(performAct)
			end
		end
	end
end

function UnitTLInterpreter:act_Flee(action, args)
	if not self._unit:isLive() then
		return
	end

	local performAct = self._dataModel:getPerformAct()

	if performAct then
		local skillAction = self._context:getSkillAction(performAct)

		if skillAction then
			local targets = skillAction:getTargets()

			for roleId, flags in pairs(targets) do
				local role = self._unitManager:getUnitById(roleId)

				if role then
					role:subActivateNums(performAct)
				end
			end
		end
	end

	self._unit:flee(args and args.dur)
	self._unitManager:disableUnitById(self._id, self._dataModel:getCellId())

	if self._heroHeadWidget and self._heroHeadWidget.unitFlee then
		self._heroHeadWidget:unitFlee(self._id)
	end

	if self._battleUIMediator.getFleeWidget then
		local fleeWidget = self._battleUIMediator:getFleeWidget()

		if fleeWidget then
			fleeWidget:reduceNum(args.cell, args.flags)
		end
	end

	if self._heroHeadWidget and self._heroHeadWidget.unitDie then
		self._heroHeadWidget:unitDie(self._id)
	end
end

function UnitTLInterpreter:act_Expelled(action, args)
	if self._expelledbehavior then
		return
	end

	if not self._unit:isLive() then
		return
	end

	local performAct = self._dataModel:getPerformAct()

	if performAct then
		local skillAction = self._context:getSkillAction(performAct)

		if skillAction then
			local targets = skillAction:getTargets()

			for roleId, flags in pairs(targets) do
				local role = self._unitManager:getUnitById(roleId)

				if role then
					role:subActivateNums(performAct)
				end
			end
		end
	end

	local mainMediator = self._context:getValue("BattleMainMediator")
	local teamInfoWidget = mainMediator:getTeamInfoWidget(self._unit:isLeft())
	local behaviorNode = self._unit:createBehaviorNode(args)

	behaviorNode:run(self._unit, function()
		teamInfoWidget:updateHpInfo(-self._dataModel:getHp())

		self._expelledBehavior = nil

		self._unit:remove()
	end)

	self._expelledBehavior = behaviorNode

	self._battleOpLayer:removeRole(self._dataModel)
end

function UnitTLInterpreter:act_ActEfft(action, args)
	local actId = args.act
	local evts = args.evts

	for _, data in ipairs(evts) do
		local evtData = {}

		table.deepcopy(data, evtData)

		local targetId = evtData[1]
		local evtName = evtData[2]

		if evtName == "Hurt" then
			local efftData = evtData[3]

			if efftData.deadly then
				-- block empty
			end

			local interpreter = self:getTLInterpreterById(targetId)

			if interpreter then
				local data = {}

				table.deepcopy(efftData, data)

				data.actId = actId

				interpreter:doAction(evtName, data)
			end
		else
			local interpreter = self:getTLInterpreterById(targetId)

			if interpreter then
				interpreter:doAction(evtName, evtData[3])
			end
		end
	end
end

function UnitTLInterpreter:act_AddRoles(action, args)
	local act = args.act
	local roles = args.roles
	local skillAction = self._context:getSkillAction(act)

	if skillAction then
		for i, role in ipairs(roles) do
			skillAction:addFlagForRole(self._id, role)
		end
	end
end

function UnitTLInterpreter:act_DelRoles(action, args)
	local act = args.act
	local roles = args.roles
	local skillAction = self._context:getSkillAction(act)

	for i, roleFlag in ipairs(roles) do
		if skillAction then
			skillAction:delFlagForRole(self._id, roleFlag)
		end

		local role = self._unitManager:getUnitById(self._id)

		if role and act then
			role:subActivateNums(act)
		end
	end
end

function UnitTLInterpreter:act_Drop(action, args)
	for i, item in ipairs(args) do
		self._battleGround:dropBattleLoot(self._unit, item)
	end
end

function UnitTLInterpreter:act_SwitchActionTo(action, args)
	local actionSrc = args.srcAnim
	local actionDes = args.desAnim

	self._unit:switchAction(actionSrc, actionDes)
end

function UnitTLInterpreter:act_ChangeActionLoop(action, args)
	local isLoop = args.isLoop
	local actionDes = args.desAnim

	self._unit:changeActionLoop(actionDes, isLoop)
end

function UnitTLInterpreter:act_ClearAllSwitchAction(action, args)
	self._unit:clearAllTransformAction()
end

function UnitTLInterpreter:act_SetDisplayZorder(action, args)
	local zorder = args.zorder

	self._unit:setDisplayZorder(zorder)
end

function UnitTLInterpreter:act_ResetDisplayZorder(action, args)
	self._unit:resetDisplayZorder()
end

function UnitTLInterpreter:act_Hurt(action, args)
	args.raw = args.raw or 0
	args.eft = args.eft or 0
	args.val = args.val or self._dataModel:getHp()

	local eft = args.eft
	local val = args.val
	local shldVal = args.shldVal

	if not args.shldCost then
		local shldCost = 0
		local lastHp = self._dataModel:getHp()
		local actorGenre = args.actorGenre
		local targetGenre = args.targetGenre
		local diff = 0
		local newHp = 0

		if val == 0 then
			newHp = val
			diff = lastHp
		else
			newHp = math.max(lastHp - args.eft, 0)
			diff = lastHp - newHp
		end

		if shldVal then
			self._dataModel:setShield(shldVal)
		end

		if args.raw > 0 then
			self._dataModel:setHp(newHp)
		end

		if args.brokeShield then
			local buffModel = ConfigReader:getRecordById("BuffModel", "ShieldBreak")

			if buffModel then
				self._unit:addActiveEffect(buffModel.Effect, false, cc.p(0.5, buffModel.EffectPos), "front", 10, function(cid, mc)
					mc:removeFromParent()
				end)
			end
		end

		self._unit:doAction(action, args)

		local battleSuppress = self._context:getValue("battleSuppress")
		local sub, bySub

		if actorGenre and battleSuppress[actorGenre] then
			if not battleSuppress[actorGenre].BySup then
				do
					local bySup = {}

					if not battleSuppress[actorGenre].Sup then
						local sup = {}

						if bySup and targetGenre and bySup[targetGenre] then
							bySub = true
						elseif sup and targetGenre and sup[targetGenre] then
							sub = true
						end
					end
				end

				if args.raw >= 0 then
					if not args.raw then
						local rawDamage = math.abs(args.raw)

						if args.immune then
							self._unit:reduceHealth("", {
								type = "immune",
								sub = sub,
								bySub = bySub
							})
						elseif eft == 0 and shldCost > 0 then
							self._unit:reduceHealth(math.ceil(shldCost), {
								type = "shield",
								sub = sub,
								bySub = bySub
							})
						else
							local var_41_4 = math.floor(rawDamage)
							local var_41_5 = {}

							var_41_5.type = args.block and "block" or args.crit and "crit" or args.dotStatus and args.dotStatus:lower() or "damage"
							var_41_5.sub = sub
							var_41_5.bySub = bySub

							self._unit:reduceHealth(var_41_4, var_41_5)
						end
					end
				end
			end
		end
	end
end

function UnitTLInterpreter:act_FlyBallToCard(action, args)
	if self._battleUIMediator and self._unit:isLeft() then
		self._battleUIMediator:flyBallToCard(self._unit, args.index)
	end
end

function UnitTLInterpreter:checkHurt(action, args, diff)
	local raw, eft
	local performAct = args.act

	if performAct then
		::label_44_0::

		local skillAction = self._context:getSkillAction(performAct)

		if true or skillAction == nil or args.notLastHit == nil then
			raw = args.raw
			eft = diff
		elseif args.notLastHit then
			skillAction:addHurtData(self._id, args.eft, args.raw)
		else
			local hurtInfo = skillAction:getHurtData(self._id)

			if hurtInfo then
				raw = ((hurtInfo or nil) and (hurtInfo.raw or 0)) + args.raw
				eft = ((hurtInfo or nil) and (hurtInfo.eft or 0)) + args.eft
			end
		end

		if raw and raw ~= 0 then
			local rawDamage = raw >= 0 and raw or math.abs(args.raw)

			self._unit:reduceHealth(math.floor(rawDamage), {
				type = args.block and "block" or args.crit and "crit" or "damage"
			})
		end

		if eft and eft ~= 0 then
			-- block empty
		end
	end
end

function UnitTLInterpreter:act_HpReduce(action, args)
	args.raw = args.raw or 0
	args.eft = args.eft or 0
	args.isFlyLabel = args.isFlyLabel or false
	args.val = args.val or self._dataModel:getHp()

	local val = args.val
	local shldVal = args.shldVal
	local isFlyLabel = args.isFlyLabel

	if not args.shldCost then
		local lastHp = self._dataModel:getHp()
		local diff = 0
		local newHp = 0

		if val == 0 then
			newHp = val
			diff = lastHp
		else
			newHp = math.max(lastHp - args.eft, 0)
			diff = lastHp - newHp
		end

		if shldVal then
			self._dataModel:setShield(shldVal)
		end

		if isFlyLabel then
			if args.raw > 0 then
				self._unit:reduceHealth(math.floor(args.raw), {
					type = "damage"
				})
				self._dataModel:setHp(newHp)
			end
		elseif args.raw > 0 then
			self._dataModel:setHp(newHp)
		end

		if args.brokeShield then
			local buffModel = ConfigReader:getRecordById("BuffModel", "ShieldBreak")

			if buffModel then
				self._unit:addActiveEffect(buffModel.Effect, false, cc.p(0.5, buffModel.EffectPos), "front", 10, function(cid, mc)
					mc:removeFromParent()
				end)
			end
		end
	end
end

function UnitTLInterpreter:act_Reflected(action, args)
	local eft = -args.eft
	local shldVal = args.shldVal
	local dataModel = self._dataModel
	local hp = dataModel:getHp()

	hp = hp + eft

	dataModel:setHp(hp)

	if shldVal then
		self._dataModel:setShield(shldVal)
	end

	if args.eft >= 0 then
		if not args.eft then
			local damage = math.abs(args.eft)

			self._unit:reduceHealth(math.floor(damage), {
				type = "reflect"
			})
		end
	end
end

function UnitTLInterpreter:act_Absorb(action, args)
	local eft = args.eft
	local dataModel = self._dataModel

	dataModel:setHp(dataModel:getHp() + eft)
	self._unit:doAction("Absorb", args)
end

function UnitTLInterpreter:act_Cured(action, args)
	local eft = args.eft
	local dataModel = self._dataModel

	dataModel:setHp(dataModel:getHp() + eft)
	self._unit:doAction(action, args)
end

function UnitTLInterpreter:act_Sync(action, args)
	if self._unitManager:getUnitById(self:getId()) then
		self._dataModel:setRp(args.anger)
	end
end

function UnitTLInterpreter:act_Suicide(action, args)
	self._dataModel:setShield(0)
	self._dataModel:setHp(0)
end

function UnitTLInterpreter:act_KillTarget(action, args)
	self._dataModel:setShield(0)
	self._dataModel:setHp(0)
end

local function endsWith(src, sub)
	local len = string.len(sub)

	return string.sub(src, string.len(src) - len + 1) == sub
end

function UnitTLInterpreter:dealWithBuffEft(eft)
	if not eft then
		return
	end

	for _, detail in ipairs(eft) do
		if detail.evt then
			if endsWith(detail.evt, "Shield") then
				local shield = detail.shield

				self._dataModel:setShield(shield or 0)
			elseif endsWith(detail.evt, "Status") then
				self._dataModel:setStatus(detail.name, detail.count)
			elseif detail.evt == "modifyMaxHp" then
				local maxHp = detail.maxHp
				local hp = detail.hp
				local orgMaxHp = self._dataModel:getOrgMaxHp()

				if self._unit._roleType == RoleType.Master then
					if self._unit:isLeft() then
						if self._battleUIMediator._leftHeadWidget then
							if maxHp < orgMaxHp then
								self._battleUIMediator._leftHeadWidget:modifyMaxHp(maxHp, orgMaxHp)
							else
								self._battleUIMediator._leftHeadWidget:modifyMaxHp(maxHp, maxHp)
							end
						end
					elseif self._battleUIMediator._rightHeadWidget then
						if maxHp < orgMaxHp then
							self._battleUIMediator._rightHeadWidget:modifyMaxHp(maxHp, orgMaxHp)
						else
							self._battleUIMediator._rightHeadWidget:modifyMaxHp(maxHp, maxHp)
						end
					end
				end

				if maxHp < orgMaxHp then
					self._unit:modifyMaxHp(orgMaxHp, maxHp)
				else
					self._unit:modifyMaxHp(maxHp, maxHp)
				end

				self._dataModel:updateMaxHp(maxHp, hp)
			end
		end

		if detail.specialevt == "HolyHide" then
			self._unit:holyHide(detail.alpha or 1)
		end
	end
end

function UnitTLInterpreter:act_AddBuff(action, args)
	self:dealWithBuffEft(args.eft)
	self._unit:addBuff(args)
end

function UnitTLInterpreter:act_RmBuff(action, args)
	self:dealWithBuffEft(args and args.eft)
	self._unit:removeBuff(args)
end

function UnitTLInterpreter:act_TickBuff(action, args)
	self._unit:tickBuff(args)
end

function UnitTLInterpreter:act_StackBuff(action, args)
	self:dealWithBuffEft(args.eft)
	self._unit:stackBuff(args)
end

function UnitTLInterpreter:act_RmBuffs(action, args)
	local unit = self._unit

	for i, param in pairs(args) do
		self:dealWithBuffEft(param and param.eft)
		unit:removeBuff(param)
	end
end

function UnitTLInterpreter:act_ClrBuff(action, args)
	self:dealWithBuffEft(args and args.eft)
	self._unit:removeBuff(args)
end

function UnitTLInterpreter:act_BrkBuff(action, args)
	self:dealWithBuffEft(args and args.eft)
	self._unit:removeBuff(args)
end

function UnitTLInterpreter:act_Focus(action, args, mode)
	local act = args.act
	local dst = args.dst

	if not args.scale then
		if not args.dur then
			local skillAction = self._context:getSkillAction(act)

			if skillAction and skillAction:isInSupering() and dst then
				-- block empty
			end
		end
	end
end

function UnitTLInterpreter:act_FocusCamera(action, args, mode)
	local act = args.act
	local dst = args.dst

	if not args.scale then
		if not args.dur then
			local dur = 200
			local heightOffset = 50
			local skillAction = self._context:getSkillAction(act)

			if skillAction and skillAction:isInSupering() and dst then
				local zone = dst[1]

				if self._unit:isTeamFlipped() then
					zone = -zone
				end

				local targetPos = self._battleGround:relPosWithZoneAndOffset(zone, dst[2], dst[3])
				local point = self._battleGround:convertRelPos2WorldSpace(targetPos)
				local camera = self._context:getValue("Camera")

				self._context:setValue("CameraActId", act)
				camera:focusOn(point.x, point.y + heightOffset, args.scale, dur / 1000)
			end
		end
	end
end

function UnitTLInterpreter:act_GroundEft(action, args, mode)
	local act = args.act
	local id = args.id
	local inSupering = args.inSupering
	local config = ConfigReader:getRecordById("BattleGroundEffect", tostring(id))
	local skillAction = self._context:getSkillAction(act)

	if config and (skillAction and skillAction:isInSupering() or inSupering == false) then
		local mainMediator = self._context:getValue("BattleMainMediator")
		local extra
		local blackOpacity = config.Black

		mainMediator:playGroundEffect(config.Path, {}, config.Anim, config.Zoom, act, (config.Order and config.Order > 0 or nil) and {
			opacity = 255,
			zorder = config.Order,
			duration = args.duration,
			unit = self._unit,
			Music = config.Music
		}, blackOpacity)
	end
end

function UnitTLInterpreter:act_Speak(action, args)
	local params = {}

	table.deepcopy(args, params)

	params.type = "Speak"

	if params.delay then
		params.delay = params.delay / 1000 or 0
	end

	self._bubbles[#self._bubbles + 1] = params

	self:checkBubbleTask()
end

function UnitTLInterpreter:act_Emote(action, args)
	local params = {}

	table.deepcopy(args, params)

	params.type = "Emote"

	if params.delay then
		params.delay = params.delay / 1000 or 0
	end

	self._bubbles[#self._bubbles + 1] = params

	self:checkBubbleTask()
end

function UnitTLInterpreter:act_HarmTargetView(action, args, mode)
	local act = args.act
	local targets = args and args.targets
	local skillAction = self._context:getSkillAction(act)
	local isPerforming = act == self._dataModel:getPerformAct()

	if isPerforming and targets and #targets > 0 and skillAction and skillAction:isInSupering() then
		self._battleGround:showTarget(targets, act)
	end
end

function UnitTLInterpreter:act_HealTargetView(action, args, mode)
	local act = args.act
	local targets = args and args.targets
	local skillAction = self._context:getSkillAction(act)
	local isPerforming = act == self._dataModel:getPerformAct()

	if isPerforming and targets and #targets > 0 and skillAction and skillAction:isInSupering() then
		self._battleGround:showTarget(targets, act, true)
	end
end

function UnitTLInterpreter:act_CancelTargetView(action, args, mode)
	self._battleGround:cancelTarget(args.act)
end

function UnitTLInterpreter:act_SetOpacity(action, args, mode)
	self._unit:hideRole(args.value)
end

function UnitTLInterpreter:act_Die(action, args)
	if self._bubbleTask then
		self._bubbleTask:stop()

		self._bubbleTask = nil
	end

	local performAct = self._dataModel:getPerformAct()

	if performAct then
		local skillAction = self._context:getSkillAction(performAct)

		if skillAction then
			local targets = skillAction:getTargets()

			for roleId, flags in pairs(targets) do
				local role = self._unitManager:getUnitById(roleId)

				if role then
					role:subActivateNums(performAct)
				end
			end

			skillAction:clearTargets()
		end
	end

	if self._unit._roleType == RoleType.Master and not self._unit:isLeft() and self._changeWidget then
		self._changeWidget:addChangeNum(1)
	end

	self._unit:doAction(action, args)

	if self._heroHeadWidget and self._heroHeadWidget.unitDie then
		self._heroHeadWidget:unitDie(self._id)
	end
end

function UnitTLInterpreter:act_Kick(action, args)
	local performAct = self._dataModel:getPerformAct()

	if performAct then
		local skillAction = self._context:getSkillAction(performAct)

		if skillAction then
			local targets = skillAction:getTargets()

			for roleId, flags in pairs(targets) do
				local role = self._unitManager:getUnitById(roleId)

				if role then
					role:subActivateNums(performAct)
				end
			end

			skillAction:clearTargets()
		end
	end

	self._unit:doAction(action, args)

	if self._heroHeadWidget and self._heroHeadWidget.unitDie then
		self._heroHeadWidget:unitDie(self._id)
	end
end

function UnitTLInterpreter:act_Clear(action, args)
	self._unit:doAction(action, args)
end

function UnitTLInterpreter:act_Reborn(action, args)
	self._dataModel:setHp(args.hp)
	self._unit:doReborn(args)
end

function UnitTLInterpreter:act_CancelUnique(action, args, mode)
	local anger = args.anger

	if self._masterWidget then
		self._masterWidget:cancelExecute(anger)
	end
end

function UnitTLInterpreter:onUnitDie(evt)
	local data = evt:getData()
	local roleId = data.id

	if roleId ~= self:getId() then
		return
	end

	local performAct = self._dataModel:getPerformAct()

	if performAct then
		local skillAction = self._context:getSkillAction(performAct)

		if not skillAction then
			return
		end

		local behaviorNode = skillAction:getBehaviorNode()

		if behaviorNode and behaviorNode:isRunning() then
			behaviorNode:abort()
			self._unit:setBusyState(false)
			self._unit:clearSkillEffect(performAct)
			self._unit:clearSkillMovie(actId)
		end
	end
end

function UnitTLInterpreter:checkBubbleTask()
	if self._bubbleTask then
		return
	end

	local scheduler = self._context:getScalableScheduler()

	self._bubbleTask = scheduler:schedule(function(task, dt)
		if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(self._unit) then
			task:stop()

			self._bubbles = {}
			self._bubbleTask = nil

			return
		end

		local bubbleCnt = #self._bubbles

		for i = bubbleCnt, 1, -1 do
			local params = self._bubbles[i]

			if type(params.delay) == "number" then
				params.delay = params.delay - dt

				if params.delay <= 0 then
					params.delay = nil

					if params.type == "Speak" then
						self._unit:speakBubble(params)
					elseif params.type == "Emote" then
						self._unit:emoteBubble(params)
					end

					table.remove(self._bubbles, i)
				end
			else
				table.remove(self._bubbles, i)
			end
		end

		if #self._bubbles == 0 then
			task:stop()

			self._bubbleTask = nil
		end
	end)
end

function UnitTLInterpreter:resetTargetState(actId)
	local skillAction = self._context:getSkillAction(actId)

	if skillAction == nil then
		return
	end

	local targets = skillAction:getTargets()

	for roleId, _ in pairs(targets) do
		local role = self._unitManager:getUnitById(roleId)

		role:tryResetState()
	end
end

function UnitTLInterpreter:act_AddEffect(action, args)
	local roleModel = self._unit:getRoleAnim()
	local parent = roleModel:getParent()
	local effectAnim = cc.MovieClip:create(args.animName)
	local zorder = roleModel:getLocalZOrder()

	effectAnim:addTo(parent, (args.zorder == "behind" or nil) and roleModel:getLocalZOrder() - 1):posite(roleModel:getPositionX(), roleModel:getPositionY()):setName(args.name)

	if args.offset then
		effectAnim:setPosition(args.offset)
	end

	if args.scaleX then
		effectAnim:setScaleX(args.scaleX)
	end

	if args.time == 1 then
		effectAnim:addEndCallback(function(fid, mc)
			effectAnim:stop()
			effectAnim:removeFromParent(true)
		end)
	end
end

function UnitTLInterpreter:act_RmEffect(action, args)
	local roleModel = self._unit:getRoleAnim()
	local parent = roleModel:getParent()
	local effectAnim = parent:getChildByName(args.name)

	if effectAnim then
		effectAnim:removeFromParent(true)
	end
end

function UnitTLInterpreter:act_Sound(action, args)
	local file = args.file
	local rate = args.rate

	if self._unit then
		self._unit:playSound(file, rate)
	end
end

function UnitTLInterpreter:act_AnimForTrgt(action, args)
	local targetId = args.trgt
	local pos = args.pos
	local layer = args.layer
	local loop = args.loop
	local mcFile = args.anim
	local point = cc.p(pos[1], pos[2])
	local target = self._unitManager:getUnitById(targetId)

	if target then
		target:addSolidEffect(mcFile, loop, point, layer, 2)
	end
end

function UnitTLInterpreter:act_AddAnim(action, args)
	local pos = args.pos
	local anim = args.anim
	local loop = args.loop
	local zOrder = args.zOrder

	if self._unit then
		local zone = pos[1]

		zone = not not (self._mainPlayerSide and zone > 0 or not self._mainPlayerSide and zone < 0) and math.abs(zone) or -math.abs(zone)

		local realPos = self._battleGround:relPosWithZoneAndOffset(zone, pos[2], pos[3])
		local targetPos = self._battleGround:convertRelPos2WorldSpace(realPos)
		local mainMediator = self._context:getValue("BattleMainMediator")

		if mainMediator.addEffectAnim then
			mainMediator:addEffectAnim(anim, targetPos, zOrder, loop, flip)
		end
	end
end

function UnitTLInterpreter:act_AddAnimWithFlip(action, args)
	local pos = args.pos
	local anim = args.anim
	local loop = args.loop
	local zOrder = args.zOrder
	local isflipX = args.isFlipX
	local isflipY = args.isFlipY

	if self._unit then
		local zone = pos[1]
		local isLeft = true

		isLeft = not not (self._mainPlayerSide and zone > 0 or not self._mainPlayerSide and zone < 0)
		zone = isLeft and math.abs(zone) or -math.abs(zone)

		local _isflipX = not isLeft

		if isflipX then
			_isflipX = not _isflipX
		end

		local realPos = self._battleGround:relPosWithZoneAndOffset(zone, pos[2], pos[3])
		local targetPos = self._battleGround:convertRelPos2WorldSpace(realPos)
		local mainMediator = self._context:getValue("BattleMainMediator")

		if mainMediator.addEffectAnim then
			mainMediator:addEffectAnim(anim, targetPos, zOrder, loop, _isflipX, isflipY)
		end
	end
end

function UnitTLInterpreter:act_TruthBubble(action, args)
	local seed = args.seed

	self._tbRandomizer = Random:new(seed)

	local truthBubbles = self._dataModel:getModelConfig().TruthBubble

	if truthBubbles and #truthBubbles > 0 then
		local params = {
			style = "",
			delay = 1200,
			stmts = {
				{
					truthBubbles[self._tbRandomizer:random(#truthBubbles)],
					3000
				}
			}
		}

		params.type = "Speak"

		if params.delay then
			params.delay = params.delay / 1000 or 0
		end

		self._bubbles[#self._bubbles + 1] = params

		self:checkBubbleTask()
	end
end

function UnitTLInterpreter:act_HolyHide(action, args)
	self._unit:holyHide(args.alpha)
end

function UnitTLInterpreter:act_FanUpdate(action, args)
	self._unit:updateFanBar(args.progress)
end

function UnitTLInterpreter:act_CancelSpecificSkill(action, args)
	return
end

function UnitTLInterpreter:act_ThrownKick(action, args)
	local performAct = self._dataModel:getPerformAct()

	if performAct then
		local skillAction = self._context:getSkillAction(performAct)

		if skillAction then
			local targets = skillAction:getTargets()

			for roleId, flags in pairs(targets) do
				local role = self._unitManager:getUnitById(roleId)

				if role then
					role:subActivateNums(performAct)
				end
			end

			skillAction:clearTargets()
		end
	end

	self._unit:doAction(action, args)

	if self._heroHeadWidget and self._heroHeadWidget.unitDie then
		self._heroHeadWidget:unitDie(self._id)
	end
end

function UnitTLInterpreter:act_GuideDie(action, args)
	self._unit:switchState("fakedie")
end

function UnitTLInterpreter:act_GuideThrown(action, args)
	self._unit:guideThrown(args)
	self._unit:setBarAndBuffVisble(false)
end

function UnitTLInterpreter:act_GuideGoBack(action, args)
	args = args or {}

	if not args[1] then
		local num1 = 1

		if not args[2] then
			local num2 = 5

			if not args[3] then
				local num3 = 2

				if not args[4] then
					local dur = 1000
					local pos = self._battleGround:relPosWithZoneAndOffset(num1, num2, num3)

					self._unit:setRelPosition(pos)
					self._unit:forceGoBack(dur)
					self._unit:setBarAndBuffVisble(true)
				end
			end
		end
	end
end

function UnitTLInterpreter:act_GuideGoOutScreen(action, args)
	args = args or {}

	if not args[1] then
		local num1 = 1

		if not args[2] then
			local num2 = 5

			if not args[3] then
				local num3 = 2

				if not args[4] then
					local dur = 1000

					if not args[5] then
						local posX = 0

						if not args[6] then
							local posY = 0
							local pos = self._battleGround:relPosWithZoneAndOffset(num1, num2, num3)

							self._unit:setRelPosition(pos)
							self._unit:forceGoOutScreen(dur, posX, posY)
						end
					end
				end
			end
		end
	end
end

function UnitTLInterpreter:act_GuideResume(action, args)
	self._unit._roleAnim:resumeAnimation()
	self._unit:switchState("stand")
end

function UnitTLInterpreter:act_GuideMoveBy(action, args)
	self._unit:guideMoveBy(args)
	self._unit:setBarAndBuffVisble(false)
end

function UnitTLInterpreter:act_SetHSVColor(action, args)
	if not args.hue then
		if not args.contrast then
			local contrast = 0

			if not args.brightness then
				local brightness = 0

				if not args.saturation then
					local saturation = 0

					self._unit:setHSVColor(args.hue, contrast, brightness, saturation)
				end
			end
		end
	end
end

function UnitTLInterpreter:act_ShowAtkAndDef(action, args)
	if not args.detail.atk then
		if not args.detail.def then
			local def = 0

			if not args.detail.hurtrate then
				local hurtrate = 0

				if not args.detail.unhurtrate then
					local unhurtrate = 0

					self._unit:showAtkAndDef(args.detail.atk, def, hurtrate, unhurtrate)
				end
			end
		end
	end
end

function UnitTLInterpreter:act_Emoji(action, args)
	self._unit:RtpkEmoji(args)
end

function UnitTLInterpreter:act_SetRootVisible(action, args)
	local isVisible = args.isVisible

	self._unit:setRootVisible(isVisible)
end

function UnitTLInterpreter:act_SetRoleScale(action, args)
	local scale = args.scale

	self._unit:setRoleScale(scale)
end

function UnitTLInterpreter:act_Transfigure(action, args)
	local roleDataModel = self._dataModel

	roleDataModel:setHp(args.hp)
	roleDataModel:setRp(args.anger)
	roleDataModel:setMaxHp(args.maxHp)
	roleDataModel:setMaxRp(args.maxAnger)
	roleDataModel:setStar(args.star)
	roleDataModel:setModelId(args.model)
	roleDataModel:setFlags(args.flags)
	self._unit:onTransShap()
	self._unit:goBack()
end
