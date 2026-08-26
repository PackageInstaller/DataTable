-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_SettlementUnlockView.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_SettlementUnlockView", package.seeall)

local Rouge2_SettlementUnlockView = class("Rouge2_SettlementUnlockView", BaseView)

function Rouge2_SettlementUnlockView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtprogress = gohelper.findChildText(self.viewGO, "Layout/Level/progressbg/#txt_progress")
	self._txtlevel = gohelper.findChildText(self.viewGO, "Layout/Level/#txt_level")
	self._goprogress = gohelper.findChild(self.viewGO, "Layout/Level/#go_progress")
	self._scrollTalent = gohelper.findChildScrollRect(self.viewGO, "Layout/#scroll_Talent")
	self._gotalenttreeitem = gohelper.findChild(self.viewGO, "Layout/#scroll_Talent/Viewport/Content/#go_talenttreeitem")
	self._scrollcollection = gohelper.findChildScrollRect(self.viewGO, "#scroll_collection")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "#scroll_collection/Viewport/Content/#go_collectionitem")
	self._imagebg = gohelper.findChildImage(self.viewGO, "#scroll_collection/Viewport/Content/#go_collectionitem/#image_bg")
	self._imagecollection = gohelper.findChildImage(self.viewGO, "#scroll_collection/Viewport/Content/#go_collectionitem/#image_collection")
	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_replay")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_SettlementUnlockView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnreplay:AddClickListener(self._btnreplayOnClick, self)
end

function Rouge2_SettlementUnlockView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnreplay:RemoveClickListener()
end

function Rouge2_SettlementUnlockView:_btncloseOnClick()
	local resultInfo = Rouge2_Model.instance:getRougeResult()

	if resultInfo then
		ViewMgr.instance:closeView(ViewName.Rouge2_SettlementView)
		ViewMgr.instance:closeView(ViewName.Rouge2_ResultView)
		self:closeThis()

		local reviewInfo = resultInfo.reviewInfo
		local params = {
			reviewInfo = reviewInfo,
			displayType = Rouge2_OutsideEnum.ResultFinalDisplayType.Result
		}

		Rouge2_OutsideController.instance:openRougeResultFinalView(params)
	end
end

function Rouge2_SettlementUnlockView:_btnreplayOnClick()
	Rouge2_OutsideController.instance:openRougeResultView()
end

function Rouge2_SettlementUnlockView:_editableInitView()
	self._imageCareerProgress = gohelper.findChildImage(self.viewGO, "Layout/Level/#go_progress/Fill")
	self._talentNodeItemList = {}

	gohelper.setActive(self._gotalenttreeitem, false)
	gohelper.setActive(self._gocollectionitem, false)

	self._goMaterialEmpty = gohelper.findChild(self.viewGO, "empty")
	self._goCareerLayout = gohelper.findChild(self.viewGO, "Layout")

	NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc)
end

function Rouge2_SettlementUnlockView:onUpdateParam()
	return
end

function Rouge2_SettlementUnlockView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_report)

	self.resultInfo = Rouge2_Model.instance:getRougeResult()

	self:refreshUI()
end

function Rouge2_SettlementUnlockView:refreshUI()
	self:refreshMaterialInfo()

	local isUnlockCareer = Rouge2_OutsideController.instance:isCareerUnlock()

	gohelper.setActive(self._goCareerLayout, isUnlockCareer)

	if not isUnlockCareer then
		self:refreshCareerInfo()
		self:refreshTalentInfo()
	end
end

function Rouge2_SettlementUnlockView:refreshCareerInfo()
	local mainCareer = self.resultInfo.reviewInfo.mainCareer
	local gainExp = self.resultInfo.addCareerExp
	local level = Rouge2_TalentModel.instance:getCareerLevel(mainCareer)

	self._txtlevel.text = tostring(level)

	local curExp = Rouge2_TalentModel.instance:getCareerExp(mainCareer)
	local jobConfig = Rouge2_OutSideConfig.instance:getJobConfig(level)

	if jobConfig then
		if not jobConfig.geniusId then
			local maxExp = 0
			local progress = curExp ~= 0 and maxExp and math.min(curExp / maxExp, 1) or 0

			self._txtprogress.text = string.format("%s +%s", curExp, gainExp)
			self._imageCareerProgress.fillAmount = progress
		end
	end
end

function Rouge2_SettlementUnlockView:refreshTalentInfo()
	local resultInfo = self.resultInfo
	local gainExp = resultInfo.addCareerExp
	local careerId = resultInfo.reviewInfo.curCareer
	local curLevel = Rouge2_TalentModel.instance:getCareerLevel(careerId)
	local curExp = Rouge2_TalentModel.instance:getCareerExp(careerId)
	local previousLevel = Rouge2_TalentModel.instance:getCareerLevelByExp(math.max(0, curExp - gainExp))
	local unlockTalent = {}

	if previousLevel < curLevel then
		for i = previousLevel + 1, curLevel do
			local talentConfig = Rouge2_OutSideConfig.instance:getTalentTypeConfigByOrder(careerId, i)

			if talentConfig then
				table.insert(unlockTalent, talentConfig.geniusId)
			end
		end
	else
		table.insert(unlockTalent, 0)
	end

	local talentCount = #unlockTalent
	local itemScale = talentCount > 1 and 0.5 or 1

	for i = 1, talentCount do
		local talentId = unlockTalent[i]
		local item = self:getTalentItem(i, itemScale)

		gohelper.setActive(item.go, true)
		item:setInfo(talentId, itemScale)
	end
end

function Rouge2_SettlementUnlockView:refreshMaterialInfo()
	local resultInfo = self.resultInfo
	local getMaterialList = resultInfo.gainMaterial
	local materialCount = #getMaterialList

	gohelper.setActive(self._goMaterialEmpty, materialCount <= 0)
	Rouge2_ResultMaterialListModel.instance:initList(getMaterialList)
	gohelper.CreateObjList(self, self.onMaterialItemShow, Rouge2_ResultMaterialListModel.instance:getList(), nil, self._gocollectionitem, Rouge2_ResultCollectionListItem)
end

function Rouge2_SettlementUnlockView:onMaterialItemShow(item, data, index)
	item:onUpdateMO(data)
end

function Rouge2_SettlementUnlockView:getTalentItem(index)
	if not self._talentNodeItemList[index] then
		local go = gohelper.cloneInPlace(self._gotalenttreeitem)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_SettlementUnlockTalentItem)

		table.insert(self._talentNodeItemList, item)

		return item
	end

	return self._talentNodeItemList[index]
end

function Rouge2_SettlementUnlockView:onClose()
	return
end

function Rouge2_SettlementUnlockView:onDestroyView()
	return
end

return Rouge2_SettlementUnlockView
