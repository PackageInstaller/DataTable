-- chunkname: @modules/logic/survival/model/map/SurvivalMapModel.lua

module("modules.logic.survival.model.map.SurvivalMapModel", package.seeall)

local SurvivalMapModel = class("SurvivalMapModel", BaseModel)

function SurvivalMapModel:onInit()
	self.showToastList = {}
	self._targetPos = nil
	self._showTargetPos = nil
	self._sceneMo = nil
	self.curUseItem = nil
	self.result = SurvivalEnum.MapResult.None
	self.showCostTime = 0
	self.itemConvertInfosList = {}
	self.resultData = SurvivalResultMo.New()
	self._initGroupMo = SurvivalInitGroupModel.New()
	self.isSearchRemove = false
	self.save_mapScale = 1 - (SurvivalConst.MapCameraParams.DefaultDis - SurvivalConst.MapCameraParams.MinDis) / (SurvivalConst.MapCameraParams.MaxDis - SurvivalConst.MapCameraParams.MinDis)
	self.isFightEnter = false
	self.guideSpBlockPos = nil
	self._cacheHexPoints = {}
	self.survivalLeaveMsgViewParam = nil
	self.dayMode = nil
end

function SurvivalMapModel:reInit()
	self:onInit()
end

function SurvivalMapModel:clearItemConvert()
	self.itemConvertInfosList = {}
end

function SurvivalMapModel:getCacheHexNode(index)
	index = index or 1
	self._cacheHexPoints[index] = self._cacheHexPoints[index] or SurvivalHexNode.New()

	return self._cacheHexPoints[index]
end

function SurvivalMapModel:getInitGroup()
	return self._initGroupMo
end

function SurvivalMapModel:getCurMapCo()
	return self._sceneMo.sceneCo
end

function SurvivalMapModel:getCurMapId()
	return self._sceneMo.mapId
end

function SurvivalMapModel:setSceneData(scene)
	self.showToastList = {}
	self._targetPos = nil
	self._showTargetPos = nil
	self.curUseItem = nil
	self.showCostTime = 0
	self.isSearchRemove = false
	self.result = SurvivalEnum.MapResult.None
	self._sceneMo = self._sceneMo or SurvivalSceneMo.New()

	self._sceneMo:init(scene)

	local heroUids = self._sceneMo.teamInfo.heros
	local npcIds = self._sceneMo.teamInfo.npcId
	local str = table.concat(heroUids, "#") .. "|" .. table.concat(npcIds, "#")

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.SurvivalTeamSave, str)
	SurvivalEquipRedDotHelper.instance:checkRed()

	local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo

	survivalShelterRoleMo:clearExpCache()
end

function SurvivalMapModel:getSceneMo()
	return self._sceneMo
end

function SurvivalMapModel:isInFog(node)
	local player = self._sceneMo.player

	return not SurvivalHelper.instance:isHaveNode(player.explored, node)
end

function SurvivalMapModel:addExploredPoint(points)
	if not self._sceneMo then
		return
	end

	local player = self._sceneMo.player

	for i, v in ipairs(points) do
		SurvivalHelper.instance:addNodeToDict(player.explored, v)
	end
end

function SurvivalMapModel:removeExploredPoint(points)
	if not self._sceneMo then
		return
	end

	local player = self._sceneMo.player

	for i, v in ipairs(points) do
		SurvivalHelper.instance:removeNodeToDict(player.explored, v)
	end
end

function SurvivalMapModel:isInFog2(node)
	local player = self._sceneMo.player

	return not SurvivalHelper.instance:isHaveNode(player.canExplored, node)
end

function SurvivalMapModel:addExploredPoint2(points)
	if not self._sceneMo then
		return
	end

	local player = self._sceneMo.player
	local addPoints = {}

	for i, v in ipairs(points) do
		if not SurvivalHelper.instance:isHaveNode(player.canExplored, v) then
			SurvivalHelper.instance:addNodeToDict(player.canExplored, v)
			table.insert(addPoints, v)
		end
	end

	SurvivalMapHelper.instance:updateCloudShow(true, addPoints, true)
end

function SurvivalMapModel:removeExploredPoint2(points)
	if not self._sceneMo then
		return
	end

	local player = self._sceneMo.player
	local removePoints = {}

	for i, v in ipairs(points) do
		if SurvivalHelper.instance:isHaveNode(player.canExplored, v) then
			SurvivalHelper.instance:removeNodeToDict(player.canExplored, v)
			table.insert(removePoints, v)
		end
	end

	SurvivalMapHelper.instance:updateCloudShow(true, removePoints, false)
end

function SurvivalMapModel:isInMiasma()
	if not self._sceneMo then
		return false
	end

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local subType = self._sceneMo:getBlockTypeByPos(self._sceneMo.player.pos)

	return subType == SurvivalEnum.UnitSubType.Miasma and weekInfo:getAttr(SurvivalEnum.AttrType.Vehicle_Miasma) == 0
end

function SurvivalMapModel:setMoveToTarget(targetPos, path)
	self._targetPos = targetPos
	self._targetPath = path
end

function SurvivalMapModel:setShowTarget(targetPos, isDelayHide)
	self._showTargetPos = targetPos

	if not targetPos then
		if isDelayHide then
			SurvivalMapHelper.instance:getScene().path:setDelayHide()
		else
			SurvivalMapHelper.instance:getScene().path:setPathListShow()
		end
	end
end

function SurvivalMapModel:canWalk(isTips)
	if self.result ~= SurvivalEnum.MapResult.None then
		return false
	end

	if self._sceneMo.panel then
		if isTips and ViewHelper.instance:checkViewOnTheTop(ViewName.SurvivalMapMainView, {
			ViewName.SurvivalToastView
		}) then
			self._sceneMo.panel = nil

			logError("当前面板缓存异常，自动清空！！！")

			return true
		end

		return false
	end

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local bagMo = weekInfo:getBag(SurvivalEnum.ItemSource.Map)

	if bagMo.totalMass > bagMo:getMaxWeightLimit() then
		if isTips then
			GameFacade.showToast(ToastEnum.SurvivalNoMoveWeight)
		end

		return false
	end

	return true
end

function SurvivalMapModel:getTargetPos()
	if not self:canWalk() then
		return
	end

	return self._targetPos, self._targetPath
end

function SurvivalMapModel:getShowTargetPos()
	if not self:canWalk() then
		return
	end

	return self._showTargetPos
end

function SurvivalMapModel:getSelectMapId()
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()
	local survivalInitGroupModel = SurvivalMapModel.instance:getInitGroup()
	local mapInfo = weekMo.mapInfos[survivalInitGroupModel.selectMapIndex + 1]

	return mapInfo.mapId
end

function SurvivalMapModel:onUseRoleSkill(info)
	local sceneMo = self:getSceneMo()

	if not sceneMo then
		return
	end

	local skillInfo = sceneMo:getRoleSkillInfo()

	skillInfo:onUseRoleSkill(info)
end

SurvivalMapModel.instance = SurvivalMapModel.New()

return SurvivalMapModel
