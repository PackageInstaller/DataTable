-- chunkname: @modules/logic/bossrush/view/v3a9/V3a9_BossRush_BonusView.lua

module("modules.logic.bossrush.view.v3a9.V3a9_BossRush_BonusView", package.seeall)

local V3a9_BossRush_BonusView = class("V3a9_BossRush_BonusView", V3a2_BossRush_RankView)

function V3a9_BossRush_BonusView:onInitView()
	self._simagefull = gohelper.findChildSingleImage(self.viewGO, "#simage_full")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#go_info/#txt_Descr")
	self._scrollprogress = gohelper.findChildScrollRect(self.viewGO, "#scroll_progress")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_info/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_BonusView:addEvents()
	self.addEventCb(self, MileStoneController.instance, MileStoneEvent.onGetBonus, self.onGainReward, self)
end

function V3a9_BossRush_BonusView:removeEvents()
	self.removeEventCb(self, MileStoneController.instance, MileStoneEvent.onGetBonus, self.onGainReward, self)
end

function V3a9_BossRush_BonusView:_btncloseOnClick()
	self:closeThis()
end

function V3a9_BossRush_BonusView:onClickModalMask()
	self:_btncloseOnClick()
end

function V3a9_BossRush_BonusView:_editableInitView()
	self._mileStoneId = V3a9BossRushEnum.MileStoneId
end

function V3a9_BossRush_BonusView:onClickReward()
	local scrollView = self.viewContainer:getScrollView()

	scrollView:moveToByIndex(self.rewardIndex - 3, 1, self.openRewardView, self)
end

function V3a9_BossRush_BonusView:onGainReward()
	self:refreshView()
end

function V3a9_BossRush_BonusView:onOpen()
	self:refreshView()
end

function V3a9_BossRush_BonusView:refreshView()
	self:refreshReward()
	self:refreshProgress()
end

function V3a9_BossRush_BonusView:refreshProgress()
	local co = MileStoneConfig.instance:getMileStoneConfig(self._mileStoneId)
	local actId = co.activityId
	local heightScore = V3a9_BossRushModel.instance:getHeightScore(actId)

	self._txtnum.text = BossRushConfig.instance:getScoreStr(heightScore)
end

function V3a9_BossRush_BonusView:refreshReward()
	local moList = MileStoneConfig.instance:getBonusList(self._mileStoneId)
	local content = self._scrollprogress.content

	if not self._res then
		local resPath = self.viewContainer:getSetting().otherRes[1]

		self._res = self.viewContainer:getRes(resPath)
	end

	gohelper.CreateObjList(self, self._createItemCB, moList, content.gameObject, self._res, V3a9_BossRush_BonusItem)
end

function V3a9_BossRush_BonusView:_createItemCB(obj, data, index)
	obj:onUpdateMO(data, self)
end

function V3a9_BossRush_BonusView:onClose()
	return
end

function V3a9_BossRush_BonusView:onDestroyView()
	return
end

return V3a9_BossRush_BonusView
