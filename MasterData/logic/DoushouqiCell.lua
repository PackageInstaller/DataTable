-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqiCell.lua

module("logic.extensions.doushouqi.view.DoushouqiCell", package.seeall)

local DoushouqiCell = class("DoushouqiCell")

function DoushouqiCell:ctor(go, gameView, mo, activityId)
	self._activityId = activityId
	self._gameView = gameView
	self._go = go
	self._mo = mo
	self._posx = 0
	self._posy = 0
	self._scale = 1
	self._pointId = 0

	self:_buildUI()
	self:updateUI()
end

function DoushouqiCell:_buildUI()
	self._btn = Framework.ButtonAdapter.GetFrom(self._go, "btn")
	self._iconChange = goutil.findChild(self._go, "btn/bottom/icon"):GetComponent(ComponentType.UIImageSpriteChange)
	self._imgIcon = goutil.findChild(self._go, "btn/bottom/icon"):GetComponent(goutil.Type_UIImage)
	self._goBottom = goutil.findChild(self._go, "btn/bottom")
	self._goLock = goutil.findChild(self._go, "btn/lock")
	self._goTag = goutil.findChild(self._go, "btn/tag")
	self._goTags = goutil.findChild(self._go, "btn/tags")
	self._tagsLayout = goutil.findChild(self._go, "btn/tags"):GetComponent(ComponentType.UILayoutSingleLine)
	self._goEffect = goutil.findChild(self._go, "effect")
	self._txtKezhi = goutil.findChildTextComponent(self._go, "btn/kezhi/txtKezhi")
	self._goKezhi = goutil.findChild(self._go, "btn/kezhi")
	self._kezhiImgChange = self._goKezhi:GetComponent(ComponentType.UIImageSpriteChange)
	self._bottomChange = self._goBottom:GetComponent(ComponentType.UIImageSpriteChange)
	self._tweenPos = self._go:GetComponent(UnityTweensType.TweenPosition)

	self._tweenPos:Stop()

	self._tweenScale = self._go:GetComponent(UnityTweensType.TweenScale)

	self._tweenScale:Stop()

	self._cacheV3 = Vector3.New(0, 0, 0)

	self:_bindEvents()
	goutil.setActive(self._goTag, false)
end

function DoushouqiCell:_unbindEvents()
	self._btn:RemoveClickListener()
end

function DoushouqiCell:_bindEvents()
	self._btn:AddClickListener(self._onClickCell, self)
end

function DoushouqiCell:destroy()
	self:_unbindEvents()
	self:_clearSelectEffect()
	self:_clearShanguangEffect()
	self:_clearGedangEffect()
	self:_clearHuhuanEffect()
	goutil.destroy(self._go)

	self._go = nil
	self._gameView = nil
	self._mo = nil
end

function DoushouqiCell:setData(data)
	self._mo:setData(data)
end

function DoushouqiCell:_onClickCell()
	GlobalDispatcher:dispatch(GlobalNotify.DoushouqiSetMyOperation)
	self:_clearSelectEffect()

	if DoushouqiGameController.instance:getIsBeforeUseSkill() then
		self:_onUseSkillSelect()
	else
		self:_onNormalSelect()
	end
end

function DoushouqiCell:_onNormalSelect()
	printInfo("DoushouqiCell 开始点击格子")

	if not self._mo then
		printInfo("DoushouqiCell 没有数据")

		return
	end

	if DoushouqiGameController.instance:isMoving() then
		printInfo("DoushouqiCell 格子正在移动")

		return
	end

	local selectMo = DoushouqiGameController.instance:getSelectMo()

	if self._mo:isEmpty() and not selectMo then
		printInfo("DoushouqiCell 空格子")

		return
	end

	if not DoushouqiGameController.instance:isMyRound() then
		FloatWordMgr.instance:show("还没有到你的回合")

		return
	end

	local pointId = self:getPointId()
	local actionId = DoushouqiModel.instance:getCurActionId()
	local counterAttackpointId = DoushouqiGameController.instance:getCounterAttackPointId()

	if not selectMo and counterAttackpointId > -1 and pointId ~= counterAttackpointId then
		FloatWordMgr.instance:show("只能操作连击棋子")

		return
	end

	if selectMo then
		if pointId == selectMo:getPointId() then
			printInfo("DoushouqiCell 点击同一个cell")
			DoushouqiGameController.instance:clearSelectMo()

			return
		end

		if DoushouqiGameController.instance:isCanMove(selectMo:getPointId(), pointId) then
			if self._mo:isBlock() and DoushouqiGameController.instance:isCanEat(selectMo:getPointId(), pointId) then
				GameUtil.clickEnabled(false, self._gameView)
				self:playGedangEffect(function()
					GameUtil.clickEnabled(true, self._gameView)
					BeastFightingChessAgent.instance:sendBeastFightingChessMoveReq(self._activityId, selectMo:getPointId(), pointId, actionId)
				end)
			else
				DoushouqiGameController.instance:moveTo(selectMo:getPointId(), pointId)
			end
		else
			if not self._mo:isEmpty() and self._mo:isUnlock() and self:_isMySide() then
				DoushouqiGameController.instance:clearSelectMo()
				DoushouqiGameController.instance:tryShowCanMoveCells(self._mo)

				return
			end

			if not self._mo:isEmpty() and not self._mo:isUnlock() then
				DoushouqiGameController.instance:clearSelectMo()
				DoushouqiGameController.instance:unlockCell(pointId)

				return
			end
		end

		return
	end

	if self._mo:isUnlock() and not self:_isMySide() then
		FloatWordMgr.instance:show("不是你方棋子")

		return
	end

	if not self._mo:isUnlock() then
		if self._mo:isInvisibility() then
			FloatWordMgr.instance:show("隐身棋子无法操作")

			return
		end

		DoushouqiGameController.instance:unlockCell(pointId)

		return
	end

	if self._mo:isStrikeVertigo() then
		FloatWordMgr.instance:show("被眩晕中")

		return
	end

	DoushouqiGameController.instance:tryShowCanMoveCells(self._mo)
	self:_showSelectEffect()
end

function DoushouqiCell:_onUseSkillSelect()
	local skillId = DoushouqiModel.instance:getMySkillId()
	local skillCfg = DoushouqiConfig.instance:getSkillCfg(self._activityId, skillId)

	printInfo("DoushouqiCell 开始点击格子")

	if not self._mo then
		printInfo("DoushouqiCell 没有数据")

		return
	end

	if DoushouqiGameController.instance:isMoving() then
		printInfo("DoushouqiCell 格子正在移动")

		return
	end

	local selectMo = DoushouqiGameController.instance:getSelectMo()

	if self._mo:isEmpty() then
		printInfo("DoushouqiCell 空格子")

		return
	end

	if not DoushouqiGameController.instance:isMyRound() then
		FloatWordMgr.instance:show("还没有到你的回合")

		return
	end

	if not self:_isMySide() then
		FloatWordMgr.instance:show("不是你方棋子")

		return
	end

	if not self._mo:isUnlock() then
		FloatWordMgr.instance:show("未解锁的棋子，无法选择")

		return
	end

	if self._mo:isStrikeVertigo() and not skillCfg.skillId == DoushouqiGameController.SkillType.Lianji then
		FloatWordMgr.instance:show("棋子被眩晕中")

		return
	end

	local targetPointId = self:getPointId()
	local counterAttackpointId = DoushouqiGameController.instance:getCounterAttackPointId()

	if counterAttackpointId > -1 and targetPointId ~= counterAttackpointId then
		FloatWordMgr.instance:show("只能操作连击棋子")

		return
	end

	self:_playGeziliangEffect()

	local actionId = DoushouqiModel.instance:getCurActionId()
	local param = ""

	if skillCfg.skillId == DoushouqiGameController.SkillType.Zhuanhuo then
		printInfo("DoushouqiCell 设置转火 ", targetPointId)
		DoushouqiGameController.instance:insertZhuanhuoPointId(targetPointId)
		printInfo("DoushouqiCell 设置转火 够了吗", DoushouqiGameController.instance:getIsZhuanhuoPointIdsEnough())

		if not DoushouqiGameController.instance:getIsZhuanhuoPointIdsEnough() then
			return
		end

		param = DoushouqiGameController.instance:getZhuanhuoPointIdsParamStr()
	end

	DoushouqiGameController.instance:sendBeastFightingChessReleaseSkillReq(self._activityId, skillId, targetPointId, param, actionId)
end

function DoushouqiCell:updateUI()
	self:_clearSelectEffect()
	self:_clearShanguangEffect()
	self:_clearGedangEffect()
	self:_clearHuhuanEffect()
	self:_clearPengzhuangEffect()
	self._tweenPos:Stop()

	local isEmpty = self._mo:isEmpty()
	local isUnlock = self._mo:isUnlock()
	local isKnow = self._mo:isKnow()

	GoUtil.SetImageAlpha(self._imgIcon, 1)

	if isKnow then
		GoUtil.SetImageAlpha(self._imgIcon, 0.5)
		goutil.setActive(self._goLock, false)
		goutil.setActive(self._goBottom, true)
	elseif not isEmpty and isUnlock then
		goutil.setActive(self._goLock, false)
		goutil.setActive(self._goBottom, true)
	elseif isEmpty then
		goutil.setActive(self._goLock, false)
		goutil.setActive(self._goBottom, false)
	else
		goutil.setActive(self._goLock, true)
		goutil.setActive(self._goBottom, false)
	end

	local x, y = self:getPos()
	local scale = self:getScale()

	Framework.TransformUtil.SetAnchoredPos(self._go.transform, x, y)
	Framework.TransformUtil.SetLocalScale(self._go.transform, scale, scale, 1)

	if not isEmpty and (isUnlock or isKnow) then
		local resName = DoushouqiConfig.instance:getDoushouqiResName(isKnow and self._mo:getKonwLevel() or self._mo:getLevel())

		self._iconChange:ChangeSprite(resName)
	end

	self:_setBottomUI()
	self:_setTag()
	self:_setKezhi(false)
end

function DoushouqiCell:_setBottomUI()
	local isKnow = self._mo:isKnow()
	local isMyCell = (isKnow and self._mo:getKnowSideId() or self._mo:getSideId()) == DoushouqiGameController.instance:getMySideId()

	self._bottomChange:SetState(isMyCell and 1 or 0)
end

function DoushouqiCell:lightBottom()
	self:_setKezhi(true)
	self:_playGeziliangEffect()
end

function DoushouqiCell:unlightBottom()
	self:_setKezhi(false)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function DoushouqiCell:getMo()
	return self._mo
end

function DoushouqiCell:moveTo(posx, posy, scale, destEmpty)
	self._destEmpty = destEmpty

	self:_setTweenParams(posx, posy, scale)
	self._tweenPos:AddListener(self._moveFinish, self)
	self._tweenScale:Begin()
	self._tweenPos:Begin()
end

function DoushouqiCell:moveToWithCallBack(posx, posy, scale, finishCallBack)
	self:_setTweenParams(posx, posy, scale)
	self._tweenPos:AddListener(function()
		self._tweenPos:RemoveListener()
		self._tweenPos:Stop()
		self._tweenScale:Stop()
		finishCallBack()
	end)
	self._tweenScale:Begin()
	self._tweenPos:Begin()
end

function DoushouqiCell:_moveFinish()
	self._tweenPos:RemoveListener()
	self._tweenPos:Stop()
	self._tweenScale:Stop()

	if self._destEmpty then
		DoushouqiGameController.instance:moveFinish()
	else
		self:_playPengzhuangEffect(function()
			DoushouqiGameController.instance:moveFinish()
		end)
	end
end

function DoushouqiCell:setPos(x, y)
	self._posx = x
	self._posy = y
end

function DoushouqiCell:setScale(scale)
	self._scale = scale
end

function DoushouqiCell:setPointId(pointId)
	self._pointId = pointId
end

function DoushouqiCell:getPointId()
	return self._pointId
end

function DoushouqiCell:getScale()
	return self._scale
end

function DoushouqiCell:getPos()
	return self._posx, self._posy
end

function DoushouqiCell:_setTag()
	local isEmpty = self._mo:isEmpty()

	if isEmpty then
		goutil.setActive(self._goTags, false)

		return
	end

	local isUnlock = self._mo:isUnlock()
	local isKnow = self._mo:isKnow()
	local isBlock = self._mo:isBlock()
	local isStrikeVertigo = self._mo:isStrikeVertigo()
	local isInvisibility = self._mo:isInvisibility()
	local isCounterAttack = self._mo:isCounterAttack()
	local isStrike = self._mo:isStrike()
	local show = isKnow or isBlock and isUnlock or isStrikeVertigo or isInvisibility or isCounterAttack or isStrike and isUnlock

	goutil.setActive(self._goTags, show)

	local childItems = {}

	for i = 1, self._goTags.transform.childCount do
		table.insert(childItems, self._goTags.transform:GetChild(i - 1).gameObject)
		goutil.setActive(childItems[i], false)
	end

	local datas = {}

	if isKnow then
		table.insert(datas, {
			name = "先知"
		})
	end

	if isBlock then
		table.insert(datas, {
			name = "格挡"
		})
	end

	if isStrikeVertigo then
		table.insert(datas, {
			name = "眩晕"
		})
	end

	if isInvisibility then
		table.insert(datas, {
			name = "隐身"
		})
	end

	if isCounterAttack then
		table.insert(datas, {
			name = "连击"
		})
	end

	if isStrike then
		table.insert(datas, {
			name = "反击"
		})
	end

	for i = 1, #datas do
		local go = childItems[i]

		go = go or goutil.cloneAndSetParent(self._goTag, self._goTags.transform)

		local txtTag = goutil.findChildTextComponent(go, "txtTag")

		txtTag.text = datas[i].name

		goutil.setActive(go, true)
	end

	self._tagsLayout:Layout()
end

function DoushouqiCell:_setTweenParams(posx, posy, scale)
	local x, y = self:getPos()

	self._cacheV3.x = x
	self._cacheV3.y = y
	self._cacheV3.z = 0
	self._tweenPos.from = self._cacheV3
	self._cacheV3.x = posx
	self._cacheV3.y = posy
	self._tweenPos.to = self._cacheV3
	self._cacheV3.x = self._scale
	self._cacheV3.y = self._scale
	self._cacheV3.z = 1
	self._tweenScale.from = self._cacheV3
	self._cacheV3.x = scale
	self._cacheV3.y = scale
	self._tweenScale.to = self._cacheV3
end

function DoushouqiCell:_showSelectEffect()
	local mo = DoushouqiGameController.instance:getSelectMo()

	if not mo or mo:getPointId() ~= self:getPointId() then
		return
	end

	self:_playGeziliangEffect()
end

function DoushouqiCell:_clearSelectEffect()
	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function DoushouqiCell:_isMySide()
	return self._mo:getSideId() == DoushouqiGameController.instance:getMySideId()
end

function DoushouqiCell:_playGeziliangEffect()
	local effName = "20240927/aoqidoushouqi/fx_ui_aqdsq_geziliang.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self._gameView, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._goEffect.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(-9, 15, 0)
end

function DoushouqiCell:playShanguangEffect()
	local effName = "20240927/aoqidoushouqi/fx_ui_aqdsq_shanguang.prefab"

	self._shanguangEffectHandler = UIEffectManager.instance:playEffect(self._gameView, effName, nil, 0, 0, false)

	self._shanguangEffectHandler:setParent(self._goEffect.transform)
	self._shanguangEffectHandler:setScale(1)
	self._shanguangEffectHandler:setLocalPos(0, 0, 0)
end

function DoushouqiCell:_clearShanguangEffect()
	if self._shanguangEffectHandler then
		UIEffectManager.instance:stopEffect(self._shanguangEffectHandler)

		self._shanguangEffectHandler = nil
	end
end

function DoushouqiCell:playGedangEffect(callback)
	local effName = "20240927/aoqidoushouqi/fx_ui_aqdsq_gedang.prefab"

	self._gedangEffectHandler = UIEffectManager.instance:playEffect(self._gameView, effName, nil, 0, 0, false, nil, callback)

	self._gedangEffectHandler:setParent(self._goEffect.transform)
	self._gedangEffectHandler:setScale(1.2)
	self._gedangEffectHandler:setLocalPos(-3, 42, 0)
end

function DoushouqiCell:_clearGedangEffect()
	if self._gedangEffectHandler then
		UIEffectManager.instance:stopEffect(self._gedangEffectHandler)

		self._gedangEffectHandler = nil
	end
end

function DoushouqiCell:playHuhuanEffect(callback)
	local effName = "20240927/aoqidoushouqi/fx_ui_aqdsq_huhuan.prefab"

	self._huhuanEffectHandler = UIEffectManager.instance:playEffect(self._gameView, effName, nil, 0, 0, false, nil, callback)

	self._huhuanEffectHandler:setParent(self._goEffect.transform)
	self._huhuanEffectHandler:setScale(1)
	self._huhuanEffectHandler:setLocalPos(0, 0, 0)
end

function DoushouqiCell:_clearHuhuanEffect()
	if self._huhuanEffectHandler then
		UIEffectManager.instance:stopEffect(self._huhuanEffectHandler)

		self._huhuanEffectHandler = nil
	end
end

function DoushouqiCell:_playPengzhuangEffect(callback)
	local effName = "20240927/aoqidoushouqi/fx_ui_aqdsq_pengzhuang.prefab"

	self._pengzhuangEffectHandler = UIEffectManager.instance:playEffect(self._gameView, effName, nil, 0, 45, false, nil, callback)

	self._pengzhuangEffectHandler:setParent(self._goEffect.transform)
	self._pengzhuangEffectHandler:setScale(1)
	self._pengzhuangEffectHandler:setLocalPos(0, 0, 0)
end

function DoushouqiCell:_clearPengzhuangEffect()
	if self._pengzhuangEffectHandler then
		UIEffectManager.instance:stopEffect(self._pengzhuangEffectHandler)

		self._pengzhuangEffectHandler = nil
	end
end

function DoushouqiCell:setAsLastSibling()
	self._go.transform:SetAsLastSibling()
end

function DoushouqiCell:_setKezhi(flag)
	if flag then
		if self._mo:isEmpty() then
			goutil.setActive(self._goKezhi, false)

			return
		end

		local mo = DoushouqiGameController.instance:getSelectMo()

		if mo and mo:getPointId() ~= self:getPointId() then
			if self._mo:getLevel() == 8 and mo:getLevel() == 1 or self._mo:getLevel() > mo:getLevel() then
				self._txtKezhi.text = "被\n克\n制"

				self._kezhiImgChange:SetState(1)
			elseif self._mo:getLevel() == 1 and mo:getLevel() == 8 or self._mo:getLevel() < mo:getLevel() then
				self._txtKezhi.text = "克\n制"

				self._kezhiImgChange:SetState(0)
			else
				flag = false
			end
		end
	end

	goutil.setActive(self._goKezhi, flag)
end

return DoushouqiCell
