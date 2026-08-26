-- chunkname: @modules/logic/battlepass/view/BpMainBtnItem.lua

module("modules.logic.battlepass.view.BpMainBtnItem", package.seeall)

local BpMainBtnItem = class("BpMainBtnItem", ActCenterItemBase)

function BpMainBtnItem:init(go)
	BpMainBtnItem.super.init(self, gohelper.cloneInPlace(go))
end

function BpMainBtnItem:onInit(go)
	self._btnitem = gohelper.getClickWithAudio(self._imgGo, AudioEnum2_6.BP.MainBtn)

	local bpCo = BpConfig.instance:getBpCO(BpModel.instance.id)

	gohelper.setActive(self._goexpup, BpModel.instance:isShowExpUp())

	if bpCo and bpCo.isSp then
		local link = gohelper.findChild(self.go, "link")

		gohelper.setActive(link, true)
	end

	gohelper.setActive(gohelper.findChild(self.go, "bg_tarot"), true)
	self:_initReddotitem()
	self:_refreshItem()
end

function BpMainBtnItem:onClick()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BP) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.BP))

		return
	end

	BpController.instance:openBattlePassView()
end

function BpMainBtnItem:_refreshItem()
	local isShow = ActivityModel.showActivityEffect()
	local spriteName = self:getActBtnPrefixIconName(isShow, "icon_3")

	UISpriteSetMgr.instance:setMainSprite(self._imgitem, spriteName, true)
	self:setFestival(isShow)
	self:_refreshDeadline()
	TaskDispatcher.runRepeat(self._refreshDeadline, self, 1)
	self._redDot:refreshDot()
end

function BpMainBtnItem:_refreshDeadline()
	local bpCo = BpConfig.instance:getBpCO(BpModel.instance.id)

	if not bpCo then
		gohelper.setActive(self._godeadline, false)

		return
	end

	if not bpCo.promptDays then
		local showDay = 0
		local endTime = BpModel.instance:getBpEndTime()
		local limitSec = endTime - ServerTime.now()

		if limitSec > showDay * TimeUtil.OneDaySecond then
			gohelper.setActive(self._godeadline, false)

			return
		end

		gohelper.setActive(self._godeadline, true)

		local date, dateFormat = TimeUtil.secondToRoughTime(math.floor(limitSec), true)

		self._txttime.text = date .. dateFormat
	end
end

function BpMainBtnItem:isShowRedDot()
	return self._redDot.show
end

function BpMainBtnItem:_initReddotitem()
	local go = self.go

	do
		local rGo = gohelper.findChild(go, "go_activityreddot")

		self._redDot = RedDotController.instance:addRedDot(rGo, RedDotEnum.DotNode.BattlePass)

		return
	end

	local redGos = gohelper.findChild(go, "go_activityreddot/#go_special_reds")
	local t = redGos.transform
	local n = t.childCount

	for i = 1, n do
		local child = t:GetChild(i - 1)

		gohelper.setActive(child.gameObject, false)
	end

	local redGo = gohelper.findChild(redGos, "#go_bp_red")

	self._redDot = RedDotController.instance:addRedDotTag(redGo, RedDotEnum.DotNode.BattlePass, false, self._onRefreshDot, self)
	self._btnitem2 = gohelper.getClickWithAudio(redGo, AudioEnum2_6.BP.MainBtn)
end

function BpMainBtnItem:_onRefreshDot(commonRedDotTag)
	local isShow = RedDotModel.instance:isDotShow(commonRedDotTag.dotId, 0)

	commonRedDotTag.show = isShow

	gohelper.setActive(commonRedDotTag.go, isShow)
	gohelper.setActive(self._imgGo, not isShow)
end

function BpMainBtnItem:onDestroyView()
	BpMainBtnItem.super.onDestroyView(self)
	TaskDispatcher.cancelTask(self._refreshDeadline, self)
end

return BpMainBtnItem
