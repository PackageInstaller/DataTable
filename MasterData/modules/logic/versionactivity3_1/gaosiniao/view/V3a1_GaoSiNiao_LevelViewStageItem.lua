-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_LevelViewStageItem.lua

local csAnimatorPlayer = SLFramework.AnimatorPlayer

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_LevelViewStageItem", package.seeall)

local V3a1_GaoSiNiao_LevelViewStageItem = class("V3a1_GaoSiNiao_LevelViewStageItem", RougeSimpleItemBase)

function V3a1_GaoSiNiao_LevelViewStageItem:onInitView()
	self._txtstageNum = gohelper.findChildText(self.viewGO, "unlock/info/#txt_stageNum")
	self._goBattle = gohelper.findChild(self.viewGO, "unlock/info/LayoutGroup/#go_Battle")
	self._txtstagename = gohelper.findChildText(self.viewGO, "unlock/info/LayoutGroup/#txt_stagename")
	self._gostar = gohelper.findChild(self.viewGO, "unlock/info/LayoutGroup/#go_star")
	self._goCurrent = gohelper.findChild(self.viewGO, "unlock/#go_Current")
	self._goFinished = gohelper.findChild(self.viewGO, "unlock/#go_Finished")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "unlock/#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a1_GaoSiNiao_LevelViewStageItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function V3a1_GaoSiNiao_LevelViewStageItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function V3a1_GaoSiNiao_LevelViewStageItem:_btnclickOnClick()
	local p = self:parent()

	p:onStageItemClick(self)
end

function V3a1_GaoSiNiao_LevelViewStageItem:ctor(ctorParam)
	V3a1_GaoSiNiao_LevelViewStageItem.super.ctor(self, ctorParam)
end

function V3a1_GaoSiNiao_LevelViewStageItem:addEventListeners()
	V3a1_GaoSiNiao_LevelViewStageItem.super.addEventListeners(self)
end

function V3a1_GaoSiNiao_LevelViewStageItem:removeEventListeners()
	V3a1_GaoSiNiao_LevelViewStageItem.super.removeEventListeners(self)
end

function V3a1_GaoSiNiao_LevelViewStageItem:onDestroyView()
	V3a1_GaoSiNiao_LevelViewStageItem.super.onDestroyView(self)
end

function V3a1_GaoSiNiao_LevelViewStageItem:_getUserDataTb_goMark()
	local list = self:getUserDataTb_()
	local goPathFmt = "#go_Mark%s"
	local i = 0

	repeat
		i = i + 1

		local go = gohelper.findChild(self._goFinished, string.format(goPathFmt, i))
		local isNil = gohelper.isNil(go)

		if not isNil then
			table.insert(list, go)
			gohelper.setActive(go, false)
		end
	until isNil

	return list
end

function V3a1_GaoSiNiao_LevelViewStageItem:_editableInitView()
	self._hasGo = gohelper.findChild(self._gostar, "star1/has")
	self._noGo = gohelper.findChild(self._gostar, "star1/no")
	self._image_FinishedGo = gohelper.findChild(self._goFinished, "image_Finished")
	self._goMarkList = self:_getUserDataTb_goMark()
	self._animatorPlayer_goMarkList = self:getUserDataTb_()

	for _, go in ipairs(self._goMarkList) do
		table.insert(self._animatorPlayer_goMarkList, csAnimatorPlayer.Get(go))
	end

	gohelper.setActive(self._goBattle, false)
	self:setActive_goCurrent(false)
	self:_setDisactive(false)

	self._animatorPlayer = csAnimatorPlayer.Get(self.viewGO)
end

function V3a1_GaoSiNiao_LevelViewStageItem:_setPassed(isPass)
	gohelper.setActive(self._hasGo, isPass)
	gohelper.setActive(self._noGo, not isPass)
end

function V3a1_GaoSiNiao_LevelViewStageItem:episodeId()
	return self._mo.episodeId
end

function V3a1_GaoSiNiao_LevelViewStageItem:isEpisodeOpen()
	local c = self:baseViewContainer()

	return c:isEpisodeOpen(self:episodeId())
end

function V3a1_GaoSiNiao_LevelViewStageItem:hasPlayedUnlockedAnimPath()
	local c = self:baseViewContainer()

	return c:hasPlayedUnlockedAnimPath(self:episodeId())
end

function V3a1_GaoSiNiao_LevelViewStageItem:hasPassLevelAndStory()
	local c = self:baseViewContainer()

	return c:hasPassLevelAndStory(self:episodeId())
end

function V3a1_GaoSiNiao_LevelViewStageItem:getPreEpisodeId()
	local c = self:baseViewContainer()

	return c:getPreEpisodeId(self:episodeId())
end

function V3a1_GaoSiNiao_LevelViewStageItem:setData(mo)
	V3a1_GaoSiNiao_LevelViewStageItem.super.setData(self, mo)

	local episodeCO = mo
	local isBattle = episodeCO.gameId > 0
	local isPassed = self:hasPassLevelAndStory()

	self._txtstageNum.text = string.format("%02d", self:index())
	self._txtstagename.text = episodeCO.name

	gohelper.setActive(self._goBattle, isBattle)
	self:_setPassed(isPassed)
end

function V3a1_GaoSiNiao_LevelViewStageItem:setActive_goCurrent(isActive)
	gohelper.setActive(self._goCurrent, isActive)
end

function V3a1_GaoSiNiao_LevelViewStageItem:_setDisactive(isDisactive)
	if isDisactive then
		self:_setPassed(false)
	end

	gohelper.setActive(self._goFinished, isDisactive)
end

function V3a1_GaoSiNiao_LevelViewStageItem:setActive_goMark(index)
	if not index then
		self:_setDisactive(false)

		return
	end

	local isDisactive = false

	for i, go in ipairs(self._goMarkList) do
		gohelper.setActive(go, i == index)

		if i == index then
			isDisactive = true
		end
	end

	self:_setDisactive(isDisactive)
end

function V3a1_GaoSiNiao_LevelViewStageItem:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

function V3a1_GaoSiNiao_LevelViewStageItem:_playAnim_goFinished(name, cb, cbObj)
	self._animatorPlayer_goFinished:Play(name, cb or function()
		return
	end, cbObj)
end

function V3a1_GaoSiNiao_LevelViewStageItem:playAnim_Open(cb, cbObj)
	self:setActive(true)
	self:_playAnim(UIAnimationName.Open, cb, cbObj)
end

function V3a1_GaoSiNiao_LevelViewStageItem:playAnim_Idle(cb, cbObj)
	self:setActive(true)
	self:_playAnim(UIAnimationName.Idle, cb, cbObj)
end

function V3a1_GaoSiNiao_LevelViewStageItem:playAnim_MarkFinish(goMarkIndex, cb, cbObj)
	self:setActive_goMark(goMarkIndex)

	local animPlayer = self._animatorPlayer_goMarkList[goMarkIndex]

	if not animPlayer then
		if cb then
			cb(cbObj)
		end

		return
	end

	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_lock)
	animPlayer:Play(UIAnimationName.Finish, cb or function()
		return
	end, cbObj)
end

function V3a1_GaoSiNiao_LevelViewStageItem:playAnim_MarkIdle(goMarkIndex, cb, cbObj)
	self:setActive_goMark(goMarkIndex)

	local animPlayer = self._animatorPlayer_goMarkList[goMarkIndex]

	if not animPlayer then
		if cb then
			cb(cbObj)
		end

		return
	end

	animPlayer:Play(UIAnimationName.Idle, cb or function()
		return
	end, cbObj)
end

return V3a1_GaoSiNiao_LevelViewStageItem
