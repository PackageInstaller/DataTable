-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/HeroBoardItemCell.lua

module("logic.extensions.playerinfo.view.info.HeroBoardItemCell", package.seeall)

local M = class("HeroBoardItemCell")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._rootGo = registry:findUIElement("player_show_item_374127036")
	self._heroImg = registry:findUIElement("player_show_item_1633132192", UIComponentType.Image)
	self._selectFlag = registry:findUIElement("player_show_item_1246602052")
	self._nameTxt = registry:findUIElement("player_show_item_624827211", UIComponentType.Text)
	self._imgQuality = registry:findUIElement("player_show_item_1050195062", UIComponentType.Image)
	self._btnClick = ButtonAdapter.Get(registry:findUIElement("player_show_item_34257852"))

	self._btnClick:AddClickListener(self._clickSelf, self)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterDepot)
end

function M:_clickSelf()
	GlobalDispatcher:dispatchEvent(EventType.CHANGE_PLAYER_DISPLAYHERO_SUC, self._curHeroId, 0)
end

function M:updateData(heroId, displayHero)
	self._curHeroId = heroId

	goutil.setActive(self._selectFlag, displayHero == heroId)

	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(heroId)

	self._nameTxt.text = heroInfoCO and heroInfoCO.name or ""

	local characterCO = CharacterConfig.instance:getCfgInfoByID(heroId)

	if characterCO then
		IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_CharacterDepot, CommEnum.Quality2CardBg[characterCO.quality])
	end

	local modelId = characterCO and characterCO.modelId or nil
	local modelCO = modelId and ModelConfig.instance:getModelConfig(modelId) or nil

	if modelCO then
		IconLoader.setSprite(self._heroImg, IconType.RoleCard, modelCO.halfIconName)
	end
end

function M:OnDestroy()
	self._compContainer = nil
	self._go = nil
	self._trs = nil
	self._curHeroId = nil

	self._btnClick:RemoveClickListener()

	self._btnClick = nil

	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterDepot)
end

return M
