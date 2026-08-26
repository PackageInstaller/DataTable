-- chunkname: @modules/logic/versionactivity3_7/travelgo/view/TravelGoBattleBar.lua

module("modules.logic.versionactivity3_7.travelgo.view.TravelGoBattleBar", package.seeall)

local TravelGoBattleBar = class("TravelGoBattleBar", LuaCompBase)

function TravelGoBattleBar:init(viewGO)
	self.viewGO = viewGO
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self.root = gohelper.findChild(viewGO, "root")
	self.Hp = gohelper.findChild(viewGO, "root/Hp")
	self.imgHp = gohelper.findChildImage(viewGO, "root/Hp/Image_FG")
	self.Rage = gohelper.findChild(viewGO, "root/Rage")

	if self.Rage then
		self.rageAnimator = self.Rage:GetComponent(gohelper.Type_Animator)
		self.imgRage = gohelper.findChildImage(viewGO, "root/Rage/Image_FG")
		self._txtRage = gohelper.findChildText(viewGO, "root/Rage/#txt_Value")
		self.goragelight = gohelper.findChild(viewGO, "root/Rage/vx_light")
		self.gorageeffect = gohelper.findChild(viewGO, "root/Rage/effect")
	end

	self.hpAnimator = self.Hp:GetComponent(gohelper.Type_Animator)
	self.Buff = gohelper.findChild(viewGO, "root/Buff")
	self._txtHp = gohelper.findChildText(viewGO, "root/Hp/#txt_Value")
	self._goAttack = gohelper.findChild(viewGO, "attack")
	self.attackanimator = self._goAttack:GetComponent(gohelper.Type_Animator)
	self._txtAttack = gohelper.findChildText(viewGO, "attack/#txt_Value")
	self._goDefence = gohelper.findChild(viewGO, "defence")
	self.defenceanimator = self._goDefence:GetComponent(gohelper.Type_Animator)
	self._txtDefence = gohelper.findChildText(viewGO, "defence/#txt_Value")

	if self.Buff then
		local scrollParam = SimpleListParam.New()

		scrollParam.cellClass = TravelGoBuffItem
		self.buffList = GameFacade.createSimpleListComp(self.Buff, scrollParam, nil, self.viewContainer)
	end
end

function TravelGoBattleBar:addEventListeners()
	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnAttrChange, self.onAttrChange, self)

	if self.Buff then
		self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnBuffChange, self.onBuffChange, self)
	end

	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnBattleStartComplete, self.onBattleStartComplete, self)
	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnBattleEventFinish, self.onBattleEventFinish, self)
end

function TravelGoBattleBar:removeEventListeners()
	self.removeEventCb(self, TravelGoController.instance, TravelGoEvent.OnAttrChange, self.onAttrChange, self)

	if self.Buff then
		self.removeEventCb(self, TravelGoController.instance, TravelGoEvent.OnBuffChange, self.onBuffChange, self)
	end

	self.removeEventCb(self, TravelGoController.instance, TravelGoEvent.OnBattleStartComplete, self.onBattleStartComplete, self)
	self.removeEventCb(self, TravelGoController.instance, TravelGoEvent.OnBattleEventFinish, self.onBattleEventFinish, self)
end

function TravelGoBattleBar:onBattleStartComplete()
	if self.isNpc then
		return
	end

	self:_setShow(true)
	self:playAnim(UIAnimationName.Open)
end

function TravelGoBattleBar:onBattleEventFinish()
	if self.isNpc then
		return
	end

	self.playAnim(self, UIAnimationName.Close, self._onPlayCloseFinished, self)
end

function TravelGoBattleBar:_onPlayCloseFinished()
	self:_setShow(false)
end

function TravelGoBattleBar:_setShow(isShow)
	gohelper.setActive(self.root, isShow)
	gohelper.setActive(self._goAttack, isShow)
	gohelper.setActive(self._goDefence, isShow)
end

function TravelGoBattleBar:setEntity(entity)
	self.entity = entity
	self.isPlayer = self.entity.entityType == TravelGoBattleEnum.EntityType.Player
	self.isNpc = self.entity.entityType == TravelGoBattleEnum.EntityType.Npc

	self:_setShow(false)

	if self.isNpc then
		return
	end

	gohelper.setActive(self.Buff, self.isPlayer)

	local value = self.entity.attributes:getHp()

	value = TravelGoController.instance:formatNumber(value)

	self:setHpValue(value)

	if self.isPlayer then
		value = self.entity.attributes:getRage()
		value = TravelGoController.instance:formatNumber(value)

		self:setRageValue(value)
	end

	self.attrAnim = {
		[TravelGoBattleEnum.AttrType.Attack] = {
			value = 0,
			animator = self.attackanimator,
			txt = self._txtAttack
		},
		[TravelGoBattleEnum.AttrType.Defence] = {
			value = 0,
			animator = self.defenceanimator,
			txt = self._txtDefence
		}
	}

	local attributes = self.entity.attributes

	for attrId, v in pairs(self.attrAnim) do
		value = attributes:getAttr(attrId)
		v.value = TravelGoController.instance:formatNumber(value)
		v.txt.text = v.value
	end
end

function TravelGoBattleBar:onAttrChange(param)
	local entity = param.entity

	if entity.uid ~= self.entity.uid then
		return
	end

	local attrId = param.attrId
	local value = param.value

	self:_updateAttrText(attrId, value)
end

function TravelGoBattleBar:_updateAttrText(attrId, value)
	if attrId == TravelGoBattleEnum.AttrType.MaxHp then
		if self.hpSeq then
			self.hpSeq:destroy()

			self.hpSeq = nil
		end

		local v = self.entity.attributes:getHp()

		self:setHpValue(v)
	elseif attrId == TravelGoBattleEnum.AttrType.Hp then
		if self._txtHp then
			if self.hpSeq then
				self.hpSeq:destroy()

				self.hpSeq = nil
			end

			self.hpSeq = FlowSequence.New()

			local formatValue = TravelGoController.instance:formatNumber(value)

			if formatValue < self.uiHpValue then
				self.hpAnimator:Play("wiggle", 0, 0)
				self.hpSeq:addWork(TimerWork.New(0.4))
			end

			self.hpSeq:addWork(TweenWork.New({
				type = "DOTweenFloat",
				t = 1,
				from = self.uiHpValue,
				to = formatValue,
				frameCb = self.setHpValue,
				cbObj = self,
				param = attrId,
				ease = EaseType.OutQuart
			}))
			self.hpSeq:start()
		end
	elseif attrId == TravelGoBattleEnum.AttrType.Rage and self.isPlayer then
		if self._txtRage then
			if self.rageSeq then
				self.rageSeq:destroy()

				self.rageSeq = nil
			end

			self.rageSeq = FlowSequence.New()

			self.rageSeq:registerDoneListener(self._onRageFlowDone, self)

			local formatValue = TravelGoController.instance:formatNumber(value)

			if formatValue < self.uiRageValue then
				self.rageAnimator:Play("wiggle", 0, 0)
				self.rageSeq:addWork(TimerWork.New(0.4))
				gohelper.setActive(self.goragelight, true)
			end

			self.rageSeq:addWork(TweenWork.New({
				type = "DOTweenFloat",
				t = 1,
				from = self.uiRageValue,
				to = formatValue,
				frameCb = self.setRageValue,
				cbObj = self,
				param = attrId,
				ease = EaseType.OutQuart
			}))
			self.rageSeq:start()
		end
	elseif (attrId == TravelGoBattleEnum.AttrType.Defence or attrId == TravelGoBattleEnum.AttrType.Attack) and self.attrAnim then
		local flow = self.attrAnim[attrId].flow

		if flow then
			flow:destroy()
		end

		local flowSequence = FlowSequence.New()
		local formatValue = TravelGoController.instance:formatNumber(value)

		flowSequence:addWork(TweenWork.New({
			type = "DOTweenFloat",
			t = 1,
			from = self.attrAnim[attrId].value,
			to = formatValue,
			frameCb = self.setValue,
			cbObj = self,
			param = attrId,
			ease = EaseType.OutQuart
		}))

		self.attrAnim[attrId].flow = flowSequence

		flowSequence:start()

		if value > self.attrAnim[attrId].value then
			self.attrAnim[attrId].animator:Play("up", 0, 0)
			AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_tangren_ding)
		end
	end
end

function TravelGoBattleBar:_onRageFlowDone()
	gohelper.setActive(self.goragelight, false)
end

function TravelGoBattleBar:setValue(num, attrId)
	local formatNum = TravelGoController.instance:formatNumber(num)

	self.attrAnim[attrId].value = formatNum
	self.attrAnim[attrId].txt.text = formatNum
end

function TravelGoBattleBar:setHpValue(num)
	self.uiHpValue = TravelGoController.instance:formatNumber(num)

	local mapHp = TravelGoController.instance:formatNumber(self.entity.attributes:getMaxHp())

	self._txtHp.text = string.format("%s/%s", self.uiHpValue, mapHp)
	self.imgHp.fillAmount = num / mapHp
end

function TravelGoBattleBar:setRageValue(num)
	self.uiRageValue = TravelGoController.instance:formatNumber(num)

	local maxRage = TravelGoController.instance:formatNumber(self.entity.attributes:getMaxRage())

	self._txtRage.text = string.format("%s/%s", self.uiRageValue, maxRage)

	local per = num / maxRage

	self.imgRage.fillAmount = per

	gohelper.setActive(self.gorageeffect, per >= 1)
end

function TravelGoBattleBar:onBuffChange(entity)
	if entity.uid ~= self.entity.uid then
		return
	end

	self:refreshBuff()
end

function TravelGoBattleBar:refreshBuff()
	if not self.isPlayer then
		return
	end

	local buffList = self.entity.buff.buffList
	local dataDic = {}
	local dataList = {}

	for i, v in ipairs(buffList) do
		if v.cfg.isShow == 1 then
			local data = dataDic[v.uid]

			if not data then
				local info = {
					stacks = 0,
					cfgId = v.cfgId,
					buffs = {}
				}

				table.insert(dataList, info)

				dataDic[v.uid] = info
				data = info
			end

			data.stacks = data.stacks + 1

			table.insert(data.buffs, v)
		end
	end

	self.buffList:setData(dataList)
end

function TravelGoBattleBar:playAnim(animName, cb, cbObj)
	if string.nilorempty(animName) or not self.animatorPlayer then
		return
	end

	self.animatorPlayer:Play(animName, cb, cbObj)
end

function TravelGoBattleBar:onDestroy()
	if self.attrAnim then
		for i, v in ipairs(self.attrAnim) do
			if v.flow then
				v.flow:destroy()
			end
		end
	end

	if self.rageSeq then
		self.rageSeq:destroy()

		self.rageSeq = nil
	end

	if self.hpSeq then
		self.hpSeq:destroy()

		self.hpSeq = nil
	end

	self.animatorPlayer = nil
end

return TravelGoBattleBar
