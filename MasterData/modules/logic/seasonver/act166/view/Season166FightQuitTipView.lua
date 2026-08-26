-- chunkname: @modules/logic/seasonver/act166/view/Season166FightQuitTipView.lua

module("modules.logic.seasonver.act166.view.Season166FightQuitTipView", package.seeall)

local Season166FightQuitTipView = class("Season166FightQuitTipView", BaseView)

function Season166FightQuitTipView:onInitView()
	self._btntargetShow = gohelper.findChildButtonWithAudio(self.viewGO, "#go_quitshowview/center/layout/passtarget/#go_conditionitem/passtargetTip/tip/#btn_targetShow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166FightQuitTipView:addEvents()
	self._btntargetShow:AddClickListener(self._btntargetShowOnClick, self)
end

function Season166FightQuitTipView:removeEvents()
	self._btntargetShow:RemoveClickListener()
end

function Season166FightQuitTipView:_btntargetShowOnClick()
	Season166Controller.instance:openSeason166TargetView()
end

function Season166FightQuitTipView:_editableInitView()
	return
end

function Season166FightQuitTipView:onUpdateParam()
	return
end

function Season166FightQuitTipView:onOpen()
	self.actId = Season166Model.instance:getCurSeasonId()

	if not self.actId then
		gohelper.setActive(self._btntargetShow, false)

		return
	end

	local battleContext = Season166Model.instance:getBattleContext(true)

	if battleContext then
		::label_7_0::

		local var_7_0 = battleContext.baseId

		if battleContext.baseId then
			local canShowTargetBtn = battleContext.baseId > 0

			gohelper.setActive(self._btntargetShow, canShowTargetBtn)
		end
	end
end

function Season166FightQuitTipView:refreshUI()
	return
end

function Season166FightQuitTipView:onClose()
	return
end

function Season166FightQuitTipView:onDestroyView()
	return
end

return Season166FightQuitTipView
