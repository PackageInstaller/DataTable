-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessdelicacy/model/GoddessDelicacyModel.lua

module("logic.extensions.goddessdelicacy.model.GoddessDelicacyModel", package.seeall)

local GoddessDelicacyModel = class("GoddessDelicacyModel", BaseModel)

function GoddessDelicacyModel:ctor()
	self._goddessInfo = nil
end

function GoddessDelicacyModel:onInit()
	GoddessDelicacyModel.super.onInit(self)
	self:onReset()
end

function GoddessDelicacyModel:onReset()
	self._goddessInfo = nil
end

function GoddessDelicacyModel:getGoddessInfo(isReset)
	if isReset or self._goddessInfo == nil then
		self._goddessInfo = {}
		self._goddessInfo.todayDishes = {}
		self._goddessInfo.foodOptions = {}
		self._goddessInfo.todayCookedTimes = 0
		self._goddessInfo.gainedPrizeIds = {}
		self._goddessInfo.dishInfoList = {}
	end

	return self._goddessInfo
end

function GoddessDelicacyModel:getAllDelicacyCfgs(actId, isSort)
	local cfgs = GoddessDelicacyConfig.instance:getNotesDishAllCfgs(actId)
	local haveCount = 0

	if cfgs == nil then
		return nil, haveCount
	end

	self:getGoddessInfo()

	local targetList = {}
	local dishInfoList = self._goddessInfo.dishInfoList

	for id, stage in pairs(dishInfoList or {}) do
		if stage == GoddessDelicacyController.instance.unLockFinish then
			haveCount = haveCount + 1
		end
	end

	for _, item in pairs(cfgs) do
		if item and item.dishId > 0 then
			table.insert(targetList, {
				dishId = item.dishId,
				name = item.name,
				icon = item.icon,
				foodIds = item.foodIds,
				idsCount = #item.foodIds,
				stage = checknumber(dishInfoList[item.dishId]),
				desc = item.desc,
				activityId = item.activityId
			})
		end
	end

	if isSort and #targetList > 1 then
		table.sort(targetList, function(a, b)
			return a.idsCount < b.idsCount
		end)
	end

	return targetList, haveCount
end

function GoddessDelicacyModel:getAllPrizeCfgs(actId)
	local cfgs = GoddessDelicacyConfig.instance:getNotesProgressCfg(actId)

	if cfgs == nil then
		return nil, haveCount
	end

	self:getGoddessInfo()

	local targetList = {}
	local gainedPrizeIds = self._goddessInfo.gainedPrizeIds

	for _, item in pairs(cfgs) do
		if item and item.prizeId > 0 then
			table.insert(targetList, {
				prizeId = item.prizeId,
				progress = item.progress,
				progressPrize = item.progressPrize,
				isFinish = table.indexof(gainedPrizeIds, item.prizeId) ~= false
			})
		end
	end

	if #targetList > 1 then
		table.sort(targetList, function(a, b)
			return a.prizeId < b.prizeId
		end)
	end

	return targetList
end

function GoddessDelicacyModel:getShareFoodInfo(actId, dishId, isFormula, isChat)
	local cfg = GoddessDelicacyConfig.instance:getNotesDishCfg(actId, dishId)

	if cfg == nil then
		printError("sr---美女美食  GoddessDelicacyModel:getShareFoodInfo(actId, dishId)   分享的信息不对 = " .. actId)
		printError("sr---美女美食  GoddessDelicacyModel:getShareFoodInfo(actId, dishId)   分享的信息不对 = " .. dishId)

		return "", ""
	end

	if not isFormula then
		return cfg.name, ""
	end

	local str = ""
	local foodCfg

	for i = 1, #cfg.foodIds do
		foodCfg = GoddessDelicacyConfig.instance:getNotesFoodCfg(actId, cfg.foodIds[i])

		if foodCfg and not string.nilorempty(foodCfg.name) then
			str = isChat and (string.nilorempty(str) and foodCfg.name .. "x1 " or str .. foodCfg.name .. "x1 ") or langPara("text_goddess_desc_29", str, foodCfg.name)
		end
	end

	return cfg.name, str
end

function GoddessDelicacyModel:getGoddessDelicacyRedpoint()
	local actId = GoddessDelicacyConfig.instance:getOpenActivityId()

	if checknumber(actId) <= 0 then
		return false
	end

	local value = GameUtil.getUserDayData("GoddessDelicacyRed")

	if checknumber(value) ~= 1 then
		return true
	end

	return RedPointModel.instance:isActiveByServer(214)
end

function GoddessDelicacyModel:scPushFoodNotesGetInfo(msg)
	self:getGoddessInfo(true)

	if msg == nil then
		return
	end

	self._goddessInfo.todayDishes = msg.todayDishes or {}
	self._goddessInfo.foodOptions = msg.foodOptions or {}
	self._goddessInfo.todayCookedTimes = checknumber(msg.todayCookedTimes)
	self._goddessInfo.gainedPrizeIds = GameUtil.pbToTable(msg.gainedPrizeIds) or {}
	self._goddessInfo.dishInfoList = {}

	for _, info in pairs(msg.dishInfoList or {}) do
		if info and checknumber(info.dishId) > 0 and info.state then
			self._goddessInfo.dishInfoList[info.dishId] = checknumber(info.state)
		end
	end
end

function GoddessDelicacyModel:scPushFoodNotesCook(msg)
	self:getGoddessInfo()

	self._goddessInfo.todayCookedTimes = self._goddessInfo.todayCookedTimes + 1

	local cookDishId = checknumber(msg.cookDishId)

	if cookDishId < 1 or checknumber(msg.dishState) < 1 then
		return
	end

	self._goddessInfo.dishInfoList[cookDishId] = checknumber(msg.dishState)
end

function GoddessDelicacyModel:scPushFoodNotesGainPrize(prizeId)
	self:getGoddessInfo()

	prizeId = checknumber(prizeId)

	if prizeId <= 0 or table.indexof(self._goddessInfo.gainedPrizeIds, prizeId) then
		return
	end

	table.insert(self._goddessInfo.gainedPrizeIds, prizeId)
end

GoddessDelicacyModel.instance = GoddessDelicacyModel.New()

return GoddessDelicacyModel
