-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/master/MasterEmblemList.lua

require("dm.gameplay.develop.model.master.MasterEmblem")

MasterEmblemList = class("MasterEmblemList", objectlua.Object, _M)

MasterEmblemList:has("_player", {
	is = "rw"
})
MasterEmblemList:has("_emblemList", {
	is = "r"
})

function MasterEmblemList:initialize(player)
	super.initialize(self)

	self._player = player
	self._emblemList = {}
end

function MasterEmblemList:synchronize(data, devs)
	if not data then
		return
	end

	for k, v in pairs(data) do
		local emblem = self:getEmblemById(k)

		if emblem then
			emblem:syncData(v)
		else
			emblem = MasterEmblem:new(k, devs)

			emblem:createAttrEffect(self._player)
			emblem:syncData(v)

			self._emblemList[k] = emblem
		end
	end
end

function MasterEmblemList:getEmblemById(id)
	for k, v in pairs(self._emblemList) do
		if tostring(id) == tostring(v:getId()) then
			return v
		end
	end

	return nil
end
