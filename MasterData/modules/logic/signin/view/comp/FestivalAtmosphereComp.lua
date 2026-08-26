-- chunkname: @modules/logic/signin/view/comp/FestivalAtmosphereComp.lua

module("modules.logic.signin.view.comp.FestivalAtmosphereComp", package.seeall)

local FestivalAtmosphereComp = class("FestivalAtmosphereComp", LuaCompBase)
local TYPE_ActAtmosphereMark = typeof(ZProj.ActAtmosphereMark)
local MarkShowId = {
	CloseAct = 2,
	OpenAct = 1,
	Normal = 0
}

function FestivalAtmosphereComp:init(go)
	self._go = go

	local components = go:GetComponentsInChildren(TYPE_ActAtmosphereMark, true)

	self._markList = {}

	RoomHelper.cArrayToLuaTable(components, self._markList)
end

function FestivalAtmosphereComp:onDestroy()
	if self._markList and #self._markList > 0 then
		for i = #self._markList, 1, -1 do
			table.remove(self._markList, i)
		end
	end

	self._go = nil
end

function FestivalAtmosphereComp:setFestival(isFestival)
	local isFest = isFestival == true

	if self._isFestival == isFest or not self._markList or #self._markList < 1 then
		return
	end

	self._isFestival = isFest

	if isFest then
		if not MarkShowId.OpenAct then
			local showId = MarkShowId.CloseAct

			for i = #self._markList, 1, -1 do
				local mark = self._markList[i]
				local tShowId = mark.showId

				if tShowId == MarkShowId.Normal then
					table.remove(self._markList, i)
				else
					gohelper.setActive(mark, tShowId == showId)
				end
			end
		end
	end
end

return FestivalAtmosphereComp
