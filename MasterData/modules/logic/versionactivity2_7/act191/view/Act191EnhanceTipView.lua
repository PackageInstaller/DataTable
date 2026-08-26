-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191EnhanceTipView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191EnhanceTipView", package.seeall)

local Act191EnhanceTipView = class("Act191EnhanceTipView", BaseView)

function Act191EnhanceTipView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "#go_Root/#simage_Icon")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_Root/#txt_Name")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#go_Root/scroll_desc/Viewport/go_desccontent/#txt_Desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191EnhanceTipView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Act191EnhanceTipView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Act191EnhanceTipView:_btnCloseOnClick()
	self:closeThis()
end

function Act191EnhanceTipView:_editableInitView()
	self.actId = Activity191Model.instance:getCurActId()
end

function Act191EnhanceTipView:onOpen()
	gohelper.setActive(self._btnClose, not self.viewParam.notShowBg)

	if self.viewParam.pos then
		local anchorPos = recthelper.rectToRelativeAnchorPos(self.viewParam.pos, self.viewGO.transform)

		recthelper.setAnchor(self._goRoot.transform, anchorPos.x + 85, 8)
	end

	local enhanceCo = self.viewParam.co

	if enhanceCo then
		self._simageIcon:LoadImage(ResUrl.getAct174BuffIcon(enhanceCo.icon))

		self._txtName.text = enhanceCo.name
		self._txtDesc.text = enhanceCo.desc

		local desc = SkillHelper.addLink(enhanceCo.desc)
		local effectId = string.splitToNumber(enhanceCo.effects, "|")[1]
		local effectCo = lua_activity191_effect.configDict[effectId]

		if effectCo then
			if effectCo.type == Activity191Enum.EffectType.EnhanceHero then
				self._txtDesc.text = Activity191Helper.buildDesc(desc, Activity191Enum.HyperLinkPattern.EnhanceDestiny, effectCo.typeParam)

				SkillHelper.addHyperLinkClick(self._txtDesc, Activity191Helper.clickHyperLinkDestiny)
			elseif effectCo.type == Activity191Enum.EffectType.Item then
				self._txtDesc.text = Activity191Helper.buildDesc(desc, Activity191Enum.HyperLinkPattern.EnhanceItem, effectCo.typeParam .. "#")

				SkillHelper.addHyperLinkClick(self._txtDesc, Activity191Helper.clickHyperLinkItem)
			elseif effectCo.type == Activity191Enum.EffectType.Hero then
				self._txtDesc.text = Activity191Helper.buildDesc(desc, Activity191Enum.HyperLinkPattern.Hero, effectCo.typeParam)

				SkillHelper.addHyperLinkClick(self._txtDesc, Activity191Helper.clickHyperLinkRole)
			else
				self._txtDesc.text = desc
			end
		else
			self._txtDesc.text = desc
		end
	end
end

function Act191EnhanceTipView:onUpdateParam()
	self:onOpen()
end

return Act191EnhanceTipView
