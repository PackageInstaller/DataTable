-- chunkname: @modules/logic/custompickchoice/view/NewbieCustomPickView.lua

module("modules.logic.custompickchoice.view.NewbieCustomPickView", package.seeall)

local NewbieCustomPickView = class("NewbieCustomPickView", BaseView)

function NewbieCustomPickView:onInitView()
	self._gobg = gohelper.findChild(self.viewGO, "mask")
	self._gomask = gohelper.findChild(self.viewGO, "bg")
	self._txttitle = gohelper.findChildText(self.viewGO, "TitleBG/Title")
	self._goTips = gohelper.findChild(self.viewGO, "Tips2")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancel")
	self._goChar1Root = gohelper.findChild(self.viewGO, "Hero/#go_Hero1")
	self._goChar2Root = gohelper.findChild(self.viewGO, "Hero/#go_Hero2")
	self._goChar3Root = gohelper.findChild(self.viewGO, "Hero/#go_Hero3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NewbieCustomPickView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self.closeThis, self)
	self.addEventCb(self, CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickListChanged, self.refreshUI, self)
	self.addEventCb(self, CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickComplete, self.closeThis, self)
end

function NewbieCustomPickView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self.removeEventCb(self, CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickListChanged, self.refreshUI, self)
	self.removeEventCb(self, CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickComplete, self.closeThis, self)
end

function NewbieCustomPickView:_btnconfirmOnClick()
	CustomPickChoiceController.instance:tryChoice(self.viewParam)
end

function NewbieCustomPickView:_editableInitView()
	self._HeroItems = {}
end

function NewbieCustomPickView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)
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

function NewbieCustomPickView:refreshUI()
	self:refreshSelectCount()
	self:refreshList()
end

function NewbieCustomPickView:refreshSelectCount()
	local selectCount = CustomPickChoiceListModel.instance:getSelectCount()
	local maxCount = CustomPickChoiceListModel.instance:getMaxSelectCount()

	ZProj.UGUIHelper.SetGrayscale(self._btnconfirm.gameObject, selectCount ~= maxCount)
end

function NewbieCustomPickView:refreshList()
	self:updateCharItem(CustomPickChoiceListModel.instance.allHeroList[1], 1, self._HeroItems, self._goChar1Root)
	self:updateCharItem(CustomPickChoiceListModel.instance.allHeroList[2], 2, self._HeroItems, self._goChar2Root)
	self:updateCharItem(CustomPickChoiceListModel.instance.allHeroList[3], 3, self._HeroItems, self._goChar3Root)
end

function NewbieCustomPickView:updateCharItem(itemData, index, itemList, goRoot)
	local item = self:getOrCreateItem(index, itemList, goRoot)
	local heroId = itemData.id
	local heroCfg
	local heroMo = HeroModel.instance:getByHeroId(heroId)
	local ownNum = 0
	local exSkillLevel = 0

	if heroMo then
		exSkillLevel = heroMo.exSkillLevel
		ownNum = heroMo.exSkillLevel + 1
	end

	local customHeroMo = HeroMo.New()

	customHeroMo:initFromConfig((heroId and heroId ~= 0 or nil) and HeroConfig.instance:getHeroCO(heroId))

	customHeroMo.rank = itemData.rank
	customHeroMo.exSkillLevel = exSkillLevel

	local isSelect = CustomPickChoiceListModel.instance:isHeroIdSelected(heroId)

	item:setSelect(isSelect)
	item:onUpdateMO(customHeroMo)

	local haveText = gohelper.findChild(goRoot, "#go_Have")
	local noHaveText = gohelper.findChild(goRoot, "#go_NoHave")
	local haveHero = ownNum > 0

	gohelper.setActive(haveText, haveHero)
	gohelper.setActive(noHaveText, not haveHero)
end

function NewbieCustomPickView:getOrCreateItem(index, items, goRoot)
	if not items[index] then
		local heroItem = IconMgr.instance:getCommonHeroItem(goRoot)

		heroItem:addClickListener(self._onItemClick, self)
		heroItem:setStyle_CharacterBackpack()
		heroItem:setLevelContentShow(false)
		heroItem:setExSkillActive(true)

		heroItem.btnLongPress = SLFramework.UGUI.UILongPressListener.Get(heroItem.go)

		heroItem.btnLongPress:SetLongPressTime({
			0.5,
			99999
		})
		heroItem.btnLongPress:AddLongPressListener(self._onLongClickItem, self, index)

		items[index] = heroItem
	end

	return items[index]
end

function NewbieCustomPickView:_onItemClick(itemData)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	CustomPickChoiceController.instance:setSelect(itemData.heroId)
end

function NewbieCustomPickView:_onLongClickItem(index)
	local itemData = CustomPickChoiceListModel.instance.allHeroList[index]

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_rolesopen)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = itemData.id
	})
end

function NewbieCustomPickView:onClose()
	for _, heroItem in ipairs(self._HeroItems) do
		heroItem.btnLongPress:RemoveLongPressListener()
	end
end

function NewbieCustomPickView:onDestroyView()
	CustomPickChoiceController.instance:onCloseView()
end

return NewbieCustomPickView
