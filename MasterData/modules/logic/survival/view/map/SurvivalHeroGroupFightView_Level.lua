-- chunkname: @modules/logic/survival/view/map/SurvivalHeroGroupFightView_Level.lua

module("modules.logic.survival.view.map.SurvivalHeroGroupFightView_Level", package.seeall)

local SurvivalHeroGroupFightView_Level = class("SurvivalHeroGroupFightView_Level", HeroGroupFightViewLevel)

function SurvivalHeroGroupFightView_Level:_btnenemyOnClick()
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	if not weekMo then
		return
	end

	local rateHard = 0
	local rateWorldLv = 0
	local fix_worldLvStr = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.SurvivalHpFixRate_WorldLv)
	local fix_hard = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.SurvivalHpFixRate_Hard)
	local worldLv = weekMo:getAttr(SurvivalEnum.AttrType.WorldLevel)

	if not string.nilorempty(fix_worldLvStr) then
		for i, v in ipairs(GameUtil.splitString2(fix_worldLvStr, true)) do
			if worldLv == v[1] then
				rateWorldLv = v[2]

				break
			end
		end
	end

	if not string.nilorempty(fix_hard) then
		for i, v in ipairs(GameUtil.splitString2(fix_hard, true)) do
			if weekMo.difficulty == v[1] then
				rateHard = v[2]

				break
			end
		end
	end

	EnemyInfoController.instance:openSurvivalEnemyInfoView(self._battleId, rateHard + rateWorldLv)
end

return SurvivalHeroGroupFightView_Level
