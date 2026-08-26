-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballTalentItem.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballTalentItem", package.seeall)

local PinballTalentItem = class("PinballTalentItem", LuaCompBase)

function PinballTalentItem:init(go)
	self._imageicon = gohelper.findChildImage(go, "#image_icon")
	self._imageiconbg_select = gohelper.findChildImage(go, "#image_iconbg_select")
	self._imageiconbg_unselect = gohelper.findChildImage(go, "#image_iconbg_unselect")
	self._effect = gohelper.findChild(go, "vx_upgrade")
	self._red = gohelper.findChild(go, "go_reddot")
end

function PinballTalentItem:addEventListeners()
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, self._refreshUI, self)
end

function PinballTalentItem:removeEventListeners()
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, self._refreshUI, self)
end

function PinballTalentItem:setData(data, buildingCo)
	self._data = data
	self._buildingCo = buildingCo
end

function PinballTalentItem:onLearn()
	gohelper.setActive(self._effect, false)
	gohelper.setActive(self._effect, true)
end

function PinballTalentItem:_refreshUI()
	self:setSelect(false)
end

function PinballTalentItem:setSelect(isSelect)
	local isUnLock = self:isActive()
	local canActive = self:canActive2()
	local isBigIcon = self._data.isBig
	local name = ""

	if isSelect and isUnLock and isBigIcon then
		name = "v2a4_tutushizi_talenbg1_1"
	elseif isSelect and not isUnLock and canActive and isBigIcon then
		name = "v2a4_tutushizi_talenbg1_2"
	elseif isSelect and not isUnLock and not canActive and isBigIcon then
		name = "v2a4_tutushizi_talenbg1_0"
	elseif not isSelect and isUnLock and isBigIcon then
		name = "v2a4_tutushizi_talenbg1_3"
	elseif not isSelect and not isUnLock and canActive and isBigIcon then
		name = "v2a4_tutushizi_talenbg1_4"
	elseif not isSelect and not isUnLock and not canActive and isBigIcon then
		name = "v2a4_tutushizi_talenbg1_5"
	elseif isSelect and isUnLock and not isBigIcon then
		name = "v2a4_tutushizi_talenbg2_1"
	elseif isSelect and not isUnLock and canActive and not isBigIcon then
		name = "v2a4_tutushizi_talenbg2_2"
	elseif isSelect and not isUnLock and not canActive and not isBigIcon then
		name = "v2a4_tutushizi_talenbg2_0"
	elseif not isSelect and isUnLock and not isBigIcon then
		name = "v2a4_tutushizi_talenbg2_3"
	elseif not isSelect and not isUnLock and canActive and not isBigIcon then
		name = "v2a4_tutushizi_talenbg2_4"
	elseif not isSelect and not isUnLock and not canActive and not isBigIcon then
		name = "v2a4_tutushizi_talenbg2_5"
	end

	UISpriteSetMgr.instance:setAct178Sprite(self._imageicon, self._data.icon)
	UISpriteSetMgr.instance:setAct178Sprite(self._imageiconbg_select, name)
	UISpriteSetMgr.instance:setAct178Sprite(self._imageiconbg_unselect, name)
	gohelper.setActive(self._imageiconbg_select, isSelect)
	gohelper.setActive(self._imageiconbg_unselect, not isSelect)
	gohelper.setActive(self._red, canActive)
end

function PinballTalentItem:isActive()
	if not self._data then
		return false
	end

	return not not PinballModel.instance:getTalentMo(self._data.id)
end

function PinballTalentItem:canActive()
	local conditionArr = string.splitToNumber(self._data.condition, "#") or {}

	for _, id in pairs(conditionArr) do
		if not PinballModel.instance:getTalentMo(id) then
			return false
		end
	end

	local co = self._buildingCo
	local needLv = self._data.needLv
	local buildInfo = PinballModel.instance:getBuildingInfoById(co.id)

	if buildInfo and needLv > buildInfo.level then
		return false
	end

	return true
end

function PinballTalentItem:canActive2()
	if self:isActive() then
		return false
	end

	if not self:canActive() then
		return false
	end

	local cost = self._data.cost

	if not string.nilorempty(cost) then
		local dict = GameUtil.splitString2(cost, true)

		for _, arr in pairs(dict) do
			if arr[2] > PinballModel.instance:getResNum(arr[1]) then
				return false
			end
		end
	end

	return true
end

return PinballTalentItem
