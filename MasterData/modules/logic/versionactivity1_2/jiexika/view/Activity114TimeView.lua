-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114TimeView.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114TimeView", package.seeall)

local Activity114TimeView = class("Activity114TimeView", BaseView)

function Activity114TimeView:onInitView()
	self._txtday = gohelper.findChildText(self.viewGO, "time/today/daytitle/#txt_day")
	self._txtdayen = gohelper.findChildText(self.viewGO, "time/today/daytitle/#txt_day/#txt_dayen")
	self._txtkeyDay = gohelper.findChildText(self.viewGO, "time/nextKeyDay/#txt_keyDay")
	self._goedubg = gohelper.findChild(self.viewGO, "time/today/eduTime/go_edubg")
	self._txteduTime = gohelper.findChildText(self.viewGO, "time/today/eduTime/#txt_eduTime")
	self._txteduTimeEn = gohelper.findChildText(self.viewGO, "time/today/eduTime/#txt_eduTime/txten")
	self._gofreebg = gohelper.findChild(self.viewGO, "time/today/freeTime/go_freebg")
	self._txtfreeTime = gohelper.findChildText(self.viewGO, "time/today/freeTime/#txt_freeTime")
	self._txtfreeTimeEn = gohelper.findChildText(self.viewGO, "time/today/freeTime/#txt_freeTime/txten")
	self._imageprocess = gohelper.findChildImage(self.viewGO, "time/today/round/bgline/#image_process")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity114TimeView:addEvents()
	Activity114Controller.instance:registerCallback(Activity114Event.OnRoundUpdate, self.onRoundChange, self)
	self.viewContainer:registerCallback(Activity114Event.MainViewAnimBegin, self.onMainViewAnimBegin, self)
	self.viewContainer:registerCallback(Activity114Event.MainViewAnimEnd, self.onMainViewAnimEnd, self)
end

function Activity114TimeView:removeEvents()
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnRoundUpdate, self.onRoundChange, self)
	self.viewContainer:unregisterCallback(Activity114Event.MainViewAnimBegin, self.onMainViewAnimBegin, self)
	self.viewContainer:unregisterCallback(Activity114Event.MainViewAnimEnd, self.onMainViewAnimEnd, self)
end

function Activity114TimeView:_editableInitView()
	self.rounds = {}

	for i = 1, 4 do
		self.rounds[i] = self:getUserDataTb_()
		self.rounds[i].type1 = gohelper.findChild(self.viewGO, "time/today/round/round" .. i .. "/type1")
		self.rounds[i].type2 = gohelper.findChild(self.viewGO, "time/today/round/round" .. i .. "/type2")
		self.rounds[i].type3 = gohelper.findChild(self.viewGO, "time/today/round/round" .. i .. "/type3")
		self.rounds[i].actdesc = gohelper.findChildText(self.viewGO, "time/today/round/round" .. i .. "/txt_actdesc")
	end

	self:onRoundChange()
end

function Activity114TimeView:onMainViewAnimBegin()
	local nowRound = Activity114Model.instance.serverData.round

	if not self.rounds[nowRound - 1] then
		return
	end

	gohelper.setActive(self.rounds[nowRound - 1].type1, false)
end

function Activity114TimeView:onMainViewAnimEnd()
	local nowRound = Activity114Model.instance.serverData.round

	if not self.rounds[nowRound - 1] then
		return
	end

	gohelper.setActive(self.rounds[nowRound - 1].type1, true)

	local anim = ZProj.ProjAnimatorPlayer.Get(self.rounds[nowRound - 1].type1)

	anim:Play(UIAnimationName.Open)
end

function Activity114TimeView:onRoundChange()
	local nowDay = Activity114Model.instance.serverData.day
	local nowRound = Activity114Model.instance.serverData.round
	local roundCo = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, nowDay, nowRound)
	local keyDayCo = Activity114Config.instance:getKeyDayCo(Activity114Model.instance.id, nowDay)

	if not roundCo or not keyDayCo or roundCo.type == Activity114Enum.RoundType.KeyDay then
		return
	end

	for i = 1, 4 do
		gohelper.setActive(self.rounds[i].type1, i < nowRound and not Activity114Model.instance.isPlayingOpenAnim)
		gohelper.setActive(self.rounds[i].type2, i == nowRound)
		gohelper.setActive(self.rounds[i].type3, nowRound < i)

		local dayRoundCo = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, nowDay, i)

		self.rounds[i].actdesc.text = dayRoundCo.desc

		SLFramework.UGUI.GuiHelper.SetColor(self.rounds[i].actdesc, i == nowRound and "#B389D7" or "#CECECE")
	end

	self._imageprocess.fillAmount = (nowRound - 1) / 3
	self._txtday.text = formatLuaLang("versionactivity_1_2_114daydes", GameUtil.getNum2Chinese(nowDay))
	self._txtdayen.text = "DAY " .. nowDay

	local tag = {
		keyDayCo.desc,
		keyDayCo.day - nowDay
	}

	self._txtkeyDay.text = GameUtil.getSubPlaceholderLuaLang(luaLang("versionactivity_1_2_114keydaydes"), tag)

	gohelper.setActive(self._goedubg, roundCo.type == Activity114Enum.RoundType.Edu)
	gohelper.setActive(self._gofreebg, roundCo.type == Activity114Enum.RoundType.Free)

	self._txteduTime.alpha = roundCo.type == Activity114Enum.RoundType.Edu and 1 or 0.102
	self._txteduTimeEn.alpha = roundCo.type == Activity114Enum.RoundType.Edu and 0.2 or 0.051
	self._txtfreeTime.alpha = roundCo.type == Activity114Enum.RoundType.Free and 1 or 0.102
	self._txtfreeTimeEn.alpha = roundCo.type == Activity114Enum.RoundType.Free and 0.2 or 0.051
end

return Activity114TimeView
