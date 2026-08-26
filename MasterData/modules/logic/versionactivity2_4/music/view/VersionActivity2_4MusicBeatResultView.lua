-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicBeatResultView.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatResultView", package.seeall)

local VersionActivity2_4MusicBeatResultView = class("VersionActivity2_4MusicBeatResultView", BaseView)

function VersionActivity2_4MusicBeatResultView:onInitView()
	self._gostoptitle = gohelper.findChild(self.viewGO, "root/#go_stoptitle")
	self._gofailtitle = gohelper.findChild(self.viewGO, "root/#go_failtitle")
	self._gosuccesstitle = gohelper.findChild(self.viewGO, "root/#go_successtitle")
	self._txtscorefailed = gohelper.findChildText(self.viewGO, "root/scoregroup/#txt_scorefailed")
	self._txtscore = gohelper.findChildText(self.viewGO, "root/scoregroup/#txt_score")
	self._txtmaxscore = gohelper.findChildText(self.viewGO, "root/scoregroup/#txt_maxscore")
	self._gocombolist = gohelper.findChild(self.viewGO, "root/evaluatelayout/#go_combolist")
	self._goevaluatelist = gohelper.findChild(self.viewGO, "root/evaluatelayout/#go_evaluatelist")
	self._btncontinuegame = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn/#btn_continuegame")
	self._btnaccompany = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn/#btn_accompany")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn/#btn_restart")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn/#btn_quitgame")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicBeatResultView:addEvents()
	self._btncontinuegame:AddClickListener(self._btncontinuegameOnClick, self)
	self._btnaccompany:AddClickListener(self._btnaccompanyOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
end

function VersionActivity2_4MusicBeatResultView:removeEvents()
	self._btncontinuegame:RemoveClickListener()
	self._btnaccompany:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnquitgame:RemoveClickListener()
end

function VersionActivity2_4MusicBeatResultView:_btncontinuegameOnClick()
	self:closeThis()
end

function VersionActivity2_4MusicBeatResultView:_btnaccompanyOnClick()
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeAccompanyView()
end

function VersionActivity2_4MusicBeatResultView:_btnrestartOnClick()
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.BeatModeEnd, self._isPause)
	self:closeThis()
end

function VersionActivity2_4MusicBeatResultView:_btnquitgameOnClick()
	ViewMgr.instance:closeView(ViewName.VersionActivity2_4MusicBeatView)
	self:closeThis()
end

function VersionActivity2_4MusicBeatResultView:_editableInitView()
	AudioMgr.instance:trigger(AudioEnum.Bakaluoer.play_ui_diqiu_settle_accounts)
end

function VersionActivity2_4MusicBeatResultView:onUpdateParam()
	return
end

function VersionActivity2_4MusicBeatResultView:onOpen()
	self._gradeList = VersionActivity2_4MusicBeatModel.instance:getGradleList()
	self._episodeId = VersionActivity2_4MusicBeatModel.instance:getEpisodeId()
	self._episodeConfig = Activity179Config.instance:getEpisodeConfig(self._episodeId)
	self._beatId = self._episodeConfig.beatId
	self._beatConfig = Activity179Config.instance:getBeatConfig(self._beatId)
	self._txtmaxscore.text = "/" .. self._beatConfig.targetId
	self._comboList = Activity179Config.instance:getComboList(self._beatId)

	self:_parseGradeList()

	self._canPass = self._beatConfig.targetId <= self._totalScore
	self._isPause = self.viewParam and self.viewParam.isPause
	self._isForceSuccess = self.viewParam and self.viewParam.isForceSuccess

	if not self._isPause then
		self._isSuccess = self._beatConfig.targetId <= self._totalScore
		self._isFail = not self._isSuccess
	else
		self._isSuccess = false
		self._isFail = false
	end

	if self._isForceSuccess then
		self._isSuccess = true
		self._isFail = false
	end

	gohelper.setActive(self._btncontinuegame, self._isPause)
	gohelper.setActive(self._btnaccompany, self._isPause)
	gohelper.setActive(self._gostoptitle, self._isPause)
	gohelper.setActive(self._gofailtitle, self._isFail)
	gohelper.setActive(self._gosuccesstitle, self._isSuccess)
	gohelper.setActive(self._txtscore, self._canPass)
	gohelper.setActive(self._txtscorefailed, not self._canPass)
end

function VersionActivity2_4MusicBeatResultView:_getComboConfig(num)
	local length = #self._comboList

	for i = length, 1, -1 do
		local config = self._comboList[i]

		if num >= config.combo or i == 1 then
			return config, i
		end
	end
end

function VersionActivity2_4MusicBeatResultView:_parseGradeList()
	self._totalScore = 0
	self._gradeValues = {}

	local tempCount = 0
	local maxCount = 0

	for i, v in ipairs(self._gradeList) do
		if not self._gradeValues[v] then
			self._gradeValues[v] = self._gradeValues[v] + 1

			if v == VersionActivity2_4MusicEnum.BeatGrade.Miss then
				tempCount = 0
			else
				tempCount = tempCount + 1
				maxCount = math.max(maxCount, tempCount)
			end
		end
	end

	local comboConfig, comboIndex = self:_getComboConfig(maxCount)
	local count = maxCount >= comboConfig.combo and 1 or 0
	local score = comboConfig.score * count

	self._totalScore = self._totalScore + score

	self:_addComboItem(comboIndex, maxCount, score)

	for i = VersionActivity2_4MusicEnum.BeatGrade.Perfect, VersionActivity2_4MusicEnum.BeatGrade.Miss do
		if not self._gradeValues[i] then
			local gradeScore = VersionActivity2_4MusicBeatModel.instance:getGradeScore(i)

			self._totalScore = self._totalScore + gradeScore * self._gradeValues[i]
		end
	end

	self._curIndex = VersionActivity2_4MusicEnum.BeatGrade.Perfect

	TaskDispatcher.cancelTask(self._createItem, self)
	TaskDispatcher.runRepeat(self._createItem, self, 0.16)
	self:_createItem()

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, self._totalScore, 0.3, self._scoreAnimFrame, self._scoreAnimFinish, self)
end

function VersionActivity2_4MusicBeatResultView:_scoreAnimFrame(value)
	local score = math.floor(value)

	self._txtscore.text = score
	self._txtscorefailed.text = score
end

function VersionActivity2_4MusicBeatResultView:_scoreAnimFinish()
	self._txtscore.text = self._totalScore
	self._txtscorefailed.text = self._totalScore
end

function VersionActivity2_4MusicBeatResultView:_createItem()
	if not self._gradeValues[self._curIndex] then
		self:_addGradeItem(self._curIndex, self._gradeValues[self._curIndex])

		self._curIndex = self._curIndex + 1

		if self._curIndex > VersionActivity2_4MusicEnum.BeatGrade.Miss then
			TaskDispatcher.cancelTask(self._createItem, self)
		end
	end
end

function VersionActivity2_4MusicBeatResultView:_addComboItem(index, count, score)
	local path = self.viewContainer:getSetting().otherRes[1]
	local childGO = self:getResInst(path, self._gocombolist)
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, VersionActivity2_4MusicBeatResultComboItem)

	item:onUpdateMO(index, count, score)
end

function VersionActivity2_4MusicBeatResultView:_addGradeItem(grade, count)
	local path = self.viewContainer:getSetting().otherRes[2]
	local childGO = self:getResInst(path, self._goevaluatelist)
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, VersionActivity2_4MusicBeatResultEvaluateItem)

	item:onUpdateMO(grade, count)
end

function VersionActivity2_4MusicBeatResultView:onClose()
	TaskDispatcher.cancelTask(self._createItem, self)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function VersionActivity2_4MusicBeatResultView:onDestroyView()
	return
end

return VersionActivity2_4MusicBeatResultView
