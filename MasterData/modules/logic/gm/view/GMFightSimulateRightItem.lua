-- chunkname: @modules/logic/gm/view/GMFightSimulateRightItem.lua

module("modules.logic.gm.view.GMFightSimulateRightItem", package.seeall)

local GMFightSimulateRightItem = class("GMFightSimulateRightItem", ListScrollCell)
local SelectColor = Color.New(1, 0.8, 0.8, 1)
local NotSelectColor = Color.white
local PrevSelectId

function GMFightSimulateRightItem:init(go)
	self._btn = gohelper.findChildButtonWithAudio(go, "btn")

	self._btn:AddClickListener(self._onClickItem, self)

	self._imgBtn = gohelper.findChildImage(go, "btn")
	self._txtName = gohelper.findChildText(go, "btn/Text")
end

function GMFightSimulateRightItem:onUpdateMO(mo)
	self._episodeCO = mo
	self._txtName.text = self._episodeCO.name

	if self._episodeCO.id == PrevSelectId then
		self._imgBtn.color = SelectColor or NotSelectColor
	end
end

function GMFightSimulateRightItem:_onClickItem()
	PrevSelectId = self._episodeCO.id
	self._imgBtn.color = SelectColor

	self._view:closeThis()

	if DungeonModel.isBattleEpisode(self._episodeCO) then
		JumpModel.instance.jumpFromFightSceneParam = "99"

		DungeonFightController.instance:enterFight(self._episodeCO.chapterId, self._episodeCO.id)
	else
		logError("GMToolView 不支持该类型的关卡" .. self._episodeCO.id)
	end
end

function GMFightSimulateRightItem:onDestroy()
	if self._btn then
		self._btn:RemoveClickListener()

		self._btn = nil
	end
end

return GMFightSimulateRightItem
