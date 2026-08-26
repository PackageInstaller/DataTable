-- chunkname: @modules/logic/survival/view/map/comp/SurvivalWeightPart.lua

module("modules.logic.survival.view.map.comp.SurvivalWeightPart", package.seeall)

local SurvivalWeightPart = class("SurvivalWeightPart", LuaCompBase)

function SurvivalWeightPart:ctor(bag)
	if bag == nil then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		bag = weekInfo:getBag(SurvivalEnum.ItemSource.Map)
	end

	self.bag = bag
end

function SurvivalWeightPart:init(go)
	self._anim = gohelper.findChildAnim(go, "")
	self._scrollbar = gohelper.findChildScrollbar(go, "Scrollbar Horizon")
	self._image_zhizhen = gohelper.findChildImage(go, "Scrollbar Horizon/Sliding Area/Handle/#image_zhizhen")
	self._image_icon = gohelper.findChildImage(go, "#image_icon")
	self._txtmass1 = gohelper.findChildTextMesh(go, "#go_mass/#txt_mass1")
	self._txtmass2 = gohelper.findChildTextMesh(go, "#go_mass/#txt_mass2")
	self._txtmass3 = gohelper.findChildTextMesh(go, "#go_mass/#txt_mass3")

	self:refreshView()
end

function SurvivalWeightPart:addEventListeners()
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapBagUpdate, self.refreshView, self)
end

function SurvivalWeightPart:removeEventListeners()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapBagUpdate, self.refreshView, self)
end

function SurvivalWeightPart:refreshView()
	local bagMo = self.bag
	local maxWeightLimit = bagMo:getMaxWeightLimit()
	local value = bagMo.totalMass / maxWeightLimit
	local massNum = string.format("%s/%s", bagMo.totalMass, maxWeightLimit)
	local statu = 1

	if value > 1 then
		statu = 3
	end

	for i = 1, 3 do
		self["_txtmass" .. i].text = i == statu and massNum or ""
	end

	UISpriteSetMgr.instance:setSurvivalSprite(self._image_icon, "survival_bag_heavyicon_" .. statu)
	UISpriteSetMgr.instance:setSurvivalSprite(self._image_zhizhen, "survival_bag_zhizhen_" .. statu)

	value = Mathf.Clamp01(value)

	self._scrollbar:SetValue(value)

	if self._anim then
		self._anim:Play("step" .. statu, 0, 0)
	end
end

return SurvivalWeightPart
