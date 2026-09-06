-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/controller/LuckyDrawController.lua

module("logic.extensions.luckydraw.controller.LuckyDrawController", package.seeall)

local LuckyDrawController = class("LuckyDrawController", BaseController)

LuckyDrawController.UserDataKeyPrefix = "LUCKDRAW_REDPOINT_DATA_"
LuckyDrawController.AddTimeStateActId = 25015

function LuckyDrawController:onInit()
	LuckyDrawController.super.onInit(self)
	self:onReset()
	LuckyDrawAgent.instance:addHandler(LuckyDrawAgent.PM_LuckyDrawGetInfoRes, self.handleGetInfo, self)
	LuckyDrawAgent.instance:addHandler(LuckyDrawAgent.PM_LuckyDrawRes, self.handleDrawRes, self)
	LuckyDrawAgent.instance:addHandler(LuckyDrawAgent.PM_LuckyDrawBuyItemRes, self.handleBuyDrawRes, self)
	RedPointAgent.instance:addHandler(RedPointAgent.PM_LoadAllRedPointRes, self.onRedPointChange, self)
end

function LuckyDrawController:onReset()
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialItemChange, self._updateMatRedpoint, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialItemChange, self._updateMatRedpoint, self)
end

function LuckyDrawController:refreshActivtyId(actId)
	LuckyDrawModel.instance:onReset()
	LuckyDrawModel.instance:setActId(actId)

	return cfg
end

function LuckyDrawController:sendGetInfo()
	local activityId = LuckyDrawModel.instance:getActId()

	LuckyDrawAgent.instance:sendPM_LuckyDrawGetInfoReq(activityId)
	LuckyDrawModel.instance:setHasGetInfo(true)

	return true
end

function LuckyDrawController:handleGetInfo(msg)
	LuckyDrawModel.instance:setCurLuckyScore(msg.luckyScore)

	for k, v in ipairs(msg.drawTimes) do
		LuckyDrawModel.instance:setPrizeDrawNum(v.prizeId, v.drawTimes)
	end

	LuckyDrawModel.instance:setTotalDrawtimes(msg.totalDrawTimes)
	LuckyDrawModel.instance:setRecordList(msg.recordList)
	LuckyDrawModel.instance:setGainProcessPrizeBit(msg.gainProcessPrizeBit)
	GlobalDispatcher:dispatch(GlobalNotify.LuckyDrawGetInfo)
end

function LuckyDrawController:sendDraw(inflationMoneyActivityIsOpen, useCoupon)
	local activityId = LuckyDrawModel.instance:getActId()

	inflationMoneyActivityIsOpen = inflationMoneyActivityIsOpen or false
	useCoupon = useCoupon or false

	if activityId then
		self:resetCiList()
		LuckyDrawAgent.instance:sendPM_LuckyDrawReq(activityId, inflationMoneyActivityIsOpen, useCoupon)
	end
end

function LuckyDrawController:handleDrawRes(msg)
	if msg:HasField("curLuckyScore") then
		local lastNum = LuckyDrawModel.instance:getCurLuckyScore()
		local addNum = msg.curLuckyScore - lastNum

		LuckyDrawModel.instance:setAddLuckyScore(addNum)
		LuckyDrawModel.instance:setCurLuckyScore(msg.curLuckyScore)
	end

	if msg:HasField("changeSetId") then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		self:restoreCiList(msg.changeSetId)
	end

	for k, v in ipairs(msg.prizeId) do
		local num = LuckyDrawModel.instance:getCurLuckyScore(v)

		LuckyDrawModel.instance:setPrizeDrawNum(v, num + 1)
	end

	LuckyDrawModel.instance:updateTotalDrawTimes()
	GlobalDispatcher:dispatch(GlobalNotify.LuckyDrawDrawRes, msg.prizeId)
end

function LuckyDrawController:buyDraw(num)
	local activityId = LuckyDrawModel.instance:getActId()

	LuckyDrawAgent.instance:sendPM_LuckyDrawBuyItemReq(activityId, num)
	UIStateManager.instance:popByName(ViewName.SellcellView)
end

function LuckyDrawController:handleBuyDrawRes(msg, state)
	if state == 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		GlobalDispatcher:dispatch(GlobalNotify.LuckyDrawBuyDraw, msg)
	end
end

function LuckyDrawController:resetCiList()
	self.ciList = {}
end

function LuckyDrawController:showMonopolyCI()
	if self.ciList then
		MaterialController.instance:showChangeSetInTemp(self.ciList)

		self.ciList = {}
	end
end

function LuckyDrawController:restoreCiList(changeSetId)
	table.insert(self.ciList, checknumber(changeSetId))
end

function LuckyDrawController:_updateMatRedpoint(mo)
	local actId = LuckyDrawModel.instance:getActId()

	if mo and actId then
		local matType = mo.type

		if matType == MatType.ACTIVITY_ITEM then
			local mainCfg = LuckyDrawConfig.instance:getActCfg(actId)
			local strItem = string.split(mainCfg.cost, ":")

			RedPointController.instance:setRedPointInfo(RedPointModel.ID_LUCKYDRAW, (MaterialMgr.getMatCount(mainCfg.cost) >= checknumber(strItem[3]) or nil) and true)
		end
	end
end

function LuckyDrawController:onRedPointChange()
	local lastActId = LuckyDrawConfig.instance:getLuckDrawPointActId()
	local rpKey = LuckyDrawController.UserDataKeyPrefix .. lastActId
	local isShow = false

	if lastActId > 0 then
		isShow = checknumber(GameUtil.getUserData(rpKey)) <= 0
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_LUCKDRAW_POINTSTATE, isShow)

	lastActId = LuckyDrawConfig.instance:getLuckDrawTimesActId()
	rpKey = LuckyDrawController.UserDataKeyPrefix .. lastActId
	isShow = false

	if lastActId > 0 then
		isShow = checknumber(GameUtil.getUserData(rpKey)) <= 0
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_LUCKDRAW_TIMESTATE, isShow)

	lastActId = LuckyDrawConfig.instance:getLuckDrawAddTimesActId()
	rpKey = LuckyDrawController.UserDataKeyPrefix .. lastActId
	isShow = false

	if lastActId > 0 then
		isShow = checknumber(GameUtil.getUserData(rpKey)) <= 0
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_LUCKDRAW_TIMESTATEAdd, isShow)
end

function LuckyDrawController:resetLuckDrawPointStateRedPoint()
	local lastActId = LuckyDrawConfig.instance:getLuckDrawPointActId()
	local rpKey = LuckyDrawController.UserDataKeyPrefix .. lastActId

	if lastActId > 0 then
		GameUtil.saveUserData(rpKey, 1)
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_LUCKDRAW_POINTSTATE, false)
end

function LuckyDrawController:resetLuckDrawTimeStateRedPoint()
	local lastActId = LuckyDrawConfig.instance:getLuckDrawTimesActId()
	local rpKey = LuckyDrawController.UserDataKeyPrefix .. lastActId

	if lastActId > 0 then
		GameUtil.saveUserData(rpKey, 1)
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_LUCKDRAW_TIMESTATE, false)
end

function LuckyDrawController:resetLuckDrawTimeStateAddRedPoint()
	local lastActId = LuckyDrawConfig.instance:getLuckDrawAddTimesActId()
	local rpKey = LuckyDrawController.UserDataKeyPrefix .. lastActId

	if lastActId > 0 then
		GameUtil.saveUserData(rpKey, 1)
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_LUCKDRAW_TIMESTATEAdd, false)
end

LuckyDrawController.instance = LuckyDrawController.New()

return LuckyDrawController
