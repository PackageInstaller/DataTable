-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueTestEffectView.lua

module("logic.extensions.roguelike.view.explore.RogueTestEffectView", package.seeall)

local M = class("RogueTestEffectViewRogueTestEffectView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._cardItems = {}
end

function M:buildUI()
	self._traCardParent = self:getGo("props_test_effect_view_-363431592").transform
	self._goCardItem = self:getGo("props_test_effect_view_1653622645")
	self._inputEffectId = self:getInput("props_test_effect_view_1347079623")
	self._inputParam1 = self:getInput("props_test_effect_view_-1341278769")
	self._inputParam2 = self:getInput("props_test_effect_view_-947649477")
	self._btnConfirm = self:getBtn("props_test_effect_view_1371248479")
	self._btnGetProp = self:getBtn("props_test_effect_view_1675189139")
	self._btnClose = self:getBtn("0&empty_mask_tips_29887572")
	self._txtCoinNum = self:getText("props_test_effect_view_-1862582701")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._btnGetProp:AddClickListener(self._onClickGetProp, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)
	self:updateRoleInfo()

	for k, v in pairs(self._cardItems) do
		v:bindEvents()
	end

	self:updateCoinNum()
end

function M:updateCoinNum()
	local coinNum = RoguelikeModel.instance:getGold() or 0

	self._txtCoinNum.text = string.format("金币数量：%d", coinNum)
end

function M:onExit()
	self:setEvent(false)

	for k, v in pairs(self._cardItems) do
		v:unbindEvents()
	end
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_GOLD, self._onRefreshGold, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_ROLE_INFO, self._onRefreshRole, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_GOLD, self._onRefreshGold, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_ROLE_INFO, self._onRefreshRole, self)
	end
end

function M:_onRefreshRole(sender, roleId, roleIndex)
	self:updateRoleInfo()
end

function M:_onRefreshGold(sender, gold)
	local coinNum = gold or RoguelikeModel.instance:getGold()

	self._txtCoinNum.text = string.format("金币数量：%d", coinNum)
end

function M:updateRoleInfo()
	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()

	for i = 1, #allRoles do
		local item = self._cardItems[i]

		if not item then
			local go = Astral.GameObjectUtil.CloneAndSetParent(self._goCardItem, self._traCardParent, nil)

			item = RogueRoleCardItem.New(go)
			self._cardItems[i] = item
		end

		if allRoles[i].roleProp:getIsDeath() then
			-- block empty
		end

		local data = {}
		local index = i

		data.roleId = allRoles[i].roleProp:getIsDeath() and 0 or allRoles[i].roleProp:getRoleId()

		function data.callback()
			if data.roleId == 0 then
				return
			end

			self:onCardClickCallback(index)
		end

		data.hp = allRoles[i].roleProp:getHp()
		data.san = allRoles[i].roleProp:getSan()

		item:updateData(data)
	end

	self._allRoles = allRoles
end

function M:onCardClickCallback(idx)
	print("选择", idx)

	local roleId = self._allRoles[idx].roleProp:getRoleId()

	self._inputParam1:SetText(roleId)
end

function M:_onClickClose()
	self:close()
end

function M:_onClickGetProp()
	local effectId = self._inputEffectId:GetText()

	if effectId == nil or effectId == "" then
		FloatWordMgr.instance:show("没填写道具id")

		return
	end

	effectId = tonumber(effectId)

	local heroId = self._inputParam1:GetText()

	if heroId == nil or heroId == "" then
		heroId = 0

		self._inputParam1:SetText(heroId)
	end

	heroId = tonumber(heroId)

	local attr = self._inputParam2:GetText()

	if attr == nil or attr == "" then
		attr = -1

		self._inputParam2:SetText(attr)
	end

	attr = tonumber(attr)

	ViewMgr.instance:open(ViewName.RogueSelectPropAndRole, {
		2,
		{
			effectId
		}
	})

	return
end

function M:_onClickConfirm()
	local effectId = self._inputEffectId:GetText()

	if effectId == nil or effectId == "" then
		effectId = 10000002

		self._inputEffectId:SetText(effectId)
	end

	effectId = tonumber(effectId)

	local heroId = self._inputParam1:GetText()

	if heroId == nil or heroId == "" then
		heroId = 0

		self._inputParam1:SetText(heroId)
	end

	heroId = tonumber(heroId)

	local attr = self._inputParam2:GetText()

	if attr == nil or attr == "" then
		attr = -1

		self._inputParam2:SetText(attr)
	end

	attr = tonumber(attr)

	RoguelikeController.instance:execEffectIds({
		effectId
	}, function()
		return
	end)
end

return M
