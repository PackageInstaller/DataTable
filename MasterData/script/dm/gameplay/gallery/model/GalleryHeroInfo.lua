-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/model/GalleryHeroInfo.lua

GalleryHeroInfo = class("GalleryHeroInfo", objectlua.Object, _M)

GalleryHeroInfo:has("_id", {
	is = "rw"
})

function GalleryHeroInfo:initialize(id, owner)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:requireRecordById("GalleryHeroInfo", tostring(id))
end

function GalleryHeroInfo:getTitle()
	local titleArray = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroPartyName", "content")

	return Strings:get(titleArray[self._config.Party]) or ""
end

function GalleryHeroInfo:getDesc()
	return Strings:get(self._config.PartyDesc)
end

function GalleryHeroInfo:getHeroIds()
	return self._config.IncludeHero
end

function GalleryHeroInfo:getOrder()
	return self._config.ShowRank
end

function GalleryHeroInfo:getRewardIds()
	return self._config.PartyReward
end
