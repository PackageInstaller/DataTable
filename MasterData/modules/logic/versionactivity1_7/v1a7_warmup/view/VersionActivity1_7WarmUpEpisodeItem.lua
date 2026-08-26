-- chunkname: @modules/logic/versionactivity1_7/v1a7_warmup/view/VersionActivity1_7WarmUpEpisodeItem.lua

module("modules.logic.versionactivity1_7.v1a7_warmup.view.VersionActivity1_7WarmUpEpisodeItem", package.seeall)

local VersionActivity1_7WarmUpEpisodeItem = class("VersionActivity1_7WarmUpEpisodeItem", UserDataDispose)

function VersionActivity1_7WarmUpEpisodeItem:onInit(go)
	self:__onInit()

	self._go = go
	self._gopic = gohelper.findChild(self._go, "pic")
	self._golocked = gohelper.findChild(self._go, "locked")
	self._gonormal = gohelper.findChild(self._go, "normal")
	self._goselect = gohelper.findChild(self._go, "select")
	self._btnselect = gohelper.findChildButtonWithAudio(self._go, "#btn_select")

	self.addClickCb(self, self._btnselect, self.onClickSelect, self)

	self._animator = self._go:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_7WarmUpEpisodeItem:onClickSelect()
	if self.viewContainer:isPlayingDesc() then
		return
	end

	if not self.episodeCo then
		return
	end

	local isOpen = Activity125Model.instance:isEpisodeReallyOpen(self.activityId, self.episodeId)

	if not isOpen then
		return
	end

	local selectId = Activity125Model.instance:getSelectEpisodeId(self.activityId)
	local isOld = Activity125Model.instance:checkIsOldEpisode(self.activityId, self.episodeId)
	local isPlay = Activity125Model.instance:checkLocalIsPlay(self.activityId, self.episodeId)
	local isFinish = Activity125Model.instance:isEpisodeFinished(self.activityId, self.episodeId)
	local isSelelct = (isOld or isPlay or isFinish) and selectId == self.episodeId

	if isSelelct then
		return
	end

	Activity125Model.instance:setSelectEpisodeId(self.activityId, self.episodeId)

	if not isOld then
		Activity125Model.instance:setOldEpisode(self.activityId, self.episodeId)
	end

	Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate)
end

function VersionActivity1_7WarmUpEpisodeItem:updateData(episodeCo)
	self.episodeCo = episodeCo

	self:refreshItem()
end

function VersionActivity1_7WarmUpEpisodeItem:refreshItem()
	if not self.episodeCo then
		gohelper.setActive(self._go, false)

		return
	end

	gohelper.setActive(self._go, true)

	self.activityId = self.episodeCo.activityId
	self.episodeId = self.episodeCo.id

	local isOpen = Activity125Model.instance:isEpisodeReallyOpen(self.activityId, self.episodeId)

	if self.episodeIsOpen == false and isOpen then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_no_effect)
	end

	self.episodeIsOpen = isOpen

	if not isOpen then
		self:playAnimation("locked")

		return
	end

	local isFinish = Activity125Model.instance:isEpisodeFinished(self.activityId, self.episodeId)
	local selectId = Activity125Model.instance:getSelectEpisodeId(self.activityId)
	local isPlay = Activity125Model.instance:checkLocalIsPlay(self.activityId, self.episodeId)
	local isOld = Activity125Model.instance:checkIsOldEpisode(self.activityId, self.episodeId)
	local isSelect = selectId == self.episodeId

	if isSelect and (isPlay or isFinish or isOld) then
		self:playAnimation("select")
	elseif isPlay then
		self._animator:Play("finish", 0, 1)
	else
		self:playAnimation("normal")
	end
end

function VersionActivity1_7WarmUpEpisodeItem:playAnimation(name)
	self._animator:Play(name)
end

function VersionActivity1_7WarmUpEpisodeItem:getPos()
	return recthelper.getAnchorX(self._go.transform)
end

function VersionActivity1_7WarmUpEpisodeItem:onDestroy()
	self:__onDispose()
end

return VersionActivity1_7WarmUpEpisodeItem
