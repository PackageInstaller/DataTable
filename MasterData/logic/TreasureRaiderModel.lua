-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/model/TreasureRaiderModel.lua

module("logic.extensions.treasureraider.model.TreasureRaiderModel", package.seeall)

local TreasureRaiderModel = class("TreasureRaiderModel", BaseModel)

function TreasureRaiderModel:ctor()
	self:onReset()
end

function TreasureRaiderModel:onInit()
	self:onReset()
end

function TreasureRaiderModel:onReset()
	self.myPlayerMo = TRMyPlayerMo.New()
	self.mySceneMo = TRSceneMo.New()
	self.curSceneMo = nil
	self.isMoving = false
end

function TreasureRaiderModel:getCurSceneMo()
	if self.curSceneMo then
		return self.curSceneMo
	end

	return self.mySceneMo
end

function TreasureRaiderModel:getMySceneMo()
	return self.mySceneMo
end

function TreasureRaiderModel:clearCurSceneMo()
	self.curSceneMo = nil
end

function TreasureRaiderModel:initCheckProduceTimer()
	self:removeProduceTimer()
	settimer(10, self._checkProduce, self)
end

function TreasureRaiderModel:removeProduceTimer()
	removetimer(self._checkProduce, self)
end

function TreasureRaiderModel:_checkProduce()
	local mo = self:getCurSceneMo()

	if mo then
		mo:_checkProduce()
	end
end

function TreasureRaiderModel:onRichManGetInfoRes(msg)
	self.mySceneMo:updateByServerData(msg, LoginModel.instance.userId)
end

function TreasureRaiderModel:onOpMapGetInfoRes(msg, isRevenge)
	self.myPlayerMo:updateBeforeUpdateOpMapGetInfo(isRevenge)
	self.mySceneMo:setActionDone(true)

	local sceneMo = TRSceneMo.New()

	sceneMo:updateByServerData(msg.target, msg.target.headInfo.userId, isRevenge)

	self.curSceneMo = sceneMo
end

function TreasureRaiderModel:onOpMapGetInfoFail()
	self.mySceneMo:setActionDone(true)
end

function TreasureRaiderModel:onRichManEditMapRes(msg)
	self.myPlayerMo:updateEditMapCount(msg)
end

function TreasureRaiderModel:onRichManWalkRes(msg)
	self.myPlayerMo:updateServerDataAfterMySceneWalk(msg)
	self.mySceneMo:updateMainCampLevel(msg)
	self.mySceneMo:setActionDone(msg.actionDone)
end

function TreasureRaiderModel:onRichManAttackWalkRes(msg, isRandom)
	self:getCurSceneMo():setActionDone(false)
	self:getCurSceneMo().myPlayerMo:updateServerDataAfterOpSceneWalk(msg, isRandom)
end

function TreasureRaiderModel:onRichManActionRes(msg, actionType)
	self.mySceneMo:updateByAction(msg, actionType)
end

function TreasureRaiderModel:onRichManResourcePrizeRes(msg)
	self.mySceneMo:updateBuildingsByReplace(msg.buildingGrids)
end

function TreasureRaiderModel:onRichManAttackSetFormRes(formationData)
	self.myPlayerMo:updatePlayerAttackFormation(formationData)

	if self.curSceneMo then
		self.curSceneMo.myPlayerMo:updatePlayerAttackFormation(formationData)
	end
end

function TreasureRaiderModel:onRichManAttackFightRes(formationData)
	self.myPlayerMo:updatePlayerAttackFormation(formationData)

	if self.curSceneMo then
		self.curSceneMo:setActionDone(true)
	end
end

function TreasureRaiderModel:onNotifyRichManFightResultRes(msg)
	if self.curSceneMo then
		self.curSceneMo:updateOneBuilding(msg.buildingGrid)
		self.curSceneMo.myPlayerMo:updateBuff(msg.extendBuff)
		self.myPlayerMo:updateBuff(msg.extendBuff)
		self.curSceneMo.myPlayerMo:setAttackPrize(msg)
	end
end

TreasureRaiderModel.instance = TreasureRaiderModel.New()

return TreasureRaiderModel
