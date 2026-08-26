-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114ScoreReportView.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114ScoreReportView", package.seeall)

local Activity114ScoreReportView = class("Activity114ScoreReportView", BaseView)
local scoreConst = {
	Activity114Enum.ConstId.ScoreA,
	Activity114Enum.ConstId.ScoreB,
	Activity114Enum.ConstId.ScoreC,
	Activity114Enum.ConstId.ScoreE
}
local progressBase = {
	1,
	0.6,
	0.32,
	0.15
}

function Activity114ScoreReportView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtactionscore = gohelper.findChildTextMesh(self.viewGO, "content/scoreInfo/action/#txt_actionscore")
	self._txtmidtermscore = gohelper.findChildTextMesh(self.viewGO, "content/scoreInfo/midterm/#txt_midtermscore")
	self._txtfinalscore = gohelper.findChildTextMesh(self.viewGO, "content/scoreInfo/final/#txt_finalscore")
	self._txttotalscore = gohelper.findChildTextMesh(self.viewGO, "content/scoreInfo/total/#txt_totalscore")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "content/multigradeInfo/progressbar/#image_progress")
	self._txtremarkdesc = gohelper.findChildTextMesh(self.viewGO, "#go_remarktip/#scroll_remark/Viewport/Content/#txt_remarkdesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity114ScoreReportView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
end

function Activity114ScoreReportView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Activity114ScoreReportView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("score/img_bg.png"))
	self._simagebg2:LoadImage(ResUrl.getAct114Icon("bg1"))

	self._scoreIcons = self:getUserDataTb_()

	for i = 1, 4 do
		self._scoreIcons[i] = gohelper.findChild(self.viewGO, "content/#go_scoreIcon/go_score" .. i)
	end

	self._grades = {}

	for i = 1, 4 do
		self._grades[i] = self:getUserDataTb_()
		self._grades[i].circle = gohelper.findChild(self.viewGO, "content/multigradeInfo/grade/grade" .. i .. "/go_circle")
		self._grades[i].txt = gohelper.findChildTextMesh(self.viewGO, "content/multigradeInfo/grade/grade" .. i .. "/txt")
	end
end

function Activity114ScoreReportView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)

	local allAttr, score1, score2, totalScore = Activity114Helper.getWeekEndScore()
	local level, des

	for i = 1, #scoreConst do
		local score, desc = Activity114Config.instance:getConstValue(Activity114Model.instance.id, scoreConst[i])

		if score <= totalScore and not level then
			level = i
			des = desc
		end

		gohelper.setActive(self._grades[i].circle, false)

		self._grades[i].txt.text = score
	end

	self._txtremarkdesc.text = des

	for i = 1, 4 do
		gohelper.setActive(self._scoreIcons[i], false)
	end

	self._txtactionscore.text = allAttr
	self._txtmidtermscore.text = score1
	self._txtfinalscore.text = score2
	self._txttotalscore.text = totalScore

	local amount = 0

	if level == 1 then
		amount = progressBase[1]
	else
		local amount1 = progressBase[level]
		local amount2 = progressBase[level - 1]
		local constScore1 = Activity114Config.instance:getConstValue(Activity114Model.instance.id, scoreConst[level])
		local constScore2 = Activity114Config.instance:getConstValue(Activity114Model.instance.id, scoreConst[level - 1])

		amount = Mathf.Lerp(amount2, amount1, (totalScore - constScore2) / (constScore1 - constScore2))
	end

	self._imageprogress.fillAmount = 0
	self._finalAmount = amount
	self._finalLevel = level

	TaskDispatcher.runDelay(self.delayTweenSlider, self, 0.4)
	TaskDispatcher.runDelay(self.playAudio1, self, 0.95)
	TaskDispatcher.runDelay(self.playAudio2, self, 1.3)
end

function Activity114ScoreReportView:delayTweenSlider()
	self._tweenId = ZProj.TweenHelper.DOFillAmount(self._imageprogress, self._finalAmount, 0.6, self.onTweenEnd, self)
end

function Activity114ScoreReportView:onTweenEnd()
	self._tweenId = nil

	for i = 1, 4 do
		gohelper.setActive(self._grades[i].circle, i == self._finalLevel)
		gohelper.setActive(self._scoreIcons[i], i == self._finalLevel)
	end
end

function Activity114ScoreReportView:playAudio1()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_stamp)
end

function Activity114ScoreReportView:playAudio2()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
end

function Activity114ScoreReportView:onClose()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_close)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	TaskDispatcher.cancelTask(self.delayTweenSlider, self)
	TaskDispatcher.cancelTask(self.playAudio1, self)
	TaskDispatcher.cancelTask(self.playAudio2, self)
end

function Activity114ScoreReportView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return Activity114ScoreReportView
