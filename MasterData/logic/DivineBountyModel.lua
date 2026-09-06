-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinebounty/model/DivineBountyModel.lua

module("logic.extensions.divinebounty.model.DivineBountyModel", package.seeall)

local DivineBountyModel = class("DivineBountyModel", BaseModel)

function DivineBountyModel:ctor()
	return
end

function DivineBountyModel:onInit()
	self:onReset()
end

function DivineBountyModel:onReset()
	self._lotteryInfo = {}
	self._itemIds = {}
	self._progressPrizeIds = {}
	self._changeSetIds = {}
	self._shopInfos = {}
	self._shopItemChangeSetId = {}
end

function DivineBountyModel:onDivineBountyGetLotteryInfoRes(msg)
	self._lotteryInfo = msg

	print("nextBigPrizeTimes = ", self._lotteryInfo.nextBigPrizeTimes, "progress = ", self._lotteryInfo.progress)
end

function DivineBountyModel:onDivineBountyLotteryRes(msg)
	self._lotteryInfo = msg.info
	self._itemIds = msg.itemIds
	self._progressPrizeIds = msg.progressPrizeIds
	self._changeSetIds = msg.changeSetIds
end

function DivineBountyModel:onDivineBountyGetShopInfoRes(msg)
	if not msg.infos then
		return
	end

	self._shopInfos = msg.infos
end

function DivineBountyModel:onDivineBountyBuyShopItemRes(msg)
	self._shopItemChangeSetId = msg.changeSetId
end

function DivineBountyModel:getAllInfo()
	local info = {}

	info._lotteryInfo = self._lotteryInfo
	info._itemIds = self._itemIds
	info._progressPrizeIds = self._progressPrizeIds

	return info
end

function DivineBountyModel:getLotteryInfo()
	return self._lotteryInfo or {}
end

function DivineBountyModel:getDivineBountyLotteryRes()
	local itemIds = self._itemIds
	local progressPrizeIds = self._progressPrizeIds
	local changeSetId = self._changeSetIds

	return itemIds, progressPrizeIds, changeSetId
end

function DivineBountyModel:getShopItemBuyTimes(itemId)
	if not self._shopInfos then
		return
	end

	local buyTimes = 0

	for i, v in ipairs(self._shopInfos) do
		if itemId == v.itemId then
			buyTimes = v.buyTimes

			break
		end
	end

	return buyTimes
end

DivineBountyModel.instance = DivineBountyModel.New()

return DivineBountyModel
