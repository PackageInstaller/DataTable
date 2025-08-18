-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataBuyGiftDraw.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResGiftDrawDetail = require("ClientData/ResGiftDrawDetail")
local ResGiftDrawMisc = require("ClientData/ResGiftDrawMisc")
local ResGiftDrawSpecialGift = require("ClientData/ResGiftDrawSpecialGift")
local strClassName = "ActivityDataBuyGiftDraw"
local ActivityDataBuyGiftDraw = Class(strClassName, ActivityDataBase)

function ActivityDataBuyGiftDraw:ctor()
	return
end

function ActivityDataBuyGiftDraw:updateMgrData(opActivityMgrItem)
	self.mgrData = opActivityMgrItem
	self.startTime = self.mgrData.time.opentime
	self.endTime = self.mgrData.time.closetime
	self.freezeTime = self.mgrData.time.freezetime
	self.giftDrawData = opActivityMgrItem.specdata.gift_draw.item

	local winnerUids = {}

	for i, v in pairs(self.giftDrawData) do
		if v.last_winner and v.last_winner ~= "" and v.last_winner ~= "0" then
			table.insert(winnerUids, v.last_winner)
		end
	end

	if #winnerUids > 0 then
		CurAvatar:getRoleCommInfosNoTip(winnerUids)
	end
end

function ActivityDataBuyGiftDraw:updateClientData(actID)
	self.actID = actID
	self.detailData = ResGiftDrawDetail[actID] or {}
	self.miscTableData = ResGiftDrawMisc[actID] or {}
	self.specialGiftTableData = ResGiftDrawSpecialGift[actID] or {}
	self.lastShareTime = ClientUtils.getServerTime() - 60
	self.showRedDotTab = {}
end

function ActivityDataBuyGiftDraw:updateRoleData(roleData, fromDataUpdate)
	self.selfBuyData = roleData.gift_draw.level
	self.buyRoundDatas = {}

	for i, v in pairs(self.selfBuyData) do
		local buyRoundData = ClientUtils.getBitsDictFromByteString(v.round_sign)

		self.buyRoundDatas[v.level] = buyRoundData
	end
end

function ActivityDataBuyGiftDraw:checkNew()
	if utils.getTableElemCount(self.showRedDotTab) > 0 then
		return true
	end

	return false
end

function ActivityDataBuyGiftDraw:updateGetDrawLogTime(level_list)
	self.drawLogTime = ClientUtils.getServerTime()
	self.drawLogRecordList = level_list
end

function ActivityDataBuyGiftDraw:updateGiftDrawShareTime()
	self.lastShareTime = ClientUtils.getServerTime()
end

return ActivityDataBuyGiftDraw
