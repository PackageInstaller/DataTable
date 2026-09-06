-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throne/view/ThronerewardItem.lua

module("logic.extensions.throne.view.ThronerewardItem", package.seeall)

local ThronerewardItem = class("ThronerewardItem", BaseLuaOnce)

function ThronerewardItem:ctor(go)
	ThronerewardItem.super.ctor(self, go)
end

function ThronerewardItem:buildUI()
	ThronerewardItem.super.buildUI(self)

	self._itemCon = self:getGo("itemCon")
	self._itemCell = self:getGo("itemCon/cell")
	self._nameText = self:getText("nameText")
	self._getBtn = self:getBtn("getBtn")
	self._itemGroup = ItemGroup.New(self._itemCon, self._itemCell, nil, nil, true)
end

function ThronerewardItem:bindEvents()
	ThronerewardItem.super.bindEvents(self)
	self._getBtn:AddClickListener(self._onClickGet, self)
end

function ThronerewardItem:unbindEvents()
	ThronerewardItem.super.unbindEvents(self)
	self._getBtn:RemoveClickListener()
end

function ThronerewardItem:onEnter(data, isGet)
	ThronerewardItem.super.onEnter(self)

	self._data = data
	self._isGet = isGet

	local hasNum = ThroneModel.instance:getThroneNum()

	self._isGray = self._isGet or hasNum < data.num

	GameUtil.SetGray(self._getBtn.gameObject, self._isGray)
	goutil.setActive(self._getBtn.gameObject, not self._isGet)

	self._nameText.text = data.desc

	local list = string.split(data.prize, "#")

	self._itemGroup:updateWithMoArray(list, function(item, data)
		MaterialMgr.setCellByCfg(data, item.mainGO)
	end)
end

function ThronerewardItem:onExit()
	ThronerewardItem.super.onExit(self)
	self._itemGroup:dispose(function(item)
		MaterialMgr.resetAll(item.mainGO)
	end)
end

function ThronerewardItem:_onClickGet()
	if self._isGet then
		FloatWordMgr.instance:show("奖励已领取")

		return
	end

	if self._isGray then
		FloatWordMgr.instance:show("条件未满足")

		return
	end

	ThroneAgent.instance:sendPM_GainThroneAchievementPrizeReq(self._data.id)
end

return ThronerewardItem
