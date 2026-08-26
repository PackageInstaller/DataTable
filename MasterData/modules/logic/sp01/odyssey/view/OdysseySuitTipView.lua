-- chunkname: @modules/logic/sp01/odyssey/view/OdysseySuitTipView.lua

module("modules.logic.sp01.odyssey.view.OdysseySuitTipView", package.seeall)

local OdysseySuitTipView = class("OdysseySuitTipView", BaseView)

function OdysseySuitTipView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gosuitTip = gohelper.findChild(self.viewGO, "#go_suitTip")
	self._goequipSuit = gohelper.findChild(self.viewGO, "#go_suitTip/#go_equipSuit")
	self._gouneffect = gohelper.findChild(self.viewGO, "#go_suitTip/#go_equipSuit/#go_uneffect")
	self._txtsuitName = gohelper.findChildText(self.viewGO, "#go_suitTip/#go_equipSuit/#go_uneffect/#txt_suitName")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_suitTip/#go_equipSuit/#go_uneffect/#image_icon")
	self._goeffect = gohelper.findChild(self.viewGO, "#go_suitTip/#go_equipSuit/#go_effect")
	self._txtsuitNameEffect = gohelper.findChildText(self.viewGO, "#go_suitTip/#go_equipSuit/#go_effect/#txt_suitNameEffect")
	self._imageiconEffect = gohelper.findChildImage(self.viewGO, "#go_suitTip/#go_equipSuit/#go_effect/#image_iconEffect")
	self._goactiveBg = gohelper.findChild(self.viewGO, "#go_suitTip/#go_equipSuit/#go_effect/#go_activeBg")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#go_suitTip/#scroll_desc")
	self._txtdesc1 = gohelper.findChildText(self.viewGO, "#go_suitTip/#scroll_desc/Viewport/Content/#txt_desc1")
	self._txtdesc2 = gohelper.findChildText(self.viewGO, "#go_suitTip/#scroll_desc/Viewport/Content/#txt_desc2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseySuitTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function OdysseySuitTipView:removeEvents()
	self._btnclose:RemoveClickListener()
end

OdysseySuitTipView.TipHalfWidth = 430
OdysseySuitTipView.TipOffsetY = -100

function OdysseySuitTipView:_btncloseOnClick()
	self:closeThis()
end

function OdysseySuitTipView:_editableInitView()
	self._descItem = self:getUserDataTb_()

	gohelper.setActive(self._txtdesc2.gameObject, false)
end

function OdysseySuitTipView:onUpdateParam()
	return
end

function OdysseySuitTipView:onOpen()
	local param = self.viewParam
	local suitId = param.suitId
	local suitLevel = param.level
	local bagType = param.bagType
	local suitConfig = OdysseyConfig.instance:getEquipSuitConfig(suitId)
	local curFormInfo = OdysseyHeroGroupModel.instance:getCurHeroGroup()

	if suitLevel == nil then
		local suitInfo = curFormInfo:getOdysseyEquipSuit(suitId)

		suitLevel = suitInfo and suitInfo.level or 0
	end

	local active = bagType == OdysseyEnum.BagType.Bag or suitLevel > 0

	if not active then
		if not self._txtsuitName then
			local nameText = self._txtsuitNameEffect

			if not active then
				if not self._imageicon then
					local iconImage = self._imageiconEffect

					nameText.text = suitConfig.name

					UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(iconImage, suitConfig.icon)

					self._txtdesc1.text = suitConfig.desc

					gohelper.setActive(self._goeffect, active)
					gohelper.setActive(self._gouneffect, not active)
					gohelper.setActive(self._goactiveBg, bagType ~= OdysseyEnum.BagType.Bag)

					local suitConfigList = OdysseyConfig.instance:getEquipSuitAllEffect(suitId)
					local suitItem = self._descItem
					local suitItemCount = #suitItem
					local suitCount = #suitConfigList

					for i = 1, suitCount do
						local config = suitConfigList[i]
						local textItem

						if suitItemCount < i then
							local textItemGo = gohelper.clone(self._txtdesc2.gameObject, self._txtdesc2.gameObject.transform.parent.gameObject)

							textItem = gohelper.findChildText(textItemGo, "")

							table.insert(suitItem, textItem)
						else
							textItem = suitItem[i]
						end

						gohelper.setActive(textItem, true)

						local singleActive = bagType == OdysseyEnum.BagType.Bag or suitLevel >= config.level

						textItem.text = SkillHelper.buildDesc(config.effect)

						local fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(textItem.gameObject, FixTmpBreakLine)

						SkillHelper.addHyperLinkClick(textItem, self._onHyperLinkClick, self)
						fixTmpBreakLine:refreshTmpContent(textItem)

						if singleActive then
							textItem.text = string.format("<color=%s>%s</color>", OdysseyEnum.SuitDescColor.Active, textItem.text)
						end
					end

					if suitCount < suitItemCount then
						for i = suitCount + 1, suitItemCount do
							gohelper.setActive(suitItem[i], false)
						end
					end

					if param.pos then
						local posX, posY = recthelper.screenPosToAnchorPos2(param.pos, self.viewGO.transform)
						local tipPosX = posX - OdysseySuitTipView.TipHalfWidth
						local tipPosY = math.max(0, posY + OdysseySuitTipView.TipOffsetY)

						self:setTipPos(tipPosX, tipPosY)
						gohelper.fitScreenOffset(self._gosuitTip.transform)
					end
				end
			end
		end
	end
end

function OdysseySuitTipView:_onHyperLinkClick(effId, clickPosition)
	local positionX = recthelper.getAnchorX(self._gosuitTip.transform)
	local tipPos

	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(effId), positionX >= 0 and Vector2.New(positionX - 825, 175) or Vector2.New(positionX + 255, 175))
end

function OdysseySuitTipView:setTipPos(x, y)
	transformhelper.setLocalPosXY(self._gosuitTip.transform, x, y)
end

function OdysseySuitTipView:onClose()
	return
end

function OdysseySuitTipView:onDestroyView()
	return
end

return OdysseySuitTipView
