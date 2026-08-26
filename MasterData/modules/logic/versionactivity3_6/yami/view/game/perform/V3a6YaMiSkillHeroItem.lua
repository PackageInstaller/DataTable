-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/perform/V3a6YaMiSkillHeroItem.lua

module("modules.logic.versionactivity3_6.yami.view.game.perform.V3a6YaMiSkillHeroItem", package.seeall)

local V3a6YaMiSkillHeroItem = class("V3a6YaMiSkillHeroItem", V3a6YaMiHeroItem)

function V3a6YaMiSkillHeroItem:_btnclickOnClick()
	V3a6YaMiHeroSkillListModel.instance:selectCell(self._index, true)
	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onSelectSkillHero)
end

return V3a6YaMiSkillHeroItem
