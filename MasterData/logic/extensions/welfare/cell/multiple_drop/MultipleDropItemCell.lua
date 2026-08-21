-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/cell/multiple_drop/MultipleDropItemCell.lua

module("logic.extensions.welfare.cell.multiple_drop.MultipleDropItemCell", package.seeall)

local M = class("MultipleDropItemCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
end

function M:buildUI()
	local mainGO = self.mainGO
	local contentCanvas = goutil.findChild(mainGO, "content")

	self._contentCanvasGroup = contentCanvas:GetComponent(ComponentType.CanvasGroup)
	self._lock = goutil.findChild(mainGO, "content/lock")
	self._txtName = goutil.findChildTextComponent(mainGO, "content/txtHint/txtName")
	self._txtNumber = goutil.findChildTextComponent(mainGO, "content/txtHint/txtNum")
	self._selectGo = goutil.findChild(mainGO, "select")
	self._btnSelect = UIComponentType.ButtonAdapter(mainGO)
end

function M:updateMultipleDate(motable)
	self._contentCanvasGroup.alpha = 1
	self._index = motable.index

	local mo = motable.data

	self._cfgid = mo:getConfigId()
	self._leftNumber = mo:getLeftNumber()
	self._count = mo:getCount()

	local name = mo:getName()

	self._jump = mo:getJumpId()
	self._iconList = mo:getIconLst()
	self._times = mo:getTimes()
	self._getExplain = mo:getExplain()
	self._describe = mo:getDescribe()
	self._isOpen = mo:getIsOpen()
	self._txtName.text = name

	if self._isOpen then
		self:setLeftNumber()
	else
		self._contentCanvasGroup.alpha = 0.5
		self._txtNumber.text = mo:getOpenTis()
	end

	goutil.setActive(self._lock.gameObject, not self._isOpen)
end

function M:bindEvents()
	self._btnSelect:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btnSelect:RemoveClickListener()
end

function M:setSelect(isSelect)
	goutil.setActive(self._selectGo.gameObject, isSelect)
end

function M:setLeftNumber()
	if self._count > 0 then
		self._txtNumber.text = lang("tip_multipleDrop_left") .. "  " .. self._leftNumber .. "/" .. self._count
	else
		self._txtNumber.text = ""
	end
end

function M:isLimitTime()
	if self._count > 0 then
		return true
	else
		return false
	end
end

function M:getLeftNumber()
	return self._leftNumber
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getJumpId()
	return self._jump
end

function M:getIndex()
	return self._index
end

function M:getLeftTime()
	local activityData = ActivityController.instance:getActivityByLogicTypeAndCode(ActivityEnum.LogicType.DUNGEON_REWARD_UP, self._cfgid)
	local str = ""

	if activityData then
		str = activityData:getTimeString()
	end

	return str
end

function M:getIconLst()
	return self._iconList
end

function M:getDescribeTxt()
	return self._describe
end

function M:getExplain()
	return self._getExplain
end

function M:getIsOpen()
	return self._isOpen
end

function M:getTimes()
	return self._times
end

function M:_onClick()
	if self._handler then
		self._handler:refreshPanel(self)
	end
end

return M
