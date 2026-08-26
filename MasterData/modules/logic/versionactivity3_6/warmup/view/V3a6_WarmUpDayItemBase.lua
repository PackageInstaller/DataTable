-- chunkname: @modules/logic/versionactivity3_6/warmup/view/V3a6_WarmUpDayItemBase.lua

module("modules.logic.versionactivity3_6.warmup.view.V3a6_WarmUpDayItemBase", package.seeall)

local V3a6_WarmUpDayItemBase = class("V3a6_WarmUpDayItemBase", RougeSimpleItemBase)

function V3a6_WarmUpDayItemBase:ctor(...)
	V3a6_WarmUpDayItemBase.super.ctor(self, ...)
end

function V3a6_WarmUpDayItemBase:setData(mo)
	V3a6_WarmUpDayItemBase.super.setData(self, mo)

	local CO = self:episodeCO()

	self._txtname.text = CO.name
end

function V3a6_WarmUpDayItemBase:episodeId()
	return self._mo
end

function V3a6_WarmUpDayItemBase:episodeCO()
	return self:_assetGetViewContainer():getEpisodeConfig(self:episodeId())
end

function V3a6_WarmUpDayItemBase:getRLOC(episodeId)
	return self:_assetGetViewContainer():getRLOC(episodeId or self:episodeId())
end

function V3a6_WarmUpDayItemBase:isEpisodeReallyOpen(episodeId)
	return self:_assetGetViewContainer():isEpisodeReallyOpen(episodeId or self:episodeId())
end

function V3a6_WarmUpDayItemBase:getSavedPlayedUnlock(episodeId)
	return self:_assetGetViewContainer():getSavedPlayedUnlock(episodeId or self:episodeId())
end

function V3a6_WarmUpDayItemBase:_btnClickOnClick()
	local p = self:parent()

	p:onClickItem(self)
end

return V3a6_WarmUpDayItemBase
