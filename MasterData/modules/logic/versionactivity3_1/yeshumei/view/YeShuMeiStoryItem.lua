-- chunkname: @modules/logic/versionactivity3_1/yeshumei/view/YeShuMeiStoryItem.lua

module("modules.logic.versionactivity3_1.yeshumei.view.YeShuMeiStoryItem", package.seeall)

local YeShuMeiStoryItem = class("YeShuMeiStoryItem", LuaCompBase)

function YeShuMeiStoryItem:init(go)
	self.viewGO = go
	self.transform = go.transform
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "unlock/#btn_click")
	self._typeNode = {}

	self:_initType()

	self._anim = go:GetComponent(typeof(UnityEngine.Animator))
end

function YeShuMeiStoryItem:_initType()
	for i = 1, 2 do
		local node = self:getUserDataTb_()

		node.go = gohelper.findChild(self.viewGO, "unlock/#go_StageType" .. i)
		node.gounlocked = gohelper.findChild(node.go, "#go_UnLocked")
		node.golock = gohelper.findChild(node.go, "#go_Locked")
		node.txtlockNum = gohelper.findChildText(node.go, "#go_Locked/#txt_stageNum")
		node.txtlockName = gohelper.findChildText(node.go, "#go_Locked/#txt_StageName")
		node.txtunlockedNum = gohelper.findChildText(node.go, "#go_UnLocked/#txt_stageNum")
		node.txtunlockedName = gohelper.findChildText(node.go, "#go_UnLocked/#txt_StageName")
		node.gofinished = gohelper.findChild(node.go, "#go_Finished")
		node.txtfinishedNum = gohelper.findChildText(node.go, "#go_Finished/#txt_stageNum")
		node.txtfinishedName = gohelper.findChildText(node.go, "#go_Finished/#txt_StageName")
		node.gocurrent = gohelper.findChild(node.go, "#go_Current")
		node.txtcurrentNum = gohelper.findChildText(node.go, "#go_Current/#txt_stageNum")
		node.txtcurrentName = gohelper.findChildText(node.go, "#go_Current/#txt_StageName")
		node.gono = gohelper.findChild(node.go, "Star/no")
		node.gostar = gohelper.findChild(node.go, "Star/#go_star")
		node.gostaranim = gohelper.findChild(node.go, "Star/#go_star/#image_Star")
		node.animstar = node.gostaranim:GetComponent(typeof(UnityEngine.Animation))

		table.insert(self._typeNode, node)
	end
end

function YeShuMeiStoryItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnOnClick, self)
end

function YeShuMeiStoryItem:_btnOnClick()
	if self._isStoryEpisode then
		if self._config.storyBefore > 0 then
			local param = {}

			param.mark = true

			StoryController.instance:playStory(self._config.storyBefore, param, self._onGameFinished, self)
		else
			self:_onGameFinished()
		end
	elseif self._config.storyBefore > 0 then
		local param = {}

		param.mark = true

		StoryController.instance:playStory(self._config.storyBefore, param, self._enterGame, self)
	else
		self:_enterGame()
	end

	RoleActivityController.instance:dispatchEvent(RoleActivityEvent.StoryItemClick, self._index)
end

function YeShuMeiStoryItem:setParam(co, index, actId)
	self._config = co
	self.id = co.episodeId
	self._actId = actId
	self._index = index
	self._isStoryEpisode = self._config.gameId == 0

	gohelper.setActive(self._typeNode[1].go, self._isStoryEpisode)
	gohelper.setActive(self._typeNode[2].go, not self._isStoryEpisode)

	if self._isStoryEpisode then
		self._node = self._typeNode[1] or self._typeNode[2]
	end

	self.gameId = self._config.gameId

	self:refreshUI()
end

function YeShuMeiStoryItem:refreshUI()
	self._isunlock = YeShuMeiModel.instance:isEpisodeUnlock(self.id)
	self._ispass = YeShuMeiModel.instance:isEpisodePass(self.id)

	local isCurrent = self.id == YeShuMeiModel.instance:getCurEpisode()

	gohelper.setActive(self._node.golock, not self._isunlock)
	gohelper.setActive(self._btnclick.gameObject, self._isunlock)
	gohelper.setActive(self._node.gofinished, not isCurrent and self._ispass)
	gohelper.setActive(self._node.gounlocked, not isCurrent and not self._ispass and self._isunlock)
	gohelper.setActive(self._node.gocurrent, isCurrent)

	self._node.txtunlockedName.text = self._config.name
	self._node.txtunlockedNum.text = string.format("%02d", self._index)
	self._node.txtlockName.text = self._config.name
	self._node.txtlockNum.text = string.format("%02d", self._index)
	self._node.txtfinishedName.text = self._config.name
	self._node.txtfinishedNum.text = string.format("%02d", self._index)
	self._node.txtcurrentName.text = self._config.name
	self._node.txtcurrentNum.text = string.format("%02d", self._index)

	gohelper.setActive(self._node.gono, not self._ispass)
	gohelper.setActive(self._node.gostar, self._ispass)
end

function YeShuMeiStoryItem:_enterGame()
	if YeShuMeiModel.instance:checkEpisodeFinishGame(self.id) and not YeShuMeiModel.instance:isEpisodePass(self.id) then
		self:_onGameFinished()
	else
		YeShuMeiGameController.instance:enterGame(self.id)
	end
end

function YeShuMeiStoryItem:_onGameFinished()
	YeShuMeiController.instance:_onGameFinished(self._actId, self.id)
end

function YeShuMeiStoryItem:isUnlock()
	return self._isunlock
end

function YeShuMeiStoryItem:playFinish()
	self._ispass = YeShuMeiModel.instance:isEpisodePass(self.id)

	gohelper.setActive(self._node.gofinished, self._ispass)
	gohelper.setActive(self._node.gounlocked, false)
	gohelper.setActive(self._node.gocurrent, false)

	self._anim.enabled = true

	self._anim:Play("finish", 0, 0)

	if self._isunlock then
		gohelper.setActive(self._node.gono, not self._ispass)
		gohelper.setActive(self._node.gostar, self._ispass)
	end
end

function YeShuMeiStoryItem:setFocusFlag(isFocus)
	gohelper.setActive(self._node.gocurrent, isFocus)
end

function YeShuMeiStoryItem:playUnlock()
	self._isunlock = YeShuMeiModel.instance:isEpisodeUnlock(self.id)

	local isCurrent = self.id == YeShuMeiModel.instance:getCurEpisode()

	gohelper.setActive(self._node.gounlocked, false)
	gohelper.setActive(self._node.golock, false)
	gohelper.setActive(self._node.gofinished, false)
	gohelper.setActive(self._node.gocurrent, isCurrent)
	self._anim:Play("unlock", 0, 0)
	AudioMgr.instance:trigger(AudioEnum3_1.YeShuMei.play_ui_mingdi_ysm_jiesuo)
end

function YeShuMeiStoryItem:playStarAnim()
	self._node.animstar:Play()
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
end

function YeShuMeiStoryItem:removeEventListeners()
	YeShuMeiController.instance:unregisterCallback(NuoDiKaEvent.JumpToEpisode, self._onJumpToEpisode, self)
	self._btnclick:RemoveClickListener()
end

return YeShuMeiStoryItem
