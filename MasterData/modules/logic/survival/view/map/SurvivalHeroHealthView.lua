-- chunkname: @modules/logic/survival/view/map/SurvivalHeroHealthView.lua

module("modules.logic.survival.view.map.SurvivalHeroHealthView", package.seeall)

local SurvivalHeroHealthView = class("SurvivalHeroHealthView", BaseView)

function SurvivalHeroHealthView:onInitView()
	self._slider2 = gohelper.findChildImage(self.viewGO, "Bottom/#go_resistance/bg2")
	self._imagebg = gohelper.findChildImage(self.viewGO, "Bottom/#go_resistance/resistance")
	self._anim = self._imagebg:GetComponent(typeof(UnityEngine.Animation))
	self._txtstatu = gohelper.findChildTextMesh(self.viewGO, "Bottom/#go_resistance/resistance/#txt_resistance")
	self._scrollbar = gohelper.findChildScrollbar(self.viewGO, "Bottom/#go_resistance/Scrollbar Horizon")
end

function SurvivalHeroHealthView:addEvents()
	SurvivalController.instance:registerCallback(SurvivalEvent.OnSurvivalHeroHealthUpdate, self._refreshHealth, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnDerivedUpdate, self._refreshHealth, self)
end

function SurvivalHeroHealthView:removeEvents()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnSurvivalHeroHealthUpdate, self._refreshHealth, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnDerivedUpdate, self._refreshHealth, self)
end

function SurvivalHeroHealthView:onOpen()
	self:_refreshHealth()
end

local colors = {
	"#C84827",
	"#C3C827",
	"#38CF6F"
}

function SurvivalHeroHealthView:_refreshHealth()
	local max = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.HeroHealthMax)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local teamInfo = SurvivalMapModel.instance:getSceneMo().teamInfo
	local cur = 0
	local total = 0

	for i, v in ipairs(teamInfo.heros) do
		local heroMo = teamInfo:getHeroMo(v)
		local healthMo = weekInfo:getHeroMo(heroMo.heroId)

		cur = cur + healthMo.health
		total = total + max
	end

	local per = cur / total
	local valStr, langStr = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.TeamHealthState)
	local state = 1
	local arr = string.splitToNumber(valStr, "#")
	local strArr = string.split(langStr, "#")

	for k, v in ipairs(arr) do
		if per >= v / 100 then
			state = k
		end
	end

	if not strArr[state] then
		local stateStr = ""

		self._scrollbar:SetValue(per)

		self._slider2.fillAmount = per
		self._imagebg.color = GameUtil.parseColor(colors[state] or colors[1])
		self._txtstatu.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_mainview_teamhealth"), stateStr)

		if self.state and state ~= self.state then
			self._anim:Play()
		end

		self.state = state
	end
end

return SurvivalHeroHealthView
