-- chunkname: @modules/logic/versionactivity1_2/yaxian/model/game/YaXianGameStatusMo.lua

module("modules.logic.versionactivity1_2.yaxian.model.game.YaXianGameStatusMo", package.seeall)

local YaXianGameStatusMo = pureTable("YaXianGameStatusMo")

function YaXianGameStatusMo.NewFunc()
	return YaXianGameStatusMo.New()
end

function YaXianGameStatusMo:resetFunc()
	self.status = nil
	self.directionList = nil
end

function YaXianGameStatusMo:releaseFunc()
	self:resetFunc()
end

function YaXianGameStatusMo:addStatus(status, direction)
	self.status = status

	if direction then
		self.directionList = self.directionList or {}

		if not tabletool.indexOf(self.directionList, direction) then
			table.insert(self.directionList, direction)
		end
	end
end

return YaXianGameStatusMo
