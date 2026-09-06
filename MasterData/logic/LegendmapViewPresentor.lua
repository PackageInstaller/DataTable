-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/LegendmapViewPresentor.lua

module("logic.extensions.legend.view.LegendmapViewPresentor", package.seeall)

local LegendmapViewPresentor = class("LegendmapViewPresentor", ViewWithGuidePresentor)
local MaxCount = 6
local EnumType = {
	AbsoluteTime = 2,
	OpenTime = 1,
	Permanent = 3
}

function LegendmapViewPresentor:ctor()
	LegendmapViewPresentor.super.ctor(self)
end

function LegendmapViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LegendmapViewPresentor:dependWhatResources()
	return {
		"ui/views/legend/legendmapview.prefab"
	}
end

function LegendmapViewPresentor:getTempResources()
	local resultPath = {}
	local availableCfgs = self:_getAvailableCfgs()

	for i = 1, MaxCount do
		if availableCfgs[i] then
			local str = string.format("ui/bigbg/legend/huodong/%s.png", availableCfgs[i].iconName)

			if not TableUtil.isHad(resultPath, str) then
				table.insert(resultPath, str)
			end
		end
	end

	return resultPath
end

function LegendmapViewPresentor:buildViews()
	return {
		LegendmapView.New(),
		LegendTreasureBoxView.New(),
		LegendLimitView.New()
	}
end

function LegendmapViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function LegendmapViewPresentor:_getAvailableCfgs()
	local cfgs = TimeLimitedConfig.instance:getTimedChallengeCfgs()
	local resultCfgs = {}

	for i, v in ipairs(cfgs) do
		if self:_isInTime(v) and #resultCfgs <= MaxCount then
			table.insert(resultCfgs, v)
		end
	end

	return resultCfgs
end

function LegendmapViewPresentor:_isInTime(cfg)
	if not cfg then
		return false
	end

	if cfg.openTimeType == EnumType.OpenTime then
		return GameUtil.isInOpenDaysByOpenDay(cfg.relativeOpenDay + 1, cfg.relativeEndDay - cfg.relativeOpenDay + 1)
	elseif cfg.openTimeType == EnumType.AbsoluteTime then
		return GameUtil.checkIsInTimePeriod(cfg.absoluteOpenDay, cfg.absoluteEndDay)
	elseif cfg.openTimeType == EnumType.Permanent then
		return true
	end

	return false
end

return LegendmapViewPresentor
