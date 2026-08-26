-- chunkname: @modules/logic/versionactivity1_7/v1a7_warmup/view/VersionActivity1_7WarmUpMapView.lua

module("modules.logic.versionactivity1_7.v1a7_warmup.view.VersionActivity1_7WarmUpMapView", package.seeall)

local VersionActivity1_7WarmUpMapView = class("VersionActivity1_7WarmUpMapView", BaseView)

function VersionActivity1_7WarmUpMapView:onInitView()
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._gomapcontent = gohelper.findChild(self.viewGO, "#go_map/Viewport/Content")

	local setting = self.viewContainer:getSetting()
	local resPath = setting.otherRes.mapRes

	self._gomaproot = self.viewContainer:getResInst(resPath, self._gomapcontent, "mapRoot")
	self.lineAnimator = gohelper.findChildComponent(self._gomaproot, "Line", typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_7WarmUpMapView:addEvents()
	self.addEventCb(self, Activity125Controller.instance, Activity125Event.DataUpdate, self.refreshUI, self)
	self.addEventCb(self, Activity125Controller.instance, Activity125Event.EpisodeUnlock, self.unlockLine, self)
end

function VersionActivity1_7WarmUpMapView:removeEvents()
	self.removeEventCb(self, Activity125Controller.instance, Activity125Event.DataUpdate, self.refreshUI, self)
	self.removeEventCb(self, Activity125Controller.instance, Activity125Event.EpisodeUnlock, self.unlockLine, self)
end

function VersionActivity1_7WarmUpMapView:_editableInitView()
	return
end

function VersionActivity1_7WarmUpMapView:onOpen()
	self._actId = ActivityEnum.Activity.Activity1_7WarmUp

	local mo = Activity125Model.instance:getById(self._actId)

	if mo then
		self:refreshUI()
	end
end

function VersionActivity1_7WarmUpMapView:refreshUI()
	TaskDispatcher.cancelTask(self.unlockLineCallback, self)
	self:initItemList()
	self:updateEpisodes()
	self:updateMapPos(self.notFirst)
end

function VersionActivity1_7WarmUpMapView:unlockLine(noAnim)
	local episodeId = Activity125Model.instance:getLastEpisode(self._actId)
	local isPlay = Activity125Model.instance:checkLocalIsPlay(self._actId, episodeId)

	if episodeId == 1 and not isPlay then
		gohelper.setActive(self.lineAnimator, false)

		return
	end

	gohelper.setActive(self.lineAnimator, true)

	if noAnim then
		self.lineAnimator:Play(string.format("go%s", episodeId - 1), 0, 1)
	else
		self.unlockEpisode = episodeId

		self.lineAnimator:Play(string.format("go%s", episodeId - 1))
		TaskDispatcher.runDelay(self.unlockLineCallback, self, 0.84)
	end
end

function VersionActivity1_7WarmUpMapView:unlockLineCallback()
	local episode = self.unlockEpisode

	self.unlockEpisode = nil

	local item = self.itemList[episode]

	if item then
		item:refreshItem()
	end
end

function VersionActivity1_7WarmUpMapView:updateMapPos(tween)
	if self._movetweenId then
		ZProj.TweenHelper.KillById(self._movetweenId)

		self._movetweenId = nil
	end

	local max = math.max(recthelper.getWidth(self._gomapcontent.transform) - recthelper.getWidth(self._gomap.transform), 0)
	local selectId = Activity125Model.instance:getSelectEpisodeId(self._actId)

	if self.selectId == selectId then
		return
	end

	self.selectId = selectId

	local pos = self:getItemPos(selectId)
	local endX = -math.min(pos, max)

	if tween then
		local startX = recthelper.getAnchorX(self._gomapcontent.transform)
		local distance = math.abs(endX - startX)

		if distance > 1 then
			local speed = 1000
			local time = distance / speed

			self._movetweenId = ZProj.TweenHelper.DOAnchorPosX(self._gomapcontent.transform, endX, time)
		end
	else
		recthelper.setAnchorX(self._gomapcontent.transform, endX)
	end

	self.notFirst = true
end

function VersionActivity1_7WarmUpMapView:getItemPos(index)
	local item = self.itemList[index]

	if not item then
		return 0
	end

	local contentWidth = recthelper.getWidth(self._gomapcontent.transform)
	local screenWidth = recthelper.getWidth(self._gomap.transform) * 0.5
	local width = contentWidth * 0.5
	local center = screenWidth - 200
	local pos = width + item:getPos() - center

	return math.max(pos, 0)
end

function VersionActivity1_7WarmUpMapView:initItemList()
	if self.itemList then
		return
	end

	local count = Activity125Model.instance:getEpisodeCount(self._actId)

	self.itemList = self:getUserDataTb_()

	for i = 1, count do
		local go = gohelper.findChild(self._gomaproot, string.format("mapitem%s", i))

		self.itemList[i] = self:createEpisodeItem(go)
	end
end

function VersionActivity1_7WarmUpMapView:createEpisodeItem(go)
	local item = VersionActivity1_7WarmUpEpisodeItem.New()

	item.viewContainer = self.viewContainer

	item:onInit(go)

	return item
end

function VersionActivity1_7WarmUpMapView:updateEpisodes()
	local list = Activity125Model.instance:getEpisodeList(self._actId)

	if list then
		for i, v in ipairs(list) do
			local item = self.itemList[i]

			if item then
				item:updateData(v)
			end
		end
	end

	if not self.unlockEpisode then
		self:unlockLine(true)
	end
end

function VersionActivity1_7WarmUpMapView:onClose()
	return
end

function VersionActivity1_7WarmUpMapView:onDestroyView()
	TaskDispatcher.cancelTask(self.unlockLineCallback, self)

	if self.itemList then
		for i, v in ipairs(self.itemList) do
			v:onDestroy()
		end
	end

	if self._movetweenId then
		ZProj.TweenHelper.KillById(self._movetweenId)

		self._movetweenId = nil
	end
end

return VersionActivity1_7WarmUpMapView
