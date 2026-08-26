-- chunkname: @modules/logic/equip/view/EquipInfoTipsView.lua

module("modules.logic.equip.view.EquipInfoTipsView", package.seeall)

local EquipInfoTipsView = class("EquipInfoTipsView", BaseView)

function EquipInfoTipsView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipInfoTipsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function EquipInfoTipsView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function EquipInfoTipsView:_btncloseOnClick()
	self:closeThis()
end

function EquipInfoTipsView:_editableInitView()
	gohelper.setActive(self._gocontainer, false)

	self._tipPanels = self:getUserDataTb_()
	self._orignAnchorX = recthelper.getAnchorX(self._gocontainer.transform)
	self._panelWidth = recthelper.getWidth(self._gocontainer.transform)
end

function EquipInfoTipsView:onUpdateParam()
	if self.viewParam.equipMo.id == self.equipMo.id then
		return
	end

	self.playAllPanelCloseAnim(self, self.onOpen, self)
end

function EquipInfoTipsView:onOpen()
	self.equipMo = self.viewParam.equipMo
	self.heroCo = self.viewParam.heroCo

	local useCount = 0
	local panel = self:_getTipPanel(1)

	panel.viewParam = self.viewParam

	panel:onOpen()

	useCount = useCount + 1

	local otherEquipMos = self.viewParam.otherEquipMos

	if otherEquipMos and #otherEquipMos > 0 then
		for i, mo in ipairs(otherEquipMos) do
			local _panel = self:_getTipPanel(i + 1)

			_panel.viewParam = tabletool.copy(self.viewParam)
			_panel.viewParam.equipMo = mo
			_panel.viewParam.heroCo = mo.config

			_panel:onOpen()

			useCount = useCount + 1
		end
	end

	if self.viewParam.isOtherEquipId then
		self:_changeViewGoPosition()
	else
		self:changeViewGoPosition()
	end

	for i = useCount + 1, #self._tipPanels do
		local goPanel = self._tipPanels[i]

		gohelper.setActive(goPanel.viewGO, false)
	end
end

function EquipInfoTipsView:_getTipPanel(index)
	local panel = self._tipPanels[index]

	if not panel then
		local go = gohelper.cloneInPlace(self._gocontainer)

		panel = MonoHelper.addNoUpdateLuaComOnceToGo(go, EquipInfoTipsPanel)

		if index > 1 then
			local x = self._orignAnchorX - (self._panelWidth + 20) * (index - 1)

			recthelper.setAnchorX(go.transform, x)
		end

		self._tipPanels[index] = panel
	end

	gohelper.setActive(panel.viewGO, true)

	return panel
end

function EquipInfoTipsView:_changeViewGoPosition()
	local uiRoot = ViewMgr.instance:getUIRoot()
	local sizeX = recthelper.getWidth(uiRoot.transform)
	local sizeY = recthelper.getHeight(uiRoot.transform)

	recthelper.setSize(self.viewGO.transform, sizeX, sizeY)

	self.viewGO.transform.anchorMin = RectTransformDefine.Anchor.LeftMiddle
	self.viewGO.transform.anchorMax = RectTransformDefine.Anchor.LeftMiddle
	self.viewGO.transform.pivot = RectTransformDefine.Anchor.LeftMiddle

	recthelper.setAnchor(self.viewGO.transform, 0, 0)

	for _, item in ipairs(self._tipPanels) do
		recthelper.setAnchorX(item.viewGO.transform, 600)
	end
end

function EquipInfoTipsView:changeViewGoPosition()
	local parentViewGoWeight = recthelper.getWidth(self.viewGO.transform.parent)

	recthelper.setWidth(self.viewGO.transform, parentViewGoWeight / 2 - 100)

	self.viewGO.transform.anchorMin = Vector2(1, 0.5)
	self.viewGO.transform.anchorMax = Vector2(1, 0.5)

	recthelper.setAnchor(self.viewGO.transform, 0, 0)
end

function EquipInfoTipsView:onClose()
	for _, panel in pairs(self._tipPanels) do
		panel:onClose()
	end
end

function EquipInfoTipsView:playAllPanelCloseAnim(callback, callbackObj)
	local panel = self._tipPanels[1]

	if not panel or not panel.viewGO.activeSelf then
		if callback then
			callback(callbackObj)
		end

		return
	end

	panel:playCloseAnim(callback, callbackObj)

	for i = 2, #self._tipPanels do
		panel = self._tipPanels[i]

		if self._tipPanels[i] and panel.viewGO.activeSelf then
			panel:playCloseAnim()
		end
	end
end

function EquipInfoTipsView:onDestroyView()
	return
end

return EquipInfoTipsView
