-- chunkname: @modules/logic/versionactivity3_4/lusijian/view/LuSiJianLevelItem.lua

module("modules.logic.versionactivity3_4.lusijian.view.LuSiJianLevelItem", package.seeall)

local LuSiJianLevelItem = class("LuSiJianLevelItem", LuaCompBase)

function LuSiJianLevelItem:init(go)
	self.viewGO = go
	self.transform = self.viewGO.transform
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Click")
	self._typeNode = {}
	self._gonormal = gohelper.findChild(self.viewGO, "#go_Normal")
	self._gospecial = gohelper.findChild(self.viewGO, "#go_Special")
	self._goCurrent = gohelper.findChild(self.viewGO, "#go_Current")

	self:_initNode(self._gonormal)
	self:_initNode(self._gospecial, true)

	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function LuSiJianLevelItem:_initNode(nodeGo, isSpecial)
	local node = self:getUserDataTb_()

	node.go = nodeGo
	node._txtName = gohelper.findChildText(nodeGo, "txt_StageName")
	node._txtNum = gohelper.findChildText(nodeGo, "txt_StageNum")
	node._gostar = gohelper.findChild(nodeGo, "Star/go_Star")
	node._golock = gohelper.findChild(nodeGo, "#go_Locked")

	if isSpecial then
		node.iconList = {}

		for i = 1, 4 do
			local goicon = gohelper.findChild(nodeGo, "#go_Icon" .. i)

			gohelper.setActive(goicon, false)
			table.insert(node.iconList, goicon)
		end
	end

	table.insert(self._typeNode, node)
end

function LuSiJianLevelItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnOnClick, self)
end

function LuSiJianLevelItem:_btnOnClick()
	local isUnlock = LuSiJianModel.instance:isEpisodeUnlock(self.id)

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

function LuSiJianLevelItem:setParam(co, index, actId)
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

	if not self._isStoryEpisode then
		local index = LuSiJianConfig.instance:getIndexInGameIdList(self.gameId)
		local goicon = self._node.iconList[index]

		gohelper.setActive(goicon, true)
	end

	self:refreshUI()
end

function LuSiJianLevelItem:refreshUI()
	self._isunlock = LuSiJianModel.instance:isEpisodeUnlock(self.id)
	self._ispass = LuSiJianModel.instance:isEpisodePass(self.id)

	local isCurrent = self.id == LuSiJianModel.instance:getCurEpisode()

	gohelper.setActive(self._node._golock, not self._isunlock)
	gohelper.setActive(self._btnclick.gameObject, true)
	gohelper.setActive(self._goCurrent, isCurrent)

	self._node._txtName.text = self._config.name
	self._node._txtNum.text = string.format("%02d", self._index)

	gohelper.setActive(self._node._gostar, self._ispass)
end

function LuSiJianLevelItem:_enterGame()
	if LuSiJianModel.instance:checkEpisodeFinishGame(self.id) and not LuSiJianModel.instance:isEpisodePass(self.id) then
		self:_onGameFinished()
	else
		LuSiJianGameController.instance:enterGame(self.id)
	end
end

function LuSiJianLevelItem:_onGameFinished()
	LuSiJianController.instance:_onGameFinished(self._actId, self.id)
end

function LuSiJianLevelItem:isUnlock()
	return self._isunlock
end

function LuSiJianLevelItem:playFinish()
	self._ispass = LuSiJianModel.instance:isEpisodePass(self.id)

	gohelper.setActive(self._goCurrent, false)

	self._anim.enabled = true

	self._anim:Play("finish", 0, 0)

	if self._isunlock then
		gohelper.setActive(self._node._gostar, self._ispass)
	end
end

function LuSiJianLevelItem:setFocusFlag(isFocus)
	gohelper.setActive(self._goCurrent, isFocus)
end

function LuSiJianLevelItem:playUnlock()
	self._isunlock = LuSiJianModel.instance:isEpisodeUnlock(self.id)

	local isCurrent = self.id == LuSiJianModel.instance:getCurEpisode()

	gohelper.setActive(self._goCurrent, isCurrent)
	gohelper.setActive(self._golock, not self._isunlock)
	self._anim:Play("unlock", 0, 0)
	AudioMgr.instance:trigger(AudioEnum3_4.LuSiJian.play_ui_bulaochun_level2)
end

function LuSiJianLevelItem:playStarAnim()
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
end

function LuSiJianLevelItem:removeEventListeners()
	LuSiJianController.instance:unregisterCallback(LuSiJianEvent.JumpToEpisode, self._onJumpToEpisode, self)
	self._btnclick:RemoveClickListener()
end

return LuSiJianLevelItem
