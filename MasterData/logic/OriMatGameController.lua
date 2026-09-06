-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/controller/OriMatGameController.lua

module("logic.extensions.orimatgame.controller.OriMatGameController", package.seeall)

local OriMatGameController = class("OriMatGameController", BaseController)

function OriMatGameController:onInit()
	self:onReset()
end

function OriMatGameController:onReset()
	self._isInGame = false
end

function OriMatGameController:showCI()
	return
end

function OriMatGameController:loadOrimatGame()
	OriMatGameController.instance:sendPM_OriginMaterialGameAllSeasonReq()
end

function OriMatGameController:sendPM_OriginMaterialGameInfoReq(seasonId)
	OriMatGameAgent.instance:sendPM_OriginMaterialGameInfoReq(seasonId)
end

function OriMatGameController:handlePM_OriginMaterialGameInfoRes(msg)
	local seasonId = msg.seasonId
	local subMo = self:getSubMo(seasonId)

	subMo:handlePM_OriginMaterialGameInfoRes(msg)
	self:_updateSeasonPrizeRedPoint(seasonId)
	self:_updateTalentTreeRedPoint(seasonId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginMaterialGameInfoRes)
end

function OriMatGameController:sendPM_OriginMaterialGameStartReq(seasonId, stageId)
	local subMo = self:getSubMo(seasonId)
	local clientKey = subMo:generateClientKey()

	OriMatGameAgent.instance:sendPM_OriginMaterialGameStartReq(seasonId, stageId, clientKey)
end

function OriMatGameController:handlePM_OriginMaterialGameStartRes(status, msg)
	if status == 0 then
		local seasonId = msg.seasonId
		local subMo = self:getSubMo(seasonId)

		subMo:handlePM_OriginMaterialGameStartRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginMaterialGameStartRes, status, msg)
end

function OriMatGameController:sendPM_OriginMaterialGameEndReq(seasonId, stageId, isPass, waveId)
	local subMo = self:getSubMo(seasonId)
	local encryptedKey = subMo:getEncryptedKey(isPass, waveId)

	OriMatGameAgent.instance:sendPM_OriginMaterialGameEndReq(seasonId, stageId, isPass, waveId, encryptedKey)
end

function OriMatGameController:handlePM_OriginMaterialGameEndRes(status, msg)
	self._isInGame = false

	if status == 0 then
		local seasonId = msg.seasonId
		local subMo = self:getSubMo(seasonId)

		subMo:handlePM_OriginMaterialGameEndRes(msg)
		self:_updateSeasonPrizeRedPoint(seasonId)
		self:_updateTalentTreeRedPoint(seasonId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginMaterialGameEndRes, status, msg)
end

function OriMatGameController:sendPM_OriginMaterialGameGainPrizeReq(seasonId)
	OriMatGameAgent.instance:sendPM_OriginMaterialGameGainPrizeReq(seasonId)
end

function OriMatGameController:handlePM_OriginMaterialGameGainPrizeRes(msg)
	local seasonId = msg.seasonId
	local subMo = self:getSubMo(seasonId)

	subMo:handlePM_OriginMaterialGameGainPrizeRes(msg)
	OriMatGameModel.instance:handlePM_OriginMaterialGameGainPrizeRes(msg)
	self:_updateSeasonPrizeRedPoint(seasonId)
	self:_updateTalentTreeRedPoint(seasonId)
	self:_updateAllSeasonPrizeRedIdFromResetData()
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginMaterialGameGainPrizeRes)
end

function OriMatGameController:sendPM_OriginMaterialGameUnlockTalentReq(seasonId, talentId)
	OriMatGameAgent.instance:sendPM_OriginMaterialGameUnlockTalentReq(seasonId, talentId)
end

function OriMatGameController:handlePM_OriginMaterialGameUnlockTalentRes(msg)
	local seasonId = msg.seasonId
	local subMo = self:getSubMo(seasonId)

	subMo:handlePM_OriginMaterialGameUnlockTalentRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginMaterialGameUnlockTalentRes, msg)
end

function OriMatGameController:sendPM_OriginMaterialGameReOpenSeasonReq(seasonId, reOpenSeasonId)
	OriMatGameAgent.instance:sendPM_OriginMaterialGameReOpenSeasonReq(seasonId, reOpenSeasonId)
end

function OriMatGameController:handlePM_OriginMaterialGameReOpenSeasonRes(msg)
	local seasonId = msg.seasonId
	local subMo = self:getSubMo(seasonId)

	subMo:handlePM_OriginMaterialGameReOpenSeasonRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginMaterialGameReOpenSeasonRes)
end

function OriMatGameController:sendPM_OriginMaterialGameAllSeasonReq()
	OriMatGameAgent.instance:sendPM_OriginMaterialGameAllSeasonReq()
end

function OriMatGameController:handlePM_OriginMaterialGameAllSeasonRes(msg)
	OriMatGameModel.instance:handlePM_OriginMaterialGameAllSeasonRes(msg)
	self:_updateAllSeasonPrizeRedIdFromResetData()
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginMaterialGameAllSeasonRes)
end

function OriMatGameController:sendPM_OriginMaterialGameOneKeyGainPrizeReq()
	OriMatGameAgent.instance:sendPM_OriginMaterialGameOneKeyGainPrizeReq()
end

function OriMatGameController:handlePM_OriginMaterialGameOneKeyGainPrizeRes(msg)
	self:_updateAllSeasonPrizeRedIdFromResetData()
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginMaterialGameOneKeyGainPrizeRes)
end

function OriMatGameController:getSeasonId()
	local seasonId = 0
	local nowStamp = ServerTime.now()
	local dataList = OriMatGameConfig.instance:getSeasonDataList()

	for _, data in ipairs(dataList) do
		local startStamp = GameUtil.string2time(data.beginTime)

		if startStamp <= nowStamp then
			seasonId = data.id
		else
			break
		end
	end

	return seasonId
end

function OriMatGameController:isInTime(seasonId)
	local startStamp, endStamp = self:getSeasonStartEndTime(seasonId)

	return GameUtil.getTimePeriod(startStamp, endStamp) == GameUtil.inTimePeriod
end

function OriMatGameController:getSubMo(seasonId)
	return OriMatGameModel.instance:getSubMo(seasonId)
end

function OriMatGameController:getSeasonStartEndTime(seasonId)
	local curSeasonData = OriMatGameConfig.instance:getSeasonData(seasonId)
	local nextSeasonData = OriMatGameConfig.instance:getSeasonData(seasonId + 1)

	if curSeasonData then
		::label_24_0::

		local var_24_0 = curSeasonData.beginTime

		if curSeasonData.beginTime then
			local startT = string.format("%s %s:00:00", curSeasonData.beginTime, ClockMgr.instance._refreshTime)

			if nextSeasonData then
				::label_24_1::

				local var_24_1 = nextSeasonData.beginTime

				if nextSeasonData.beginTime then
					local endT = string.format("%s %s:00:00", nextSeasonData.beginTime, ClockMgr.instance._refreshTime)

					return startT, endT
				end
			end
		end
	end
end

function OriMatGameController:getCurSeasonId()
	local newestSeasonId = self:getSeasonId()
	local key = string.format("OriMatGame_CurSeasonId_%s", newestSeasonId)
	local value = GameUtil.getUserData(key)
	local seasonId = checknumber(value)
	local subMo = self:getSubMo(newestSeasonId)

	if seasonId <= 0 or not subMo:isReOpenSeason(seasonId) then
		seasonId = newestSeasonId
	end

	return seasonId
end

function OriMatGameController:changeSeason(seasonId)
	local newestSeasonId = self:getSeasonId()
	local subMo = self:getSubMo(newestSeasonId)

	if seasonId ~= newestSeasonId and not subMo:isReOpenSeason(seasonId) then
		FloatWordMgr.instance:show("赛季未解锁")

		return
	end

	local curSeasonId = self:getCurSeasonId()

	if seasonId == curSeasonId then
		FloatWordMgr.instance:show("已回溯")

		return
	end

	local key = string.format("OriMatGame_CurSeasonId_%s", newestSeasonId)
	local value = GameUtil.saveUserData(key, seasonId)

	OriMatGameController.instance:sendPM_OriginMaterialGameInfoReq(seasonId)
	GlobalDispatcher:dispatch(GlobalNotify.OriMatGameChangeSeason, seasonId)
end

function OriMatGameController:startGameDirectly(seasonId, stageId, weaponIds, talents)
	self._isInGame = true

	OriMatGameGameController.instance:setSelectedWeaponIds(weaponIds)
	OriMatGameGameController.instance:setActiveTalents(talents)
	UIStateManager.instance:push(ViewName.OriMatGameGameView, seasonId, stageId)
end

function OriMatGameController:getIsInGame()
	return self._isInGame
end

function OriMatGameController:_updateSeasonPrizeRedPoint(seasonId)
	local subMo = self:getSubMo(seasonId)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ORIMATGAMESEASONPRIZE, (subMo:isCanGetPrizeInSeason()))
end

function OriMatGameController:_updateTalentTreeRedPoint(seasonId)
	local isActivated = false
	local dataList = OriMatGameConfig.instance:getTalentDataList()

	for _, data in ipairs(dataList) do
		local result = self:getTryUnlockTalentResultAndTips(false, seasonId, data.talentId)

		if result == GameEnum.ResultCode.Success then
			isActivated = true

			break
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ORIMATGAMETALENTTREE, isActivated)
end

function OriMatGameController:getTryUnlockTalentResultAndTips(isShowTips, seasonId, talentId)
	local result = GameEnum.ResultCode.Success
	local tips
	local talentData = OriMatGameConfig.instance:getTalentCfg(talentId)

	if talentData == nil then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "未选择技能"
	end

	local subMo = self:getSubMo(seasonId)

	if result == GameEnum.ResultCode.Success then
		local isUnlock = subMo:isUnlockTalent(talentId)

		if isUnlock then
			result = GameEnum.ResultCode.Error
			tips = isShowTips and "技能已激活"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local lockIds = talentData and talentData.lockIds

		if lockIds then
			for _, lockId in ipairs(lockIds) do
				local isUnlock = subMo:isUnlockTalent(lockId)

				if not isUnlock then
					result = GameEnum.ResultCode.Error
					tips = isShowTips and "前置技能未激活"
				end
			end
		end
	end

	if result == GameEnum.ResultCode.Success then
		local cost = talentData and talentData.cost

		if not string.nilorempty(cost) then
			local matType, matId, matNum = MaterialMgr.getMatParams(cost)
			local withNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

			if withNum < matNum then
				result = GameEnum.ResultCode.Error

				local matName = MaterialMgr.getMaterialsName(matType, matId)

				tips = isShowTips and string.format("%s不足", matName)
			end
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function OriMatGameController:openWeaponUpgradeDescTipsView(weaponId, goOrPos)
	local pos = goOrPos
	local sizeDelta = {
		0,
		0
	}

	if goOrPos and goOrPos.gameObject then
		local rect = goOrPos.gameObject:GetComponent("RectTransform")

		if rect ~= nil then
			sizeDelta = {
				rect.sizeDelta.x,
				rect.sizeDelta.y
			}
		end

		pos = goOrPos.gameObject.transform.position

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)
	end

	CommonTipsMgr.instance:_openOneView(ViewName.OriMatGameWeaponUpgradeDescTipsView, weaponId, pos, sizeDelta)
end

function OriMatGameController:playGameBgMusic(audioId)
	if self._isPlayingBgm then
		return
	else
		self._isPlayingBgm = true
	end

	AudioPlayerEx.instance:playMusic(audioId)
end

function OriMatGameController:stopGameBgMusic()
	self._isPlayingBgm = false

	local scene = SceneMgr.instance:getCurScene()

	if scene then
		local bgmId = 0

		if scene.bgm and scene.bgm.getBgmId then
			bgmId = scene.bgm:getBgmId()
		end

		if bgmId and bgmId ~= 0 then
			AudioPlayerEx.instance:playMusic(bgmId)
		end
	end
end

function OriMatGameController:_updateAllSeasonPrizeRedIdFromResetData()
	local isActivated = false
	local seasonDataList = OriMatGameConfig.instance:getSeasonDataList()

	for _, seasonData in ipairs(seasonDataList) do
		if OriMatGameModel.instance:isCanGainPrizeOfSeason(seasonData.id) then
			isActivated = true

			break
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ORIMATGAMEALLSEASONPRIZE, isActivated)
end

OriMatGameController.instance = OriMatGameController.New()

return OriMatGameController
