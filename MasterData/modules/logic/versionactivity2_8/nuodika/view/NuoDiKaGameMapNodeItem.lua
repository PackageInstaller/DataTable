-- chunkname: @modules/logic/versionactivity2_8/nuodika/view/NuoDiKaGameMapNodeItem.lua

module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaGameMapNodeItem", package.seeall)

local NuoDiKaGameMapNodeItem = class("NuoDiKaGameMapNodeItem", LuaCompBase)

function NuoDiKaGameMapNodeItem:init(go, topGo)
	self.go = go
	self.topGo = topGo
	self._goroot = gohelper.findChild(go, "goroot")
	self._btnnode = gohelper.findChildButtonWithAudio(go, "goroot/btn_node")
	self._golocked = gohelper.findChild(go, "goroot/go_locked")
	self._gounlocked = gohelper.findChild(go, "goroot/go_unlocked")
	self._gointeractable = gohelper.findChild(go, "goroot/go_interactable")
	self._goplaceable = gohelper.findChild(go, "goroot/go_placeable")
	self._godamage = gohelper.findChild(go, "goroot/go_damage")
	self._goselected = gohelper.findChild(go, "goroot/go_selected")
	self._gocloud = gohelper.findChild(go, "goroot/go_cloud")
	self._gouninteractable = gohelper.findChild(go, "goroot/go_uninteractable")
	self._gouninteractableenemy = gohelper.findChild(go, "goroot/go_uninteractableenemy")
	self._goenemyicon = gohelper.findChild(go, "goroot/go_enemyicon")
	self._goenemy = gohelper.findChild(go, "goroot/go_enemy")
	self._simageenemy = gohelper.findChildSingleImage(go, "goroot/go_enemy/image_enemy")
	self._goitem = gohelper.findChild(go, "goroot/go_item")
	self._simageitem = gohelper.findChildSingleImage(go, "goroot/go_item/image_item")
	self._topgoroot = gohelper.findChild(topGo, "goroot")
	self._gostate1 = gohelper.findChild(topGo, "goroot/go_state1")
	self._gohp1 = gohelper.findChild(topGo, "goroot/go_state1/gohp1")
	self._txthpnum1 = gohelper.findChildText(topGo, "goroot/go_state1/gohp1/txt_hpnum1")
	self._goattack1 = gohelper.findChild(topGo, "goroot/go_state1/goattack1")
	self._txtattacknum1 = gohelper.findChildText(topGo, "goroot/go_state1/goattack1/txt_attcknum1")
	self._gostate2 = gohelper.findChild(topGo, "goroot/go_state2")
	self._gohp2 = gohelper.findChild(topGo, "goroot/go_state2/gohp2")
	self._txthpnum2 = gohelper.findChildText(topGo, "goroot/go_state2/gohp2/txt_hpnum2")
	self._goattack2 = gohelper.findChild(topGo, "goroot/go_state2/goattack2")
	self._txtattacknum2 = gohelper.findChildText(topGo, "goroot/go_state2/goattack2/txt_attcknum2")
	self._goturns = gohelper.findChild(topGo, "goroot/go_turns")
	self._txtturns = gohelper.findChildText(topGo, "goroot/go_turns/txt_turns")
	self._gowarn = gohelper.findChild(topGo, "goroot/vx_warn")
	self._goheal = gohelper.findChild(topGo, "goroot/vx_heal")
	self._godead = gohelper.findChild(topGo, "goroot/vx_dead")
	self._txtaffected = gohelper.findChildText(topGo, "goroot/txt_affected")
	self._goattack = gohelper.findChild(topGo, "goroot/vx_attack")
	self._goscan = gohelper.findChild(topGo, "goroot/vx_scan")
	self._godeadbuff = gohelper.findChild(topGo, "goroot/vx_deadbuff")
	self._goendless = gohelper.findChild(topGo, "goroot/vx_endless")
	self._goitemtip = gohelper.findChild(topGo, "goroot/go_itemtip")
	self._txtitemdesc = gohelper.findChildText(topGo, "goroot/go_itemtip/txt_itemdesc")
	self._txtitemname = gohelper.findChildText(topGo, "goroot/go_itemtip/txt_itemdesc/txt_itemname")
	self._btnitemuse = gohelper.findChildButtonWithAudio(topGo, "goroot/go_itemtip/txt_itemdesc/btn_itemuse")
	self._goenemytip = gohelper.findChild(topGo, "goroot/go_enemytip")
	self._txtenemydesc = gohelper.findChildText(topGo, "goroot/go_enemytip/txt_enemydesc")
	self._txtenemyname = gohelper.findChildText(topGo, "goroot/go_enemytip/txt_enemydesc/txt_enemyname")
	self._btnenemyattack = gohelper.findChildButtonWithAudio(topGo, "goroot/go_enemytip/txt_enemydesc/btn_enemyattack")

	self:_initNode()
	self:_addEvents()
end

function NuoDiKaGameMapNodeItem:_addEvents()
	self._btnnode:AddClickListener(self._btnnodeOnClick, self)
	self._btnenemyattack:AddClickListener(self._btnenemyattackOnClick, self)
	self._btnitemuse:AddClickListener(self._btnitemuseOnClick, self)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.NodeClicked, self._onNodeClick, self)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.AttackEnemy, self._onStartAttack, self)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.WarnEnemyNode, self._onWarnEnemyNode, self)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.UnlockAllNodesEnemyDead, self._onUnlockAllNodesEnemyDead, self)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.UnlockSuccessItem, self._onUnlockSuccessItem, self)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.ItemWarnAttackEnemy, self._onItemWarnAttackEnemy, self)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.ClearNodeItem, self._onClearNodeItem, self)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.HideOtherNodeTips, self._onHideOtherNodeTips, self)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.ShowInteractAttackWarn, self._onShowInteractAttackWarn, self)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.ShowItemScan, self._onCheckShowScan, self)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.MapResetClicked, self._onResetNode, self)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.GameRestart, self._onResetNode, self)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.GameFailed, self._onGameFailed, self)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.GameSuccess, self._onGameSuccess, self)
end

function NuoDiKaGameMapNodeItem:_removeEvents()
	self._btnnode:RemoveClickListener()
	self._btnenemyattack:RemoveClickListener()
	self._btnitemuse:RemoveClickListener()
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.NodeClicked, self._onNodeClick, self)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.AttackEnemy, self._onStartAttack, self)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.WarnEnemyNode, self._onWarnEnemyNode, self)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.UnlockAllNodesEnemyDead, self._onUnlockAllNodesEnemyDead, self)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.UnlockSuccessItem, self._onUnlockSuccessItem, self)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.ItemWarnAttackEnemy, self._onItemWarnAttackEnemy, self)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.ClearNodeItem, self._onClearNodeItem, self)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.HideOtherNodeTips, self._onHideOtherNodeTips, self)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.ShowInteractAttackWarn, self._onShowInteractAttackWarn, self)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.ShowItemScan, self._onCheckShowScan, self)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.MapResetClicked, self._onResetNode, self)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.GameRestart, self._onResetNode, self)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.GameSuccess, self._onGameSuccess, self)
end

function NuoDiKaGameMapNodeItem:_onGameFailed()
	self:_endBlock()
end

function NuoDiKaGameMapNodeItem:_onGameSuccess()
	self:_endBlock()
end

function NuoDiKaGameMapNodeItem:_onResetNode()
	self:hideItemTip()
	self:hideEnemyTip()
	self._enemyAnim:Play("open", 0, 1)
	self._enemyTopAni:Play("open", 0, 1)
end

function NuoDiKaGameMapNodeItem:_onCheckShowScan(nodeMo)
	if self._nodeMo.id ~= nodeMo.id then
		return
	end

	self:_onShowScan()
end

function NuoDiKaGameMapNodeItem:_onShowInteractAttackWarn(nodeMo)
	if self._nodeMo.id ~= nodeMo.id then
		return
	end

	gohelper.setActive(self._gowarn, true)
	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_interact_attack)
	UIBlockMgr.instance:startBlock("interactAttack")
	TaskDispatcher.runDelay(self._showInteractWarnFinished, self, 1)
end

function NuoDiKaGameMapNodeItem:_showInteractWarnFinished()
	gohelper.setActive(self._gowarn, false)
	UIBlockMgr.instance:endBlock("interactAttack")
end

function NuoDiKaGameMapNodeItem:_onHideOtherNodeTips(nodeId)
	if self._nodeMo.id == nodeId then
		return
	end

	self:hideItemTip()
	self:hideEnemyTip()
end

function NuoDiKaGameMapNodeItem:_onClearNodeItem(nodeMo)
	if self._nodeMo.id ~= nodeMo.id then
		return
	end

	nodeMo:clearEvent()
	self:hideItemTip()
end

function NuoDiKaGameMapNodeItem:_onItemWarnAttackEnemy(nodeMo)
	local isUnlock = self._nodeMo:isNodeUnlock()

	if not isUnlock then
		return
	end

	local eventCo = self._nodeMo:getEvent()

	if eventCo then
		::label_12_0::

		local hasEnemy = self._nodeMo:isNodeHasEnemy()

		if not hasEnemy then
			return
		end

		self._warnAttackNode = nodeMo

		gohelper.setActive(self._goplaceable, true)
	end
end

function NuoDiKaGameMapNodeItem:_onUnlockAllNodesEnemyDead(id)
	if self._nodeMo.id ~= id then
		return
	end

	gohelper.setActive(self._godeadbuff, true)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("enemyDeadUnlock")
	TaskDispatcher.runDelay(self._enemyDeadUnlockFinished, self, 1.5)
end

function NuoDiKaGameMapNodeItem:_onUnlockSuccessItem(id)
	if self._nodeMo.id ~= id then
		return
	end

	gohelper.setActive(self._goendless, true)
end

function NuoDiKaGameMapNodeItem:_enemyDeadUnlockFinished()
	UIBlockMgr.instance:endBlock("enemyDeadUnlock")
	gohelper.setActive(self._godeadbuff, false)
end

function NuoDiKaGameMapNodeItem:_btnnodeOnClick()
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.HideOtherNodeTips, self._nodeMo.id)

	local isEnemyLock = NuoDiKaMapModel.instance:isNodeEnemyLock(self._nodeMo.id)

	if isEnemyLock then
		GameFacade.showToast(ToastEnum.NuoDiKaGameNodeLocked)

		return
	end

	local isUnlock = self._nodeMo:isNodeUnlock()

	if not isUnlock then
		local isCouldUnlock = NuoDiKaMapModel.instance:isNodeCouldUnlock(self._nodeMo.id, self._mapId)

		if not isCouldUnlock then
			return
		end

		gohelper.setActive(self._gounlocked, true)
		self._cloudAnim:Play("close", 0, 0)
		self._interactAnim:Play("close", 0, 0)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("cloudUnlock")
		TaskDispatcher.runDelay(self._unlockFinished, self, 0.4)
		NuoDiKaMapModel.instance:setCurSelectNode(self._nodeMo.id)
		NuoDiKaMapModel.instance:setNodeUnlock(self._nodeMo.id, self._mapId)

		local eventCo = self._nodeMo:getEvent()

		if eventCo then
			::label_16_0::

			local hasEnemy = self._nodeMo:isNodeHasEnemy()

			if eventCo then
				::label_16_1::

				local hasItem = self._nodeMo:isNodeHasItem()

				AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_unlock_node)

				if hasEnemy or hasItem then
					AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_unlock_unit)
				end

				NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.OnUnlockGuideNode, tostring(self._nodeMo.id))
			end
		end
	else
		if self._warnAttackNode then
			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.StartInteract)
			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ItemStartSkill, self._nodeMo, self._warnAttackNode)

			self._warnAttackNode = nil

			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.NodeClicked, self._nodeMo.id)

			return
		end

		NuoDiKaMapModel.instance:setCurSelectNode(self._nodeMo.id)

		local eventCo = self._nodeMo:getEvent()

		self:_refreshNodeState()

		if eventCo then
			::label_16_2::

			local hasEnemy = self._nodeMo:isNodeHasEnemy()

			if hasEnemy then
				self:showEnemyTip()
			end

			if eventCo then
				::label_16_3::

				local hasItem = self._nodeMo:isNodeHasItem()

				if hasItem then
					self:showItemTip()
				end

				NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.NodeClicked, self._nodeMo.id)
			end
		end
	end
end

function NuoDiKaGameMapNodeItem:_unlockFinished()
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.NodeClicked, self._nodeMo.id)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.StartInteract)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.MapRefresh)
	TaskDispatcher.runDelay(self._unlockAnimFinished, self, 0.6)
end

function NuoDiKaGameMapNodeItem:_unlockAnimFinished()
	UIBlockMgr.instance:endBlock("cloudUnlock")

	local eventCo = self._nodeMo:getEvent()

	if eventCo then
		::label_18_0::

		local hasEnemy = self._nodeMo:isNodeHasEnemy()

		if hasEnemy then
			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.CheckShowEnemyDetail, eventCo.eventParam)
		end

		if eventCo then
			::label_18_1::

			local hasItem = self._nodeMo:isNodeHasItem()

			if hasItem then
				NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.CheckShowItemDetail, eventCo.eventParam)
			end
		end
	end
end

function NuoDiKaGameMapNodeItem:_btnenemyattackOnClick()
	if not self._nodeMo:getEvent() then
		return
	end

	local mainRole = NuoDiKaMapModel.instance:getMapMainRole().enemyId
	local hurtCount = NuoDiKaConfig.instance:getEnemyCo(mainRole).atk

	if hurtCount <= 0 then
		return
	end

	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.StartInteract)

	if hurtCount >= self._nodeMo.hp then
		AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_enemy_dead)
		self._enemyAnim:Play("dead", 0, 0)
		self._enemyTopAni:Play("dead", 0, 0)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("enemyDead")
		self:hideEnemyTip()
		NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.AttackMainRole, self._nodeMo.atk)
		self._nodeMo:clearEvent()
		TaskDispatcher.runDelay(self._deadFinished, self, 1.5)

		return
	end

	local mainRole = NuoDiKaMapModel.instance:getMapMainRole().enemyId
	local hurtCount = NuoDiKaConfig.instance:getEnemyCo(mainRole).atk

	if hurtCount <= 0 then
		return
	end

	self:_onStartAttack(self._nodeMo, hurtCount, false)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.AttackMainRole, self._nodeMo.atk)
end

function NuoDiKaGameMapNodeItem:_deadFinished()
	gohelper.setActive(self._goattack, false)
	UIBlockMgr.instance:endBlock("enemyDead")
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.EnemyDead, self._nodeMo)

	local enemyId = self._nodeMo:getInitEvent().eventParam
	local enemyCo = NuoDiKaConfig.instance:getEnemyCo(enemyId)

	if enemyCo and enemyCo.eventID and enemyCo.eventID > 0 then
		return
	end

	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.MapRefresh)
end

function NuoDiKaGameMapNodeItem:_btnitemuseOnClick()
	local eventCo = self._nodeMo:getEvent()

	if not eventCo then
		return
	end

	if eventCo.eventParam == 2002 then
		self:hideItemTip()
		NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ItemWarnAttackEnemy, self._nodeMo)

		return
	end

	if eventCo.eventParam == 2005 then
		self:_onShowScan()
	end

	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.StartInteract)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ItemStartSkill, self._nodeMo, self._nodeMo)
end

function NuoDiKaGameMapNodeItem:_onShowScan()
	self:hideItemTip()
	gohelper.setActive(self._goscan, true)
	UIBlockMgrExtend.setNeedCircleMv(false)
	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_item_detection)
	UIBlockMgr.instance:startBlock("itemScan")
	TaskDispatcher.runDelay(self._scanFinished, self, 2)
end

function NuoDiKaGameMapNodeItem:_scanFinished()
	gohelper.setActive(self._goscan, false)
	UIBlockMgr.instance:endBlock("itemScan")
end

function NuoDiKaGameMapNodeItem:_onNodeClick(nodeId)
	self._warnAttackNode = nil

	gohelper.setActive(self._goplaceable, false)

	if self._nodeMo.id ~= nodeId then
		self:hideItemTip()
		self:hideEnemyTip()
		self:refreshNode()
	end
end

function NuoDiKaGameMapNodeItem:_onStartAttack(nodeMo, hurtCount, isItemAttack)
	if not self._nodeMo:getEvent() then
		return
	end

	if self._nodeMo.id ~= nodeMo.id then
		return
	end

	if isItemAttack then
		gohelper.setActive(self._goattack, true)
	end

	self._hurtValue = hurtCount

	self._nodeMo:reduceHp(self._hurtValue)
	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_enemy_hurt)

	if self._nodeMo.hp <= 0 then
		AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_enemy_dead)
		self._enemyAnim:Play("dead", 0, 0)
		self._enemyTopAni:Play("dead", 0, 0)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("enemyDead")
		self:hideEnemyTip()
		TaskDispatcher.runDelay(self._deadFinished, self, 1.5)

		return
	end

	self._enemyAnim:Play("hurt", 0, 0)
	self._enemyTopAni:Play("hurt", 0, 0)

	if self._txtaffected.gameObject.activeSelf then
		local totalHurt = hurtCount - tonumber(self._txtaffected.text)

		self._txtaffected.text = "-" .. totalHurt
	else
		gohelper.setActive(self._txtaffected.gameObject, true)

		self._txtaffected.text = "-" .. hurtCount
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("enemyHurt")
	TaskDispatcher.runDelay(self._hurtFinished, self, 1)
end

function NuoDiKaGameMapNodeItem:_hurtFinished()
	gohelper.setActive(self._goattack, false)
	gohelper.setActive(self._txtaffected.gameObject, false)
	UIBlockMgr.instance:endBlock("enemyHurt")
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.MapRefresh)
end

function NuoDiKaGameMapNodeItem:_onWarnEnemyNode(targetNodeMo)
	if self._nodeMo.id ~= targetNodeMo.id then
		return
	end

	if not self._nodeMo:isNodeHasEnemy() then
		return
	end

	self._nodeMo:setWarn(true)
	self:_refreshNodeState()
end

function NuoDiKaGameMapNodeItem:_initNode()
	gohelper.setActive(self.go, true)
	gohelper.setActive(self.topGo, true)
	gohelper.setActive(self._golocked, false)
	gohelper.setActive(self._gounlocked, false)
	gohelper.setActive(self._gointeractable, false)
	gohelper.setActive(self._goplaceable, false)
	gohelper.setActive(self._godamage, false)
	gohelper.setActive(self._goselected, false)
	gohelper.setActive(self._gouninteractable, false)
	gohelper.setActive(self._gocloud, false)
	gohelper.setActive(self._gouninteractableenemy, false)
	gohelper.setActive(self._goenemyicon, false)
	gohelper.setActive(self._goenemy, false)
	gohelper.setActive(self._gostate1, false)
	gohelper.setActive(self._gostate2, false)
	gohelper.setActive(self._goenemytip, false)
	gohelper.setActive(self._txtaffected.gameObject, false)
	gohelper.setActive(self._goitem, false)
	gohelper.setActive(self._goitemtip, false)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._btnnode.gameObject)

	self._drag:AddDragBeginListener(self._onBeginDrag, self, self._goitem.transform)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onEndDrag, self, self._goitem.transform)

	self._enemyAnim = self._goenemy:GetComponent(typeof(UnityEngine.Animator))
	self._enemyTopAni = self._topgoroot:GetComponent(typeof(UnityEngine.Animator))
	self._cloudAnim = self._gocloud:GetComponent(typeof(UnityEngine.Animator))
	self._lockAnim = self._golocked:GetComponent(typeof(UnityEngine.Animator))
	self._unlockAnim = self._gounlocked:GetComponent(typeof(UnityEngine.Animator))
	self._interactAnim = self._gointeractable:GetComponent(typeof(UnityEngine.Animator))
end

function NuoDiKaGameMapNodeItem:_onBeginDrag(unitTransform, pointerEventData)
	self:hideItemTip()
	self:hideEnemyTip()

	if not self._nodeMo then
		return
	end

	if not self._nodeMo:isNodeHasEnemy() and not self._nodeMo:isNodeHasItem() then
		return
	end

	local itemCo = NuoDiKaConfig.instance:getItemCo(self._nodeMo:getEvent().eventParam)

	if itemCo and itemCo.canMove ~= NuoDiKaEnum.ItemDragType.CanMove then
		return
	end

	self._goDrag = gohelper.clone(self._goitem)

	self._goDrag.transform:SetParent(self.go.transform.parent.parent)
	transformhelper.setLocalScale(self._goDrag.transform, 1, 1, 1)

	local pos = pointerEventData.position
	local anchorPos = recthelper.screenPosToAnchorPos(pos, self._goDrag.transform.parent)

	recthelper.setAnchor(self._goDrag.transform, anchorPos.x, anchorPos.y)
end

function NuoDiKaGameMapNodeItem:_onDrag(param, pointerEventData)
	if not self._nodeMo then
		return
	end

	if not self._nodeMo:isNodeHasEnemy() and not self._nodeMo:isNodeHasItem() then
		return
	end

	local itemCo = NuoDiKaConfig.instance:getItemCo(self._nodeMo:getEvent().eventParam)

	if itemCo and itemCo.canMove ~= NuoDiKaEnum.ItemDragType.CanMove then
		return
	end

	local pos = pointerEventData.position
	local anchorPos = recthelper.screenPosToAnchorPos(pos, self._goDrag.transform.parent)

	recthelper.setAnchor(self._goDrag.transform, anchorPos.x, anchorPos.y)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.NodeUnitDraging, pos, self._nodeMo)
end

function NuoDiKaGameMapNodeItem:_onEndDrag(equipTransform, pointerEventData)
	if not self._nodeMo then
		return
	end

	if not self._nodeMo:isNodeHasEnemy() and not self._nodeMo:isNodeHasItem() then
		return
	end

	local itemCo = NuoDiKaConfig.instance:getItemCo(self._nodeMo:getEvent().eventParam)

	if itemCo and itemCo.canMove ~= NuoDiKaEnum.ItemDragType.CanMove then
		return
	end

	local pos = pointerEventData.position
	local anchorPos = recthelper.screenPosToAnchorPos(pos, self._goDrag.transform.parent)

	recthelper.setAnchor(self._goDrag.transform, anchorPos.x, anchorPos.y)

	if self._goDrag then
		gohelper.destroy(self._goDrag)

		self._goDrag = nil
	end

	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.NodeUnitDragEnd, pos, self._nodeMo)
end

function NuoDiKaGameMapNodeItem:setItem(mo)
	self._nodeMo = mo
	self.go.name = mo.x .. "_" .. mo.y
	self.topGo.name = mo.x .. "_" .. mo.y

	self:refreshNode()
end

function NuoDiKaGameMapNodeItem:refreshNode()
	self:_refreshNodeState()
	self:_refreshEnemy()
	self:_refreshItem()
end

function NuoDiKaGameMapNodeItem:_refreshNodeState()
	local isUnlock = self._nodeMo:isNodeUnlock()
	local isInteractable = NuoDiKaMapModel.instance:isNodeCouldUnlock(self._nodeMo.id)
	local isEnemyLock = NuoDiKaMapModel.instance:isNodeEnemyLock(self._nodeMo.id)
	local isSelected = NuoDiKaMapModel.instance:isNodeSelected(self._nodeMo.id)
	local hasItem = self._nodeMo:isNodeHasItem() or self._nodeMo:isNodeHasEnemy()

	if not isUnlock and isInteractable and not self._gointeractable.activeSelf then
		gohelper.setActive(self._gointeractable, true)
		self._interactAnim:Play("open", 0, 0)
		self._lockAnim:Play("close", 0, 0)
	end

	gohelper.setActive(self._gounlocked, isUnlock)
	gohelper.setActive(self._golocked, not isUnlock and not isInteractable)
	gohelper.setActive(self._gointeractable, not isUnlock and isInteractable)
	gohelper.setActive(self._gocloud, not isUnlock and isInteractable)
	gohelper.setActive(self._gouninteractable, not isUnlock and isEnemyLock and not self._nodeMo.isWarn)
	gohelper.setActive(self._gouninteractableenemy, not isUnlock and isEnemyLock and self._nodeMo.isWarn)
	gohelper.setActive(self._goenemyicon, not isUnlock and not isEnemyLock and self._nodeMo.isWarn)
	gohelper.setActive(self._goselected, isSelected and hasItem)
end

function NuoDiKaGameMapNodeItem:_refreshEnemy()
	local isUnlock = self._nodeMo:isNodeUnlock()
	local hasEnemy = self._nodeMo:getEvent() and self._nodeMo:isNodeHasEnemy()

	gohelper.setActive(self._goenemy, isUnlock and hasEnemy)

	local enemyState = NuoDiKaEnum.EnemyState.Normal

	gohelper.setActive(self._gostate1, isUnlock and hasEnemy and enemyState ~= NuoDiKaEnum.EnemyState.Freeze)
	gohelper.setActive(self._gostate2, isUnlock and hasEnemy and enemyState == NuoDiKaEnum.EnemyState.Freeze)
	gohelper.setActive(self._goturns, isUnlock and hasEnemy and self._nodeMo:isTriggerTypeEnemy())

	if isUnlock and hasEnemy then
		local eventCo = self._nodeMo:getEvent()
		local enemyCo = NuoDiKaConfig.instance:getEnemyCo(eventCo.eventParam)

		self._txthpnum1.text = self._nodeMo.hp
		self._txthpnum2.text = self._nodeMo.hp
		self._txtattacknum1.text = self._nodeMo.atk
		self._txtattacknum2.text = self._nodeMo.atk
		self._txtenemyname.text = enemyCo.name
		self._txtenemydesc.text = enemyCo.desc

		self._simageenemy:LoadImage(ResUrl.getNuoDiKaMonsterIcon(enemyCo.picture))

		self._txtturns.text = self._nodeMo.interactTimes
	end
end

function NuoDiKaGameMapNodeItem:_refreshItem()
	local isUnlock = self._nodeMo:isNodeUnlock()
	local hasItem = self._nodeMo:getEvent() and self._nodeMo:isNodeHasItem()

	gohelper.setActive(self._goitem, isUnlock and hasItem)

	if isUnlock and hasItem then
		local eventCo = self._nodeMo:getEvent()
		local itemCo = NuoDiKaConfig.instance:getItemCo(eventCo.eventParam)

		self._txtitemname.text = itemCo.name
		self._txtitemdesc.text = itemCo.desc

		self._simageitem:LoadImage(ResUrl.getNuoDiKaItemIcon(itemCo.picture))
	end
end

function NuoDiKaGameMapNodeItem:showPlaceable(show)
	gohelper.setActive(self._goplaceable, show)
end

function NuoDiKaGameMapNodeItem:showDamage(show)
	gohelper.setActive(self._godamage, show)
end

function NuoDiKaGameMapNodeItem:_showAffect(show, affectValue)
	gohelper.setActive(self._txtaffected.gameObject, show)

	if show then
		self._txtaffected.text = affectValue or 0
	end
end

function NuoDiKaGameMapNodeItem:showEnemyTip()
	if self._goenemytip.activeSelf then
		return
	end

	gohelper.setActive(self._goenemytip, true)
	TaskDispatcher.runDelay(function()
		local tipHeight = recthelper.getHeight(self._goenemytip.transform)
		local uiPosY = recthelper.uiPosToScreenPos(self._goenemytip.transform).y
		local offsetY = uiPosY + tipHeight
		local posY = offsetY <= UnityEngine.Screen.height and 160 or 160 - (offsetY - UnityEngine.Screen.height)

		transformhelper.setLocalPos(self._goenemytip.transform, 0, posY, 0)
	end, self, 0.01)
end

function NuoDiKaGameMapNodeItem:hideEnemyTip()
	gohelper.setActive(self._goenemytip, false)
	transformhelper.setLocalPos(self._goenemytip.transform, 0, 160, 0)
end

function NuoDiKaGameMapNodeItem:showItemTip()
	if self._goitemtip.activeSelf then
		return
	end

	gohelper.setActive(self._goitemtip, true)
	TaskDispatcher.runDelay(function()
		local tipHeight = recthelper.getHeight(self._goitemtip.transform)
		local uiPosY = recthelper.uiPosToScreenPos(self._goitemtip.transform).y
		local offsetY = uiPosY + tipHeight
		local posY = offsetY <= UnityEngine.Screen.height and 160 or 160 - (offsetY - UnityEngine.Screen.height)

		transformhelper.setLocalPos(self._goitemtip.transform, 0, posY, 0)
	end, self, 0.01)
end

function NuoDiKaGameMapNodeItem:hideItemTip()
	gohelper.setActive(self._goitemtip, false)
	transformhelper.setLocalPos(self._goitemtip.transform, 0, 160, 0)
end

function NuoDiKaGameMapNodeItem:setNodeOffset(x, y)
	transformhelper.setLocalPos(self._goroot.transform, x, y, 0)
	transformhelper.setLocalPos(self._topgoroot.transform, x, y, 0)
end

function NuoDiKaGameMapNodeItem:showFade(fade)
	if fade then
		self._enemyAnim:Play("fade", 0, 0)
		self._enemyTopAni:Play("fade", 0, 0)
	else
		self._enemyAnim:Play("idle", 0, 0)
		self._enemyTopAni:Play("idle", 0, 0)
	end
end

function NuoDiKaGameMapNodeItem:getNodeRoot()
	return self._goroot
end

function NuoDiKaGameMapNodeItem:getNodeMo()
	return self._nodeMo
end

function NuoDiKaGameMapNodeItem:_endBlock()
	UIBlockMgr.instance:endBlock("interactAttack")
	UIBlockMgr.instance:endBlock("enemyDeadUnlock")
	UIBlockMgr.instance:endBlock("cloudUnlock")
	UIBlockMgr.instance:endBlock("enemyDead")
	UIBlockMgr.instance:endBlock("itemScan")
	UIBlockMgr.instance:endBlock("enemyHurt")
	TaskDispatcher.cancelTask(self._deadFinished, self)
	TaskDispatcher.cancelTask(self._scanFinished, self)
	TaskDispatcher.cancelTask(self._hurtFinished, self)
	TaskDispatcher.cancelTask(self._unlockAnimFinished, self)
	TaskDispatcher.cancelTask(self._unlockFinished, self)
	TaskDispatcher.cancelTask(self._enemyDeadUnlockFinished, self)
	TaskDispatcher.cancelTask(self._showInteractWarnFinished, self)
end

function NuoDiKaGameMapNodeItem:destroy()
	self:_endBlock()
	self:_removeEvents()
	self._simageenemy:UnLoadImage()
	self._simageitem:UnLoadImage()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
end

return NuoDiKaGameMapNodeItem
