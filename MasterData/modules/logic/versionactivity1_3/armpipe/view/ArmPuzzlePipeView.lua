-- chunkname: @modules/logic/versionactivity1_3/armpipe/view/ArmPuzzlePipeView.lua

module("modules.logic.versionactivity1_3.armpipe.view.ArmPuzzlePipeView", package.seeall)

local ArmPuzzlePipeView = class("ArmPuzzlePipeView", BaseView)

function ArmPuzzlePipeView:onInitView()
	self._simagepaperlower = gohelper.findChildSingleImage(self.viewGO, "Paper/#simage_PaperLower")
	self._simagephoto = gohelper.findChildSingleImage(self.viewGO, "Paper/#simage_Photo")
	self._simagepaperupper = gohelper.findChildSingleImage(self.viewGO, "Paper/#simage_PaperUpper")
	self._simagepaperupper3 = gohelper.findChildSingleImage(self.viewGO, "Paper/#simage_PaperUpper3")
	self._simagepaperupper4 = gohelper.findChildSingleImage(self.viewGO, "Paper/#simage_PaperUpper4")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")
	self._txtTips = gohelper.findChildText(self.viewGO, "#txt_Tips")
	self._goopMask = gohelper.findChild(self.viewGO, "#go_opMask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArmPuzzlePipeView:addEvents()
	return
end

function ArmPuzzlePipeView:removeEvents()
	return
end

function ArmPuzzlePipeView:_editableInitView()
	gohelper.setActive(self._gofinish, false)
	gohelper.setActive(self._goopMask, false)
	self._simagepaperlower:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_puzzlepaper2"))
	self._simagephoto:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_puzzle_photo"))
	self._simagepaperupper:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_puzzlepaper1"))
	self._simagepaperupper3:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_puzzlepaper3"))
	self._simagepaperupper4:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_puzzlepaper4"))
	NavigateMgr.instance:addEscape(self.viewName, self._onEscape, self)
end

function ArmPuzzlePipeView:onUpdateParam()
	return
end

function ArmPuzzlePipeView:onOpen()
	self.addEventCb(self, ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.PipeGameClear, self._onGameClear, self)
	self.addEventCb(self, ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.ResetGameRefresh, self._onResetGame, self)
	self:_refreshUI()
end

function ArmPuzzlePipeView:_onResetGame()
	gohelper.setActive(self._gofinish, false)
end

function ArmPuzzlePipeView:_onGameClear()
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
	gohelper.setActive(self._gofinish, true)

	local episodeCo = ArmPuzzlePipeModel.instance:getEpisodeCo()

	if not Activity124Model.instance:isEpisodeClear(episodeCo.activityId, episodeCo.episodeId) then
		self._isFristClear = true
		self._fristClearEpisodeIdId = episodeCo.episodeId
		self._fristClearActivityId = episodeCo.activityId

		gohelper.setActive(self._goopMask, true)
		Activity124Rpc.instance:sendFinishAct124EpisodeRequest(episodeCo.activityId, episodeCo.episodeId)

		self._escapeUseTime = Time.time + ArmPuzzlePipeEnum.AnimatorTime.GameFinish + 0.3

		TaskDispatcher.runDelay(self._onRewardRequest, self, ArmPuzzlePipeEnum.AnimatorTime.GameFinish)
	end
end

function ArmPuzzlePipeView:_onRewardRequest()
	gohelper.setActive(self._goopMask, false)
	Activity124Rpc.instance:sendReceiveAct124RewardRequest(self._fristClearActivityId, self._fristClearEpisodeIdId)
end

function ArmPuzzlePipeView:_refreshUI()
	local episodeCo = ArmPuzzlePipeModel.instance:getEpisodeCo()

	if episodeCo then
		local cfgMap = Activity124Config.instance:getMapCo(episodeCo.activityId, episodeCo.mapId)

		if cfgMap then
			self._txtTips.text = cfgMap.desc or ""
		end
	end
end

function ArmPuzzlePipeView:onClose()
	if self._isFristClear then
		Activity124Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.EpisodeFiexdAnim, self._fristClearEpisodeIdId)
	end
end

function ArmPuzzlePipeView:_onEscape()
	if self._escapeUseTime == nil or self._escapeUseTime < Time.time then
		Stat1_3Controller.instance:puzzleStatAbort()
		self:closeThis()
	end
end

function ArmPuzzlePipeView:onDestroyView()
	self._simagepaperlower:UnLoadImage()
	self._simagephoto:UnLoadImage()
	self._simagepaperupper:UnLoadImage()
	self._simagepaperupper3:UnLoadImage()
	self._simagepaperupper4:UnLoadImage()
	NavigateMgr.instance:removeEscape(self.viewName, self._onEscape, self)
end

return ArmPuzzlePipeView
