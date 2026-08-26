-- chunkname: @modules/logic/bossrush/view/FightViewBossHpBossRushAction.lua

module("modules.logic.bossrush.view.FightViewBossHpBossRushAction", package.seeall)

local FightViewBossHpBossRushAction = class("FightViewBossHpBossRushAction", FightBaseView)

function FightViewBossHpBossRushAction:onInitView()
	self._moveRoot = gohelper.findChild(self.viewGO, "mask/moveRoot/moveRootScript").transform
	self._content = gohelper.findChild(self.viewGO, "mask/moveRoot/moveRootScript/root/Content")
	self._opItem = gohelper.findChild(self.viewGO, "mask/moveRoot/moveRootScript/root/Content/op")
	self._btn = gohelper.findChildButton(self.viewGO, "btn")
	self._ani = SLFramework.AnimatorPlayer.Get(self.viewGO)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewBossHpBossRushAction:addEvents()
	self:com_registFightEvent(FightEvent.OnMonsterChange, self._onMonsterChange)
	self:com_registFightEvent(FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish)
	self:com_registFightEvent(FightEvent.OnEntityDead, self._onEntityDead)
	self:com_registFightEvent(FightEvent.OnBuffUpdate, self._onBuffUpdate)
	self:com_registClick(self._btn, self._ontBtnClick)
end

function FightViewBossHpBossRushAction:removeEvents()
	return
end

function FightViewBossHpBossRushAction:_editableInitView()
	gohelper.setActive(self.viewGO, true)
end

function FightViewBossHpBossRushAction:_ontBtnClick()
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if not self._curDataList or #self._curDataList == 0 then
		return
	end

	if not self._bossEntityMO then
		return
	end

	local data = {
		entityId = self._bossEntityMO.id,
		dataList = LuaUtil.deepCopySimple(self._curDataList)
	}

	ViewMgr.instance:openView(ViewName.FightActionBarPopView, data)
end

function FightViewBossHpBossRushAction:onOpen()
	self:_refreshActData()
	self:_refreshRoundShow()
end

function FightViewBossHpBossRushAction:_onMonsterChange(oldEntityMO)
	if self._bossEntityMO and oldEntityMO.id == self._bossEntityMO.id then
		self:_refreshActData(1)
	end
end

function FightViewBossHpBossRushAction:_onEntityDead(entityId)
	if self._bossEntityMO and self._bossEntityMO.id == entityId then
		self:_refreshActData(1)
	end
end

function FightViewBossHpBossRushAction:_onBuffUpdate(targetId, effectType, buffId, buffUid)
	if self._bossEntityMO and self._bossEntityMO.id == targetId and effectType == FightEnum.EffectType.BUFFADD and buffId == 514000102 then
		local list = {}

		tabletool.addValues(list, self._curDataList)
		tabletool.addValues(list, self._actList)

		for i, v in ipairs(list) do
			for index, skillData in ipairs(v) do
				if skillData.isChannelPosedSkill then
					skillData.forbidden = true

					FightController.instance:dispatchEvent(FightEvent.ForbidBossRushHpChannelSkillOpItem, skillData)

					return
				end
			end
		end
	end
end

function FightViewBossHpBossRushAction:_refreshActData(offsetRound)
	self._curRound = FightModel.instance:getCurRoundId() + (offsetRound or 0)
	self._maxRound = FightModel.instance:getMaxRound()
	self._actList = {}
	self._curDataList = {}

	local battleId = FightModel.instance:getBattleId()
	local parentView = self.PARENT_VIEW

	self._bossEntityMO = parentView._bossEntityMO

	if self._bossEntityMO then
		local monsterId = self._bossEntityMO.modelId

		if lua_boss_action.configDict[battleId] then
			local config = lua_boss_action.configDict[battleId][monsterId]

			if config then
				local actionId = config.actionId

				config = lua_boss_action_list.configDict[actionId]

				if lua_boss_action_list.configDict[actionId] then
					local index = 0
					local curRound = self._curRound

					while curRound <= self._maxRound do
						for i = 1, config.circle do
							index = index + 1

							if not self._actList[index] then
								local skillList = {}
								local action = config["actionId" .. i]

								if action == "noAction" then
									if #skillList == 0 then
										table.insert(skillList, {
											skillId = 0
										})
									end
								else
									local strArr = FightStrUtil.instance:getSplitCache(action, "#")
									local skillArr

									if not tonumber(strArr[1]) then
										skillArr = {}

										local arr = FightStrUtil.instance:getSplitCache(action, "|")
										local skillId = tonumber(arr[#arr])

										if skillId then
											skillArr[1] = skillId
										end
									else
										skillArr = FightStrUtil.instance:getSplitToNumberCache(action, "#")
									end

									for _, skillId in ipairs(skillArr) do
										local isChannel, channelSkillId, channelRound = FightHelper.isBossRushChannelSkill(skillId)

										if isChannel then
											local playRound = index + channelRound

											if playRound <= self._maxRound then
												self._actList[playRound] = self._actList[playRound] or {}

												table.insert(self._actList[playRound], {
													isChannelPosedSkill = true,
													skillId = channelSkillId
												})
											end

											table.insert(skillList, {
												isChannelSkill = true,
												round = channelRound,
												skillId = skillId
											})
										else
											table.insert(skillList, {
												skillId = skillId
											})
										end
									end
								end

								self._actList[index] = skillList
								curRound = curRound + 1

								if curRound > self._maxRound then
									break
								end
							end
						end
					end
				end
			end
		end
	end
end

local maxCard = 10

function FightViewBossHpBossRushAction:_refreshRoundShow()
	self._cardCount = 0

	for i = 1, maxCard do
		if not self._curDataList[i] then
			local act = table.remove(self._actList, 1)

			if act then
				table.insert(self._curDataList, act)
			end
		end
	end

	self:com_createObjList(self._onRoundSkillShow, self._curDataList, self._content, self._opItem)
end

function FightViewBossHpBossRushAction:_releaseTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function FightViewBossHpBossRushAction:_onRoundSequenceFinish()
	if #self._curDataList > 0 then
		local skillList = table.remove(self._curDataList, 1)

		self:_releaseTween()

		local posX = recthelper.getWidth(self._content.transform:GetChild(0))

		self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._moveRoot, -posX, 0.3, self._onTweenEnd, self)
	else
		if self.viewGO.activeInHierarchy then
			self._ani:Play("update", nil, nil)
		end

		TaskDispatcher.runDelay(self._refreshRoundShow, self, 0.16)
	end
end

function FightViewBossHpBossRushAction:_onTweenEnd()
	self:_refreshRoundShow()
	recthelper.setAnchorX(self._moveRoot, 0)
end

function FightViewBossHpBossRushAction:_onRoundSkillShow(obj, data, index)
	if self._cardCount >= maxCard then
		gohelper.setActive(obj, false)

		return
	end

	gohelper.setActive(obj, true)

	local list = {
		0
	}

	tabletool.addValues(list, data)

	local item = gohelper.findChild(obj, "item")

	self:com_createObjList(self._onOpSkillShow, list, obj, item)
end

function FightViewBossHpBossRushAction:_onOpSkillShow(obj, data, index)
	if index == 1 then
		return
	end

	self._cardCount = self._cardCount + 1

	if self._cardCount > maxCard then
		gohelper.setActive(obj, false)

		return
	end

	gohelper.setActive(obj, true)

	self._opItemClassDic = self._opItemClassDic or {}
	self._opItemClassDic[self._cardCount] = self._opItemClassDic[self._cardCount] or self:com_openSubView(FightViewBossHpBossRushActionOpItem)

	self._opItemClassDic[self._cardCount]:refreshUI(obj, data)
end

function FightViewBossHpBossRushAction:onClose()
	TaskDispatcher.cancelTask(self._refreshRoundShow, self)
	self:_releaseTween()
end

function FightViewBossHpBossRushAction:onDestroyView()
	return
end

return FightViewBossHpBossRushAction
