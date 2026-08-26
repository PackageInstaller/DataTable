-- chunkname: @modules/logic/custompickchoice/view/CustomPickChoiceView.lua

module("modules.logic.custompickchoice.view.CustomPickChoiceView", package.seeall)

local CustomPickChoiceView = class("CustomPickChoiceView", BaseView)

function CustomPickChoiceView:onInitView()
	self._gobg = gohelper.findChild(self.viewGO, "mask")
	self._gomask = gohelper.findChild(self.viewGO, "bg")
	self._txttitle = gohelper.findChildText(self.viewGO, "Title")
	self._goTips = gohelper.findChild(self.viewGO, "Tips2")
	self._txtnum = gohelper.findChildText(self.viewGO, "Tips2/#txt_num")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancel")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem")
	self._goitem = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem")
	self._gonogain = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_nogain")
	self._goown = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_own")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CustomPickChoiceView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self.closeThis, self)
	self.addEventCb(self, CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickListChanged, self.refreshUI, self)
	self.addEventCb(self, CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickComplete, self.closeThis, self)
end

function CustomPickChoiceView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self.removeEventCb(self, CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickListChanged, self.refreshUI, self)
	self.removeEventCb(self, CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickComplete, self.closeThis, self)
end

function CustomPickChoiceView:_btnconfirmOnClick()
	CustomPickChoiceController.instance:tryChoice(self.viewParam)
end

function CustomPickChoiceView:_editableInitView()
	self._noGainHeroes = {}
	self._ownHeroes = {}
	self._goTitleNoGain = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title1")
	self._goTitleOwn = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title2")
	self._transcontent = self._gocontent.transform

	gohelper.setActive(self._goitem, false)
end

function CustomPickChoiceView:onOpen()
	logNormal("CustomPickChoiceView onOpen")
	CustomPickChoiceController.instance:onOpenView()

	if self.viewParam then
		local styleId = self.viewParam.styleId
		local fixedTexts = styleId and CustomPickChoiceEnum.FixedText[styleId]

		if fixedTexts then
			for com, fixedText in pairs(fixedTexts) do
				if self[com] then
					self[com].text = luaLang(fixedText)
				end
			end
		end

		local compVisible = styleId and CustomPickChoiceEnum.ComponentVisible[styleId]

		if compVisible then
			for com, visible in pairs(compVisible) do
				if self[com] then
					gohelper.setActive(self[com], visible)
				end
			end
		end
	end
end

function CustomPickChoiceView:refreshUI()
	self:refreshSelectCount()
	self:refreshList()
end

function CustomPickChoiceView:refreshSelectCount()
	local selectCount = CustomPickChoiceListModel.instance:getSelectCount()
	local maxCount = CustomPickChoiceListModel.instance:getMaxSelectCount()

	self._txtnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		selectCount,
		maxCount
	})

	ZProj.UGUIHelper.SetGrayscale(self._btnconfirm.gameObject, selectCount ~= maxCount)
end

function CustomPickChoiceView:refreshList()
	self:refreshItems(CustomPickChoiceListModel.instance.noGainList, self._noGainHeroes, self._gonogain, self._goTitleNoGain)
	self:refreshItems(CustomPickChoiceListModel.instance.ownList, self._ownHeroes, self._goown, self._goTitleOwn)
	ZProj.UGUIHelper.RebuildLayout(self._transcontent)
end

function CustomPickChoiceView:refreshItems(datas, items, goRoot, goTitle)
	if datas and #datas > 0 then
		gohelper.setActive(goRoot, true)
		gohelper.setActive(goTitle, true)

		for index, mo in ipairs(datas) do
			local item = self:getOrCreateItem(index, items, goRoot)

			item.component:onUpdateMO(mo)
		end
	else
		gohelper.setActive(goRoot, false)
		gohelper.setActive(goTitle, false)
	end
end

function CustomPickChoiceView:getOrCreateItem(index, items, goRoot)
	local item = items[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.clone(self._goitem, goRoot, "item" .. tostring(index))

		gohelper.setActive(item.go, true)

		item.component = MonoHelper.addNoUpdateLuaComOnceToGo(item.go, CustomPickChoiceItem)

		item.component:init(item.go)
		item.component:addEvents()

		items[index] = item
	end

	return item
end

function CustomPickChoiceView:onClose()
	return
end

function CustomPickChoiceView:onDestroyView()
	CustomPickChoiceController.instance:onCloseView()
end

return CustomPickChoiceView
