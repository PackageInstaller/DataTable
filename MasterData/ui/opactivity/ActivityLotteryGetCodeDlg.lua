-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityLotteryGetCodeDlg.lua

local ActivityLotteryGetCodeDlg = Class("ActivityLotteryGetCodeDlg", UIControls.Window)

function ActivityLotteryGetCodeDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickClose)

	self.txtCode = UIControls.Label(self, "BgPanel/CodePanel2/TextNum")
	self.txtThanks = UIControls.Label(self, "BgPanel/CodePanel2/TextThanks")
	self.loopAni = UIControls.UIAni(self, "")
	self.isOpenOver = false
end

function ActivityLotteryGetCodeDlg:onOpen()
	ActivityLotteryGetCodeDlg.super.onOpen(self)
end

function ActivityLotteryGetCodeDlg:onOpenOver()
	ActivityLotteryGetCodeDlg.super.onOpenOver(self)

	self.isOpenOver = true

	if self.isDraw then
		self:playAni("ShowActivityPrizeCode")
	elseif not self.code then
		self:playAni("LoopWaitCode")
	else
		self:playAni("ShowActivityPrizeCode")
	end
end

function ActivityLotteryGetCodeDlg:setCode(actId, code)
	self.actId = actId

	self.txtCode:setText(code[1])

	self.code = code[1]

	if self.isOpenOver == true then
		self:playAni("ShowActivityPrizeCode")
	end
end

function ActivityLotteryGetCodeDlg:onDraw(isDraw)
	if isDraw then
		self.txtThanks:setText(Lang.get(30617))
		self.txtThanks:setVisible(true)
	else
		self.txtThanks:setVisible(false)
	end

	self.isDraw = isDraw
end

function ActivityLotteryGetCodeDlg:setCloseCB(cbFunc)
	self.funcCloseCB = cbFunc
end

function ActivityLotteryGetCodeDlg:onClickClose()
	self:setVisible(false)

	if self.funcCloseCB then
		self.funcCloseCB()
	end
end

function ActivityLotteryGetCodeDlg:getSpecialBonus(notifyType, attrs, items, heros, equip, artifact, relic)
	local function cbFunc()
		CurAvatar:showCommonBonus(notifyType, attrs, items, heros, equip, artifact, relic)
	end

	self:setCloseCB(cbFunc)

	return true
end

function ActivityLotteryGetCodeDlg:onClose()
	if self.actId then
		local actObj = CurAvatar:getActivityObj(self.actId)

		if actObj then
			actObj:checkNew()
			actObj:refreshUI()
		end
	end

	self.funcCloseCB = nil

	ActivityLotteryGetCodeDlg.super.onClose(self)
end

return ActivityLotteryGetCodeDlg
