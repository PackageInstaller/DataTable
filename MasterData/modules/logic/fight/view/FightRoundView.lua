-- chunkname: @modules/logic/fight/view/FightRoundView.lua

module("modules.logic.fight.view.FightRoundView", package.seeall)

local FightRoundView = class("FightRoundView", BaseView)

function FightRoundView:onInitView()
	self._imageroundBg = gohelper.findChildSingleImage(self.viewGO, "#image_roundBg")
	self._txtroundText = gohelper.findChildText(self.viewGO, "#image_roundBg/#txt_roundText")
	self._imagefightStartBg = gohelper.findChildImage(self.viewGO, "#image_fightStartBg")
	self._goalList = gohelper.findChild(self.viewGO, "#image_roundBg/goalList")
	self._goCondition = gohelper.findChild(self.viewGO, "#image_roundBg/goalList/#go_goal")
	self._txtCondition = gohelper.findChildText(self.viewGO, "#image_roundBg/goalList/#go_goal/#txt_condition1")
	self._goPlatCondition = gohelper.findChild(self.viewGO, "#image_roundBg/goalList/#go_platinum")
	self._txtPlatCondition = gohelper.findChildText(self.viewGO, "#image_roundBg/goalList/#go_platinum/#txt_condition2")
	self._goplatinum1 = gohelper.findChild(self.viewGO, "#image_roundBg/goalList/#go_platinum1")
	self._txtcondition3 = gohelper.findChildText(self.viewGO, "#image_roundBg/goalList/#go_platinum1/#txt_condition3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightRoundView:addEvents()
	return
end

function FightRoundView:removeEvents()
	return
end

local ShowTime = 1

function FightRoundView:_editableInitView()
	self._imageroundBg:LoadImage(ResUrl.getFightResultcIcon("bg_tubiaoheidi"))
end

function FightRoundView:onOpen()
	local speed = FightModel.instance:getSpeed()

	if speed > 0 then
		self._showTime = ShowTime / speed or ShowTime
	end

	self._showTime = Mathf.Clamp(self._showTime, 0.2, 1)

	local episodeId = FightModel.instance:getFightParam().episodeId

	if not episodeId then
		return
	end

	local curWaveId = FightModel.instance:getCurWaveId()
	local maxWave = FightModel.instance.maxWave
	local isBoss = false

	self._txtroundText.text = luaLang("main_fight") .. string.format(" - %d/%d", curWaveId, maxWave)

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig then
		::label_5_0::

		if DungeonConfig.instance:getChapterCO(episodeConfig.chapterId).type ~= DungeonEnum.ChapterType.Hard then
			-- block empty
		end

		if curWaveId == 1 then
			local conditionText = DungeonConfig.instance:getFirstEpisodeWinConditionText(nil, FightModel.instance:getBattleId())

			if episodeConfig and episodeConfig.type == DungeonEnum.EpisodeType.V3_2ZongMao then
				conditionText = luaLang("v1a4_bossrushleveldetail_txt_target")
			end

			if episodeConfig and episodeConfig.type == DungeonEnum.EpisodeType.Abyss then
				AbyssHelper.loadFightRoundCondition(episodeId, self._goalList, self._goCondition)
				gohelper.setActive(self._goPlatCondition, false)
				gohelper.setActive(self._goplatinum1, false)
			else
				self:_setConditionText(self._txtCondition, conditionText, true)

				local platCondition = DungeonConfig.instance:getEpisodeAdvancedConditionText(episodeId, FightModel.instance:getBattleId())

				if string.nilorempty(platCondition) then
					gohelper.setActive(self._goPlatCondition, false)
				else
					self:_setConditionText(self._txtPlatCondition, platCondition, true)
				end

				local platCondition2 = DungeonConfig.instance:getEpisodeAdvancedCondition2Text(episodeId, FightModel.instance:getBattleId())

				if string.nilorempty(platCondition2) then
					gohelper.setActive(self._goplatinum1, false)
				else
					self:_setConditionText(self._txtcondition3, platCondition2, true)
				end
			end
		else
			gohelper.setActive(self._goCondition, false)
			gohelper.setActive(self._goPlatCondition, false)
			gohelper.setActive(self._goplatinum1, false)
		end

		gohelper.setActive(self._imageroundBg.gameObject, not isBoss)
		gohelper.setActive(self._imagefightStartBg.gameObject, isBoss)

		if isBoss then
			FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Bosswarning)
			TaskDispatcher.runDelay(self._delayShowRound, self, self._showTime)
		else
			TaskDispatcher.runDelay(self._delayClose, self, self._showTime)
		end

		gohelper.onceAddComponent(self.viewGO, typeof(ZProj.EffectTimeScale)):SetTimeScale(FightModel.instance:getUISpeed())
		gohelper.setActive(self._goalList, (FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.WeekwalkVer2] or nil) and false)
	end
end

function FightRoundView:_setConditionText(txtGo, text, passStory)
	txtGo.text = passStory and gohelper.getRichColorText(text, "#C4C0BD") or gohelper.getRichColorText(text, "#6C6C6B")
end

function FightRoundView:_delayShowRound()
	gohelper.setActive(self._imageroundBg.gameObject, true)
	gohelper.setActive(self._imagefightStartBg.gameObject, false)
	TaskDispatcher.runDelay(self._delayClose, self, self._showTime)
end

function FightRoundView:onClose()
	FightController.instance:dispatchEvent(FightEvent.OnRoundViewClose)
	TaskDispatcher.cancelTask(self._delayShowRound, self)
	TaskDispatcher.cancelTask(self._delayClose, self)
end

function FightRoundView:onDestroyView()
	self._imageroundBg:UnLoadImage()
end

function FightRoundView:_delayClose()
	self:closeThis()
end

return FightRoundView
