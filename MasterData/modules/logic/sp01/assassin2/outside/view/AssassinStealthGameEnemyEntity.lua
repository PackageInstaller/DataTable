-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGameEnemyEntity.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameEnemyEntity", package.seeall)

local AssassinStealthGameEnemyEntity = class("AssassinStealthGameEnemyEntity", LuaCompBase)

function AssassinStealthGameEnemyEntity:ctor(uid)
	self.uid = uid
end

function AssassinStealthGameEnemyEntity:init(go)
	self.go = go
	self.trans = self.go.transform
	self.transParent = self.trans.parent
	self._imagehead = gohelper.findChildImage(self.go, "#simage_head")
	self._gonormal = gohelper.findChild(self.go, "#go_normal")
	self._godead = gohelper.findChild(self.go, "#go_dead")
	self._imagehead2 = gohelper.findChildImage(self.go, "#go_dead/#simage_head")
	self._gocanRemove = gohelper.findChild(self.go, "#go_dead/#go_canRemove")

	local needAp = AssassinConfig.instance:getAssassinActPower(AssassinEnum.HeroAct.HandleBody)
	local goRemoveApLayout = gohelper.findChild(self.go, "#go_dead/#go_canRemove/#go_apLayout")

	self._removeApComp = MonoHelper.addNoUpdateLuaComOnceToGo(goRemoveApLayout, AssassinStealthGameAPComp)

	self._removeApComp:setAPCount(needAp)

	self._gocanClick = gohelper.findChild(self.go, "#go_canClick")
	self._btnclick = gohelper.findChildClickWithAudio(self.go, "#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.go, AssassinStealthGameEffectComp)
	self._godefend = gohelper.findChild(self.go, "#go_defend")
	self._goboss = gohelper.findChild(self.go, "#go_boss")
	self._gotarget = gohelper.findChild(self.go, "#go_target")
	self._gobuff = gohelper.findChild(self.go, "#go_buff")
	self._gopetrifact = gohelper.findChild(self.go, "#go_buff/#go_petrifact")
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.go)

	self:refresh()
end

function AssassinStealthGameEnemyEntity:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function AssassinStealthGameEnemyEntity:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function AssassinStealthGameEnemyEntity:_btnclickOnClick()
	AssassinStealthGameController.instance:clickEnemyEntity(self.uid)
end

function AssassinStealthGameEnemyEntity:changeParent(parentTrans)
	if gohelper.isNil(parentTrans) then
		return
	end

	self.trans:SetParent(parentTrans)

	self.transParent = parentTrans
end

function AssassinStealthGameEnemyEntity:refresh(effectId)
	self:refreshMonster()
	self:refreshStatus()
	self:refreshPos()
	self:refreshSelected()
	self:refreshCanRemove()
	self:refreshCanClick()
	self:playEffect(effectId)
end

function AssassinStealthGameEnemyEntity:refreshMonster()
	local gameEnemyMo = AssassinStealthGameModel.instance:getEnemyMo(self.uid, true)
	local monsterId = gameEnemyMo:getMonsterId()

	if self.monsterId and self.monsterId == monsterId then
		return
	end

	self.monsterId = monsterId
	self.go.name = string.format("%s", self.monsterId)

	local headIcon = AssassinConfig.instance:getEnemyHeadIcon(self.monsterId)

	UISpriteSetMgr.instance:setSp01AssassinSprite(self._imagehead, headIcon)
	UISpriteSetMgr.instance:setSp01AssassinSprite(self._imagehead2, headIcon)

	local isNotMove = AssassinConfig.instance:getEnemyIsNotMove(self.monsterId)

	gohelper.setActive(self._godefend, isNotMove)
end

function AssassinStealthGameEnemyEntity:refreshStatus()
	local gameEnemyMo = AssassinStealthGameModel.instance:getEnemyMo(self.uid, true)
	local isDead = gameEnemyMo:getIsDead()

	if isDead then
		gohelper.setActive(self._goboss, false)
		gohelper.setActive(self._gonormal, false)
		gohelper.setActive(self._gotarget, false)
		gohelper.setActive(self._gobuff, false)
	else
		local isBoss = AssassinConfig.instance:getEnemyIsBoss(self.monsterId)

		gohelper.setActive(self._goboss, isBoss)
		gohelper.setActive(self._gonormal, not isBoss)

		local isTarget = false
		local missionId = AssassinStealthGameModel.instance:getMissionId()
		local targetEnemies = AssassinConfig.instance:getTargetEnemies(missionId)

		if targetEnemies then
			for _, targetEnemy in ipairs(targetEnemies) do
				if targetEnemy == self.monsterId then
					isTarget = true

					break
				end
			end
		end

		gohelper.setActive(self._gotarget, isTarget)
		gohelper.setActive(self._gobuff, true)
		self:refreshBuff()
	end

	gohelper.setActive(self._godead, isDead)
end

function AssassinStealthGameEnemyEntity:refreshBuff()
	local gameEnemyMo = AssassinStealthGameModel.instance:getEnemyMo(self.uid, true)
	local isPetrified = gameEnemyMo:hasBuffType(AssassinEnum.StealGameBuffType.Petrifaction)

	gohelper.setActive(self._gopetrifact, isPetrified)

	local buffIdList = AssassinConfig.instance:getBuffIdList()

	for _, buffId in ipairs(buffIdList) do
		local effectId = AssassinConfig.instance:getAssassinBuffEffectId(buffId)
		local hasBuff = gameEnemyMo:hasBuff(buffId)

		if hasBuff then
			self:playEffect(effectId)
		else
			self:removeEffect(effectId)
		end
	end
end

function AssassinStealthGameEnemyEntity:refreshPos()
	local gameEnemyMo = AssassinStealthGameModel.instance:getEnemyMo(self.uid, true)
	local gridId, pointIndex = gameEnemyMo:getPos()
	local pos = AssassinStealthGameEntityMgr.instance:getGridPointGoPosInEntityLayer(gridId, pointIndex, self.transParent)

	transformhelper.setLocalPosXY(self.trans, pos.x, pos.y)
end

function AssassinStealthGameEnemyEntity:refreshSelected()
	return
end

function AssassinStealthGameEnemyEntity:refreshCanRemove()
	local isCanRemove = AssassinStealthGameHelper.isSelectedHeroCanRemoveEnemyBody(self.uid)

	if self._gocanRemove.activeSelf == isCanRemove then
		return
	end

	gohelper.setActive(self._gocanRemove, isCanRemove)

	if isCanRemove then
		self._animatorPlayer:Play("search", nil, self)
	end
end

function AssassinStealthGameEnemyEntity:refreshCanClick()
	local isCanRemove = AssassinStealthGameHelper.isSelectedHeroCanRemoveEnemyBody(self.uid)
	local isCanUseSkillProp2Enemy = AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToEnemy(self.uid)
	local isCanSelect = AssassinStealthGameHelper.isSelectedHeroCanSelectEnemy(self.uid)

	gohelper.setActive(self._gocanClick, isCanRemove or isCanUseSkillProp2Enemy or isCanSelect)
end

function AssassinStealthGameEnemyEntity:playRemove()
	self._animatorPlayer:Play("close", self.destroy, self)
end

function AssassinStealthGameEnemyEntity:playEffect(effectId, finishCb, finishCbObj, finishCbParam, blockKey)
	if self._effectComp then
		self._effectComp:playEffect(effectId, finishCb, finishCbObj, finishCbParam, nil, nil, blockKey)
	end
end

function AssassinStealthGameEnemyEntity:removeEffect(effectId)
	if not self._effectComp or not effectId or effectId == 0 then
		return
	end

	self._effectComp:removeEffect(effectId)
end

function AssassinStealthGameEnemyEntity:getLocalPos()
	return transformhelper.getLocalPos(self.trans)
end

function AssassinStealthGameEnemyEntity:destroy()
	self.go:DestroyImmediate()
end

function AssassinStealthGameEnemyEntity:onDestroy()
	self.uid = nil
	self.monsterId = nil
end

return AssassinStealthGameEnemyEntity
