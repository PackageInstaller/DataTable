-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_BossBattleDetailView.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_BossBattleDetailView", package.seeall)

local Rouge2_BossBattleDetailView = class("Rouge2_BossBattleDetailView", BaseView)

Rouge2_BossBattleDetailView.DelaySwitchBossInfo = 0.15
Rouge2_BossBattleDetailView.DelaySwitchSaveInfo = 0.15

function Rouge2_BossBattleDetailView:onInitView()
	self._goBossIconList = gohelper.findChild(self.viewGO, "Left/#scroll_BossIconList/Viewport/#go_BossIconList")
	self._goBossIconItem = gohelper.findChild(self.viewGO, "Left/#scroll_BossIconList/Viewport/#go_BossIconList/#go_BossIconItem")
	self._simageBossIcon = gohelper.findChildSingleImage(self.viewGO, "Middle/bossContainer/#simage_BossIcon")
	self._imageCareer = gohelper.findChildImage(self.viewGO, "Middle/bossContainer/#scroll_BaseInfo/Viewport/Content/Top/#image_Career")
	self._txtName = gohelper.findChildText(self.viewGO, "Middle/bossContainer/#scroll_BaseInfo/Viewport/Content/Top/#txt_Name")
	self._btnDetail = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/bossContainer/#scroll_BaseInfo/Viewport/Content/Top/#txt_Name/#btn_Detail")
	self._goTagList = gohelper.findChild(self.viewGO, "Middle/bossContainer/#scroll_BaseInfo/Viewport/Content/#go_TagList")
	self._goTagItem = gohelper.findChild(self.viewGO, "Middle/bossContainer/#scroll_BaseInfo/Viewport/Content/#go_TagList/#go_TagItem")
	self._txtDesc = gohelper.findChildText(self.viewGO, "Middle/bossContainer/#scroll_BaseInfo/Viewport/Content/#txt_Desc")
	self._goMaxScore = gohelper.findChild(self.viewGO, "Middle/bossContainer/#go_MaxScore")
	self._simageMaxScore = gohelper.findChildSingleImage(self.viewGO, "Middle/bossContainer/#go_MaxScore/#simage_MaxScore")
	self._txtMaxScore = gohelper.findChildText(self.viewGO, "Middle/bossContainer/#go_MaxScore/#txt_MaxScore")
	self._goReward = gohelper.findChild(self.viewGO, "Middle/#go_Reward")
	self._goHasSaveInfo = gohelper.findChild(self.viewGO, "Bottom/#go_HasSaveInfo")
	self._goNotSaveInfo = gohelper.findChild(self.viewGO, "Bottom/#go_NotSaveInfo")
	self._goSaveInfoPos = gohelper.findChild(self.viewGO, "Bottom/#go_HasSaveInfo/#go_SaveInfoPos")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "Bottom/#go_HasSaveInfo/#btn_Start")
	self._btnStart2 = gohelper.findChildButtonWithAudio(self.viewGO, "Bottom/#go_NotSaveInfo/#btn_Start2")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "Bottom/#go_HasSaveInfo/#btn_Left")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "Bottom/#go_HasSaveInfo/#btn_Right")
	self._goSavePointList = gohelper.findChild(self.viewGO, "Bottom/#go_HasSaveInfo/#go_SavePointList")
	self._goSavePointItem = gohelper.findChild(self.viewGO, "Bottom/#go_HasSaveInfo/#go_SavePointList/#go_SavePointItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BossBattleDetailView:addEvents()
	self._btnDetail:AddClickListener(self._btnDetailOnClick, self)
	self._btnStart:AddClickListener(self._btnStartOnClick, self)
	self._btnStart2:AddClickListener(self._btnStartOnClick, self)
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnUpdateBossBattleInfo, self._onUpdateBossBattleInfo, self)
end

function Rouge2_BossBattleDetailView:removeEvents()
	self._btnDetail:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnStart2:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function Rouge2_BossBattleDetailView:_btnDetailOnClick()
	if self._selectEpisodeCo then
		if self._selectEpisodeCo and self._selectEpisodeCo ~= 0 then
			EnemyInfoController.instance:openEnemyInfoViewByBattleId(self._selectEpisodeCo)
		end
	end
end

function Rouge2_BossBattleDetailView:_btnStartOnClick()
	if not self._selectBossId then
		return
	end

	Rouge2_BossBattleController.instance:enterFight(self._selectBossId)
end

function Rouge2_BossBattleDetailView:_btnLeftOnClick()
	self:playAnim2SwithSaveInfo(false)
end

function Rouge2_BossBattleDetailView:_btnRightOnClick()
	self:playAnim2SwithSaveInfo(true)
end

function Rouge2_BossBattleDetailView:_editableInitView()
	self._selectIndex = 0
	self._rewardListItem = Rouge2_BossBattleRewardList.Get(self._goReward)
	self._bossItemTab = self:getUserDataTb_()
	self._saveMO = {
		viewType = Rouge2_OutsideEnum.SaveInfoViewType.Show
	}
	self._goLeftBtn = self._btnLeft.gameObject
	self._goRightBtn = self._btnRight.gameObject

	SkillHelper.addHyperLinkClick(self._txtDesc)

	self._viewAnim = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._saveInfoAnim = gohelper.onceAddComponent(self._goHasSaveInfo, gohelper.Type_Animator)
end

function Rouge2_BossBattleDetailView:onOpen()
	self:initViewParam()
	self:refreshUI(self._initSelectIndex)
end

function Rouge2_BossBattleDetailView:initViewParam()
	self._battleInfo = self.viewParam and self.viewParam.battleInfo
	self._battleInfo = self._battleInfo or Rouge2_OutsideModel.instance:getBossBattleInfo()
	self._bossCoList = self.viewParam and self.viewParam.configList
	self._bossCoList = self._bossCoList or Rouge2_BossBattleConfig.instance:getAllBossConfigList()

	if self._bossCoList then
		self._bossNum = #self._bossCoList or 0
	end

	self._initSelectIndex = self:findSelectIndexParam()
end

function Rouge2_BossBattleDetailView:findSelectIndexParam()
	if self.viewParam then
		local selectIndex = self.viewParam.selectIndex

		if self.viewParam then
			local selectBossId = self.viewParam.selectBossId

			if self.viewParam then
				local selectEpisodeId = self.viewParam.selectEpisodeId

				if not self.viewParam and (selectBossId or selectEpisodeId) then
					for i, bossCo in ipairs(self._bossCoList) do
						local bossId = bossCo.id
						local episodeId = bossCo.levelId

						if bossId == selectBossId or episodeId == selectEpisodeId then
							selectIndex = i

							break
						end
					end
				end

				return self.viewParam or 1
			end
		end
	end
end

function Rouge2_BossBattleDetailView:refreshUI(selectIndex)
	self:updateSelectIndex(selectIndex)
	self:refreshSaveInfo()
end

function Rouge2_BossBattleDetailView:updateSelectIndex(index)
	if index <= 0 or index > self._bossNum then
		return
	end

	self._selectIndex = index
	self._selectBossCo = self._bossCoList[self._selectIndex]
	self._selectBossId = self._selectBossCo and self._selectBossCo.id
	self._selectBossInfo = self._battleInfo and self._battleInfo:getBossInfoById(self._selectBossId)
	self._selectEpisodeCo = Rouge2_BossBattleController.instance:getEpisodeCoByBossId(self._selectBossId)
	self._selectMonsterCo = Rouge2_BossBattleController.instance:getBossFightConfig(self._selectBossId)

	self._rewardListItem:onUpdateMO(self._battleInfo, self._selectBossCo)
	self:refreshBossUI()
	self:refreshBossIconList()
	self:refreshBossInfoLevel()
end

function Rouge2_BossBattleDetailView:refreshBossUI()
	self:refreshEpisodeName()

	self._txtDesc.text = Rouge2_ItemDescHelper.buildDesc(self._selectBossCo.battleInfo, "#F3A055")

	self._simageBossIcon:LoadImage(ResUrl.getRouge2Icon("bossbattle/" .. self._selectBossCo.bossIcon))

	if self._selectMonsterCo then
		if not self._selectMonsterCo.career then
			local career = ""

			UISpriteSetMgr.instance:setCommonSprite(self._imageCareer, "lssx_" .. career, true)

			local tagList = Rouge2_BossBattleConfig.instance:getBossTagList(self._selectBossId)

			gohelper.CreateObjList(self, self._refreshTagItem, tagList, self._goTagList, self._goTagItem)
		end
	end
end

function Rouge2_BossBattleDetailView:refreshEpisodeName()
	if self._selectEpisodeCo then
		if not self._selectEpisodeCo.name then
			local episodeName = ""
			local first = GameUtil.utf8sub(episodeName, 1, 1)

			self._txtName.text = string.format("<size=100>%s</size>%s", first, (GameUtil.utf8len(episodeName) >= 2 or nil) and GameUtil.utf8sub(episodeName, 2, GameUtil.utf8len(episodeName) - 1))
		end
	end
end

function Rouge2_BossBattleDetailView:_refreshTagItem(goTag, tagName, index)
	local txtName = gohelper.findChildText(goTag, "txt_TagName")

	SkillHelper.addHyperLinkClick(txtName)

	txtName.text = SkillHelper.buildDesc(tagName)
end

function Rouge2_BossBattleDetailView:refreshBossInfoLevel()
	local isPass = self._selectBossInfo ~= nil

	gohelper.setActive(self._goMaxScore, isPass)

	if isPass then
		local maxScore = self._selectBossInfo and self._selectBossInfo:getMaxScore() or 0

		self._txtMaxScore.text = maxScore

		Rouge2_IconHelper.setBossAssessIcon(maxScore, self._simageMaxScore)
	end
end

function Rouge2_BossBattleDetailView:refreshSaveInfo()
	local saveInfoNum = self._battleInfo and self._battleInfo:getSaveInfoNum() or 0
	local hasSaveInfo = saveInfoNum and saveInfoNum > 0
	local hasTwoSaveInfo = saveInfoNum and saveInfoNum > 1

	gohelper.setActive(self._goHasSaveInfo, hasSaveInfo)
	gohelper.setActive(self._goNotSaveInfo, not hasSaveInfo)
	gohelper.setActive(self._goRightBtn, hasTwoSaveInfo)
	gohelper.setActive(self._goLeftBtn, hasTwoSaveInfo)

	if not hasSaveInfo then
		return
	end

	local useSaveInfo = self._battleInfo:getUseSaveInfo()

	if not useSaveInfo then
		self:swithSaveInfo()

		return
	end

	self._selectSaveIndex = self._battleInfo and self._battleInfo:getUseSaveIndex()

	self:refreshSaveInfoItem(useSaveInfo)
	self:refreshSavePointList(saveInfoNum)
end

function Rouge2_BossBattleDetailView:refreshSaveInfoItem(saveInfo)
	if not self._saveInfoItem then
		local goSaveInfoItem = self:getResInst(Rouge2_Enum.ResPath.SaveInfoListItem, self._goSaveInfoPos, "go_SaveInfoItem")

		self._saveInfoItem = Rouge2_SaveInfoListItem.Get(goSaveInfoItem)
		self._saveInfoItem._view = self
	end

	self._saveMO.saveInfo = saveInfo

	self._saveInfoItem:onUpdateMO(self._saveMO)
end

function Rouge2_BossBattleDetailView:refreshSavePointList(saveInfoNum)
	saveInfoNum = saveInfoNum or 0

	gohelper.CreateNumObjList(self._goSavePointList, self._goSavePointItem, saveInfoNum, self._refreshSavePointItem, self)
end

function Rouge2_BossBattleDetailView:_refreshSavePointItem(goItem, index)
	local goSelect = gohelper.findChild(goItem, "go_Select")
	local goUnselect = gohelper.findChild(goItem, "go_Unselect")

	gohelper.setActive(goSelect, self._selectSaveIndex == index)
	gohelper.setActive(goUnselect, self._selectSaveIndex ~= index)
end

function Rouge2_BossBattleDetailView:playAnim2SwithSaveInfo(isNext)
	GameUtil.setActiveUIBlock(self.viewName, true, false)

	self._readySwithSave = isNext

	self._saveInfoAnim:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(self._onSwitchSaveInfoAnimDone, self)
	TaskDispatcher.runDelay(self._onSwitchSaveInfoAnimDone, self, Rouge2_BossBattleDetailView.DelaySwitchSaveInfo)
end

function Rouge2_BossBattleDetailView:_onSwitchSaveInfoAnimDone()
	GameUtil.setActiveUIBlock(self.viewName, false, true)
	self:swithSaveInfo(self._readySwithSave)
end

function Rouge2_BossBattleDetailView:swithSaveInfo(isNext)
	if self._battleInfo then
		local saveInfo = self._battleInfo:getNextSaveInfo(isNext)

		if not saveInfo then
			return
		end

		local saveIndex = saveInfo and saveInfo:getIndex()

		Rouge2_FightRecordController.instance:setUseRecordIndex(saveIndex)
	end
end

function Rouge2_BossBattleDetailView:_onUpdateBossBattleInfo()
	self:refreshUI(self._selectIndex)
end

function Rouge2_BossBattleDetailView:refreshBossIconList()
	gohelper.CreateObjList(self, self._refreshBossIconItem, self._bossCoList, self._goBossIconList, self._goBossIconItem)
end

function Rouge2_BossBattleDetailView:_refreshBossIconItem(goIcon, bossCo, index)
	local bossItem = self._bossItemTab[index]

	if not bossItem then
		bossItem = self:getUserDataTb_()
		bossItem.goSelect = gohelper.findChild(goIcon, "go_Select")
		bossItem.imageIcon1 = gohelper.findChildImage(goIcon, "go_Select/image_Icon")
		bossItem.goUnselect = gohelper.findChild(goIcon, "go_Unselect")
		bossItem.imageIcon2 = gohelper.findChildImage(goIcon, "go_Unselect/image_Icon")
		bossItem.btnClick = gohelper.findChildButtonWithAudio(goIcon, "btn_Click", AudioEnum.Rouge2.SwitchBoss)

		bossItem.btnClick:AddClickListener(self._onClickBossIcon, self, index)

		self._bossItemTab[index] = bossItem
	end

	UISpriteSetMgr.instance:setRouge8Sprite(bossItem.imageIcon1, bossCo.tabIcon)
	UISpriteSetMgr.instance:setRouge8Sprite(bossItem.imageIcon2, bossCo.tabIcon)
	gohelper.setActive(bossItem.goSelect, self._selectIndex == index)
	gohelper.setActive(bossItem.goUnselect, self._selectIndex ~= index)
end

function Rouge2_BossBattleDetailView:_onClickBossIcon(index)
	GameUtil.setActiveUIBlock(self.viewName, true, false)

	self._readySelectBossIndex = index
	self._viewAnim.enabled = true

	self._viewAnim:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(self._onSwitchBossAnimDone, self)
	TaskDispatcher.runDelay(self._onSwitchBossAnimDone, self, Rouge2_BossBattleDetailView.DelaySwitchBossInfo)
end

function Rouge2_BossBattleDetailView:_onSwitchBossAnimDone()
	GameUtil.setActiveUIBlock(self.viewName, false, true)

	if not self._readySelectBossIndex then
		return
	end

	self:updateSelectIndex(self._readySelectBossIndex)
end

function Rouge2_BossBattleDetailView:releasAllBossItem()
	if self._bossItemTab then
		for _, bossItem in pairs(self._bossItemTab) do
			bossItem.btnClick:RemoveClickListener()
		end
	end
end

function Rouge2_BossBattleDetailView:onClose()
	GameUtil.setActiveUIBlock(self.viewName, false, true)
	TaskDispatcher.cancelTask(self._onSwitchBossAnimDone, self)
	TaskDispatcher.cancelTask(self._onSwitchSaveInfoAnimDone, self)
end

function Rouge2_BossBattleDetailView:onDestroyView()
	self:releasAllBossItem()
	self._simageBossIcon:UnLoadImage()
	self._simageMaxScore:UnLoadImage()
end

return Rouge2_BossBattleDetailView
