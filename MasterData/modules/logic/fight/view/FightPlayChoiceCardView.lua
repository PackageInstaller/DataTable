-- chunkname: @modules/logic/fight/view/FightPlayChoiceCardView.lua

module("modules.logic.fight.view.FightPlayChoiceCardView", package.seeall)

local FightPlayChoiceCardView = class("FightPlayChoiceCardView", FightBaseView)

function FightPlayChoiceCardView:onInitView()
	self.maskClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "Mask")
	self.click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#btn_Coping/clickarea")
	self.gridRoot = gohelper.findChild(self.viewGO, "root/grid")
	self._scrollViewObj = gohelper.findChild(self.viewGO, "#scroll_handcards")
	self._cardRoot = gohelper.findChild(self.viewGO, "#scroll_handcards/Viewport/handcards")
	self._cardItem = gohelper.findChild(self.viewGO, "#scroll_handcards/Viewport/handcards/#go_item")
	self._nameText = gohelper.findChildText(self.viewGO, "CheckPoint/txt_CheckPointName")
	self._desText = gohelper.findChildText(self.viewGO, "CheckPoint/Scroll View/Viewport/#txt_Descr")
	self.titleText = gohelper.findChildText(self.viewGO, "Title/txt_Title")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightPlayChoiceCardView:addEvents()
	self:com_registClick(self.click, self.onBtnConfirm)
	self:com_registClick(self.maskClick, self.closeThis)
end

function FightPlayChoiceCardView:removeEvents()
	return
end

function FightPlayChoiceCardView:_editableInitView()
	return
end

function FightPlayChoiceCardView:onOpen()
	self.cardData = self.viewParam.cardData
	self.choiceConfig = self.viewParam.config
	self.callback = self.viewParam.callback
	self.handle = self.viewParam.handle
	self.entityId = self.cardData.uid

	self:com_loadAsset("ui/viewres/fight/fightcarditem.prefab", self.onCardLoaded)

	local skillConfig = lua_skill.configDict[self.cardData.skillId]

	if skillConfig then
		self.titleText.text = skillConfig.name
	end
end

function FightPlayChoiceCardView:onCardLoaded(success, loader)
	if not success then
		return
	end

	self._skillList = string.splitToNumber(self.choiceConfig.choiceSkIlls, "#")
	self._cardWidth = 180
	self._halfCardWidth = self._cardWidth / 2
	self._cardDistance = self._cardWidth + 40
	self._scrollWidth = recthelper.getWidth(self._scrollViewObj.transform)
	self._halfScrollWidth = self._scrollWidth / 2

	local tarPrefab = loader:GetResource()

	gohelper.clone(tarPrefab, gohelper.findChild(self._cardItem, "#go_carditem"), "card")

	self._posX = #self._skillList > 5 and 120 or -self._halfScrollWidth - (#self._skillList - 1) * self._cardDistance / 2
	self._cardObjList = self:getUserDataTb_()

	self:com_createObjList(self._onItemShow, self._skillList, self._cardRoot, self._cardItem)
	recthelper.setWidth(self._cardRoot.transform, -self._posX - self._halfCardWidth + self._cardDistance)
	self:_onCardClick(1)
end

function FightPlayChoiceCardView:_onItemShow(obj, data, index)
	local skillId = data
	local transform = obj.transform

	transform.anchorMin = Vector2.one
	transform.anchorMax = Vector2.one

	recthelper.setAnchorX(transform, self._posX)

	self._posX = self._posX + self._cardDistance

	local cardObj = gohelper.findChild(obj, "#go_carditem/card")
	local class = MonoHelper.addNoUpdateLuaComOnceToGo(cardObj, FightViewCardItem)

	class:updateItem(self.entityId, skillId)
	class:detectShowBlueStar()

	local click = gohelper.getClickWithDefaultAudio(obj)

	self:com_registClick(click, self._onCardClick, index)
	table.insert(self._cardObjList, obj)
end

function FightPlayChoiceCardView:_onCardClick(index)
	if self._curSelectIndex == index then
		return
	end

	self._curSelectIndex = index
	self.curSkillId = self._skillList[index]

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

function FightPlayChoiceCardView:_showSkillDes()
	local skillConfig = lua_skill.configDict[self.curSkillId]

	if not skillConfig then
		return
	end

	self._nameText.text = skillConfig.name
	self._desText.text = HeroSkillModel.instance:skillDesToSpot(FightConfig.instance:getEntitySkillDesc(self.entityId, skillConfig), "#c56131", "#7c93ad")
end

function FightPlayChoiceCardView:onBtnConfirm()
	if not self._curSelectIndex then
		self:closeThis()

		return
	end

	local skillId = self.curSkillId
	local targetId = FightDataHelper.operationDataMgr.curSelectEntityId
	local skillCO = lua_skill.configDict[skillId]
	local mySideList = FightDataHelper.entityMgr:getMyNormalList()
	local mySideSpList = FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide)
	local mySideEntityCount = #mySideList + #mySideSpList

	if skillCO and FightEnum.ShowLogicTargetView[skillCO.logicTarget] and skillCO.targetLimit == FightEnum.TargetLimit.MySide then
		if mySideEntityCount > 1 then
			ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
				fromId = self.cardData.uid,
				skillId = skillId,
				callback = self._toPlayCard,
				callbackObj = self
			})

			return
		end

		if mySideEntityCount == 1 then
			targetId = mySideList[1].id
		end
	end

	self.callback(self.handle, targetId, nil, skillId)
	self:closeThis()
end

function FightPlayChoiceCardView:_toPlayCard(entityId)
	self.callback(self.handle, entityId, nil, self.curSkillId)
	self:closeThis()
end

function FightPlayChoiceCardView:onClose()
	return
end

function FightPlayChoiceCardView:onDestroyView()
	return
end

return FightPlayChoiceCardView
