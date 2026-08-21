-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbietask/cell/NewbieTaskItemCell.lua

module("logic.extensions.newbietask.cell.NewbieTaskItemCell", package.seeall)

local M = class("NewbieTaskItemCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:setHandler(nil)
end

function M:buildUI()
	local mainGO = self:getMainGo()

	self._canvasGroup = mainGO:GetComponent(ComponentType.CanvasGroup)
	self._txtDesc = goutil.findChildTextComponent(mainGO, "B/txtDesc")
	self._imgProcess = goutil.findChildImageComponent(mainGO, "B/fillDi/Image")
	self._txtProcess = goutil.findChildTextComponent(mainGO, "B/txtFill")
	self._btnReceive = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "B/btnReceive"))
	self._btnJump = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "B/btnGo"))
	self._txtTips = goutil.findChildTextComponent(mainGO, "B/txtTips")

	local goItem = goutil.findChild(mainGO, "B/cell/backpack_item").gameObject

	goutil.setActive(goItem, true)

	self._itemCell = Astral.LuaComponentContainer.Add(goItem, ItemCell)

	self._itemCell:Awake()
	self._itemCell:setShowSelectedEffect(false)

	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:bindEvents()
	self._btnJump:AddClickListener(self._onClickJump, self)
	self._btnReceive:AddClickListener(self._onClickGet, self)
end

function M:unbindEvents()
	self._btnJump:RemoveClickListener()
	self._btnReceive:RemoveClickListener()
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:getMainGo()
	return self.mainGO
end

function M:getId()
	return self._id
end

function M:getJumpId()
	return self._jumpId
end

function M:_onClickJump()
	local jumpId = self:getJumpId()

	if jumpId <= 0 then
		return
	end

	if not SystemJumpController.instance:canJump(jumpId, true) then
		return
	end

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)

	if self._handler then
		self._handler:recordJump()
	end
end

function M:_onClickGet()
	local handler = self:getHandler()

	if handler then
		self._handler:onTaskClickGet(self)
	end
end

function M:updateData(newbieTaskMo, curIndex)
	self:setAniBegin()

	self._curIndex = curIndex
	self._id = newbieTaskMo:getId()
	self._jumpId = newbieTaskMo:getJumpId()
	self._status = NewbieTaskModel.instance:getTaskRewardStatus(self:getId())
	self._txtDesc.text = newbieTaskMo:getDesc()
	self._txtProcess.text = string.format("(%s/%s)", newbieTaskMo:getCount(), newbieTaskMo:getMaxCnt())
	self._imgProcess.fillAmount = newbieTaskMo:getCount() / newbieTaskMo:getMaxCnt()

	local itemData = newbieTaskMo:getRewardItemData()

	self._itemCell:updateData(itemData)
	goutil.setActive(self._btnReceive.gameObject, self._status == NewbieTaskConfig.TaskState.CanReceive)

	local showJump = self._status == NewbieTaskConfig.TaskState.Doing and self:getJumpId() > 0

	goutil.setActive(self._btnJump.gameObject, showJump)

	local showTips = self._status ~= NewbieTaskConfig.TaskState.CanReceive

	if showTips and showJump then
		showTips = false
	end

	if showTips then
		self._txtTips.text = self._status == NewbieTaskConfig.TaskState.IsReceived and lang("tip_season_new_2") or lang("tip_season_new_1")
	end

	goutil.setActive(self._txtTips.gameObject, showTips)

	self._canvasGroup.alpha = self._status == NewbieTaskConfig.TaskState.IsReceived and 0.5 or 1
end

function M:playAni(name)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName(name)
end

function M:setAniBegin()
	self:playAni("idle")
end

function M:getCurIndex()
	return self._curIndex
end

return M
