-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerlottery/view/SummerlotteryeffectViewPresentor.lua

module("logic.extensions.summerlottery.view.SummerlotteryeffectViewPresentor", package.seeall)

local SummerlotteryeffectViewPresentor = class("SummerlotteryeffectViewPresentor", ViewPresentor)

function SummerlotteryeffectViewPresentor:ctor()
	SummerlotteryeffectViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.LotteryEffectViewPriority
end

function SummerlotteryeffectViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function SummerlotteryeffectViewPresentor:dependWhatResources()
	return {
		"ui/views/summerlottery/summerlotteryeffectview.prefab"
	}
end

function SummerlotteryeffectViewPresentor:_getParam(params, key, defaultValue)
	if params[key] ~= nil then
		return params[key]
	end

	return defaultValue
end

function SummerlotteryeffectViewPresentor:getTempResources()
	local effectMgr = UIEffectManager.instance
	local params = self:getFirstParam() or {}
	local effs = {}

	table.insert(effs, effectMgr:getEffectPath(SummerLotteryConfig.ChouKaFirstEffect))

	local chouKaQualityUrls = self:_getParam(params, "chouKaQualityUrls", SummerLotteryConfig.ChouKaQualityUrls)
	local tuoweiQualityUrls = self:_getParam(params, "tuoweiQualityUrls", SummerLotteryConfig.TuoWeiQualityUrls)

	for q, url in pairs(chouKaQualityUrls) do
		table.insert(effs, effectMgr:getEffectPath(url))
	end

	for q, url in pairs(tuoweiQualityUrls) do
		table.insert(effs, effectMgr:getEffectPath(url))
	end

	return effs
end

function SummerlotteryeffectViewPresentor:buildViews()
	return {
		SummerLotteryEffectView.New()
	}
end

return SummerlotteryeffectViewPresentor
