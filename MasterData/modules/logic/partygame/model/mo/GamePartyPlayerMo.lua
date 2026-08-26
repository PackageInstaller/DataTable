-- chunkname: @modules/logic/partygame/model/mo/GamePartyPlayerMo.lua

module("modules.logic.partygame.model.mo.GamePartyPlayerMo", package.seeall)

local GamePartyPlayerMo = class("GamePartyPlayerMo")
local colors = {
	"#FFB762",
	"#FFE84C",
	"#7ABAFF",
	"#7FEBD0",
	"#B4EF84",
	"#EBC2FF",
	"#FF8B8B"
}
local teamColor = {
	[PartyGameEnum.GamePlayerTeamType.Red] = "#FF8B8B",
	[PartyGameEnum.GamePlayerTeamType.Blue] = "#7ABAFF"
}

function GamePartyPlayerMo:ctor()
	self.uid = nil
	self.name = ""
	self.state = 0
	self.isRobot = 0
	self.index = -1
	self.tempType = PartyGameEnum.GamePlayerTeamType.None
	self.skinIds = {}
	self.cardIds = {}
	self.hp = 0
	self.whiteColor = GameUtil.parseColor("#FFFFFF")
end

function GamePartyPlayerMo:update(data)
	self.uid = data.Uid
	self.name = data.Name
	self.state = data.State
	self.isRobot = data.IsRobot
	self.index = data.Index
	self.tempType = data.TeamType
	self.hp = data.Hp

	if data.SkinIds then
		local skinIds = data.SkinIds

		tabletool.clear(self.skinIds)

		for i = 0, skinIds.Count - 1 do
			table.insert(self.skinIds, skinIds[i])
		end
	end

	if data.CardIds then
		local cardIds = data.CardIds

		tabletool.clear(self.cardIds)

		for i = 0, cardIds.Count - 1 do
			table.insert(self.cardIds, cardIds[i])
		end
	end
end

function GamePartyPlayerMo:getColorName()
	if not self.colorName then
		if teamColor[self.tempType] then
			self.colorName = string.format("<color=%s>%s</color>", teamColor[self.tempType], self.name)
			self.color = GameUtil.parseColor(teamColor[self.tempType])
		elseif self:isMainPlayer() then
			self.colorName = self.name
			self.color = self.whiteColor
		else
			local index = self.index

			if index == 8 then
				local list = PartyGameModel.instance:getCurGamePlayerList()

				for k, v in pairs(list) do
					if v:isMainPlayer() then
						index = v.index

						break
					end
				end
			end

			self.color = GameUtil.parseColor(colors[index])
			self.colorName = string.format("<color=%s>%s</color>", colors[index], self.name)
		end
	end

	return self.colorName, self.color
end

function GamePartyPlayerMo:isMainPlayer()
	local curGame = PartyGameController.instance:getCurPartyGame()

	if not curGame or curGame:getIsLocal() then
		return self.isRobot == 0
	end

	return tostring(self.uid) == tostring(curGame:getMainPlayerUid())
end

return GamePartyPlayerMo
