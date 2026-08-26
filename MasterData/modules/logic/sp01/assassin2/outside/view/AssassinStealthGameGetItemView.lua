-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGameGetItemView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameGetItemView", package.seeall)

local AssassinStealthGameGetItemView = class("AssassinStealthGameGetItemView", BaseView)

function AssassinStealthGameGetItemView:onInitView()
	self._btnclick = gohelper.findChildClickWithAudio(self.viewGO, "#simage_Mask", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._gocontent = gohelper.findChild(self.viewGO, "root/Grid")
	self._goItem = gohelper.findChild(self.viewGO, "root/Grid/#go_Item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinStealthGameGetItemView:addEvents()
	self._btnclick:AddClickListener(self._btnCloseOnClick, self)
end

function AssassinStealthGameGetItemView:removeEvents()
	self._btnclick:RemoveClickListener()
end

function AssassinStealthGameGetItemView:_btnCloseOnClick()
	self:closeThis()
end

function AssassinStealthGameGetItemView:_editableInitView()
	return
end

function AssassinStealthGameGetItemView:onUpdateParam()
	return
end

function AssassinStealthGameGetItemView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_getitems)
	gohelper.CreateObjList(self, self._onCreateItem, self.viewParam, self._gocontent, self._goItem)
end

function AssassinStealthGameGetItemView:_onCreateItem(obj, data, index)
	local imageIcon = gohelper.findChildImage(obj, "#simage_Icon")
	local txtNum = gohelper.findChildText(obj, "image_TipsBG/#txt_Num")

	AssassinHelper.setAssassinItemIcon(data.itemId, imageIcon)

	txtNum.text = data.count
end

function AssassinStealthGameGetItemView:onClose()
	return
end

function AssassinStealthGameGetItemView:onDestroyView()
	return
end

return AssassinStealthGameGetItemView
