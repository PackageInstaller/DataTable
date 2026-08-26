-- chunkname: @modules/logic/sodache/view/inside/SodacheCardQuickSelectView.lua

module("modules.logic.sodache.view.inside.SodacheCardQuickSelectView", package.seeall)

local SodacheCardQuickSelectView = class("SodacheCardQuickSelectView", BaseView)

function SodacheCardQuickSelectView:onInitView()
	self._gorecommend = gohelper.findChild(self.viewGO, "root/left/recommendInspiration")
	self._goattritem = gohelper.findChild(self.viewGO, "root/left/recommendInspiration/#go_attrlist/#go_attritem")
	self._txtvalue = gohelper.findChildTextMesh(self.viewGO, "root/right/bottom/#txt_value")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/bottom/#btn_ok")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/bottom/#btn_notok")
	self._btnsort = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/top/#btn_quality")
	self._transarrow = gohelper.findChild(self.viewGO, "root/right/top/#btn_quality/txt/arrow").transform
	self._scroll = gohelper.findChild(self.viewGO, "root/right/#scroll_cardlist")
	self._goleftinfo = gohelper.findChild(self.viewGO, "root/left/sodache_cardinfoleft")
	self._goempty = gohelper.findChild(self.viewGO, "root/left/#go_empty")
	self._godices = gohelper.findChild(self.viewGO, "root/left/#go_dices")
	self._godice = gohelper.findChild(self.viewGO, "root/left/#go_dices")
end

function SodacheCardQuickSelectView:addEvents()
	self._btnok:AddClickListener(self._onConfirmClick, self)
	self._btncancel:AddClickListener(self.closeThis, self)
	self._btnsort:AddClickListener(self._onClickSort, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnClickCardQuickSelectItem, self._onClickItem, self)
end

function SodacheCardQuickSelectView:removeEvents()
	self._btnok:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btnsort:RemoveClickListener()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnClickCardQuickSelectItem, self._onClickItem, self)
end

function SodacheCardQuickSelectView:onOpen()
	self._diceComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._godice, SodacheCheckDicePart)
	self._cardInfo = MonoHelper.addNoUpdateLuaComOnceToGo(self._goleftinfo, SodacheQuickSelectCardInfoLeft)

	self._cardInfo:setNoShowPassive()

	self._isColorDec = true
	self._attrRestraintIcons = self:getUserDataTb_()
	self.mo = self.viewParam
	self._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(self._scroll, SurvivalSimpleListPart)

	self._simpleList:setCellCls(SodacheCardQuickSelectItem)
	self._simpleList:setCellParam(self.mo)
	self:refreshRecommend()
	self:refreshItems()
	self:refreshCount()
	self:refreshDices()

	local curItem

	if self.curSelectItem then
		local count = self.mo:getItemSelectCount(self.curSelectItem.serverMo.configId)

		if count > 0 then
			curItem = self.curSelectItem
		end
	end

	if curItem then
		self._cardInfo:setData(curItem)
		gohelper.setActive(self._goempty, false)
		gohelper.setActive(self._goleftinfo, true)
	else
		gohelper.setActive(self._goleftinfo, false)
		gohelper.setActive(self._goempty, true)
	end

	self:updateRestraintIcon(curItem)
end

function SodacheCardQuickSelectView:_onClickSort()
	self._isColorDec = not self._isColorDec

	self:refreshItems()
end

local temp

function SodacheCardQuickSelectView:refreshItems()
	transformhelper.setLocalScale(self._transarrow, 1, self._isColorDec and -1 or 1, 1)

	local allShowItems = self.mo.canSelectCards

	temp = self

	table.sort(allShowItems, self.sortFunc)

	temp = nil
	self.curSelectItem = allShowItems[1]
	self.allItems = allShowItems

	self._simpleList:setList(allShowItems)
end

function SodacheCardQuickSelectView.sortFunc(a, b)
	local self = temp

	if self.mo:getItemSelectCount(a.serverMo.configId) > 0 ~= (self.mo:getItemSelectCount(b.serverMo.configId) > 0) then
		return self.mo:getItemSelectCount(a.serverMo.configId) > 0
	end

	if a.serverMo.itemCo.quality ~= b.serverMo.itemCo.quality then
		if self._isColorDec then
			return a.serverMo.itemCo.quality > b.serverMo.itemCo.quality
		else
			return a.serverMo.itemCo.quality < b.serverMo.itemCo.quality
		end
	end

	return a.serverMo.configId < b.serverMo.configId
end

function SodacheCardQuickSelectView:_onClickItem(cardMo, isAdd)
	if self.mo.isMultSelect or isAdd then
		self._cardInfo:setData(cardMo)
		self:updateRestraintIcon(cardMo)
		gohelper.setActive(self._goempty, false)
		gohelper.setActive(self._goleftinfo, true)
	else
		gohelper.setActive(self._goempty, true)
		gohelper.setActive(self._goleftinfo, false)
		self:updateRestraintIcon()
	end

	self:refreshCount()
end

function SodacheCardQuickSelectView:updateRestraintIcon(cardMo)
	if cardMo then
		local dict = cardMo.serverMo:getRefrainDict() or {}

		for i, v in pairs(self._attrRestraintIcons) do
			if dict[i] then
				gohelper.setActive(v, true)
			else
				gohelper.setActive(v, false)
			end
		end
	else
		for i, v in pairs(self._attrRestraintIcons) do
			gohelper.setActive(v, false)
		end
	end
end

function SodacheCardQuickSelectView:refreshCount()
	self._txtvalue.text = self.mo.isMultSelect and GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("sodache_cardquickselectview_count"), self.mo.selectCount, self.mo.totalSelectCount) or ""
end

function SodacheCardQuickSelectView:refreshRecommend()
	gohelper.setActive(self._gorecommend, self.mo.recommendList ~= nil)

	if self.mo.recommendList then
		gohelper.CreateObjList(self, self._createCareerIcon, self.mo.recommendList, nil, self._goattritem)
	end
end

function SodacheCardQuickSelectView:refreshDices()
	if not self.mo.choiceCo then
		gohelper.setActive(self._godices, false)

		return
	end

	gohelper.setActive(self._godices, true)
	self._diceComp:updateDices(self.mo.choiceCo.verifyCond)
end

function SodacheCardQuickSelectView:_createCareerIcon(obj, data, index)
	local restraint = gohelper.findChild(obj, "#go_kezhi")
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)

	self._attrRestraintIcons[data] = restraint
end

function SodacheCardQuickSelectView:_onConfirmClick()
	if self.mo.selectCallback and self.mo.selectCallback(self.mo.selectCallobj, self.mo.selectCards) then
		return
	end

	self:closeThis()
end

return SodacheCardQuickSelectView
