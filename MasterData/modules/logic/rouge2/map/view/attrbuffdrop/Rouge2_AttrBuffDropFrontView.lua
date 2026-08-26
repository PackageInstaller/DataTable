-- chunkname: @modules/logic/rouge2/map/view/attrbuffdrop/Rouge2_AttrBuffDropFrontView.lua

module("modules.logic.rouge2.map.view.attrbuffdrop.Rouge2_AttrBuffDropFrontView", package.seeall)

local Rouge2_AttrBuffDropFrontView = class("Rouge2_AttrBuffDropFrontView", BaseView)

function Rouge2_AttrBuffDropFrontView:onInitView()
	self._goInfo = gohelper.findChild(self.viewGO, "#go_Info")
	self._goAttrReason = gohelper.findChild(self.viewGO, "#go_Info/Layout/#go_AttrReason")
	self._imageAttrReason = gohelper.findChildImage(self.viewGO, "#go_Info/Layout/#go_AttrReason/#image_AttrReason")
	self._txtAttrReason = gohelper.findChildText(self.viewGO, "#go_Info/Layout/#go_AttrReason/#txt_AttrReason")
	self._goFront = gohelper.findChild(self.viewGO, "#go_Front")
	self._imageAttrReason2 = gohelper.findChildImage(self.viewGO, "#go_Front/#image_AttrReason")
	self._txtAttrReason2 = gohelper.findChildText(self.viewGO, "#go_Front/#txt_AttrReason")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_AttrBuffDropFrontView:addEvents()
	return
end

function Rouge2_AttrBuffDropFrontView:removeEvents()
	return
end

function Rouge2_AttrBuffDropFrontView:_editableInitView()
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self._goFront)
end

function Rouge2_AttrBuffDropFrontView:onOpen()
	self:initViewParam()
	self:refreshUI()
end

function Rouge2_AttrBuffDropFrontView:onOpenFinish()
	return
end

function Rouge2_AttrBuffDropFrontView:onUpdateParam()
	self:initViewParam()
	self:refreshUI()
end

function Rouge2_AttrBuffDropFrontView:initViewParam()
	self._viewEnum = self.viewParam and self.viewParam.viewEnum
end

function Rouge2_AttrBuffDropFrontView:refreshUI()
	self:refreshAttrTips()
end

function Rouge2_AttrBuffDropFrontView:refreshAttrTips()
	self._animatorPlayer:Stop()

	local showReason = self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select

	gohelper.setActive(self._goAttrReason, showReason)
	gohelper.setActive(self._goFront, showReason)

	if not showReason then
		self:_hideFrontView()

		return
	end

	if self.viewParam then
		local interactive = self.viewParam.interactive
		local dropAttrId = interactive and interactive.dropAttrId

		if not dropAttrId or dropAttrId == 0 then
			logError(string.format("肉鸽属性谐波掉落来源不存在 dropAttrId = %s", dropAttrId))

			return
		end

		local dropCo = Rouge2_AttributeConfig.instance:getAttrDropConfig(dropAttrId)
		local attrId = dropCo and dropCo.attr
		local attrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(attrId)

		if attrCo then
			if not attrCo.name then
				local attrName = ""

				if dropCo then
					if not dropCo.needNum then
						local attrValue = 0

						self._txtAttrReason.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("rouge2_attrbuffdropview_tips2"), attrName, attrValue)
						self._txtAttrReason2.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_attrbuffdropview_tips3"), attrName)

						Rouge2_IconHelper.setAttributeIcon(attrId, self._imageAttrReason, Rouge2_Enum.AttrIconSuffix.Large)
						Rouge2_IconHelper.setAttributeIcon(attrId, self._imageAttrReason2, Rouge2_Enum.AttrIconSuffix.Large)
						gohelper.setActive(self._goInfo, false)
						self._animatorPlayer:Play("open", self._hideFrontView, self)
						AudioMgr.instance:trigger(AudioEnum.Rouge2.OpenAttrDropFront)
					end
				end
			end
		end
	end
end

function Rouge2_AttrBuffDropFrontView:_hideFrontView()
	gohelper.setActive(self._goFront, false)
	gohelper.setActive(self._goInfo, true)
	self:tryGuideAttrDropView()
end

function Rouge2_AttrBuffDropFrontView:tryGuideAttrDropView()
	if self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select and not GuideModel.instance:isGuideFinish(Rouge2_MapEnum.GuideId.AttrBuffDrop) then
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnGuideAttrBuffDrop)
	end
end

function Rouge2_AttrBuffDropFrontView:onClose()
	if self._animatorPlayer then
		self._animatorPlayer:Stop()
	end
end

return Rouge2_AttrBuffDropFrontView
