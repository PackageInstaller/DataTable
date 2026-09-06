-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/view/item/FishingGameFloatTextItem.lua

module("logic.extensions.aoqiattackforce.view.item.FishingGameFloatTextItem", package.seeall)

local FishingGameFloatTextItem = class("FishingGameFloatTextItem", AQAFFloatItem)

function FishingGameFloatTextItem:setContent(content)
	local contentText = self:getContentText()
	local num = checknumber(content)

	contentText:SetText(content)
	GameUtil.SetActive(self._contentText.gameObject, num ~= 0)
end

return FishingGameFloatTextItem
