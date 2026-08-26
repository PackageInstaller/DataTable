-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyTalentNodeItem.lua

module("modules.logic.sp01.odyssey.view.OdysseyTalentNodeItem", package.seeall)

local OdysseyTalentNodeItem = class("OdysseyTalentNodeItem", LuaCompBase)

function OdysseyTalentNodeItem:ctor(param)
	self.param = param
end

function OdysseyTalentNodeItem:init(go)
	self:__onInit()

	self.go = go
	self._goselect = gohelper.findChild(self.go, "#go_select")
	self._godark = gohelper.findChild(self.go, "#go_dark")
	self._imagedarkIcon = gohelper.findChildImage(self.go, "#go_dark/#image_darkIcon")
	self._golock = gohelper.findChild(self.go, "#go_lock")
	self._gocanlvup = gohelper.findChild(self.go, "#go_canlvup")
	self._imageicon = gohelper.findChildImage(self.go, "#go_canlvup/#image_icon")
	self._gomaxEffect = gohelper.findChild(self.go, "#go_canlvup/#go_maxEffect")
	self._gonum = gohelper.findChild(self.go, "#go_canlvup/image_numbg")
	self._txtnum = gohelper.findChildText(self.go, "#go_canlvup/image_numbg/#txt_num")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "#btn_click")
	self._golevelUpEffect = gohelper.findChild(self.go, "#go_canlvup/vx_glow")
	self._godarkbg = gohelper.findChild(self.go, "#go_dark/image_talenticonbg")
	self._golockbg = gohelper.findChild(self.go, "#go_lock/image_talenticonbg")
	self._gocanlvupbg = gohelper.findChild(self.go, "#go_canlvup/image_talenticonbg")
	self._canLvupEffect = gohelper.findChild(self.go, "vx_canlvup")
	self._lockAnimPlayer = SLFramework.AnimatorPlayer.Get(self._golock)

	gohelper.setActive(self._golevelUpEffect, false)
	gohelper.setActive(self._canLvupEffect, false)
end

function OdysseyTalentNodeItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	OdysseyController.instance:registerCallback(OdysseyEvent.RefreshTalentNodeSelect, self.refreshSelectState, self)
end

function OdysseyTalentNodeItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	OdysseyController.instance:unregisterCallback(OdysseyEvent.RefreshTalentNodeSelect, self.refreshSelectState, self)
end

function OdysseyTalentNodeItem:_btnclickOnClick()
	if self.curSelectNodeId ~= self.nodeId then
		OdysseyTalentModel.instance:setCurselectNodeId(self.nodeId)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.RefreshTalentNodeSelect)
	end
end

function OdysseyTalentNodeItem:refreshNode(talencCo, isTipNode)
	self.config = talencCo
	self.nodeId = talencCo.nodeId
	self.isTipNode = isTipNode
	self.talentMo = OdysseyTalentModel.instance:getTalentMo(self.nodeId)
	self.isUnlock, self.unlockConditionData = OdysseyTalentModel.instance:checkTalentCanUnlock(self.nodeId)
	self.effectList = OdysseyConfig.instance:getAllTalentEffectConfigByNodeId(self.nodeId)

	self:setAndPlayUnLockAnimState()
	gohelper.setActive(self._gocanlvup, self.isUnlock and self.talentMo and self.talentMo.level > 0)
	gohelper.setActive(self._godark, not self.talentMo or self.talentMo.level == 0)
	gohelper.setActive(self._gonum, #self.effectList > 1)

	self._txtnum.text = self.talentMo and string.format("%s/%s", self.talentMo.level, #self.effectList) or ""

	gohelper.setActive(self._gomaxEffect, self.isUnlock and self.talentMo and self.talentMo.level == #self.effectList and not self.isTipNode)
	gohelper.setActive(self._godarkbg, not self.isTipNode)
	gohelper.setActive(self._golockbg, not self.isTipNode)
	gohelper.setActive(self._gocanlvupbg, not self.isTipNode)

	local canConsume = self:checkCanConsume()

	if self.isUnlock then
		local canShowLvUpEffect = true

		if self.talentMo then
			canShowLvUpEffect = self.talentMo

			if self.talentMo then
				if self.talentMo.level > 0 and self.talentMo.level < #self.effectList then
					if canConsume then
						::label_6_0::

						canShowLvUpEffect = not self.isTipNode
					end

					gohelper.setActive(self._canLvupEffect, canShowLvUpEffect)
					self:refreshSelectState()
					UISpriteSetMgr.instance:setSp01OdysseyTalentSprite(self._imageicon, self.config.icon)
					UISpriteSetMgr.instance:setSp01OdysseyTalentSprite(self._imagedarkIcon, self.config.icon)
				end
			end
		end
	end
end

function OdysseyTalentNodeItem:setAndPlayUnLockAnimState()
	if self.isTipNode then
		self:hideLock()

		return
	end

	if self.lastLockState == nil then
		gohelper.setActive(self._golock, not self.isUnlock and not self.isTipNode)
	elseif self.lastLockState ~= self.isUnlock then
		if self.isUnlock then
			gohelper.setActive(self._golock, true)
			self._lockAnimPlayer:Play("open", self.hideLock, self)
		else
			gohelper.setActive(self._golock, true)
			self._lockAnimPlayer:Play("idle", nil, self)
		end
	end

	self.lastLockState = self.isUnlock
end

function OdysseyTalentNodeItem:hideLock()
	gohelper.setActive(self._golock, false)
end

function OdysseyTalentNodeItem:checkCanConsume()
	local curTalentPoint = OdysseyTalentModel.instance:getCurTalentPoint()
	local curTalentEffectCoList = OdysseyConfig.instance:getAllTalentEffectConfigByNodeId(self.nodeId)

	if self.talentMo then
		if not self.talentMo.level then
			local curTalentLevel = 0
			local nextTalentLevel = curTalentLevel + 1

			return nextTalentLevel <= #curTalentEffectCoList and curTalentPoint >= curTalentEffectCoList[nextTalentLevel].consume
		end
	end
end

function OdysseyTalentNodeItem:refreshSelectState()
	self.curSelectNodeId = OdysseyTalentModel.instance:getCurSelectNodeId()

	gohelper.setActive(self._goselect, self.curSelectNodeId == self.nodeId and not self.isTipNode)
end

function OdysseyTalentNodeItem:hideBtn()
	gohelper.setActive(self._btnclick.gameObject, false)
end

function OdysseyTalentNodeItem:playLevelUpEffect()
	if self.isTipNode then
		gohelper.setActive(self._golevelUpEffect, false)

		return
	end

	gohelper.setActive(self._golevelUpEffect, false)
	gohelper.setActive(self._golevelUpEffect, true)
end

function OdysseyTalentNodeItem:destroy()
	self:__onDispose()
end

return OdysseyTalentNodeItem
