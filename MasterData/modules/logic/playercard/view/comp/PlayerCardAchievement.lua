-- chunkname: @modules/logic/playercard/view/comp/PlayerCardAchievement.lua

module("modules.logic.playercard.view.comp.PlayerCardAchievement", package.seeall)

local PlayerCardAchievement = class("PlayerCardAchievement", BaseView)

function PlayerCardAchievement:init(go)
	self.viewGO = go

	self:onInitView()
end

function PlayerCardAchievement:onInitView()
	self.go = gohelper.findChild(self.viewGO, "root/main/achieve")
	self.btnClick = gohelper.findChildButtonWithAudio(self.go, "#btn_click")
	self.txtDec = gohelper.findChildTextMesh(self.go, "#txt_dec")
	self.goAchievement = gohelper.findChild(self.go, "#go_achievement")
	self.goSingle = gohelper.findChild(self.goAchievement, "#go_singlecontainer")
	self.goSingleItem = gohelper.findChild(self.goAchievement, "#go_singlecontainer/horizontal/#go_singleitem")
	self.goSingleSelectedEffect = gohelper.findChild(self.goAchievement, "#go_singlecontainer/selected_eff")
	self.goGroup = gohelper.findChild(self.goAchievement, "#go_group")
	self.groupSimageBg = gohelper.findChildSingleImage(self.goAchievement, "#go_group/#image_bg")
	self.goGroupContainer = gohelper.findChild(self.goAchievement, "#go_group/#go_groupcontainer")
	self.goGroupSelectedEffect = gohelper.findChild(self.goAchievement, "#go_group/selected_eff")
	self.goEmpty = gohelper.findChild(self.goAchievement, "#go_showempty")
	self.goMisihai = gohelper.findChild(self.go, "#go_misihai")
	self._singleAchieveTabs = {}
	self._iconItems = {}
end

function PlayerCardAchievement:playSelelctEffect()
	gohelper.setActive(self.goGroupSelectedEffect, false)
	gohelper.setActive(self.goGroupSelectedEffect, true)
	gohelper.setActive(self.goSingleSelectedEffect, false)
	gohelper.setActive(self.goSingleSelectedEffect, true)
	PlayerCardController.instance:playChangeEffectAudio()
end

function PlayerCardAchievement:addEvents()
	self.btnClick:AddClickListener(self.btnClickOnClick, self)
	self.addEventCb(self, AchievementController.instance, AchievementEvent.AchievementSaveSucc, self.onRefreshView, self)
end

function PlayerCardAchievement:removeEvents()
	self.btnClick:RemoveClickListener()
	self.removeEventCb(self, AchievementController.instance, AchievementEvent.AchievementSaveSucc, self.onRefreshView, self)
end

function PlayerCardAchievement:canOpen()
	self:onOpen()
	self:addEvents()
end

function PlayerCardAchievement:onOpen()
	local param = self.viewParam

	self.userId = param.userId

	local achieveitem = self.viewContainer:getSetting().otherRes.achieveitem
	local misihaiitem = self.viewContainer:getSetting().otherRes.misihaiitem

	self.achieveitemRes = self.viewContainer:getRes(achieveitem)
	self.misihaiitemRes = self.viewContainer:getRes(misihaiitem)

	self:onRefreshView()
end

function PlayerCardAchievement:getCardInfo()
	return PlayerCardModel.instance:getCardInfo(self.userId)
end

function PlayerCardAchievement:isPlayerSelf()
	local cardInfo = self:getCardInfo()

	return cardInfo and cardInfo:isSelf()
end

function PlayerCardAchievement:getPlayerInfo()
	local cardInfo = self:getCardInfo()

	return cardInfo and cardInfo:getPlayerInfo()
end

function PlayerCardAchievement:btnClickOnClick()
	if self:isPlayerSelf() then
		if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
			ViewMgr.instance:openView(ViewName.PlayerCardAchievementSelectView)
		else
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
		end
	end
end

function PlayerCardAchievement:onRefreshView()
	local cardInfo = self:getCardInfo()

	if not cardInfo then
		return
	end

	self.txtDec.text = cardInfo.achievementCount == -1 and PlayerCardEnum.EmptyString2 or tostring(cardInfo.achievementCount)

	self:_refreshAchievements()
end

function PlayerCardAchievement:_refreshAchievements()
	local cardInfo = self:getCardInfo()
	local playerInfo = self:getPlayerInfo()
	local showStr = cardInfo:getShowAchievement() or playerInfo.showAchievement
	local isGroup, showTaskList, isNamePlate = PlayerViewAchievementModel.instance:getShowAchievements(showStr)
	local isEmpty = not showTaskList or tabletool.len(showTaskList) <= 0

	gohelper.setActive(self.goEmpty, isEmpty)
	gohelper.setActive(self.goGroup, isGroup and not isEmpty)
	gohelper.setActive(self.goSingle, not isGroup and not isEmpty and not isNamePlate)
	gohelper.setActive(self.goMisihai, not isGroup and not isEmpty and isNamePlate)

	if self.notIsFirst and self.showStr ~= showStr then
		self:playSelelctEffect()
	end

	self.showStr = showStr
	self.notIsFirst = true

	if isEmpty then
		return
	end

	if not isGroup then
		if not isNamePlate then
			self:_refreshSingle(showTaskList)
		else
			self:_refreshNamePlate(showTaskList)
		end
	else
		for k, v in pairs(showTaskList) do
			self:_refreshGroup(k, v)

			break
		end
	end
end

function PlayerCardAchievement:_refreshNamePlate(showTaskList)
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

	item._bgLoader:startLoad(AchievementUtils.getBgPrefabUrl(bgName, true), callback, self)
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

	item.txtlevel.text = self.userId ~= PlayerModel.instance:getMyUserId() and self:getCardInfo():getTowerLayerMetre() or num < maxProgress and maxProgress or num

	gohelper.setActive(item.go, true)
end

function PlayerCardAchievement:_getOrCreateNamePlate()
	local item = self:getUserDataTb_()

	item.go = gohelper.clone(self.misihaiitemRes, self.goMisihai, "nameplate")
	item.levelItemList = {}

	for i = 1, 3 do
		local levelitem = {}

		levelitem.go = gohelper.findChild(item.go, "go_icon/level" .. i)
		levelitem.gobg = gohelper.findChild(levelitem.go, "#simage_bg")
		levelitem.simagetitle = gohelper.findChildSingleImage(levelitem.go, "#simage_title")
		levelitem.txtlevel = gohelper.findChildText(levelitem.go, "#txt_level")

		gohelper.setActive(levelitem.go, false)
		table.insert(item.levelItemList, levelitem)
	end

	return item
end

function PlayerCardAchievement:_refreshSingle(showTaskList)
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
end

function PlayerCardAchievement:_getOrCreateSingleItem(index)
	if not self._singleAchieveTabs[index] then
		local achievementItem = self:getUserDataTb_()

		achievementItem.viewGo = gohelper.cloneInPlace(self.goSingleItem, "singleitem_" .. index)
		achievementItem.goempty = gohelper.findChild(achievementItem.viewGo, "go_empty")
		achievementItem.gohas = gohelper.findChild(achievementItem.viewGo, "go_has")
		achievementItem.simageicon = gohelper.findChildSingleImage(achievementItem.viewGo, "go_has/simage_icon")

		table.insert(self._singleAchieveTabs, index, achievementItem)
	end

	return self._singleAchieveTabs[index]
end

function PlayerCardAchievement:_refreshGroup(groupId, taskList)
	local groupCO = AchievementConfig.instance:getGroup(groupId)

	if groupCO then
		local isUnLockAchievementFinished = AchievementModel.instance:isAchievementTaskFinished(groupCO.unLockAchievement)
		local groupBgUrl = AchievementConfig.instance:getGroupBgUrl(groupId, AchievementEnum.GroupParamType.List, isUnLockAchievementFinished)

		self.groupSimageBg:LoadImage(groupBgUrl)
		self:refreshSingleInGroup(groupId, taskList)
	end
end

function PlayerCardAchievement:refreshSingleInGroup(groupId, taskList)
	local achievementCfgs = AchievementConfig.instance:getAchievementsByGroupId(groupId)
	local achievement2TaskMap = self:buildAchievementAndTaskMap(taskList)
	local idTabs = AchievementConfig.instance:getGroupParamIdTab(groupId, AchievementEnum.GroupParamType.List)

	if idTabs then
		if not #idTabs then
			local idCount = 0

			for i = 1, math.max(#self._iconItems, idCount) do
				local item = self:_getOrCreateGroupItem(i)
				local achievementCO = achievementCfgs and achievementCfgs[idTabs[i]]

				self:_setGroupAchievementPosAndScale(item.viewGO, groupId, i)
				gohelper.setActive(item.viewGO, achievementCO ~= nil)

				if achievementCO then
					local taskCO = self:getExistTaskCo(achievement2TaskMap, achievementCO)

					if taskCO then
						item:setData(taskCO)
						item:setIconVisible(true)
						item:setBgVisible(false)
						item:setNameTxtVisible(false)
					else
						gohelper.setActive(item.viewGO, false)
					end
				end
			end
		end
	end
end

function PlayerCardAchievement:buildAchievementAndTaskMap(taskList)
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

function PlayerCardAchievement:_setGroupAchievementPosAndScale(go, groupId, index)
	local posX, posY, scaleX, scaleY = AchievementConfig.instance:getAchievementPosAndScaleInGroup(groupId, index, AchievementEnum.GroupParamType.List)

	if go then
		recthelper.setAnchor(go.transform, posX or 0, posY or 0)
		transformhelper.setLocalScale(go.transform, scaleX or 1, scaleY or 1, 1)
	end
end

function PlayerCardAchievement:getExistTaskCo(taskMap, achievementCO)
	return taskMap[achievementCO.id]
end

function PlayerCardAchievement:_getOrCreateGroupItem(index)
	if not self._iconItems[index] then
		local icon = AchievementMainIcon.New()
		local go = gohelper.clone(self.achieveitemRes, self.goGroupContainer, tostring(index))

		icon:init(go)

		self._iconItems[index] = icon
	end

	return self._iconItems[index]
end

function PlayerCardAchievement:_tryDisposeSingleItems()
	if self._singleAchieveTabs then
		for _, v in pairs(self._singleAchieveTabs) do
			if v.simageicon then
				v.simageicon:UnLoadImage()
			end
		end

		self._singleAchieveTabs = nil
	end

	if self._iconItems then
		for _, v in pairs(self._iconItems) do
			v:dispose()
		end

		self._iconItems = nil
	end
end

function PlayerCardAchievement:onDestroy()
	self:_tryDisposeSingleItems()
	self.groupSimageBg:UnLoadImage()
	self:removeEvents()
end

return PlayerCardAchievement
