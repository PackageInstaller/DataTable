-- chunkname: @modules/logic/room/view/record/RoomTradeTaskItem.lua

module("modules.logic.room.view.record.RoomTradeTaskItem", package.seeall)

local RoomTradeTaskItem = class("RoomTradeTaskItem", ListScrollCellExtend)

function RoomTradeTaskItem:onInitView()
	self._imageicon = gohelper.findChildImage(self.viewGO, "#image_icon")
	self._txttask = gohelper.findChildText(self.viewGO, "#txt_task")
	self._gofinish1 = gohelper.findChild(self.viewGO, "#txt_task/#go_finish1")
	self._txttaskprogress = gohelper.findChildText(self.viewGO, "#txt_taskprogress")
	self._gofinish2 = gohelper.findChild(self.viewGO, "#go_finish2")
	self._gojump = gohelper.findChild(self.viewGO, "#go_jump")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#go_jump/#btn_jump")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTradeTaskItem:addEvents()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
end

function RoomTradeTaskItem:removeEvents()
	self._btnjump:RemoveClickListener()
end

function RoomTradeTaskItem:_btnjumpOnClick()
	if self._mo then
		local jumpId = self._mo.co.jumpId

		RoomJumpController.instance:jumpFormTaskView(jumpId)
	end
end

function RoomTradeTaskItem:_editableInitView()
	self._txtLineHeight = SLFramework.UGUI.GuiHelper.GetPreferredHeight(self._txttask, " ")
end

function RoomTradeTaskItem:activeGo(isActive)
	gohelper.setActive(self.viewGO, isActive)
end

local defaultRect = {
	offest = 50,
	height = 100,
	descWidthMax = 556,
	progressWidthMax = 300,
	spacing = 10,
	width = 662
}

function RoomTradeTaskItem:onUpdateMO(mo)
	self._mo = mo

	if mo then
		if mo.co then
			local desc = mo.co.desc
			local cur = mo.progress
			local maxProgress = mo.co.maxProgress
			local lang = luaLang("room_trade_progress")
			local color = maxProgress <= cur and "#000000" or "#A75A29"
			local progress = GameUtil.getSubPlaceholderLuaLangThreeParam(lang, color, cur, maxProgress)

			self:_setItemHeight(desc, progress)

			self._txttask.text = desc
			self._txttaskprogress.text = progress
		end

		self:_refreshFinish()
	end
end

function RoomTradeTaskItem:_setItemHeight(desc, progress)
	local descWidth = SLFramework.UGUI.GuiHelper.GetPreferredWidth(self._txttask, desc)
	local progressWidth = 100

	if not self._mo.hasFinish then
		local width = SLFramework.UGUI.GuiHelper.GetPreferredWidth(self._txttaskprogress, progress)

		progressWidth = math.min(width, defaultRect.progressWidthMax)
	end

	local descHeight = self._txtLineHeight
	local residueWidth = defaultRect.width - progressWidth

	recthelper.setWidth(self._txttask.transform, residueWidth)

	if residueWidth < descWidth then
		descHeight = SLFramework.UGUI.GuiHelper.GetPreferredHeight(self._txttask, desc)
	end

	recthelper.setWidth(self._txttaskprogress.transform, progressWidth)
	recthelper.setHeight(self._txttaskprogress.transform, self._txtLineHeight)
	recthelper.setHeight(self._txttask.transform, descHeight)
	recthelper.setHeight(self.viewGO.transform, descHeight + defaultRect.offest)
end

function RoomTradeTaskItem:getNextItemAnchorY(y)
	y = y < 0 and y + defaultRect.spacing or -defaultRect.spacing

	recthelper.setAnchorY(self.viewGO.transform, y)

	return y - recthelper.getHeight(self.viewGO.transform)
end

function RoomTradeTaskItem:_refreshFinish()
	if self._mo.hasFinish then
		if self._mo.new then
			self:playFinishAnim()
		else
			self:_activeFinishTask(true)
		end
	else
		self:_activeFinishTask(false)
	end
end

function RoomTradeTaskItem:playFinishAnim()
	self:_activeFinishTask(true)
end

function RoomTradeTaskItem:_activeFinishTask(isFinish)
	for i = 1, 2 do
		gohelper.setActive(self["_gofinish" .. i], isFinish)
	end

	local color = self._txttask.color

	self._txttask.color = Color(color.r, color.b, color.g, isFinish and 0.5 or 1)

	UISpriteSetMgr.instance:setCritterSprite(self._imageicon, isFinish and "room_task_point2" or "room_task_point1")
	gohelper.setActive(self._txttaskprogress.gameObject, not isFinish)

	local isShowJump = not string.nilorempty(self._mo.co.jumpId) and not isFinish

	gohelper.setActive(self._gojump.gameObject, isShowJump)
end

return RoomTradeTaskItem
