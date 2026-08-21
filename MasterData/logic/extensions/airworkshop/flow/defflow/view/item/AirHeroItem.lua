-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/item/AirHeroItem.lua

module("logic.extensions.airworkshop.flow.defflow.view.item.AirHeroItem", package.seeall)

local M = class("AirHeroItem", UIReusableLuaBehavior)
local kEnableColor = "#FFFFFFFF"
local kDisableColor = "#FFFFFF66"

function M:buildUI()
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "pos/normal/headScale/heroIcon")
	self._imgQualityGrid = goutil.findChildImageComponent(self.mainGO, "pos/normal/imgQuality")
	self._imgQualityLine = goutil.findChildImageComponent(self.mainGO, "pos/normal/imgQuality/imgLine")
	self._txtLv = goutil.findChildTextComponent(self.mainGO, "pos/normal/txtLv")
	self._career = UIBattleCareer.New(goutil.findChild(self.mainGO, "pos/normal/career"))
	self._selectGo = goutil.findChild(self.mainGO, "pos/imgSelect")
	self._clickGo = goutil.findChild(self.mainGO, "pos/click")
	self._btnClick = Astral.ButtonAdapter.Get(self._clickGo)

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:OnDestroy()
	self:_unbindEvents()
	self._career:destroy()
end

function M:destroyUI()
	self:OnDestroy()
end

function M:onEnter()
	local transform = self.mainGO.transform
end

function M:onExit()
	IconLoader.clearSprite(self._imgIcon)
end

function M:setHeroMO(heroMO)
	self._heroId = heroMO:getId()
	self._txtLv.text = heroMO:getLevel()

	self._career:setCareerAndColorType(heroMO:getCareer(), heroMO:getColorType())

	local modelCO = ModelConfig.instance:getModelConfig(heroMO:getModelId())

	IconLoader.setSprite(self._imgIcon, IconType.RoleHeadIcon, modelCO.headIconName)
	IconLoader.setSprite(self._imgQualityGrid, IconType.Skinlib, CommEnum.Quality2SamllIcon[heroMO:getQuality()])
	IconLoader.setSprite(self._imgQualityLine, IconType.Skinlib, CharacterCOUtil.quality2LineName(heroMO:getQuality()))
end

function M:setSeleted(status)
	goutil.setActive(self._selectGo, status)
end

function M:setIdx(idx)
	self._idx = idx
end

function M:getHeroId()
	return self._heroId
end

function M:setClickCallBack(func, handler)
	self._clickFunc = func
	self._clickHandler = handler
end

function M:_onClick()
	if self._clickFunc then
		self._clickFunc(self._clickHandler, self._idx)
	end
end

return M
