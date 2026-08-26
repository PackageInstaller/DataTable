-- chunkname: @modules/logic/scene/shelter/entity/SurvivalShelterMonsterEntity.lua

module("modules.logic.scene.shelter.entity.SurvivalShelterMonsterEntity", package.seeall)

local SurvivalShelterMonsterEntity = class("SurvivalShelterMonsterEntity", SurvivalShelterUnitEntity)
local showSuccessTime = 3

function SurvivalShelterMonsterEntity.Create(unitType, unitId, root)
	local needShowFightSuccess = SurvivalShelterModel.instance:getNeedShowFightSuccess()
	local pos, dir = SurvivalMapHelper.instance:getLocalShelterEntityPosAndDir(unitType, unitId)

	if needShowFightSuccess then
		local playerMo = SurvivalShelterModel.instance:getPlayerMo()

		pos = playerMo.pos
	end

	if not pos then
		logError(string.format("not find shelterFight random pos, shelterFightId:%s", unitId))

		return
	end

	local go = gohelper.create3d(root, string.format("shelterFightId_%s%s", unitId, tostring(pos)))
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(pos.q, pos.r)
	local rootTrans = go.transform

	transformhelper.setLocalPos(rootTrans, x, y, z)
	transformhelper.setLocalRotation(rootTrans, 0, dir * 60, 0)

	local param = {
		unitType = unitType,
		unitId = unitId,
		pos = pos,
		dir = dir
	}

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalShelterMonsterEntity, param)
end

function SurvivalShelterMonsterEntity:onCtor(param)
	self.pos = param.pos
	self.dir = param.dir
	self.ponitRange = {}

	SurvivalHelper.instance:addNodeToDict(self.ponitRange, self.pos)

	local fightConfig = lua_survival_shelter_intrude_fight.configDict[self.unitId]

	if fightConfig and fightConfig.gridType == SurvivalEnum.ShelterGridType.Triangle then
		local dir2 = (self.dir + 1) % 6
		local dir3 = (self.dir + 2) % 6
		local point1 = self.pos + SurvivalEnum.DirToPos[dir2]
		local point2 = self.pos + SurvivalEnum.DirToPos[dir3]

		SurvivalHelper.instance:addNodeToDict(self.ponitRange, point1)
		SurvivalHelper.instance:addNodeToDict(self.ponitRange, point2)
	end
end

function SurvivalShelterMonsterEntity:onStart()
	self.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
end

function SurvivalShelterMonsterEntity:onInit()
	self:showModel()
end

function SurvivalShelterMonsterEntity:showModel()
	if not gohelper.isNil(self.goModel) then
		return
	end

	if self._loader then
		return
	end

	self._loader = PrefabInstantiate.Create(self.go)

	local path = self:getResPath()

	if string.nilorempty(path) then
		return
	end

	self._loader:startLoad(path, self._onResLoadEnd, self)
end

function SurvivalShelterMonsterEntity:getResPath()
	local fightConfig = lua_survival_shelter_intrude_fight.configDict[self.unitId]

	if not fightConfig then
		return nil
	end

	return fightConfig.model
end

function SurvivalShelterMonsterEntity:getScale()
	local fightConfig = lua_survival_shelter_intrude_fight.configDict[self.unitId]

	if fightConfig then
		if not (fightConfig.scale * 0.01) then
			return 1
		end
	end
end

function SurvivalShelterMonsterEntity:_onResLoadEnd()
	local go = self._loader:getInstGO()
	local trans = go.transform

	self.goModel = go

	local scale = self:getScale()

	transformhelper.setLocalScale(trans, scale, scale, scale)
	gohelper.addChild(self.trans.parent.gameObject, self.goModel)

	local x, y, z = self:getCenterPos()

	transformhelper.setLocalPos(trans, x, y, z)
	gohelper.addChildPosStay(self.go, self.goModel)
	transformhelper.setLocalRotation(trans, 0, 0, 0)
	self:onLoadedEnd()
end

function SurvivalShelterMonsterEntity:needUI()
	return true
end

function SurvivalShelterMonsterEntity:getCenterPos()
	local ponitRange = self.ponitRange
	local sumX, sumY, sumZ = 0, 0, 0
	local count = 0

	for q, vv in pairs(ponitRange) do
		for r, ponit in pairs(vv) do
			local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(ponit.q, ponit.r)

			sumX = sumX + x
			sumY = sumY + y
			sumZ = sumZ + z
			count = count + 1
		end
	end

	if count > 0 then
		local averageX = sumX / count
		local averageY = sumY / count
		local averageZ = sumZ / count

		return averageX, averageY, averageZ
	end

	return 0, 0, 0
end

function SurvivalShelterMonsterEntity:checkClick(hexPoint)
	return SurvivalHelper.instance:getValueFromDict(self.ponitRange, hexPoint)
end

function SurvivalShelterMonsterEntity:isInPlayerPos()
	local scene = SurvivalMapHelper.instance:getScene()

	if not scene then
		return false
	end

	local player = scene.unit:getPlayer()

	return player:isInPosList(self.ponitRange)
end

function SurvivalShelterMonsterEntity:showEffect()
	if gohelper.isNil(self._effectRoot) then
		self._effectRoot = gohelper.create3d(self.trans.gameObject, "EffectRoot")

		gohelper.setActive(self._effectRoot, false)
	end

	if not gohelper.isNil(self.monsterEffect) then
		return
	end

	local scene = SurvivalMapHelper.instance:getScene()

	if SurvivalController.instance.isOldSettle then
		local needShowFightSuccess = SurvivalShelterModel.instance:getNeedShowFightSuccess()

		self.monsterEffect = needShowFightSuccess and scene.preloader:getMonsterFightSuccessPath(self._effectRoot) or scene.preloader:getMonsterEffect(self._effectRoot)

		if gohelper.isNil(self.monsterEffect) then
			return
		end

		local tr = self.monsterEffect.transform
		local scale = self:getScale()

		transformhelper.setLocalScale(tr, scale, scale, scale)

		local needShowFightSuccess = SurvivalShelterModel.instance:getNeedShowFightSuccess()

		if needShowFightSuccess then
			transformhelper.setLocalPos(tr, 0, -0.35, 0)
			AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_fight)
			TaskDispatcher.runDelay(self._showSuccessFinish, self, showSuccessTime)
		end
	else
		self.monsterEffect = scene.preloader:getMonsterEffect(self._effectRoot)

		if not gohelper.isNil(self.monsterEffect) then
			local tr = self.monsterEffect.transform
			local scale = self:getScale()

			transformhelper.setLocalScale(tr, scale, scale, scale)
		end
	end
end

function SurvivalShelterMonsterEntity:playFightEffect()
	if self.monsterEffect then
		gohelper.setActive(self.monsterEffect, false)
	end

	local scene = SurvivalMapHelper.instance:getScene()

	self.monsterFightEffect = scene.preloader:getMonsterFightSuccessPath(self._effectRoot)

	if not gohelper.isNil(self.monsterEffect) then
		local tr = self.monsterFightEffect.transform
		local scale = self:getScale()

		transformhelper.setLocalScale(tr, scale, scale, scale)
		transformhelper.setLocalPos(tr, 0, -0.35, 0)
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_fight)
	end
end

function SurvivalShelterMonsterEntity:_showSuccessFinish()
	SurvivalModel.instance:addDebugSettleStr("_showSuccessFinish")
	SurvivalShelterModel.instance:setNeedShowFightSuccess(false, nil)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.BossFightSuccessShowFinish)
end

function SurvivalShelterMonsterEntity:onDestroy()
	TaskDispatcher.cancelTask(self._showSuccessFinish, self)
	SurvivalShelterMonsterEntity.super.onDestroy(self)
end

function SurvivalShelterMonsterEntity:addEventListeners()
	return
end

function SurvivalShelterMonsterEntity:removeEventListeners()
	return
end

function SurvivalShelterMonsterEntity:_onDecreeVoteStart()
	self:setVisible(false)
end

function SurvivalShelterMonsterEntity:_onDecreeVoteEnd()
	self:setVisible(true)
end

return SurvivalShelterMonsterEntity
