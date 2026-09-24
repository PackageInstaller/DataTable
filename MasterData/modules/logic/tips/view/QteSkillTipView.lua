-- chunkname: @modules/logic/tips/view/QteSkillTipView.lua

module("modules.logic.tips.view.QteSkillTipView", package.seeall)

local QteSkillTipView = class("QteSkillTipView", BaseView)

function QteSkillTipView:onInitView()
	self.closeClick = gohelper.findChildClick(self.viewGO, "root/#btn_close")

	self.addClickCb(self, self.closeClick, self.closeThis, self)

	self.closeCLick1 = gohelper.findChildClick(self.viewGO, "root/Bg/icon2")

	self.addClickCb(self, self.closeCLick1, self.closeThis, self)

	self.simageSkillIcon = gohelper.findChildSingleImage(self.viewGO, "root/skillcard/#go_skillcarditem/imgIcon")
	self.simageTagIcon = gohelper.findChildSingleImage(self.viewGO, "root/skillcard/#go_skillcarditem/tag/tagIcon")
	self.txtSkillName = gohelper.findChildText(self.viewGO, "root/name")
	self.imageCost = gohelper.findChildImage(self.viewGO, "root/cost/#image_icon")
	self.txtCost = gohelper.findChildText(self.viewGO, "root/cost/#txt_cost")

	local goContent = gohelper.findChild(self.viewGO, "root/skilltipScrollview/Viewport/Content")

	self.txtDesc = gohelper.findChildText(goContent, "qte/#txt_qte")
	self.goTxtExtra = gohelper.findChild(goContent, "extra/#txt_extra")
	self.txtExtraList = self:getUserDataTb_()
	self.txtExtraDescList = self:getUserDataTb_()

	table.insert(self.txtExtraList, self.goTxtExtra:GetComponent(gohelper.Type_TextMesh))

	self._btnTip = gohelper.findChildButtonWithAudio(self.viewGO, "root/Bg/#btn_tips")
	self._goTip = gohelper.findChild(self.viewGO, "root/Bg/#btn_tips/Tips")
	self._btncloseTip = gohelper.findChildButtonWithAudio(self.viewGO, "root/Bg/#btn_tips/Tips/#btn_close")
	self._txtTip = gohelper.findChildText(self.viewGO, "root/Bg/#btn_tips/Tips/#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function QteSkillTipView:addEvents()
	self._btnTip:AddClickListener(self.onClickTips, self)
	self._btncloseTip:AddClickListener(self.onClickCloseTips, self)
end

function QteSkillTipView:removeEvents()
	self._btnTip:RemoveClickListener()
	self._btncloseTip:RemoveClickListener()
end

function QteSkillTipView:onClickTips()
	self:_showTip(true)
end

function QteSkillTipView:onClickCloseTips()
	self:_showTip(false)
end

function QteSkillTipView:_showTip(isShow)
	gohelper.setActive(self._goTip, isShow)
end

local TipOffset1 = Vector2(270, 170)

function QteSkillTipView:_editableInitView()
	local tip = lua_fight_qte_const.configDict[6].value2

	self._tipDesc = MonoHelper.addNoUpdateLuaComOnceToGo(self._txtTip.gameObject, SkillDescComp)

	self._tipDesc:setNumberColor("#C66030")
	self._tipDesc:setLinkColor("#4e6698")
	self._tipDesc:setTipParam(0, TipOffset1)
	self._tipDesc:updateInfo(self._txtTip, tip)
end

function QteSkillTipView:onClickModalMask()
	self:closeThis()
end

function QteSkillTipView:onUpdateParam()
	self:initData()
	self:refreshUI()
end

function QteSkillTipView:onOpen()
	self:initData()
	self:refreshUI()
	gohelper.setActive(self._btnTip.gameObject, true)
	self:_showTip(false)
end

function QteSkillTipView:initData()
	self.qteSkillGroupId = self.viewParam
	self.qteSkillGroupCo = lua_fight_qte_skillgroup.configDict[self.qteSkillGroupId]
	self.entityName = ""

	if not self.qteSkillGroupCo then
		logError("洞知技能配置不存在: id : " .. tostring(self.qteSkillGroupId))
	end
end

local TipOffset = Vector2(-300, 0)

function QteSkillTipView:refreshUI()
	if not self.qteSkillGroupCo then
		return
	end

	local activeSkillId = self.qteSkillGroupCo.activeId
	local activeSkillCo = activeSkillId and lua_skill.configDict[activeSkillId]

	if activeSkillCo then
		local costType, cost = FightHelper.getQTESkillCost(activeSkillCo)
		local image = FightQteEntityItemHelper.getCostTypeImage(costType)

		UISpriteSetMgr.instance:setFightSprite(self.imageCost, image)

		self.txtCost.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("fight_common_double_param"), luaLang("multiple"), cost)
		self.txtSkillName.text = activeSkillCo.name
		self._skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(self.txtDesc.gameObject, SkillDescComp)

		self._skillDesc:setNumberColor("#C66030")
		self._skillDesc:setLinkColor("#4e6698")
		self._skillDesc:setTipParam(0, TipOffset)
		self._skillDesc:updateInfo(self.txtDesc, FightConfig.instance:getSkillEffectDesc(self.entityName, activeSkillCo))
		self.simageSkillIcon:LoadImage(ResUrl.getSkillIcon(activeSkillCo.icon))

		local showTag = activeSkillCo.showTag

		showTag = string.format("attribute_%s", showTag)
		showTag = ResUrl.getAttributeIcon(showTag)

		self.simageTagIcon:LoadImage(showTag)
	end

	local extraIndex = 0
	local passive1Co = lua_skill.configDict[self.qteSkillGroupCo.passiveId1]

	if passive1Co then
		extraIndex = extraIndex + 1

		local txt = self.txtExtraList[extraIndex]

		if not txt then
			local go = gohelper.cloneInPlace(self.goTxtExtra)

			txt = go:GetComponent(gohelper.Type_TextMesh)

			table.insert(self.txtExtraList, txt)
		end

		self:_refreshExtraTxt(extraIndex, FightConfig.instance:getSkillEffectDesc(self.entityName, passive1Co))
		gohelper.setActive(txt.gameObject, true)
	end

	local passive2Co = lua_skill.configDict[self.qteSkillGroupCo.passiveId2]

	if passive2Co then
		extraIndex = extraIndex + 1

		local txt = self.txtExtraList[extraIndex]

		if not txt then
			local go = gohelper.cloneInPlace(self.goTxtExtra)

			txt = go:GetComponent(gohelper.Type_TextMesh)

			table.insert(self.txtExtraList, txt)
		end

		self:_refreshExtraTxt(extraIndex, FightConfig.instance:getSkillEffectDesc(self.entityName, passive2Co))
		gohelper.setActive(txt.gameObject, true)
	end

	for i = extraIndex + 1, #self.txtExtraList do
		local txt = self.txtExtraList[i]

		gohelper.setActive(txt.gameObject, false)
	end
end

function QteSkillTipView:_refreshExtraTxt(extraIndex, desc)
	if not self.txtExtraList[extraIndex] then
		return
	end

	local descComp = self.txtExtraDescList[extraIndex]
	local txt = self.txtExtraList[extraIndex]

	if not descComp then
		descComp = MonoHelper.addNoUpdateLuaComOnceToGo(txt.gameObject, SkillDescComp)

		descComp:setNumberColor("#C66030")
		descComp:setLinkColor("#4e6698")
		descComp:setTipParam(0, TipOffset)

		self.txtExtraDescList[extraIndex] = descComp
	end

	descComp:updateInfo(txt, desc)
end

function QteSkillTipView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
end

function QteSkillTipView:onDestroyView()
	if self.simageSkillIcon then
		self.simageSkillIcon:UnLoadImage()

		self.simageSkillIcon = nil
	end

	if self.simageSkillIcon then
		self.simageSkillIcon:UnLoadImage()

		self.simageSkillIcon = nil
	end
end

return QteSkillTipView
