-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/new/CharacterImpressionTaskCell.lua

module("logic.extensions.characterinformation.view.new.CharacterImpressionTaskCell", package.seeall)

local M = class("CharacterImpressionTaskCell")

function M:ctor(mainGo)
	self.mainGO = mainGo.gameObject
	self._canvasGroupMainGo = self.mainGO:GetComponent(ComponentType.CanvasGroup)
	self.rectTr = self.mainGO:GetComponent(UIComponentType.RectTransform)
	self.cellGO = mainGo.transform:GetChild(0).gameObject
	self._canvasGroupCellGo = goutil.addComponentOnce(self.cellGO, ComponentType.CanvasGroup)
	self._rectTrCell = self.cellGO:GetComponent(UIComponentType.RectTransform)
	self._rectTrCellDefaultScale = Vector3.New(1.2, 1.2, 1.2)
	self._registry = ViewElementsRegistry.New(self.cellGO)
end

function M:getMainGo()
	return self.mainGO
end

function M:getMainRectTr()
	return self.rectTr
end

function M:getCellGo()
	return self.cellGO
end

function M:getRegistry()
	return self._registry
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local registry = self:getRegistry()

	self._vec3Zero = Vector3.New(0, 0, 0)
	self._vec3One = Vector3.New(1, 1, 1)
	self._vec3Temp = Vector3.New()
	self._vec3Ramdom = Vector3.New(1, 1, 1)
	self._canvasGroupContent = registry:findUIElement("heart_anchor_task_item_731182147", ComponentType.CanvasGroup)
	self._btnSetTarget = UIComponentType.ButtonAdapter(registry:findUIElement("heart_anchor_task_item_1583318867"))
	self._btnReceive = UIComponentType.ButtonAdapter(registry:findUIElement("heart_anchor_task_item_1274907424"))
	self._btnJump = UIComponentType.ButtonAdapter(registry:findUIElement("heart_anchor_task_item_1795983232"))
	self._goDone = registry:findUIElement("heart_anchor_task_item_-1613997238")
	self._goTailEffect = registry:findUIElement("heart_anchor_task_item_847259506")
	self._goCanReward = registry:findUIElement("heart_anchor_task_item_-1135466469")
	self._goTarget = registry:findUIElement("heart_anchor_task_item_-1042427676")
	self._goTargetOutSide = registry:findUIElement("heart_anchor_task_item_-1752397387")
	self._txtDesc = registry:findUIElement("heart_anchor_task_item_-1791055280", UIComponentType.Text)
	self._rewardRootExp = registry:findUIElement("heart_anchor_task_item_-1154680539")
	self._txtRewardExp = registry:findUIElement("heart_anchor_task_item_-1537927914", UIComponentType.Text)
	self._rewardRootItem = registry:findUIElement("heart_anchor_task_item_-861774855")
	self._imgItemQuality = registry:findUIElement("rewards_detail_item_868117965", UIComponentType.Image)
	self._imgItemIcon = registry:findUIElement("rewards_detail_item_-2041880288", UIComponentType.Image)
	self._txtItemCount = registry:findUIElement("heart_anchor_task_item_-2027239067", UIComponentType.Text)
	self._btnClickItem = UIComponentType.ButtonAdapter(registry:findUIElement("rewards_detail_item_1370605741"))
end

function M:destroyUI()
	self:setEvent(false)
	self:setHandler(nil)
	self._canvasGroupMainGo:DOKill(false)
	self.rectTr:DOKill(false)
	self._rectTrCell:DOKill(false)
	self._canvasGroupContent:DOKill(false)

	self.mainGO = nil

	if self._registry then
		self._registry:cleanRegistry()
	end

	self._registry = nil
end

function M:bindEvents()
	self._btnSetTarget:AddClickListener(self._onClickSetTarget, self)
	self._btnReceive:AddClickListener(self._onClickReceive, self)
	self._btnJump:AddClickListener(self._onClickJump, self)
	self._btnClickItem:AddClickListener(self._onClickRewardItem, self)
end

function M:unbindEvents()
	self._btnSetTarget:RemoveClickListener()
	self._btnReceive:RemoveClickListener()
	self._btnJump:RemoveClickListener()
	self._btnClickItem:RemoveClickListener()
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:onEnter()
	self:setEvent(true)
end

function M:onExit()
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:getIsVisible()
	return self._visible
end

function M:setVisible(visible)
	self._visible = visible

	goutil.setActive(self:getMainGo(), visible)
end

function M:setShowDetail(showDetail, duration)
	self._showDetail = showDetail
	duration = duration or 0

	if duration > 0 then
		self._canvasGroupContent.alpha = showDetail and 1 or 0
	else
		self._canvasGroupContent.alpha = showDetail and 1 or 0
	end
end

function M:getIsShowDetail()
	return self._showDetail
end

function M:getCurHeroData()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	if not heroData then
		return nil
	end

	local data = HeroDepotModel.instance:getHeroInfoByID(heroData:getId())

	return data
end

function M:_onClickSetTarget()
	if self._data:getHasFinish() then
		return
	end

	if not self._data:getIsTarget() then
		TacitAgent.instance:sendMarkPrimaryTaskRequest(self._data:getId())
	end

	goutil.setActive(self._goTarget, self._data:getIsTarget())
	goutil.setActive(self._goTargetOutSide, self._data:getIsTarget() and not self:getIsShowDetail())
end

function M:_onClickReceive()
	if self._data:getHasFinish() then
		printWarn(string.format("[%s] task[%s] hasFinish", self:getCurHeroData():getId(), self._data:getId()))

		return
	end

	if self._data:getCanReward() then
		TacitAgent.instance:sendTakeTaskRewardRequest(self._data:getId(), self:getCurHeroData():getId())
	else
		printWarn(string.format("[%s] task[%s] canReward = false", self:getCurHeroData():getId(), self._data:getId()))
	end
end

function M:_onClickJump()
	if self._data:getHasFinish() then
		return
	end

	local jumpId = self._data:getJumpId()

	if jumpId > 0 then
		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, self._data:getJumpId())
	end
end

function M:_onClickRewardItem()
	local itemData = self._itemData

	if not itemData then
		return
	end

	local isShowTips = true
	local showTipsPassEvent = false
	local hideGetWay = true
	local hideLock = true

	GlobalDispatcher:dispatchEvent(itemData:getItemMarkType(), itemData, self._rewardRootExp, 1, isShowTips, showTipsPassEvent, hideGetWay, hideLock)
end

function M:getTaskId()
	if self._data then
		return self._data:getId()
	end

	return nil
end

function M:getRewardingVFX()
	return self._goTailEffect
end

function M:setCellData(taskMo)
	self._data = taskMo

	local isFinish = self._data:getHasFinish()
	local jumpId = self._data:getJumpId()
	local showJumpBtn = not self._data:getCanReward() and jumpId > 0 and not isFinish
	local desc = self._data:getDesc()

	if not isFinish then
		desc = string.format("%s<color=#bababa>(%s/%s)</color>", desc, self._data:getCurCount(), self._data:getMaxCount())
	end

	self._txtDesc.text = desc

	goutil.setActive(self._goTarget, self._data:getIsTarget())
	goutil.setActive(self._goTargetOutSide, self._data:getIsTarget() and not self:getIsShowDetail())
	goutil.setActive(self._goDone, isFinish)
	goutil.setActive(self._goCanReward, not isFinish and self._data:getCanReward())
	goutil.setActive(self._btnReceive.gameObject, not isFinish and self._data:getCanReward())
	goutil.setActive(self._btnJump.gameObject, showJumpBtn)
	goutil.setActive(self._btnSetTarget.gameObject, not self._data:getIsTarget() and not isFinish)

	self._canvasGroupCellGo.alpha = isFinish and 0.5 or 1

	self:_refreshReward()
end

function M:updateTaskCellData()
	if not self:getIsVisible() then
		return
	end

	local taskMo = TacitModel.instance:getTacitTaskMO(self:getTaskId())

	self:setCellData(taskMo)
end

function M:_refreshReward()
	local reward = self._data:getRewardTb()
	local exp = self._data:getTacitExp() or 0

	self._txtRewardExp.text = exp

	goutil.setActive(self._rewardRootExp, exp > 0)
	goutil.setActive(self._rewardRootItem, reward)

	if reward then
		local itemId = reward.itemId
		local itemCount = reward.num

		self._itemData = ItemUtil.createItemData({
			count = itemCount,
			itemId = itemId
		})

		IconLoader.setSprite(self._imgItemQuality, IconType.Skinlib, GameUrl.getItemQualityUrl(self._itemData:getQuality()))

		self._txtItemCount.text = itemCount

		local icon = self._itemData:getIcon()
		local itemTypeEnum = self._itemData:getType()

		if string.nilorempty(icon) then
			return
		end

		IconLoader.setSpriteByItemType(self._imgItemIcon, itemTypeEnum, icon)
	end
end

function M:dealInZone(inZone, duration)
	if self._inZone ~= nil and self._inZone == inZone then
		return
	end

	self._inZone = inZone

	self._canvasGroupMainGo:DOKill(false)
	self.rectTr:DOKill(false)

	local alpha = inZone and 1 or 0.5
	local scale = inZone and 1 or 0.7

	self._canvasGroupMainGo:DOFade(alpha, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)

	self._canvasGroupMainGo.interactable = inZone
	self._canvasGroupMainGo.blocksRaycasts = inZone

	self._vec3Temp:Set(scale, scale, 1)
	self.rectTr:DOScale(self._vec3Temp, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
end

function M:playEnterAni(play)
	self._rectTrCell:DOKill(false)
	self._canvasGroupContent:DOKill(false)

	if play then
		local duration = 0.3

		RectTransformUtils.SetAnchoredPosition(self._rectTrCell, math.random(-100, 100), math.random(-100, 100))
		RectTransformUtils.SetScale(self._rectTrCell, 0.7, 0.7, 1)

		self._canvasGroupContent.alpha = 0

		self._canvasGroupContent:DOFade(1, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
		self._rectTrCell:DOAnchorPos(self._vec3Zero, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
		self._rectTrCell:DOScale(self._rectTrCellDefaultScale, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(self.playRandomAni, self)
	else
		local scaleX, scaleY, scaleZ = self._rectTrCellDefaultScale:Get()

		RectTransformUtils.SetScale(self._rectTrCell, scaleX, scaleY, scaleZ)

		self._canvasGroupContent.alpha = 1

		self:playRandomAni()
	end
end

function M:playRandomAni()
	local duration = 3.6

	self._vec3Ramdom:Set(math.random(-20, 20), math.random(-20, 20), 0)
	self._rectTrCell:DOAnchorPos(self._vec3Ramdom, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(self.playRandomAni, self)
end

return M
