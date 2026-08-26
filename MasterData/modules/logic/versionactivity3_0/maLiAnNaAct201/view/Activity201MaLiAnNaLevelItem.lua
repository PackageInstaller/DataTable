-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/Activity201MaLiAnNaLevelItem.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.Activity201MaLiAnNaLevelItem", package.seeall)

local Activity201MaLiAnNaLevelItem = class("Activity201MaLiAnNaLevelItem", LuaCompBase)

function Activity201MaLiAnNaLevelItem:init(go)
	self._gopointnormal = gohelper.findChild(go, "#image_point_normal")
	self._gppointfinish = gohelper.findChild(go, "#image_point_finish")
	self._gostagenormal = gohelper.findChild(go, "unlock/#go_stagenormal")
	self._gostagefinish = gohelper.findChild(go, "unlock/#go_stagefinish")
	self._imagestagenum = gohelper.findChildImage(go, "unlock/info/#image_Num")
	self._txtstagename = gohelper.findChildText(go, "unlock/info/#txt_stagename")
	self._gobattletag = gohelper.findChild(go, "unlock/info/#txt_stagename/#go_Battle")
	self._txtstagenum = gohelper.findChildText(go, "unlock/info/#txt_stageNum")
	self._gostar = gohelper.findChild(go, "unlock/info/#go_star")
	self._btnclick = gohelper.findChildButton(go, "unlock/#btn_click")
	self._goCurrent = gohelper.findChild(go, "unlock/#go_Current")
	self._gofinish = gohelper.findChild(go, "unlock/finish")
	self._gounlock = gohelper.findChild(go, "unlock")
	self._stars = self:getUserDataTb_()

	for i = 1, 2 do
		local star = {}

		star.go = gohelper.findChild(go, "unlock/info/#go_star/star" .. i)
		star.has = gohelper.findChild(star.go, "has")
		star.no = gohelper.findChild(star.go, "no")

		table.insert(self._stars, star)
	end

	self._govxunlockeff = gohelper.setActive(go, "vx_unlock")
	self._anim = go:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity201MaLiAnNaLevelItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnOnClick, self)
end

function Activity201MaLiAnNaLevelItem:_btnOnClick()
	if self._isStoryEpisode then
		if self._config.storyBefore > 0 then
			local param = {}

			param.mark = true

			Activity201MaLiAnNaController.instance:stopBurnAudio()
			StoryController.instance:playStory(self._config.storyBefore, param, self._onGameFinished, self)
		else
			self:_onGameFinished()
		end
	elseif self._config.storyBefore > 0 then
		local param = {}

		param.mark = true

		Activity201MaLiAnNaController.instance:stopBurnAudio()
		StoryController.instance:playStory(self._config.storyBefore, param, self._enterGame, self)
	else
		self:_enterGame()
	end
end

function Activity201MaLiAnNaLevelItem:setParam(co, index, actId)
	self._config = co
	self.id = co.episodeId
	self._actId = actId
	self._index = index
	self._isStoryEpisode = self._config.gameId == 0

	gohelper.setActive(self._gobattletag, not self._isStoryEpisode)

	self.gameId = self._config.gameId

	self:refreshUI()
end

function Activity201MaLiAnNaLevelItem:refreshUI()
	self._isunlock = Activity201MaLiAnNaModel.instance:isEpisodeUnlock(self.id)
	self._ispass = Activity201MaLiAnNaModel.instance:isEpisodePass(self.id)

	gohelper.setActive(self._gopointnormal, not self._ispass)
	gohelper.setActive(self._gppointfinish, self._ispass)
	gohelper.setActive(self._gounlock, self._isunlock)

	if self._isunlock then
		gohelper.setActive(self._gostagenormal, not self._ispass)
		gohelper.setActive(self._gostagefinish, self._ispass)

		self._txtstagename.text = self._config.name
		self._txtstagenum.text = string.format("STAGE %02d", self._index)

		local name = string.format("v3a0_malianna_level_stage%02d", self._index)

		UISpriteSetMgr.instance:setMaliAnNaSprite(self._imagestagenum, name)

		for index, star in ipairs(self._stars) do
			gohelper.setActive(star.no, not self._ispass)
			gohelper.setActive(star.has, self._ispass)
		end
	end

	local isCurrent = self.id == Activity201MaLiAnNaModel.instance:getCurEpisode()

	gohelper.setActive(self._goCurrent, isCurrent)
end

function Activity201MaLiAnNaLevelItem:_enterGame()
	Activity201MaLiAnNaController.instance:startBurnAudio()

	if Activity201MaLiAnNaModel.instance:checkEpisodeFinishGame(self.id) and not Activity201MaLiAnNaModel.instance:isEpisodePass(self.id) then
		self:_onGameFinished()
	else
		Activity201MaLiAnNaGameController.instance:enterGame(self.gameId, self.id)
	end
end

function Activity201MaLiAnNaLevelItem:_onGameFinished()
	Activity201MaLiAnNaController.instance:_onGameFinished(self._actId, self.id)
end

function Activity201MaLiAnNaLevelItem:isUnlock()
	return self._islvunlock
end

function Activity201MaLiAnNaLevelItem:playFinish()
	self._ispass = Activity201MaLiAnNaModel.instance:isEpisodePass(self.id)

	gohelper.setActive(self._gopointnormal, not self._ispass)
	gohelper.setActive(self._gppointfinish, self._ispass)
	gohelper.setActive(self._gostagenormal, not self._ispass)
	gohelper.setActive(self._gostagefinish, self._ispass)
	gohelper.setActive(self._goCurrent, false)

	self._anim.enabled = true

	AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_level_finish)
	self._anim:Play("finish", 0, 0)

	for _, star in ipairs(self._stars) do
		gohelper.setActive(star.no, not self._ispass)
		gohelper.setActive(star.has, self._ispass)
	end
end

function Activity201MaLiAnNaLevelItem:playUnlock()
	self._isunlock = Activity201MaLiAnNaModel.instance:isEpisodeUnlock(self.id)

	gohelper.setActive(self._gounlock, self._isunlock)

	local isCurrent = self.id == Activity201MaLiAnNaModel.instance:getCurEpisode()

	gohelper.setActive(self._goCurrent, isCurrent)
	AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_level_appear)
	self._anim:Play("unlock", 0, 0)
end

function Activity201MaLiAnNaLevelItem:playStarAnim()
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
end

function Activity201MaLiAnNaLevelItem:removeEventListeners()
	Activity201MaLiAnNaController.instance:unregisterCallback(NuoDiKaEvent.JumpToEpisode, self._onJumpToEpisode, self)
	self._btnclick:RemoveClickListener()
end

return Activity201MaLiAnNaLevelItem
