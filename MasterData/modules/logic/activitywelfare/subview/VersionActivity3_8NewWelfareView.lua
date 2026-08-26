-- chunkname: @modules/logic/activitywelfare/subview/VersionActivity3_8NewWelfareView.lua

module("modules.logic.activitywelfare.subview.VersionActivity3_8NewWelfareView", package.seeall)

local VersionActivity3_8NewWelfareView = class("VersionActivity3_8NewWelfareView", BaseView)

function VersionActivity3_8NewWelfareView:onInitView()
	self._txtlimittime = gohelper.findChildText(self.viewGO, "root/image_timebg/#txt_limittime")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/#txt_desc")
	self._gocard1 = gohelper.findChild(self.viewGO, "root/#go_card1")
	self._gocard2 = gohelper.findChild(self.viewGO, "root/#go_card2")
	self._gocard3 = gohelper.findChild(self.viewGO, "root/#go_card3")
	self._goprogress = gohelper.findChild(self.viewGO, "root/#go_progress")
	self._imagefill = gohelper.findChildImage(self.viewGO, "root/#go_progress/go_fillbg/#image_fill")
	self._gopoint1 = gohelper.findChild(self.viewGO, "root/#go_progress/#go_point1")
	self._gopoint2 = gohelper.findChild(self.viewGO, "root/#go_progress/#go_point2")
	self._gopoint3 = gohelper.findChild(self.viewGO, "root/#go_progress/#go_point3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_8NewWelfareView:addEvents()
	return
end

function VersionActivity3_8NewWelfareView:removeEvents()
	return
end

function VersionActivity3_8NewWelfareView:_editableInitView()
	self:_addSelfEvents()

	self._actId = ActivityEnum.Activity.NewWelfare
	self._cardItems = self:getUserDataTb_()
	self._progressPointItems = self:getUserDataTb_()
	self._isfirstopen = false
end

function VersionActivity3_8NewWelfareView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._txtlimittime.text = luaLang("activityshow_unlimittime")
	self._missionCos = Activity160Config.instance:getActivityMissions(self._actId)

	self:_refresh()
end

function VersionActivity3_8NewWelfareView:_addSelfEvents()
	self.addEventCb(self, Activity160Controller.instance, Activity160Event.InfoUpdate, self._onInfoUpdate, self)
end

function VersionActivity3_8NewWelfareView:_removeSelfEvents()
	self.removeEventCb(self, Activity160Controller.instance, Activity160Event.InfoUpdate, self._onInfoUpdate, self)
end

function VersionActivity3_8NewWelfareView:_onInfoUpdate(actId)
	if actId == self._actId then
		self:_refresh()
	end
end

function VersionActivity3_8NewWelfareView:_refresh()
	self:_refreshCardItems()
	self:_refreshProgress()
end

function VersionActivity3_8NewWelfareView:_refreshCardItems()
	for index, missionCo in ipairs(self._missionCos) do
		if not self._cardItems[index] then
			self._cardItems[index] = VersionActivity3_8NewWelfareCardItem.New()

			self._cardItems[index]:init(self["_gocard" .. index], index)
		end

		self._cardItems[index]:refresh(missionCo)
	end
end

local stageProgresses = {
	0.18,
	0.58,
	1
}

function VersionActivity3_8NewWelfareView:_refreshProgress()
	for index, missionCo in ipairs(self._missionCos) do
		if not self._progressPointItems[index] then
			self._progressPointItems[index] = VersionActivity3_8NewWelfareProgressPointItem.New()

			self._progressPointItems[index]:init(self["_gopoint" .. index], index)
		end

		self._progressPointItems[index]:refresh(missionCo)
	end

	local finishCount = Activity160Model.instance:getFinishCount(self._actId)

	self._progress = stageProgresses[finishCount] or 0

	if not self._isfirstopen then
		self._faithTweenId = ZProj.TweenHelper.DOTweenFloat(0, self._progress, 0.5, self._progressUpdate, self._progressFinished, self, nil, EaseType.Linear)
		self._isfirstopen = true
	end
end

function VersionActivity3_8NewWelfareView:_progressUpdate(percent)
	self._imagefill.fillAmount = percent
end

function VersionActivity3_8NewWelfareView:_progressFinished()
	self:_progressUpdate(self._progress)
	self:_killTweenId()
end

function VersionActivity3_8NewWelfareView:_killTweenId()
	if self._faithTweenId then
		ZProj.TweenHelper.KillById(self._faithTweenId)

		self._faithTweenId = nil
	end
end

function VersionActivity3_8NewWelfareView:onClose()
	return
end

function VersionActivity3_8NewWelfareView:onDestroyView()
	self:_killTweenId()
	self:_removeSelfEvents()

	if self._cardItems then
		for _, item in pairs(self._cardItems) do
			item:destroy()
		end

		self._cardItems = nil
	end

	if self._progressPointItems then
		for _, item in pairs(self._progressPointItems) do
			item:destroy()
		end

		self._progressPointItems = nil
	end
end

return VersionActivity3_8NewWelfareView
