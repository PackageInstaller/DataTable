-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleTopCell.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleTopCell", package.seeall)

local MahjongBattleTopCell = class("MahjongBattleTopCell", CustomRightCell)

MahjongBattleTopCell.prefabUrl = "ui/views/mahjongbattle/mahjongbattletopcell.prefab"

function MahjongBattleTopCell:buildUI()
	self._conStars = goutil.findChild(self.mainGO, "stars")
	self._starList = {}

	for i = 1, 6 do
		self._starList[i] = goutil.findChild(self._conStars, "star_" .. i)
	end
end

function MahjongBattleTopCell:checkAndShowIcon(activityId, awakenLevel)
	local showNum = checknumber(awakenLevel)

	if showNum > 0 then
		goutil.setActive(self._conStars, true)

		for i, go in ipairs(self._starList) do
			goutil.setActive(go, i <= showNum)
		end
	else
		goutil.setActive(self._conStars, false)
	end
end

function MahjongBattleTopCell:onExit()
	return
end

return MahjongBattleTopCell
