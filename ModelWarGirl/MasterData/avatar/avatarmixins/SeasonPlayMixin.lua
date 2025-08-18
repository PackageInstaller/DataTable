-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\SeasonPlayMixin.lua

local ResOpActivitySeasonBPMisc = require("ClientData/ResOpActivitySeasonBPMisc")
local ResOpActivitySeasonBPAward = require("ClientData/ResOpActivitySeasonBPAward")
local ResOpActivitySeasonBPShow = require("ClientData/ResOpActivitySeasonBPShow")
local ResOpActivitySeasonBPEntrance = require("ClientData/ResOpActivitySeasonBPEntrance")
local ResSeasonPlaySettleShow = require("ClientData/ResSeasonPlaySettleShow")
local ResSeasonRelicOp = require("ClientData/ResSeasonRelicOp")
local ResSeasonDrawShow = require("ClientData/ResSeasonDrawShow")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local SeasonPlayMixin = {}

function SeasonPlayMixin:initSeasonPlayMixin(baseData, syncData)
	self:registSeasonRelicRedDotRelateItemId()
end

function SeasonPlayMixin:getSeasonPlayBPShowControlResData(control_id)
	if control_id and ResOpActivitySeasonBPShow[control_id] then
		return ResOpActivitySeasonBPShow[control_id]
	end
end

function SeasonPlayMixin:getSeasonPlaySubDataByType(type, actObj)
	if not type or type == 0 then
		return
	end

	local datas = {}

	actObj = actObj or self:getSeasonPlayActivity()

	if actObj then
		local relateActIds = self:getAllRelateSubActIds(actObj.opId)
		local relateActData = {}

		for index, opId in ipairs(relateActIds or {}) do
			if self.opActivityObjs[opId] then
				local actobj = self.opActivityObjs[opId]

				if actobj:isOpen() then
					table.insert(relateActData, actobj.actData)
				end
			end
		end

		for index, actData in ipairs(relateActData) do
			for achieveType, typeData in pairs(actData.clientData or {}) do
				for index, aData in ipairs(typeData) do
					if aData.show_control_id and aData.show_control_id ~= 0 then
						local state = actData:getAchieveState(achieveType, index)
						local oneData = {}

						oneData = aData
						oneData.state = state
						oneData.nowProgress = actData:getAchieveProgress(achieveType)

						local resData = self:getSeasonPlayBPShowControlResData(aData.show_control_id)

						if resData and resData.show_type == type then
							table.insert(datas, oneData)
						end
					end
				end
			end
		end

		if ResOpActivitySeasonBPAward[actObj.actId] then
			for _, typeData in pairs(ResOpActivitySeasonBPAward[actObj.actId]) do
				for index, data in pairs(typeData) do
					if data and data.show_control_id ~= 0 then
						local resData = self:getSeasonPlayBPShowControlResData(data.show_control_id)

						if resData and resData.show_type == type then
							if resData.relate_act_id then
								if self.activityObjs[resData.relate_act_id] and self.activityObjs[resData.relate_act_id]:isOpen() then
									data.isRank = true
									data.state = Const.ACT_ACHIEVE_STATE_NOT_ENOUGH

									table.insert(datas, data)
								end
							else
								data.isRank = true
								data.state = Const.ACT_ACHIEVE_STATE_NOT_ENOUGH

								table.insert(datas, data)
							end
						end
					end
				end
			end
		end
	end

	return datas
end

function SeasonPlayMixin:getSeaSonPlayEntranceResDataByType(type, actObj)
	if not type or type == 0 then
		return
	end

	local datas = {}

	actObj = actObj or self:getSeasonPlayActivity()

	if actObj and actObj.actId and ResOpActivitySeasonBPEntrance[actObj.actId] then
		if type ~= Const.SEASON_TASK_TYPE_OPACT and type ~= Const.SEASON_TASK_TYPE_DRAW then
			for k, v in pairs(ResOpActivitySeasonBPEntrance[actObj.actId][type]) do
				return v
			end
		else
			for id, data in pairs(ResOpActivitySeasonBPEntrance[actObj.actId][type]) do
				local actId = data.relate_act_id

				if self.activityObjs[actId] and self.activityObjs[actId]:isOpen() then
					return data
				end
			end
		end
	end
end

function SeasonPlayMixin:checkSeasonPlayCanGetRedDot(...)
	if self:checkSeasonPlayCanGetRedDotByType(Const.SEASON_TASK_TYPE_CHALLENGE) or self:checkSeasonPlayCanGetRedDotByType(Const.SEASON_TASK_TYPE_WEEK) or self:checkSeasonPlayCanGetRedDotByType(Const.SEASON_TASK_TYPE_OPACT) then
		return true
	end
end

function SeasonPlayMixin:checkSeasonPlayMainAndRelateDrawRedDot(actObj)
	if actObj and actObj:isOpen() then
		if actObj.redDotId and RedDotManager.getKeyState(actObj.redDotId) then
			return true
		end

		if ResOpActivitySeasonBPMisc[actObj.actId] then
			local actId = ResOpActivitySeasonBPMisc[actObj.actId].relate_draw_actId

			if actId then
				local drawObject = self:getActivityObj(actId)

				if drawObject and drawObject:isOpen() and drawObject.redDotId then
					return RedDotManager.getKeyState(drawObject.redDotId)
				end
			end
		end
	end
end

function SeasonPlayMixin:checkOpenSeaonPlayRedDot(...)
	if self:checkSeasonPlayCanGetRedDot() then
		return true
	end

	local actObj = self:getSeasonPlayActivity()

	if actObj and actObj.curState == Const.OPACT_STATE_OPEN and self:checkSeasonPlayNewOpenRedDot() then
		return true
	end

	if actObj and self:checkSeasonPlayMainAndRelateDrawRedDot(actObj) then
		return true
	end

	return false
end

function SeasonPlayMixin:checkSeasonPlayMainMenuBgRedDot()
	if self:checkOpenSeaonPlayRedDot() then
		return true
	end

	return false
end

function SeasonPlayMixin:checkSeasonPlayCanGetRedDotByType(type)
	if type then
		local datas = self:getSeasonPlaySubDataByType(type)

		for index, data in ipairs(datas) do
			if data.state == Const.ACT_ACHIEVE_STATE_ENOUGH then
				return true
			end
		end
	end
end

function SeasonPlayMixin:checkSeasonPlayNewOpenRedDot(...)
	if self:checkSeasonPlayNewOpenRedDotByType(Const.SEASON_TASK_TYPE_CHALLENGE) or self:checkSeasonPlayNewOpenRedDotByType(Const.SEASON_TASK_TYPE_WEEK) or self:checkSeasonPlayNewOpenRedDotByType(Const.SEASON_TASK_TYPE_OPACT) then
		return true
	end

	return false
end

function SeasonPlayMixin:getItemSeasonDrawShowData(itemId)
	if itemId and ResSeasonDrawShow[itemId] then
		return ResSeasonDrawShow[itemId]
	end
end

function SeasonPlayMixin:checkSeasonPlayNewOpenRedDotByType(Type)
	if Type ~= Const.SEASON_TASK_TYPE_WEEK and Type ~= Const.SEASON_TASK_TYPE_CHALLENGE then
		return false
	end

	local datas = self:getSeasonPlaySubDataByType(Type)

	if not datas or #datas == 0 then
		return false
	end

	local userData = self:getClientUserData(Const.USER_KEY_SEASON_PLAY_NEW_OPEN)

	if not userData then
		return true
	end

	local actObj = self:getSeasonPlayActivity()
	local actId = actObj.actId

	if userData.actId ~= actId or not userData[Type] then
		return true
	end

	for index, data in ipairs(datas or {}) do
		if not userData[Type][data.detail_id] then
			return true
		else
			local endTime = userData[Type][data.detail_id]
			local actObj = self:getActivityObj(data.detail_id)

			if actObj and actObj:isOpen() and actObj.endTime and type(endTime) == "number" and endTime < actObj.endTime then
				return true
			end
		end
	end

	return false
end

function SeasonPlayMixin:saveSeasonPlaySawTasksByType(type)
	if not type or type ~= Const.SEASON_TASK_TYPE_WEEK and type ~= Const.SEASON_TASK_TYPE_CHALLENGE then
		return
	end

	local userData = self:getClientUserData(Const.USER_KEY_SEASON_PLAY_NEW_OPEN)

	userData = userData or {}

	local actObj = self:getSeasonPlayActivity()

	if actObj then
		local actId = actObj.actId

		if userData.actId ~= actId then
			userData = {
				actId = actId
			}
		end

		if not userData[type] then
			userData[type] = {}
		end

		local datas = self:getSeasonPlaySubDataByType(type)

		for index, data in ipairs(datas or {}) do
			local actObj = self:getActivityObj(data.detail_id)

			if actObj and actObj:isOpen() and actObj.endTime then
				userData[type][data.detail_id] = actObj.endTime
			end
		end

		self:setClientUserData(Const.USER_KEY_SEASON_PLAY_NEW_OPEN, userData)
	end
end

function SeasonPlayMixin:refreshSeasonPlayUIs(...)
	local seasonPlayListDlg = UIManager.tryGetUI("seasonPlayListDlg")

	if seasonPlayListDlg and seasonPlayListDlg:getVisible() then
		seasonPlayListDlg:setType()
	end

	local seasonPlayMainDlg = UIManager.tryGetUI("seasonPlayMainDlg")

	if seasonPlayMainDlg and seasonPlayMainDlg:getVisible() then
		seasonPlayMainDlg:refreshData()
	end
end

function SeasonPlayMixin:checkSeasonPlayTimeUpRedDotByType(type)
	if type ~= Const.SEASON_TASK_TYPE_OPACT then
		return false
	end

	local datas = self:getSeasonPlaySubDataByType(type)
	local oneDayTotalSecs = 86400

	for index, data in ipairs(datas or {}) do
		if self.activityObjs[data.detail_id] and self.activityObjs[data.detail_id].getRemainOpenTime then
			local leftTime = self.activityObjs[data.detail_id]:getRemainOpenTime()

			if leftTime and leftTime ~= 0 and leftTime <= oneDayTotalSecs then
				return true
			end
		end
	end

	return false
end

function SeasonPlayMixin:onOpActSeasonBPPointGetResp(opId, count, reason, param)
	if not opId or not reason then
		return
	end

	local id

	if not ResSeasonPlaySettleShow[reason] then
		return
	end

	id = ResSeasonPlaySettleShow[reason].id

	local desc = ResSeasonPlaySettleShow[reason].desc

	if not self.seasonPlayAddBpCount then
		self.seasonPlayAddBpCount = {}
	end

	if not self.seasonPlayAddBpCount[opId] then
		self.seasonPlayAddBpCount[opId] = {}
	end

	if not self.seasonPlayAddBpCount[opId][id] then
		self.seasonPlayAddBpCount[opId][id] = {}
		self.seasonPlayAddBpCount[opId][id].count = 0
		self.seasonPlayAddBpCount[opId][id].desc = desc
	end

	self.seasonPlayAddBpCount[opId][id].count = self.seasonPlayAddBpCount[opId][id].count + count

	local seasonPlayMainDlg = UIManager.tryGetUI("seasonPlayMainDlg")

	if seasonPlayMainDlg and seasonPlayMainDlg:getVisible() then
		seasonPlayMainDlg:setSettleShow()
	end
end

function SeasonPlayMixin:getOpActSeasonBPPointAdd(opId)
	if opId and self.seasonPlayAddBpCount and self.seasonPlayAddBpCount[opId] then
		return self.seasonPlayAddBpCount[opId]
	end
end

function SeasonPlayMixin:clearOpActSeasonBPPointAdd(opId, type)
	if opId and self.seasonPlayAddBpCount and self.seasonPlayAddBpCount[opId] then
		self.seasonPlayAddBpCount[opId][type] = nil
	end
end

function SeasonPlayMixin:onOpActDrawSeasonDrawResp(actId, list)
	local ui = UIManager.tryGetUI("seasonPlaySkinPoolDlg")

	if ui then
		local showUI = UIManager.tryGetUI("seasonPlayShowAwardDlg")

		if ui.toggleIsOn and showUI and showUI:getVisible() then
			showUI:setData(list)
		else
			ui:onDrawResp(list)
		end
	end
end

function SeasonPlayMixin:registSeasonRelicRedDotRelateItemId(...)
	local visMap = {}

	for _, relicData in pairs(ResSeasonRelicOp or {}) do
		for type, typeData in pairs(relicData or {}) do
			for index, aData in pairs(typeData or {}) do
				if aData and aData.use then
					for i, data in ipairs(aData.use or {}) do
						if data.id and not visMap[data.id] then
							visMap[data.id] = true

							self:registerItemChangedCallBack(data.id, Slot(self.checkSeasonRelicRedDot, self))
						end
					end
				end
			end
		end
	end
end

function SeasonPlayMixin:checkOpenSeasonLevel(level)
	local actObj = self:getSeasonPlayActivity()

	if actObj and actObj:isOpen() then
		local lastData = actObj.actData:getNextAchieveInfo(true)

		if lastData and level >= lastData.index then
			return false
		else
			return true
		end
	end

	return true
end

return SeasonPlayMixin
