-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/perform/V3a6YaMiHeroTalkItem.lua

module("modules.logic.versionactivity3_6.yami.view.game.perform.V3a6YaMiHeroTalkItem", package.seeall)

local V3a6YaMiHeroTalkItem = class("V3a6YaMiHeroTalkItem", V3a6YaMiFloatItem)

function V3a6YaMiHeroTalkItem:ctor(heroId)
	self._heroId = heroId
end

function V3a6YaMiHeroTalkItem:init(go)
	self.go = go
	self._gotalk = gohelper.findChild(self.go, "#go_talk")
	self._scrolltalk = gohelper.findChildScrollRect(self.go, "#scroll_talk")
	self._txttalk = gohelper.findChildText(self.go, "#scroll_talk/Viewport/Content/#txt_talk")

	self:addEventListeners()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiHeroTalkItem:addEventListeners()
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onTriggerSkill, self._onTriggerSkill, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onFinishPerform, self._onFinishPerform, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onMeetEvent, self._onMeetEvent, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onFinishEvent, self._onFinishEvent, self)
end

function V3a6YaMiHeroTalkItem:removeEventListeners()
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onTriggerSkill, self._onTriggerSkill, self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onFinishPerform, self._onFinishPerform, self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onMeetEvent, self._onMeetEvent, self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onFinishEvent, self._onFinishEvent, self)
end

function V3a6YaMiHeroTalkItem:_onTriggerSkill()
	self:_clear()
	self:_startSkillTalk()
end

function V3a6YaMiHeroTalkItem:_onFinishPerform()
	self:_clear()
	self:setActive(false)
end

function V3a6YaMiHeroTalkItem:_onMeetEvent()
	self._isPerforming = false

	self:_clear()
	self:setActive(false)
end

function V3a6YaMiHeroTalkItem:_onFinishEvent()
	self._isPerforming = true

	self:checkTalk()
end

function V3a6YaMiHeroTalkItem:_editableInitView()
	self._randomTimeRange = V3a6YaMiConfig.instance:getConstValue2(V3a6YaMiEnum.ConstId.TalkRandomTime, true, "#")
	self._sustainTime = V3a6YaMiConfig.instance:getConstValueByConst(V3a6YaMiEnum.ConstId.TalkSustainTime) or 5
end

function V3a6YaMiHeroTalkItem:onUpdateMO(heroId, mgr)
	self._isPerforming = true
	self._heroId = heroId
	self._mgr = mgr
end

function V3a6YaMiHeroTalkItem:checkTalk()
	self:_clear()

	self._mo = self._mo or V3a6YaMiModel.instance:getHeroMoById(self._heroId)

	self:setActive(false)

	local time = math.random(self._randomTimeRange[1], self._randomTimeRange[2])

	TaskDispatcher.runDelay(self._startRandomTalk, self, time)
end

function V3a6YaMiHeroTalkItem:_startRandomTalk()
	self:_startTalk(V3a6YaMiEnum.TalkTriggerType.Random)
end

function V3a6YaMiHeroTalkItem:_startSkillTalk()
	self:_startTalk(V3a6YaMiEnum.TalkTriggerType.Skill)
end

function V3a6YaMiHeroTalkItem:_startTalk(type)
	if not self._mo or not self._isPerforming then
		return
	end

	if self._mgr then
		local isCanShow = self._mgr:isCanShow()

		if not isCanShow then
			self:setActive(false)
			self:checkTalk()

			return
		end

		self._mgr:modifyTalkCount(true)
	end

	local co = self._mo:getCurTalkCo(type)

	if not co then
		self:_onFinishTalk()

		return
	end

	self._txttalk.text = co.content

	self:setActive(true)
	TaskDispatcher.runDelay(self._onFinishTalk, self, self._sustainTime)
end

function V3a6YaMiHeroTalkItem:_onFinishTalk()
	self:_clear()
	self:setActive(false)
	self:checkTalk()

	if self._mgr then
		self._mgr:modifyTalkCount(false)
	end
end

function V3a6YaMiHeroTalkItem:_clear()
	TaskDispatcher.cancelTask(self._startRandomTalk, self)
	TaskDispatcher.cancelTask(self._onFinishTalk, self)
end

function V3a6YaMiHeroTalkItem:onDestroy()
	self:_clear()
end

return V3a6YaMiHeroTalkItem
