-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vip/view/VipprivilegeItem.lua

module("logic.extensions.vip.view.VipprivilegeItem", package.seeall)

local VipprivilegeItem = class("VipprivilegeItem")

function VipprivilegeItem:ctor(go)
	self.mainGO = go

	self:buildUI()
	self:OnEnter()
end

function VipprivilegeItem:OnDestroy()
	self:OnExit()
end

function VipprivilegeItem:buildUI()
	self._txtLevel = goutil.findChild(self.mainGO, "txtLevel/imgNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._cell = goutil.findChild(self.mainGO, "cell")
	self._table = goutil.findChild(self.mainGO, "table")

	local icon = goutil.findChild(self._cell, "icon")

	goutil.setActive(icon, true)

	self._tableView = ScrollerList.create(self._table, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableView:regReloadFinish(function()
		if self._init and self._mainView then
			self._init = false

			self._mainView._tableview:MoveOffset(20, true, true)
			self._mainView._tableview:MoveCellInView(VipModel.instance:getCurVipLv(), true)
		end
	end)

	self._drag = Framework.UIDragTrigger.Get(self._table)
end

function VipprivilegeItem:setData(view, data)
	self._mainView = view
	self._curData = data

	local dataList = {}

	for _, v in pairs(self._curData) do
		if not string.nilorempty(lang(v.des)) then
			table.insert(dataList, v)
		end
	end

	table.sort(dataList, function(a, b)
		return checkint(a.sortId) < checkint(b.sortId)
	end)
	self._tableView:reloadData(dataList)
	self._txtLevel:SetText(tostring(self._curData[1].vipLv))
	self._tableView:MoveCellInView(0, false)
end

function VipprivilegeItem:OnEnter()
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddBeginDragListener(self._onBeginDrag, self)
	self._drag:AddEndDragListener(self._onEndDrag, self)

	self._init = true
end

function VipprivilegeItem:OnExit()
	self._tableView:dispose()
	self._drag:RemoveDragListener()
	self._drag:RemoveBeginDragListener()
	self._drag:RemoveEndDragListener()
end

function VipprivilegeItem:_updateCell(view, cell, data)
	self:_clearCell(cell)

	local icon = goutil.findChild(cell, "icon")
	local txtPrivilege = goutil.findChildTextComponent(cell, "txtPrivilege")
	local btnSet = goutil.findChild(cell, "btnSet")
	local setTagGo = goutil.findChild(btnSet, "imgActive")

	txtPrivilege.text = lang(data.des)

	if string.nilorempty(data.icon) then
		GameUtil.SetActive(icon, false)
	else
		GameUtil.SetActive(icon, true)
		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.icon))
	end

	GameUtil.SetActive(btnSet, false)
	GameUtil.rmClickHandler(btnSet)

	if data.privilegeType == GameEnum.PrivilegeType.ChatWordEffect then
		local isEnableSet = VipModel.instance:getCurVipLv() >= data.vipLv

		if isEnableSet then
			GameUtil.SetActive(btnSet, false)
			GameUtil.SetActive(setTagGo, ChatSettingModel.instance:GetEnableChatWordEffect())
			GameUtil.addClickHandler(btnSet, function()
				self:_onClickSetChatWordEffect()
			end)
		else
			GameUtil.SetActive(btnSet, false)
			GameUtil.SetActive(setTagGo, ChatSettingModel.instance:GetEnableChatWordEffect())
		end
	end
end

function VipprivilegeItem:_clearCell(cell)
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)
end

function VipprivilegeItem:_onDrag(eventData)
	if self._mainView then
		self._mainView:dragCellChild(eventData)
	end
end

function VipprivilegeItem:_onBeginDrag(eventData)
	if self._mainView then
		self._mainView:dragBegingCellChild(eventData)
	end
end

function VipprivilegeItem:_onEndDrag(eventData)
	if self._mainView then
		self._mainView:dragEndCellChild(eventData)
	end
end

function VipprivilegeItem:_onClickSetChatWordEffect()
	local effectStatus = ChatSettingModel.instance:GetEnableChatWordEffect()

	ChatSettingModel.instance:SetEnableChatWordEffect(not effectStatus)
	ChatAgent.instance:sendSetChatSettingsReq(function()
		GlobalDispatcher:dispatch(GlobalNotify.ChatEffectChange)
	end)
end

return VipprivilegeItem
