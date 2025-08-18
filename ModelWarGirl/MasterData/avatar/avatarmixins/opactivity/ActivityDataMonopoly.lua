-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataMonopoly.lua

local ResActivityDetailMonopolyStep = require("ClientData/ResActivityDetailMonopolyStep")
local ResOpActivityMonopolyDetail = require("ClientData/ResOpActivityMonopolyDetail")
local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResActivityDetailMonopolyEvent = require("ClientData/ResActivityDetailMonopolyEvent")
local ResOpActivityMonopolyAwardLib = require("ClientData/ResOpActivityMonopolyAwardLib")
local ResOpActivityMonopolyItemEvent = require("ClientData/ResOpActivityMonopolyItemEvent")
local ActivityDataMonoPoly = Class("ActivityDataMonoPoly", ActivityDataBase)

function ActivityDataMonoPoly:ctor()
	self.curPos = 0
	self.nowEvent = 0
	self.gridInfo = {}
	self.chooseAwardInfo = {}
	self.normalBuyNum = 0
	self.luckBuyNum = 0
	self.itemCount = {}
end

function ActivityDataMonoPoly:updateClientData(actId)
	local detailId = self.actObject.templateData.detail_id

	self.clientData = ResActivityDetailMonopolyStep[detailId] or {}
	self.miscData = ResOpActivityMonopolyDetail[detailId] or {}
	self.itemEventData = ResOpActivityMonopolyItemEvent[detailId]
end

function ActivityDataMonoPoly:updateRoleData(roleData)
	self.curPos = roleData.monopoly.index
	self.nowEvent = roleData.monopoly.event_id
	self.gridInfo = {}

	for sIndex, sInfo in ipairs(roleData.monopoly.step) do
		self.gridInfo[sIndex] = math.max(sInfo.level or 0, 1)
	end

	self.normalBuyNum = roleData.monopoly.normal_count or 0
	self.luckBuyNum = roleData.monopoly.remote_count or 0
	self.itemEventId = roleData.monopoly.item_event.event_id
	self.itemEventCount = roleData.monopoly.item_event.left_round
	self.itemCount = {}

	for _, info in ipairs(roleData.monopoly.item_count) do
		self.itemCount[info.id] = info.num
	end

	self.chooseAwardInfo = {}

	for _, info in ipairs(roleData.monopoly.lib) do
		local countInfo = {}

		for _, countData in ipairs(info.item) do
			table.insert(countInfo, countData.count)
		end

		self.chooseAwardInfo[info.lib_id] = {
			info.sel_index,
			countInfo
		}
	end
end

function ActivityDataMonoPoly:onMonopolyExchangeResp(diceType, count, num)
	if diceType == "kDiceTypeNormal" then
		self.normalBuyNum = num
	else
		self.luckBuyNum = num
	end
end

function ActivityDataMonoPoly:checkNew()
	if self.miscData and self.miscData.normal_id and ClientUtils.getMoney(self.miscData.normal_id) > 0 then
		return true
	end
end

function ActivityDataMonoPoly:onMonopolyRollResp(move_to, endIndex, eventId, item_event, libCountList, item_count)
	self.curPos = endIndex
	self.gridInfo[move_to.index] = math.max(move_to.data.level or 0, 1)
	self.nowEvent = eventId
	self.itemEventId = item_event.event_id
	self.itemEventCount = item_event.left_round
	self.chooseAwardInfo = {}

	for _, info in ipairs(item_count) do
		self.itemCount[info.id] = info.num
	end

	for _, info in ipairs(libCountList) do
		local countInfo = {}

		for _, countData in ipairs(info.item) do
			table.insert(countInfo, countData.count)
		end

		self.chooseAwardInfo[info.lib_id] = {
			info.sel_index,
			countInfo
		}
	end
end

function ActivityDataMonoPoly:getMonopolyGridLevel(gridIndex)
	return self.gridInfo[gridIndex] or 1
end

function ActivityDataMonoPoly:getNowEventData()
	return ResActivityDetailMonopolyEvent[self.nowEvent]
end

function ActivityDataMonoPoly:getCanBuyDiceNum()
	return self.miscData.normal_limit - self.normalBuyNum
end

function ActivityDataMonoPoly:getChooseAwardInfo(lib_id)
	local nowChoose = self.chooseAwardInfo[lib_id]

	if nowChoose then
		local chooseIndex = nowChoose[1]
		local awardChooseData = ResOpActivityMonopolyAwardLib[lib_id]

		if awardChooseData[chooseIndex] then
			local awardId = awardChooseData[chooseIndex].award_id
			local nowCount = nowChoose[2][chooseIndex] or 0
			local maxCount = awardChooseData[chooseIndex].max_count

			return awardId, nowCount, maxCount
		end
	else
		return false
	end
end

function ActivityDataMonoPoly:onOpActMonopolySetLibAwardResp(lib_id, index)
	if not self.chooseAwardInfo[lib_id] then
		self.chooseAwardInfo[lib_id] = {
			0,
			{}
		}
	end

	self.chooseAwardInfo[lib_id][1] = index
end

function ActivityDataMonoPoly:onOpActMonopolyUseItemResp(event_id, left_round)
	self.itemEventId = event_id
	self.itemEventCount = left_round
end

function ActivityDataMonoPoly:getRecordInfo()
	local info = {}

	for index, itemId in ipairs(self.miscData.record_items or {}) do
		table.insert(info, {
			itemId,
			self.itemCount[itemId] or 0
		})
	end

	return info
end

function ActivityDataMonoPoly:isRecordItem(itemId)
	for index, iId in ipairs(self.miscData.record_items or {}) do
		if iId == itemId then
			return true
		end
	end

	return false
end

return ActivityDataMonoPoly
