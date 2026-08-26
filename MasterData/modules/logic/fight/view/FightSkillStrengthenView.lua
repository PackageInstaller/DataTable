-- chunkname: @modules/logic/fight/view/FightSkillStrengthenView.lua

module("modules.logic.fight.view.FightSkillStrengthenView", package.seeall)

local FightSkillStrengthenView = class("FightSkillStrengthenView", BaseViewExtended)

function FightSkillStrengthenView:onInitView()
	self._btnObj = gohelper.findChild(self.viewGO, "#btn_Strenthen")
	self._btnConfirm = gohelper.getClickWithDefaultAudio(self._btnObj)
	self._scrollViewObj = gohelper.findChild(self.viewGO, "#scroll_handcards")
	self._cardRoot = gohelper.findChild(self.viewGO, "#scroll_handcards/Viewport/handcards")
	self._cardItem = gohelper.findChild(self.viewGO, "#scroll_handcards/Viewport/handcards/#go_item")
	self._nameText = gohelper.findChildText(self.viewGO, "CheckPoint/txt_CheckPointName")
	self._desText = gohelper.findChildText(self.viewGO, "CheckPoint/Scroll View/Viewport/#txt_Descr")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightSkillStrengthenView:addEvents()
	self.addClickCb(self, self._btnConfirm, self._onBtnConfirm, self)
	FightController.instance:registerCallback(FightEvent.StartPlayClothSkill, self._onStartPlayClothSkill, self)
	FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail, self)
end

function FightSkillStrengthenView:removeEvents()
	FightController.instance:unregisterCallback(FightEvent.StartPlayClothSkill, self._onStartPlayClothSkill, self)
	FightController.instance:unregisterCallback(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail, self)
end

function FightSkillStrengthenView:_editableInitView()
	return
end

function FightSkillStrengthenView:_onStartPlayClothSkill()
	self:closeThis()
end

function FightSkillStrengthenView:_onRespUseClothSkillFail()
	self:closeThis()
end

function FightSkillStrengthenView:_onBtnConfirm()
	if self._confirmed then
		return
	end

	self._confirmed = true

	local optionId = self._optionIdList[self._curSelectIndex]

	FightRpc.instance:sendUseClothSkillRequest(self._upgradeId, self._entityId, optionId, FightEnum.ClothSkillType.HeroUpgrade)
end

function FightSkillStrengthenView.sort(item1, item2)
	return item1 < item2
end

function FightSkillStrengthenView:_onBtnEsc()
	return
end

function FightSkillStrengthenView:onOpen()
	NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._onBtnEsc, self)

	local data = table.remove(self.viewParam, 1)

	if data then
		self._upgradeId = data.id
		self._entityId = data.entityId
		self._optionIdList = data.optionIds

		self:_refreshUI()
	else
		self:closeThis()
	end
end

function FightSkillStrengthenView:_refreshUI()
	local cardPath = "ui/viewres/fight/fightcarditem.prefab"

	self:com_loadAsset(cardPath, self._onLoadFinish)
end

function FightSkillStrengthenView:_onLoadFinish(loader)
	self._cardWidth = 180
	self._halfCardWidth = self._cardWidth / 2
	self._cardDistance = self._cardWidth + 40
	self._scrollWidth = recthelper.getWidth(self._scrollViewObj.transform)
	self._halfScrollWidth = self._scrollWidth / 2

	local tarPrefab = loader:GetResource()

	gohelper.clone(tarPrefab, gohelper.findChild(self._cardItem, "#go_carditem"), "card")

	self._posX = #self._optionIdList > 5 and 120 or -self._halfScrollWidth - (#self._optionIdList - 1) * self._cardDistance / 2
	self._cardObjList = self:getUserDataTb_()
	self._skillList = {}

	self:com_createObjList(self._onItemShow, self._optionIdList, self._cardRoot, self._cardItem)
	recthelper.setWidth(self._cardRoot.transform, -self._posX - self._halfCardWidth + self._cardDistance)
	self:_onCardClick(1)
end

function FightSkillStrengthenView:_onItemShow(obj, data, index)
	local config = lua_hero_upgrade_options.configDict[data]
	local skillId = config.showSkillId

	self._skillList[index] = skillId

	if not skillId then
		gohelper.setActive(obj, false)

		return
	end

	local transform = obj.transform

	transform.anchorMin = Vector2.New(1, 0.5)
	transform.anchorMax = Vector2.New(1, 0.5)

	recthelper.setAnchorX(transform, self._posX)

	self._posX = self._posX + self._cardDistance

	local cardObj = gohelper.findChild(obj, "#go_carditem/card")
	local class = MonoHelper.addNoUpdateLuaComOnceToGo(cardObj, FightViewCardItem)

	class:updateItem(self._entityId, skillId)

	local click = gohelper.getClickWithDefaultAudio(obj)

	self.addClickCb(self, click, self._onCardClick, self, index)
	table.insert(self._cardObjList, obj)
end

function FightSkillStrengthenView:_onCardClick(index)
	if self._curSelectIndex == index then
		return
	end

	self._curSelectIndex = index

	for i, v in ipairs(self._cardObjList) do
		local frame = gohelper.findChild(v, "#go_Frame")

		gohelper.setActive(frame, i == self._curSelectIndex)
	end

	self:_showSkillDes()

	local cardObj = self._cardObjList[index]
	local cardTransform = cardObj.transform
	local relativePosX = recthelper.rectToRelativeAnchorPos(cardTransform.position, self._scrollViewObj.transform).x
	local minX = relativePosX - self._halfCardWidth
	local maxX = relativePosX + self._halfCardWidth

	if minX < -self._halfScrollWidth then
		local offset = minX + self._halfScrollWidth

		recthelper.setAnchorX(self._cardRoot.transform, recthelper.getAnchorX(self._cardRoot.transform) - offset + 20)
	end

	if maxX > self._halfScrollWidth then
		local offset = maxX - self._halfScrollWidth

		recthelper.setAnchorX(self._cardRoot.transform, recthelper.getAnchorX(self._cardRoot.transform) - offset - 20)
	end
end

function FightSkillStrengthenView:_showSkillDes()
	local hero_upgradeConfig = lua_hero_upgrade.configDict[self._upgradeId]
	local optionId = self._optionIdList[self._curSelectIndex]
	local config = lua_hero_upgrade_options.configDict[optionId]

	self._nameText.text = config.title

	local desc, name = SkillConfig.instance:getExSkillDesc(config, hero_upgradeConfig.heroId)

	desc = string.gsub(desc, "▩(%d)%%s", name)
	desc = HeroSkillModel.instance:formatDescWithColor(desc)
	self._desText.text = desc
end

function FightSkillStrengthenView:onClose()
	return
end

function FightSkillStrengthenView:onDestroyView()
	return
end

return FightSkillStrengthenView
