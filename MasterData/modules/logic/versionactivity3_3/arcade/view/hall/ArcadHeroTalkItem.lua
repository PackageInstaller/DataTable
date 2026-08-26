-- chunkname: @modules/logic/versionactivity3_3/arcade/view/hall/ArcadHeroTalkItem.lua

module("modules.logic.versionactivity3_3.arcade.view.hall.ArcadHeroTalkItem", package.seeall)

local ArcadHeroTalkItem = class("ArcadHeroTalkItem", LuaCompBase)

function ArcadHeroTalkItem:init(go)
	self.viewGO = go
	self._goroot = gohelper.findChild(self.viewGO, "root")
	self._scrollinfo = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_info")
	self._txttalk = gohelper.findChildText(self.viewGO, "root/#scroll_info/Viewport/Content/#txt_talk")
	self._goArrowTips = gohelper.findChild(self.viewGO, "root/#go_ArrowTips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadHeroTalkItem:_editableInitView()
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.NPCTalk, self._onNPCTalk, self)

	self.updateHandle = UpdateBeat:CreateListener(self._onFrame, self)

	UpdateBeat:AddListener(self.updateHandle)

	self._spawnInterval = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.TalkIntervalTime, true) * 0.001
end

function ArcadHeroTalkItem:_onNPCTalk(id)
	if self.mo.id ~= id then
		return
	end

	self:checkPlayTalk()
end

function ArcadHeroTalkItem:onUpdateMO(mo)
	self.mo = mo
	self._isTalking = false

	local isFirst = self:isFirstTalk()

	if isFirst or ArcadeController.instance:getEnterInteractiveId() == self.mo.id then
		self:checkPlayTalk()
	end
end

function ArcadHeroTalkItem:_onFrame()
	if not self._isTalking or not LuaUtil.tableNotEmpty(self._contentInfo) then
		return
	end

	if self._scrollinfo.verticalNormalizedPosition > 0 then
		self._scrollinfo.verticalNormalizedPosition = 0
	end

	local currentTime = Time.time

	if currentTime - self._lastSpawnTime < self._spawnInterval then
		return
	end

	if self._curContentIndex >= self._contentLen + 1 then
		if not self._nextStepTimeMS then
			local timems = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.NextStepTimeMS, true)

			if timems then
				self._nextStepTimeMS = timems * 0.001 or 1
			end
		end

		if currentTime - self._lastSpawnTime > self._nextStepTimeMS then
			self._curstep = self._curstep + 1

			self:_playTalk()
		end

		return
	end

	self._curContentIndex = self._curContentIndex + 1

	local content = self._contentInfo[self._curContentIndex]

	if not string.nilorempty(content) then
		self:_showTalk(content)
	end

	self._lastSpawnTime = Time.time
end

function ArcadHeroTalkItem:isFirstTalk()
	local value = ArcadeOutSizeModel.instance:getPlayerPrefsValue(ArcadeEnum.PlayerPrefsKey.HallNPCFirst, self.mo.id, 0, true)

	return value == 0
end

function ArcadHeroTalkItem:checkPlayTalk()
	local isFirst = self:isFirstTalk()

	if isFirst then
		if not ArcadeHallEnum.TalkCondition.First then
			local condition = ArcadeHallEnum.TalkCondition.Trigger
			local groupId = self.mo:getTalkGroupId(condition)

			self:_startPlayTalk(groupId)
		end
	end
end

function ArcadHeroTalkItem:_startPlayTalk(groupId)
	gohelper.setActive(self._goroot, true)

	self._curGroup = groupId
	self._curstep = 1

	self:_playTalk()

	self._isTalking = true

	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_bubble_popup)
end

function ArcadHeroTalkItem:_playTalk()
	local info, co = self.mo:getStepContentInfo(self._curGroup, self._curstep)

	if not info or #info == 0 or not co then
		self:_finishTalk()

		return
	end

	self._contentInfo = info
	self._contentLen = #info
	self._lastSpawnTime = Time.time
	self._curContentIndex = 0

	self:_showTalk("")
	ArcadeController.instance:dispatchEvent(ArcadeEvent.NPCTalkBlock, co.block == 1)
end

function ArcadHeroTalkItem:_showTalk(content)
	self._txttalk.text = content
end

function ArcadHeroTalkItem:_finishTalk()
	ArcadeController.instance:dispatchEvent(ArcadeEvent.NPCTalkBlock, false)

	local isFirst = self:isFirstTalk()

	if isFirst then
		ArcadeOutSizeModel.instance:setPlayerPrefsValue(ArcadeEnum.PlayerPrefsKey.HallNPCFirst, self.mo.id, 1, true)
	end

	gohelper.setActive(self._goroot, false)

	self._isTalking = false
end

function ArcadHeroTalkItem:onDestroy()
	if self.updateHandle then
		UpdateBeat:RemoveListener(self.updateHandle)
	end

	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.NPCTalk, self._onNPCTalk, self)
end

return ArcadHeroTalkItem
