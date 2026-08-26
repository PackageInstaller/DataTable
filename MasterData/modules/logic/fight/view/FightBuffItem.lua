-- chunkname: @modules/logic/fight/view/FightBuffItem.lua

module("modules.logic.fight.view.FightBuffItem", package.seeall)

local FightBuffItem = class("FightBuffItem", LuaCompBase)

function FightBuffItem:init(go)
	self.go = go
	self.tr = go.transform
	self._imgIcon = gohelper.findChildImage(go, "icon")
	self._txtBadBuff = gohelper.findChildText(go, "badText")
	self._txtGoodBuff = gohelper.findChildText(go, "goodText")
	self._txtBadCount = gohelper.findChildText(go, "badText_count")
	self._txtGoodCount = gohelper.findChildText(go, "goodText_count")
	self._bgIcon = gohelper.findChildImage(go, "bg")
	self.bgeffect = gohelper.findChild(go, "bgeffect")
	self.buffquan = gohelper.findChild(go, "buffquan")
	self.bufffinish = gohelper.findChild(go, "bufffinish")
	self.buffdot = gohelper.findChild(go, "buffdot")
	self._animator = go:GetComponent(typeof(UnityEngine.Animator))
	self._click = gohelper.getClick(go)

	gohelper.addUIClickAudio(go, AudioEnum.UI.UI_Common_Click)

	self._tipsOffsetX = 0
	self._tipsOffsetY = 0

	self:closeAni()
end

function FightBuffItem:addEventListeners()
	self._click:AddClickListener(self._onClick, self)
end

function FightBuffItem:removeEventListeners()
	self._click:RemoveClickListener()
end

function FightBuffItem:setClickCallback(callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj
end

function FightBuffItem:_onClick()
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	if self._callback then
		self._callback(self._callbackObj, self.buffMO.entityId)
	else
		FightController.instance:dispatchEvent(FightEvent.OnBuffClick, self.buffMO.entityId, self.tr, self._tipsOffsetX, self._tipsOffsetY)
	end
end

function FightBuffItem:setTipsOffset(x, y)
	self._tipsOffsetX = x
	self._tipsOffsetY = y
end

function FightBuffItem:updateBuffMO(buffMO)
	if self.buffMO and self.buffMO.buffId ~= buffMO.buffId and not FightHelper.shouUIPoisoningEffect(buffMO.buffId) then
		self:_hidePoisoningEffect()
	end

	self.buffMO = buffMO

	local buffCO = lua_skill_buff.configDict[buffMO.buffId]

	if buffCO then
		gohelper.onceAddComponent(self.go, gohelper.Type_CanvasGroup).alpha = 1

		local buffIconId = buffCO.iconId

		if string.nilorempty(buffIconId) or buffIconId == "0" then
			logError(string.format("try show buff icon, but buffId : %s, buffName : %s, buffIconId : %s", buffCO.id, buffCO.name, buffIconId))
		else
			UISpriteSetMgr.instance:setBuffSprite(self._imgIcon, buffCO.iconId)
		end

		self:refreshTxt(buffMO, buffCO)

		local buffTypeCo = lua_skill_bufftype.configDict[buffCO.typeId]

		if self:isTimeBuff(buffCO) then
			gohelper.setActive(self._bgIcon.gameObject, true)
			UISpriteSetMgr.instance:setFightSprite(self._bgIcon, "buff_jishiqi_" .. self:calculateBuffType(buffTypeCo.type))
		elseif buffTypeCo.cannotRemove then
			UISpriteSetMgr.instance:setFightSprite(self._bgIcon, "buff_bukechexiao_" .. self:calculateBuffType(buffTypeCo.type))
			gohelper.setActive(self._bgIcon.gameObject, true)
		else
			gohelper.setActive(self._bgIcon.gameObject, false)
		end
	else
		logError("buff config not exist, id = " .. buffMO.buffId)
	end
end

function FightBuffItem:getBuffGoodText(buffMO)
	if not buffMO then
		return ""
	end

	if FightBuffHelper.isCountContinueChanelBuff(buffMO) then
		return buffMO.exInfo
	end

	if buffMO.duration > 0 then
		return buffMO.duration
	end

	return ""
end

function FightBuffItem:refreshTxt(buffMO, buffCO)
	if isDebugBuild and GMController.instance.hideBuffLayer then
		gohelper.setActive(self._txtGoodBuff.gameObject, false)
		gohelper.setActive(self._txtGoodCount.gameObject, false)
		gohelper.setActive(self._txtBadBuff.gameObject, false)
		gohelper.setActive(self._txtBadCount.gameObject, false)

		return
	end

	if FightHeroSpEffectConfig.instance:isKSDLSpecialBuff(buffMO.buffId) then
		self:refreshKSDLSpecialBuffTxt(buffMO, buffCO)

		return
	end

	if FightBuffHelper.isDeadlyPoisonBuff(buffMO) then
		self:refreshDeadlyPoisonTxt(buffMO, buffCO)

		return
	end

	if FightBuffHelper.isDuduBoneContinueChannelBuff(buffMO) then
		self:refreshDuduBoneContinueChannelTxt(buffMO, buffCO)

		return
	end

	if buffCO.isGoodBuff == 1 then
		gohelper.setActive(self._txtGoodBuff.gameObject, true)
		gohelper.setActive(self._txtGoodCount.gameObject, true)
		gohelper.setActive(self._txtBadBuff.gameObject, false)
		gohelper.setActive(self._txtBadCount.gameObject, false)

		if FightSkillBuffMgr.instance:buffIsStackerBuff(buffCO) then
			self._txtGoodBuff.text = ""
			self._txtGoodCount.text = FightSkillBuffMgr.instance:getStackedCount(buffMO.entityId, buffMO)
		else
			self._txtGoodBuff.text = self:getBuffGoodText(buffMO)

			if buffMO.layer and buffMO.layer > 0 then
				self._txtGoodCount.text = buffMO.layer
			elseif buffMO.count > 0 then
				self._txtGoodCount.text = buffMO.count or ""
			end
		end
	else
		gohelper.setActive(self._txtGoodBuff.gameObject, false)
		gohelper.setActive(self._txtGoodCount.gameObject, false)
		gohelper.setActive(self._txtBadBuff.gameObject, true)
		gohelper.setActive(self._txtBadCount.gameObject, true)

		local is_stacked, tar_type = FightSkillBuffMgr.instance:buffIsStackerBuff(buffCO)

		if is_stacked then
			self._txtBadBuff.text = ""

			if tar_type == FightEnum.BuffIncludeTypes.Stacked12 then
				if buffMO.duration > 0 then
					self._txtBadBuff.text = buffMO.duration or ""
				end
			end

			self._txtBadCount.text = FightSkillBuffMgr.instance:getStackedCount(buffMO.entityId, buffMO)
		else
			if buffMO.duration > 0 then
				self._txtBadBuff.text = buffMO.duration or ""
			end

			if buffMO.layer and buffMO.layer > 0 then
				self._txtBadCount.text = buffMO.layer
			elseif buffMO.count > 0 then
				self._txtBadCount.text = buffMO.count or ""
			end
		end
	end
end

function FightBuffItem:refreshDeadlyPoisonTxt(buffMo, buffCo)
	gohelper.setActive(self._txtGoodBuff.gameObject, false)
	gohelper.setActive(self._txtGoodCount.gameObject, false)
	gohelper.setActive(self._txtBadBuff.gameObject, true)
	gohelper.setActive(self._txtBadCount.gameObject, true)

	if buffMo.duration > 0 then
		self._txtBadBuff.text = buffMo.duration or ""
	end

	self._txtBadCount.text = FightSkillBuffMgr.instance:getStackedCount(buffMo.entityId, buffMo)
end

function FightBuffItem:refreshDuduBoneContinueChannelTxt(buffMo, buffCo)
	gohelper.setActive(self._txtGoodBuff.gameObject, true)
	gohelper.setActive(self._txtGoodCount.gameObject, true)
	gohelper.setActive(self._txtBadBuff.gameObject, false)
	gohelper.setActive(self._txtBadCount.gameObject, false)

	self._txtGoodBuff.text = buffMo.exInfo
	self._txtGoodCount.text = ""
end

function FightBuffItem:refreshKSDLSpecialBuffTxt(buffMo, buffCo)
	gohelper.setActive(self._txtGoodBuff.gameObject, false)
	gohelper.setActive(self._txtGoodCount.gameObject, false)
	gohelper.setActive(self._txtBadBuff.gameObject, false)
	gohelper.setActive(self._txtBadCount.gameObject, false)
end

function FightBuffItem:calculateBuffType(buffType)
	for _, type in ipairs(FightEnum.BuffTypeList.GoodBuffList) do
		if buffType == type then
			return FightEnum.FightBuffType.GoodBuff
		end
	end

	for _, type in ipairs(FightEnum.BuffTypeList.BadBuffList) do
		if buffType == type then
			return FightEnum.FightBuffType.BadBuff
		end
	end

	return FightEnum.FightBuffType.NormalBuff
end

function FightBuffItem:isTimeBuff(buffCo)
	local featureStr = buffCo.features

	if string.nilorempty(featureStr) then
		return false
	end

	local featureList = FightStrUtil.instance:getSplitCache(featureStr, "|")
	local tempFeature

	for _, feature in ipairs(featureList) do
		tempFeature = FightStrUtil.instance:getSplitToNumberCache(feature, "#")

		if #tempFeature >= 2 and tempFeature[1] == 702 and tempFeature[2] > 2 then
			return true
		end
	end

	return false
end

function FightBuffItem:showPoisoningEffect()
	self:playAni("buffeffect")
end

function FightBuffItem:_hidePoisoningEffect()
	self:closeAni()
end

function FightBuffItem:playAni(name)
	local speed = FightModel.instance:getUISpeed()

	self._animator.enabled = true
	self._animator.speed = speed

	self._animator:Play(name, 0, 0)

	local stateInfo = self._animator:GetCurrentAnimatorStateInfo(0)
	local duration = stateInfo.length / speed

	TaskDispatcher.runDelay(self.closeAni, self, duration)

	return duration
end

function FightBuffItem:closeAni()
	if not self._animator then
		return
	end

	self._animator.enabled = false

	ZProj.UGUIHelper.SetColorAlpha(self._imgIcon, 1)

	gohelper.onceAddComponent(self.go, gohelper.Type_CanvasGroup).alpha = 1

	gohelper.setActive(self.bgeffect, false)
	gohelper.setActive(self.buffquan, false)
	gohelper.setActive(self.bufffinish, false)
	gohelper.setActive(self.buffdot, false)
	transformhelper.setLocalScale(self._txtBadBuff.transform, 0.4, 0.4, 1)
	transformhelper.setLocalScale(self._txtGoodBuff.transform, 0.4, 0.4, 1)
	transformhelper.setLocalScale(self._txtBadCount.transform, 0.4, 0.4, 1)
	transformhelper.setLocalScale(self._txtGoodCount.transform, 0.4, 0.4, 1)
end

function FightBuffItem:onDestroy()
	self._imgIcon = nil
	self._callback = nil
	self._callbackObj = nil

	TaskDispatcher.cancelTask(self._hidePoisoningEffect, self)
	TaskDispatcher.cancelTask(self.closeAni, self)
end

return FightBuffItem
