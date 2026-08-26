-- chunkname: @modules/logic/bossrush/view/v3a9/V3a9_BossRush_MainActHeroTeam.lua

module("modules.logic.bossrush.view.v3a9.V3a9_BossRush_MainActHeroTeam", package.seeall)

local V3a9_BossRush_MainActHeroTeam = class("V3a9_BossRush_MainActHeroTeam", ListScrollCellExtend)

function V3a9_BossRush_MainActHeroTeam:onInitView()
	self._goHead = gohelper.findChild(self.viewGO, "#go_Head")
	self._simageHeadIcon = gohelper.findChildSingleImage(self.viewGO, "#go_Head/#simage_HeadIcon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_MainActHeroTeam:addEvents()
	return
end

function V3a9_BossRush_MainActHeroTeam:removeEvents()
	return
end

function V3a9_BossRush_MainActHeroTeam:_editableInitView()
	self._heroItems = self:getUserDataTb_()

	gohelper.setActive(self._goHead, false)
end

function V3a9_BossRush_MainActHeroTeam:_editableAddEvents()
	return
end

function V3a9_BossRush_MainActHeroTeam:_editableRemoveEvents()
	return
end

function V3a9_BossRush_MainActHeroTeam:onUpdateMO(mo, stage)
	self._mo = mo

	local count = 0

	for i = 1, V3a9BossRushEnum.HeroCount do
		local heroMo = V3a9_BossRushModel.instance:getTeamHeroMo(i, stage)
		local heroId = heroMo and heroMo.heroId

		count = count + 1

		local item = self:_getHeroItem(count)
		local isHas = heroMo ~= nil

		if isHas then
			local config = HeroConfig.instance:getHeroCO(heroId)

			if heroMo then
				if not heroMo.skin then
					local skin = config.skinId
					local skinConfig = SkinConfig.instance:getSkinCo(skin)

					item.simageHeadIcon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.headIcon))
				end
			end
		end

		gohelper.setActive(item.simageHeadIcon.gameObject, isHas)
	end

	for i, item in ipairs(self._heroItems) do
		gohelper.setActive(item.go, i <= count)
	end
end

function V3a9_BossRush_MainActHeroTeam:_getHeroItem(index)
	local item = self._heroItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._goHead, "hero_" .. index)
		item.simageHeadIcon = gohelper.findChildSingleImage(item.go, "#simage_HeadIcon")
		self._heroItems[index] = item
	end

	return item
end

function V3a9_BossRush_MainActHeroTeam:onSelect(isSelect)
	return
end

function V3a9_BossRush_MainActHeroTeam:onDestroyView()
	for _, item in ipairs(self._heroItems) do
		item.simageHeadIcon:UnLoadImage()
	end
end

return V3a9_BossRush_MainActHeroTeam
