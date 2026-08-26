-- chunkname: @modules/logic/fight/view/FightCardPreDisPlayView.lua

module("modules.logic.fight.view.FightCardPreDisPlayView", package.seeall)

local FightCardPreDisPlayView = class("FightCardPreDisPlayView", BaseViewExtended)

function FightCardPreDisPlayView:onInitView()
	self._viewClick = gohelper.getClickWithDefaultAudio(self.viewGO)
	self._scrollViewObj = gohelper.findChild(self.viewGO, "#scroll_handcards")
	self._cardRoot = gohelper.findChild(self.viewGO, "#scroll_handcards/Viewport/handcards")
	self._skillRoot = gohelper.findChild(self.viewGO, "Skill")
	self._skillNameText = gohelper.findChildText(self.viewGO, "Skill/#txt_SkillName")
	self._skillDesText = gohelper.findChildText(self.viewGO, "Skill/Scroll View/Viewport/#txt_SkillDescr")
	self._imageSkillBg = gohelper.findChild(self.viewGO, "Skill/image_SkillBG")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightCardPreDisPlayView:addEvents()
	self.addClickCb(self, self._viewClick, self._onBtnClose, self)
end

function FightCardPreDisPlayView:removeEvents()
	return
end

function FightCardPreDisPlayView:_editableInitView()
	return
end

function FightCardPreDisPlayView:_onBtnClose()
	if self._showSkillDesPart then
		self:_cancelSelect()

		return
	end

	self:closeThis()
end

function FightCardPreDisPlayView:onOpen()
	self._anchor = Vector2.New(1, 0.5)

	gohelper.setActive(self._skillRoot, false)
	NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._onBtnClose, self)

	self._cardDataList = self.viewParam

	self:_refreshUI()
end

function FightCardPreDisPlayView:_refreshUI()
	local cardPath = "ui/viewres/fight/fightcarditem.prefab"

	self:com_loadAsset(cardPath, self._onLoadFinish)
end

function FightCardPreDisPlayView:_onLoadFinish(loader)
	self._cardWidth = 180
	self._halfCardWidth = self._cardWidth / 2
	self._cardDistance = self._cardWidth + 40
	self._scrollWidth = recthelper.getWidth(self._scrollViewObj.transform)
	self._halfScrollWidth = self._scrollWidth / 2

	local tarPrefab = loader:GetResource()

	self._posX = #self._cardDataList > 5 and -120 or -self._halfScrollWidth + (#self._cardDataList - 1) * self._cardDistance / 2
	self._cardObjList = self:getUserDataTb_()

	self:com_createObjList(self._onItemShow, self._cardDataList, self._cardRoot, tarPrefab)
	recthelper.setWidth(self._cardRoot.transform, -self._posX - self._halfCardWidth)
end

function FightCardPreDisPlayView:_onItemShow(obj, data, index)
	local transform = obj.transform

	transform.anchorMin = self._anchor
	transform.anchorMax = self._anchor

	recthelper.setAnchorX(transform, self._posX)

	self._posX = self._posX - self._cardDistance

	local class = MonoHelper.addNoUpdateLuaComOnceToGo(obj, FightViewCardItem)

	class:updateItem(data.uid, data.skillId, data)

	local click = gohelper.getClickWithDefaultAudio(obj)

	self.addClickCb(self, click, self._onCardClick, self, index)
	table.insert(self._cardObjList, obj)
end

function FightCardPreDisPlayView:_onCardClick(index)
	if self._curSelectIndex == index then
		return
	end

	self:_releaseTween()

	if self._curSelectIndex then
		self:_cancelSelect()
	end

	self._showSkillDesPart = true

	gohelper.setActive(self._skillRoot, true)

	self._curSelectIndex = index
	self._curSelectCardInfo = self._cardDataList[index]

	self:_showSkillDes()

	local cardObj = self._cardObjList[index]
	local cardTransform = cardObj.transform

	table.insert(self._tween, ZProj.TweenHelper.DOAnchorPosY(cardTransform, 27, 0.1))
	table.insert(self._tween, ZProj.TweenHelper.DOScale(cardTransform, 1.2, 1.2, 1, 0.1))

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

function FightCardPreDisPlayView:_releaseTween()
	if self._tween then
		for i, v in ipairs(self._tween) do
			ZProj.TweenHelper.KillById(v)
		end
	end

	self._tween = {}
end

function FightCardPreDisPlayView:_cancelSelect()
	if self._curSelectIndex then
		gohelper.setActive(self._skillRoot, false)
		self:_releaseTween()
		table.insert(self._tween, ZProj.TweenHelper.DOAnchorPosY(self._cardObjList[self._curSelectIndex].transform, 0, 0.1))
		table.insert(self._tween, ZProj.TweenHelper.DOScale(self._cardObjList[self._curSelectIndex].transform, 1, 1, 1, 0.1))

		self._curSelectIndex = nil
		self._showSkillDesPart = false
	end
end

function FightCardPreDisPlayView:_showSkillDes()
	local skillConfig = lua_skill.configDict[self._curSelectCardInfo.skillId]

	self._skillNameText.text = skillConfig.name
	self._skillDesText.text = FightConfig.instance:getEntitySkillDesc(self._curSelectCardInfo.uid, skillConfig)

	local textHeight = self._skillDesText.preferredHeight

	if textHeight > 80 then
		recthelper.setHeight(self._imageSkillBg.transform, 270)
	else
		recthelper.setHeight(self._imageSkillBg.transform, 200)
	end
end

function FightCardPreDisPlayView:onClose()
	self:_releaseTween()
end

function FightCardPreDisPlayView:onDestroyView()
	return
end

return FightCardPreDisPlayView
