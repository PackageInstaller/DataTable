-- chunkname: @modules/logic/fight/view/FightSuccessCachotHeroView.lua

module("modules.logic.fight.view.FightSuccessCachotHeroView", package.seeall)

local FightSuccessCachotHeroView = class("FightSuccessCachotHeroView", BaseView)

function FightSuccessCachotHeroView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "#go_cachot_herogroup")
	self._heroItemParent = gohelper.findChild(self._goroot, "layout")
	self._heroItem = gohelper.findChild(self._goroot, "layout/heroitem")
	self._txtLv = gohelper.findChild(self.viewGO, "goalcontent/txtLv")
end

function FightSuccessCachotHeroView:onOpen()
	gohelper.setActive(self._txtLv, false)
	gohelper.setActive(self._goroot, true)

	local allHeros = {}
	local teamInfo = V1a6_CachotModel.instance:getTeamInfo()

	if not teamInfo then
		return
	end

	local groupInfo = teamInfo:getCurGroupInfo()

	if groupInfo then
		for _, v in ipairs(groupInfo.heroList) do
			local heroMo = HeroModel.instance:getById(v)

			if heroMo then
				local nowHp = teamInfo:getHeroHp(heroMo.heroId)
				local skinId = heroMo.skin

				if skinId == 0 then
					skinId = lua_character.configDict[heroMo.heroId].skinId
				end

				table.insert(allHeros, {
					skinId = heroMo.skin,
					nowHp = nowHp.life / 1000,
					heroId = heroMo.heroId
				})
			end
		end
	end

	gohelper.CreateObjList(self, self._onHeroItemCreate, allHeros, self._heroItemParent, self._heroItem)
end

function FightSuccessCachotHeroView:_onHeroItemCreate(obj, data, index)
	local slider = gohelper.findChildSlider(obj, "#slider_hp")
	local icon = gohelper.findChildSingleImage(obj, "hero/#simage_rolehead")
	local dead = gohelper.findChild(obj, "#dead")

	slider:SetValue(data.nowHp)
	gohelper.setActive(dead, data.nowHp <= 0)

	local skinCo = lua_skin.configDict[data.skinId]

	icon:LoadImage(ResUrl.getHeadIconSmall(skinCo.headIcon))
	ZProj.UGUIHelper.SetGrayscale(icon.gameObject, data.nowHp <= 0)
end

function FightSuccessCachotHeroView:onClose()
	return
end

return FightSuccessCachotHeroView
