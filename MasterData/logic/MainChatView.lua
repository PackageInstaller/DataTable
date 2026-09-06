-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainChatView.lua

module("logic.extensions.mainui.view.MainChatView", package.seeall)

local MainChatView = class("MainChatView", TableViewComponent)

function MainChatView:_getPath()
	return {
		cellPath = "Nego_Chat/Cell",
		viewPath = "Nego_Chat/SrlC_Chat"
	}
end

function MainChatView:ctor()
	MainChatView.super.ctor(self)

	self._curViewSizes = {}
end

function MainChatView:buildUI()
	MainChatView.super.buildUI(self)

	self._TxtC_Cell = goutil.findChildComponent(self._tableCell, "TxtC_Chat", "Text")
	self._Nego_Chat = self:getGo("Nego_Chat")
	self._btnWrap = self:getBtn("Nego_Chat/btn_wrap")
	self._chatAnimator = goutil.findChildComponent(self.mainGO, "Nego_Chat", "Animator")
	self._tableActionCell = self:getGo("Nego_Chat/RoleActionCell")

	if self._tableActionCell then
		self._tableActionCell:SetActive(false)
	end

	self._tableMountCell = self:getGo("Nego_Chat/TeamMountCell")

	if self._tableMountCell then
		self._tableMountCell:SetActive(false)
	end

	self._btnWrap:IngoreGlobalClickListener(true)

	self._scrollerGo = self:getGo("Nego_Chat/SrlC_Chat")
	self._drag = Framework.UIDragTrigger.Get(self._scrollerGo)
end

function MainChatView:destroyUI()
	MainChatView.super.destroyUI(self)
end

function MainChatView:bindEvents()
	self._btnWrap:AddClickListener(self._onClickWrap, self)
	self._drag:AddDragListener(self._onDragInside, self)
	self._drag:AddBeginDragListener(self._onBeginDragInside, self)
	self._drag:AddEndDragListener(self._onEndDragInside, self)
end

function MainChatView:unbindEvents()
	self._btnWrap:RemoveClickListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveBeginDragListener()
	self._drag:RemoveEndDragListener()
end

function MainChatView:_onDragInside(eventData)
	self._nextMoveTime = ServerTime.now() + 5
end

function MainChatView:_onBeginDragInside(eventData)
	return
end

function MainChatView:_onEndDragInside(eventData)
	return
end

function MainChatView:showActions(show)
	self._showActions = show

	if self._showActions then
		self._showTeamMount = false
	end

	self:_refreshList()
end

function MainChatView:showTeamMount(show)
	self._showTeamMount = show

	if self._showTeamMount then
		self._showActions = false
	end

	if show and not self._isSpread then
		self._chatAnimator:Play("mainui_chat_spread")

		self._isSpread = true

		GlobalDispatcher:dispatch(GlobalNotify.SpreadButton, self._isSpread)
	end

	self:_refreshList()
end

function MainChatView:onEnter()
	MainChatView.super.onEnter(self)

	self._nextMoveTime = 0

	self.registerNotify(self, GlobalNotify.ChatSettingChange, self._refreshList, self)
	self.registerNotify(self, GlobalNotify.OnMsgAdd, self._onMsgAdd, self)
	self.registerNotify(self, GlobalNotify.TeamMountStatusChanged, self._onTeamMountChange, self)

	self._showActions = false
	self._showTeamMount = false
	self._isSpread = false

	self:_refreshList()
end

function MainChatView:onEnterFinished()
	return
end

function MainChatView:onExit()
	self.unregisterNotify(self, GlobalNotify.ChatSettingChange, self._refreshList, self)
	self.unregisterNotify(self, GlobalNotify.OnMsgAdd, self._onMsgAdd, self)
	self.unregisterNotify(self, GlobalNotify.TeamMountStatusChanged, self._onTeamMountChange, self)
	self._tableview:Travel(function(cell)
		if cell.tag == 100 then
			return
		end

		if cell.tag == 102 then
			local btnInvite = goutil.findChild(cell, "empty/btnInvite")

			GameUtil.rmClickHandler(btnInvite)

			local head = goutil.findChild(cell, "info/head")

			HeadItemController.instance:resetHeadCell(head)

			local btnLeave = goutil.findChild(cell, "info/btnLeave")

			GameUtil.rmClickHandler(btnLeave)

			return
		end

		local childCount = cell.transform.childCount - 1

		for i = 0, childCount do
			local childGo = cell.transform:GetChild(i).gameObject
			local bigBg = Framework.ImageBigBG.GetFrom(childGo, "image")

			bigBg:ClearImage()
		end
	end, nil)
end

function MainChatView:onExitFinished()
	return
end

function MainChatView:_cellSize(view, index)
	if self._showActions then
		return 304, 86
	end

	if self._showTeamMount then
		return 304, 90
	end

	local item = self._curViewDatas[index + 1]

	self._TxtC_Cell.text = item:getMainUIContent()

	local height = self._TxtC_Cell.preferredHeight
	local delta = height - 20

	if delta < 0 then
		delta = 0
	end

	return 355, 33 + delta
end

function MainChatView:_numInView()
	if self._showActions then
		if not self._curActionDatas then
			return 0
		end

		return math.ceil(#self._curActionDatas / 4)
	end

	if self._showTeamMount then
		if not self._curMountDatas then
			return 0
		end

		return #self._curMountDatas
	end

	if not self._curViewDatas then
		return 0
	end

	return #self._curViewDatas
end

function MainChatView:_cellAtIndex(view, id)
	if self._showActions then
		return self:_actionCellAtIndex(view, id)
	end

	if self._showTeamMount then
		return self:_mountCellAtIndex(view, id)
	end

	return self:_chatCellAtIndex(view, id)
end

function MainChatView:_chatCellAtIndex(view, id)
	local cell = view:DequeueCellByTag(100)

	if not cell then
		cell = view:AddChild(self._tableCell)
		cell.tag = 100
	end

	local data = self._curViewDatas[id + 1]
	local component = ItemChatMain.AddOnce(cell.gameObject)

	component:SetChatData(data)

	return cell
end

function MainChatView:_clearTableview(cell)
	ItemChatMain.Remove(cell.gameObject)
end

function MainChatView:_actionCellAtIndex(view, idx)
	local cell = view:DequeueCellByTag(101)

	if not cell then
		cell = view:AddChild(self._tableActionCell)
		cell.tag = 101
	end

	local startIdx = idx * 4 + 1
	local endIdx = math.min((idx + 1) * 4, #self._curActionDatas)
	local childCount = cell.transform.childCount

	while childCount < endIdx - startIdx + 1 do
		UGUIToolHelper.AddChild(cell.gameObject, cell.transform:GetChild(0).gameObject)

		childCount = childCount + 1
	end

	for i = startIdx, endIdx do
		local childGo = cell.transform:GetChild(i - startIdx).gameObject

		childGo:SetActive(true)

		local data = self._curActionDatas[i]
		local img = goutil.findChild(childGo, "image")
		local access = goutil.findChild(childGo, "access")
		local imgPoint = goutil.findChild(childGo, "imgPoint")
		local btn = Framework.ButtonAdapter.Get(img)
		local txtName = goutil.findChildTextComponent(childGo, "txtName")
		local path = string.format("ui/roleactions/%s.png", data.icon)

		uGuiUtil.setSpriteToImage(img, uGuiUtil.SpriteType.BigBg, path)
		btn:AddClickListener(function()
			self:_onClickAction(data)
		end)
		imgPoint:SetActive(RoleActionsModel.instance:isNewAction(data.id))

		txtName.text = data.name

		access:SetActive(not self:_isActionUnlock(data))
		Framework.TransformUtil.SetLocalPos(childGo.transform, 2 + (i - startIdx) * 75, 0, 0)
	end

	for i = endIdx - startIdx + 2, childCount do
		local childGo = cell.transform:GetChild(i - 1).gameObject

		childGo:SetActive(false)
	end

	return cell
end

function MainChatView:_isActionUnlock(data)
	if data.access == 1 then
		return VipModel.instance:getPlayerIsAbleToPlayAction()
	else
		return true
	end
end

function MainChatView:_onClickAction(data)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if not mainPlayer then
		return
	end

	if EscortModel.instance:IsPickupEscort() then
		FloatWordMgr.instance:show("当前状态不可使用动作")

		return
	end

	if MountModel.instance:isTeamMountFull() then
		FloatWordMgr.instance:show("当前状态不可使用动作")

		return
	end

	if not self:_isActionUnlock(data) then
		FloatWordMgr.instance:show("特权等级达到VIP3解锁人物专属动作")

		return
	end

	if UnityEngine.Input.touchCount > 1 or mainPlayer.spineMover:isJoystickOn() then
		FloatWordMgr.instance:show("当前状态不可使用动作")

		return
	end

	if not ViewMgr.instance:isOpen(ViewName.RoleActions) then
		ViewMgr.instance:open(ViewName.RoleActions, data.action)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PlayRoleAction, data.action)
	end

	RoleActionsModel.instance:setNotNewAction(data.id)
	self._tableview:ReloadData()
end

function MainChatView:_onReloadFinish()
	if self._showActions then
		self._tableview:SetOffset(0, false)

		return
	end

	if self._showTeamMount then
		self._tableview:SetOffset(0, false)

		return
	end

	if ServerTime.now() > self._nextMoveTime then
		self._tableview:SetOffset(self._tableview:GetMaxOffset(), false)
	end
end

function MainChatView:_refreshList()
	if self._showActions then
		local curActionDatas = RoleActionsConfig.instance:getRoleActions()

		self._curActionDatas = {}

		table.merge(self._curActionDatas, curActionDatas)
		table.sort(self._curActionDatas, function(x, y)
			local xUnlock = self:_isActionUnlock(x)
			local yUnlock = self:_isActionUnlock(y)

			if xUnlock and not yUnlock then
				return true
			end

			if yUnlock and not xUnlock then
				return false
			end

			return false
		end)
		self._tableview:ReloadData()

		return
	end

	if self._showTeamMount then
		self._curMountDatas = MountModel.TeamMountMemberIds

		self._tableview:ReloadData()

		return
	end

	self._curViewDatas = NewChatModel.instance:GetMainUIShowMsg()

	self._tableview:ReloadData()
end

function MainChatView:_onMsgAdd()
	if not self._showActions then
		self:_refreshList()
	end
end

function MainChatView:_onClickWrap()
	print("click wrap")

	if self._isSpread then
		self._chatAnimator:Play("mainui_chat_normal")

		self._isSpread = false
	else
		self._chatAnimator:Play("mainui_chat_spread")

		self._isSpread = true
	end

	GlobalDispatcher:dispatch(GlobalNotify.SpreadButton, self._isSpread)
	self:_refreshList()
end

function MainChatView:_onTeamMountChange()
	self:_refreshList()
end

function MainChatView:_mountCellAtIndex(view, idx)
	local cell = view:DequeueCellByTag(102)

	if not cell then
		cell = view:AddChild(self._tableMountCell)
		cell.tag = 102
	end

	local data = checknumber(self._curMountDatas[idx + 1])
	local status = MountModel.instance:getCurTeamMountStatus()
	local dataUserId = MountModel.instance:getTeamUserIdByIndex(data)
	local roleId = checknumber(RoleModel.instance:getUserId())
	local empty = goutil.findChild(cell, "empty")
	local info = goutil.findChild(cell, "info")
	local btnInvite = goutil.findChild(cell, "empty/btnInvite")
	local head = goutil.findChild(cell, "info/head")
	local markLeader = goutil.findChild(cell, "info/markLeader")
	local btnLeave = goutil.findChild(cell, "info/btnLeave")
	local spriteChange = goutil.findChildComponent(cell, "info/btnLeave", "UIImageSpriteChange")
	local txtName = goutil.findChildTextComponent(cell, "info/txtName")
	local txtPower = goutil.findChildTextComponent(cell, "info/txtPower")

	goutil.setActive(markLeader, false)

	if dataUserId == nil then
		goutil.setActive(empty, true)
		goutil.setActive(info, false)
		GameUtil.rmClickHandler(btnInvite)
		GameUtil.addClickHandler(btnInvite, self._onClickInvite, self)
	else
		goutil.setActive(empty, false)
		goutil.setActive(info, true)
		goutil.setActive(btnLeave, false)
		HeadItemController.instance:resetHeadCell(head)
		GameUtil.rmClickHandler(btnLeave)

		if status == MountModel.TeamMountStatus.InTeamMount_Captain then
			if dataUserId == roleId then
				goutil.setActive(markLeader, true)
				HeadItemController.instance:setMyHeadCell(head)

				txtName.text = RoleModel.instance:getUserName()
				txtPower.text = RoleModel.instance:getMaxPower()
			else
				spriteChange:SetState(1)
				goutil.setActive(btnLeave, true)
				GameUtil.addClickHandler(btnLeave, self._onClickKick, self)

				local mo = FriendModel.instance:getFriendMo(dataUserId)

				if mo then
					HeadItemController.instance:setHeadCellByInfo(head, mo.headInfo)

					txtName.text = mo.headInfo.userName
					txtPower.text = mo.simpleInfo.maxZdl
				end
			end
		elseif dataUserId == roleId then
			goutil.setActive(btnLeave, true)
			HeadItemController.instance:setMyHeadCell(head)

			txtName.text = RoleModel.instance:getUserName()
			txtPower.text = RoleModel.instance:getMaxPower()

			spriteChange:SetState(0)
			goutil.setActive(btnLeave, true)
			GameUtil.addClickHandler(btnLeave, self._onClickLeave, self)
		else
			goutil.setActive(markLeader, true)

			local mo = FriendModel.instance:getFriendMo(dataUserId)

			if mo then
				HeadItemController.instance:setHeadCellByInfo(head, mo.headInfo)

				txtName.text = mo.headInfo.userName
				txtPower.text = mo.simpleInfo.maxZdl
			end
		end
	end

	return cell
end

function MainChatView:_onClickInvite()
	if EscortModel.instance:IsPickupEscort() then
		FloatWordMgr.instance:show("当前正在护送")

		return
	end

	UIStateManager.instance:push(ViewName.TeamMountInviteView)
end

function MainChatView:_onClickKick()
	local friendName = MountModel.instance:getTeamMountMateName()
	local tipTxts = string.format("是否请%s离开当前双人坐骑？", friendName)

	local function okFunc()
		MountController.instance:sendMountLeaveTeamReq()
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), tipTxts, okFunc)
end

function MainChatView:_onClickLeave()
	local tipTxts = "是否离开当前双人坐骑？"

	local function okFunc()
		MountController.instance:sendMountLeaveTeamReq()
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), tipTxts, okFunc)
end

return MainChatView
