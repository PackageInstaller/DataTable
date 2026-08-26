-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballDayEndView.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballDayEndView", package.seeall)

local PinballDayEndView = class("PinballDayEndView", BaseView)

function PinballDayEndView:onInitView()
	self._txtday = gohelper.findChildTextMesh(self.viewGO, "bg/#txt_day")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._txtmainlv = gohelper.findChildTextMesh(self.viewGO, "#go_main/#txt_lv")
	self._slider1 = gohelper.findChildImage(self.viewGO, "#go_main/#go_slider/#go_slider1")
	self._slider2 = gohelper.findChildImage(self.viewGO, "#go_main/#go_slider/#go_slider2")
	self._slider3 = gohelper.findChildImage(self.viewGO, "#go_main/#go_slider/#go_slider3")
	self._txtnum = gohelper.findChildTextMesh(self.viewGO, "#go_main/#txt_num")
	self._imagemoodicon = gohelper.findChildImage(self.viewGO, "#go_mood/#simage_icon")
	self._imagemood1 = gohelper.findChildImage(self.viewGO, "#go_mood/#simage_progress1")
	self._imagemood2 = gohelper.findChildImage(self.viewGO, "#go_mood/#simage_progress2")
	self._txtmoodnum = gohelper.findChildTextMesh(self.viewGO, "#go_mood/mask/#txt_mood")
	self._goarrow1 = gohelper.findChild(self.viewGO, "txt_dec/#go_arrow")
	self._goarrow2 = gohelper.findChild(self.viewGO, "txt_dec2/#go_arrow")
	self._txtdescmood = gohelper.findChildTextMesh(self.viewGO, "#go_mood/mask2/#txt_desc")
	self._godescmainitem = gohelper.findChild(self.viewGO, "#go_main/layout/tag1")
	self._godescmood = gohelper.findChild(self.viewGO, "#go_mood/mask2")
	self._effectday = gohelper.findChild(self.viewGO, "bg/vx_nextday")
	self._effectnextlv = gohelper.findChild(self.viewGO, "#go_main/vx_nextlevel")
end

function PinballDayEndView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio9)
	gohelper.setActive(self._gotips, false)

	self._txtday.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_day"), self.viewParam.day)
	self._canClose = false
	self._beforeScore, self._nextScore = self.viewParam.preScore, self.viewParam.nextScore
	self._beforeComplaint, self._nextComplaint = self.viewParam.preComplaint, self.viewParam.nextComplaint

	gohelper.setActive(self._goarrow1, self._nextScore > self._beforeScore)
	gohelper.setActive(self._goarrow2, self._nextComplaint > self._beforeComplaint)
	self:updateTxt()
	TaskDispatcher.runDelay(self._delayTween, self, 1)

	if self._beforeScore == self._nextScore and self._beforeComplaint == self._nextComplaint then
		self:_onTween(1)

		return
	end

	self:_onTween(0)
end

function PinballDayEndView:_delayTween()
	if self._beforeScore == self._nextScore and self._beforeComplaint == self._nextComplaint then
		self:onTweenEnd()

		return
	end

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1, self._onTween, self.onTweenEnd, self)
end

function PinballDayEndView:_onTween(value)
	self:updateScore(math.floor(value * (self._nextScore - self._beforeScore) + self._beforeScore))
	self:updateComplaint(math.floor(value * (self._nextComplaint - self._beforeComplaint) + self._beforeComplaint))
end

function PinballDayEndView:updateTxt()
	local preLv = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, self.viewParam.preMaxProsperity)
	local nowLv = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, self.viewParam.nextMaxProsperity)
	local dict = {}

	for i = preLv + 1, nowLv do
		local co = lua_activity178_score.configDict[VersionActivity2_4Enum.ActivityId.Pinball][i]

		if not string.nilorempty(co.showTxt) then
			local arrs = string.splitToNumber(co.showTxt, "#")

			for _, id in pairs(arrs) do
				dict[id] = true
			end
		end
	end

	local list = {}

	for id in pairs(dict) do
		table.insert(list, id)
	end

	table.sort(list)

	local descs = {}

	for index, id in ipairs(list) do
		local txt = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_score_desc_" .. id), index)

		table.insert(descs, txt)
	end

	gohelper.CreateObjList(self, self._createMainDescItem, descs, nil, self._godescmainitem)

	local preStage = self:getStage(self.viewParam.preComplaint)
	local nextStage = self:getStage(self.viewParam.nextComplaint)
	local nowBallNum = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.DefaultMarblesHoleNum)

	if nextStage == 3 then
		nowBallNum = nowBallNum - PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintMaxSubHoleNum)
	elseif nextStage == 2 then
		nowBallNum = nowBallNum - PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintThresholdSubHoleNum)
	end

	if nextStage < preStage then
		gohelper.setActive(self._godescmood, true)

		self._txtdescmood.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_holenum_desc_2"), nowBallNum)
	elseif preStage < nextStage then
		gohelper.setActive(self._godescmood, true)

		self._txtdescmood.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_holenum_desc_1"), nowBallNum)
	else
		gohelper.setActive(self._godescmood, false)

		self._txtdescmood.text = ""
	end
end

function PinballDayEndView:_createMainDescItem(obj, data, index)
	local txt = gohelper.findChildTextMesh(obj, "#txt_desc")

	txt.text = data
end

function PinballDayEndView:updateScore(value)
	local level, curScore, nextScore = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, value)
	local score, changeNum = value, self._nextScore

	self._txtmainlv.text = level

	if self._cacheLv and level > self._cacheLv then
		gohelper.setActive(self._effectnextlv, false)
		gohelper.setActive(self._effectnextlv, true)
	end

	self._cacheLv = level

	local value1, value2, value3 = 0, 0, 0

	if changeNum == score then
		self._txtnum.text = string.format("%d/%d", score, nextScore)
		value2 = nextScore == curScore and 1 or (score - curScore) / (nextScore - curScore)
	else
		self._txtnum.text = string.format("%d(%+d)/%d", score, changeNum - score, nextScore)

		if score < changeNum then
			if nextScore == curScore then
				value2 = 1
			else
				value1 = (changeNum - curScore) / (nextScore - curScore)
				value2 = (score - curScore) / (nextScore - curScore)

				if nextScore < changeNum then
					local _, changeBaseScore, changeNextScore = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, changeNum)

					value3 = (changeNum - changeBaseScore) / (changeNextScore - changeBaseScore)
				end
			end
		elseif curScore <= changeNum then
			value1 = (score - curScore) / (nextScore - curScore)
			value2 = (changeNum - curScore) / (nextScore - curScore)
		else
			local _, changeBaseScore, changeNextScore = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, changeNum)

			value1 = 1
			value2 = (changeNum - changeBaseScore) / (changeNextScore - changeBaseScore)
			value3 = (score - curScore) / (nextScore - curScore)
		end
	end

	self._slider1.fillAmount = value1
	self._slider2.fillAmount = value2
	self._slider3.fillAmount = value3
end

function PinballDayEndView:getStage(num)
	local max = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintLimit)
	local threshold = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintThreshold)
	local curStage = 1

	if max <= num then
		curStage = 3
	elseif threshold <= num then
		curStage = 2
	end

	return curStage
end

function PinballDayEndView:updateComplaint(value)
	local max = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintLimit)
	local cur, next = value, self._nextComplaint
	local curStage = self:getStage(cur)

	UISpriteSetMgr.instance:setAct178Sprite(self._imagemoodicon, "v2a4_tutushizi_heart_" .. curStage)
	UISpriteSetMgr.instance:setAct178Sprite(self._imagemood2, "v2a4_tutushizi_heartprogress_" .. curStage)

	local value1 = cur / max
	local value2 = next / max

	if value2 < value1 then
		value2 = value1
		value1 = value2
	end

	self._imagemood1.fillAmount = value2
	self._imagemood2.fillAmount = value1
	self._txtmoodnum.text = string.format("%s/%s", cur, max)
end

function PinballDayEndView:onTweenEnd()
	gohelper.setActive(self._effectday, false)
	gohelper.setActive(self._effectday, true)

	self._txtday.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_day"), PinballModel.instance.day)
	self._canClose = true
	self._tweenId = nil

	gohelper.setActive(self._gotips, true)
end

function PinballDayEndView:onClose()
	TaskDispatcher.cancelTask(self._delayTween, self)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	PinballController.instance:dispatchEvent(PinballEvent.EndRound)
	PinballController.instance:sendGuideMainLv()
end

function PinballDayEndView:onClickModalMask()
	if not self._canClose then
		return
	end

	self:closeThis()
end

return PinballDayEndView
