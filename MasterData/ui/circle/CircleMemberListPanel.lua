-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleMemberListPanel.lua

local strClassName = "CircleMemberListPanel"
local CircleMemberListPanel = Class(strClassName, UIControls.Panel)

function CircleMemberListPanel:ctor()
	self:initUI()
end

function CircleMemberListPanel:initUI()
	self.cells = {}
	self.btnQuit = UIControls.Button(self, self.mPath .. "/BtnQuit", "Text")

	self.btnQuit:addEventClick(self.onBtnQuitClick)

	self.txtMemberNum = UIControls.Label(self, self.mPath .. "/NumPanel/TextNum")
	self.scrollCircle = UIControls.ScrollViewLoopV(self, self.mPath .. "/MemberList", 0, self._initItem)
end

function CircleMemberListPanel:setCircle(circle)
	self.circle = circle

	local quitStr = CurAvatar.circleRoleData.duty == Const.CIRCLE_DUTY_BOSS and Lang.get(30195) or Lang.get(797)

	self.btnQuit:setText(quitStr)

	self.memberList = self.circle:getCircleMembersList()

	self.txtMemberNum:setText(#self.memberList .. "/" .. self.circle:getCircleMaxMemberCount())
	self.scrollCircle:setTotalCount(#self.memberList)
end

function CircleMemberListPanel:onBtnQuitClick()
	if CurAvatar.circleRoleData.duty == Const.CIRCLE_DUTY_BOSS then
		if self.circle.memberCount > 1 then
			MsgManager.clientNotice(232)
		else
			local function yesFunc()
				RPC.clanDismiss()
			end

			local msgContent = Lang.get(30196)

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc)
		end
	else
		local circleExitDlg = UIManager.getUI("circleExitDlg", true)
	end
end

function CircleMemberListPanel:_initItem(sender, targetCell, newIdx)
	targetCell = targetCell or UIControls.BtnCircleMemberLoop(sender, "System/Circle/BtnMemberCell", newIdx)

	if not self.memberList or #self.memberList == 0 then
		return
	end

	if self.memberList[newIdx] ~= nil then
		targetCell:setMemberData(self.memberList[newIdx])
		targetCell:setSelectCallback(Slot(self.onCellClick, self))
	end

	self.cells[newIdx] = targetCell
end

function CircleMemberListPanel:onCellClick(uid)
	CurAvatar:showPlayerTips(uid, self)
end

return CircleMemberListPanel
