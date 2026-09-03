-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/model/GalleryParty.lua

GalleryParty = class("GalleryParty", objectlua.Object, _M)

GalleryParty:has("_id", {
	is = "rw"
})

function GalleryParty:initialize(id, owner)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:requireRecordById("GalleryParty", id)
end

function GalleryParty:getTitle()
	local titleArray = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroPartyName", "content")

	return Strings:get(titleArray[self._config.Party]) or ""
end

function GalleryParty:getDesc()
	return Strings:get(self._config.PartyDesc)
end

function GalleryParty:getHeroIds()
	if not next(self._config.IncludeHero) then
		local heros = {}
		local data = {}
		local config = ConfigReader:getDataTable("GalleryParty")

		for k, v in pairs(config) do
			if v.Type == 1 then
				data[v.ShowRank] = v
			end
		end

		for i, v in ipairs(data) do
			for i, id in ipairs(v.IncludeHero) do
				table.insert(heros, id)
			end
		end

		self._config.IncludeHero = heros
	end

	return self._config.IncludeHero
end

function GalleryParty:getOrder()
	return self._config.ShowRank
end

function GalleryParty:getRewardIds()
	return self._config.PartyReward
end

function GalleryParty:getPartyId()
	return self._config.Party
end

function GalleryParty:getIcon()
	return self._config.Icon
end

function GalleryParty:getType()
	return self._config.Type
end
