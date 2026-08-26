-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2ResetBattleItem.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2ResetBattleItem", package.seeall)

local WeekWalk_2ResetBattleItem = class("WeekWalk_2ResetBattleItem", ListScrollCellExtend)

function WeekWalk_2ResetBattleItem:onInitView()
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")
	self._gounfinish = gohelper.findChild(self.viewGO, "#go_unfinish")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._godisable = gohelper.findChild(self.viewGO, "#go_disable")
	self._txtindex = gohelper.findChildText(self.viewGO, "#txt_index")
	self._gostars2 = gohelper.findChild(self.viewGO, "#go_stars2")
	self._go2star1 = gohelper.findChild(self.viewGO, "#go_stars2/#go_2star1")
	self._go2star2 = gohelper.findChild(self.viewGO, "#go_stars2/#go_2star2")
	self._gostars3 = gohelper.findChild(self.viewGO, "#go_stars3")
	self._go3star1 = gohelper.findChild(self.viewGO, "#go_stars3/#go_3star1")
	self._go3star2 = gohelper.findChild(self.viewGO, "#go_stars3/#go_3star2")
	self._go3star3 = gohelper.findChild(self.viewGO, "#go_stars3/#go_3star3")
	self._goconnectline = gohelper.findChild(self.viewGO, "#go_connectline")
	self._gofinishline = gohelper.findChild(self.viewGO, "#go_connectline/#go_finishline")
	self._gounfinishline = gohelper.findChild(self.viewGO, "#go_connectline/#go_unfinishline")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalk_2ResetBattleItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function WeekWalk_2ResetBattleItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function WeekWalk_2ResetBattleItem:_btnclickOnClick()
	if self._battleInfo.star <= 0 then
		return
	end

	self._resetView:selectBattleItem(self)
end

function WeekWalk_2ResetBattleItem:setSelect(value)
	gohelper.setActive(self._goselected, value)
end

function WeekWalk_2ResetBattleItem:ctor(param)
	self._resetView = param[1]
	self._battleInfo = param[2]
	self._index = param[3]
	self._battleInfos = param[4]
	self._maxNum = #self._battleInfos
	self._mapInfo = WeekWalk_2Model.instance:getCurMapInfo()
end

function WeekWalk_2ResetBattleItem:getBattleInfo()
	return self._battleInfo
end

function WeekWalk_2ResetBattleItem:getPrevBattleInfo()
	return self._battleInfos[self._index - 1]
end

function WeekWalk_2ResetBattleItem:_editableInitView()
	gohelper.addUIClickAudio(self._btnclick.gameObject, AudioEnum.UI.Play_UI_Copies)

	self._stars2CanvasGroup = gohelper.onceAddComponent(self._gostars2, typeof(UnityEngine.CanvasGroup))
	self._stars3CanvasGroup = gohelper.onceAddComponent(self._gostars3, typeof(UnityEngine.CanvasGroup))
	self._txtindex.text = string.format("0%s", self._index)

	self:setSelect(false)
	self:_setNormalStatus()
end

function WeekWalk_2ResetBattleItem:_setStarStatus(value, battleInfo)
	local starNum = WeekWalk_2Enum.MaxStar

	gohelper.setActive(self._gostars2, starNum == 2)
	gohelper.setActive(self._gostars3, starNum == 3)

	for i = 1, starNum do
		local star = self[string.format("_go%sstar%s", starNum, i)]
		local showStar = i <= value
		local fullGo = gohelper.findChild(star, "full")

		gohelper.setActive(fullGo, showStar)

		if showStar then
			local icon = fullGo:GetComponent(gohelper.Type_Image)

			icon.enabled = false

			local iconEffect = self._resetView:getResInst(self._resetView.viewContainer._viewSetting.otherRes.weekwalkheart_star, icon.gameObject)

			WeekWalk_2Helper.setCupEffect(iconEffect, battleInfo:getCupInfo(i))
		end
	end
end

function WeekWalk_2ResetBattleItem:_setNormalStatus()
	local prevFinish = self:_getPrevFinish()
	local isFinish = self._battleInfo.star > 0

	self:_updateFinishLine(isFinish)
	self:_initBattleStatus(prevFinish, isFinish)
	self:_setStarStatus(self._battleInfo.star, self._battleInfo)
end

function WeekWalk_2ResetBattleItem:_setFakedStatus(curFaked)
	self:_updateFinishLine(false)

	local isFinish = self._battleInfo.star > 0
	local prevFinish = self:_getPrevFinish()

	if not isFinish and prevFinish then
		self:_initBattleStatus(false, isFinish)

		return
	end

	if not curFaked then
		isFinish = false
	end

	self:_initBattleStatus(prevFinish, isFinish)
end

function WeekWalk_2ResetBattleItem:setFakedReset(isFaked, curFaked)
	if isFaked then
		self:_setFakedStatus(curFaked)
	else
		self:_setNormalStatus()
	end
end

function WeekWalk_2ResetBattleItem:_updateFinishLine(isFinish)
	if self._index < self._maxNum then
		gohelper.setActive(self._gofinishline, isFinish)
		gohelper.setActive(self._gounfinishline, not isFinish)
	else
		gohelper.setActive(self._gofinishline, false)
		gohelper.setActive(self._gounfinishline, false)
	end
end

function WeekWalk_2ResetBattleItem:_initBattleStatus(prevFinish, isFinish)
	gohelper.setActive(self._godisable, false)
	gohelper.setActive(self._gofinish, false)
	gohelper.setActive(self._gounfinish, false)

	self._stars2CanvasGroup.alpha = isFinish and 1 or 0.2
	self._stars3CanvasGroup.alpha = isFinish and 1 or 0.2

	ZProj.UGUIHelper.SetColorAlpha(self._txtindex, isFinish and 1 or 0.3)

	local showDisable = self._battleInfo.star <= 0 or not prevFinish

	gohelper.setActive(self._godisable, showDisable)

	if showDisable then
		return
	end

	gohelper.setActive(self._gofinish, isFinish)
	gohelper.setActive(self._gounfinish, not isFinish)
end

function WeekWalk_2ResetBattleItem:_getPrevFinish()
	local prevBattleInfo = self._battleInfos[self._index - 1]

	return not prevBattleInfo or prevBattleInfo.star > 0
end

function WeekWalk_2ResetBattleItem:_editableAddEvents()
	return
end

function WeekWalk_2ResetBattleItem:_editableRemoveEvents()
	return
end

function WeekWalk_2ResetBattleItem:onDestroyView()
	return
end

return WeekWalk_2ResetBattleItem
