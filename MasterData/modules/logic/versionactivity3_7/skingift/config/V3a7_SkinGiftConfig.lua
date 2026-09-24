-- chunkname: @modules/logic/versionactivity3_7/skingift/config/V3a7_SkinGiftConfig.lua

module("modules.logic.versionactivity3_7.skingift.config.V3a7_SkinGiftConfig", package.seeall)

local V3a7_SkinGiftConfig = class("V3a7_SkinGiftConfig", BaseConfig)

function V3a7_SkinGiftConfig:onInit()
	self.actId2ItemIdDic = {}
	self.actId2PackageIdDic = {}
end

function V3a7_SkinGiftConfig:getSkinItemId(actId)
	if not self.actId2ItemIdDic[actId] then
		self:_initParamByActId(actId)
	end

	return self.actId2ItemIdDic[actId]
end

function V3a7_SkinGiftConfig:getSkinPackageId(actId)
	if not self.actId2PackageIdDic[actId] then
		self:_initParamByActId(actId)
	end

	return self.actId2PackageIdDic[actId]
end

function V3a7_SkinGiftConfig:_initParamByActId(actId)
	local activityConfig = ActivityConfig.instance:getActivityCo(actId)

	if string.nilorempty(activityConfig.patFaceParam) or string.nilorempty(activityConfig.param) then
		logError("V3a7_SkinGiftConfig:_getSkinItemId actId:%s param is nil", actId)
	end

	local itemId = tonumber(activityConfig.param)
	local packageId = tonumber(activityConfig.patFaceParam)

	if itemId == nil or itemId == 0 or packageId == nil or packageId == 0 then
		logError("V3a7_SkinGiftConfig:_getSkinItemId actId:%s param is valid", actId)
	end

	self.actId2ItemIdDic[actId] = itemId
	self.actId2PackageIdDic[actId] = packageId
end

function V3a7_SkinGiftConfig:getCurActId()
	return (ActivityConfig.instance:getConstAsNum(ActivityEnum.ConstId.RandomSkinGift))
end

function V3a7_SkinGiftConfig:getCurItemId()
	local actId = self:getCurActId()

	return self:getSkinItemId(actId)
end

function V3a7_SkinGiftConfig:getCurPackageId()
	local actId = self:getCurActId()

	return self:getSkinPackageId(actId)
end

V3a7_SkinGiftConfig.instance = V3a7_SkinGiftConfig.New()

return V3a7_SkinGiftConfig
