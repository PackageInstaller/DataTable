-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_HeroGroup.lua

module("modules.logic.bossrush.view.V1a4_BossRush_HeroGroup", package.seeall)

local V1a4_BossRush_HeroGroup = class("V1a4_BossRush_HeroGroup", LuaCompBase)

function V1a4_BossRush_HeroGroup:ctor(parentViewContainer)
	self._parentViewContainer = parentViewContainer
end

function V1a4_BossRush_HeroGroup:init(go)
	local transform = go.transform
	local childCount = transform.childCount

	self._groupList = self:getUserDataTb_()

	for i = 0, childCount - 1 do
		local groupTran = transform:GetChild(i)
		local list = self:getUserDataTb_()

		for j = 0, i do
			local itemTran = groupTran:GetChild(j)
			local itemGo = itemTran.gameObject

			table.insert(list, itemGo)
		end

		table.insert(self._groupList, list)
	end

	self._go = go
end

function V1a4_BossRush_HeroGroup:_createHeroItem(parentGO, heroMo, equipMo)
	local itemClass, resPath

	if equipMo then
		itemClass = V1a4_BossRush_HeroGroupItem1
		resPath = BossRushEnum.ResPath.v1a4_bossrush_herogroupitem1
	else
		itemClass = V1a4_BossRush_HeroGroupItem2
		resPath = BossRushEnum.ResPath.v1a4_bossrush_herogroupitem2
	end

	local go = self._parentViewContainer:getResInst(resPath, parentGO or self._go, itemClass.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)
end

function V1a4_BossRush_HeroGroup:setDataByFightParam(fightParam)
	local heroEquipMoList = fightParam:getHeroEquipMoList()
	local n = math.min(#self._groupList, #heroEquipMoList)
	local group = self._groupList[n]

	self._heroList = {}

	for i, v in ipairs(heroEquipMoList) do
		local go = group[i]
		local heroMo = v.heroMo
		local equipMo = v.equipMo
		local item = self:_createHeroItem(go, heroMo, equipMo)

		item:setData(heroMo, equipMo)

		self._heroList[i] = item
	end
end

function V1a4_BossRush_HeroGroup:setDataByCurFightParam()
	self:setDataByFightParam(FightModel.instance:getFightParam())
end

function V1a4_BossRush_HeroGroup:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_heroList")
end

return V1a4_BossRush_HeroGroup
