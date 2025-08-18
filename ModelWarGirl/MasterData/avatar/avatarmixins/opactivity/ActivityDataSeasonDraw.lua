-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataSeasonDraw.lua

local ResOpActivityDrawSeasonDetail = require("ClientData/ResOpActivityDrawSeasonDetail")
local ResDrawFakeRand = require("ClientData/ResDrawFakeRand")
local ResDrawProbilityClient = require("ClientData/ResDrawProbilityClient")
local ResDrawPoolClient = require("ClientData/ResDrawPoolClient")
local ResShopExchg = require("ClientData/ResShopExchg")
local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ActivityDataSeasonDraw = Class("ActivityDataSeasonDraw", ActivityDataBase)

function ActivityDataSeasonDraw:ctor(...)
	return
end

function ActivityDataSeasonDraw:updateRoleData(roleData)
	if roleData and roleData.draw_season then
		self.count = roleData.draw_season.count
		self.superRoundCount = roleData.draw_season.sol_super_round_count or 0
	end
end

function ActivityDataSeasonDraw:updateMgrData(mgrData)
	self:registerItemChangedCallBack()
end

function ActivityDataSeasonDraw:getResDetailData(...)
	if self.actId and ResOpActivityDrawSeasonDetail[self.actId] then
		return ResOpActivityDrawSeasonDetail[self.actId]
	end
end

function ActivityDataSeasonDraw:getResDrawFakeRandData(...)
	local detailData = self:getResDetailData()

	if detailData then
		local drawId = detailData.draw_pool_id

		if drawId and ResDrawFakeRand[drawId] then
			return ResDrawFakeRand[drawId]
		end
	end
end

function ActivityDataSeasonDraw:getResShopExchgData(...)
	local detailData = self:getResDetailData()

	if detailData and detailData.exchange_id then
		local datas = {}

		for index, id in ipairs(detailData.exchange_id) do
			if ResShopExchg[id] then
				table.insert(datas, ResShopExchg[id])
			end
		end

		return datas
	end
end

function ActivityDataSeasonDraw:getResDrawProbilityData(...)
	local detailData = self:getResDetailData()

	if detailData then
		local drawId = detailData.draw_pool_id

		if drawId and ResDrawProbilityClient[drawId] then
			return ResDrawProbilityClient[drawId]
		end
	end
end

function ActivityDataSeasonDraw:getRelatedRandReplaceActObj()
	local detailData = self:getResDetailData()

	if detailData then
		local actId = detailData.related_rand_replace_id

		if actId then
			local actObj = CurAvatar:getActivityObj(actId)

			if actObj then
				return actObj
			end
		end
	end
end

function ActivityDataSeasonDraw:getRelatedActivityShopActObj(...)
	local detailData = self:getResDetailData()

	if detailData then
		local actId = detailData.related_activity_shop_id

		if actId then
			local actObj = CurAvatar:getActivityObj(actId)

			if actObj then
				return actObj
			end
		end
	end
end

function ActivityDataSeasonDraw:registerItemChangedCallBack(...)
	local resData = self:getResDrawFakeRandData()

	if resData and self.actId then
		CurAvatar:registerItemChangedCallBack(resData.item_id, Functor(CurAvatar._checkDrawcardActItemReddot, self.actId, resData.item_id, resData.item_num))
		CurAvatar._checkDrawcardActItemReddot(self.actId, resData.item_id, resData.item_num)
	end
end

function ActivityDataSeasonDraw:checkNew(...)
	if self.actObject.redDotId then
		return RedDotManager.getKeyState(self.actObject.redDotId)
	end
end

function ActivityDataSeasonDraw:getFirstShowExchgRedDot(index)
	if self.firstShowExchg and self.firstShowExchg[index] then
		return self.firstShowExchg[index]
	end
end

function ActivityDataSeasonDraw:setFirstShowExchgRedDot(index)
	if not self.firstShowExchg then
		self.firstShowExchg = {}
	end

	self.firstShowExchg[index] = true
end

function ActivityDataSeasonDraw:unsetDrawCardItemReddot(...)
	if self.actObject.redDotId then
		RedDotManager.setKeyState(self.actObject.redDotId, false)
	end
end

return ActivityDataSeasonDraw
