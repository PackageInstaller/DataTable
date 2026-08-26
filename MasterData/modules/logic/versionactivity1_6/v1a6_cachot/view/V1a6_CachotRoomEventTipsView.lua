-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRoomEventTipsView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomEventTipsView", package.seeall)

local V1a6_CachotRoomEventTipsView = class("V1a6_CachotRoomEventTipsView", BaseView)

function V1a6_CachotRoomEventTipsView:onInitView()
	self._goheros = gohelper.findChild(self.viewGO, "top/#go_herogroup")
	self._goheroparent = gohelper.findChild(self.viewGO, "top/#go_herogroup/layout")
	self._gohero = gohelper.findChild(self.viewGO, "top/#go_herogroup/heroitem")

	local eventId = V1a6_CachotConfig.instance:getConstConfig(V1a6_CachotEnum.Const.RecoverEvent).value

	self._recoverEventId = tonumber(eventId)
end

function V1a6_CachotRoomEventTipsView:addEvents()
	return
end

function V1a6_CachotRoomEventTipsView:removeEvents()
	return
end

function V1a6_CachotRoomEventTipsView:onOpen()
	self._heroItems = self:getUserDataTb_()

	gohelper.setActive(self._goheros, false)

	self._needShowCureEffect = V1a6_CachotController.instance.needShowCureEffect
	V1a6_CachotController.instance.needShowCureEffect = nil
	self._cureAddHp = V1a6_CachotController.instance.cureAddHp
	V1a6_CachotController.instance.cureAddHp = nil

	if self._needShowCureEffect then
		self:_onRoomChangePlayAnim()
	end

	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseViewFinishCall, self, LuaEventSystem.High)
	self.addEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.SelectHero, self._onSelectHero, self)
	self.addEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.OnEventFinish, self._onEventFinish, self)
	self.addEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.RoomChangePlayAnim, self._onRoomChangePlayAnim, self)
end

function V1a6_CachotRoomEventTipsView:_onRoomChangePlayAnim()
	if self._needShowCureEffect then
		self._needShowCureEffect = false

		self:_showCureEffect()
	end
end

function V1a6_CachotRoomEventTipsView:_onEventFinish(event)
	local eventCo = lua_rogue_event.configDict[event.eventId]

	if eventCo.type == V1a6_CachotEnum.EventType.CharacterCure then
		local cureCo = lua_rogue_event_life.configDict[eventCo.eventId]

		if cureCo then
			local arr = string.splitToNumber(cureCo.num, "#")
			local type = arr[1]
			local selectNum = arr[2]
			local num = cureCo.lifeAdd / 10

			self._cureData = {
				type,
				selectNum,
				num,
				event.eventId
			}

			if self:_showTipAtOnce() then
				self:_checkCure()
			end
		end
	elseif eventCo.type == V1a6_CachotEnum.EventType.CharacterRebirth then
		local reviveCo = lua_rogue_event_revive.configDict[eventCo.eventId]

		if reviveCo then
			local arr = string.splitToNumber(reviveCo.num, "#")
			local type = arr[1]
			local selectNum = arr[2]

			self._reviveData = {
				type,
				selectNum
			}

			if self:_showTipAtOnce() then
				self:_checkRevive()
			end
		end
	elseif eventCo.type == V1a6_CachotEnum.EventType.Tip then
		local tipsCo = lua_rogue_event_tips.configDict[eventCo.eventId]

		if tipsCo then
			V1a6_CachotEventController.instance:setPause(true, V1a6_CachotEnum.EventPauseType.Tips)
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CachotTips, ViewName.V1a6_CachotTipsView, {
				str = tipsCo.desc,
				style = V1a6_CachotEnum.TipStyle.Normal
			})
		end
	end
end

function V1a6_CachotRoomEventTipsView:_showTipAtOnce()
	return ViewMgr.instance:isOpen(ViewName.V1a6_CachotRewardView)
end

function V1a6_CachotRoomEventTipsView:_onSelectHero(mo)
	self._selectHeroMo = mo
end

function V1a6_CachotRoomEventTipsView:onCloseViewFinishCall(viewName)
	if viewName == ViewName.V1a6_CachotHeroGroupEditView and self._selectHeroMo then
		local tip = formatLuaLang("cachot_recruit", self._selectHeroMo.config.name)

		self._selectHeroMo = nil

		V1a6_CachotController.instance:openV1a6_CachotTipsView({
			str = tip,
			style = V1a6_CachotEnum.TipStyle.Normal
		})
	elseif viewName == ViewName.V1a6_CachotEpisodeView or viewName == ViewName.V1a6_CachotNormalStoreGoodsView then
		self:_checkCure()
		self:_checkRevive()
	elseif viewName == ViewName.V1a6_CachotRoleRecoverView then
		self:_checkCure()
	end
end

function V1a6_CachotRoomEventTipsView:_checkRevive()
	local reviveData = self._reviveData

	self._reviveData = nil

	if not reviveData then
		return
	end

	local type = reviveData[1]

	if type == 1 then
		-- block empty
	end
end

function V1a6_CachotRoomEventTipsView:_showRecoverFromReviveTip()
	local cureCo = lua_rogue_event_life.configDict[self._recoverEventId]
	local num = cureCo.lifeAdd / 10
	local tip = formatLuaLang("cachot_revival_nodead", tostring(num) .. "%")

	V1a6_CachotController.instance:openV1a6_CachotTipsView({
		str = tip,
		style = V1a6_CachotEnum.TipStyle.Normal
	})
end

function V1a6_CachotRoomEventTipsView:_markNeedShowCureEffect()
	self._needShowCureEffect = true

	if ViewMgr.instance:isOpen(ViewName.V1a6_CachotRewardView) and GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		V1a6_CachotController.instance.needShowCureEffect = true
		V1a6_CachotController.instance.cureAddHp = self._cureAddHp
	end
end

function V1a6_CachotRoomEventTipsView:_checkCure()
	local cureData = self._cureData

	self._cureData = nil

	if not cureData then
		return
	end

	local type = cureData[1]
	local hpValue = cureData[3]
	local eventId = cureData[4]

	self._cureAddHp = hpValue > 0
	hpValue = math.abs(hpValue)

	if eventId == self._recoverEventId then
		self:_markNeedShowCureEffect()
		self:_showRecoverFromReviveTip()

		return
	end

	if type == 1 then
		self:_markNeedShowCureEffect()
	elseif type == 2 then
		local lifes = V1a6_CachotModel.instance:getChangeLifes()
		local heroNameList = ""

		if lifes then
			for i, v in ipairs(lifes) do
				local heroMO = HeroModel.instance:getByHeroId(v.heroId)

				if heroMO then
					heroNameList = string.nilorempty(heroNameList) and heroMO.config.name or heroNameList .. "、" .. heroMO.config.name
				end
			end
		end

		local hpValueStr = tostring(hpValue) .. "%%"

		if self._cureAddHp then
			local tip = luaLang("cachot_multi_add_hp")

			V1a6_CachotController.instance:openV1a6_CachotTipsView({
				str = tip,
				style = V1a6_CachotEnum.TipStyle.Normal,
				strExtra = {
					heroNameList,
					hpValueStr
				}
			})
		else
			local tip = luaLang("cachot_multi_reduce_hp")

			V1a6_CachotController.instance:openV1a6_CachotTipsView({
				str = tip,
				style = V1a6_CachotEnum.TipStyle.Normal,
				strExtra = {
					heroNameList,
					hpValueStr
				}
			})
		end

		self:_markNeedShowCureEffect()
	elseif type == 3 then
		self:_markNeedShowCureEffect()

		local hpValueStr = tostring(hpValue) .. "%"

		if self._cureAddHp then
			local tip = formatLuaLang("cachot_team_add_hp", hpValueStr)

			V1a6_CachotController.instance:openV1a6_CachotTipsView({
				str = tip,
				style = V1a6_CachotEnum.TipStyle.Normal
			})
		else
			local tip = formatLuaLang("cachot_team_reduce_hp", hpValueStr)

			V1a6_CachotController.instance:openV1a6_CachotTipsView({
				str = tip,
				style = V1a6_CachotEnum.TipStyle.Normal
			})
		end
	end
end

function V1a6_CachotRoomEventTipsView:_restrictChangeData(changeData)
	local maxNum = 4

	if maxNum >= #changeData then
		return changeData
	end

	local teamInfo = V1a6_CachotModel.instance:getTeamInfo()
	local groupHeroList = {}
	local curGroupInfo = teamInfo:getCurGroupInfo()

	if curGroupInfo then
		for _, v in ipairs(curGroupInfo.heroList) do
			local heroMo = HeroModel.instance:getById(v)

			if heroMo then
				local nowHp = teamInfo:getHeroHp(heroMo.heroId)

				if nowHp.life > 0 then
					groupHeroList[heroMo.heroId] = true
				end
			end
		end
	end

	local result = {}

	for i, v in ipairs(changeData) do
		if groupHeroList[v.heroId] then
			table.insert(result, v)
		end
	end

	if #result == maxNum then
		return result
	end

	for i = 1, maxNum - #result do
		for _, v in ipairs(changeData) do
			if not groupHeroList[v.heroId] then
				table.insert(result, v)

				groupHeroList[v.heroId] = true

				break
			end
		end
	end

	return result
end

function V1a6_CachotRoomEventTipsView:_showCureEffect()
	local lifes = V1a6_CachotModel.instance:getChangeLifes()

	if not lifes then
		return
	end

	local teamInfo = V1a6_CachotModel.instance:getTeamInfo()

	self._hpChangeData = {}

	for i, v in ipairs(lifes) do
		local hpInfo = teamInfo:getHeroHp(v.heroId)

		table.insert(self._hpChangeData, {
			total = 1000,
			heroId = v.heroId,
			preVal = v.life,
			nowVal = hpInfo.life
		})
	end

	self._hpChangeData = self:_restrictChangeData(self._hpChangeData)

	gohelper.setActive(self._goheros, true)
	gohelper.CreateObjList(self, self._onItemLoad, self._hpChangeData, self._goheroparent, self._gohero)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, self._tweenUpdate, self._tweenEnd, self, nil, EaseType.Linear)

	self:_tweenUpdate(0)

	for i = #self._hpChangeData + 1, #self._heroItems do
		local item = self._heroItems[i]

		gohelper.setActive(item and item.go, false)
	end

	TaskDispatcher.cancelTask(self._delayFinish, self)
	TaskDispatcher.runDelay(self._delayFinish, self, 2.1)
end

function V1a6_CachotRoomEventTipsView:_delayFinish()
	gohelper.setActive(self._goheros, false)
end

function V1a6_CachotRoomEventTipsView:_onItemLoad(obj, data, index)
	local item = self._heroItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = obj
		item.animator = obj:GetComponent("Animator")
		item.slider = gohelper.findChildSlider(obj, "#slider_hp")
		item.icon = gohelper.findChildSingleImage(obj, "hero/#simage_rolehead")
		item.arrowred = gohelper.findChildImage(obj, "arrow_red")
		item.arrowgreen = gohelper.findChildImage(obj, "arrow_green")
		self._heroItems[index] = item
	end

	local heroMO = HeroModel.instance:getByHeroId(data.heroId)
	local skinCo = lua_skin.configDict[heroMO.skin]

	item.icon:LoadImage(ResUrl.getHeadIconSmall(skinCo.headIcon))
	gohelper.setActive(item.arrowred, not self._cureAddHp)
	gohelper.setActive(item.arrowgreen, self._cureAddHp)
	gohelper.setActive(item.go, true)

	if self._cureAddHp then
		item.animator:Play("healthy", 0, 0)
	else
		item.animator:Play(data.nowVal <= 0 and "die" or "hit", 0, 0)
	end
end

function V1a6_CachotRoomEventTipsView:_tweenUpdate(val)
	for i, v in ipairs(self._hpChangeData) do
		self._heroItems[i].slider:SetValue(Mathf.Lerp(v.preVal, v.nowVal, val) / v.total)
	end
end

function V1a6_CachotRoomEventTipsView:_tweenEnd()
	self._tweenId = nil
end

function V1a6_CachotRoomEventTipsView:onClose()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	TaskDispatcher.cancelTask(self._delayFinish, self)
end

return V1a6_CachotRoomEventTipsView
