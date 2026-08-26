-- chunkname: @modules/logic/achievement/view/AchievementMainNamePlateItem.lua

module("modules.logic.achievement.view.AchievementMainNamePlateItem", package.seeall)

local AchievementMainNamePlateItem = class("AchievementMainNamePlateItem", ListScrollCellExtend)

function AchievementMainNamePlateItem:onInitView()
	self._goIcon = gohelper.findChild(self.viewGO, "go_icon")
	self._btnclick = gohelper.findChildButton(self.viewGO, "#btn_click")

	self:_initLevelItems()

	self._prefab = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AchievementMainNamePlateItem:addEvents()
	self._btnclick:AddClickListener(self._onClickBtn, self)
end

function AchievementMainNamePlateItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function AchievementMainNamePlateItem:_onClickBtn()
	if self._mo and self._mo.id then
		local viewParam = {}

		viewParam.achievementId = self._mo.id
		viewParam.achievementIds = AchievementMainListModel.instance:getCurrentAchievementIds()

		ViewMgr.instance:openView(ViewName.AchievementNamePlateLevelView, viewParam)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_saga)
	end
end

function AchievementMainNamePlateItem:_initLevelItems()
	self.levelItemList = {}

	for i = 1, 3 do
		local item = {}

		item.go = gohelper.findChild(self._goIcon, "level" .. i)
		item.unlock = gohelper.findChild(item.go, "#go_UnLocked")
		item.lock = gohelper.findChild(item.go, "#go_Locked")
		item.gounlockbg = gohelper.findChild(item.unlock, "#simage_bg")
		item.simageunlocktitle = gohelper.findChildSingleImage(item.unlock, "#simage_title")
		item.txtunlocklevel = gohelper.findChildText(item.unlock, "#txt_level")
		item.simagelockbg = gohelper.findChildSingleImage(item.lock, "#simage_bg")
		item.simagelocktitle = gohelper.findChildSingleImage(item.lock, "#simage_title")
		item.txtlocklevel = gohelper.findChildText(item.lock, "#txt_level")

		gohelper.setActive(item.go, false)
		table.insert(self.levelItemList, item)
	end
end

function AchievementMainNamePlateItem:_editableInitView()
	self._animator = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))

	self.addEventCb(self, AchievementMainController.instance, AchievementEvent.OnFocusAchievementFinished, self._onFocusFinished, self)
end

function AchievementMainNamePlateItem:onDestroy()
	return
end

function AchievementMainNamePlateItem:onUpdateMO(mo)
	if AchievementMainCommonModel.instance:getCurrentViewType() ~= AchievementEnum.ViewType.Tile then
		return
	end

	self._mo = mo

	self:refreshUI()
end

function AchievementMainNamePlateItem:refreshUI()
	local isNamePlate = AchievementMainCommonModel.instance:checkIsNamePlate()

	if not isNamePlate then
		return
	end

	local achievementCfg = AchievementConfig.instance:getAchievement(self._mo.id)

	if achievementCfg then
		local curSortType = AchievementMainCommonModel.instance:getCurrentSortType()
		local curFilterType = AchievementMainCommonModel.instance:getCurrentFilterType()
		local taskConfigList = self._mo:getFilterTaskList(curSortType, curFilterType)
		local lastFinishLevel

		if taskConfigList then
			for index, taskCfg in ipairs(taskConfigList) do
				local item = self.levelItemList[index]
				local taskMO = AchievementModel.instance:getById(taskCfg.id)
				local taskHasFinished = taskMO and taskMO.hasFinished

				if taskHasFinished then
					lastFinishLevel = taskCfg.level
				end

				gohelper.setActive(item.unlock, taskHasFinished)
				gohelper.setActive(item.lock, not taskHasFinished)

				local prefabName, titlebgName, bgName

				if taskCfg.image and not string.nilorempty(taskCfg.image) then
					local temp = string.split(taskCfg.image, "#")

					prefabName = temp[1]
					titlebgName = temp[2]
					bgName = temp[3]
				end

				if taskHasFinished then
					local function callback()
						self._prefab[index] = item._bgLoader:getInstGO()
					end

					if not self._prefab[index] then
						item._bgLoader = PrefabInstantiate.Create(item.gounlockbg)

						item._bgLoader:startLoad(AchievementUtils.getBgPrefabUrl(prefabName), callback, self)
					end

					item.simageunlocktitle:LoadImage(ResUrl.getAchievementLangIcon(titlebgName))
				else
					item.simagelockbg:LoadImage(ResUrl.getAchievementIcon(bgName))
					item.simagelocktitle:LoadImage(ResUrl.getAchievementLangIcon(titlebgName))
				end

				local listenerType = taskCfg.listenerType
				local maxProgress = AchievementUtils.getAchievementProgressBySourceType(achievementCfg.rule)
				local num

				if listenerType and listenerType == "TowerPassLayer" then
					if taskCfg.listenerParam and not string.nilorempty(taskCfg.listenerParam) then
						local temp = string.split(taskCfg.listenerParam, "#")

						num = temp and temp[3]
						num = num * 10
					end
				else
					num = taskCfg and taskCfg.maxProgress
				end

				if taskHasFinished then
					item.txtunlocklevel.text = num < maxProgress and maxProgress or num
					item.txtlocklevel.text = num < maxProgress and maxProgress or num
				else
					item.txtunlocklevel.text = num < maxProgress and num or maxProgress
					item.txtlocklevel.text = num < maxProgress and num or maxProgress
				end
			end

			if lastFinishLevel and lastFinishLevel > 0 then
				for index, item in ipairs(self.levelItemList) do
					if index == lastFinishLevel then
						gohelper.setActive(item.go, true)
					else
						gohelper.setActive(item.go, false)
					end
				end
			else
				gohelper.setActive(self.levelItemList[1].go, true)
			end
		end
	end
end

function AchievementMainNamePlateItem:setIconColor(color)
	SLFramework.UGUI.GuiHelper.SetColor(self._imageicon, color or "#FFFFFF")
end

function AchievementMainNamePlateItem:playAchievementAnim()
	return
end

function AchievementMainNamePlateItem:_onFocusFinished()
	return
end

return AchievementMainNamePlateItem
