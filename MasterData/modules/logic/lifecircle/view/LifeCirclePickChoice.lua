-- chunkname: @modules/logic/lifecircle/view/LifeCirclePickChoice.lua

module("modules.logic.lifecircle.view.LifeCirclePickChoice", package.seeall)

local LifeCirclePickChoice = class("LifeCirclePickChoice", BaseView)

function LifeCirclePickChoice:onInitView()
	self._simageListBG = gohelper.findChildSingleImage(self.viewGO, "#simage_ListBG")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancel")
	self._scrollrule = gohelper.findChildScrollRect(self.viewGO, "#scroll_rule")
	self._gostoreItem = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem")
	self._gonogain = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_nogain")
	self._goown = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_own")
	self._scrollrule_simple = gohelper.findChildScrollRect(self.viewGO, "#scroll_rule_simple")
	self._gostoreItem_simple = gohelper.findChild(self.viewGO, "#scroll_rule_simple/Viewport/#go_storeItem_simple")
	self._gosimple = gohelper.findChild(self.viewGO, "#scroll_rule_simple/Viewport/#go_storeItem_simple/#go_simple")
	self._goLifeCirclePickChoiceItem = gohelper.findChild(self.viewGO, "#go_LifeCirclePickChoiceItem")
	self._goexskill = gohelper.findChild(self.viewGO, "#go_LifeCirclePickChoiceItem/role/#go_exskill")
	self._imageexskill = gohelper.findChildImage(self.viewGO, "#go_LifeCirclePickChoiceItem/role/#go_exskill/#image_exskill")
	self._goclick = gohelper.findChild(self.viewGO, "#go_LifeCirclePickChoiceItem/select/#go_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LifeCirclePickChoice:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
end

function LifeCirclePickChoice:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
end

local ti = table.insert

LifeCirclePickChoice.Style = {
	Title = 1,
	None = 0
}

local function _sortFunc(a, b)
	local aHeroMo = HeroModel.instance:getByHeroId(a.id)
	local bHeroMo = HeroModel.instance:getByHeroId(b.id)
	local aHasHero = aHeroMo ~= nil
	local bHasHero = bHeroMo ~= nil

	if aHasHero ~= bHasHero then
		return bHasHero
	end

	if aHeroMo then
		if not aHeroMo.exSkillLevel then
			local aSkillLevel = -1

			if bHeroMo then
				if not bHeroMo.exSkillLevel then
					local bSkillLevel = -1

					if aSkillLevel ~= bSkillLevel then
						if aSkillLevel == 5 or bSkillLevel == 5 then
							return aSkillLevel ~= 5
						end

						return bSkillLevel < aSkillLevel
					end

					return a.id > b.id
				end
			end
		end
	end
end

function LifeCirclePickChoice:_btncancelOnClick()
	self:closeThis()
end

function LifeCirclePickChoice:_confirmCallback()
	local cb = self.viewParam.callback

	if cb then
		self.viewParam.callback(self)
	else
		self:closeThis()
	end
end

function LifeCirclePickChoice:_btnconfirmOnClick()
	self:_confirmCallback()
end

function LifeCirclePickChoice:_editableInitView()
	self._txtTitle = gohelper.findChildText(self.viewGO, "Title")
	self._btn_confirmTxt = gohelper.findChildText(self.viewGO, "#btn_confirm/Text")
	self._goTitleNoGain = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title1")
	self._goTitleOwn = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title2")

	gohelper.setActive(self._goLifeCirclePickChoiceItem, false)

	self._gostoreItemTrans = self._gostoreItem.transform
	self._gostoreItem_simpleTrans = self._gostoreItem_simple.transform
	self._scrollruleGo = self._scrollrule.gameObject
	self._scrollrule_simpleGo = self._scrollrule_simple.gameObject
	self._noGainItemList = {}
	self._ownItemList = {}
	self._noGainDataList = {}
	self._ownDataList = {}
end

function LifeCirclePickChoice:_heroIdList()
	return self.viewParam.heroIdList or {}
end

function LifeCirclePickChoice:_title()
	return self.viewParam.title or ""
end

function LifeCirclePickChoice:_confirmDesc()
	return self.viewParam.confirmDesc or ""
end

function LifeCirclePickChoice:isCustomSelect()
	return self.viewParam.isCustomSelect or false
end

function LifeCirclePickChoice:_isTitleStyle()
	return self.viewParam.style == LifeCirclePickChoice.Style.None
end

function LifeCirclePickChoice:onUpdateParam()
	gohelper.setActive(self._scrollruleGo, false)
	gohelper.setActive(self._scrollrule_simpleGo, false)

	if self:_isTitleStyle() then
		gohelper.setActive(self._scrollruleGo, true)
		self:_refreshWithTitle()
	else
		gohelper.setActive(self._scrollrule_simpleGo, true)
		self:_refresh()
	end
end

function LifeCirclePickChoice:onOpen()
	self._txtTitle.text = self:_title()
	self._btn_confirmTxt.text = self:_confirmDesc()

	for _, heroId in ipairs(self:_heroIdList()) do
		local mo = SummonCustomPickChoiceMO.New()

		mo:init(heroId)

		if mo:hasHero() then
			ti(self._ownDataList, mo)
		else
			ti(self._noGainDataList, mo)
		end
	end

	table.sort(self._ownDataList, _sortFunc)
	table.sort(self._noGainDataList, _sortFunc)
	self:onUpdateParam()
end

function LifeCirclePickChoice:onClose()
	GameUtil.onDestroyViewMemberList(self, "_noGainItemList")
	GameUtil.onDestroyViewMemberList(self, "_ownItemList")
end

function LifeCirclePickChoice:onDestroyView()
	return
end

function LifeCirclePickChoice:_refreshWithTitle()
	self:_refreshItemListAndTitle(self._noGainDataList, self._noGainItemList, self._gonogain, self._goTitleNoGain)
	self:_refreshItemListAndTitle(self._ownDataList, self._ownItemList, self._goown, self._goTitleOwn)
	ZProj.UGUIHelper.RebuildLayout(self._gostoreItemTrans)
end

function LifeCirclePickChoice:_refresh()
	self:_refreshItemList(self._noGainDataList, self._noGainItemList, self._gosimple)
	self:_refreshItemList(self._ownDataList, self._ownItemList, self._gosimple)
	ZProj.UGUIHelper.RebuildLayout(self._gostoreItem_simpleTrans)
end

function LifeCirclePickChoice:_refreshItemListAndTitle(dataList, refItemList, parentGO, goTitle)
	local isEmpty = not dataList or #dataList == 0

	gohelper.setActive(parentGO, not isEmpty)
	gohelper.setActive(goTitle, not isEmpty)

	if isEmpty then
		return
	end

	self:_refreshItemList(dataList, refItemList, parentGO)
end

function LifeCirclePickChoice:_refreshItemList(dataList, refItemList, parentGO)
	for index, mo in ipairs(dataList) do
		local item = refItemList[index]

		if not item then
			item = self:_create_LifeCirclePickChoiceItem(index, parentGO)
			refItemList[index] = item
		end

		item:onUpdateMO(mo)
		item:setActive(true)
	end

	for i = #dataList + 1, #refItemList do
		local item = refItemList[i]

		item:setActive(false)
	end
end

function LifeCirclePickChoice:_create_LifeCirclePickChoiceItem(index, parentGO)
	local go = gohelper.clone(self._goLifeCirclePickChoiceItem, parentGO)
	local item = LifeCirclePickChoiceItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:init(go)
	item:setIndex(index)

	return item
end

function LifeCirclePickChoice:onItemSelected(item, isSelected)
	if self._lastSelectedItem then
		self._lastSelectedItem:setSelected(false)
	end

	self._lastSelectedItem = isSelected and item or nil
end

function LifeCirclePickChoice:selectedHeroId()
	if not self._lastSelectedItem then
		return
	end

	return self._lastSelectedItem:heroId()
end

return LifeCirclePickChoice
