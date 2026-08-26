-- chunkname: @modules/logic/seasonver/act166/controller/Season166Controller.lua

module("modules.logic.seasonver.act166.controller.Season166Controller", package.seeall)

local Season166Controller = class("Season166Controller", BaseController)

function Season166Controller:onInit()
	return
end

function Season166Controller:reInit()
	return
end

function Season166Controller:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self.handleReceiveActChanged, self)
end

function Season166Controller:handleReceiveActChanged(actId)
	logNormal("handleReceiveActChanged : " .. tostring(actId))

	local actList = ActivityModel.instance:getOnlineActIdByType(Season166Enum.ActType)

	if actList then
		Activity166Rpc.instance:sendGet166InfosRequest(actList[1])
	end
end

function Season166Controller:openSeasonView(param)
	local viewParam = param or {}

	viewParam.actId = param.actId or Season166Enum.ActId

	Activity166Rpc.instance:sendGet166InfosRequest(viewParam.actId, function()
		self:openSeasonMainView(viewParam)
	end, self)
end

function Season166Controller:openSeasonMainView(param)
	if not param.actId then
		local actId = Season166Model.instance:getCurSeasonId()
		local endTime, offsetSecond = self:getSeasonEnterCloseTimeStamp(actId)

		if not ActivityModel.instance:isActOnLine(actId) or offsetSecond <= 0 then
			logError(actId .. " not online!")

			return
		end

		ViewMgr.instance:openView(ViewName.Season166MainView, param)
	end
end

function Season166Controller:openSeasonBaseSpotView(param)
	ViewMgr.instance:openView(ViewName.Season166BaseSpotView, param)
end

function Season166Controller:openSeasonTrainView(param)
	ViewMgr.instance:openView(ViewName.Season166TrainView, param)
end

function Season166Controller:openSeasonTeachView(param)
	ViewMgr.instance:openView(ViewName.Season166TeachView, param)
end

function Season166Controller:enterSeasonTeachView(param)
	local teachConstCo = Season166Config.instance:getSeasonConstGlobalCo(Season166Enum.TeachStoryConstId)
	local teachStoryId = tonumber(teachConstCo.value)
	local isStoryFinished = StoryModel.instance:isStoryFinished(teachStoryId)

	if isStoryFinished then
		self:openSeasonTeachView(param)
	else
		local storyParam = {}

		storyParam.mark = true

		StoryController.instance:playStory(teachStoryId, storyParam, self.openSeasonTeachView, self, param)
	end
end

function Season166Controller:openHeroGroupFightView(param)
	ViewMgr.instance:openView(ViewName.Season166HeroGroupFightView, param)
end

function Season166Controller:openSeason166TargetView()
	local actId = Season166Model.instance:getCurSeasonId()
	local battleContext = Season166Model.instance:getBattleContext()

	if battleContext and battleContext.baseId and battleContext.baseId > 0 then
		ViewMgr.instance:openView(ViewName.Season166HeroGroupTargetView, {
			actId = actId,
			baseId = battleContext.baseId
		})
	end
end

function Season166Controller.isSeason166EpisodeType(episodeType)
	return episodeType == DungeonEnum.EpisodeType.Season166Base or episodeType == DungeonEnum.EpisodeType.Season166Train or episodeType == DungeonEnum.EpisodeType.Season166Teach
end

function Season166Controller.getMaxHeroGroupCount()
	local episodeId = Season166HeroGroupModel.instance.episodeId
	local episodeCo = episodeId and lua_episode.configDict[episodeId]
	local battleId = episodeCo.battleId
	local battleCo = battleId and lua_battle.configDict[battleId]

	return battleCo.roleNum
end

function Season166Controller:openResultPanel()
	ViewMgr.instance:openView(ViewName.Season166ResultPanel)
end

function Season166Controller:openTalentInfoView(param)
	ViewMgr.instance:openView(ViewName.Season166TalentInfoView, param)
end

function Season166Controller:checkProcessFightReconnect()
	local fightReason = FightModel.instance:getFightReason()
	local episodeId = fightReason.episodeId
	local co = DungeonConfig.instance:getEpisodeCO(episodeId)

	if co and Season166Controller.isSeason166EpisodeType(co.type) then
		local config = Season166Config.instance:getSeasonConfigByEpisodeId(episodeId)
		local talentId

		Season166Model.instance:setBattleContext(config.activityId, episodeId, config.baseId, co.type == DungeonEnum.EpisodeType.Season166Teach and 0 or config.talentId or Season166Model.getPrefsTalent(), config.trainId, config.teachId)

		local isReplay = fightReason.type == FightEnum.FightReason.DungeonRecord
		local multiplication = fightReason.multiplication

		multiplication = multiplication and multiplication > 0 and multiplication or 1

		FightController.instance:setFightParamByEpisodeId(episodeId, isReplay, multiplication, fightReason.battleId)
		Season166HeroGroupModel.instance:setParam(fightReason.battleId, episodeId, false, true)
	end
end

local function prefabKeyAddActId(key)
	if string.nilorempty(key) then
		return key
	end

	local actId = Season166Model.instance:getCurSeasonId() or 0

	return (string.format("Season166_%s_%s", actId, key))
end

function Season166Controller:savePlayerPrefs(key, value)
	if string.nilorempty(key) or not value then
		return
	end

	local uniqueKey = prefabKeyAddActId(key)
	local isNumber = type(value) == "number"

	if isNumber then
		GameUtil.playerPrefsSetNumberByUserId(uniqueKey, value)
	else
		GameUtil.playerPrefsSetStringByUserId(uniqueKey, value)
	end
end

function Season166Controller:getPlayerPrefs(key, defaultValue)
	local value = defaultValue or ""

	if string.nilorempty(key) then
		return value
	end

	local uniqueKey = prefabKeyAddActId(key)
	local isNumber = type(value) == "number"

	value = isNumber and GameUtil.playerPrefsGetNumberByUserId(uniqueKey, value) or GameUtil.playerPrefsGetStringByUserId(uniqueKey, value)

	return value
end

function Season166Controller:loadDictFromStr(jsonStr)
	return (not string.nilorempty(jsonStr) or nil) and cjson.decode(jsonStr)
end

function Season166Controller:getSeasonEnterCloseTimeStamp(actId)
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	if not actInfoMo then
		return 0
	end

	local closeEnterTimeOffset = Season166Config.instance:getSeasonConstNum(actId, Season166Enum.CloseSeasonEnterTime)
	local startTimeStamp = actInfoMo:getRealStartTimeStamp()
	local endTimeStamp = actInfoMo:getRealEndTimeStamp()
	local enterCloseTime = startTimeStamp + closeEnterTimeOffset * TimeUtil.OneDaySecond
	local endTime = closeEnterTimeOffset > 0 and enterCloseTime or endTimeStamp
	local offsetSecond = endTime - ServerTime.now()

	return endTime, offsetSecond
end

function Season166Controller:tryGetToastAsset(callback, callbackObj)
	if self._toastLoader and not self._toastLoader.isLoading then
		local assetItem = self._toastLoader:getAssetItem(Season166Enum.ToastPath)

		return (assetItem:GetResource(Season166Enum.ToastPath))
	end

	if not self._toastLoader then
		self._toastLoader = MultiAbLoader.New()

		self._toastLoader:addPath(Season166Enum.ToastPath)
		self._toastLoader:startLoad(callback, callbackObj)
	end

	return nil
end

function Season166Controller:fillToastObj(toastObj, toastParam)
	local callbackGroup = ToastCallbackGroup.New()

	callbackGroup.onClose = self.onCloseWhenToastRemove
	callbackGroup.onCloseObj = self
	callbackGroup.onCloseParam = toastParam
	callbackGroup.onOpen = self.onOpenToast
	callbackGroup.onOpenObj = self
	callbackGroup.onOpenParam = toastParam
	toastObj.callbackGroup = callbackGroup
end

function Season166Controller:onOpenToast(toastParam, toastItem)
	toastParam.item = Season166ToastItem.New()

	toastParam.item:init(toastItem, toastParam)
end

function Season166Controller:onCloseWhenToastRemove(toastParam, toastItem)
	if toastParam.item then
		toastParam.item:dispose()

		toastParam.item = nil
	end
end

function Season166Controller:showToast(toastType)
	local toastTipInfo = toastType == Season166Enum.ToastType.Talent and luaLang("p_season166resultview_txt_tips") or luaLang("season166_newinfo_unlock")
	local iconPath = toastType == Season166Enum.ToastType.Talent and 1 or 2
	local toastParam = {
		toastTip = toastTipInfo,
		icon = iconPath
	}

	ToastController.instance:showToastWithCustomData(ToastEnum.Season166ReportNotUnlock, self.fillToastObj, self, toastParam)
end

function Season166Controller:enterReportItem(actId, infoId)
	local actInfo = Season166Model.instance:getActInfo(actId)
	local infoMo = actInfo and actInfo:getInformationMO(infoId)
	local param = {}

	param.actId = actId
	param.infoId = infoId

	if infoMo then
		if not Season166Enum.UnlockState then
			param.unlockState = Season166Enum.LockState

			Season166Controller.instance:dispatchEvent(Season166Event.ClickInfoReportItem, param)
		end
	end
end

Season166Controller.instance = Season166Controller.New()

return Season166Controller
