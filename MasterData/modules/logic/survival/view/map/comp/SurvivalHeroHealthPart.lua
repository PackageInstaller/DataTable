-- chunkname: @modules/logic/survival/view/map/comp/SurvivalHeroHealthPart.lua

module("modules.logic.survival.view.map.comp.SurvivalHeroHealthPart", package.seeall)

local SurvivalHeroHealthPart = class("SurvivalHeroHealthPart", LuaCompBase)

function SurvivalHeroHealthPart:init(go)
	self._states = self:getUserDataTb_()
	self._statesimage = self:getUserDataTb_()

	for i = 1, 3 do
		self._states[i] = gohelper.findChild(go, "#go_hp/#go_State" .. i)
		self._statesimage[i] = self._states[i].transform:GetChild(i - 1).gameObject:GetComponent(gohelper.Type_Image)
	end

	self._goFrame1 = gohelper.findChild(go, "#go_Frame/frame_hp1")
	self._goFrame2 = gohelper.findChild(go, "#go_Frame/frame_hp2")
	self._goDead = gohelper.findChild(go, "#go_dead")
	self._txtHealth = gohelper.findChildTextMesh(go, "#go_hp/txt_Health")
end

function SurvivalHeroHealthPart:setHeroId(heroId)
	local heroHealthMo = SurvivalShelterModel.instance:getWeekInfo():getHeroMo(heroId)
	local curState, amout = heroHealthMo:getCurState()

	if amout > 0 and amout < 0.1 then
		amout = 0.1
	end

	for i = 1, 3 do
		gohelper.setActive(self._states[i], curState == i)
	end

	if self._statesimage[curState] then
		self._statesimage[curState].fillAmount = amout
	end

	gohelper.setActive(self._goDead, curState == 0)
	gohelper.setActive(self._goFrame1, heroHealthMo.status == SurvivalEnum.HeroStatu.Normal and curState == 2)
	gohelper.setActive(self._goFrame2, heroHealthMo.status == SurvivalEnum.HeroStatu.Hurt and curState ~= 0)
end

function SurvivalHeroHealthPart:setTxtHealthWhite()
	if gohelper.isNil(self._txtHealth) then
		return
	end

	SLFramework.UGUI.GuiHelper.SetColor(self._txtHealth, "#FFFFFF")
end

return SurvivalHeroHealthPart
