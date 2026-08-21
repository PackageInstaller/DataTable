-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveCardCutlinePreviewItemView.lua

module("logic.extensions.retrieve.view.RetrieveCardCutlinePreviewItemView", package.seeall)

local M = class("RetrieveCardCutlinePreviewItemView")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	self._imgQuality = self._viewElementsRegistry:findUIElement("0&hero_item_29007724", UIComponentType.Image)
	self._imgQuality1 = self._viewElementsRegistry:findUIElement("hero_item_-1565489570", UIComponentType.Image)
	self._imgHead = self._viewElementsRegistry:findUIElement("0&battle_hero_item_892867850", UIComponentType.Image)
	self._goCareer = self._viewElementsRegistry:findUIElement("0&0&career_475494592")
	self._txtName = self._viewElementsRegistry:findUIElement("retrieve_hero_preview_item_71920226", UIComponentType.Text)
	self._upGo = self._viewElementsRegistry:findUIElement("retrieve_hero_preview_item_727108574")
	self._pickedTipGo = self._viewElementsRegistry:findUIElement("retrieve_hero_preview_item_-128650467")

	goutil.setActive(self._findGo, false)
	goutil.setActive(self._pickedTipGo, false)
	goutil.setActive(self._txtName.gameObject, true)
	goutil.setActive(self._goCareer, true)

	self._btnClick = ButtonAdapter.Get(self._viewElementsRegistry:findUIElement("0&battle_hero_item_-1904829982"))

	self._btnClick:AddClickListener(self._clickSelf, self)
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:_updateView(data, curType, lotteryData)
	self._type = curType
	self._data = data

	local quality = 1
	local name = ""

	goutil.setActive(self._imgHead.gameObject, self._type == RetrieveEnum.LotterySimpleType.Card)

	local characterCO = CharacterConfig.instance:getCfgInfoByID(data.itemCode)
	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(data.itemCode)

	quality = characterCO.quality
	name = heroInfoCO.name

	local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)

	IconLoader.setSprite(self._imgHead, IconType.RoleHeadIcon, modelCO.headIconName)

	self._txtName.text = name

	IconLoader.setSprite(self._imgQuality1, IconType.Skinlib, CommEnum.Quality2LineName[quality])
	IconLoader.setSprite(self._imgQuality, IconType.Skinlib, CommEnum.Quality2SamllIcon[quality])
	goutil.setActive(self._upGo, LotteryUtil.isProbabilityUp(data))
	goutil.setActive(self._pickedTipGo, lotteryData and data.itemCode == lotteryData:getPicked())

	local careerCell = Astral.SimpleLuaComponentContainer.Add(self._goCareer, CareerCell)

	careerCell:setData(data.itemCode)
end

function M:_clickSelf()
	CharacterUtil.openCharacterPreviewView(self._data.itemCode)
end

function M:showPreviewView()
	goutil.setActive(self._upGo, false)
	goutil.setActive(self._findGo, true)
	goutil.setActive(self._txtName.gameObject, false)
end

function M:OnDestroy()
	self._viewElementsRegistry:cleanRegistry()

	self._viewElementsRegistry = nil

	self._btnClick:RemoveClickListener()
end

return M
