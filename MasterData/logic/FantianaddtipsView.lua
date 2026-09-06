-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/view/FantianaddtipsView.lua

module("logic.extensions.fantian.view.FantianaddtipsView", package.seeall)

local FantianaddtipsView = class("FantianaddtipsView", ViewComponent)

function FantianaddtipsView:ctor()
	FantianaddtipsView.super.ctor(self)
end

function FantianaddtipsView:unbindEvents()
	FantianaddtipsView.super.unbindEvents(self)

	for i, v in ipairs(self._itemList) do
		GameUtil.rmClickHandler(v)
	end
end

function FantianaddtipsView:bindEvents()
	FantianaddtipsView.super.bindEvents(self)

	for i, v in ipairs(self._itemList) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickCell, self, i))
	end
end

function FantianaddtipsView:buildUI()
	FantianaddtipsView.super.buildUI(self)

	self._itemList = {}

	for i = 1, 9 do
		local cell = self:getGo("itemNum_" .. i)

		table.insert(self._itemList, cell)
	end
end

function FantianaddtipsView:onExit()
	FantianaddtipsView.super.onExit(self)
end

function FantianaddtipsView:onEnter()
	FantianaddtipsView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()

	local activityId = self._fmtMo.activityId
	local curSelectTierId = self._fmtMo.curSelectTierId
	local curSelectLevel = self._fmtMo.curSelectLevel

	self.activityId = activityId

	local cfg = FanTianChallengeConfig.instance:getStageCfgById(activityId, curSelectTierId, curSelectLevel) or {}

	self.creepsMasterId = cfg.creepsMasterId
	self.creeps = FanTianChallengeConfig.instance:getCreepsCfgById(self.creepsMasterId)

	local idx = 1
	local idxMap = {}

	self._posMap = {}

	for k, v in pairs(self.creeps) do
		self._posMap[v.posId] = v

		if not string.nilorempty(v.dragonSoulDesc) then
			idxMap[v.posId] = idx
			idx = idx + 1
		else
			idxMap[v.posId] = 0
		end
	end

	for i, cell in ipairs(self._itemList) do
		local txtNum = goutil.findChildTextComponent(cell, "txtNum")
		local itemChange = goutil.findChildComponent(cell, "item", "UIImageSpriteChange")

		if self.activityId == 313001 then
			itemChange:SetState(0)
		elseif self.activityId == 313002 then
			itemChange:SetState(1)
		elseif self.activityId == 313003 then
			itemChange:SetState(2)
		end

		local cfg = self._posMap[i]

		GameUtil.SetActive(cell, cfg ~= nil and not string.nilorempty(cfg.dragonSoulDesc))

		if cfg and cfg.dragonSoulDesc then
			txtNum.text = idxMap[i]
		end
	end
end

function FantianaddtipsView:_onClickCell(index)
	if self._posMap then
		local cfg = self._posMap[index]

		if cfg then
			TipsFacade.instance:openPopupWindow(lang("tip"), cfg.dragonSoulDesc)
		end
	end
end

return FantianaddtipsView
