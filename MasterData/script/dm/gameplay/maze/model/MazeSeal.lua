-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeSeal.lua

require("dm.gameplay.develop.model.master.MazeMaster")

MazeSeal = class("MazeSeal", objectlua.Object, _M)

MazeSeal:has("_sealHeroList", {
	is = "rw"
})
MazeSeal:has("_sealTreasureList", {
	is = "rw"
})
MazeSeal:has("_sealEventList", {
	is = "rw"
})

function MazeSeal:initialize(player, mzsystem)
	super.initialize(self)

	self._player = player
	self._mazeSystem = mzsystem
end

function MazeSeal:syncData(data)
	if data then
		local counthero = 0
		local countitem = 0
		local countevent = 0

		if self._sealHeroList == nil then
			self._sealHeroList = {}
		end

		if self._sealTreasureList == nil then
			self._sealTreasureList = {}
		end

		if self._sealEventList == nil then
			self._sealEventList = {}
		end

		for k, v in pairs(data) do
			if v.taskValues then
				local tasktype = ConfigReader:getRecordById("PansLabOptionUnlock", k)

				if tasktype then
					if tasktype.Type == "ITEM" then
						countitem = countitem + 1
						self._sealTreasureList[k] = v
					elseif tasktype.Type == "HERO" then
						counthero = counthero + 1

						if self._sealHeroList[k] then
							self:syncHeroData(k, v)
						else
							self._sealHeroList[k] = v
						end
					elseif tasktype.Type == "EVENT" then
						countevent = countevent + 1
						self._sealEventList[k] = v
					end
				end
			end
		end
	end
end

function MazeSeal:syncHeroData(counthero, herodata)
	if self._sealHeroList[counthero] and self._sealHeroList[counthero].taskValues then
		local curdata = self._sealHeroList[counthero]

		if herodata.taskStatus then
			curdata.taskStatus = herodata.taskStatus
		end
	end
end
