-- chunkname: @modules/logic/turnback/view/TurnbackPickEquipListItem.lua

module("modules.logic.turnback.view.TurnbackPickEquipListItem", package.seeall)

local TurnbackPickEquipListItem = class("TurnbackPickEquipListItem", ListScrollCellExtend)

function TurnbackPickEquipListItem:onInitView()
	self._goisselect = gohelper.findChild(self.viewGO, "#go_isselect")
	self._goequipitem = gohelper.findChild(self.viewGO, "#go_equipitem")
	self._txtgood = gohelper.findChildText(self.viewGO, "#txt_good")
	self._gonamelayout = gohelper.findChild(self.viewGO, "#go_namelayout")
	self._goheroname = gohelper.findChild(self.viewGO, "#go_namelayout/#txt_heroname")
	self._gonogood = gohelper.findChild(self.viewGO, "#txt_nogood")
	self._txtequipname = gohelper.findChildText(self.viewGO, "#txt_equipname")
	self._golimitmax = gohelper.findChild(self.viewGO, "#go_limitmax")
	self._goclick = gohelper.findChild(self.viewGO, "#btn_click")
	self._btnClick = gohelper.findChildButton(self.viewGO, "#btn_click")
	self._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(self._goclick)

	self._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackPickEquipListItem:addEvents()
	self._btnClick:AddClickListener(self.onClickSelf, self)
	self._btnLongPress:AddLongPressListener(self._onLongClickItem, self)
	self.addEventCb(self, TurnbackPickEquipController.instance, TurnbackEvent.onCustomPickListChanged, self.refreshSelect, self)
end

function TurnbackPickEquipListItem:removeEvents()
	self._btnClick:RemoveClickListener()
	self._btnLongPress:RemoveLongPressListener()
	self.removeEventCb(self, TurnbackPickEquipController.instance, TurnbackEvent.onCustomPickListChanged, self.refreshSelect, self)
end

function TurnbackPickEquipListItem:_editableInitView()
	gohelper.setActive(self._goheroname, false)
end

function TurnbackPickEquipListItem:_editableAddEvents()
	return
end

function TurnbackPickEquipListItem:_editableRemoveEvents()
	return
end

function TurnbackPickEquipListItem:onClickSelf()
	if EquipModel.instance:isLimitAndAlreadyHas(self._mo.id) then
		return
	end

	TurnbackPickEquipController.instance:setSelect(self._mo.index)
end

function TurnbackPickEquipListItem:_onLongClickItem()
	if not self._mo then
		return
	end

	local param = {}

	param.equipId = self._mo.id

	EquipController.instance:openEquipView(param)
end

function TurnbackPickEquipListItem:onUpdateMO(mo)
	self._mo = mo
	self._config = mo and mo.config

	self:refreshUI()
	self:refreshSelect()
end

function TurnbackPickEquipListItem:refreshUI()
	if not self._mo then
		return
	end

	self._txtequipname.text = self._config.name

	self:_refreshHeroName()
	self:_refreshEquipIcon()

	local isLimit = EquipModel.instance:isLimitAndAlreadyHas(self._mo.id)

	gohelper.setActive(self._golimitmax, isLimit)
end

function TurnbackPickEquipListItem:_refreshEquipIcon()
	self._equipIcon = self._equipIcon or IconMgr.instance:getCommonEquipIcon(self._goequipitem)

	self._equipIcon:setMOValue(self._mo.type, self._mo.id, self._mo.num)
	self._equipIcon:hideLv(true)
end

function TurnbackPickEquipListItem:_refreshHeroName()
	local heroIdStr = self._config.characterId
	local haveHero = not string.nilorempty(heroIdStr)

	gohelper.setActive(self._gonamelayout, haveHero)
	gohelper.setActive(self._txtgood.gameObject, haveHero)
	gohelper.setActive(self._gonogood, not haveHero)

	if haveHero then
		self._nameList = self._nameList or {}

		local heroIdList = string.splitToNumber(heroIdStr, "#")
		local heroCount = #heroIdList

		for i = 1, heroCount do
			local nameitem = self._nameList[i]

			if not nameitem then
				nameitem = self:getUserDataTb_()
				nameitem.go = gohelper.clone(self._goheroname, self._gonamelayout, "name" .. i)
				nameitem.txt = nameitem.go:GetComponent(gohelper.Type_TextMesh)

				table.insert(self._nameList, nameitem)
			end

			gohelper.setActive(nameitem.go, true)

			local heroId = heroIdList[i]
			local heroCo = HeroConfig.instance:getHeroCO(heroId)

			nameitem.txt.text = heroCo.name
		end

		if heroCount > 0 and heroCount < #self._nameList then
			for i = #self._nameList, heroCount + 1, -1 do
				local nameitem = self._nameList[i]

				gohelper.setActive(nameitem.go, false)
			end
		end
	end
end

function TurnbackPickEquipListItem:refreshSelect()
	local isSelect = TurnbackPickEquipListModel.instance:isEquipIdSelected(self._mo.index)

	gohelper.setActive(self._goisselect, isSelect)
end

function TurnbackPickEquipListItem:onSelect(isSelect)
	return
end

function TurnbackPickEquipListItem:onDestroyView()
	return
end

return TurnbackPickEquipListItem
