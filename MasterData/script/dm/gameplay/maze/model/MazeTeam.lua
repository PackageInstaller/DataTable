-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeTeam.lua

require("dm.gameplay.develop.model.master.MazeMaster")

MazeTeam = class("MazeTeam", objectlua.Object, _M)

MazeTeam:has("_master", {
	is = "rw"
})
MazeTeam:has("_heros", {
	is = "rw"
})
MazeTeam:has("_masterLevel", {
	is = "rw"
})

function MazeTeam:initialize(player)
	super.initialize(self)

	self._player = player
end

function MazeTeam:syncData(data, mzsystem)
	self._mazeSystem = mzsystem

	if data.master then
		local mastertemp = data.master["0"]

		if mastertemp.id then
			self._master = data.master["0"]

			self._mazeSystem:setSelectMaster(self._master)
		else
			self._mazeSystem:setMasterData(data.master["0"])

			self._master = self._mazeSystem:getSelectMaster()
		end

		local prototypeFactory = PrototypeFactory:getInstance()
		local eneryMasterPrototype = prototypeFactory:getEneryMasterPrototype(self._master.id)
		local masterData = eneryMasterPrototype:getMasterData()

		self._master.skills = masterData.skills
	end

	if data.heroes then
		if not self._heroes then
			self._heroes = data.heroes

			self._mazeSystem:setHeros(self._heroes)
		else
			for k, v in pairs(data.heroes) do
				if self._heroes[k] then
					for kk, vv in pairs(v) do
						self._heroes[k][kk] = vv
					end
				else
					self._heroes[k] = v
				end
			end
		end

		self._mazeSystem:syncHeros()
	end
end

function MazeTeam:clearData()
	self._heroes = nil
end

function MazeTeam:getMazeMasterSkill()
	return self._master.skills
end

function MazeTeam:getMaster()
	return self._master
end

function MazeTeam:getHeros()
	return self._heroes
end

function MazeTeam:getName()
	return ""
end
