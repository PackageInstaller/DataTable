-- chunkname: @modules/logic/matchgame/outside/map/MatchGameMapRewardItem.lua

module("modules.logic.matchgame.outside.map.MatchGameMapRewardItem", package.seeall)

local MatchGameMapRewardItem = class("MatchGameMapRewardItem", LuaCompBase)

function MatchGameMapRewardItem:init(go)
	self.go = go
	self._imageBg = gohelper.findChildImage(go, "bg")
	self._imageIcon = gohelper.findChildImage(go, "image_Icon")
	self._txtNum = gohelper.findChildText(go, "txt_Num")
	self._goTag = gohelper.findChild(go, "go_Tag")
	self._goHasGet = gohelper.findChild(go, "go_hasget")
	self._btnClick = gohelper.findChildButtonWithAudio(go, "btn_click")
end

function MatchGameMapRewardItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function MatchGameMapRewardItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function MatchGameMapRewardItem:_btnClickOnClick()
	MatchGameController.instance:openItemTipView(self._itemId)
end

function MatchGameMapRewardItem:onUpdateMO(rewardParams, isFirstBonus, index, hasGet)
	self._rewardParams = rewardParams
	self._itemId = self._rewardParams[1]
	self._itemNum = self._rewardParams[2]
	self._index = index

	gohelper.setActive(self._goTag, isFirstBonus)
	gohelper.setActive(self._goHasGet, hasGet)

	self._txtNum.text = self._itemNum or 0

	MatchGameHelper.setItemIcon(self._itemId, self._imageIcon, self._imageBg, MatchGameEnum.ItemIconType.Large)
end

return MatchGameMapRewardItem
