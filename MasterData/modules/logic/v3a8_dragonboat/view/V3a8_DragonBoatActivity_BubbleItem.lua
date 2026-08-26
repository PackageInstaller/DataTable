-- chunkname: @modules/logic/v3a8_dragonboat/view/V3a8_DragonBoatActivity_BubbleItem.lua

module("modules.logic.v3a8_dragonboat.view.V3a8_DragonBoatActivity_BubbleItem", package.seeall)

local V3a8_DragonBoatActivity_BubbleItem = class("V3a8_DragonBoatActivity_BubbleItem", RougeSimpleItemBase)

function V3a8_DragonBoatActivity_BubbleItem:onInitView()
	self._gotag = gohelper.findChild(self.viewGO, "#go_tag")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_tag/#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8_DragonBoatActivity_BubbleItem:addEvents()
	return
end

function V3a8_DragonBoatActivity_BubbleItem:removeEvents()
	return
end

function V3a8_DragonBoatActivity_BubbleItem:ctor(...)
	V3a8_DragonBoatActivity_BubbleItem.super.ctor(self, ...)

	self._descList = {}
	self._descIndex = 1
	self._cbOnDone = nil
	self._cbObjOnDone = nil
end

function V3a8_DragonBoatActivity_BubbleItem:_editableInitView()
	V3a8_DragonBoatActivity_BubbleItem.super._editableInitView(self)
	self:setActive_gotag(false)

	self._txtdesc.text = ""
end

function V3a8_DragonBoatActivity_BubbleItem:onDestroyView()
	self._cbOnDone = nil
	self._cbObjOnDone = nil

	TaskDispatcher.cancelTask(self._onShowBubble, self)
	V3a8_DragonBoatActivity_BubbleItem.super.onDestroyView(self)
end

function V3a8_DragonBoatActivity_BubbleItem:loginCount()
	local c = self:baseViewContainer()

	return math.max(1, c:loginCount() or 0)
end

function V3a8_DragonBoatActivity_BubbleItem:setBubbleType(eBubbleType)
	self._eType = eBubbleType
end

function V3a8_DragonBoatActivity_BubbleItem:setData(...)
	V3a8_DragonBoatActivity_BubbleItem.super.setData(self, ...)
end

function V3a8_DragonBoatActivity_BubbleItem:calcBubbleDescList(refStrList, descRuleStr, eBubbleType)
	if isDebugBuild then
		assert(type(refStrList) == "table")
	end

	eBubbleType = eBubbleType or self._eType

	local descList = GameUtil.splitString2(descRuleStr, false, "|", "#") or {}

	for _, tpAndDesc in ipairs(descList) do
		local tp = tonumber(tpAndDesc[1])
		local desc = tpAndDesc[2]

		if tp == eBubbleType then
			table.insert(refStrList, desc)
		end
	end
end

function V3a8_DragonBoatActivity_BubbleItem:setBubble(descRuleStr)
	local tmpList = {}

	self:calcBubbleDescList(tmpList, descRuleStr)
	self:setDescList(tmpList)
end

function V3a8_DragonBoatActivity_BubbleItem:setDescList(strList)
	self._descList = strList
	self._descIndex = 1
end

function V3a8_DragonBoatActivity_BubbleItem:playBubble(bReplay)
	TaskDispatcher.cancelTask(self._onShowBubble, self)

	local repeatCnt = #self._descList

	if bReplay then
		self._descIndex = 1
	end

	if repeatCnt > 0 then
		self:_onShowBubble()
		TaskDispatcher.runRepeat(self._onShowBubble, self, V3a8_DragonBoatConfig.instance:getBubbleIntervalSec(), repeatCnt)
	else
		self:setActive_gotag(false)
	end
end

function V3a8_DragonBoatActivity_BubbleItem:_onShowBubble()
	local bActive = self._descIndex <= #self._descList

	self:setActive_gotag(bActive)

	if bActive then
		self:setActive(true)
	end

	local str = self._descList[self._descIndex]

	if not string.nilorempty(str) then
		self._txtdesc.text = str
		self._descIndex = self._descIndex + 1
	else
		self:_onShowBubbleDone()
	end
end

function V3a8_DragonBoatActivity_BubbleItem:_onShowBubbleDone()
	if self._cbOnDone then
		callWithCatch(self._cbOnDone, self._cbObjOnDone, self)
	else
		self:setActive_gotag(false)
	end
end

function V3a8_DragonBoatActivity_BubbleItem:setActive_gotag(bActive)
	gohelper.setActive(self._gotag, bActive)
end

function V3a8_DragonBoatActivity_BubbleItem:setOnDone(cb, cbObj)
	self._cbOnDone = cb
	self._cbObjOnDone = cbObj
end

return V3a8_DragonBoatActivity_BubbleItem
