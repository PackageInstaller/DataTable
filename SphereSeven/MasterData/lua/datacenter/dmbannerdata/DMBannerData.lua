local DMBannerData = BaseClass("DMBannerData", Singleton)

local function __init(self)
    self.dMBannerInfo = {};
	self.isNeedPushStart = true;
end

local function AddDMBannerData(self,paramMsg,paramId)
	table.insert(self.dMBannerInfo,{paramMsg=paramMsg,paramId=paramId});
end
local function GetDMBannerData(self)
	return self.dMBannerInfo
end

local function ClearDMBannerData(self)
	self.dMBannerInfo = {}
end

local function SetDMBIsStart(self,bool)
	self.isNeedPushStart = bool;
end

local function GetDMBIsStart(self)
	return self.isNeedPushStart;
end

DMBannerData.__init = __init
DMBannerData.AddDMBannerData = AddDMBannerData
DMBannerData.GetDMBannerData = GetDMBannerData
DMBannerData.ClearDMBannerData = ClearDMBannerData
DMBannerData.SetDMBIsStart = SetDMBIsStart
DMBannerData.GetDMBIsStart = GetDMBIsStart


return DMBannerData