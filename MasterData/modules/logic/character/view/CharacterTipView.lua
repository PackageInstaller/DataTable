-- chunkname: @modules/logic/character/view/CharacterTipView.lua

module("modules.logic.character.view.CharacterTipView", package.seeall)

local CharacterTipView = class("CharacterTipView", BaseView)

function CharacterTipView:onInitView()
	self._goattributetip = gohelper.findChild(self.viewGO, "#go_attributetip")
	self._goattrassassinbg = gohelper.findChild(self.viewGO, "#go_attributetip/skillbgassassin")
	self._btnbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_attributetip/scrollview/viewport/#btn_bg")
	self._goattributecontent = gohelper.findChild(self.viewGO, "#go_attributetip/scrollview/viewport/content")
	self._godetailcontent = gohelper.findChild(self.viewGO, "#go_attributetip/#go_detailContent")
	self._goattributecontentitem = gohelper.findChild(self.viewGO, "#go_attributetip/#go_detailContent/detailscroll/Viewport/#go_attributeContent/#go_attributeItem")
	self._gopassiveskilltip = gohelper.findChild(self.viewGO, "#go_passiveskilltip")
	self._goeffectdesc = gohelper.findChild(self.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc")
	self._goeffectdescitem = gohelper.findChild(self.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc/#go_effectdescitem")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#go_passiveskilltip/mask/root/scrollview")
	self._gopassiveassassinbg = gohelper.findChild(self.viewGO, "#go_passiveskilltip/mask/root/scrollview/skillbgassassin")
	self._gomask1 = gohelper.findChild(self.viewGO, "#go_passiveskilltip/mask/root/scrollview/#go_mask1")
	self._simageshadow = gohelper.findChildSingleImage(self.viewGO, "#go_passiveskilltip/mask/root/scrollview/#simage_shadow")
	self._btnclosepassivetip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_passiveskilltip/#btn_closepassivetip")
	self._goBuffContainer = gohelper.findChild(self.viewGO, "#go_buffContainer")
	self._btnclosebuff = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buffContainer/buff_bg")
	self._goBuffItem = gohelper.findChild(self.viewGO, "#go_buffContainer/#go_buffitem")
	self._txtBuffName = gohelper.findChildText(self.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name")
	self._goBuffTag = gohelper.findChild(self.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag")
	self._txtBuffTagName = gohelper.findChildText(self.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag/bg/txt_tagname")
	self._txtBuffDesc = gohelper.findChildText(self.viewGO, "#go_buffContainer/#go_buffitem/txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterTipView:addEvents()
	self._btnbg:AddClickListener(self._btnbgOnClick, self)
	self._btnclosebuff:AddClickListener(self._btnclosebuffOnClick, self)
	self._scrollview:AddOnValueChanged(self._onDragCallHandler, self)
	self._btnclosepassivetip:AddClickListener(self._btnclosepassivetipOnClick, self)
end

function CharacterTipView:removeEvents()
	self._btnbg:RemoveClickListener()
	self._btnclosebuff:RemoveClickListener()
	self._scrollview:RemoveOnValueChanged()
	self._btnclosepassivetip:RemoveClickListener()
end

CharacterTipView.DetailOffset = 25
CharacterTipView.DetailBottomPos = -133.7
CharacterTipView.DetailClickMinPos = -148
CharacterTipView.AttrColor = GameUtil.parseColor("#323c34")

function CharacterTipView:_btnbgOnClick()
	if not self._isOpenAttrDesc then
		return
	end

	self._isOpenAttrDesc = false

	gohelper.setActive(self._godetailcontent, false)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_role_description)
end

function CharacterTipView:_btnclosebuffOnClick()
	gohelper.setActive(self._goBuffContainer, false)
end

function CharacterTipView:_btnclosepassivetipOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function CharacterTipView:_onDragCallHandler()
	gohelper.setActive(self._gomask1, self._couldScroll and gohelper.getRemindFourNumberFloat(self._scrollview.verticalNormalizedPosition) > 0)

	self._passiveskilltipmask.enabled = self._couldScroll and gohelper.getRemindFourNumberFloat(self._scrollview.verticalNormalizedPosition) < 1
end

function CharacterTipView:_editableInitView()
	self._isOpenAttrDesc = false

	gohelper.setActive(self._goBuffContainer, false)

	self.gocontent = gohelper.findChild(self._goattributetip, "scrollview/viewport/content")
	self.gotitleitem = gohelper.findChild(self._goattributetip, "scrollview/viewport/content/titleitem")
	self.godescitem = gohelper.findChild(self._goattributetip, "scrollview/viewport/content/descitem")
	self.goattrnormalitem = gohelper.findChild(self._goattributetip, "scrollview/viewport/content/attrnormalitem")
	self.goattrnormalwithdescitem = gohelper.findChild(self._goattributetip, "scrollview/viewport/content/attrnormalwithdescitem")
	self.goattrupperitem = gohelper.findChild(self._goattributetip, "scrollview/viewport/content/attrupperitem")
	self._txtDetailItemName = gohelper.findChildText(self._goattributecontentitem, "name")
	self._txtDetailItemIcon = gohelper.findChildImage(self._goattributecontentitem, "name/icon")
	self._txtDetailItemDesc = gohelper.findChildText(self._goattributecontentitem, "desc")
	self._passiveskilltipcontent = gohelper.findChild(self._gopassiveskilltip, "mask/root/scrollview/viewport/content")
	self._passiveskilltipmask = gohelper.findChild(self._gopassiveskilltip, "mask"):GetComponent(typeof(UnityEngine.UI.RectMask2D))

	gohelper.setActive(self.gotitleitem, false)
	gohelper.setActive(self.godescitem, false)
	gohelper.setActive(self.goattrnormalitem, false)
	gohelper.setActive(self.goattrnormalwithdescitem, false)
	gohelper.setActive(self.goattrupperitem, false)

	self.goTotalTitle = gohelper.clone(self.gotitleitem, self.gocontent, "totaltitle")

	gohelper.setActive(self.goTotalTitle, false)
	self:_setTitleText(self.goTotalTitle, luaLang("character_tip_total_attribute"), "STATS")

	self.goDescTitle = gohelper.clone(self.godescitem, self.gocontent, "descitem")

	gohelper.setActive(self.goDescTitle, false)

	self._attnormalitems = {}

	for i = 1, 4 do
		local o = self:getUserDataTb_()

		o.go = gohelper.clone(self.goattrnormalitem, self.gocontent, "attrnormal" .. 1)

		gohelper.setActive(o.go, true)

		o.value = gohelper.findChildText(o.go, "value")
		o.addValue = gohelper.findChildText(o.go, "addvalue")
		o.name = gohelper.findChildText(o.go, "name")
		o.icon = gohelper.findChildImage(o.go, "icon")
		o.rate = gohelper.findChildImage(o.go, "rate")
		o.detail = gohelper.findChild(o.go, "btndetail")
		o.withDesc = false
		self._attnormalitems[i] = o
	end

	local o = self:getUserDataTb_()

	o.go = gohelper.clone(self.goattrnormalwithdescitem, self.gocontent, "attrnormal" .. #self._attnormalitems + 1)

	gohelper.setActive(o.go, true)

	o.value = gohelper.findChildText(o.go, "attr/value")
	o.addValue = gohelper.findChildText(o.go, "attr/addvalue")
	o.name = gohelper.findChildText(o.go, "attr/name")
	o.icon = gohelper.findChildImage(o.go, "attr/icon")
	o.detail = gohelper.findChild(o.go, "attr/btndetail")
	o.desc = gohelper.findChildText(o.go, "desc/#txt_desc")
	o.withDesc = true
	self._attnormalitems[#self._attnormalitems + 1] = o
	self._attrupperitems = {}

	for i = 1, 12 do
		self:_getAttrUpperItem(i)
	end

	self._passiveskillitems = {}

	for i = 1, 3 do
		self._passiveskillitems[i] = self:_findPassiveskillitems(i)
	end

	self._passiveskillitems[0] = self:_findPassiveskillitems(4)
	self._txtpassivename = gohelper.findChildText(self.viewGO, "#go_passiveskilltip/name/bg/#txt_passivename")
	self._detailClickItems = {}
	self._detailDescTab = self:getUserDataTb_()
	self._skillEffectDescItems = self:getUserDataTb_()

	self._simageshadow:LoadImage(ResUrl.getCharacterIcon("bg_shade"))
end

function CharacterTipView:_findPassiveskillitems(index)
	local o = self:getUserDataTb_()

	o.go = gohelper.findChild(self._gopassiveskilltip, "mask/root/scrollview/viewport/content/talentstar" .. index)
	o.desc = gohelper.findChildTextMesh(o.go, "desctxt")
	o.hyperLinkClick = SkillHelper.addHyperLinkClick(o.desc, self._onHyperLinkClick, self)
	o.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(o.desc.gameObject, FixTmpBreakLine)
	o.on = gohelper.findChild(o.go, "#go_passiveskills/passiveskill/on")
	o.unlocktxt = gohelper.findChildText(o.go, "#go_passiveskills/passiveskill/unlocktxt")
	o.canvasgroup = gohelper.onceAddComponent(o.go, typeof(UnityEngine.CanvasGroup))
	o.connectline = gohelper.findChild(o.go, "line")

	return o
end

function CharacterTipView:_getAttrUpperItem(index)
	local o = self._attrupperitems[index]

	if not o then
		o = self:getUserDataTb_()
		o.go = gohelper.clone(self.goattrupperitem, self.gocontent, "attrupper" .. index)

		gohelper.setActive(o.go, true)

		o.value = gohelper.findChildText(o.go, "value")
		o.addValue = gohelper.findChildText(o.go, "addvalue")
		o.name = gohelper.findChildText(o.go, "name")
		o.icon = gohelper.findChildImage(o.go, "icon")
		o.detail = gohelper.findChild(o.go, "btndetail")
		self._attrupperitems[index] = o
	end

	return o
end

function CharacterTipView:_setTitleText(go, cn, en)
	local textCn = gohelper.findChildText(go, "attcn")

	if textCn then
		textCn.text = cn
	end

	local textEn = gohelper.findChildText(go, "atten")

	if textEn then
		textEn.text = en
	end
end

function CharacterTipView:onUpdateParam()
	return
end

function CharacterTipView:onDestroyView()
	self._simageshadow:UnLoadImage()
end

function CharacterTipView:onOpen()
	gohelper.setActive(self._godetailcontent, false)

	local info = self.viewParam

	self.heroId = self.viewParam.heroid
	self._level = self.viewParam.level
	self._rank = self.viewParam.rank
	self._passiveSkillLevel = self.viewParam.passiveSkillLevel
	self._setEquipInfo = self.viewParam.setEquipInfo
	self._talentCubeInfos = self.viewParam.talentCubeInfos
	self._balanceHelper = self.viewParam.balanceHelper or HeroGroupBalanceHelper
	self._hideAttrDetail = self.viewParam.hideAttrDetail

	gohelper.setActive(self.goDescTitle, true)
	gohelper.setActive(self.goTotalTitle, true)
	gohelper.setActive(self._goattributetip, info.tag == "attribute")
	gohelper.setActive(self._gopassiveskilltip, info.tag == "passiveskill")
	gohelper.setActive(self._goattrassassinbg, info.showAssassinBg)
	gohelper.setActive(self._gopassiveassassinbg, info.showAssassinBg)

	info.showAttributeOption = info.showAttributeOption or CharacterEnum.showAttributeOption.ShowCurrent

	if info.tag == "attribute" then
		self:_setAttribute(info.equips, info.showAttributeOption, info.anchorParams, info.tipPos)
	elseif info.tag == "passiveskill" then
		self:_setPassiveSkill(info.heroid, info.showAttributeOption, info.anchorParams, info.tipPos)
	end
end

function CharacterTipView:_setAttribute(equips, showAttributeOption, anchorParams, tipPos)
	for i = 7, 11 do
		gohelper.setActive(self._attrupperitems[i].go, false)
	end

	self:refreshBaseAttrItem(equips, showAttributeOption)
	self:refreshUpAttrItem(equips, showAttributeOption)
	self:_setTipPos(self._goattributetip.transform, tipPos, anchorParams)
end

function CharacterTipView:refreshBaseAttrItem(equips, showAttributeOption)
	local baseAttrDict = self:getBaseAttrValueList(showAttributeOption)
	local equipAddValues = self:getEquipAddBaseValues(equips, baseAttrDict)
	local talentAddValues = self:getTalentValues(showAttributeOption)

	if not self.viewParam.heroMo then
		local heroMo = HeroModel.instance:getByHeroId(self.heroId)
		local destinyStoneMo = heroMo and heroMo.destinyStoneMo
		local destinyStoneValues = destinyStoneMo and destinyStoneMo:getAddAttrValues()

		for i, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
			local co = HeroConfig.instance:getHeroAttributeCO(attrId)
			local destinyStoneAddValue = destinyStoneMo and destinyStoneMo:getAddValueByAttrId(destinyStoneValues, attrId, heroMo) or 0

			if talentAddValues[attrId] then
				local addValue = equipAddValues[attrId] + (talentAddValues[attrId].value or 0) + destinyStoneAddValue

				self._attnormalitems[i].value.text = baseAttrDict[attrId]
				self._attnormalitems[i].addValue.text = addValue == 0 and "" or "+" .. addValue
				self._attnormalitems[i].name.text = co.name

				CharacterController.instance:SetAttriIcon(self._attnormalitems[i].icon, attrId, GameUtil.parseColor("#323c34"))

				if co.isShowTips == 1 and not self._hideAttrDetail then
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

					technicDesc = string.gsub(technicDesc, "▩1%%s", technicAddCri)
					technicDesc = string.gsub(technicDesc, "▩2%%s", technicAddCriDmg)
					self._attnormalitems[i].desc.text = technicDesc
				end
			end
		end
	end
end

function CharacterTipView:refreshUpAttrItem(equips, showAttributeOption)
	local baseAttrDict = self:getBaseAttrValueList(showAttributeOption)
	local upAttrValueDict = self:_getTotalUpAttributes(showAttributeOption)
	local equipAddValues = self:getEquipBreakAddAttrValues(equips)
	local talentAddValues = self:getTalentValues(showAttributeOption)

	if not self.viewParam.heroMo then
		local heroMo = HeroModel.instance:getByHeroId(self.heroId)
		local destinyStoneMo = heroMo and heroMo.destinyStoneMo
		local destinyStoneValues = destinyStoneMo and destinyStoneMo:getAddAttrValues()
		local technicAddCri, technicAddCriDmg = self:calculateTechnic(baseAttrDict[CharacterEnum.AttrId.Technic], showAttributeOption)
		local index = 1

		for i, attrId in ipairs(CharacterEnum.UpAttrIdList) do
			gohelper.setActive(self._attrupperitems[i].go, true)

			local attrCo = HeroConfig.instance:getHeroAttributeCO(attrId)
			local destinyStoneAddValue = destinyStoneMo and destinyStoneMo:getAddValueByAttrId(destinyStoneValues, attrId, heroMo) or 0

			if talentAddValues[attrId] then
				local addValue = equipAddValues[attrId] + (talentAddValues[attrId].value or 0) + destinyStoneAddValue
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

				if attrCo.isShowTips == 1 and not self._hideAttrDetail then
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

				index = index + 1
			end
		end

		for i, attrId in ipairs(CharacterDestinyEnum.DestinyUpSpecialAttr) do
			local destinyStoneAddValue = destinyStoneMo and destinyStoneMo:getAddValueByAttrId(destinyStoneValues, attrId, heroMo) or 0

			if destinyStoneAddValue ~= 0 then
				local item = self:_getAttrUpperItem(index)

				gohelper.setActive(item.go, true)

				local attrCo = HeroConfig.instance:getHeroAttributeCO(attrId)

				item.value.text = attrCo.showType == 1 and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("percent"), 0) or 0

				local addValue = "+" .. tostring(GameUtil.noMoreThanOneDecimalPlace(destinyStoneAddValue)) .. "%"

				item.addValue.text = destinyStoneAddValue == 0 and "" or addValue
				item.name.text = attrCo.name

				CharacterController.instance:SetAttriIcon(item.icon, attrId, CharacterTipView.AttrColor)

				if attrCo.isShowTips == 1 then
					local param = {
						attributeId = attrCo.id,
						icon = attrId,
						go = item.go
					}
					local click = gohelper.getClick(item.detail)

					click:AddClickListener(self.showDetail, self, param)
					table.insert(self._detailClickItems, click)
					gohelper.setActive(item.detail, true)
				else
					gohelper.setActive(item.detail, false)
				end

				index = index + 1
			end
		end
	end
end

function CharacterTipView:getBaseAttrValueList(showAttributeOption)
	local result = {}

	if showAttributeOption == CharacterEnum.showAttributeOption.ShowMax then
		result = self:_getMaxNormalAtrributes()
	elseif showAttributeOption == CharacterEnum.showAttributeOption.ShowMin then
		result = self:_getMinNormalAttribute()
	elseif not self.viewParam.heroMo then
		local heroMo = HeroModel.instance:getByHeroId(self.heroId)
		local level, rank = self._level, self._rank

		if self.viewParam.isBalance then
			level = self._balanceHelper.getHeroBalanceLv(heroMo.heroId)
			_, rank = HeroConfig.instance:getShowLevel(level)
		end

		result = heroMo:getHeroBaseAttrDict(level, rank)
	end

	return result
end

function CharacterTipView:getEquipAddBaseValues(equips, baseAttrDict)
	local equipAddValues = {}
	local equipBreakAddAttrDict = {}

	for _, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
		equipAddValues[attrId] = 0
		equipBreakAddAttrDict[attrId] = 0
	end

	local equipLv

	if self.viewParam.isBalance then
		_, _, equipLv = self._balanceHelper.getBalanceLv()
	end

	if not self.viewParam.heroMo then
		local heroMo = HeroModel.instance:getByHeroId(self.heroId)

		if equips then
			local trialEquipMo = self.viewParam.trialEquipMo

			if trialEquipMo then
				heroMo:_calcEquipAttr(trialEquipMo, equipAddValues, equipBreakAddAttrDict)
			end

			for i = 1, #equips do
				local equipMo = EquipModel.instance:getEquip(equips[i])

				equipMo = equipMo and self:_modifyEquipInfo(equipMo)

				heroMo:_calcEquipAttr(equipMo, equipAddValues, equipBreakAddAttrDict, equipLv)

				local otherEquipMo

				if trialEquipMo then
					do
						local otherEquipId = EquipModel.instance:getOtherTwinssychubeEquipId(trialEquipMo.equipId)

						if otherEquipId then
							otherEquipMo = EquipMO.New()

							local co = {
								equipId = otherEquipId,
								equipLv = trialEquipMo.level,
								equipRefine = trialEquipMo.refineLv
							}

							otherEquipMo:initByTrialCO(co)
						end
					end
				end

				if equipMo then
					::label_19_0::

					do
						local otherEquipId = EquipModel.instance:getOtherTwinssychubeEquipId(equipMo.equipId)

						otherEquipMo = EquipModel.instance:getTwinssychubeEquipMo(otherEquipId)
					end

					if otherEquipMo then
						heroMo:_calcEquipAttr(otherEquipMo, equipAddValues, equipBreakAddAttrDict, equipLv)
					end
				end
			end
		end

		for _, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
			equipAddValues[attrId] = equipAddValues[attrId] + math.floor(equipBreakAddAttrDict[attrId] / 1000 * baseAttrDict[attrId])
		end

		return equipAddValues
	end
end

function CharacterTipView:_modifyEquipInfo(equipMO)
	if self._setEquipInfo then
		local callback = self._setEquipInfo[1]
		local callbackTarget = self._setEquipInfo[2]
		local param = self._setEquipInfo[3]

		if param and param.isCachot then
			return callback(callbackTarget, {
				seatLevel = param.seatLevel,
				equipMO = equipMO
			})
		end
	end

	return equipMO
end

function CharacterTipView:getTalentValues(showAttributeOption)
	local result = {}

	if showAttributeOption == CharacterEnum.showAttributeOption.ShowCurrent then
		if not self.viewParam.heroMo then
			local heroMo = HeroModel.instance:getByHeroId(self.heroId)

			if self.viewParam.isBalance then
				local balanceLv, rank, fixTalent, talentCubeInfos = self._balanceHelper.getHeroBalanceInfo(heroMo.heroId)

				result = heroMo:getTalentGain(balanceLv, rank, nil, talentCubeInfos)
			else
				result = heroMo:getTalentGain(self._level or heroMo.level, self._rank, nil, self._talentCubeInfos)
			end

			result = HeroConfig.instance:talentGainTab2IDTab(result)

			for attrId, value in pairs(result) do
				local config = HeroConfig.instance:getHeroAttributeCO(attrId)

				result[attrId].value = config.type ~= 1 and result[attrId].value / 10 or math.floor(result[attrId].value)
			end
		end
	end

	return result
end

function CharacterTipView:getDestinyStoneAddValues(showAttributeOption)
	if not self.viewParam.heroMo then
		local heroMo = HeroModel.instance:getByHeroId(self.heroId)

		if heroMo then
			local destinyStoneMo = heroMo.destinyStoneMo

			if destinyStoneMo then
				return destinyStoneMo:getAddAttrValues()
			end
		end
	end
end

function CharacterTipView:getEquipBreakAddAttrValues(equips)
	local upAddValues = {}

	for _, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
		upAddValues[attrId] = 0
	end

	for _, attrId in ipairs(CharacterEnum.UpAttrIdList) do
		upAddValues[attrId] = 0
	end

	if equips and self.viewParam.heroMo and self.viewParam.trialEquipMo then
		local equipMo = self.viewParam.trialEquipMo
		local attrId, value = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(equipMo.config, equipMo.breakLv)

		if attrId then
			upAddValues[attrId] = upAddValues[attrId] + value
		end
	end

	local trialEquipMo = self.viewParam.trialEquipMo
	local otherEquipMo

	if equips and #equips > 0 then
		for _, equipUid in ipairs(equips) do
			local equipMo = EquipModel.instance:getEquip(equipUid)

			if equipMo then
				equipMo = self:_modifyEquipInfo(equipMo)

				if trialEquipMo then
					do
						local otherEquipId = EquipModel.instance:getOtherTwinssychubeEquipId(trialEquipMo.equipId)

						if otherEquipId then
							otherEquipMo = EquipMO.New()

							local co = {
								equipId = otherEquipId,
								equipLv = trialEquipMo.level,
								equipRefine = trialEquipMo.refineLv
							}

							otherEquipMo:initByTrialCO(co)
						end
					end
				end

				if equipMo then
					::label_23_0::

					do
						local otherEquipId = EquipModel.instance:getOtherTwinssychubeEquipId(equipMo.equipId)

						otherEquipMo = EquipModel.instance:getTwinssychubeEquipMo(otherEquipId)
					end

					local attrId, value = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(equipMo.config, equipMo.breakLv)

					if attrId then
						upAddValues[attrId] = upAddValues[attrId] + value
					end

					if otherEquipMo then
						local _attrId, otherEquipValue = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(otherEquipMo.config, otherEquipMo.breakLv)

						upAddValues[_attrId] = upAddValues[_attrId] + otherEquipValue
					end
				end
			end
		end
	end

	for attrId, value in pairs(upAddValues) do
		upAddValues[attrId] = value / 10
	end

	return upAddValues
end

function CharacterTipView:calculateTechnic(technicValue, showAttributeOption)
	local technicAddCri, technicAddCriDmg, level

	if showAttributeOption == CharacterEnum.showAttributeOption.ShowMax then
		level = CharacterModel.instance:getMaxLevel(self.viewParam.heroid)
	elseif showAttributeOption == CharacterEnum.showAttributeOption.ShowMin then
		level = 1
	end

	if not self.viewParam.heroMo then
		do
			local heroMo = HeroModel.instance:getByHeroId(self.viewParam.heroid)

			level = self._level or heroMo.level

			if self.viewParam.isBalance then
				level = self._balanceHelper.getHeroBalanceLv(heroMo.heroId)
			end
		end

		local critChanceNum = tonumber(lua_fight_const.configDict[11].value)
		local critDmgChanceNum = tonumber(lua_fight_const.configDict[12].value)
		local fitConstNum = tonumber(lua_fight_const.configDict[13].value)
		local targetLevelNum = tonumber(lua_fight_const.configDict[14].value)
		local tempVal = fitConstNum + level * targetLevelNum * 10

		tempVal = tempVal * 10

		return string.format("%.1f", technicValue * critChanceNum / tempVal), (string.format("%.1f", technicValue * critDmgChanceNum / tempVal))
	end
end

function CharacterTipView:_getTotalUpAttributes(showAttributeOption)
	local attrDict

	if showAttributeOption == CharacterEnum.showAttributeOption.ShowMax then
		do
			local maxRank = CharacterModel.instance:getMaxRank(self.viewParam.heroid)
			local maxLevel = CharacterModel.instance:getrankEffects(self.viewParam.heroid, maxRank)[1]

			attrDict = SkillConfig.instance:getherolevelCO(self.viewParam.heroid, maxLevel)
		end
	elseif showAttributeOption == CharacterEnum.showAttributeOption.ShowMin then
		attrDict = SkillConfig.instance:getherolevelCO(self.viewParam.heroid, 1)
	end

	if not self.viewParam.heroMo then
		do
			local heroMO = HeroModel.instance:getByHeroId(self.viewParam.heroid)

			attrDict = heroMO:getHeroLevelConfig()
		end

		local result = {}

		for _, attrId in ipairs(CharacterEnum.UpAttrIdList) do
			result[attrId] = attrDict[CharacterEnum.AttrIdToAttrName[attrId]] or 0
		end

		return result
	end
end

function CharacterTipView:_getMaxNormalAtrributes()
	local maxRank = CharacterModel.instance:getMaxRank(self.viewParam.heroid)
	local maxlv = CharacterModel.instance:getMaxLevel(self.viewParam.heroid)
	local lvCo = SkillConfig.instance:getherolevelCO(self.viewParam.heroid, maxlv)
	local rankValues = SkillConfig.instance:getHeroRankAttribute(self.viewParam.heroid, maxRank)

	return {
		[CharacterEnum.AttrId.Attack] = lvCo.atk + rankValues.atk,
		[CharacterEnum.AttrId.Hp] = lvCo.hp + rankValues.hp,
		[CharacterEnum.AttrId.Defense] = lvCo.def + rankValues.def,
		[CharacterEnum.AttrId.Mdefense] = lvCo.mdef + rankValues.mdef,
		[CharacterEnum.AttrId.Technic] = lvCo.technic + rankValues.technic
	}
end

function CharacterTipView:_getMinNormalAttribute()
	local lvCo = SkillConfig.instance:getherolevelCO(self.viewParam.heroid, 1)

	return {
		[CharacterEnum.AttrId.Attack] = lvCo.atk,
		[CharacterEnum.AttrId.Hp] = lvCo.hp,
		[CharacterEnum.AttrId.Defense] = lvCo.def,
		[CharacterEnum.AttrId.Mdefense] = lvCo.mdef,
		[CharacterEnum.AttrId.Technic] = lvCo.technic
	}
end

function CharacterTipView:_countRate(baseCo, attr, max)
	for i = 1, max - 1 do
		if baseCo < attr[i + 1] then
			return i
		end
	end

	return max
end

function CharacterTipView:_setPassiveSkill(heroid, showAttributeOption, anchorParams, tipPos)
	self._matchSkillNames = {}

	local exSkillLevel

	if showAttributeOption == CharacterEnum.showAttributeOption.ShowMax then
		exSkillLevel = CharacterEnum.MaxSkillExLevel
	elseif showAttributeOption == CharacterEnum.showAttributeOption.ShowMin then
		exSkillLevel = 0
	end

	if not self.viewParam.heroMo then
		do
			local heroMo = HeroModel.instance:getByHeroId(heroid)

			exSkillLevel = heroMo.exSkillLevel
		end

		local pskills = SkillConfig.instance:getPassiveSKillsCoByExSkillLevel(heroid, exSkillLevel)

		if self.viewParam.heroMo and self.viewParam.heroMo.trialAttrCo then
			pskills = self.viewParam.heroMo:getpassiveskillsCO()
		end

		local skillIds = self:_checkReplaceSkill(pskills, self.viewParam.heroMo)
		local firstSkill = pskills[1]
		local firstSkillId = firstSkill.skillPassive

		self._txtpassivename.text = lua_skill.configDict[firstSkillId].name

		local heroCo = HeroConfig.instance:getHeroCO(heroid)
		local txtTab = {}

		for i, skillId in pairs(skillIds) do
			local skillCo = lua_skill.configDict[skillId]

			txtTab[i] = FightConfig.instance:getSkillEffectDesc(heroCo.name, skillCo)
		end

		local matchTxtTab = HeroSkillModel.instance:getSkillEffectTagIdsFormDescTabRecursion(txtTab)
		local tagNameExistDict = {}
		local skillEffectDescTab = {}
		local passiveLevel = 0

		if self.viewParam.isBalance then
			local balanceLv = self._balanceHelper.getHeroBalanceLv(self.viewParam.heroMo.heroId)

			passiveLevel = SkillConfig.instance:getHeroExSkillLevelByLevel(self.viewParam.heroMo.heroId, math.max(self._level or self.viewParam.heroMo.level, balanceLv))
		end

		for i, skillId in pairs(skillIds) do
			if skillId then
				local unlock = true

				if i ~= 0 then
					unlock = self:_getPassiveUnlock(showAttributeOption, heroid, i, self.viewParam.heroMo)

					if self.viewParam.isBalance then
						unlock = i <= passiveLevel
					end
				end

				local skillCo = lua_skill.configDict[skillId]
				local txt = FightConfig.instance:getSkillEffectDesc(heroCo.name, skillCo)

				for _, v in ipairs(matchTxtTab[i]) do
					local effectCo = SkillConfig.instance:getSkillEffectDescCo(v)
					local name = effectCo.name
					local canShowSkillTag = HeroSkillModel.instance:canShowSkillTag(name, true)

					if canShowSkillTag and not tagNameExistDict[name] then
						tagNameExistDict[name] = true

						if effectCo.isSpecialCharacter == 1 then
							local desc = effectCo.desc

							txt = string.format("%s", txt)

							local skillEffectDesc = SkillHelper.buildDesc(desc)

							table.insert(skillEffectDescTab, {
								desc = skillEffectDesc,
								title = effectCo.name
							})
						end
					end
				end

				local desc = SkillHelper.buildDesc(txt)
				local ranknum = self:_getTargetRankByEffect(heroid, i)

				if not unlock then
					self._passiveskillitems[i].unlocktxt.text = string.format(luaLang("character_passive_get"), GameUtil.getRomanNums(ranknum))

					SLFramework.UGUI.GuiHelper.SetColor(self._passiveskillitems[i].unlocktxt, "#3A3A3A")
				else
					local unlocktxt

					self._passiveskillitems[i].unlocktxt.text = i == 0 and luaLang("character_skill_passive_0") or string.format(luaLang("character_passive_unlock"), GameUtil.getRomanNums(ranknum))

					SLFramework.UGUI.GuiHelper.SetColor(self._passiveskillitems[i].unlocktxt, "#313B33")
				end

				self._passiveskillitems[i].canvasgroup.alpha = unlock and 1 or 0.83

				gohelper.setActive(self._passiveskillitems[i].on, unlock)

				self._passiveskillitems[i].desc.text = desc

				self._passiveskillitems[i].fixTmpBreakLine:refreshTmpContent(self._passiveskillitems[i].desc)
				SLFramework.UGUI.GuiHelper.SetColor(self._passiveskillitems[i].desc, unlock and "#272525" or "#3A3A3A")
				gohelper.setActive(self._passiveskillitems[i].go, true)
				gohelper.setActive(self._passiveskillitems[i].connectline, i ~= #pskills)
			else
				gohelper.setActive(self._passiveskillitems[i].go, false)
			end
		end

		for i = #pskills + 1, #self._passiveskillitems do
			gohelper.setActive(self._passiveskillitems[i].go, false)
		end

		gohelper.setActive(self._passiveskillitems[0].go, skillIds[0] ~= nil)
		self:_showSkillEffectDesc(skillEffectDescTab)
		self:_refreshPassiveSkillScroll()
		self:_setTipPos(self._gopassiveskilltip.transform, tipPos, anchorParams)
	end
end

function CharacterTipView:_checkReplaceSkill(skillIdList, heroMo)
	local skillIds = {}

	if skillIdList then
		for i, v in pairs(skillIdList) do
			skillIds[i] = v.skillPassive
		end

		if heroMo then
			skillIds = heroMo:checkReplaceSkill(skillIds)
		end
	end

	return skillIds
end

function CharacterTipView:_setTipPos(tipTran, tipPos, anchorParams)
	if not tipTran or not self._goBuffItem then
		return
	end

	if anchorParams then
		if not anchorParams[1] then
			local targetAnchorMin = Vector2.New(0.5, 0.5)

			if anchorParams then
				if not anchorParams[2] then
					local targetAnchorMax = Vector2.New(0.5, 0.5)
					local targetTipPos = tipPos and tipPos or Vector2.New(0, 0)

					tipTran.anchorMin = targetAnchorMin
					tipTran.anchorMax = targetAnchorMax
					self._goBuffItem.transform.anchorMin = targetAnchorMin
					self._goBuffItem.transform.anchorMax = targetAnchorMax

					recthelper.setAnchor(tipTran, targetTipPos.x, targetTipPos.y)
					recthelper.setAnchorX(self._goBuffItem.transform, self.viewParam.buffTipsX or 0)
				end
			end
		end
	end
end

function CharacterTipView:_refreshPassiveSkillScroll()
	self:_setScrollMaskVisible()

	local passviewskilltipviewport = gohelper.findChild(self._gopassiveskilltip, "mask/root/scrollview/viewport")
	local psviewportVerticalGroup = gohelper.onceAddComponent(passviewskilltipviewport, gohelper.Type_VerticalLayoutGroup)
	local psviewportLayoutElement = gohelper.onceAddComponent(passviewskilltipviewport, typeof(UnityEngine.UI.LayoutElement))

	psviewportVerticalGroup.enabled = false
	psviewportLayoutElement.enabled = true
	psviewportLayoutElement.preferredHeight = recthelper.getHeight(passviewskilltipviewport.transform)
end

function CharacterTipView:_showSkillEffectDesc(skillEffectDescTab)
	gohelper.setActive(self._goeffectdesc, skillEffectDescTab and #skillEffectDescTab > 0)

	for i = 1, #skillEffectDescTab do
		local skillDesc = skillEffectDescTab[i]
		local descItem = self:_getSkillEffectDescItem(i)

		descItem.desc.text = skillDesc.desc
		descItem.title.text = SkillHelper.removeRichTag(skillDesc.title)

		descItem.fixTmpBreakLine:refreshTmpContent(descItem.desc)
		gohelper.setActive(descItem.go, true)
	end

	for i = #skillEffectDescTab + 1, #self._skillEffectDescItems do
		gohelper.setActive(self._passiveskillitems[i].go, false)
	end
end

function CharacterTipView:_getSkillEffectDescItem(index)
	local descItem = self._skillEffectDescItems[index]

	if not descItem then
		descItem = self:getUserDataTb_()
		descItem.go = gohelper.cloneInPlace(self._goeffectdescitem, "descitem" .. index)
		descItem.desc = gohelper.findChildText(descItem.go, "effectdesc")
		descItem.title = gohelper.findChildText(descItem.go, "titlebg/bg/name")
		descItem.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(descItem.desc.gameObject, FixTmpBreakLine)
		descItem.hyperLinkClick = SkillHelper.addHyperLinkClick(descItem.desc, self._onHyperLinkClick, self)

		table.insert(self._skillEffectDescItems, index, descItem)
	end

	return descItem
end

CharacterTipView.LeftWidth = 470
CharacterTipView.RightWidth = 190
CharacterTipView.TopHeight = 292
CharacterTipView.Interval = 10

function CharacterTipView:_onHyperLinkClick(effectId, clickPosition)
	self._defaultVNP = self._defaultVNP or self.viewParam.defaultVNP

	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(tonumber(effectId), self.setTipPosCallback, self, nil, self._defaultVNP)
end

function CharacterTipView:setTipPosCallback(rectTrTipViewGo, rectTrScrollTip)
	self.rectTrPassive = self.rectTrPassive or self._gopassiveskilltip:GetComponent(gohelper.Type_RectTransform)

	local w = GameUtil.getViewSize()
	local halfW = w / 2
	local screenPosX, screenPosY = recthelper.uiPosToScreenPos2(self.rectTrPassive)
	local localPosX, localPosY = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(screenPosX, screenPosY, rectTrTipViewGo, CameraMgr.instance:getUICamera(), nil, nil)
	local leftRemainWidth = halfW + localPosX - CharacterTipView.LeftWidth - CharacterTipView.Interval
	local scrollTipWidth = recthelper.getWidth(rectTrScrollTip)
	local showLeft = scrollTipWidth <= leftRemainWidth

	rectTrScrollTip.pivot = CommonBuffTipEnum.Pivot.Right

	local anchorX = localPosX
	local anchorY = localPosY

	anchorX = showLeft and anchorX - CharacterTipView.LeftWidth - CharacterTipView.Interval or anchorX + CharacterTipView.RightWidth + CharacterTipView.Interval + scrollTipWidth
	anchorY = anchorY + CharacterTipView.TopHeight

	recthelper.setAnchor(rectTrScrollTip, anchorX, anchorY)
end

function CharacterTipView:_setScrollMaskVisible()
	local root = gohelper.findChild(self._gopassiveskilltip, "mask/root")

	ZProj.UGUIHelper.RebuildLayout(root.transform)

	local scrollContentHeight = recthelper.getHeight(self._passiveskilltipcontent.transform)
	local scrollViewHeight = recthelper.getHeight(self._scrollview.transform)

	self._couldScroll = scrollViewHeight < scrollContentHeight

	gohelper.setActive(self._gomask1, self._couldScroll and gohelper.getRemindFourNumberFloat(self._scrollview.verticalNormalizedPosition) > 0)

	self._passiveskilltipmask.enabled = false
end

function CharacterTipView:_getPassiveUnlock(state, heroid, i, heroMo)
	if state == CharacterEnum.showAttributeOption.ShowMax then
		return true
	elseif state == CharacterEnum.showAttributeOption.ShowMin then
		return false
	elseif heroMo then
		return CharacterModel.instance:isPassiveUnlockByHeroMo(heroMo, i, self._passiveSkillLevel)
	else
		return CharacterModel.instance:isPassiveUnlock(heroid, i)
	end
end

function CharacterTipView:_getTargetRankByEffect(heroid, skilllv)
	local rankCo = SkillConfig.instance:getheroranksCO(heroid)

	for k, _ in pairs(rankCo) do
		local effect = CharacterModel.instance:getrankEffects(heroid, k)

		if effect[2] == skilllv then
			return k - 1
		end
	end

	return 0
end

function CharacterTipView:showDetail(param)
	self._isOpenAttrDesc = not self._isOpenAttrDesc

	gohelper.setActive(self._godetailcontent, self._isOpenAttrDesc)

	if not self._isOpenAttrDesc then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_role_description)

	local tipClickPosition = recthelper.rectToRelativeAnchorPos(param.go.transform.position, self._goattributetip.transform)

	if tipClickPosition.y < CharacterTipView.DetailClickMinPos then
		recthelper.setAnchorY(self._godetailcontent.transform, CharacterTipView.DetailBottomPos)
	else
		recthelper.setAnchorY(self._godetailcontent.transform, tipClickPosition.y + CharacterTipView.DetailOffset)
	end

	local attributeCo = HeroConfig.instance:getHeroAttributeCO(param.attributeId)

	self._txtDetailItemName.text = attributeCo.name

	CharacterController.instance:SetAttriIcon(self._txtDetailItemIcon, param.icon, GameUtil.parseColor("#975129"))

	local attributeDescList = string.split(attributeCo.desc, "|")

	for k, v in ipairs(attributeDescList) do
		local descItem = self._detailDescTab[k]

		if not descItem then
			descItem = gohelper.clone(self._txtDetailItemDesc.gameObject, self._goattributecontentitem, "descItem")

			gohelper.setActive(descItem, false)
			table.insert(self._detailDescTab, descItem)
		end

		gohelper.setActive(descItem, true)

		descItem:GetComponent(gohelper.Type_TextMesh).text = v
	end

	for i = #attributeDescList + 1, #self._detailDescTab do
		gohelper.setActive(self._detailDescTab[i], false)
	end
end

function CharacterTipView:onClose()
	for _, click in pairs(self._detailClickItems) do
		click:RemoveClickListener()
	end
end

return CharacterTipView
