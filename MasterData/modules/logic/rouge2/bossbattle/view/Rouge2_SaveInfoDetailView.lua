-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_SaveInfoDetailView.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_SaveInfoDetailView", package.seeall)

local Rouge2_SaveInfoDetailView = class("Rouge2_SaveInfoDetailView", BaseView)

function Rouge2_SaveInfoDetailView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
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
	self._txtBuffNum = gohelper.findChildText(self.viewGO, "Right/Layout/#go_BuffContainer/#go_BuffTitle/#txt_BuffNum")
	self._txtAttrBuffNum = gohelper.findChildText(self.viewGO, "Right/Layout/#go_AttrBuffContainer/#go_AttrBuffTitle/#txt_AttrBuffNum")
	self._goEmptyBuff = gohelper.findChild(self.viewGO, "Right/Layout/#go_BuffContainer/#go_EmptyBuff")
	self._goEmptyAttrBuff = gohelper.findChild(self.viewGO, "Right/Layout/#go_AttrBuffContainer/#go_EmptyAttrBuff")
	self._imageRare = gohelper.findChildImage(self.viewGO, "Right/#image_Rare")
	self._imageAssessBg = gohelper.findChildImage(self.viewGO, "Right/#image_AssessBg")
	self._imageAssess = gohelper.findChildImage(self.viewGO, "Right/#image_AssessBg/#image_Assess")
	self._txtScore = gohelper.findChildText(self.viewGO, "Right/#txt_Score")
	self._btnAssessTips = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Assess/#btn_AssessTips")
	self._goAssessTips = gohelper.findChild(self.viewGO, "#go_AssessTips")
	self._btnCloseAssess = gohelper.findChildButtonWithAudio(self.viewGO, "#go_AssessTips/#btn_CloseAssess")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_SaveInfoDetailView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnAssessTips:AddClickListener(self._btnAssessTipsOnClick, self)
	self._btnCloseAssess:AddClickListener(self._btnCloseAssessOnClick, self)
end

function Rouge2_SaveInfoDetailView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnAssessTips:RemoveClickListener()
	self._btnCloseAssess:RemoveClickListener()
end

function Rouge2_SaveInfoDetailView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_SaveInfoDetailView:_btnAssessTipsOnClick()
	gohelper.setActive(self._goAssessTips, true)
end

function Rouge2_SaveInfoDetailView:_btnCloseAssessOnClick()
	gohelper.setActive(self._goAssessTips, false)
end

function Rouge2_SaveInfoDetailView:_editableInitView()
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
end

function Rouge2_SaveInfoDetailView:onUpdateParam()
	return
end

function Rouge2_SaveInfoDetailView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_over)

	self._saveInfo = self.viewParam and self.viewParam.saveInfo
	self._reviewInfo = self._saveInfo and self._saveInfo:getReviewInfo()

	self:refreshUI()
end

function Rouge2_SaveInfoDetailView:refreshUI()
	if not self._saveInfo or not self._reviewInfo then
		return
	end

	self:refreshBaseInfo()
	self:refreshCareerInfo()
	self:refreshAttrInfo()
	self:refreshHeroInfo()
	self:refreshSkillInfo()
	self:refreshDrug()
	self:refreshItemList()
end

function Rouge2_SaveInfoDetailView:refreshBaseInfo()
	self:refreshDifficultyBg()

	local score = self._reviewInfo:getScore()

	self._txtScore.text = Rouge2_IconHelper.getScoreStr(score)

	Rouge2_IconHelper.setResultAssessIcon(score, self._imageAssess, self._imageAssessBg, self._imageRare)
end

function Rouge2_SaveInfoDetailView:refreshDifficultyBg()
	if self._reviewInfo then
		local difficulty = self._reviewInfo:getDifficulty()
		local diffCo = Rouge2_Config.instance:getDifficultyCoById(difficulty)

		self._txtDifficulty.text = diffCo and diffCo.title

		local constConfig = Rouge2_Config.instance:getConstCoById(Rouge2_Enum.ConstId.DifficultyIndexDuration)
		local duration = tonumber(constConfig.value)
		local bgIndex = math.floor(diffCo.difficulty / duration) + 1 or 1

		for index, bg in ipairs(self._difficultyBgList) do
			gohelper.setActive(bg, index == bgIndex)
		end
	end
end

function Rouge2_SaveInfoDetailView:refreshCareerInfo()
	local careerId = self._reviewInfo:getCareerId()

	Rouge2_IconHelper.setCareerName(careerId, self._txtCareerName, true)
	Rouge2_IconHelper.setCareerIcon(careerId, self._simageCareerIcon, Rouge2_Enum.CareerIconSuffix.Bag)
end

function Rouge2_SaveInfoDetailView:refreshAttrInfo()
	local attrInfoList = self._reviewInfo:getLeaderAttrInfoList() or {}

	gohelper.CreateObjList(self, self._refreshAttrItem, attrInfoList, self._goAttrList, self._goAttrItem)
end

function Rouge2_SaveInfoDetailView:_refreshAttrItem(goItem, attrInfo, index)
	local imageIcon = gohelper.findChildImage(goItem, "image_Icon")
	local txtValue = gohelper.findChildText(goItem, "txt_Value")
	local txtName = gohelper.findChildText(goItem, "txt_Name")
	local attrId = attrInfo.id
	local attrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(attrId)

	txtValue.text = attrInfo.value
	txtName.text = attrCo and attrCo.name

	Rouge2_IconHelper.setAttributeIcon(attrId, imageIcon)
end

function Rouge2_SaveInfoDetailView:refreshHeroInfo()
	if self._reviewInfo then
		local lastTeamInfoList = self._reviewInfo:getLastTeamInfoList()

		if self._reviewInfo then
			local systemId = self._reviewInfo:getSystemId()

			self._heroGroupComp:onUpdateMO(self._reviewInfo, systemId)
		end
	end
end

function Rouge2_SaveInfoDetailView:refreshSkillInfo()
	if self._reviewInfo then
		local skillList = self._reviewInfo:getItemList(Rouge2_Enum.BagType.ActiveSkill)

		self._activeSkillComp:onUpdateMO(Rouge2_Enum.ItemDataType.Config, self._reviewInfo)
	end
end

function Rouge2_SaveInfoDetailView:refreshDrug()
	if self._reviewInfo then
		local drugId = self._reviewInfo:getDrugId()
		local useDrug = drugId and drugId ~= 0

		gohelper.setActive(self._goHasDrug, useDrug)
		gohelper.setActive(self._goEmptyDrug, not useDrug)

		if useDrug then
			Rouge2_IconHelper.setFormulaIcon(drugId, self._simageDrugIcon)
		end
	end
end

function Rouge2_SaveInfoDetailView:refreshItemList()
	local buffList = self._reviewInfo:getItemList(Rouge2_Enum.BagType.Buff)

	if buffList then
		if not #buffList then
			local buffNum = 0

			self._txtBuffNum.text = buffNum

			self.viewContainer:setBuffList(buffList)
			gohelper.setActive(self._goEmptyBuff, buffNum <= 0)

			local attrBuffList = self._reviewInfo:getItemList(Rouge2_Enum.BagType.AttrBuff)

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

function Rouge2_SaveInfoDetailView:onClose()
	return
end

function Rouge2_SaveInfoDetailView:onDestroyView()
	self._simageDrugIcon:UnLoadImage()
	self._simageCareerIcon:UnLoadImage()
end

return Rouge2_SaveInfoDetailView
