-- chunkname: @modules/logic/versionactivity3_3/marsha/view/comp/MarshaLevelItem.lua

module("modules.logic.versionactivity3_3.marsha.view.comp.MarshaLevelItem", package.seeall)

local MarshaLevelItem = class("MarshaLevelItem", LuaCompBase)

function MarshaLevelItem:init(go)
	self.go = go
	self.transform = self.go.transform
	self._goNormal = gohelper.findChild(self.go, "#go_Normal")
	self._goSpecial = gohelper.findChild(self.go, "#go_Special")
	self._goCurrent = gohelper.findChild(self.go, "#go_Current")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "#btn_Click")
	self._goVxFinish = gohelper.findChild(self.go, "vx_finish")
	self._goVxUnlockEff = gohelper.setActive(self.go, "vx_unlock")
	self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._goNormal, false)
	gohelper.setActive(self._goSpecial, false)
	gohelper.setActive(self._btnClick, false)
end

function MarshaLevelItem:addEventListeners()
	self.addClickCb(self, self._btnClick, self._btnOnClick, self)
	self.addEventCb(self, MarshaController.instance, MarshaEvent.ClickLevelItem, self.refreshSelect, self)
end

function MarshaLevelItem:_btnOnClick()
	MarshaModel.instance:setCurEpisode(self.config.episodeId)

	if self.config.gameId == 0 then
		if self.config.storyBefore > 0 then
			local param = {}

			param.mark = true

			StoryController.instance:playStory(self.config.storyBefore, param, self._onGameFinished, self)
		else
			self:_onGameFinished()
		end
	elseif self.config.storyBefore > 0 then
		local param = {}

		param.mark = true

		StoryController.instance:playStory(self.config.storyBefore, param, self._storyBeforeFinish, self)
	else
		self:_storyBeforeFinish()
	end

	MarshaController.instance:dispatchEvent(MarshaEvent.ClickLevelItem)
end

function MarshaLevelItem:setData(co, index, actId)
	self.actId = actId
	self.index = index
	self.config = co
	self.id = co.episodeId
	self.isUnlock = MarshaModel.instance:isEpisodeUnlock(self.id)
	self.isPass = MarshaModel.instance:isEpisodePass(self.id)
	self.goUnlock = self.config.gameId == 0 and self._goNormal or self._goSpecial

	self:initUI()
	self:refreshUI()
end

function MarshaLevelItem:initUI()
	self.txtStageNum = gohelper.findChildText(self.goUnlock, "txt_StageNum")
	self.txtStageName = gohelper.findChildText(self.goUnlock, "txt_StageName")
	self.goStar = gohelper.findChild(self.goUnlock, "Star/go_Star")
end

function MarshaLevelItem:refreshUI()
	self.txtStageNum.text = self.index
	self.txtStageName.text = self.config.name

	if not self.isUnlock then
		return
	end

	gohelper.setActive(self.goUnlock, true)
	gohelper.setActive(self._btnClick, true)
	gohelper.setActive(self.goStar, self.isPass)
	self:refreshSelect()
end

function MarshaLevelItem:refreshSelect()
	local isCurrent = self.id == MarshaModel.instance:getCurEpisode()

	gohelper.setActive(self._goCurrent, isCurrent)
end

function MarshaLevelItem:_storyBeforeFinish()
	ViewMgr.instance:openView(ViewName.MarshaGameView, self.config.gameId)
end

function MarshaLevelItem:_onGameFinished()
	MarshaController.instance:onGameFinish()
end

function MarshaLevelItem:playFinish()
	self.isPass = MarshaModel.instance:isEpisodePass(self.id)

	gohelper.setActive(self._goCurrent, false)
	gohelper.setActive(self._goVxFinish, false)

	self._anim.enabled = true

	self._anim:Play("finish", 0, 0)
	gohelper.setActive(self.goStar, true)
end

function MarshaLevelItem:playUnlock()
	self.isUnlock = MarshaModel.instance:isEpisodeUnlock(self.id)

	gohelper.setActive(self.goUnlock, self.isUnlock)
	gohelper.setActive(self._btnClick, self.isUnlock)
	gohelper.setActive(self._goVxUnlockEff, self.isUnlock)

	local isCurrent = self.id == MarshaModel.instance:getCurEpisode()

	gohelper.setActive(self._goCurrent, isCurrent)
	self._anim:Play("unlock", 0, 0)
end

function MarshaLevelItem:playStarAnim()
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
end

return MarshaLevelItem
