-- chunkname: @modules/logic/tips/view/FightDeviceCardTipView.lua

module("modules.logic.tips.view.FightDeviceCardTipView", package.seeall)

local FightDeviceCardTipView = class("FightDeviceCardTipView", BaseView)

function FightDeviceCardTipView:onInitView()
	self.viewRect = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	self.viewWidth = recthelper.getWidth(self.viewRect)
	self.viewHeight = recthelper.getHeight(self.viewRect)
	self.goRoot = gohelper.findChild(self.viewGO, "layout")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightDeviceCardTipView:addEvents()
	return
end

function FightDeviceCardTipView:removeEvents()
	return
end

function FightDeviceCardTipView:_editableInitView()
	self.blockGraphic = gohelper.findChildComponent(self.viewGO, "close_block", gohelper.Type_Graphic)
	self.click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "close_block")

	self.click:AddClickListener(self.closeThis, self)

	self.skillItemList = {}

	table.insert(self.skillItemList, self:createSkillItem(self.goRoot))
end

function FightDeviceCardTipView:createSkillItem(goRoot)
	local skillItem = self:getUserDataTb_()

	skillItem.goRoot = goRoot
	skillItem.rectRoot = goRoot:GetComponent(gohelper.Type_RectTransform)
	skillItem.using = false
	skillItem._txttitle = gohelper.findChildText(goRoot, "#txt_title")
	skillItem._txtdesc = gohelper.findChildText(goRoot, "#txt_desc")
	skillItem._txtCostPower = gohelper.findChildText(goRoot, "grid/#txt_energy")
	skillItem._txtAddExPoint = gohelper.findChildText(goRoot, "grid/#txt_tongdiao")
	skillItem._imageEnergyIcon = gohelper.findChildImage(goRoot, "grid/#txt_energy/icon")

	return skillItem
end

function FightDeviceCardTipView:onUpdateParam()
	self:refreshUI()
end

function FightDeviceCardTipView:onOpen()
	self:refreshUI()
end

function FightDeviceCardTipView:refreshUI()
	if self.viewParam.openType == FightDeviceCardTipController.OpenType.DeviceSkillInfo then
		self:refreshByDeviceSkillInfo()
	else
		self:refreshByDeviceInfo()
	end

	self:setPos()
	self:checkIgnoreClick()
end

function FightDeviceCardTipView:refreshByDeviceSkillInfo()
	local deviceSkillInfo = self.viewParam.deviceSkillInfo
	local uid = self.viewParam.entityUid
	local skillItem = self.skillItemList[1]

	skillItem.using = true

	FightDeviceCardTipView.refreshContent(deviceSkillInfo, uid, skillItem._txttitle, skillItem._txtdesc, skillItem._txtCostPower, skillItem._txtAddExPoint, skillItem._imageEnergyIcon)

	for i = 2, #self.skillItemList do
		self.skillItemList[i].using = false
	end
end

function FightDeviceCardTipView:refreshByDeviceInfo()
	local deviceInfo = self.viewParam.deviceInfo
	local uid = self.viewParam.entityUid
	local group = deviceInfo.skills[deviceInfo.clientIndex]
	local skills = group and group.skills

	if not skills then
		for i = 1, #self.skillItemList do
			self.skillItemList[i].using = false
		end

		return
	end

	for index, skillInfo in ipairs(skills) do
		local skillItem = self.skillItemList[index]

		if not skillItem then
			skillItem = self:createSkillItem(gohelper.cloneInPlace(self.goRoot))

			table.insert(self.skillItemList, skillItem)
		end

		skillItem.using = true

		FightDeviceCardTipView.refreshContent(skillInfo, uid, skillItem._txttitle, skillItem._txtdesc, skillItem._txtCostPower, skillItem._txtAddExPoint, skillItem._imageEnergyIcon)
	end

	for i = #skills + 1, #self.skillItemList do
		self.skillItemList[i].using = false
	end
end

function FightDeviceCardTipView:setPos()
	local initAnchorX, initAnchorY = self:getInitPos()
	local preHeight = 0

	for _, skillItem in ipairs(self.skillItemList) do
		if skillItem.using then
			gohelper.setActive(skillItem.goRoot, true)
			ZProj.UGUIHelper.RebuildLayout(skillItem.rectRoot)

			skillItem.rectRoot.pivot = self.viewParam.pivot
			skillItem.rectRoot.anchorMin = self.viewParam.anchorMinAndMax
			skillItem.rectRoot.anchorMax = self.viewParam.anchorMinAndMax

			recthelper.setAnchor(skillItem.rectRoot, initAnchorX, initAnchorY - preHeight)

			preHeight = preHeight + recthelper.getHeight(skillItem.rectRoot)
		else
			gohelper.setActive(skillItem.goRoot, false)
		end
	end
end

function FightDeviceCardTipView:getInitPos()
	local anchorX, anchorY = recthelper.screenPosToAnchorPos2(self.viewParam.screenPos, self.viewRect)
	local anchorMinAndMax = self.viewParam.anchorMinAndMax

	if anchorMinAndMax == FightDeviceCardTipController.Pivot.TopLeft then
		anchorX = anchorX + self.viewWidth * 0.5
		anchorY = anchorY - self.viewHeight * 0.5
	elseif anchorMinAndMax == FightDeviceCardTipController.Pivot.TopCenter then
		anchorY = anchorY - self.viewHeight * 0.5
	elseif anchorMinAndMax == FightDeviceCardTipController.Pivot.TopRight then
		anchorX = anchorX - self.viewWidth * 0.5
		anchorY = anchorY - self.viewHeight * 0.5
	elseif anchorMinAndMax == FightDeviceCardTipController.Pivot.CenterLeft then
		anchorX = anchorX + self.viewWidth * 0.5
	elseif anchorMinAndMax == FightDeviceCardTipController.Pivot.Center then
		-- block empty
	elseif anchorMinAndMax == FightDeviceCardTipController.Pivot.CenterRight then
		anchorX = anchorX - self.viewWidth * 0.5
	elseif anchorMinAndMax == FightDeviceCardTipController.Pivot.BottomLeft then
		anchorX = anchorX + self.viewWidth * 0.5
		anchorY = anchorY + self.viewHeight * 0.5
	elseif anchorMinAndMax == FightDeviceCardTipController.Pivot.BottomCenter then
		anchorY = anchorY + self.viewHeight * 0.5
	elseif anchorMinAndMax == FightDeviceCardTipController.Pivot.BottomRight then
		anchorX = anchorX - self.viewWidth * 0.5
		anchorY = anchorY + self.viewHeight * 0.5
	end

	anchorX = anchorX + self.viewParam.offsetPosX
	anchorY = anchorY + self.viewParam.offsetPosY

	return anchorX, anchorY
end

function FightDeviceCardTipView:checkIgnoreClick()
	self.blockGraphic.raycastTarget = not self.viewParam.ignoreClick
end

function FightDeviceCardTipView.refreshContent(deviceSkillInfo, entityId, txtTitle, txtDesc, txtCost, txtAddExPoint, imageEnergyIcon)
	local skillId = deviceSkillInfo and deviceSkillInfo.skillId
	local skillCo = skillId and lua_skill.configDict[skillId]

	if not skillCo then
		return
	end

	local desc = FightConfig.instance:getEntitySkillDesc(entityId, skillCo)

	desc = SkillHelper.buildDesc(desc)
	txtTitle.text = skillCo.name
	txtDesc.text = desc

	if skillCo.isBigSkill == 1 then
		gohelper.setActive(imageEnergyIcon.gameObject, false)
		gohelper.setActive(txtCost.gameObject, false)

		local entityMo = FightDataHelper.entityMgr:getById(entityId)

		txtAddExPoint.text = "-" .. (entityMo and entityMo:getUniqueSkillPoint() or 0)
	else
		gohelper.setActive(imageEnergyIcon.gameObject, true)
		gohelper.setActive(txtCost.gameObject, true)

		txtCost.text = "-" .. deviceSkillInfo.costValue
		txtAddExPoint.text = "+" .. FightDeviceHelper.getSkillIdAddDeviceExPoint(skillId)

		local url = FightDeviceHelper.getCareerImage(deviceSkillInfo.costType)

		UISpriteSetMgr.instance:setFightSprite(imageEnergyIcon, url, true)
	end
end

function FightDeviceCardTipView:onDestroyView()
	if self.click then
		self.click:RemoveClickListener()

		self.click = nil
	end
end

return FightDeviceCardTipView
