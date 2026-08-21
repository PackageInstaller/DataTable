-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueTeamInfoView.lua

module("logic.extensions.roguelike.view.explore.RogueTeamInfoView", package.seeall)

local M = class("RogueTeamInfoView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._cardItems = {}
end

function M:buildUI()
	self._traCardParent = self:getGo("run_group_result_view_-862745642").transform
	self._btnReturn = self:getBtn("run_group_result_view_1658217649")
end

function M:onEnter()
	self:showCurTeamInfo()
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()

	for k, v in pairs(self._cardItems) do
		v:unbindEvents()
	end
end

function M:_onClickReturn()
	self:close()
end

function M:showCurTeamInfo()
	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()

	for i = 1, #allRoles do
		local item = self._cardItems[i]

		if not item then
			item = RogueRoleLiPaiItem.New(self._traCardParent:GetChild(i - 1).gameObject)
			self._cardItems[i] = item
		end

		if allRoles[i].roleProp:getIsDeath() then
			-- block empty
		end

		local data = {}
		local index = i

		data.roleId = allRoles[i].roleProp:getIsDeath() and 0 or allRoles[i].roleProp:getRoleId()

		local temp = data.roleId

		function data.callback()
			return
		end

		data.hp = allRoles[i].roleProp:getHp()
		data.san = allRoles[i].roleProp:getSan()

		item:updateData(data)
	end
end

return M
