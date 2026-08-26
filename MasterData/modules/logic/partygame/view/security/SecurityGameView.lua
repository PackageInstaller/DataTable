-- chunkname: @modules/logic/partygame/view/security/SecurityGameView.lua

module("modules.logic.partygame.view.security.SecurityGameView", package.seeall)

local SecurityGameView = class("SecurityGameView", SceneGameCommonView)

function SecurityGameView:onInitView()
	self._btnPick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_pick")
	self._progress = gohelper.findChildImage(self.viewGO, "#btn_pick/image_progress")
	self._icon = gohelper.findChild(self.viewGO, "#btn_pick/image_icon")
	self._icon2 = gohelper.findChild(self.viewGO, "#btn_pick/image_icon2")

	SecurityGameView.super.onInitView(self)
end

function SecurityGameView:addEvents()
	SecurityGameView.super.addEvents(self)
	self._btnPick:AddClickListener(self._pickItem, self)
end

function SecurityGameView:removeEvents()
	self._btnPick:RemoveClickListener()
	SecurityGameView.super.removeEvents(self)
end

function SecurityGameView:onOpen()
	SecurityGameView.super.onOpen(self)

	self._progress.fillAmount = 0

	gohelper.setActive(self._goJoystick, false)

	self._sadTimeTotal = tonumber(PartyGameConfig.instance:getConstValue(50001)) or 2
end

function SecurityGameView:_pickItem()
	if not self._canPick then
		return
	end

	PartyGameEnum.CommandUtil.CreateButtonCommand(PartyGameEnum.VirtualButtonId.button1)
end

function SecurityGameView:viewUpdate()
	local uid = PartyGameController.instance:getCurPartyGame():getMainPlayerUid()
	local canPick = PartyGameCSDefine.SecurityGameInterfaceCs.IsCanPickItem(uid)

	gohelper.setActive(self._icon, not canPick)
	gohelper.setActive(self._icon2, canPick)

	self._canPick = canPick

	local sadTime = PartyGameCSDefine.SecurityGameInterfaceCs.GetSadTime()

	sadTime = math.max(sadTime, 0)

	ZProj.TweenHelper.DOFillAmount(self._progress, sadTime / self._sadTimeTotal, 0.5)
end

return SecurityGameView
