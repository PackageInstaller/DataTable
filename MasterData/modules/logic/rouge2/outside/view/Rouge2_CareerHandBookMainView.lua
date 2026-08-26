-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CareerHandBookMainView.lua

module("modules.logic.rouge2.outside.view.Rouge2_CareerHandBookMainView", package.seeall)

local Rouge2_CareerHandBookMainView = class("Rouge2_CareerHandBookMainView", BaseView)

function Rouge2_CareerHandBookMainView:onInitView()
	self._txtprogress = gohelper.findChildText(self.viewGO, "Level/progressbg/#txt_progress")
	self._txtlevel = gohelper.findChildText(self.viewGO, "Level/#txt_level")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "Level/#btn_check")
	self._scrollTabList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TabList")
	self._gotabitem = gohelper.findChild(self.viewGO, "#scroll_TabList/Viewport/Content/#go_tabitem")
	self._scrollProgress = gohelper.findChildScrollRect(self.viewGO, "#scroll_Progress")
	self._gocareerGroup = gohelper.findChild(self.viewGO, "#scroll_Progress/Viewport/Content/#go_careerGroup")
	self._gocareeritem = gohelper.findChild(self.viewGO, "#scroll_Progress/Viewport/Content/#go_careerGroup/#go_careeritem")
	self._godetailview = gohelper.findChild(self.viewGO, "#go_detailview")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._btnCloseDetail = gohelper.findChildButton(self.viewGO, "#scroll_Progress/Viewport/#btn_closeDetail")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CareerHandBookMainView:addEvents()
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
	self._btnCloseDetail:AddClickListener(self._btnCloseDetailOnClick, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectHandBookCareer, self.onSelectTabItem, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectHandBookTalent, self.onSelectHandBookTalent, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnUpdateCommonTalent, self.refreshTalentGroup, self)
end

function Rouge2_CareerHandBookMainView:removeEvents()
	self._btncheck:RemoveClickListener()
	self._btnCloseDetail:RemoveClickListener()
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectHandBookCareer, self.onSelectTabItem, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectHandBookTalent, self.onSelectHandBookTalent, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnUpdateCommonTalent, self.refreshTalentGroup, self)
end

function Rouge2_CareerHandBookMainView:_btnClickOnClick()
	return
end

function Rouge2_CareerHandBookMainView:_btnclickOnClick()
	return
end

function Rouge2_CareerHandBookMainView:_btncheckOnClick()
	local param = {}

	param.careerId = self._curCareerId

	ViewMgr.instance:openView(ViewName.Rouge2_CareerHandBookTransferView, param)
end

function Rouge2_CareerHandBookMainView:_btnCloseDetailOnClick()
	ViewMgr.instance:closeView(ViewName.Rouge2_CareerHandBookDetailView)
	gohelper.setActive(self._btnCloseDetail, false)
end

function Rouge2_CareerHandBookMainView:_editableInitView()
	self._groupItemList = {}
	self._groupUseItemList = {}
	self._tabItemList = {}
	self._tabMoList = {}

	gohelper.setActive(self._gocareerGroup, false)

	self.animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
	self.levelAnimator = gohelper.findChildComponent(self.viewGO, "Level", gohelper.Type_Animator)

	gohelper.setActive(self._btnCloseDetail, false)
end

function Rouge2_CareerHandBookMainView:onSelectTabItem(mo, hideAnim)
	if ViewMgr.instance:isOpen(ViewName.Rouge2_CareerHandBookDetailView) then
		ViewMgr.instance:closeView(ViewName.Rouge2_CareerHandBookDetailView)
		gohelper.setActive(self._btnCloseDetail, false)
	end

	self._curCareerId = mo.careerId

	self:selectTabItem(mo.careerId)

	if not hideAnim then
		AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_orchclick)
		self.animator:Play("switch", 0, 0)

		local delayTime = Rouge2_OutsideEnum.CareerSwitchRefreshTime

		TaskDispatcher.runDelay(self.onSwitchAnimPlayFinish, self, delayTime)
		Rouge2_OutsideController.instance:lockScreen(true, delayTime)
	else
		self:refreshTalentGroup()
	end
end

function Rouge2_CareerHandBookMainView:selectTabItem(selectId)
	for _, item in ipairs(self._tabItemList) do
		item:onSelect(selectId == item._mo.careerId)
	end
end

function Rouge2_CareerHandBookMainView:onSwitchAnimPlayFinish()
	Rouge2_OutsideController.instance:lockScreen(false)
	TaskDispatcher.cancelTask(self.onSwitchAnimPlayFinish, self)
	self:refreshTalentGroup()
end

function Rouge2_CareerHandBookMainView:onSelectHandBookTalent(talentId)
	if ViewMgr.instance:isOpen(ViewName.Rouge2_CareerHandBookDetailView) then
		return
	end

	Rouge2_TalentModel.instance:setCurTalentId(talentId)

	local viewParam = {}

	viewParam.parentGo = self._godetailview
	viewParam.talentId = talentId

	Rouge2_ViewHelper.openRougeCareerHandBookDetailView(viewParam)
	gohelper.setActive(self._btnCloseDetail, true)
end

function Rouge2_CareerHandBookMainView:onUpdateParam()
	return
end

function Rouge2_CareerHandBookMainView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_guide)
	self:refreshUI()
end

function Rouge2_CareerHandBookMainView:refreshUI()
	self:refreshCareerTabItem()

	local firstMo = self._tabMoList[1]

	if firstMo then
		self:onSelectTabItem(firstMo, true)
	end
end

function Rouge2_CareerHandBookMainView:refreshCareerTabItem()
	local list = Rouge2_CareerConfig.instance:getAllCareerConfigs()

	for i, v in ipairs(list) do
		local mo = {
			id = i,
			careerId = v.id,
			config = v
		}

		table.insert(self._tabMoList, mo)
	end

	gohelper.CreateObjList(self, self.onTabItemShow, self._tabMoList, nil, self._gotabitem, Rouge2_CareerHandBookTabItem)
end

function Rouge2_CareerHandBookMainView:onTabItemShow(item, data, index)
	item:onUpdateMO(data)
	table.insert(self._tabItemList, item)
end

function Rouge2_CareerHandBookMainView:OnUpdateCommonTalent(geniusId)
	self:refreshTalentGroup()
end

function Rouge2_CareerHandBookMainView:refreshTalentGroup()
	local list = Rouge2_OutSideConfig.instance:getTalentConfigListByType(self._curCareerId)
	local result = {}

	if list then
		if not #list then
			local totalTalentCount = 0

			gohelper.setActive(self._scrollProgress, totalTalentCount > 0)

			if totalTalentCount == 0 then
				return
			end

			local lastGroupIndex = math.floor((totalTalentCount - 1) / 3) + 1
			local curTalentId = list[totalTalentCount].geniusId
			local nextTalentId

			for i, v in ipairs(list) do
				local groupId = math.floor((i - 1) / 3) + 1
				local groupMo

				if not result[groupId] then
					groupMo = {
						groupId = groupId,
						talentIdList = {},
						indexList = {},
						isLast = groupId == lastGroupIndex,
						careerId = self._curCareerId
					}

					table.insert(result, groupMo)
				else
					groupMo = result[groupId]
				end

				table.insert(groupMo.talentIdList, v.geniusId)
				table.insert(groupMo.indexList, i)
			end

			tabletool.clear(self._groupUseItemList)

			for i = 1, lastGroupIndex do
				local groupItem

				if not self._groupItemList[i] then
					local groupItemGo = gohelper.cloneInPlace(self._gocareerGroup, tostring(i))

					groupItem = MonoHelper.addNoUpdateLuaComOnceToGo(groupItemGo, Rouge2_CareerHandBookGroupItem)

					table.insert(self._groupItemList, groupItem)
				else
					groupItem = self._groupItemList[i]
				end

				table.insert(self._groupUseItemList, groupItem)
				groupItem:setActive(true)
				groupItem:setInfo(result[i])
			end

			local itemCount = #self._groupItemList

			if lastGroupIndex < itemCount then
				for i = lastGroupIndex + 1, itemCount do
					local groupItem = self._groupItemList[i]

					groupItem:setActive(false)
				end
			end

			self._curTalentId = curTalentId
			self._curCareerConfig = Rouge2_CareerConfig.instance:getCareerConfig(self._curCareerId)
			self._curTalentConfig = Rouge2_OutSideConfig.instance:getTalentConfigById(self._curTalentId)
			self.typeConfig = Rouge2_OutSideConfig.instance:getTalentTypeConfigByTalentId(self._curTalentId)
			self._curExp = Rouge2_TalentModel.instance:getCareerExp(self._curCareerId)
			self._curLevel = Rouge2_TalentModel.instance:getCareerLevel(self._curCareerId)

			local nextConfig = Rouge2_OutSideConfig.instance:getTalentTypeConfigByOrder(self._curCareerId, self.typeConfig.order + 1)

			if nextConfig ~= nil then
				self._nextTalentId = nextConfig.geniusId
			end

			local isLevelUp, previousLevel, previousExp = self:checkLevelUp()

			if not isLevelUp then
				self:refreshCareerInfo()
			else
				self:onLevelUp(previousLevel, previousExp)
			end
		end
	end
end

function Rouge2_CareerHandBookMainView:refreshCareerInfo()
	local curLevel = Rouge2_TalentModel.instance:getCareerLevel(self._curCareerId)

	self._txtlevel.text = tostring(curLevel)

	local curExp = Rouge2_TalentModel.instance:getCareerExp(self._curCareerId)
	local haveNextLevel = self._nextTalentId ~= nil
	local nextConfig = haveNextLevel and Rouge2_OutSideConfig.instance:getTalentTypeConfigByTalentId(self._nextTalentId) or self.typeConfig

	self._txtprogress.text = string.format("%s/%s", curExp, nextConfig.careerExp)
end

function Rouge2_CareerHandBookMainView:checkLevelUp()
	local curLevel = Rouge2_TalentModel.instance:getCareerLevel(self._curCareerId)
	local gainExp = Rouge2_TalentModel.instance:getCareerGainExp(self._curCareerId)

	if gainExp and gainExp > 0 then
		local previousExp = math.max(0, self._curExp - gainExp)
		local previousLevel = Rouge2_TalentModel.instance:getCareerLevelByExp(previousExp)

		if previousLevel < curLevel then
			logNormal("肉鸽2 当前职业技能升级 职业Id:" .. self._curCareerId .. " 先前等级: " .. previousLevel .. " 当前等级: " .. curLevel)

			return true, previousLevel, previousExp
		end
	end

	return false, nil
end

function Rouge2_CareerHandBookMainView:onLevelUp(previousLevel, previousExp)
	Rouge2_OutsideController.instance:lockScreen(true, Rouge2_OutsideEnum.CareerLevelUpTime)
	self.levelAnimator:Play("levelup", 0, 0)

	local param = {}

	param.previousLevel = previousLevel
	param.careerId = self._curCareerId
	self._previousLevel = previousLevel
	self._previousExp = previousExp

	local previousJobConfig = Rouge2_OutSideConfig.instance:getJobConfig(previousLevel)
	local curJobConfig = Rouge2_OutSideConfig.instance:getJobConfig(self._curLevel)

	self._previousTotalExp = previousJobConfig.geniusId
	self._curTotalExp = curJobConfig.geniusId

	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnLevelUpAnimStart, param)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, Rouge2_OutsideEnum.CareerLevelUpTime, self.frameChangeScoreCallBack, self.onLevelUpAnimFinish, self)
end

function Rouge2_CareerHandBookMainView:frameChangeScoreCallBack(curScore)
	local curLevel = self._previousLevel + curScore * (self._curLevel - self._previousLevel)
	local curExp = self._previousExp + curScore * (self._curExp - self._previousExp)
	local curTotalExp = self._previousTotalExp + curScore * (self._curTotalExp - self._previousTotalExp)

	self._txtlevel.text = tostring(math.floor(curLevel))
	self._txtprogress.text = string.format("%s/%s", math.floor(curExp), math.floor(curTotalExp))
end

function Rouge2_CareerHandBookMainView:onLevelUpAnimFinish()
	self.levelAnimator:Play("idle", 0, 0)
	Rouge2_OutsideController.instance:lockScreen(false, Rouge2_OutsideEnum.CareerLevelUpTime)
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnLevelUpAnimFinish, self._curCareerId)
	Rouge2_TalentModel.instance:clearCareerGainExp(self._curCareerId)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end
end

function Rouge2_CareerHandBookMainView:onClose()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	Rouge2_TalentModel.instance:setCurTalentId(nil)
	TaskDispatcher.cancelTask(self.onSwitchAnimPlayFinish, self)
end

function Rouge2_CareerHandBookMainView:onDestroyView()
	return
end

return Rouge2_CareerHandBookMainView
