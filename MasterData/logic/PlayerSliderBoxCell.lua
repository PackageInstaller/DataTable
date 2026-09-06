-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/helpdragonmom/view/PlayerSliderBoxCell.lua

module("logic.extensions.helpdragonmom.view.PlayerSliderBoxCell", package.seeall)

local PlayerSliderBoxCell = class("PlayerSliderBoxCell", PlayerSliderCell)

function PlayerSliderBoxCell:ctor(luaComponentContainer)
	PlayerSliderBoxCell.super.ctor(self, luaComponentContainer)

	self._itemChange = self._item:GetComponent("UIImageSpriteChange")
end

function PlayerSliderBoxCell:_doInit()
	GameUtil.rmClickHandler(GameUtil.asBtn(self._item))
	GameUtil.addClickHandler(GameUtil.asBtn(self._item), self._onClickItem, self)
end

function PlayerSliderBoxCell:update()
	local rewardCfg = self._data
	local isGeted = self._callbackParams.isPlayerRewardGeted(rewardCfg)
	local isCanGet = self._callbackParams.isPlayerRewardCanGet(rewardCfg)

	if isGeted then
		self._itemChange:SetState(0)
		GameUtil.SetGray(self._item, true)
	elseif isCanGet then
		self._itemChange:SetState(1)
		GameUtil.SetGray(self._item, false)
	else
		self._itemChange:SetState(0)
		GameUtil.SetGray(self._item, false)
	end

	return PlayerSliderBoxCell.super.update(self)
end

function PlayerSliderBoxCell:clear()
	PlayerSliderBoxCell.super.clear(self)
	GameUtil.rmClickHandler(GameUtil.asBtn(self._item))
end

return PlayerSliderBoxCell
