-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/model/ClubMapPositionList.lua

ClubMapPositionList = class("ClubMapPositionList", objectlua.Object, _M)

ClubMapPositionList:has("_playerVillages", {
	is = "r"
})
ClubMapPositionList:has("_clubVillageChangeCount", {
	is = "r"
})

function ClubMapPositionList:initialize()
	super.initialize(self)

	self._playerVillages = {}
end

function ClubMapPositionList:syncInfo(data)
	if data.playerVillages then
		self._memberCount_before = #self._playerVillages
		self._playerVillages = {}

		for k, v in pairs(data.playerVillages) do
			local onePos = ClubMapPosition:new()

			onePos:syncInfo(v)

			self._playerVillages[onePos:getVillagePos()] = onePos
		end

		self._memberCount_after = #self._playerVillages
	end
end

function ClubMapPositionList:setClubVillageChangeCount(data)
	if data then
		self._clubVillageChangeCount = data.value
	end
end

function ClubMapPositionList:isMemberChange()
	return self._memberCount_after ~= self._memberCount_before and self._memberCount_before ~= 0
end

local houseImage = {
	"js_zym_f_sz.png",
	"js_zym_f_fsz.png",
	"js_zym_f_jy.png",
	"js_zym_f_pt.png"
}

ClubMapPosition = class("ClubMapPosition", objectlua.Object, _M)

ClubMapPosition:has("_rId", {
	is = "r"
})
ClubMapPosition:has("_name", {
	is = "r"
})
ClubMapPosition:has("_position", {
	is = "r"
})
ClubMapPosition:has("_village", {
	is = "r"
})
ClubMapPosition:has("_villagePos", {
	is = "r"
})

function ClubMapPosition:initialize()
	super.initialize(self)

	self._rId = ""
	self._name = ""
	self._position = 0
	self._village = ""
	self._villagePos = 0
end

function ClubMapPosition:syncInfo(data)
	if data.rId then
		self._rId = data.rId
	end

	if data.name then
		self._name = data.name
	end

	if data.position then
		self._position = data.position
	end

	if data.village then
		self._village = data.village
	end

	if data.villagePos then
		self._villagePos = data.villagePos
	end
end

function ClubMapPosition:getJobPositinImage()
	return (houseImage[self._position] or nil) and houseImage[self._position]
end
