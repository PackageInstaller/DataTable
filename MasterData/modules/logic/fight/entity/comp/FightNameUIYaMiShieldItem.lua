-- chunkname: @modules/logic/fight/entity/comp/FightNameUIYaMiShieldItem.lua

module("modules.logic.fight.entity.comp.FightNameUIYaMiShieldItem", package.seeall)

local FightNameUIYaMiShieldItem = class("FightNameUIYaMiShieldItem", FightBaseClass)

function FightNameUIYaMiShieldItem:onConstructor(viewGO, buffData, entityData)
	self.viewGO = viewGO
	self.buffData = buffData
	self.entityId = buffData.entityId
	self.entityData = entityData

	local actInfo = buffData.actInfo

	for k, v in ipairs(actInfo) do
		if v.actId == 1125 then
			self.actInfo = v

			break
		end
	end

	if not self.actInfo then
		self:disposeSelf()

		return
	end

	self.normal = gohelper.findChild(self.viewGO, "normal")
	self.reduce = gohelper.findChild(self.viewGO, "reduce")
	self.add = gohelper.findChild(self.viewGO, "add")
	self.broken = gohelper.findChild(self.viewGO, "broken")
	self.shield = gohelper.findChild(self.viewGO, "shield")
	self.shieldText = gohelper.findChildText(self.viewGO, "shield/#txt_shield")
	self.click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#go_clickarea")
	self.animator = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
	self.reduceText = gohelper.findChildText(self.viewGO, "reduce/reduce/#txt_reduce")
	self.addText = gohelper.findChildText(self.viewGO, "add/effect/#txt_add")

	self:com_registMsg(FightMsgId.OnUpdateYaMiShield, self.onUpdateYaMiShield)
	self:com_registMsg(FightMsgId.RefreshYaMiShieldAfterDamage, self.onRefreshYaMiShieldAfterDamage)
	self:com_registMsg(FightMsgId.OnRemoveYaMiShield, self.onRemoveYaMiShield)
	self:com_registMsg(FightMsgId.UpdateEntityBuffActInfo, self.onUpdateEntityBuffActInfo)
	self:com_registMsg(FightMsgId.GetYaMiShieldUIOffset, self.onGetYaMiShieldUIOffset)
	self:com_registMsg(FightMsgId.GetYaMiShieldData, self.onGetYaMiShieldData)
	self:refreshUI()
	FightMsgMgr.sendMsg(FightMsgId.ShowYaMiNameUISlider, entityData, buffData, self.actInfo)
	AudioMgr.instance:trigger(360003)
end

function FightNameUIYaMiShieldItem:onGetYaMiShieldUIOffset(entityId)
	if entityId ~= self.entityId then
		return
	end

	FightMsgMgr.replyMsg(FightMsgId.GetYaMiShieldUIOffset, 40)
end

function FightNameUIYaMiShieldItem:onGetYaMiShieldData(entityId)
	if entityId ~= self.entityId then
		return
	end

	local tab = {
		buffData = self.buffData,
		actInfo = self.actInfo
	}

	FightMsgMgr.replyMsg(FightMsgId.GetYaMiShieldData, tab)
end

function FightNameUIYaMiShieldItem:refreshUI()
	self.shieldValue = self.actInfo.param[1]
	self.shieldText.text = self.shieldValue
end

function FightNameUIYaMiShieldItem:onUpdateYaMiShield(buffData)
	if self.buffData.uid ~= buffData.uid then
		return
	end

	local last = self.shieldValue

	self:refreshUI()

	if last < self.shieldValue then
		self.animator:Play("add", 0, 0)
		AudioMgr.instance:trigger(360004)

		self.addText.text = "+" .. self.shieldValue - last
	elseif last > self.shieldValue then
		self.animator:Play("reduce", 0, 0)
		AudioMgr.instance:trigger(360005)

		self.reduceText.text = "-" .. last - self.shieldValue
	end
end

function FightNameUIYaMiShieldItem:onRefreshYaMiShieldAfterDamage()
	self:onUpdateYaMiShield(self.buffData)
end

function FightNameUIYaMiShieldItem:onRemoveYaMiShield(buffData)
	if self.buffData.uid ~= buffData.uid then
		return
	end

	self.shieldText.text = 0

	AudioMgr.instance:trigger(360006)

	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkPlayAnimator, self.animator.gameObject, "broken")
	flow:registFinishCallback(self.onRemoveFinish, self)
	flow:start()
end

function FightNameUIYaMiShieldItem:onRemoveFinish()
	self:disposeSelf()
end

function FightNameUIYaMiShieldItem:onUpdateEntityBuffActInfo(entityId, buffUid, actInfo)
	if buffUid ~= self.buffData.uid then
		return
	end

	local last = self.shieldValue

	self:refreshUI()

	if last < self.shieldValue then
		self.animator:Play("add", 0, 0)

		self.addText.text = "+" .. self.shieldValue - last
	elseif last > self.shieldValue then
		self.animator:Play("reduce", 0, 0)

		self.reduceText.text = "-" .. last - self.shieldValue
	end
end

function FightNameUIYaMiShieldItem:onDestructor()
	gohelper.destroy(self.viewGO)
end

return FightNameUIYaMiShieldItem
