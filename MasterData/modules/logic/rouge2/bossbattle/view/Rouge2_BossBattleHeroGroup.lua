-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_BossBattleHeroGroup.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_BossBattleHeroGroup", package.seeall)

local Rouge2_BossBattleHeroGroup = class("Rouge2_BossBattleHeroGroup", LuaCompBase)

function Rouge2_BossBattleHeroGroup:ctor(parentViewContainer)
	self._parentViewContainer = parentViewContainer
end

function Rouge2_BossBattleHeroGroup:init(go)
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

function Rouge2_BossBattleHeroGroup:_createHeroItem(parentGO, heroMo, equipMo)
	local itemClass, resPath

	if equipMo then
		itemClass = Rouge2_BossBattleHeroGroupItem1
		resPath = Rouge2_Enum.ResPath.BossBattleHeroGroupItem1
	else
		itemClass = Rouge2_BossBattleHeroGroupItem2
		resPath = Rouge2_Enum.ResPath.BossBattleHeroGroupItem2
	end

	local go = self._parentViewContainer:getResInst(resPath, parentGO or self._go, itemClass.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)
end

function Rouge2_BossBattleHeroGroup:setDataByFightParam(fightParam)
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

function Rouge2_BossBattleHeroGroup:setDataByCurFightParam()
	self:setDataByFightParam(FightModel.instance:getFightParam())
end

function Rouge2_BossBattleHeroGroup:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_heroList")
end

return Rouge2_BossBattleHeroGroup
