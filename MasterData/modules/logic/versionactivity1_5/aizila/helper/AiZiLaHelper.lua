-- chunkname: @modules/logic/versionactivity1_5/aizila/helper/AiZiLaHelper.lua

module("modules.logic.versionactivity1_5.aizila.helper.AiZiLaHelper", package.seeall)

local AiZiLaHelper = {}

function AiZiLaHelper.getLimitTimeStr()
	local actMO = ActivityModel.instance:getActMO(VersionActivity1_5Enum.ActivityId.AiZiLa)

	if actMO then
		return string.format(luaLang("versionactivity_remain_day"), actMO:getRemainTimeStr3())
	end

	return ""
end

function AiZiLaHelper.isOpenDay(episodeId)
	local actId = VersionActivity1_5Enum.ActivityId.AiZiLa
	local actMO = ActivityModel.instance:getActMO(actId)
	local cfg = AiZiLaConfig.instance:getEpisodeCo(actId, episodeId)

	if actMO and cfg then
		if not cfg.openDay then
			local openDay = 0
			local openTime = actMO:getRealStartTimeStamp() + (openDay - 1) * 24 * 60 * 60
			local serverTimeStamp = ServerTime.now()
			local preIsClear = cfg.preEpisode == 0 or AiZiLaModel.instance:isEpisodeClear(cfg.preEpisode)
			local cdtime = math.max(openTime - serverTimeStamp, 0)

			if not preIsClear or cdtime > 0 then
				return false, cdtime
			end
		end
	else
		if not cfg then
			logNormal(string.format("can not find v1a5 activity episodeCfg. actId:%s episodeId:%s", actId, episodeId))
		end

		return false, -1
	end

	return true
end

function AiZiLaHelper.showToastByEpsodeId(episodeId)
	local actId = VersionActivity1_5Enum.ActivityId.AiZiLa
	local episodeCfg = AiZiLaConfig.instance:getEpisodeCo(actId, episodeId)

	if not episodeCfg then
		logNormal(string.format("can not find v1a5 activity episodeCfg. actId:%s episodeId:%s", VersionActivity1_5Enum.ActivityId.AiZiLa, episodeId))

		return
	end

	local isOpen, cdTime = AiZiLaHelper.isOpenDay(episodeCfg.id)

	if not isOpen then
		if episodeCfg.preEpisode ~= 0 or not AiZiLaModel.instance:isEpisodeClear(episodeCfg.preEpisode) then
			GameFacade.showToast(ToastEnum.V1a5AiZiLaEpisodeNotOpen, episodeCfg.unlockDesc)
		else
			GameFacade.showToast(ToastEnum.Va3Act120EpisodeNotOpenTime)
		end
	end
end

function AiZiLaHelper.clearOrCreateModel(model)
	if model then
		model:clear()
	else
		model = BaseModel.New()
	end

	return model
end

function AiZiLaHelper.updateMOModel(clsMO, model, moId, info)
	local targetMO = model:getById(moId)

	if targetMO == nil then
		targetMO = clsMO.New()

		targetMO:init(moId)
		model:addAtLast(targetMO)
	end

	targetMO:updateInfo(info)

	return targetMO
end

function AiZiLaHelper.getCostParams(equipCfg)
	local costParams = {}
	local params = equipCfg and GameUtil.splitString2(equipCfg.cost, true)

	if params then
		for _, param in ipairs(params) do
			table.insert(costParams, {
				itemId = param[1],
				itemNum = param[2]
			})
		end
	end

	return costParams
end

function AiZiLaHelper.checkCostParams(costParams)
	if costParams then
		local tAiZiLaModel = AiZiLaModel.instance

		for _, param in ipairs(costParams) do
			if tAiZiLaModel:getItemQuantity(param.itemId) < param.itemNum then
				return false
			end
		end
	end

	return true
end

function AiZiLaHelper.getEpisodeReward(rewardStr)
	local rewardList = {}

	if not string.nilorempty(rewardStr) then
		local params = string.splitToNumber(rewardStr, "|")

		if params then
			for i, itemId in ipairs(params) do
				table.insert(rewardList, {
					itemId = itemId
				})
			end
		end
	end

	return rewardList
end

function AiZiLaHelper.playViewAnimator(viewName, animName)
	local viewContainer = ViewMgr.instance:getContainer(viewName)

	if viewContainer and viewContainer.playViewAnimator then
		viewContainer:playViewAnimator(animName)
	end
end

function AiZiLaHelper.getItemMOListByBonusStr(bonusStr, itemMOList)
	if string.nilorempty(bonusStr) then
		return itemMOList
	end

	local params = GameUtil.splitString2(bonusStr, true)

	if params then
		itemMOList = itemMOList or {}

		for i, param in ipairs(params) do
			local itemMO = AiZiLaItemMO.New()

			itemMO:init(param[1], param[1], param[2] or 1)
			table.insert(itemMOList, itemMO)
		end
	end

	return itemMOList
end

function AiZiLaHelper.startBlock(key)
	if not UIBlockMgr.instance:isKeyBlock(key) then
		UIBlockMgr.instance:startBlock(key)
	end
end

function AiZiLaHelper.endBlock(key)
	if UIBlockMgr.instance:isKeyBlock(key) then
		UIBlockMgr.instance:endBlock(key)
	end
end

function AiZiLaHelper.isFinishRed(keystr)
	return PlayerPrefsHelper.getNumber(keystr, 0) == 1
end

function AiZiLaHelper.finishRed(keystr)
	PlayerPrefsHelper.setNumber(keystr, 1)
end

function AiZiLaHelper.getRedKey(redId, redUId)
	local userId = PlayerModel.instance:getMyUserId() or 0

	return string.format("AiZiLaModel_red_skey_%s_%s_%s", userId, redId, redUId or 0)
end

return AiZiLaHelper
