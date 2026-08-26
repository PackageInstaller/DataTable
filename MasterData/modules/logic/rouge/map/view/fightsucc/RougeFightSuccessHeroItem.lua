-- chunkname: @modules/logic/rouge/map/view/fightsucc/RougeFightSuccessHeroItem.lua

module("modules.logic.rouge.map.view.fightsucc.RougeFightSuccessHeroItem", package.seeall)

local RougeFightSuccessHeroItem = class("RougeFightSuccessHeroItem", RougeLuaCompBase)

function RougeFightSuccessHeroItem:init(go)
	RougeFightSuccessHeroItem.super.init(self, go)

	self.go = go
	self.slider = gohelper.findChildSlider(go, "#slider_hp")
	self.simageRole = gohelper.findChildSingleImage(go, "hero/#simage_rolehead")
	self.goDead = gohelper.findChild(go, "#go_dead")
end

function RougeFightSuccessHeroItem:refreshHero(heroMo)
	local heroId = heroMo and heroMo.heroId

	if heroId ~= 0 then
		gohelper.setActive(self.go, true)

		local headIcon = self:getHeroHeadIcon(heroId)

		self.simageRole:LoadImage(ResUrl.getRoomHeadIcon(headIcon))

		local fightResultInfo = RougeModel.instance:getFightResultInfo()
		local life = fightResultInfo and fightResultInfo:getLife(heroId)

		if life <= 0 then
			self.slider:SetValue(0)
			gohelper.setActive(self.goDead, true)
		else
			self.slider:SetValue(life / 1000)
			gohelper.setActive(self.goDead, false)
		end

		self:tickUpdateDLCs(heroMo)
	end
end

function RougeFightSuccessHeroItem:getHeroHeadIcon(heroId)
	local teamInfo = RougeModel.instance:getTeamInfo()
	local isAssist = teamInfo and teamInfo:isAssistHero(heroId)
	local heroMo = isAssist and teamInfo:getAssistHeroMo() or HeroModel.instance:getByHeroId(heroId)
	local skinId = heroMo and heroMo.skin
	local skinCo = skinId and lua_skin.configDict[skinId]

	return (skinCo or nil) and (skinCo.headIcon or heroId .. "01")
end

function RougeFightSuccessHeroItem:onDestroyView()
	self.simageRole:UnLoadImage()
end

return RougeFightSuccessHeroItem
