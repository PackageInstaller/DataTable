-- chunkname: @modules/logic/matchgame/outside/character/MatchGameDevelopCharacterListItem.lua

module("modules.logic.matchgame.outside.character.MatchGameDevelopCharacterListItem", package.seeall)

local MatchGameDevelopCharacterListItem = class("MatchGameDevelopCharacterListItem", SimpleListItem)

function MatchGameDevelopCharacterListItem:onInit(viewGO)
	self._goSelect = gohelper.findChild(self.viewGO, "go_Select")
	self._goLock = gohelper.findChild(self.viewGO, "go_Lock")
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "image_Icon")
	self._imageCareer = gohelper.findChildImage(self.viewGO, "image_Career")
	self._txtLevel = gohelper.findChildText(self.viewGO, "levelBg/txt_Level")
	self._goActiveEffect = gohelper.findChild(self.viewGO, "go_Lock/unlockable_eff")
end

function MatchGameDevelopCharacterListItem:onItemShow(data)
	self._characterCo = data
	self._characterId = data.characterId
	self._characterMo = MatchGameModel.instance:getCharacterMo(self._characterId)

	self:refreshUI()
end

function MatchGameDevelopCharacterListItem:refreshUI()
	local status = MatchGameModel.instance:getCharacterStatus(self._characterId)
	local isLock = status <= MatchGameEnum.CharacterStatus.Lock

	gohelper.setActive(self._goLock, isLock)
	MatchGameHelper.setCharacterElement(self._characterCo.elementId, self._imageCareer)

	if self._characterMo then
		if not self._characterMo.level then
			local level = 1

			self._txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_malllevelupview_level"), level)

			self._simageIcon:LoadImage(ResUrl.getHeadIconSmall(self._characterCo.icon))
		end
	end
end

function MatchGameDevelopCharacterListItem:onSelectChange(isSelect)
	gohelper.setActive(self._goSelect, isSelect)
end

function MatchGameDevelopCharacterListItem:onDestroy()
	self._simageIcon:UnLoadImage()
end

return MatchGameDevelopCharacterListItem
