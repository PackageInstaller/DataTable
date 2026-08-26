-- chunkname: @modules/logic/playercard/view/comp/PlayerCardAchievementNamePlateSelectItem.lua

module("modules.logic.playercard.view.comp.PlayerCardAchievementNamePlateSelectItem", package.seeall)

local PlayerCardAchievementNamePlateSelectItem = class("PlayerCardAchievementNamePlateSelectItem", ListScrollCellExtend)

function PlayerCardAchievementNamePlateSelectItem:onInitView()
	self._goIcon = gohelper.findChild(self.viewGO, "go_icon")
	self._goselect = gohelper.findChild(self.viewGO, "#go_groupselected")
	self._btnclick = gohelper.findChildButton(self.viewGO, "#btn_groupselect")

	self:_initLevelItems()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerCardAchievementNamePlateSelectItem:addEvents()
	self._btnclick:AddClickListener(self._onClickBtn, self)
end

function PlayerCardAchievementNamePlateSelectItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function PlayerCardAchievementNamePlateSelectItem:_onClickBtn()
	if self._id then
		PlayerCardAchievementSelectListModel.instance:clearAllSelect()
		PlayerCardAchievementSelectController.instance:changeNamePlateSelect(self._id)

		local isSelected = PlayerCardAchievementSelectListModel.instance:isSingleSelected(self._id)

		AudioMgr.instance:trigger((isSelected or nil) and (AudioEnum.UI.play_ui_hero_card_click or AudioEnum.UI.play_ui_hero_card_gone))
	end
end

function PlayerCardAchievementNamePlateSelectItem:_initLevelItems()
	self.levelItemList = {}

	for i = 1, 3 do
		local item = {}

		item.go = gohelper.findChild(self._goIcon, "level" .. i)
		item.gobg = gohelper.findChild(item.go, "#simage_bg")
		item.simagetitle = gohelper.findChildSingleImage(item.go, "#simage_title")
		item.txtlevel = gohelper.findChildText(item.go, "#txt_level")

		gohelper.setActive(item.go, false)
		table.insert(self.levelItemList, item)
	end
end

function PlayerCardAchievementNamePlateSelectItem:_editableInitView()
	self._animator = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
end

function PlayerCardAchievementNamePlateSelectItem:onDestroy()
	return
end

function PlayerCardAchievementNamePlateSelectItem:onUpdateMO(mo)
	self._mo = mo and mo.achievementCfgs[1]
	self._achievementId = self._mo.achievementId
	self._achievementCo = self._mo.co
	self._id = self._mo.taskId
	self._co = self._mo.taskCo

	self:refreshUI()
end

function PlayerCardAchievementNamePlateSelectItem:refreshUI()
	local isNamePlate = PlayerCardAchievementSelectListModel.instance:checkIsNamePlate()

	if not isNamePlate then
		return
	end

	local isSelected = PlayerCardAchievementSelectListModel.instance:isSingleSelected(self._id)

	gohelper.setActive(self._goselect, isSelected)

	local item = self.levelItemList[self._co.level]
	local bgName, titlebgName

	if self._co.image and not string.nilorempty(self._co.image) then
		local temp = string.split(self._co.image, "#")

		bgName = temp[1]
		titlebgName = temp[2]
	end

	local function callback()
		local go = item._bgLoader:getInstGO()
	end

	item._bgLoader = PrefabInstantiate.Create(item.gobg)

	item._bgLoader:startLoad(AchievementUtils.getBgPrefabUrl(bgName), callback, self)
	item.simagetitle:LoadImage(ResUrl.getAchievementLangIcon(titlebgName))

	local listenerType = self._co.listenerType
	local maxProgress = AchievementUtils.getAchievementProgressBySourceType(self._achievementCo.rule)
	local num

	if listenerType and listenerType == "TowerPassLayer" then
		if self._co.listenerParam and not string.nilorempty(self._co.listenerParam) then
			local temp = string.split(self._co.listenerParam, "#")

			num = temp and temp[3]
			num = num * 10
		end
	else
		num = self._co and self._co.maxProgress
	end

	item.txtlevel.text = num < maxProgress and maxProgress or num

	gohelper.setActive(self.levelItemList[self._co.level].go, true)
end

function PlayerCardAchievementNamePlateSelectItem:playAchievementAnim()
	return
end

function PlayerCardAchievementNamePlateSelectItem:_onFocusFinished()
	return
end

return PlayerCardAchievementNamePlateSelectItem
