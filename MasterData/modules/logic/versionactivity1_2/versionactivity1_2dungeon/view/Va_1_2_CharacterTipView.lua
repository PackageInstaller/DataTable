-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/Va_1_2_CharacterTipView.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.Va_1_2_CharacterTipView", package.seeall)

local Va_1_2_CharacterTipView = class("Va_1_2_CharacterTipView", CharacterTipView)

function Va_1_2_CharacterTipView:onInitView()
	self._goattributetip = gohelper.findChild(self.viewGO, "#go_attributetip")
	self._btnbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_attributetip/scrollview/viewport/#btn_bg")
	self._goattributecontent = gohelper.findChild(self.viewGO, "#go_attributetip/scrollview/viewport/content")
	self._godetailcontent = gohelper.findChild(self.viewGO, "#go_attributetip/#go_detailContent")
	self._goattributecontentitem = gohelper.findChild(self.viewGO, "#go_attributetip/#go_detailContent/detailscroll/Viewport/#go_attributeContent/#go_attributeItem")
	self._gopassiveskilltip = gohelper.findChild(self.viewGO, "#go_passiveskilltip")
	self._goeffectdesc = gohelper.findChild(self.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc")
	self._goeffectdescitem = gohelper.findChild(self.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc/#go_effectdescitem")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#go_passiveskilltip/mask/root/scrollview")
	self._gomask1 = gohelper.findChild(self.viewGO, "#go_passiveskilltip/mask/root/scrollview/#go_mask1")
	self._simageshadow = gohelper.findChildSingleImage(self.viewGO, "#go_passiveskilltip/mask/root/scrollview/#simage_shadow")
	self._btnclosepassivetip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_passiveskilltip/#btn_closepassivetip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Va_1_2_CharacterTipView:addEvents()
	self._btnbg:AddClickListener(self._btnbgOnClick, self)
	self._scrollview:AddOnValueChanged(self._onDragCallHandler, self)
	self._btnclosepassivetip:AddClickListener(self._btnclosepassivetipOnClick, self)
end

function Va_1_2_CharacterTipView:removeEvents()
	self._btnbg:RemoveClickListener()
	self._scrollview:RemoveOnValueChanged()
	self._btnclosepassivetip:RemoveClickListener()
end

function Va_1_2_CharacterTipView:refreshBaseAttrItem(equips, showAttributeOption)
	local baseAttrDict = self:getBaseAttrValueList(showAttributeOption)
	local equipAddValues = self:getEquipAddBaseValues(equips, baseAttrDict)
	local talentAddValues = self:getTalentValues(showAttributeOption)
	local upDic = VersionActivity1_2DungeonModel.instance:getAttrUpDic()

	for i, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
		local img_up = gohelper.findChild(self._attnormalitems[i].value.gameObject, "img_up")

		gohelper.setActive(img_up, upDic[attrId])

		local co = HeroConfig.instance:getHeroAttributeCO(attrId)
		local addValue = equipAddValues[attrId] + ((talentAddValues[attrId] or nil) and (talentAddValues[attrId].value or 0)) + (upDic[attrId] or 0)

		self._attnormalitems[i].value.text = baseAttrDict[attrId]
		self._attnormalitems[i].addValue.text = addValue == 0 and "" or "+" .. addValue
		self._attnormalitems[i].name.text = co.name

		CharacterController.instance:SetAttriIcon(self._attnormalitems[i].icon, attrId, GameUtil.parseColor("#323c34"))

		if co.isShowTips == 1 then
			local param = {
				attributeId = co.id,
				icon = attrId,
				go = self._attnormalitems[i].go
			}
			local click = gohelper.getClick(self._attnormalitems[i].detail)

			click:AddClickListener(self.showDetail, self, param)
			table.insert(self._detailClickItems, click)
			gohelper.setActive(self._attnormalitems[i].detail, true)
		else
			gohelper.setActive(self._attnormalitems[i].detail, false)
		end

		if self._attnormalitems[i].withDesc then
			local technicAddCri, technicAddCriDmg = self:calculateTechnic(baseAttrDict[CharacterEnum.AttrId.Technic], showAttributeOption)
			local technicDesc = CommonConfig.instance:getConstStr(ConstEnum.CharacterTechnicDesc)
			local techTag = {
				technicAddCri,
				technicAddCriDmg
			}

			technicDesc = GameUtil.getSubPlaceholderLuaLang(technicDesc, techTag)
			self._attnormalitems[i].desc.text = technicDesc
		end
	end
end

function Va_1_2_CharacterTipView:refreshUpAttrItem(equips, showAttributeOption)
	local baseAttrDict = self:getBaseAttrValueList(showAttributeOption)
	local upAttrValueDict = self:_getTotalUpAttributes(showAttributeOption)
	local equipAddValues = self:getEquipBreakAddAttrValues(equips)
	local talentAddValues = self:getTalentValues(showAttributeOption)
	local technicAddCri, technicAddCriDmg = self:calculateTechnic(baseAttrDict[CharacterEnum.AttrId.Technic], showAttributeOption)
	local upDic = VersionActivity1_2DungeonModel.instance:getAttrUpDic()

	for i, attrId in ipairs(CharacterEnum.UpAttrIdList) do
		local img_up = gohelper.findChild(self._attrupperitems[i].value.gameObject, "img_up")

		gohelper.setActive(img_up, upDic[attrId])
		gohelper.setActive(self._attrupperitems[i].go, true)

		local attrCo = HeroConfig.instance:getHeroAttributeCO(attrId)
		local addValue = equipAddValues[attrId] + ((talentAddValues[attrId] or nil) and (talentAddValues[attrId].value or 0)) + (upDic[attrId] or 0) / 10
		local realPercent = (upAttrValueDict[attrId] or 0) / 10

		if attrId == CharacterEnum.AttrId.Cri then
			realPercent = realPercent + technicAddCri
		end

		if attrId == CharacterEnum.AttrId.CriDmg then
			realPercent = realPercent + technicAddCriDmg
		end

		realPercent = tostring(GameUtil.noMoreThanOneDecimalPlace(realPercent)) .. "%"
		self._attrupperitems[i].value.text = realPercent
		self._attrupperitems[i].addValue.text = addValue == 0 and "" or "+" .. tostring(GameUtil.noMoreThanOneDecimalPlace(addValue)) .. "%"
		self._attrupperitems[i].name.text = attrCo.name

		CharacterController.instance:SetAttriIcon(self._attrupperitems[i].icon, attrId, CharacterTipView.AttrColor)

		if attrCo.isShowTips == 1 then
			local param = {
				attributeId = attrCo.id,
				icon = attrId,
				go = self._attrupperitems[i].go
			}
			local click = gohelper.getClick(self._attrupperitems[i].detail)

			click:AddClickListener(self.showDetail, self, param)
			table.insert(self._detailClickItems, click)
			gohelper.setActive(self._attrupperitems[i].detail, true)
		else
			gohelper.setActive(self._attrupperitems[i].detail, false)
		end
	end
end

return Va_1_2_CharacterTipView
