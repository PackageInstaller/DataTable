-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/achievement/AchievementSkillDetailView.lua

module("logic.extensions.playerinfo.view.achievement.AchievementSkillDetailView", package.seeall)

local M = class("AchievementSkillDetailView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._tabMoList = {}
	self._data = {}
end

function M:buildUI()
	local mainGo = self.mainGO
	local tabScroll = goutil.findChild(mainGo, "skillScroll")

	self._loopListTab = LoopListHelper.New(tabScroll)

	self._loopListTab:InitListView(0, self._updateCell, self)

	self._imgIcon = goutil.findChildImageComponent(mainGo, "right/skillHint/icon")
	self._txtLv = goutil.findChildTextComponent(mainGo, "right/skillHint/txtLv")
	self._txtProgress = goutil.findChildTextComponent(mainGo, "right/skillHint/txtNum")
	self._txtDesc = goutil.findChildTextComponent(mainGo, "right/skillHint/txtContent")
	self._imgProgress = goutil.findChildImageComponent(mainGo, "right/skillHint/sliderDi/fill")
	self._btnDetail = Astral.ButtonAdapter.Get(goutil.findChild(mainGo, "right/skillHint/btnMore"))
	self._tipsRoot = goutil.findChild(mainGo, "tips")
	self._btnHideDetail = Astral.ButtonAdapter.Get(self._tipsRoot)
	self._detailTips = goutil.findChild(mainGo, "tips/achievement_detail_tips")
	self._canvasGroup = goutil.addComponentOnce(self._detailTips, ComponentType.CanvasGroup)
	self._txtDetailName = goutil.findChildTextComponent(self._detailTips, "txtlName")
	self._txtDetailLevel = goutil.findChildTextComponent(self._detailTips, "txtlLevel")
	self._txtDetailDesc = goutil.findChildComponent(self._detailTips, "txtContent", UIComponentType.TextMeshProUGUI)
	self._allGetHintGo = goutil.findChild(mainGo, "right/taskContent/allReceiveHint")
	self._btnGetAll = Astral.ButtonAdapter.Get(goutil.findChild(mainGo, "right/taskContent/allReceiveHint/btnReceive"))

	local taskScroll = goutil.findChild(mainGo, "right/taskContent/scroll")

	self._loopListTask = LoopGridViewHelper.New(taskScroll)

	self._loopListTask:InitGridView(0, self._updateCellTask, self)

	self._rewardGos = {}

	local rewardRoot = goutil.findChild(mainGo, "right/bottom/group3")

	for i = 1, 5 do
		local itemGo = goutil.findChild(rewardRoot, "item" .. i)

		table.insert(self._rewardGos, itemGo)
	end

	self._imgProgressReward = goutil.findChildImageComponent(mainGo, "right/bottom/group1/fill")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	GlobalDispatcher:addEventListener(EventType.UPDATA_ACHIEVEMENT, self._refreshVisibleView, self)
	GlobalDispatcher:addEventListener(EventType.CHANGE_ACHIEVEMENT_TAB, self._onChangeTab, self)
	GlobalDispatcher:addEventListener(EventType.HERO_INFO_CHANGE, self._onCardInfoChange, self)
	GlobalDispatcher:addEventListener(EventType.ACHIEVEMENT_TAKE_REWARD_SUC, self._onGetLevelReward, self)
	self._btnDetail:AddClickListener(self._onClickBtnDetail, self)
	self._btnHideDetail:AddClickListener(self._onHideTips, self)
	self._btnGetAll:AddClickListener(self._onClickGetAllReward, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.UPDATA_ACHIEVEMENT, self._refreshVisibleView, self)
	GlobalDispatcher:removeEventListener(EventType.CHANGE_ACHIEVEMENT_TAB, self._onChangeTab, self)
	GlobalDispatcher:removeEventListener(EventType.HERO_INFO_CHANGE, self._onCardInfoChange, self)
	GlobalDispatcher:removeEventListener(EventType.ACHIEVEMENT_TAKE_REWARD_SUC, self._onGetLevelReward, self)
	self._btnDetail:RemoveClickListener()
	self._btnHideDetail:RemoveClickListener()
	self._btnGetAll:RemoveClickListener()
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Task)
	goutil.setActive(self._tipsRoot, false)

	self._tabMo = self:getFirstParam()

	self:_refreshData()
	self._loopListTask:MoveToItemIndex(0)
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Task)
	goutil.setActive(self._tipsRoot, false)
end

function M:_onCardInfoChange()
	AchievementAgent.instance:sendGetAllAchievementRequest()
end

function M:_onClickBtnClose()
	self:close()
end

function M:_refreshVisibleView()
	self:_refreshData()
end

function M:_onChangeTab(_, tabMo)
	self._tabMo = tabMo

	self:_refreshData()
	self._loopListTask:MoveToItemIndex(0)
end

function M:_onGetLevelReward()
	self:_updateSkillInfo()
end

function M:_refreshData()
	self._skillId = self._tabMo:getId()
	self._lvRewards = self._tabMo:getLvRewards()
	self._tabMoList = AchievementModel.instance:getAchievementSkillListModel():getMoList()

	self._loopListTab:SetListItemCount(#self._tabMoList)
	self._loopListTab:RefreshAllShownItem()
	self:_updateSkillInfo()
	table.clear(self._data)

	self._dataList = AchievementModel.instance:getAchievementMoList(self._skillId)

	for i, v in ipairs(self._dataList) do
		table.insert(self._data, v)
	end

	self._loopListTask:SetListItemCount(#self._data)
	self._loopListTask:RefreshAllShownItem()

	local canGetCount = 0

	for i, v in ipairs(self._data) do
		if v:canGetReward() and not v:getIsFinish() then
			canGetCount = canGetCount + 1
		end

		goutil.setActive(self._allGetHintGo, canGetCount > 1)
	end
end

function M:_playEnterAni()
	local minIndex, maxIndex = self._loopList:GetCurShowItemIndexRange()

	self._List = self._loopList:GetLoopListView()

	local tweenAni = DG.Tweening.DOTween.Sequence()

	tweenAni:AppendInterval(0.15)

	for i = minIndex, maxIndex do
		local item = self._List:GetShownItemByItemIndex(i).gameObject

		item:GetComponent(ComponentType.CanvasGroup).alpha = 0

		local itemView = Astral.LuaComponentContainer.Get(item, AchievementSkillItem)

		tweenAni:AppendCallback(function()
			itemView:playAni()
		end)
		tweenAni:AppendInterval(0.15)
	end
end

function M:_updateCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopListTab:NewListViewItem("skill_item")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, AchievementSkillDetailTab)
	local mo = self._tabMoList[curIndex]

	itemView:updateData(mo, self._skillId == mo:getId())

	return item
end

function M:_updateSkillInfo()
	local mo = AchievementModel.instance:getCurrSkillLevelMo(self._skillId)

	if not mo then
		return
	end

	local level = mo:getLevel()
	local maxLevel = AchievementModel.instance:getSkillMaxLevel(mo:getId())
	local moNext = AchievementModel.instance:getSkillLevelMo(mo:getId(), level, true)

	IconLoader.setSprite(self._imgIcon, IconType.AchievementSkill, mo:getIcon())

	local skillMo = self._tabMo:getSkillMo()
	local curExp = skillMo:getSkillExp()
	local needExp = skillMo:getSkillExpNeed()

	if moNext then
		needExp = moNext:getSkillExpNeed()
		self._txtLv.text = string.format("LV. <size=44>%s</size><color=#c5c5c5>/%s</color>", level, maxLevel)
		self._txtProgress.text = string.format("%s<color=#b6b7b7>/%s</color>", curExp, needExp)

		local tweenAni = DG.Tweening.DOTween.Sequence()

		tweenAni:Append(self._imgProgress:DOFillAmount(curExp / needExp, 0.3))
	else
		self._imgProgress.fillAmount = needExp / needExp
		self._txtLv.text = string.format("LV. <size=44>%s</size><color=#c5c5c5>/%s</color>", level, level)
		self._txtProgress.text = string.format("%s<color=#b6b7b7>/%s</color>", needExp, needExp)
	end

	local desc = mo:getDescOne()

	if level == 0 then
		desc = moNext:getDescOne()
	end

	if string.find(desc, "%s", 1, true) then
		if level == 0 then
			self._txtDesc.text = string.format(desc, tonumber(moNext:getEffectValue()))
		else
			self._txtDesc.text = string.format(desc, tonumber(mo:getEffectValue()))
		end
	else
		self._txtDesc.text = desc
	end

	local moMax = AchievementModel.instance:getSkillLevelMo(mo:getId(), maxLevel)
	local descMax = moMax:getDescOne()

	self._txtDetailName.text = self._tabMo:getName()
	self._txtDetailLevel.text = string.format("Lv.%s（MAX）", maxLevel)

	if string.find(descMax, "%s", 1, true) then
		self._txtDetailDesc.text = string.format(descMax, tonumber(moMax:getEffectValue()))
	else
		self._txtDetailDesc.text = descMax
	end

	self._imgProgressReward.fillAmount = CommonViewUtil.calculate(level, self._lvRewards, self.step_getter, self.progress_getter, 0, 0)

	for i, v in ipairs(self._rewardGos) do
		local itemGo = v.transform:GetChild(0).gameObject
		local pointGo = goutil.findChild(v, "point")
		local txtLevel = goutil.findChildTextComponent(v, "txtLv")
		local canGetTag = goutil.findChild(itemGo, "canReceive")
		local isGetTag = goutil.findChild(itemGo, "imgReceived")
		local hasData = i <= #self._lvRewards
		local rewardItem = Astral.LuaComponentContainer.Add(itemGo, ItemCell)
		local normalComponent = rewardItem:getComponent("normal")

		rewardItem:setShowSelectedEffect(false)

		if hasData then
			goutil.setActive(pointGo, level >= self._lvRewards[i].level)

			txtLevel.text = string.format("Lv.%s", self._lvRewards[i].level)

			local rewardCO = RewardConfig.instance:getRewardCfgByCode(self._lvRewards[i].rewardId)
			local tempList = {}

			if rewardCO then
				for m, n in ipairs(rewardCO.reward and rewardCO.reward or {}) do
					table.insert(tempList, {
						itemId = n.code,
						num = n.num
					})
				end
			end

			rewardItem:updateData(ItemData.New({
				count = tempList[1].num,
				itemId = tempList[1].itemId
			}))

			local canGet = skillMo:canGetLevelReward(self._lvRewards[i].level)
			local isGet = skillMo:isGetLevelReward(self._lvRewards[i].level)
			local isGoGetReward = canGet and not isGet

			goutil.setActive(canGetTag, isGoGetReward)
			goutil.setActive(isGetTag, isGet)
			goutil.setActive(normalComponent:getRedPoint(), isGoGetReward)
			normalComponent:setClickListener(function()
				if isGoGetReward then
					AchievementAgent.instance:sendTakeAchievementSkillLevelRewardRequest(self._skillId, {
						self._lvRewards[i].level
					})
				else
					rewardItem:dealSelect()
				end
			end, self)
		end

		goutil.setActive(v, hasData)
	end
end

function M:_updateCellTask(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopListTask:NewListViewItem("achievement_skill_task_item")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, AchievementSkillItem)
	local mo = self._data[curIndex]

	itemView:updateData(mo)

	return item
end

function M:_onClickGetAllReward()
	local idList = {}

	for i, v in ipairs(self._data or {}) do
		if v:canGetReward() and not v:getIsFinish() then
			table.insert(idList, v:getId())
		end
	end

	AchievementAgent.instance:sendTakeRewardRequest(idList)
end

function M:_onClickBtnDetail()
	self._canvasGroup.alpha = 0

	goutil.setActive(self._tipsRoot, true)
	self._canvasGroup:DOFade(1, 0.2):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
end

function M:_onHideTips()
	self._canvasGroup:DOFade(0, 0.2):OnComplete(self._onFinish, self):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
end

function M:_onFinish()
	goutil.setActive(self._tipsRoot, false)
end

function M.step_getter(config)
	return config.level
end

function M.progress_getter(config, configs)
	local progressData = {
		0.05,
		0.3,
		0.55,
		0.77,
		1
	}
	local progressList = {}

	for i, v in ipairs(configs) do
		table.insert(progressList, {
			[v.level] = progressData[i]
		})
	end

	for i, v in ipairs(progressList) do
		if v[config.level] then
			return v[config.level]
		end
	end

	return 0
end

return M
