-- chunkname: @modules/logic/rouge2/map/map/itemcomp/Rouge2_MapNodeIconItem.lua

module("modules.logic.rouge2.map.map.itemcomp.Rouge2_MapNodeIconItem", package.seeall)

local Rouge2_MapNodeIconItem = class("Rouge2_MapNodeIconItem", LuaCompBase)

function Rouge2_MapNodeIconItem:ctor(tranHeadContainer)
	self._tranHeadContainer = tranHeadContainer
end

function Rouge2_MapNodeIconItem:init(go)
	self.go = go
	self._goRoot = gohelper.findChild(self.go, "#go_Root")
	self._imageChessBg = gohelper.findChildImage(self.go, "#go_Root/#image_chessbg")
	self._goSelectLight = gohelper.findChild(self.go, "#go_Root/#layer_selectlight")
	self._goNormalSelectLight = gohelper.findChild(self.go, "#go_Root/#layer_selectlight/selectlight1")
	self._goHardSelectLight = gohelper.findChild(self.go, "#go_Root/#layer_selectlight/selectlight2")
	self._goBubble = gohelper.findChild(self.go, "#go_Root/Bubble")
	self._imageIconBg = gohelper.findChildImage(self.go, "#go_Root/Bubble/#image_iconbg")
	self._imageIcon = gohelper.findChildImage(self.go, "#go_Root/Bubble/#image_icon")
	self._goFinish = gohelper.findChild(self.go, "#go_Root/Bubble/#go_finish")
	self._goLock = gohelper.findChild(self.go, "#go_Root/Bubble/#go_lock")
	self._goUnfinish = gohelper.findChild(self.go, "#go_Root/Bubble/#go_unfinish")
	self._goName = gohelper.findChild(self.go, "#go_Root/Bubble/namebg")
	self._txtName = gohelper.findChildText(self.go, "#go_Root/Bubble/namebg/#txt_name")
	self._goAttrList = gohelper.findChild(self.go, "#go_Root/Bubble/#go_attrlist")
	self._goAttrItem = gohelper.findChild(self.go, "#go_Root/Bubble/#go_attrlist/#go_attr")
	self._goLine = gohelper.findChild(self.go, "#go_Root/Bubble/line")
	self._goRecommend = gohelper.findChild(self.go, "#go_Root/Bubble/#go_Recommand_light")
	self._iconCanvasGroup = gohelper.onceAddComponent(self._imageIcon.gameObject, gohelper.Type_CanvasGroup)
	self._iconBgCanvasGroup = gohelper.onceAddComponent(self._imageIconBg.gameObject, gohelper.Type_CanvasGroup)
	self._lineCanvasGroup = gohelper.onceAddComponent(self._goLine, gohelper.Type_CanvasGroup)
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)

	gohelper.setActive(self.go, true)
end

function Rouge2_MapNodeIconItem:addEventListeners()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Rouge2_MapNodeIconItem:removeEventListeners()
	return
end

function Rouge2_MapNodeIconItem:onUpdateMO(nodeMo, mapItem)
	self:refreshInfo(nodeMo, mapItem)
	self:refreshUI()
	self:updatePos()
end

function Rouge2_MapNodeIconItem:updatePos()
	if not self._mapItem then
		return
	end

	local scenePos = self._mapItem:getScenePos()
	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiPosX, uiPosY = recthelper.worldPosToAnchorPos2(scenePos, self._tranHeadContainer, mainCamera, mainCamera)

	recthelper.setAnchor(self._goRoot.transform, uiPosX, uiPosY)
end

function Rouge2_MapNodeIconItem:getIconGO()
	return self._goRoot
end

function Rouge2_MapNodeIconItem:refreshInfo(nodeMo, mapItem)
	self._nodeMo = nodeMo
	self._mapItem = mapItem
	self._isSelect = mapItem.select
	self._arriveStatus = self._mapItem:getArriveStatus()
	self._isNormal = self._nodeMo:checkIsNormal()
	self._state = self._nodeMo:getEventState()
	self._eventCo = self._nodeMo:getEventCo()
	self._eventType = self._eventCo and self._eventCo.type
	self._layerId = self._nodeMo.layer
	self._nodeId = self._nodeMo.nodeId
	self._isLock = self._arriveStatus == Rouge2_MapEnum.Arrive.NotArrive or self._arriveStatus == Rouge2_MapEnum.Arrive.CantArrive
	self._isFinish = self._state == Rouge2_MapEnum.EventState.Finish
end

function Rouge2_MapNodeIconItem:refreshUI()
	gohelper.setActive(self._goBubble, self._isNormal)

	if not self._isNormal then
		gohelper.setActive(self._goSelectLight, false)

		local iconName = self._isLock and "rouge2_map_chessgreybg" or "rouge2_map_chessbg_1"

		UISpriteSetMgr.instance:setRouge6Sprite(self._imageChessBg, iconName)

		return
	end

	gohelper.setActive(self._goFinish, self._isFinish)
	gohelper.setActive(self._goUnfinish, self._arriveStatus == Rouge2_MapEnum.Arrive.CanArrive or self._arriveStatus == Rouge2_MapEnum.Arrive.ArrivingNotFinish)
	gohelper.setActive(self._goLock, self._isLock)
	self:refreshIcon()
	self:refreshRecommend()
	self:refreshSelect()
	self:refreshNodeName()
	self:refreshNodeAttr()
	self:playIconAnim()
end

function Rouge2_MapNodeIconItem:refreshIcon()
	local iconBottomBg = Rouge2_MapNodeIconHelper.getNodeIconBottomBg(self._eventType, self._arriveStatus)

	UISpriteSetMgr.instance:setRouge6Sprite(self._imageChessBg, iconBottomBg, true)

	local bubbleIconBg = Rouge2_MapNodeIconHelper.getNodeIconBubbleBg(self._eventType, self._arriveStatus)

	UISpriteSetMgr.instance:setRouge6Sprite(self._imageIconBg, bubbleIconBg, true)

	local icon = Rouge2_MapNodeIconHelper.getNodeIcon(self._eventType, self._arriveStatus)

	UISpriteSetMgr.instance:setRouge6Sprite(self._imageIcon, icon, true)
	ZProj.UGUIHelper.SetGrayFactor(self._imageIcon.gameObject, self._isLock and 1 or 0)

	local iconBgColor = "#FFFFFF"
	local iconBgAlpha = 1

	if self._arriveStatus == Rouge2_MapEnum.Arrive.CantArrive then
		iconBgColor = "#6F6F6F"
		iconBgAlpha = 0.39
	end

	self._iconBgCanvasGroup.alpha = iconBgAlpha
	self._lineCanvasGroup.alpha = iconBgAlpha

	SLFramework.UGUI.GuiHelper.SetColor(self._imageIconBg, iconBgColor)

	local iconColor = "#FFFFFF"
	local iconAlpha = 1

	if self._isFinish then
		iconColor = "#989898"
	elseif self._arriveStatus == Rouge2_MapEnum.Arrive.CantArrive then
		iconColor = "#9C9C9C"
		iconAlpha = 0.39
	end

	self._iconCanvasGroup.alpha = iconAlpha

	SLFramework.UGUI.GuiHelper.SetColor(self._imageIcon, iconColor)
end

function Rouge2_MapNodeIconItem:refreshRecommend()
	if self._eventCo then
		local isHighQuality = self._eventCo.isHighQuality ~= 0
		local isCanArrive = self._arriveStatus == Rouge2_MapEnum.Arrive.CanArrive or self._arriveStatus == Rouge2_MapEnum.Arrive.NotArrive or self._arriveStatus == Rouge2_MapEnum.NodeSelectArriveStatus
		local curNode = Rouge2_MapModel.instance:getCurNode()
		local isNotCurNode = not curNode or curNode.nodeId ~= self._nodeId

		gohelper.setActive(self._goRecommend, isHighQuality and isCanArrive and isNotCurNode)
	end
end

function Rouge2_MapNodeIconItem:refreshSelect()
	gohelper.setActive(self._goSelectLight, self._isSelect)

	if not self._isSelect then
		return
	end

	local isFightEvent = Rouge2_MapHelper.isFightEvent(self._eventType)

	gohelper.setActive(self._goNormalSelectLight, not isFightEvent)
	gohelper.setActive(self._goHardSelectLight, isFightEvent)
end

function Rouge2_MapNodeIconItem:onSelect(isSelect)
	if self._isSelect == isSelect then
		return
	end

	self._isSelect = isSelect

	self:playIconAnim()
	self:refreshSelect()
end

function Rouge2_MapNodeIconItem:refreshNodeName()
	local isEliteFight = Rouge2_MapHelper.isEliteFightEvent(self._eventType)
	local isArrive = self._arriveStatus == Rouge2_MapEnum.Arrive.CanArrive or self._arriveStatus == Rouge2_MapEnum.Arrive.ArrivingNotFinish
	local isShowHead = isArrive and isEliteFight

	gohelper.setActive(self._goName, isShowHead)

	if not isShowHead then
		return
	end

	local fightEventCo = Rouge2_MapConfig.instance:eventId2FightEventCo(self._eventCo.id)
	local episodeId = fightEventCo and fightEventCo.episodeId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	self._txtName.text = episodeCo and episodeCo.name
end

function Rouge2_MapNodeIconItem:refreshNodeAttr()
	local isFightEvent = Rouge2_MapHelper.isFightEvent(self._eventType)
	local isNotArriveOrCanArrive = self._arriveStatus == Rouge2_MapEnum.Arrive.NotArrive or self._arriveStatus == Rouge2_MapEnum.Arrive.CanArrive or self._arriveStatus == Rouge2_MapEnum.Arrive.ArrivingNotFinish
	local isShowAttr = isNotArriveOrCanArrive and not isFightEvent

	gohelper.setActive(self._goAttrList, isShowAttr)

	if not isShowAttr then
		return
	end

	local advanceAttrIds = string.splitToNumber(self._eventCo.advantageAttribute, "#")

	gohelper.CreateObjList(self, self._refreshAdvanceAttrItem, advanceAttrIds, self._goAttrList, self._goAttrItem)
end

function Rouge2_MapNodeIconItem:_refreshAdvanceAttrItem(obj, attrId, index)
	local imageIcon = obj:GetComponent(gohelper.Type_Image)

	Rouge2_IconHelper.setAttributeIcon(attrId, imageIcon, Rouge2_Enum.AttrIconSuffix.Circle)
end

function Rouge2_MapNodeIconItem:onMapPosChange()
	self:updatePos()
end

function Rouge2_MapNodeIconItem:playIconAnim()
	self._waitPlayUnlockAnim = false

	local animName = ""

	if self._arriveStatus == Rouge2_MapEnum.NodeSelectArriveStatus then
		animName = "select"
	elseif self._arriveStatus == Rouge2_MapEnum.Arrive.CanArrive then
		local isUnlockAnim = Rouge2_MapLocalDataHelper.isNodeUnlockAnim(self._layerId, self._nodeId)

		if not isUnlockAnim then
			animName = "unlock"
			self._waitPlayUnlockAnim = true

			Rouge2_MapLocalDataHelper.addUnlockAnimNode(self._layerId, self._nodeId)
		else
			animName = "unselect"
		end
	else
		animName = "unselect"
	end

	if self._animName == animName or string.nilorempty(animName) then
		return
	end

	self._animName = animName

	if self._waitPlayUnlockAnim and ViewMgr.instance:isOpen(ViewName.LoadingView) and not ViewHelper.instance:checkViewOnTheTop(ViewName.Rouge2_MapView, {
		ViewName.Rouge2_MapTipView
	}) then
		return
	end

	self._animator:Play(self._animName, 0, 0)
end

function Rouge2_MapNodeIconItem:_onOpenViewFinish()
	self:_tryPlayUnlockAnim()
end

function Rouge2_MapNodeIconItem:_onCloseViewFinish()
	self:_tryPlayUnlockAnim()
end

function Rouge2_MapNodeIconItem:_tryPlayUnlockAnim()
	if not self._waitPlayUnlockAnim then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.LoadingView) or not ViewHelper.instance:checkViewOnTheTop(ViewName.Rouge2_MapView, {
		ViewName.Rouge2_MapTipView
	}) then
		return
	end

	self._animator:Play(self._animName, 0, 0)

	self._waitPlayUnlockAnim = false

	AudioMgr.instance:trigger(AudioEnum.Rouge2.UnlockNewEvent)
end

return Rouge2_MapNodeIconItem
