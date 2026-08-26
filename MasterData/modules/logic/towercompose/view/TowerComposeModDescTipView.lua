-- chunkname: @modules/logic/towercompose/view/TowerComposeModDescTipView.lua

module("modules.logic.towercompose.view.TowerComposeModDescTipView", package.seeall)

local TowerComposeModDescTipView = class("TowerComposeModDescTipView", BaseView)

function TowerComposeModDescTipView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goscrollTip = gohelper.findChild(self.viewGO, "scroll_tip")
	self._scrollTip = gohelper.findChildScrollRect(self.viewGO, "scroll_tip")
	self._gomodTipContent = gohelper.findChild(self.viewGO, "scroll_tip/viewport/#go_modTipContent")
	self._gomodTipItem = gohelper.findChild(self.viewGO, "scroll_tip/viewport/#go_modTipContent/#go_modTipItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeModDescTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function TowerComposeModDescTipView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function TowerComposeModDescTipView:_btncloseOnClick()
	self:closeThis()
end

function TowerComposeModDescTipView:_editableInitView()
	self._scrollTipTrans = self._goscrollTip:GetComponent(gohelper.Type_RectTransform)
	self._modTipTrans = self._gomodTipContent:GetComponent(gohelper.Type_RectTransform)
	self.modDescItem = self:getUserDataTb_()

	gohelper.setActive(self._gomodTipItem, false)
end

function TowerComposeModDescTipView:onUpdateParam()
	return
end

function TowerComposeModDescTipView:onOpen()
	self.modIdList = self.viewParam.modIdList
	self.parentGO = self.viewParam.parentGO
	self.pivot = self.viewParam.pivot or Vector2(0.5, 0.5)

	self:refreshUI()
end

function TowerComposeModDescTipView:refreshUI()
	self._scrollTipTrans.pivot = self.pivot
	self._modTipTrans.pivot = Vector2(0.5, self.pivot.y)

	local posX, posY = recthelper.rectToRelativeAnchorPos2(self.parentGO.transform.position, self.viewGO.transform)

	recthelper.setAnchor(self._scrollTipTrans, posX, posY)

	for index, modId in ipairs(self.modIdList) do
		local modDescItem = self.modDescItem[index]

		if not modDescItem then
			modDescItem = {
				go = gohelper.clone(self._gomodTipItem, self._gomodTipContent, "modTipItem_" .. modId)
			}
			modDescItem.txtName = gohelper.findChildText(modDescItem.go, "txt_name")
			modDescItem.txtDesc = gohelper.findChildText(modDescItem.go, "txt_desc")
			modDescItem.imageIcon = gohelper.findChildImage(modDescItem.go, "image_icon")
			modDescItem.imageModColorIcon = gohelper.findChildImage(modDescItem.go, "image_icon_01")
			modDescItem.materialModIcon = UnityEngine.Object.Instantiate(modDescItem.imageModColorIcon.material)
			modDescItem.imageModLvColorIcon = gohelper.findChildImage(modDescItem.go, "image_icon_02")
			modDescItem.materialModLvIcon = UnityEngine.Object.Instantiate(modDescItem.imageModLvColorIcon.material)
			modDescItem.imageModColorIcon.material = modDescItem.materialModIcon
			modDescItem.imageModLvColorIcon.material = modDescItem.materialModLvIcon
			modDescItem.line = gohelper.findChild(modDescItem.go, "line")
			modDescItem.descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(modDescItem.txtDesc.gameObject, FixTmpBreakLine)

			SkillHelper.addHyperLinkClick(modDescItem.txtDesc, self._onHyperLinkClick, self)

			modDescItem.modIconComp = MonoHelper.addNoUpdateLuaComOnceToGo(modDescItem.go, TowerComposeModIconComp)
			self.modDescItem[index] = modDescItem
		end

		gohelper.setActive(modDescItem.go, true)

		modDescItem.modId = modId
		modDescItem.config = TowerComposeConfig.instance:getComposeModConfig(modId)

		modDescItem.modIconComp:refreshMod(modId, modDescItem.imageIcon, modDescItem.imageModColorIcon, modDescItem.imageModLvColorIcon, modDescItem.materialModIcon, modDescItem.materialModLvIcon)

		modDescItem.txtName.text = modDescItem.config.name
		modDescItem.txtDesc.text = SkillHelper.buildDesc(modDescItem.config.desc)

		modDescItem.descFixTmpBreakLine:refreshTmpContent(modDescItem.txtDesc)
		gohelper.setActive(modDescItem.line, index < #self.modIdList)
	end

	self._scrollTip.verticalNormalizedPosition = 1
end

function TowerComposeModDescTipView:_onHyperLinkClick(effId, clickPosition)
	CommonBuffTipController.instance:openCommonTipView(tonumber(effId), clickPosition)
end

function TowerComposeModDescTipView:onClose()
	return
end

function TowerComposeModDescTipView:onDestroyView()
	return
end

return TowerComposeModDescTipView
