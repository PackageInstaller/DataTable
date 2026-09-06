-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/view/fmtview/HexagramFmtRightView.lua

module("logic.extensions.yirenpozhen.view.fmtview.HexagramFmtRightView", package.seeall)

local HexagramFmtRightView = class("HexagramFmtRightView", FormationRightView)

function HexagramFmtRightView:getAllShowPetList()
	return YirenPozhenModel.instance:getAllPetList(true)
end

function HexagramFmtRightView:setCurViewDatas()
	self._curViewDatas = {}

	local pets = self:getAllShowPetList()
	local map = {}

	for k, v in pairs(pets) do
		self._curPetMap[v.petId] = v

		if map[v.raceId] == nil or v:isSummonedPet() or checknumber(v.summonedPetId) > 0 then
			map[v.raceId] = v

			if self:onFilter(v) then
				self._curViewDatas[#self._curViewDatas + 1] = v
			end
		end
	end
end

return HexagramFmtRightView
