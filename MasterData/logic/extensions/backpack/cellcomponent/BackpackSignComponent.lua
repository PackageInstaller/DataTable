-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackSignComponent.lua

module("logic.extensions.backpack.cellcomponent.BackpackSignComponent", package.seeall)

local M = class("BackpackSignComponent", CellBaseComponent)

function M:ctor(cell)
	M.super.ctor(self, cell)

	self._numText = nil
end

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._signGo = registry:findUIElement("backpack_item_549918192")
	self._limitTimeSign = registry:findUIElement("backpack_item_-1569296312")
	self._txtLimitTime = goutil.findChildTextComponent(self._signGo, "limitTimeSign/txtLimitTime")
end

function M:updateData(data)
	local signVisible = false
	local expireTime = data:getExpireTime()

	expireTime = tonumber(expireTime)

	if expireTime > 0 then
		signVisible = true
		self._txtLimitTime.text = self:getExpiredTimeStr(expireTime)

		self._txtLimitTime.gameObject:SetActive(true)
	else
		self._txtLimitTime.gameObject:SetActive(false)
	end

	self._signGo:SetActive(signVisible)
	self._limitTimeSign:SetActive(signVisible)
end

function M:getExpiredTimeStr(expiredTime)
	local curTime = ServerTime.now() * 1000

	if expiredTime < curTime then
		return lang("tip_overdue")
	end

	local offset = expiredTime - curTime

	return TextFormatter.formatExpireTime(offset / 1000)
end

return M
