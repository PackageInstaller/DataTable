-- chunkname: @modules/logic/player/view/PlayerViewAchievement.lua

module("modules.logic.player.view.PlayerViewAchievement", package.seeall)

local PlayerViewAchievement = class("PlayerViewAchievement", BaseView)

function PlayerViewAchievement:onInitView()
	self._goachievement = gohelper.findChild(self.viewGO, "go_achievement")
	self._goshow = gohelper.findChild(self.viewGO, "go_achievement/#go_show")
	self._btneditachievement = gohelper.findChildButtonWithAudio(self.viewGO, "go_achievement/#go_show/#btn_editachievement")
	self._gosinglecontainer = gohelper.findChild(self.viewGO, "go_achievement/#go_show/#go_singlecontainer")
	self._gogroupcontainer = gohelper.findChild(self.viewGO, "go_achievement/#go_show/#go_groupcontainer")
	self._gosingleitem = gohelper.findChild(self.viewGO, "go_achievement/#go_show/#go_singlecontainer/horizontal/#go_singleitem")
	self._goshowempty = gohelper.findChild(self.viewGO, "go_achievement/#go_show/#go_showempty")
	self._simagegroupbg = gohelper.findChildSingleImage(self.viewGO, "go_achievement/#go_show/#go_groupcontainer/#simage_groupbg")
	self._gogrouparea = gohelper.findChild(self.viewGO, "go_achievement/#go_show/#go_groupcontainer/#go_grouparea")
	self._txtTitle = gohelper.findChildText(self.viewGO, "go_achievement/#go_show/#go_groupcontainer/#txt_Title")
	self._gomisihai = gohelper.findChild(self.viewGO, "go_achievement/#go_show/#go_misihai")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerViewAchievement:addEvents()
	self._btneditachievement:AddClickListener(self._btneditachievementOnClick, self)
end

function PlayerViewAchievement:removeEvents()
	self._btneditachievement:RemoveClickListener()
end

function PlayerViewAchievement:_editableInitView()
	return
end

function PlayerViewAchievement:onDestroyView()
	self:_tryDisposeSingleItems()
	self:_tryDisposeGroupItems()
	self._simagegroupbg:UnLoadImage()
end

function PlayerViewAchievement:onOpen()
	self._playerSelf = self.viewParam.playerSelf
	self._info = self.viewParam.playerInfo
	self._singleAchieveTabs = {}

	self.addEventCb(self, AchievementController.instance, AchievementEvent.AchievementSaveSucc, self.refreshUI, self)
	self:refreshUI()
end

function PlayerViewAchievement:onClose()
	self.removeEventCb(self, AchievementController.instance, AchievementEvent.AchievementSaveSucc, self.refreshUI, self)
end

function PlayerViewAchievement:refreshUI()
	self:_refreshAchievements()
end

function PlayerViewAchievement:_getOrCreateSingleItem(index)
	if not self._singleAchieveTabs[index] then
		local achievementItem = self:getUserDataTb_()

		achievementItem.viewGo = gohelper.cloneInPlace(self._gosingleitem, "singleitem_" .. index)
		achievementItem.goempty = gohelper.findChild(achievementItem.viewGo, "go_empty")
		achievementItem.gohas = gohelper.findChild(achievementItem.viewGo, "go_has")
		achievementItem.simageicon = gohelper.findChildSingleImage(achievementItem.viewGo, "go_has/simage_icon")

		table.insert(self._singleAchieveTabs, index, achievementItem)
	end

	return self._singleAchieveTabs[index]
end

function PlayerViewAchievement:_refreshAchievements()
	local showStr = self._playerSelf and PlayerModel.instance:getShowAchievement() or self._info.showAchievement
	local isGroup, showTaskList, isNamePlate = PlayerViewAchievementModel.instance:getShowAchievements(showStr)
	local isEmpty = not showTaskList or tabletool.len(showTaskList) <= 0

	gohelper.setActive(self._goshowempty, isEmpty)
	gohelper.setActive(self._gogroupcontainer, isGroup and not isEmpty)
	gohelper.setActive(self._gosinglecontainer, not isGroup and not isEmpty and not isNamePlate)
	gohelper.setActive(self._gomisihai, not isGroup and not isEmpty and isNamePlate)

	if isEmpty then
		return
	end

	if not isGroup then
		if not isNamePlate then
			local index = 1

			for k, v in ipairs(showTaskList) do
				local achievementItem = self:_getOrCreateSingleItem(index)

				gohelper.setActive(achievementItem.viewGo, true)
				gohelper.setActive(achievementItem.goempty, false)
				gohelper.setActive(achievementItem.gohas, true)

				local taskCO = AchievementConfig.instance:getTask(v)

				if taskCO then
					achievementItem.simageicon:LoadImage(ResUrl.getAchievementIcon("badgeicon/" .. taskCO.icon))
				end

				index = index + 1
			end

			for i = index, AchievementEnum.ShowMaxSingleCount do
				local achievementItem = self:_getOrCreateSingleItem(i)

				gohelper.setActive(achievementItem.viewGo, true)
				gohelper.setActive(achievementItem.goempty, true)
				gohelper.setActive(achievementItem.gohas, false)
			end
		else
			self:_refreshNamePlate(showTaskList)
		end
	else
		for k, v in pairs(showTaskList) do
			self:_refreshGroupAchievements(k, v)
		end
	end
end

function PlayerViewAchievement:_refreshNamePlate(showTaskList)
	self._gonameplateitem = self._gonameplateitem or self:_getOrCreateNamePlate()

	local taskCO = AchievementConfig.instance:getTask(showTaskList[1])

	if not taskCO then
		return
	end

	local achievementCfg = AchievementConfig.instance:getAchievement(taskCO.achievementId)

	for index, item in ipairs(self._gonameplateitem.levelItemList) do
		gohelper.setActive(item.go, false)
	end

	local item = self._gonameplateitem.levelItemList[taskCO.level]
	local bgName, titlebgName

	if taskCO.image and not string.nilorempty(taskCO.image) then
		local temp = string.split(taskCO.image, "#")

		bgName = temp[1]
		titlebgName = temp[2]
	end

	local function callback()
		local go = item._bgLoader:getInstGO()
	end

	if item._bgLoader then
		item._bgLoader:dispose()

		item._bgLoader = nil
	end

	item._bgLoader = PrefabInstantiate.Create(item.gobg)

	item._bgLoader:startLoad(AchievementUtils.getBgPrefabUrl(bgName), callback, self)
	item.simagetitle:LoadImage(ResUrl.getAchievementLangIcon(titlebgName))

	local listenerType = taskCO.listenerType
	local maxProgress = AchievementUtils.getAchievementProgressBySourceType(achievementCfg.rule)
	local num

	if listenerType and listenerType == "TowerPassLayer" then
		if taskCO.listenerParam and not string.nilorempty(taskCO.listenerParam) then
			local temp = string.split(taskCO.listenerParam, "#")

			num = temp and temp[3]
			num = num * 10
		end
	else
		num = taskCO and taskCO.maxProgress
	end

	item.txtlevel.text = not self._playerSelf and self._info.towerLayerMetre or num < maxProgress and maxProgress or num

	gohelper.setActive(item.go, true)
end

function PlayerViewAchievement:_getOrCreateNamePlate()
	local item = self:getUserDataTb_()

	item.go = gohelper.findChild(self._gomisihai, "go_icon")
	item.levelItemList = {}

	for i = 1, 3 do
		local levelitem = {}

		levelitem.go = gohelper.findChild(item.go, "deep" .. i)
		levelitem.gobg = gohelper.findChild(levelitem.go, "#simage_bg")
		levelitem.simagetitle = gohelper.findChildSingleImage(levelitem.go, "#simage_title")
		levelitem.txtlevel = gohelper.findChildText(levelitem.go, "#txt_deep_" .. i)

		gohelper.setActive(levelitem.go, false)
		table.insert(item.levelItemList, levelitem)
	end

	return item
end

function PlayerViewAchievement:_refreshGroupAchievements(groupId, taskList)
	local groupCfg = AchievementConfig.instance:getGroup(groupId)

	if groupCfg then
		self:_refreshGroupTitle(groupCfg)
		self:_refreshGroupBg(groupCfg, taskList)
		self:_buildAchievementIconInGroup(groupId, taskList)
	end
end

function PlayerViewAchievement:_refreshGroupBg(groupCfg, taskList)
	local groupBgUrl = AchievementConfig.instance:getGroupBgUrl(groupCfg.id, AchievementEnum.GroupParamType.Player, (groupCfg and groupCfg.unLockAchievement ~= 0 and taskList or nil) and tabletool.indexOf(taskList, groupCfg.unLockAchievement) ~= nil)

	self._simagegroupbg:LoadImage(groupBgUrl)
end

function PlayerViewAchievement:_refreshGroupTitle(groupCfg)
	if groupCfg then
		self._txtTitle.text = tostring(groupCfg.name)

		local groupTitleColor = AchievementConfig.instance:getGroupTitleColorConfig(groupCfg.id, AchievementEnum.GroupParamType.Player)

		SLFramework.UGUI.GuiHelper.SetColor(self._txtTitle, groupTitleColor)
	end
end

function PlayerViewAchievement:_buildAchievementIconInGroup(groupId, taskList)
	local achievementCfgs = AchievementConfig.instance:getAchievementsByGroupId(groupId)
	local achievement2TaskMap = self:buildAchievementAndTaskMap(taskList)
	local processMap = {}
	local idTab = AchievementConfig.instance:getGroupParamIdTab(groupId, AchievementEnum.GroupParamType.Player)

	if idTab then
		for k, v in ipairs(idTab) do
			local item = self:getOrCreateSingleItemInGroup(k)

			self:_setGroupAchievementPosAndScale(item.viewGO, groupId, k)

			processMap[item] = true

			local achievementCO = achievementCfgs and achievementCfgs[v]

			gohelper.setActive(item.viewGO, achievementCO ~= nil)

			if achievementCO then
				local taskCO = self:getExistTaskCo(achievement2TaskMap, achievementCO)

				item:setSelectIconVisible(false)
				item:setNameTxtVisible(false)

				if taskCO then
					item:setData(taskCO)
					item:setIconVisible(true)
					item:setBgVisible(false)
				else
					gohelper.setActive(item.viewGO, false)
				end
			end
		end
	end

	for _, item in pairs(self._groupItems) do
		if not processMap[item] then
			gohelper.setActive(item.viewGO, false)
		end
	end
end

function PlayerViewAchievement:buildAchievementAndTaskMap(taskList)
	local map = {}

	if taskList then
		for k, v in ipairs(taskList) do
			local taskCo = AchievementConfig.instance:getTask(v)
			local id = taskCo.achievementId

			map[id] = map[id] or taskCo
		end
	end

	return map
end

function PlayerViewAchievement:getExistTaskCo(taskMap, achievementCO)
	return taskMap[achievementCO.id]
end

function PlayerViewAchievement:getOrCreateSingleItemInGroup(index)
	self._groupItems = self._groupItems or self:getUserDataTb_()

	local item = self._groupItems[index]

	if not item then
		item = AchievementMainIcon.New()

		local goIcon = self:getResInst(AchievementEnum.MainIconPath, self._gogrouparea, "#go_icon" .. index)

		item:init(goIcon)

		self._groupItems[index] = item
	end

	return item
end

function PlayerViewAchievement:_setGroupAchievementPosAndScale(go, groupId, index)
	local posX, posY, scaleX, scaleY = AchievementConfig.instance:getAchievementPosAndScaleInGroup(groupId, index, AchievementEnum.GroupParamType.Player)

	if go then
		recthelper.setAnchor(go.transform, posX or 0, posY or 0)
		transformhelper.setLocalScale(go.transform, scaleX or 1, scaleY or 1, 1)
	end
end

function PlayerViewAchievement:_btneditachievementOnClick()
	if self._playerSelf then
		if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
			ViewMgr.instance:openView(ViewName.AchievementSelectView)
		else
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
		end
	end
end

function PlayerViewAchievement:_tryDisposeSingleItems()
	if self._singleAchieveTabs then
		for _, v in pairs(self._singleAchieveTabs) do
			if v.simageicon then
				v.simageicon:UnLoadImage()
			end
		end

		self._singleAchieveTabs = nil
	end
end

function PlayerViewAchievement:_tryDisposeGroupItems()
	if self._groupItems then
		for _, v in pairs(self._groupItems) do
			v:dispose()
		end

		self._groupItems = nil
	end
end

return PlayerViewAchievement
