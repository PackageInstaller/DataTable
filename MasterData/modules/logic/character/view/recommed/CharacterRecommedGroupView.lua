-- chunkname: @modules/logic/character/view/recommed/CharacterRecommedGroupView.lua

module("modules.logic.character.view.recommed.CharacterRecommedGroupView", package.seeall)

local CharacterRecommedGroupView = class("CharacterRecommedGroupView", BaseView)
local MaxScrollHeight = 602

function CharacterRecommedGroupView:onInitView()
	self._gogroup = gohelper.findChild(self.viewGO, "content/group")
	self._layoutElement = self._gogroup:GetComponent(typeof(UnityEngine.UI.LayoutElement))
	self._goContent = gohelper.findChild(self.viewGO, "content/group/#scroll_group/Viewport/Content")
	self._imagegroupicon = gohelper.findChildImage(self.viewGO, "content/group/title/icon")
	self._scrollgroup = gohelper.findChildScrollRect(self.viewGO, "content/group/#scroll_group")
	self._goequip = gohelper.findChild(self.viewGO, "content/equip")
	self._imageequipicon = gohelper.findChildImage(self.viewGO, "content/equip/title/icon")
	self._scrollequip = gohelper.findChildScrollRect(self.viewGO, "content/equip/#scroll_equip")
	self._godragcontainer = gohelper.findChild(self.viewGO, "#go_dragcontainer")
	self._goviewport = gohelper.findChild(self.viewGO, "content/group/#scroll_group/Viewport")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterRecommedGroupView:addEvents()
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnCutHeroAnimCB, self._refreshHero, self)
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnReplaceTeam, self._onReplaceTeam, self)
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnBeginDragHeroIcon, self._onBeginDragHeroIcon, self)
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnDragHeroIcon, self._onDragHeroIcon, self)
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnEndDragHeroIcon, self._onEndDragHeroIcon, self)
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.RegisterHeroIcon, self._onRegisterHeroIcon, self)

	self._scrollDragComp = UIDragListenerHelper.New()

	self._scrollDragComp:createByScrollRect(self._scrollgroup)
end

function CharacterRecommedGroupView:removeEvents()
	self._scrollDragComp:onDestroyView()
	self.removeEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnCutHeroAnimCB, self._refreshHero, self)
end

function CharacterRecommedGroupView:_editableInitView()
	self._tranviewport = self._goviewport.transform
	self._trancontent = self._goContent.transform

	local goDragItem = self.viewContainer:getHeroIconRes()

	self._goDragItem = gohelper.clone(goDragItem, self._godragcontainer, "dragItem_1")
	self._dragItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._goDragItem, CharacterRecommedHeroIcon)
	self._trandragcontainer = self._godragcontainer.transform
	self._tranDragItem = self._goDragItem.transform
	self._halfDragItemWidth = recthelper.getWidth(self._tranDragItem) / 2
	self._halfDragItemHeight = recthelper.getHeight(self._tranDragItem) / 2
	self._goDragItem2 = gohelper.clone(goDragItem, self._godragcontainer, "dragItem_2")
	self._dragItem2 = MonoHelper.addNoUpdateLuaComOnceToGo(self._goDragItem2, CharacterRecommedHeroIcon)

	gohelper.setActive(self._goDragItem, false)
	gohelper.setActive(self._goDragItem2, false)

	self._goGroupList = self._scrollgroup.gameObject
	self._heroItemTab = {}
end

function CharacterRecommedGroupView:onUpdateParam()
	return
end

function CharacterRecommedGroupView:onOpen()
	self:_refreshHero(self.viewParam.heroId)
	self:playViewAnim(CharacterRecommedEnum.AnimName.Open, 0, 0)

	if self._groupItems then
		for _, item in ipairs(self._groupItems) do
			item:playViewAnim(CharacterRecommedEnum.AnimName.Open, 0, 0)
		end
	end
end

function CharacterRecommedGroupView:_refreshHero(heroId)
	if self.heroId and heroId == self.heroId then
		return
	end

	self.heroId = heroId
	self._heroRecommendMO = CharacterRecommedModel.instance:getHeroRecommendMo(heroId)

	CharacterRecommedModel.instance:checkHeroMainTeam(self.heroId)

	local isShowTeam = self._heroRecommendMO:isShowTeam()
	local isShowEquip = self._heroRecommendMO:isShowEquip()

	if isShowTeam then
		self:_refreshGroup()
		self:_onHeightChange()
	end

	if isShowEquip then
		self:_refreshEquip()
	end

	gohelper.setActive(self._gogroup, isShowTeam)
	gohelper.setActive(self._goequip, isShowEquip)
end

function CharacterRecommedGroupView:_onHeightChange(groupItem, expand)
	TaskDispatcher.cancelTask(self._updateContentHeight, self)
	TaskDispatcher.runDelay(self._updateContentHeight, self, 0.01)

	if expand then
		self._expandGroupItem = groupItem

		TaskDispatcher.cancelTask(self._tryMoveGroupItemCenter, self)
		TaskDispatcher.runDelay(self._tryMoveGroupItemCenter, self, 0.1)
	end
end

function CharacterRecommedGroupView:_updateContentHeight()
	ZProj.UGUIHelper.RebuildLayout(self._goContent.transform)

	self._layoutElement.minHeight = math.min(MaxScrollHeight, recthelper.getHeight(self._goContent.transform))
end

function CharacterRecommedGroupView:_tryMoveGroupItemCenter()
	if not self._expandGroupItem then
		return
	end

	local worldCorners = self._expandGroupItem.transform:GetWorldCorners()
	local bottomRight = recthelper.rectToRelativeAnchorPos(worldCorners[3], self._tranviewport)
	local viewportHeight = recthelper.getHeight(self._tranviewport)
	local outHeight = math.abs(bottomRight.y) - viewportHeight

	if outHeight > 0 then
		UIBlockHelper.instance:startBlock(self.viewName, CharacterRecommedEnum.GroupTweenDuration, self.viewName)

		local contentPosY = recthelper.getAnchorY(self._trancontent)
		local targetPosY = contentPosY + outHeight

		self._focusTweenId = ZProj.TweenHelper.DOAnchorPosY(self._trancontent, targetPosY, CharacterRecommedEnum.GroupTweenDuration)
	end
end

function CharacterRecommedGroupView:_refreshGroup()
	if not self._heroRecommendMO then
		return
	end

	local moList = self._heroRecommendMO.teamRec

	if moList then
		self._goGroupItem = self._goGroupItem or self.viewContainer:getGroupItemRes()
		self._groupItems = {}

		gohelper.CreateObjList(self, self._groupItemCB, moList, self._scrollgroup.content.gameObject, self._goGroupItem, CharacterRecommedGroupItem)
	end
end

function CharacterRecommedGroupView:_groupItemCB(obj, data, index)
	obj:onUpdateMO(data, self.viewContainer, self._heroRecommendMO, self.heroId)
	obj:setHeightChangeCallback(self._onHeightChange, self)
	obj:setIndex(index)

	if self.viewParam.fromView then
		local isFormCharacterView = self.viewParam.fromView == ViewName.CharacterView

		if self.viewParam.fromView then
			local isFromTeachingView = not (self.viewParam.fromView ~= ViewName.TeachingMainView or self.viewParam.hideTab ~= nil)

			obj:showUseBtn(isFormCharacterView or isFromTeachingView)

			self._groupItems[index] = obj
		end
	end
end

function CharacterRecommedGroupView:_refreshEquip()
	if not self._heroRecommendMO then
		return
	end

	self._goequipicon = self._goequipicon or self.viewContainer:getEquipIconRes()

	local moList = self._heroRecommendMO.equipRec

	if moList then
		gohelper.CreateObjList(self, self._equipItemCB, moList, self._scrollequip.content.gameObject, self._goequipicon, CharacterRecommedEquipIcon)
	end
end

function CharacterRecommedGroupView:_equipItemCB(obj, data, index)
	obj:onUpdateMO(data)
	obj:setClickCallback(function()
		EquipController.instance:openEquipView({
			equipId = data
		})
	end, self)
end

function CharacterRecommedGroupView:playViewAnim(animName, layer, normalizedTime)
	self._viewAnim = self._viewAnim or self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._viewAnim then
		self._viewAnim:Play(animName, layer, normalizedTime)
	end
end

function CharacterRecommedGroupView:_onReplaceTeam()
	self:_refreshGroup()
end

function CharacterRecommedGroupView:_onRegisterHeroIcon(heroItem)
	if not heroItem then
		return
	end

	self._heroItemTab[heroItem] = true
end

function CharacterRecommedGroupView:_onBeginDragHeroIcon(sourceItem)
	GameUtil.setActiveUIBlock(self.viewName, true, false)
	self:_refreshDragItem(sourceItem)
end

function CharacterRecommedGroupView:_onDragHeroIcon(sourceItem)
	self:_refreshDragItem(sourceItem)
end

function CharacterRecommedGroupView:_onEndDragHeroIcon(sourceItem)
	GameUtil.setActiveUIBlock(self.viewName, false, true)
	UIBlockHelper.instance:startBlock(self.viewName, CharacterRecommedEnum.HeroIconTweenDuration, self.viewName)

	self._sourceItem = sourceItem
	self._targetItem = self:_calcReplaceTeamIndex(sourceItem)

	if not self._sourceItem or not self._targetItem then
		GameFacade.showToast(ToastEnum.CharacterRecommedReplaceError)

		self._errorTweenId = self._tweenItem2TargetPos(self, self._dragItem, sourceItem, self._onDragItemErrorCallback, self)

		return
	end

	self:_initTargetReplaceItem()
	self:_tweenItem2TargetPos(self._dragItem2, sourceItem)

	self._replaceTweenId = self._tweenItem2TargetPos(self, self._dragItem, self._targetItem, self._onDragItemSuccessCallback, self)
end

function CharacterRecommedGroupView:_initTargetReplaceItem()
	gohelper.setActive(self._goDragItem2, true)

	local _, _, _, heroMo = self._targetItem:getData()

	self._dragItem2:onUpdateMO(heroMo)

	local targetPos = recthelper.rectToRelativeAnchorPos(self._targetItem.transform.position, self._trandragcontainer)

	recthelper.setAnchor(self._dragItem2.transform, targetPos.x, targetPos.y)
end

function CharacterRecommedGroupView:_tweenItem2TargetPos(sourceItem, targetItem, callback, callbackObj)
	local duration = CharacterRecommedEnum.HeroIconTweenDuration
	local targetPos = recthelper.rectToRelativeAnchorPos(targetItem.transform.position, self._trandragcontainer)

	return ZProj.TweenHelper.DOAnchorPos(sourceItem.transform, targetPos.x, targetPos.y, duration, callback, callbackObj)
end

function CharacterRecommedGroupView:_onDragItemErrorCallback()
	gohelper.setActive(self._goDragItem, false)
	gohelper.setActive(self._goDragItem2, false)
	UIBlockHelper.instance:endBlock(self.viewName)
end

function CharacterRecommedGroupView:_onDragItemSuccessCallback()
	gohelper.setActive(self._goDragItem, false)
	gohelper.setActive(self._goDragItem2, false)
	UIBlockHelper.instance:endBlock(self.viewName)

	local originTeamId, originTeamIndex = self._sourceItem:getData()
	local _, nextTeamIndex, nextPosIndex = self._targetItem:getData()

	CharacterRecommedModel.instance:swapTeamHero(originTeamId, originTeamIndex, nextTeamIndex, nextPosIndex)
end

function CharacterRecommedGroupView:_refreshDragItem(sourceItem)
	gohelper.setActive(self._goDragItem, true)

	local position = GamepadController.instance:getMousePosition()
	local rectPosX, rectPosY = recthelper.screenPosToAnchorPos2(position, self._trandragcontainer)

	recthelper.setAnchor(self._tranDragItem, rectPosX, rectPosY)

	local _, _, _, heroMo = sourceItem:getData()

	self._dragItem:onUpdateMO(heroMo)
end

function CharacterRecommedGroupView:_calcReplaceTeamIndex(originItem)
	local screenPos = GamepadController.instance:getMousePosition()

	for heroItem in pairs(self._heroItemTab) do
		if heroItem ~= originItem and heroItem.viewGO.activeInHierarchy then
			local posX, posY = recthelper.screenPosToAnchorPos2(screenPos, heroItem.transform)

			if math.abs(posX) <= self._halfDragItemWidth and math.abs(posY) <= self._halfDragItemHeight then
				local originTeamId, originTeamIndex, originPosIndex = originItem:getData()
				local nextTeamId, nextTeamIndex, nextPosIndex = heroItem:getData()

				if originTeamId == nextTeamId and originPosIndex == nextPosIndex and originTeamIndex ~= nextTeamIndex then
					return heroItem
				end
			end
		end
	end
end

function CharacterRecommedGroupView:getScrollList()
	return self._goGroupList
end

function CharacterRecommedGroupView:getScrollDragComp()
	return self._scrollDragComp
end

function CharacterRecommedGroupView:onClose()
	UIBlockHelper.instance:endBlock(self.viewName)
	TaskDispatcher.cancelTask(self._tryMoveGroupItemCenter, self)
	TaskDispatcher.cancelTask(self._updateContentHeight, self)
	GameUtil.onDestroyViewMember_TweenId(self, "_focusTweenId")
	GameUtil.onDestroyViewMember_TweenId(self, "_errorTweenId")
	GameUtil.onDestroyViewMember_TweenId(self, "_replaceTweenId")
end

function CharacterRecommedGroupView:onDestroyView()
	return
end

return CharacterRecommedGroupView
