-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_ResultFinalView.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_ResultFinalView", package.seeall)

local Rouge2_ResultFinalView = class("Rouge2_ResultFinalView", BaseView)

function Rouge2_ResultFinalView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._goDifficulty = gohelper.findChild(self.viewGO, "Title/#go_Difficulty")
	self._txtDifficulty = gohelper.findChildText(self.viewGO, "Title/title/#txt_Difficulty")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._simageCareerIcon = gohelper.findChildSingleImage(self.viewGO, "Left/#go_Career/#simage_CareerIcon")
	self._txtCareerName = gohelper.findChildText(self.viewGO, "Left/#go_Career/#txt_CareerName")
	self._goAttrList = gohelper.findChild(self.viewGO, "Left/#go_AttrList")
	self._goAttrItem = gohelper.findChild(self.viewGO, "Left/#go_AttrList/#go_AttrItem")
	self._goDrug = gohelper.findChild(self.viewGO, "Left/#go_Drug")
	self._goHasDrug = gohelper.findChild(self.viewGO, "Left/#go_Drug/#go_HasDrug")
	self._simageDrugIcon = gohelper.findChildSingleImage(self.viewGO, "Left/#go_Drug/#go_HasDrug/#simage_DrugIcon")
	self._goEmptyDrug = gohelper.findChild(self.viewGO, "Left/#go_Drug/#go_EmptyDrug")
	self._goHeroGroup = gohelper.findChild(self.viewGO, "Left/#go_HeroGroup")
	self._goActiveSkill = gohelper.findChild(self.viewGO, "Left/#go_ActiveSkill")
	self._goplayinfo = gohelper.findChild(self.viewGO, "Left/#go_playinfo")
	self._txtplayername = gohelper.findChildText(self.viewGO, "Left/#go_playinfo/#txt_playername")
	self._txttime = gohelper.findChildText(self.viewGO, "Left/#go_playinfo/#txt_time")
	self._simageplayericon = gohelper.findChildSingleImage(self.viewGO, "Left/#go_playinfo/#simage_playericon")
	self._txtBuffNum = gohelper.findChildText(self.viewGO, "Right/Layout/#go_BuffContainer/#go_BuffTitle/#txt_BuffNum")
	self._txtAttrBuffNum = gohelper.findChildText(self.viewGO, "Right/Layout/#go_AttrBuffContainer/#go_AttrBuffTitle/#txt_AttrBuffNum")
	self._goEmptyBuff = gohelper.findChild(self.viewGO, "Right/Layout/#go_BuffContainer/#go_EmptyBuff")
	self._goEmptyAttrBuff = gohelper.findChild(self.viewGO, "Right/Layout/#go_AttrBuffContainer/#go_EmptyAttrBuff")
	self._txtScore = gohelper.findChildText(self.viewGO, "Right/#txt_Score")
	self._imageRare = gohelper.findChildImage(self.viewGO, "Right/#image_Rare")
	self._imageAssessBg = gohelper.findChildImage(self.viewGO, "Right/#image_AssessBg")
	self._imageAssess = gohelper.findChildImage(self.viewGO, "Right/#image_AssessBg/#image_Assess")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._btnShow = gohelper.findChildButton(self.viewGO, "#btn_Show")
	self._goHide = gohelper.findChild(self.viewGO, "#go_Hide")
	self._btnHide = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Hide/#btn_Hide")
	self._goBtnContainer = gohelper.findChild(self.viewGO, "Right/#go_BtnContainer")
	self._btnSave = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_BtnContainer/#btn_Save")
	self._goCanSave = gohelper.findChild(self.viewGO, "Right/#go_BtnContainer/#btn_Save/#go_CanSave")
	self._goNotSave = gohelper.findChild(self.viewGO, "Right/#go_BtnContainer/#btn_Save/#go_NotSave")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_BtnContainer/#btn_Close")
	self._btnAssessTips = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Assess/#btn_AssessTips")
	self._goAssessTips = gohelper.findChild(self.viewGO, "#go_AssessTips")
	self._btnCloseAssess = gohelper.findChildButtonWithAudio(self.viewGO, "#go_AssessTips/#btn_CloseAssess")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ResultFinalView:addEvents()
	self._btnShow:AddClickListener(self._btnShowOnClick, self)
	self._btnHide:AddClickListener(self._btnHideOnClick, self)
	self._btnSave:AddClickListener(self._btnSaveOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnAssessTips:AddClickListener(self._btnAssessTipsOnClick, self)
	self._btnCloseAssess:AddClickListener(self._btnCloseAssessOnClick, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSaveRecordDone, self._onSaveRecordDone, self)
end

function Rouge2_ResultFinalView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnShow:RemoveClickListener()
	self._btnHide:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self._btnAssessTips:RemoveClickListener()
	self._btnCloseAssess:RemoveClickListener()
end

function Rouge2_ResultFinalView:_btnCloseOnClick()
	Rouge2_FightRecordController.instance:cancelSaveRecord()
	self:closeThis()
end

function Rouge2_ResultFinalView:_btnHideOnClick()
	self:setBtnActive(false)
end

function Rouge2_ResultFinalView:_btnShowOnClick()
	self:setBtnActive(true)
end

function Rouge2_ResultFinalView:_btnSaveOnClick()
	if not self._isCanSave then
		local minDiffName, minDiff = Rouge2_FightRecordController.instance:getMainRecordDifficultyName()

		GameFacade.showToast(ToastEnum.Rouge2CantSave, minDiffName, minDiff)

		return
	elseif self._isSaveRecordDone then
		GameFacade.showToast(ToastEnum.Rouge2HasSave)

		return
	end

	self:refreshBtn()
	Rouge2_FightRecordController.instance:startSaveRecord()
end

function Rouge2_ResultFinalView:_btnAssessTipsOnClick()
	gohelper.setActive(self._goAssessTips, true)
end

function Rouge2_ResultFinalView:_btnCloseAssessOnClick()
	gohelper.setActive(self._goAssessTips, false)
end

function Rouge2_ResultFinalView:checkNewUnlock()
	local isOpen = Rouge2_OutsideController.instance:checkNewPass()

	if not isOpen then
		Rouge2_OutsideController.instance:checkNewUnlock()
	end
end

function Rouge2_ResultFinalView:setBtnActive(active)
	gohelper.setActive(self._goHide, active)
	gohelper.setActive(self._gotopleft, active and self.type == Rouge2_OutsideEnum.ResultFinalDisplayType.Review)
	gohelper.setActive(self._btnShow, not active)
end

function Rouge2_ResultFinalView:_editableInitView()
	self._difficultyBgList = self:getUserDataTb_()

	local parentGo = self._goDifficulty.transform
	local childCount = parentGo.childCount

	for i = 1, childCount do
		local childGo = parentGo:GetChild(i - 1).gameObject

		table.insert(self._difficultyBgList, childGo)
	end

	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)

	self._heroGroupComp = Rouge2_SaveInfoHeroGroupComp.Get(self._goHeroGroup)
	self._activeSkillComp = Rouge2_SaveInfoActiveSkillComp.Get(self._goActiveSkill, Rouge2_Enum.CommonSkillIconType.Type_3)

	self._activeSkillComp:updateSystemParam(Rouge2_Enum.TeamRecommendParam.IsShowSystemIcon, false)
	self._activeSkillComp:updateSystemParam(Rouge2_Enum.TeamRecommendParam.Spacing, 35)
	self._activeSkillComp:setLayoutSpacing(-50)
	gohelper.setActive(self._goAssessTips, false)

	self._isSaveRecordDone = false
end

function Rouge2_ResultFinalView:onUpdateParam()
	return
end

function Rouge2_ResultFinalView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_over)

	if self.viewParam then
		local reviewInfo = self.viewParam.reviewInfo

		if self.viewParam then
			if not self.viewParam.displayType then
				self.type = Rouge2_OutsideEnum.ResultFinalDisplayType.Review

				self:refreshUI(reviewInfo)
				self:setBtnActive(true)
			end
		end
	end
end

function Rouge2_ResultFinalView:refreshUI(reviewInfo)
	if not reviewInfo then
		return
	end

	self:refreshBaseInfo(reviewInfo)
	self:refreshCareerInfo(reviewInfo)
	self:refreshAttrInfo(reviewInfo)
	self:refreshHeroInfo(reviewInfo)
	self:refreshSkillInfo(reviewInfo)
	self:refreshDrug(reviewInfo)
	self:refreshPlayerInfo(reviewInfo)
	self:refreshItemList(reviewInfo)
end

function Rouge2_ResultFinalView:refreshBaseInfo(reviewInfo)
	self:refreshDifficultyBg(reviewInfo)

	local isSucc = reviewInfo:isSucceed()

	gohelper.setActive(self._gosuccess, isSucc)
	gohelper.setActive(self._gofail, not isSucc)

	if self.viewParam then
		local resultInfo = self.viewParam.reviewInfo

		self._isResultType = self.type == Rouge2_OutsideEnum.ResultFinalDisplayType.Result
		self._isCanSave = self._isResultType and Rouge2_FightRecordController.instance:checkCanSave(resultInfo)

		self:refreshBtn()

		local score = reviewInfo:getScore() or 0

		self._txtScore.text = score

		Rouge2_IconHelper.setResultAssessIcon(score, self._imageAssess, self._imageAssessBg, self._imageRare)
	end
end

function Rouge2_ResultFinalView:refreshBtn()
	gohelper.setActive(self._goBtnContainer, self._isResultType)
	gohelper.setActive(self._goCanSave, self._isCanSave and not self._isSaveRecordDone)
	gohelper.setActive(self._goNotSave, not self._isCanSave or self._isSaveRecordDone)
end

function Rouge2_ResultFinalView.getEndingDesc(reviewInfo)
	local isSucc = reviewInfo:isSucceed()
	local desc = ""

	if isSucc then
		local endingId = reviewInfo.endId
		local endingCfg = Rouge2_Config.instance:getEndingCO(endingId)

		desc = endingCfg and endingCfg.desc
	else
		local layerId = reviewInfo.layerId
		local middleLayerId = reviewInfo.middleLayerId
		local isInMiddleLayer = reviewInfo:isInMiddleLayer()
		local finalStepLayerName = ""

		if isInMiddleLayer then
			local middleLayerCfg = lua_rouge2_middle_layer.configDict[middleLayerId]

			finalStepLayerName = middleLayerCfg and middleLayerCfg.name
		else
			local layerCfg = lua_rouge2_layer.configDict[layerId]

			finalStepLayerName = layerCfg and layerCfg.name
		end

		desc = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("p_rougeresultreportview_txt_dec5"), finalStepLayerName)
	end

	return desc
end

function Rouge2_ResultFinalView:refreshDifficultyBg(reviewInfo)
	local difficulty = reviewInfo:getDifficulty()
	local diffCo = Rouge2_Config.instance:getDifficultyCoById(difficulty)

	self._txtDifficulty.text = diffCo and diffCo.title

	local constConfig = Rouge2_Config.instance:getConstCoById(Rouge2_Enum.ConstId.DifficultyIndexDuration)
	local duration = tonumber(constConfig.value)
	local bgIndex = math.floor(diffCo.difficulty / duration) + 1 or 1

	for index, bg in ipairs(self._difficultyBgList) do
		gohelper.setActive(bg, index == bgIndex)
	end
end

function Rouge2_ResultFinalView:refreshCareerInfo(reviewInfo)
	local careerId = reviewInfo.curCareer

	Rouge2_IconHelper.setCareerName(careerId, self._txtCareerName, true)
	Rouge2_IconHelper.setCareerIcon(careerId, self._simageCareerIcon, Rouge2_Enum.CareerIconSuffix.Bag)
end

function Rouge2_ResultFinalView:refreshAttrInfo(reviewInfo)
	local attrInfoList = reviewInfo:getLeaderAttrInfoList() or {}

	gohelper.CreateObjList(self, self._refreshAttrItem, attrInfoList, self._goAttrList, self._goAttrItem)
end

function Rouge2_ResultFinalView:_refreshAttrItem(goItem, attrInfo, index)
	local imageIcon = gohelper.findChildImage(goItem, "image_Icon")
	local txtValue = gohelper.findChildText(goItem, "txt_Value")
	local txtName = gohelper.findChildText(goItem, "txt_Name")
	local attrId = attrInfo.id
	local attrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(attrId)

	txtValue.text = attrInfo.value
	txtName.text = attrCo and attrCo.name

	Rouge2_IconHelper.setAttributeIcon(attrId, imageIcon)
end

function Rouge2_ResultFinalView:refreshHeroInfo(reviewInfo)
	local lastTeamInfoList = reviewInfo and reviewInfo:getLastTeamInfoList()
	local systemId = reviewInfo and reviewInfo:getSystemId()

	self._heroGroupComp:onUpdateMO(lastTeamInfoList, systemId)
end

function Rouge2_ResultFinalView:refreshPlayerInfo(reviewInfo)
	self._txtplayername.text = reviewInfo.playerName

	local finishTime = reviewInfo.finishTime / 1000

	self._txttime.text = TimeUtil.localTime2ServerTimeString(finishTime, "%Y.%m.%d %H:%M")
	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simageplayericon)

	self._liveHeadIcon:setLiveHead(reviewInfo.portrait)
end

function Rouge2_ResultFinalView:refreshSkillInfo(reviewInfo)
	local skillList = reviewInfo:getItemList(Rouge2_Enum.BagType.ActiveSkill)

	self._activeSkillComp:onUpdateMO(Rouge2_Enum.ItemDataType.Config, skillList)
end

function Rouge2_ResultFinalView:refreshDrug(reviewInfo)
	local drugId = reviewInfo:getDrugId()
	local useDrug = drugId and drugId ~= 0

	gohelper.setActive(self._goHasDrug, useDrug)
	gohelper.setActive(self._goEmptyDrug, not useDrug)

	if useDrug then
		Rouge2_IconHelper.setFormulaIcon(drugId, self._simageDrugIcon)
	end
end

function Rouge2_ResultFinalView:refreshItemList(reviewInfo)
	local buffList = reviewInfo:getItemList(Rouge2_Enum.BagType.Buff)

	if buffList then
		if not #buffList then
			local buffNum = 0

			self._txtBuffNum.text = buffNum

			self.viewContainer:setBuffList(buffList)
			gohelper.setActive(self._goEmptyBuff, buffNum <= 0)

			local attrBuffList = reviewInfo:getItemList(Rouge2_Enum.BagType.AttrBuff)

			if attrBuffList then
				if not #attrBuffList then
					local attrBuffNum = 0

					self._txtAttrBuffNum.text = attrBuffNum

					self.viewContainer:setAttrBuffList(attrBuffList)
					gohelper.setActive(self._goEmptyAttrBuff, attrBuffNum <= 0)
				end
			end
		end
	end
end

function Rouge2_ResultFinalView:_onSaveRecordDone()
	self._isSaveRecordDone = true

	self:refreshBtn()
end

function Rouge2_ResultFinalView:onClose()
	if self.type == Rouge2_OutsideEnum.ResultFinalDisplayType.Result then
		self:checkNewUnlock()
	end
end

function Rouge2_ResultFinalView:onDestroyView()
	self._simageDrugIcon:UnLoadImage()
	self._simageCareerIcon:UnLoadImage()
end

return Rouge2_ResultFinalView
