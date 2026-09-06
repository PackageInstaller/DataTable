-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/model/MonthCardModel.lua

module("logic.extensions.monthcard.model.MonthCardModel", package.seeall)

local MonthCardModel = class("MonthCardModel", BaseModel)

MonthCardModel.CarStatesChange = "MonthCardModel.CarStatesChange"
MonthCardModel.GetRecordSuccessed = "MonthCardModel.GetRecordSuccessed"
MonthCardModel.MonthCardId = 1
MonthCardModel.ResMonthCardId = 3
MonthCardModel.MonthCardId2022 = 6
MonthCardModel.ResMonthCardId2022 = 7
MonthCardModel.MonthCardBackId = 8
MonthCardModel.MonthCardId2024 = 9
MonthCardModel.ResMonthCardId2024 = 10
MonthCardModel.MonthCardBackId2024 = 11
MonthCardModel.MonthCardCritical = 12

function MonthCardModel:ctor()
	return
end

function MonthCardModel:onInit()
	self:onReset()
end

function MonthCardModel:onReset()
	return
end

function MonthCardModel:isCardActive(id)
	return RoleModel.instance:isMonthCardActive(id)
end

function MonthCardModel:getActiveCardLeftTime(id)
	local times = 0
	local info = RoleModel.instance:getMontchCardStates()

	for i, v in ipairs(info) do
		if v.cardId == id then
			times = v.restDay

			break
		end
	end

	return times
end

function MonthCardModel:getCardActiveDescStr(id)
	local active = self:isCardActive(id)
	local desc = "未激活"

	if active then
		if id == 2 then
			local day = self:_getCardActivityDay(id)

			desc = "终身卡已激活" .. day .. "天"
		else
			local times = self:getActiveCardLeftTime(id)

			times = math.max(0, times)
			desc = "剩余有效期" .. times .. "天"
		end
	end

	return desc
end

function MonthCardModel:isgetCardPrize(id)
	local info = RoleModel.instance:getMontchCardStates()

	for i, v in ipairs(info) do
		if v.cardId == id then
			return v.hasGainPrize
		end
	end

	return false
end

function MonthCardModel:setBuyCardSuccessed(msg)
	local info = RoleModel.instance:getMontchCardStates()
	local id = msg.cardId
	local hasData = false

	for i, v in ipairs(info) do
		if v.cardId == id then
			local cfg = MonthCardConfig.instance:getCfgById(id)

			v.restDay = msg.restDay
			hasData = true

			break
		end
	end

	if not hasData then
		local cfg = MonthCardConfig.instance:getCfgById(id)
		local data = {
			hasGainPrize = false,
			cardId = id,
			restDay = msg.restDay,
			buyTimeMillis = ServerTime.nowMs()
		}

		table.insert(info, data)
	end

	RoleModel.instance:calMonthcardDisabledTime()

	local cfg = MonthCardConfig.instance:getCfgByIndex(id)

	TipsFacade.instance:openTipWindowNoX(cfg.cardName .. "激活成功", "记得登录游戏领取每日奖励喔", nil, "我知道了")
end

function MonthCardModel:GainDailyPrizeRes(cardId)
	local info = RoleModel.instance:getMontchCardStates()

	if info then
		for i, v in ipairs(info) do
			if v.cardId == cardId then
				v.hasGainPrize = true
			end
		end
	end
end

function MonthCardModel:_getCardActivityDay(cardId)
	local time = 0
	local day = 1
	local info = RoleModel.instance:getMontchCardStates()

	if info then
		for i, v in ipairs(info) do
			if v.cardId == cardId then
				time = checknumber(v.buyTimeMillis)

				break
			end
		end
	end

	if time > 0 then
		day = math.max(1, math.ceil((ServerTime.nowMs() - time) / 86400000))
	end

	return day
end

function MonthCardModel:calculateRedDot()
	local cfgs = MonthCardConfig.instance:getAllCfgs()

	for i, v in ipairs(cfgs) do
		local notget = self:isCardActive(v.cardId) and not self:isgetCardPrize(v.cardId)

		RedPointController.instance:setRedPointInfo(RedPointModel.ID_MONTHCARD_PRE .. v.cardId, notget)
	end
end

function MonthCardModel:checkCardRedDot(cardId)
	return self:isCardActive(cardId) and not self:isgetCardPrize(cardId)
end

MonthCardModel.instance = MonthCardModel.New()

return MonthCardModel
