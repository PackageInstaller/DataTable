-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godlongyan/model/GodLongYanModel.lua

module("logic.extensions.godlongyan.model.GodLongYanModel", package.seeall)

local GodLongYanModel = class("GodLongYanModel", BaseModel)

function GodLongYanModel:ctor()
	return
end

function GodLongYanModel:onInit()
	self:onReset()
end

function GodLongYanModel:onReset()
	self._challengeId = 38
	self._buffLv = {}
	self._curStage = 0
	self._gameHasPlayTimes = 0
	self._cutFruitDataMo = nil
	self._clientKey = 0
	self._serverKey = 0
	self._encryptedKey = 0
	self._oneKeyChangeSetId = nil
	self._isShowLevelTip = nil
end

function GodLongYanModel:getChallengeId()
	return self._challengeId
end

function GodLongYanModel:getPlanId()
	local cfg = GodLongYanConfig.instance:getGlyData(self._challengeId)

	return (cfg or nil) and (cfg.buffPlan or 0)
end

function GodLongYanModel:getCoinStr()
	local cfg = GodLongYanConfig.instance:getGlyData(self._challengeId)

	return (cfg or nil) and (cfg.consume or "")
end

function GodLongYanModel:onHandleGodLongYanChallengeGetInfoRes(msg)
	self._buffLv = msg.buffLv
	self._curStage = msg.curStage
	self._gameHasPlayTimes = msg.gameHasPlayTimes
end

function GodLongYanModel:onHandleGodLongYanChallengeUpgradeBuffRes(msg)
	local type = msg.buffType

	self._buffLv[type] = msg.buffLv
end

function GodLongYanModel:onHandleGodLongYanChallengeFightRes(msg)
	return
end

function GodLongYanModel:onHandleGodLongYanChallengeStartGameRes(msg)
	self._clientKey = msg.clientKey
	self._serverKey = msg.serverKey
end

function GodLongYanModel:onHandleGodLongYanChallengeEndGameRes(msg)
	return
end

function GodLongYanModel:onHandleGodLongYanChallengeFinishRes(msg)
	self._curStage = msg.curStage
end

function GodLongYanModel:onGodLongYanChallengeOneKeyPassRes(msg)
	self._curStage = msg.curStage
	self._oneKeyChangeSetId = msg.changeSetId
end

function GodLongYanModel:onChallengeResetBuffRes(msg)
	self._buffLv[msg.buffType] = 0
end

function GodLongYanModel:getGameHasPlayTimes()
	return self._gameHasPlayTimes
end

function GodLongYanModel:getAllBuffLvlList()
	return self._buffLv
end

function GodLongYanModel:getBuffLvl(buffType)
	if self._buffLv[buffType] then
		return self._buffLv[buffType]
	end

	return 0
end

function GodLongYanModel:getHasPalyGameTimes()
	return self._gameHasPlayTimes
end

function GodLongYanModel:getCurStage()
	return self._curStage
end

function GodLongYanModel:isCurStagePass(stage)
	return stage <= self._curStage
end

function GodLongYanModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = GodLongYanCustomFmtMo.New()
	end

	return self._customFmtMo
end

function GodLongYanModel:getOneKeyChangeSetId()
	return self._oneKeyChangeSetId
end

function GodLongYanModel:isBuffCanUpgrade(buffType)
	if buffType <= 0 then
		return false
	end

	local planId = self:getPlanId()
	local maxLvl = GodLongYanConfig.instance:getBuffMaxLvl(planId, checknumber(buffType))

	maxLvl = math.max(1, maxLvl)

	local curLvl = self:getBuffLvl(buffType)

	if maxLvl <= curLvl then
		return false
	end

	local curItemCount = MaterialMgr.getMatCount(self:getCoinStr())
	local cfg = GodLongYanConfig.instance:getBuffByIdAndLvl(planId, buffType, curLvl + 1)

	if curItemCount < ((cfg or nil) and cfg.upgradeCostNum) then
		return false
	end

	return true
end

function GodLongYanModel:isAnyBuffCanUpgrade()
	local planId = self:getPlanId()
	local cfgList = GodLongYanConfig.instance:getBuffListByPlanId(planId)

	for buffType, v in ipairs(cfgList) do
		if self:isBuffCanUpgrade(buffType) then
			return true
		end
	end

	return false
end

function GodLongYanModel:getCurStageIdx()
	return self:getGameHasPlayTimes() + 1
end

function GodLongYanModel:getGameScore()
	return self:getCutFruitDataMo():getStageScore()
end

function GodLongYanModel:getCutFruitDataMo()
	self._cutFruitDataMo = self._cutFruitDataMo or CutFruitDataMo.New()

	return self._cutFruitDataMo
end

function GodLongYanModel:clearCutFruitDataMo()
	self._cutFruitDataMo = nil
end

function GodLongYanModel:getEncryptedKey()
	return GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, {
		self:getGameScore()
	})
end

function GodLongYanModel:setShowLevelTip()
	self._isShowLevelTip = true
end

function GodLongYanModel:getIsShowLevelTip()
	self._isShowLevelTip = nil

	return self._isShowLevelTip
end

GodLongYanModel.instance = GodLongYanModel.New()

return GodLongYanModel
