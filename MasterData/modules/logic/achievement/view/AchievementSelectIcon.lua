-- chunkname: @modules/logic/achievement/view/AchievementSelectIcon.lua

module("modules.logic.achievement.view.AchievementSelectIcon", package.seeall)

local AchievementSelectIcon = class("AchievementSelectIcon", UserDataDispose)

function AchievementSelectIcon:init(go, iconGO)
	self:__onInit()

	self.viewGO = go
	self.iconGO = iconGO

	self:initComponents()
end

function AchievementSelectIcon:initComponents()
	self._goicon = gohelper.findChild(self.viewGO, "#go_icon")
	self._icon = AchievementMainIcon.New()

	self._icon:init(self.iconGO)
	self._icon:setClickCall(self.onClickSelf, self)
	gohelper.addChild(self._goicon, self.iconGO)
end

function AchievementSelectIcon:setData(taskCO)
	self.taskCO = taskCO

	self:refreshUI()
end

function AchievementSelectIcon:refreshUI()
	self._icon:setData(self.taskCO)
	self._icon:setBgVisible(true)

	local isSelected = AchievementSelectListModel.instance:isSingleSelected(self.taskCO.id)

	self._icon:setSelectIconVisible(isSelected)

	if isSelected then
		self._icon:setSelectIndex(AchievementSelectListModel.instance:getSelectOrderIndex(self.taskCO.id))
	end
end

function AchievementSelectIcon:onClickSelf()
	AchievementSelectController.instance:changeSingleSelect(self.taskCO.id)

	local isSelected = AchievementSelectListModel.instance:isSingleSelected(self.taskCO.id)

	AudioMgr.instance:trigger((isSelected or nil) and (AudioEnum.UI.play_ui_hero_card_click or AudioEnum.UI.play_ui_hero_card_gone))
end

function AchievementSelectIcon:dispose()
	if self._icon then
		self._icon:dispose()
	end

	self:__onDispose()
end

return AchievementSelectIcon
