-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroEnterView.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroEnterView", package.seeall)

local DiceHeroEnterView = class("DiceHeroEnterView", VersionActivityEnterBaseSubView)

function DiceHeroEnterView:onInitView()
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter", AudioEnum2_6.DiceHero.play_ui_wenming_alaifugameplay)
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	self._txtLockTxt = gohelper.findChildTextMesh(self.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	self._txtDescr = gohelper.findChildTextMesh(self.viewGO, "Right/#txt_Descr")
	self._gored = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#go_reddot")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Try/image_TryBtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DiceHeroEnterView:addEvents()
	self._btnEnter:AddClickListener(self._onEnterClick, self)
	self._btnLocked:AddClickListener(self._onLockClick, self)
	self._btnTrial:AddClickListener(self._clickTrial, self)
end

function DiceHeroEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
end

function DiceHeroEnterView:onOpen()
	DiceHeroEnterView.super.onOpen(self)
	RedDotController.instance:addRedDot(self._gored, RedDotEnum.DotNode.V2a6DiceHero)

	local isOpen = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.DiceHero)

	gohelper.setActive(self._btnEnter, isOpen)
	gohelper.setActive(self._btnLocked, not isOpen)

	if not isOpen then
		local episodeId = OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.DiceHero).episodeId
		local episodetxt = DungeonConfig.instance:getEpisodeDisplay(episodeId)

		self._txtLockTxt.text = string.format(luaLang("dungeon_unlock_episode_mode_sp"), episodetxt)
	end
end

function DiceHeroEnterView:_editableInitView()
	self.config = ActivityConfig.instance:getActivityCo(VersionActivity2_6Enum.ActivityId.DiceHero)
	self._txtDescr.text = self.config.actDesc
end

function DiceHeroEnterView:_onEnterClick()
	ViewMgr.instance:openView(ViewName.DiceHeroMainView)
end

function DiceHeroEnterView:_clickTrial()
	if ActivityHelper.getActivityStatus(VersionActivity2_6Enum.ActivityId.DiceHero) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.config.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	else
		self:_onLockClick()
	end
end

function DiceHeroEnterView:everySecondCall()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_6Enum.ActivityId.DiceHero)
end

function DiceHeroEnterView:_onLockClick()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(OpenEnum.UnlockFunc.DiceHero)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

return DiceHeroEnterView
