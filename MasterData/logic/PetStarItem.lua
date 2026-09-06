-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/panel/PetStarItem.lua

module("logic.extensions.bag.panel.PetStarItem", package.seeall)

local PetStarItem = class("PetStarItem")

function PetStarItem:ctor(go, isCell)
	self._stars = {}
	self._starBks = {}

	for i = 1, CharacterConfig.MAX_STAR_LVL do
		local star = goutil.findChild(go, "star_" .. i)

		if star then
			table.insert(self._stars, star.gameObject)
		else
			break
		end
	end

	self._layout = go:GetComponent("UILayoutSingleLine")
end

function PetStarItem:updateStar(starLv, isFirst)
	starLv = checknumber(starLv)
	starLv = math.max(1, starLv)

	local rareCfg = CharacterConfig.instance:getAwakenRareCfg(starLv)

	starLv = rareCfg.starNum

	for k, v in ipairs(self._stars) do
		goutil.setActive(v.gameObject, k <= starLv)
	end

	if self._layout then
		self._layout:Layout()
	end
end

function PetStarItem:showStarByCustom(starNum)
	for k, v in ipairs(self._stars) do
		goutil.setActive(v.gameObject, k <= starNum)
	end

	if self._layout then
		self._layout:Layout()
	end
end

function PetStarItem:getItemByIndex(i)
	if self._stars[i] then
		return self._stars[i].gameObject
	end

	return nil
end

return PetStarItem
