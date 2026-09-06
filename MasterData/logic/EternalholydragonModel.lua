-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalholydragon/model/EternalholydragonModel.lua

module("logic.extensions.eternalholydragon.view.EternalholydragonModel", package.seeall)

local EternalholydragonModel = class("EternalholydragonModel", BaseModel)

function EternalholydragonModel:ctor()
	return
end

function EternalholydragonModel:onInit()
	self:onReset()
end

function EternalholydragonModel:onReset()
	self._activityId = 0
	self._info = nil
	self._riverCustomFmtMo = nil
	self._landCustomFmtMo = nil
	self._ownedItem = {}
	self._gridinfo = {}
	self._petInfo_id2hp = {}
end

function EternalholydragonModel:setActivityId(activityId)
	self._activityId = activityId
end

function EternalholydragonModel:getActivityId()
	return self._activityId
end

function EternalholydragonModel:setInfo(msg)
	self._info = msg
	self._ownedItem = {}
	self._gridinfo = {}
	self._petInfo_id2hp = {}

	self:_addOwnedItem(msg.ownedItem)
	self:_initGridInfo(msg.gridInfo)
	self:_addPetInfo(msg.petInfo)
end

function EternalholydragonModel:getInfo()
	return self._info
end

function EternalholydragonModel:getOwnedItem()
	return self._ownedItem
end

function EternalholydragonModel:_addOwnedItem(pbMsg)
	if not pbMsg then
		return
	end

	local t = GameUtil.pbToTable(pbMsg) or {}

	for i, v in ipairs(t) do
		table.insert(self._ownedItem, v)
	end
end

function EternalholydragonModel:_initGridInfo(gridInfo)
	self._gridinfo = GameUtil.pbToTable(gridInfo) or {}
end

function EternalholydragonModel:_addPetInfo(petInfo)
	for i, v in ipairs(petInfo) do
		self._petInfo_id2hp[v.id] = v
	end
end

function EternalholydragonModel:_updateGridInfo(gridInfo)
	local isFind = false

	for i, v in ipairs(self._gridinfo) do
		if v.pos.x == gridInfo.pos.x and v.pos.y == gridInfo.pos.y then
			v.gridElementType = gridInfo.gridElementType
			v.gridElementParams = gridInfo.gridElementParams
			isFind = true

			break
		end
	end

	if not isFind then
		local t = GameUtil.pbToTable(gridInfo)

		table.insert(self._gridinfo, t)
	end
end

function EternalholydragonModel:getGridInfos()
	return self._gridinfo
end

function EternalholydragonModel:getRiverCustomFmtMo()
	self._riverCustomFmtMo = self._riverCustomFmtMo or EternalholydragonRiverCustomMo.New()

	return self._riverCustomFmtMo
end

function EternalholydragonModel:getLandCustomFmtMo()
	self._landCustomFmtMo = self._landCustomFmtMo or TraincampMissionCustomFmtMo.New()

	return self._landCustomFmtMo
end

function EternalholydragonModel:dragonClgForward(targetPos)
	self._info.pos.x = targetPos.x
	self._info.pos.y = targetPos.y
end

function EternalholydragonModel:getPetInfos()
	return self._petInfo_id2hp
end

function EternalholydragonModel:getPetInfo(petId)
	return self._petInfo_id2hp[petId]
end

function EternalholydragonModel:onNotifyFightRiverMonsterRes(msg)
	if msg.win then
		self._info.pos.x = msg.monsterPos.x
		self._info.pos.y = msg.monsterPos.y

		self:_updateGridInfo(msg.gridInfo)
		self:_addOwnedItem(msg.newGainedItem)
		self:_addPetInfo(msg.petInfo)

		if msg.passStage then
			self._ownedItem = {}
			self._petInfo_id2hp = {}
			self._gridinfo = {}
			self._info.clgProgress = self._info.clgProgress + 1

			local stageCfg = EternalholydragonConfig.instance:getStageCfg(msg.activityId, self._info.clgProgress + 1)

			if stageCfg then
				local mapCfgs = EternalholydragonConfig.instance:getMapCfgs(stageCfg.mapId)
				local r, c = EternalholydragonController.instance:getStartPos(mapCfgs)

				self._info.pos.x = r
				self._info.pos.y = c
			else
				UIJumper.instance:removeTopState(ViewName.EternalholydragongameView)

				local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(msg.activityId)

				if isAoqiGodProcessType then
					local info = EternalholydragonModel.instance:getInfo()
					local cfgs = EternalholydragonConfig.instance:getStageCfgs(info.activityId)

					if info.clgProgress + 1 > #cfgs then
						AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.EHolyDragon, msg.activityId)
					end
				end
			end
		end
	end
end

function EternalholydragonModel:onNotifyFightLandMonsterRes(msg)
	if msg.win then
		self:_updateGridInfo(msg.gridInfo)
		self:_addOwnedItem(msg.newGainedItem)
		self:_addPetInfo(msg.petInfo)
	end
end

function EternalholydragonModel:onResetStageRes(msg)
	self._petInfo_id2hp = {}
	self._gridinfo = {}
	self._ownedItem = {}
	self._info.pos.x = msg.pos.x
	self._info.pos.y = msg.pos.y
	self._info.clgProgress = msg.clgProgress
end

function EternalholydragonModel:onUseItemOnLandRes(msg)
	self._ownedItem = {}

	self:_addOwnedItem(msg.ownedItem)
	self:_updateGridInfo(msg.gridInfo)
end

EternalholydragonModel.instance = EternalholydragonModel.New()

return EternalholydragonModel
