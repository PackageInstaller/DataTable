-- chunkname: @modules/logic/playercard/view/comp/PlayerCardAchievementSelectIcon.lua

module("modules.logic.playercard.view.comp.PlayerCardAchievementSelectIcon", package.seeall)

local PlayerCardAchievementSelectIcon = class("PlayerCardAchievementSelectIcon", UserDataDispose)

function PlayerCardAchievementSelectIcon:init(go, iconGO)
	self:__onInit()

	self.viewGO = go
	self.iconGO = iconGO

	self:initComponents()
end

function PlayerCardAchievementSelectIcon:initComponents()
	self._goicon = gohelper.findChild(self.viewGO, "#go_icon")
	self._icon = AchievementMainIcon.New()

	self._icon:init(self.iconGO)
	self._icon:setClickCall(self.onClickSelf, self)
	gohelper.addChild(self._goicon, self.iconGO)
end

function PlayerCardAchievementSelectIcon:setData(taskCO)
	self.taskCO = taskCO

	self:refreshUI()
end

function PlayerCardAchievementSelectIcon:refreshUI()
	self._icon:setData(self.taskCO)
	self._icon:setBgVisible(true)

	local isSelected = PlayerCardAchievementSelectListModel.instance:isSingleSelected(self.taskCO.id)

	self._icon:setSelectIconVisible(isSelected)

	if isSelected then
		self._icon:setSelectIndex(PlayerCardAchievementSelectListModel.instance:getSelectOrderIndex(self.taskCO.id))
	end
end

function PlayerCardAchievementSelectIcon:onClickSelf()
	PlayerCardAchievementSelectController.instance:changeSingleSelect(self.taskCO.id)

	local isSelected = PlayerCardAchievementSelectListModel.instance:isSingleSelected(self.taskCO.id)

	AudioMgr.instance:trigger((isSelected or nil) and (AudioEnum.UI.play_ui_hero_card_click or AudioEnum.UI.play_ui_hero_card_gone))
end

function PlayerCardAchievementSelectIcon:dispose()
	if self._icon then
		self._icon:dispose()
	end

	self:__onDispose()
end

return PlayerCardAchievementSelectIcon
