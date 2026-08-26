-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CareerHandBookTransferView.lua

module("modules.logic.rouge2.outside.view.Rouge2_CareerHandBookTransferView", package.seeall)

local Rouge2_CareerHandBookTransferView = class("Rouge2_CareerHandBookTransferView", BaseView)

function Rouge2_CareerHandBookTransferView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagepanelmask1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg/#simage_panelmask1")
	self._simagepanelmask2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg/#simage_panelmask2")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_bg/#simage_mask")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gocareerattributemap = gohelper.findChild(self.viewGO, "Career/#go_careerattributemap")
	self._txtname = gohelper.findChildText(self.viewGO, "Career/#txt_name")
	self._gosubName = gohelper.findChild(self.viewGO, "Career/#txt_name/#go_subName")
	self._txtsub = gohelper.findChildText(self.viewGO, "Career/#txt_name/#go_subName/#txt_sub")
	self._txten = gohelper.findChildText(self.viewGO, "Career/#txt_en")
	self._golock = gohelper.findChild(self.viewGO, "Initial/Viewport/Content/#go_lock")
	self._txtunlockTips = gohelper.findChildText(self.viewGO, "Initial/Viewport/Content/#go_lock/tips/unlocktips/#txt_unlockTips")
	self._gounlock = gohelper.findChild(self.viewGO, "Initial/Viewport/Content/#go_unlock")
	self._goSkillUnlock = gohelper.findChild(self.viewGO, "Initial/Viewport/Content/#go_unlock/#go_SkillUnlock")
	self._goSkillItem = gohelper.findChild(self.viewGO, "Initial/Viewport/Content/#go_unlock/#go_SkillUnlock/#go_SkillItem")
	self._imageSkillIcon = gohelper.findChildImage(self.viewGO, "Initial/Viewport/Content/#go_unlock/#go_SkillUnlock/#go_SkillItem/#image_SkillIcon")
	self._btnSearch = gohelper.findChildButtonWithAudio(self.viewGO, "Initial/Viewport/Content/#go_unlock/#go_SkillUnlock/#go_SkillItem/#btn_Search")
	self._txtskillName = gohelper.findChildText(self.viewGO, "Initial/Viewport/Content/#go_unlock/#go_SkillUnlock/#go_SkillItem/#txt_skillName")
	self._txtskillDesc = gohelper.findChildText(self.viewGO, "Initial/Viewport/Content/#go_unlock/#go_SkillUnlock/#go_SkillItem/#txt_skillDesc")
	self._goSkilllock = gohelper.findChild(self.viewGO, "Initial/Viewport/Content/#go_unlock/#go_Skilllock")
	self._txtunlockDesc2 = gohelper.findChildText(self.viewGO, "Initial/Viewport/Content/#go_unlock/#go_Skilllock/tips/unlocktips/#txt_unlockDesc2")
	self._goeffect = gohelper.findChild(self.viewGO, "Initial/Viewport/Content/#go_unlock/#go_effect")
	self._goEffectItem = gohelper.findChild(self.viewGO, "Initial/Viewport/Content/#go_unlock/#go_effect/#go_EffectItem")
	self._imageeffectIcon = gohelper.findChildImage(self.viewGO, "Initial/Viewport/Content/#go_unlock/#go_effect/#go_EffectItem/#image_effectIcon")
	self._txteffectName = gohelper.findChildText(self.viewGO, "Initial/Viewport/Content/#go_unlock/#go_effect/#go_EffectItem/#txt_effectName")
	self._txteffectDesc = gohelper.findChildText(self.viewGO, "Initial/Viewport/Content/#go_unlock/#go_effect/#go_EffectItem/#txt_effectDesc")
	self._scrolltab = gohelper.findChildScrollRect(self.viewGO, "#scroll_tab")
	self._gotabitem = gohelper.findChild(self.viewGO, "#scroll_tab/Viewport/Content/#go_tabitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CareerHandBookTransferView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnSearch:AddClickListener(self._btnSearchOnClick, self)
end

function Rouge2_CareerHandBookTransferView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnSearch:RemoveClickListener()
end

function Rouge2_CareerHandBookTransferView:_btncloseOnClick()
	self:closeThis()
end

function Rouge2_CareerHandBookTransferView:_btnSearchOnClick()
	return
end

function Rouge2_CareerHandBookTransferView:_editableInitView()
	local goCareerMap = self:getResInst(Rouge2_Enum.ResPath.AttributeMap, self._gocareerattributemap)

	self._attributeMap = Rouge2_CareerAttributeMap.Get(goCareerMap)

	self._attributeMap:setCareerSelectVisible(false)
	gohelper.setActive(self._scrolltab, false)
end

function Rouge2_CareerHandBookTransferView:onUpdateParam()
	return
end

function Rouge2_CareerHandBookTransferView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_guideorch)

	self._curCareerId = self.viewParam.careerId

	self:refreshUI()
end

function Rouge2_CareerHandBookTransferView:refreshUI()
	self:refreshTab()
	self:refreshCareerState()
end

function Rouge2_CareerHandBookTransferView:refreshTab()
	Rouge2_TalentModel.instance:setCurSelectId(nil)
end

function Rouge2_CareerHandBookTransferView:refreshCareerState()
	local transferId = Rouge2_TalentModel.instance:getCurTransferId()
	local isOriginCareer = transferId == nil
	local isLock = not isOriginCareer and Rouge2_TalentModel.instance:isCareerTransferOpen(transferId)

	gohelper.setActive(self._golock, isLock)
	gohelper.setActive(self._gounlock, not isLock)
	gohelper.setActive(self._goSkillUnlock, isOriginCareer)
	gohelper.setActive(self._goeffect, not isLock)
	gohelper.setActive(self._goSkilllock, isLock)
	gohelper.setActive(self._gosubName, not isOriginCareer)

	if not isOriginCareer then
		self:refreshUnlockTips(isLock)
	end

	if not isLock then
		if isOriginCareer then
			self:refreshSkillInfo()
		end

		self:refreshEffectInfo()
	end

	self:refreshAttributeInfo()
	self:refreshCareerInfo()
end

function Rouge2_CareerHandBookTransferView:refreshAttributeInfo()
	self._attributeMap:onUpdateMO(self._curCareerId, Rouge2_Enum.AttributeData.Config)
end

function Rouge2_CareerHandBookTransferView:refreshCareerInfo()
	local careerConfig = Rouge2_CareerConfig.instance:getCareerConfig(self._curCareerId)

	self._txtname.text = careerConfig.name
	self._txten.text = careerConfig.nameEn
end

function Rouge2_CareerHandBookTransferView:refreshUnlockTips(isLock)
	if isLock then
		if not self._txtunlockTips then
			local textDesc = self._txtunlockDesc2

			textDesc.text = ""
		end
	end
end

function Rouge2_CareerHandBookTransferView:refreshSkillInfo()
	local careerConfig = Rouge2_CareerConfig.instance:getCareerConfig(self._curCareerId)
	local paramList = string.splitToNumber(careerConfig.activeSkills, "|")

	gohelper.CreateObjList(self, self.onSkillItemShow, paramList, nil, self._goSkillItem, Rouge2_CareerHandBookTransferSkillItem, nil, nil, 1)
end

function Rouge2_CareerHandBookTransferView:onSkillItemShow(item, data, index)
	item:setInfo(data)
end

function Rouge2_CareerHandBookTransferView:refreshEffectInfo()
	local careerConfig = Rouge2_CareerConfig.instance:getCareerConfig(self._curCareerId)
	local paramList = string.splitToNumber(careerConfig.initialColletions, "|")

	gohelper.CreateObjList(self, self.onEffectItemShow, paramList, nil, self._goEffectItem, Rouge2_CareerHandBookTransferCollectionItem, nil, nil, 1)
end

function Rouge2_CareerHandBookTransferView:onEffectItemShow(item, data, index)
	item:setInfo(data)
end

function Rouge2_CareerHandBookTransferView:onClose()
	return
end

function Rouge2_CareerHandBookTransferView:onDestroyView()
	return
end

return Rouge2_CareerHandBookTransferView
