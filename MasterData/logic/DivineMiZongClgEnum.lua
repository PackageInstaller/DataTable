-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemizongclg/data/DivineMiZongClgEnum.lua

module("logic.extensions.divinemizongclg.data.DivineMiZongClgEnum", package.seeall)

local DivineMiZongClgEnum = {}

DivineMiZongClgEnum.TeamPosCoordinates = {
	[GameEnum.BattleTeam.Left] = {
		9,
		6,
		3,
		8,
		5,
		2,
		7,
		4,
		1
	},
	[GameEnum.BattleTeam.Right] = {
		3,
		6,
		9,
		2,
		5,
		8,
		1,
		4,
		7
	}
}
DivineMiZongClgEnum.StageBgFields = {
	"nearBg",
	"middleBg",
	"farBg"
}
DivineMiZongClgEnum.FmtSize_Width = 3
DivineMiZongClgEnum.FmtSize_Height = 3

function DivineMiZongClgEnum.GetNbrPosIds(centerPosId, teamId)
	local posIds = {}
	local coordinates = DivineMiZongClgEnum.TeamPosCoordinates[teamId]
	local coordIdx = table.indexof(coordinates, centerPosId)

	if coordIdx then
		local width, height = DivineMiZongClgEnum.FmtSize_Width, DivineMiZongClgEnum.FmtSize_Height
		local coordX, coordY = MmUtil.getPos(coordIdx, width, height)

		for _, toward in pairs(MmUtil.Towards) do
			local nbrX, nbrY = MmUtil.getNeighborPos(coordX, coordY, width, height, toward)

			if nbrX and nbrX then
				local idx = MmUtil.getPosIndex(nbrX, nbrY, width, height)
				local posId = coordinates[idx]

				if posId then
					table.insert(posIds, posId)
				end
			end
		end
	end

	return posIds
end

return DivineMiZongClgEnum
