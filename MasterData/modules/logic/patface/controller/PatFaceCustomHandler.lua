-- chunkname: @modules/logic/patface/controller/PatFaceCustomHandler.lua

module("modules.logic.patface.controller.PatFaceCustomHandler", package.seeall)

local PatFaceCustomHandler = {}

function PatFaceCustomHandler.activity142CheckCanPat(patFaceId)
	local result = false
	local isInOpen = Activity136Model.instance:isActivity136InOpen()

	if isInOpen then
		local hasReceive = Activity136Model.instance:hasReceivedCharacter()

		result = not hasReceive
	end

	return result
end

function PatFaceCustomHandler.decalogPresentCheckCanPat(patFaceId)
	return DecalogPresentModel.instance:isShowRedDot()
end

function PatFaceCustomHandler.matildaGiftCheckCanPat(patFaceId)
	return V1a9_MatildaGiftModel.instance:isShowRedDot()
end

function PatFaceCustomHandler.semmelWeisGiftCheckCanPat(patFaceId)
	return SemmelWeisGiftModel.instance:isShowRedDot()
end

function PatFaceCustomHandler.bPSPViewCanPat(patFaceId)
	if BpModel.instance:isEnd() then
		return false
	end

	local bpCo = BpConfig.instance:getBpCO(BpModel.instance.id)

	if not bpCo or not bpCo.isSp then
		return false
	end

	local status = ActivityHelper.getActivityStatus(BpConfig.instance:getSpActId(), true)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	return BpModel.instance.firstShowSp
end

function PatFaceCustomHandler.bPViewCanPat(patFaceId)
	if BpModel.instance:isEnd() then
		return false
	end

	local key = string.format("%s#%s#%s", PlayerPrefsKey.FirstShowPatFace, "BPFace", PlayerModel.instance:getPlayinfo().userId)
	local data = PlayerPrefsHelper.getString(key, "")

	return BpModel.instance.firstShow and tonumber(data) ~= BpModel.instance.id
end

function PatFaceCustomHandler.limitDecorateCanPat(patFaceId)
	local status = ActivityHelper.getActivityStatus(VersionActivity2_2Enum.ActivityId.LimitDecorate, true)
	local isOnline = status == ActivityEnum.ActivityStatus.Normal

	if isOnline then
		return (PatFaceCustomHandler.checkIsFistShow(patFaceId))
	end
end

function PatFaceCustomHandler.decalogPresentPat(patFaceId)
	local patViewName = PatFaceConfig.instance:getPatFaceViewName(patFaceId)

	DecalogPresentController.instance:openDecalogPresentView(patViewName)
end

function PatFaceCustomHandler.matildaGiftPat(patFaceId)
	V1a9_MatildaGiftController.instance:openMatildaGiftView()
end

function PatFaceCustomHandler.semmelWeisGiftPat(patFaceId)
	SemmelWeisGiftController.instance:openSemmelWeisGiftView()
end

function PatFaceCustomHandler.checkIsFistShow(patFaceId)
	local key = string.format("%s#%s#%s", PlayerPrefsKey.FirstShowPatFace, patFaceId, PlayerModel.instance:getPlayinfo().userId)
	local data = PlayerPrefsHelper.getString(key, "")

	return string.nilorempty(data)
end

function PatFaceCustomHandler.setHasShow(patFaceId)
	local key = string.format("%s#%s#%s", PlayerPrefsKey.FirstShowPatFace, patFaceId, PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(key, "hasEnter")
end

function PatFaceCustomHandler.V2a8_WuErLiXiGiftCheckCanPat(patFaceId)
	return V2a8_WuErLiXiGiftModel.instance:isShowRedDot()
end

function PatFaceCustomHandler.V2a8_WuErLiXiGiftPat(patFaceId)
	V2a8_WuErLiXiGiftController.instance:openV2a8_WuErLiXiGiftView()
end

function PatFaceCustomHandler.V2a8_SelfSelectCharacterViewCheckCanPat(patFaceId)
	return Activity199Model.instance:isShowRedDot()
end

function PatFaceCustomHandler.V2a8_SelfSelectCharacterViewPat(patFaceId)
	Activity199Controller.instance:openV2a8_SelfSelectCharacterView()
end

function PatFaceCustomHandler.V2a8_BPSkinFaceViewCanPat(patFaceId)
	local payStatus = BpModel.instance.payStatus

	if payStatus ~= BpEnum.PayStatus.Pay1 and payStatus ~= BpEnum.PayStatus.Pay2 then
		return false
	end

	local skinId = CommonConfig.instance:getConstNum(ConstEnum.BPSkinFaceViewSkinId)

	if not skinId or skinId == 0 or not lua_skin.configDict[skinId] then
		return false
	end

	if BpController.instance:isSkinFaceOnlineBySkinId(skinId) and BpController.instance:isEmptySkinFaceViewStr(skinId) then
		local stroeGoodsMO = StoreClothesGoodsItemListModel.instance:findMOByProduct(MaterialEnum.MaterialType.HeroSkin, skinId)

		if stroeGoodsMO and not stroeGoodsMO:alreadyHas() then
			return true
		end
	end

	return false
end

function PatFaceCustomHandler.V2a8_openBPSkinFaceViewPat()
	local skinId = CommonConfig.instance:getConstNum(ConstEnum.BPSkinFaceViewSkinId)

	if skinId ~= 0 then
		ViewMgr.instance:openView(ViewName.BPSkinFaceView, {
			skinId = skinId
		})
	end
end

function PatFaceCustomHandler.PowerMakerPatFaceViewCanPat(patFaceId)
	local ofMakerInfo = ItemPowerModel.instance:getCacheFirstPowerMakerInfo()

	if not ofMakerInfo or ofMakerInfo.makeCount <= 0 then
		return
	end

	local logoutHourConst = CommonConfig.instance:getConstStr(ConstEnum.PowerMakerPatFaceTime)

	if not string.nilorempty(logoutHourConst) then
		local hour = TimeUtil.secondToHMS(ofMakerInfo.logoutSecond)

		if hour >= tonumber(logoutHourConst) then
			return true
		end
	end
end

function PatFaceCustomHandler.PowerMakerPatFaceViewPat()
	ViewMgr.instance:openView(ViewName.PowerMakerPatFaceView)
end

function PatFaceCustomHandler.V3a3TowerGiftPanelViewPatFaceViewCanPat()
	local taskId = 530010
	local taskMo = TaskModel.instance:getTaskById(taskId)

	if not taskMo then
		return false
	end

	local isActOpen = ActivityHelper.isOpen(ActivityEnum.Activity.V3a3_TowerDeep)
	local hadRecieve = taskMo.finishCount > 0 and taskMo.progress >= taskMo.config.maxProgress

	return isActOpen and not hadRecieve
end

function PatFaceCustomHandler.V3a3TowerGiftPanelViewPatFaceViewPat()
	ViewMgr.instance:openView(ViewName.V3a3TowerGiftPanelView)
end

function PatFaceCustomHandler.V3a8FreeMonthCardCanPat()
	local actId = VersionActivity3_8Enum.ActivityId.FreeMonthCard
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if not actInfoMo then
		return false
	end

	local isExpired = actInfoMo:getRealEndTimeStamp() - ServerTime.now() < 1
	local canPat = actInfoMo:isOnline() and actInfoMo:isOpen() and not isExpired

	if not canPat then
		return false
	end

	local curDay = VersionActivity3_8FreeMonthCardModel.instance:getCurSignDay()

	return (VersionActivity3_8FreeMonthCardModel.instance:isDayCanSign(curDay))
end

function PatFaceCustomHandler.V3a8FreeMonthCardPat()
	MonthCardController.instance:openV3a8PanelView()
end

function PatFaceCustomHandler.SP02_OperationActivityPatFaceViewCanPat(patFaceId)
	local actId = PatFaceConfig.instance:getPatFaceActivityId(patFaceId)
	local isActOpen = ActivityHelper.isOpen(actId)
	local haveCanGet = ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId)

	return isActOpen and haveCanGet
end

function PatFaceCustomHandler.SP02_OperationActivityPatFaceViewPat(patFaceId)
	local actId = PatFaceConfig.instance:getPatFaceActivityId(patFaceId)

	ViewMgr.instance:openView(ViewName.AtomicOperationActivityEnterPatFaceView, {
		actId = actId
	})
end

return PatFaceCustomHandler
