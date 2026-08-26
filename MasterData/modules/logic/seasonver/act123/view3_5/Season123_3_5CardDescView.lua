-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5CardDescView.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5CardDescView", package.seeall)

local Season123_3_5CardDescView = class("Season123_3_5CardDescView", BaseView)

function Season123_3_5CardDescView:onInitView()
	self.btnBgClose = gohelper.findChildClickWithAudio(self.viewGO, "bg/fullbg")
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_target/#btn_leave")
	self.goDescContent = gohelper.findChild(self.viewGO, "#go_target/#scroll_desc/Viewport/#go_descContent")
	self.goDescItem = gohelper.findChild(self.viewGO, "#go_target/#scroll_desc/Viewport/#go_descContent/#go_descitem")

	gohelper.setActive(self.goDescItem, false)

	self.txtName = gohelper.findChildTextMesh(self.viewGO, "#go_target/#txt_cardname")
	self.cardPos = gohelper.findChild(self.viewGO, "#go_target/#go_ctrl/#go_targetcardpos")
	self.goTipsPos = gohelper.findChild(self.viewGO, "#go_tipspos")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_3_5CardDescView:addEvents()
	self.addClickCb(self, self.btnBgClose, self.onClickClose, self)
	self.addClickCb(self, self.btnClose, self.onClickClose, self)
end

function Season123_3_5CardDescView:removeEvents()
	self:removeClickCb(self.btnBgClose)
	self:removeClickCb(self.btnClose)
end

function Season123_3_5CardDescView:_editableInitView()
	return
end

function Season123_3_5CardDescView:onClickClose()
	self:closeThis()
end

function Season123_3_5CardDescView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_fight_ui_uttu_card_pop)

	self.equipId = self.viewParam.equipId
	self.equipConfig = Season123Config.instance:getSeasonEquipCo(self.equipId)

	self:refreshUI()
end

function Season123_3_5CardDescView:refreshUI()
	if not self.equipConfig then
		return
	end

	self.txtName.text = self.equipConfig.name

	if not self.cardItem then
		self.cardItem = Season123_3_5CelebrityCardItem.New()

		self.cardItem:init(self.cardPos, self.equipId, {
			noClick = true
		})
	else
		self.cardItem:reset(self.equipId)
	end

	self:refreshCardDesc(self.equipConfig)
end

function Season123_3_5CardDescView:refreshCardDesc(itemConfig)
	self.cardDescInfos = self:getUserDataTb_()

	if itemConfig then
		local skillList = Season123EquipMetaUtils.getSkillEffectStrList(itemConfig)

		self.colorStr = Season123EquipMetaUtils.getCareerColorDarkBg(itemConfig.equipId)

		if itemConfig.attrId ~= 0 then
			local propsList = Season123EquipMetaUtils.getEquipPropsStrList(itemConfig.attrId)

			if GameUtil.getTabLen(propsList) > 0 then
				tabletool.addValues(self.cardDescInfos, propsList)
			end
		end

		tabletool.addValues(self.cardDescInfos, skillList)
		gohelper.CreateObjList(self, self.cardDescItemShow, self.cardDescInfos, self.goDescContent, self.goDescItem)
	end
end

function Season123_3_5CardDescView:cardDescItemShow(obj, data, index)
	obj.name = "desc" .. index

	local txtDesc = gohelper.findChildText(obj, "txt_desc")
	local fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(txtDesc.gameObject, FixTmpBreakLine)

	data = SkillHelper.addLink(data)
	data = HeroSkillModel.instance:skillDesToSpot(data)
	txtDesc.text = data

	fixTmpBreakLine:refreshTmpContent(txtDesc)
	SLFramework.UGUI.GuiHelper.SetColor(txtDesc, self.colorStr)
	SkillHelper.addHyperLinkClick(txtDesc, self.setSkillClickCallBack, self)
end

function Season123_3_5CardDescView:setSkillClickCallBack(effId, clickPosition)
	local tipPosX, tipPosY = recthelper.getAnchor(self.goTipsPos.transform)
	local tipPos = Vector2.New(tipPosX, tipPosY)

	CommonBuffTipController:openCommonTipViewWithCustomPos(effId, tipPos, CommonBuffTipEnum.Pivot.Left)
end

function Season123_3_5CardDescView:onClose()
	return
end

function Season123_3_5CardDescView:onDestroyView()
	if self.cardItem then
		self.cardItem:destroy()

		self.cardItem = nil
	end
end

return Season123_3_5CardDescView
