-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiLevelItem.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiLevelItem", package.seeall)

local DianJiShiLevelItem = class("DianJiShiLevelItem", LuaCompBase)

function DianJiShiLevelItem:init(go)
	self.viewGO = go
	self.transform = self.viewGO.transform
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Click")
	self._typeNode = {}
	self._gonormal = gohelper.findChild(self.viewGO, "#go_Normal")
	self._gospecial = gohelper.findChild(self.viewGO, "#go_Special")
	self._goCurrent = gohelper.findChild(self.viewGO, "#go_Current")

	self:_initNode(self._gonormal)
	self:_initNode(self._gospecial, true)

	self._anim1 = gohelper.onceAddComponent(self._gonormal, gohelper.Type_Animator)
	self._anim2 = gohelper.onceAddComponent(self._gospecial, gohelper.Type_Animator)
end

function DianJiShiLevelItem:_initNode(nodeGo, isSpecial)
	local node = self:getUserDataTb_()

	node.go = nodeGo
	node._txtName = gohelper.findChildText(nodeGo, "Layout/txt_StageName")
	node._txtNum = gohelper.findChildText(nodeGo, "Layout/Num/txt_StageNum")
	node._gostar = gohelper.findChild(nodeGo, "Star/go_Star")
	node._golock = gohelper.findChild(nodeGo, "#go_Locked")
	node._anim = gohelper.onceAddComponent(nodeGo, gohelper.Type_Animator)

	table.insert(self._typeNode, node)
end

function DianJiShiLevelItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnOnClick, self)
end

function DianJiShiLevelItem:removeEventListeners()
	DianJiShiLevelController.instance:unregisterCallback(DianJiShiGameEvent.JumpToEpisode, self._onJumpToEpisode, self)
	self._btnclick:RemoveClickListener()
end

function DianJiShiLevelItem:_btnOnClick()
	local isUnlock = DianJiShiModel.instance:isEpisodeUnlock(self.id)

	if not isUnlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

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

function DianJiShiLevelItem:setParam(co, index, actId)
	self._config = co
	self.id = co.episodeId
	self._actId = actId
	self._index = index
	self._isStoryEpisode = self._config.gameId == 0
	self.gameId = self._config.gameId

	if self._isStoryEpisode then
		self._node = self._typeNode[1] or self._typeNode[2]
	end

	gohelper.setActive(self._typeNode[1].go, self._isStoryEpisode)
	gohelper.setActive(self._typeNode[2].go, not self._isStoryEpisode)
	self:refreshUI()
end

function DianJiShiLevelItem:refreshUI()
	self._isunlock = DianJiShiModel.instance:isEpisodeUnlock(self.id)
	self._ispass = DianJiShiModel.instance:isEpisodePass(self.id)

	local isCurrent = self.id == DianJiShiModel.instance:getCurEpisode()

	gohelper.setActive(self._node._golock, not self._isunlock)
	gohelper.setActive(self._btnclick.gameObject, true)
	gohelper.setActive(self._goCurrent, isCurrent)

	self._node._txtName.text = self._config.name
	self._node._txtNum.text = string.format("%02d", self._index)

	gohelper.setActive(self._node._gostar, self._ispass)
	self._anim1:Play("idle")
	self._anim2:Play("idle")
end

function DianJiShiLevelItem:_enterGame()
	if DianJiShiModel.instance:checkEpisodeFinishGame(self.id) and not DianJiShiModel.instance:isEpisodePass(self.id) then
		self:_onGameFinished()
	else
		DianJiShiLevelController.instance:enterGame(self.id)
	end
end

function DianJiShiLevelItem:_onGameFinished()
	DianJiShiLevelController.instance:_onGameFinished(self._actId, self.id)
end

function DianJiShiLevelItem:isUnlock()
	return self._isunlock
end

function DianJiShiLevelItem:playFinish()
	self._ispass = DianJiShiModel.instance:isEpisodePass(self.id)

	gohelper.setActive(self._goCurrent, false)

	if self._isStoryEpisode then
		self._anim1.enabled = true

		self._anim1:Play("finish", 0, 0)
	else
		self._anim2.enabled = true

		self._anim2:Play("finish", 0, 0)
	end

	if self._isunlock then
		gohelper.setActive(self._node._gostar, self._ispass)
	end
end

function DianJiShiLevelItem:setFocusFlag(isFocus)
	gohelper.setActive(self._goCurrent, isFocus)
end

function DianJiShiLevelItem:playUnlock()
	self._isunlock = DianJiShiModel.instance:isEpisodeUnlock(self.id)

	local isCurrent = self.id == DianJiShiModel.instance:getCurEpisode()

	gohelper.setActive(self._goCurrent, isCurrent)
	gohelper.setActive(self._node._golock, true)

	if self._isStoryEpisode then
		self._anim1.enabled = true

		self._anim1:Play("unlock", 0, 0)
	else
		self._anim2.enabled = true

		self._anim2:Play("unlock", 0, 0)
	end

	AudioMgr.instance:trigger(AudioEnum3_8.DianJiShi.UnlockNewEpisode)
end

function DianJiShiLevelItem:playStarAnim()
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
end

return DianJiShiLevelItem
