-- chunkname: @modules/logic/achievement/view/AchievementNamePlatePanelView.lua

module("modules.logic.achievement.view.AchievementNamePlatePanelView", package.seeall)

local AchievementNamePlatePanelView = class("AchievementNamePlatePanelView", BaseView)

function AchievementNamePlatePanelView:onInitView()
	self._goIcon = gohelper.findChild(self.viewGO, "go_icon")
	self._btnView = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_view")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._btnImage = gohelper.findChildButtonWithAudio(self.viewGO, "go_icon/#btn_image")

	self:_initLevelItems()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AchievementNamePlatePanelView:addEvents()
	self._btnView:AddClickListener(self._btnViewOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnImage:AddClickListener(self._btnImageOnClick, self)
end

function AchievementNamePlatePanelView:removeEvents()
	self._btnView:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnImage:RemoveClickListener()
end

function AchievementNamePlatePanelView:_initLevelItems()
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

function AchievementNamePlatePanelView:onOpen()
	self._co = self.viewParam.taskCo
	self._id = self._co.achievementId

	self:refreshUI()
end

function AchievementNamePlatePanelView:refreshUI()
	local level = self._co.level
	local achievementCfg = AchievementConfig.instance:getAchievement(self._id)
	local item = self.levelItemList[level]
	local taskMO = AchievementModel.instance:getById(self._co.id)
	local taskHasFinished = taskMO and taskMO.hasFinished

	gohelper.setActive(item.unlock, taskHasFinished)
	gohelper.setActive(item.lock, not taskHasFinished)

	local prefabName, titlebgName, bgName

	if self._co.image and not string.nilorempty(self._co.image) then
		local temp = string.split(self._co.image, "#")

		prefabName = temp[1]
		titlebgName = temp[2]
		bgName = temp[3]
	end

	if taskHasFinished then
		local function callback()
			local go = item._bgLoader:getInstGO()
		end

		item._bgLoader = PrefabInstantiate.Create(item.gounlockbg)

		item._bgLoader:startLoad(AchievementUtils.getBgPrefabUrl(prefabName), callback, self)
		item.simageunlocktitle:LoadImage(ResUrl.getAchievementLangIcon(titlebgName))
	else
		item.simagelockbg:LoadImage(ResUrl.getAchievementIcon(bgName))
		item.simagelocktitle:LoadImage(ResUrl.getAchievementLangIcon(titlebgName))
	end

	local listenerType = self._co.listenerType
	local maxProgress = AchievementUtils.getAchievementProgressBySourceType(achievementCfg.rule)
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

	if taskHasFinished then
		item.txtunlocklevel.text = num < maxProgress and maxProgress or num
		item.txtlocklevel.text = num < maxProgress and maxProgress or num
	else
		item.txtunlocklevel.text = num < maxProgress and num or maxProgress
		item.txtlocklevel.text = num < maxProgress and num or maxProgress
	end

	gohelper.setActive(item.go, true)
end

function AchievementNamePlatePanelView:_btnCloseOnClick()
	self:closeThis()
end

function AchievementNamePlatePanelView:_btnViewOnClick()
	AchievementController.instance:openAchievementMainViewAndFocus(AchievementEnum.AchievementType.Single, self._id, false)
end

function AchievementNamePlatePanelView:_btnImageOnClick()
	local taskCoList = AchievementConfig.instance:getTasksByAchievementId(self._id)
	local taskIds = {}

	if taskCoList then
		for _, taskCo in ipairs(taskCoList) do
			if taskCo then
				table.insert(taskIds, taskCo.id)
			end
		end
	end

	local viewParam = {}

	viewParam.achievementId = self._id
	viewParam.achievementIds = taskIds

	ViewMgr.instance:openView(ViewName.AchievementNamePlateLevelView, viewParam)
end

return AchievementNamePlatePanelView
