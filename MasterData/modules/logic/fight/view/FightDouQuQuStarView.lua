-- chunkname: @modules/logic/fight/view/FightDouQuQuStarView.lua

module("modules.logic.fight.view.FightDouQuQuStarView", package.seeall)

local FightDouQuQuStarView = class("FightDouQuQuStarView", FightBaseView)

function FightDouQuQuStarView:onInitView()
	self.img = gohelper.findChildImage(self.viewGO, "root/quality/bg/#image_quality")
end

function FightDouQuQuStarView:addEvents()
	return
end

function FightDouQuQuStarView:onConstructor(entityMO)
	self.entityMO = entityMO
end

function FightDouQuQuStarView:refreshEntityMO(entityMO)
	self.entityMO = entityMO

	if self.viewGO then
		self:refreshStar()
	end
end

function FightDouQuQuStarView:onOpen()
	self.customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]

	self:refreshStar()
end

function FightDouQuQuStarView:refreshStar()
	local data = self.customData.teamAHeroInfo
	local star = 0

	for k, v in pairs(data) do
		if tonumber(k) == self.entityMO.modelId then
			local arr = string.splitToNumber(v, "#")

			star = arr[1]

			break
		end
	end

	if star == 0 then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	self.img.fillAmount = star / Activity191Enum.CharacterMaxStar
end

return FightDouQuQuStarView
