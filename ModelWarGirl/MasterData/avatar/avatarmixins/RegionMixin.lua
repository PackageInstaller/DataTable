-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\RegionMixin.lua

local RegionUtils = RegionUtils
local EventConst = require("EventConst")
local RegionMixin = {}

function RegionMixin:initRegionMixin(baseData, syncData)
	self:addEventListener()
end

function RegionMixin:postinitRegionMixin(baseData, syncData)
	return
end

function RegionMixin:destroyRegionMixin()
	return
end

function RegionMixin:addEventListener()
	local slotCheckHomepageOpened

	if RegionUtils.isTW() or RegionUtils.isJP() or RegionUtils.isSEA() then
		slotCheckHomepageOpened = Slot(self.checkHomepageOpened, self)
	elseif RegionUtils.isKR() then
		slotCheckHomepageOpened = Slot(self.checkHomepageOpened_KR, self)
	end

	if slotCheckHomepageOpened then
		EventCenter.addEventListener(EventConst.JUMP_GUIDE, slotCheckHomepageOpened)
	end
end

function RegionMixin:checkHomepageOpened(guideId, sourceUIName)
	if (RegionUtils.isTW() and guideId == Const.TW_HOMEPAGE_GUIDE_ID or RegionUtils.isJP() and guideId == Const.JP_HOMEPAGE_GUIDE_ID or RegionUtils.isSEA() and guideId == Const.SEA_HOMEPAGE_GUIDE_ID) and self:getAchieveProcessByType(Const.ACHIEVE_TYPE_FORUM) == 0 then
		self:updateClientAchieveProgress(Const.ACHIEVE_TYPE_FORUM, 1)
	end
end

function RegionMixin:checkHomepageOpened_KR()
	if self:getAchieveProcessByType(Const.ACHIEVE_TYPE_FORUM) == 0 then
		self:updateClientAchieveProgress(Const.ACHIEVE_TYPE_FORUM, 1)
	end
end

return RegionMixin
