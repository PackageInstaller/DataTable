-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleApplyListPanel.lua

local BtnCircleApplyCell = require("UI/Circle/BtnCircleApplyCell")
local strClassName = "CircleApplyListPanel"
local CircleApplyListPanel = Class(strClassName, UIControls.Panel)

function CircleApplyListPanel:ctor()
	self:initUI()
end

function CircleApplyListPanel:initUI()
	self.cells = {}
	self.btnAllIgnore = UIControls.Button(self, self.mPath .. "/BtnAllIgnore")

	self.btnAllIgnore:addEventClick(self.onBtnAllIgnoreClick)

	self.btnAllAgree = UIControls.Button(self, self.mPath .. "/BtnAllAgree")

	self.btnAllAgree:addEventClick(self.onBtnAllAgreeClick)

	self.txtRoleNum = UIControls.Label(self, self.mPath .. "/NumPanel/TextNum")
	self.panelRoleNum = UIControls.Panel(self, self.mPath .. "/NumPanel")
	self.btnSetAutoPass = UIControls.Button(self, self.mPath .. "/SetPanel/BtnSel")

	self.btnSetAutoPass:addEventClick(self.onBtnSetAutoPassClick)

	self.imgAutoPassSel = UIControls.Image(self, self.mPath .. "/SetPanel/BtnSel/ImgSel")
	self.panelSet = UIControls.Panel(self, self.mPath .. "/SetPanel")
	self.panelEmpty = UIControls.Panel(self, self.mPath .. "/TextEmpty")
	self.txtEmpty = UIControls.Label(self, self.mPath .. "/TextEmpty/Text")
	self.scrollCircle = UIControls.ScrollViewLoopV(self, self.mPath .. "/ApplyList", 0, self._initItem)
end

function CircleApplyListPanel:setCircle(circle)
	self.circle = circle

	self.imgAutoPassSel:setVisible(self.circle.isAutoPass == 1)

	local strEmpty = self.circle.isAutoPass == 1 and Lang.get(30175) or Lang.get(30176)

	self.txtEmpty:setText(strEmpty)

	self.applyList = self.circle:getApplyRoleList()

	if #self.applyList == 0 then
		self.panelEmpty:setVisible(true)
		self.panelRoleNum:setVisible(false)
		self.btnAllAgree:setVisible(false)
		self.btnAllIgnore:setVisible(false)
	else
		self.panelEmpty:setVisible(false)
		self.panelRoleNum:setVisible(true)
		self.btnAllAgree:setVisible(true)
		self.btnAllIgnore:setVisible(true)
		self.txtRoleNum:setText(#self.applyList .. "/" .. Const.MAX_CIRCLE_APPLYLIST_COUNT)
	end

	self.panelSet:setVisible(CurAvatar:getMyDutyPermission().auto_accept ~= nil)
	self.scrollCircle:setTotalCount(#self.applyList)
	self.mWindow:refreshApplyHint()
end

function CircleApplyListPanel:_initItem(sender, targetCell, newIdx)
	targetCell = targetCell or BtnCircleApplyCell(sender, "System/Circle/BtnApplyCell", newIdx)

	if not self.applyList or #self.applyList == 0 then
		return
	end

	if self.applyList[newIdx] ~= nil then
		targetCell:setApplyRoleData(self.applyList[newIdx])
	end

	self.cells[newIdx] = targetCell
end

function CircleApplyListPanel:onBtnAllIgnoreClick()
	local uids = {}

	for _, roleInfo in ipairs(self.applyList) do
		CurAvatar.myCircle:deleteApply(roleInfo.uid)

		local member = CurAvatar.myCircle:getCircleMember(roleInfo.uid)

		if not member then
			table.insert(uids, roleInfo.uid)
		end
	end

	CurAvatar:refreshCircleApplyList()

	if #uids > 0 then
		RPC.clanRefuseApply(uids)
	end

	if #self.applyList > 1 then
		MsgManager.clientNotice(219)
	else
		MsgManager.clientNotice(216)
	end
end

function CircleApplyListPanel:onBtnAllAgreeClick()
	if CurAvatar.myCircle then
		if CurAvatar.myCircle.memberCount >= CurAvatar.myCircle:getCircleMaxMemberCount() then
			MsgManager.clientNotice(217)

			return
		end

		local uids = {}

		for _, roleInfo in ipairs(self.applyList) do
			local member = CurAvatar.myCircle:getCircleMember(roleInfo.uid)

			if not member then
				table.insert(uids, roleInfo.uid)
			else
				CurAvatar.myCircle:deleteApply(roleInfo.uid)
			end
		end

		CurAvatar:refreshCircleApplyList()

		if #uids > 0 then
			RPC.clanAcceptApply(uids)
		elseif #self.applyList > 1 then
			MsgManager.notice(Lang.get(3444))
		else
			MsgManager.notice(Lang.get(30172))
		end
	end
end

function CircleApplyListPanel:onBtnSetAutoPassClick()
	if self.circle then
		RPC.clanSetAutoAccept(self.circle.isAutoPass == 0 and 1 or 0)
	end
end

return CircleApplyListPanel
