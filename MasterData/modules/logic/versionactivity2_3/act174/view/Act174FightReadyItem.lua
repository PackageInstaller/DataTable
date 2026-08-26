-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174FightReadyItem.lua

module("modules.logic.versionactivity2_3.act174.view.Act174FightReadyItem", package.seeall)

local Act174FightReadyItem = class("Act174FightReadyItem", LuaCompBase)

function Act174FightReadyItem:ctor(readyView)
	self._readyView = readyView
end

function Act174FightReadyItem:init(go)
	self._go = go
	self.transform = go.transform
	self._imageNum = gohelper.findChildImage(go, "numbg/image_Num")

	CommonDragHelper.instance:registerDragObj(go, self.beginDrag, self.onDrag, self.endDrag, self.checkDrag, self, nil, true)
	self:initBattleHero()
end

function Act174FightReadyItem:addEventListeners()
	return
end

function Act174FightReadyItem:removeEventListeners()
	return
end

function Act174FightReadyItem:onDestroy()
	CommonDragHelper.instance:unregisterDragObj(self._go)
end

function Act174FightReadyItem:initBattleHero()
	self.heroItemList = {}

	for i = 1, 4 do
		local fightHeroGo = self._readyView:getResInst(Activity174Enum.PrefabPath.BattleHero, self._go)

		self.heroItemList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(fightHeroGo, Act174BattleHeroItem, self)
	end
end

function Act174FightReadyItem:setData(teamInfo, isEnemy)
	self.teamInfo = teamInfo
	self.reverse = isEnemy

	if teamInfo then
		self.index = teamInfo.index

		UISpriteSetMgr.instance:setAct174Sprite(self._imageNum, "act174_ready_num_0" .. self.index)
		self:refreshTeam()
	end
end

function Act174FightReadyItem:refreshTeam()
	if self.reverse then
		for i = 4, 1, -1 do
			local index = math.abs(i - 5)
			local info = Activity174Helper.MatchKeyInArray(self.teamInfo.battleHeroInfo, i, "index")

			self.heroItemList[index]:setIndex(i)
			self.heroItemList[index]:setData(info, self.teamInfo.index, true)
		end
	else
		for i = 1, 4 do
			local info = Activity174Helper.MatchKeyInArray(self.teamInfo.battleHeroInfo, i, "index")

			self.heroItemList[i]:setIndex(i)
			self.heroItemList[i]:setData(info, self.teamInfo.index, false)
		end
	end
end

function Act174FightReadyItem:beginDrag()
	self.isDraging = true
end

function Act174FightReadyItem:onDrag(params, pointerEventData)
	self:_tweenToPos(self._go.transform, pointerEventData.position)
	gohelper.setAsLastSibling(self._go)
end

function Act174FightReadyItem:endDrag(_, pointerEventData)
	self.isDraging = false

	local pos = pointerEventData.position
	local targetItem = self:findTarget(pos)

	if not targetItem then
		local targetTr = self._readyView.frameTrList[self.index]
		local anchorPos = recthelper.rectToRelativeAnchorPos(targetTr.position, self.transform.parent)

		self.setToPos(self, self._go.transform, anchorPos, true, self.tweenCallback, self)
	else
		local relativeRectTr = self.transform.parent
		local targetTr = self._readyView.frameTrList[targetItem.index]
		local anchorPos = recthelper.rectToRelativeAnchorPos(targetTr.position, relativeRectTr)

		self.setToPos(self, self.transform, anchorPos, true, self.tweenCallback, self)

		if targetItem ~= self then
			relativeRectTr = targetItem.transform.parent
			targetTr = self._readyView.frameTrList[self.index]
			anchorPos = recthelper.rectToRelativeAnchorPos(self._readyView.frameTrList[self.index].position, targetItem.transform.parent)

			local targetIndex = targetItem.index

			self.setToPos(self, targetItem.transform, anchorPos, true, function()
				self._readyView:exchangeItem(self.index, targetIndex)
			end, self)
		end
	end

	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_move)
end

function Act174FightReadyItem:checkDrag()
	if self._readyView.unLockTeamCnt == 1 or self.reverse or self.isDraging or self.tweenId then
		return true
	end
end

function Act174FightReadyItem:findTarget(position)
	for i = 1, self._readyView.unLockTeamCnt do
		local frameTr = self._readyView.frameTrList[i]
		local x, y = recthelper.getAnchor(frameTr)

		x = x - 416
		y = y + 276

		local readyItem = self._readyView.readyItemList[i]
		local anchorPos = recthelper.screenPosToAnchorPos(position, frameTr.parent)

		if math.abs((anchorPos.x - x) * 2) < recthelper.getWidth(frameTr) and math.abs((anchorPos.y - y) * 2) < recthelper.getHeight(frameTr) then
			return readyItem or nil
		end
	end

	return nil
end

function Act174FightReadyItem:setToPos(transform, anchorPos, tween, callback, callbackObj)
	if tween then
		CommonDragHelper.instance:setGlobalEnabled(false)

		self.tweenId = ZProj.TweenHelper.DOAnchorPos(transform, anchorPos.x, anchorPos.y, 0.2, callback, callbackObj)
	else
		recthelper.setAnchor(transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj)
		end
	end
end

function Act174FightReadyItem:tweenCallback()
	self.tweenId = nil

	CommonDragHelper.instance:setGlobalEnabled(true)
end

function Act174FightReadyItem:_tweenToPos(trans, position)
	local anchorPos = recthelper.screenPosToAnchorPos(position, trans.parent)
	local curAnchorX, curAnchorY = recthelper.getAnchor(trans)

	if math.abs(curAnchorX - anchorPos.x) > 10 or math.abs(curAnchorY - anchorPos.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(trans, anchorPos.x, anchorPos.y, 0.2)
	else
		recthelper.setAnchor(trans, anchorPos.x, anchorPos.y)
	end
end

return Act174FightReadyItem
