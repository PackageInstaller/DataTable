-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/selecttips/RogueAttrUpgradeView.lua

module("logic.extensions.roguelike.view.explore.selecttips.RogueAttrUpgradeView", package.seeall)

local M = class("RogueAttrUpgradeView", ViewComponent)

function M:buildUI()
	self._cardItems = {}
	self._goCardParent = self:getGo("rungroup_attribute_upgrade_view_-1426969763")

	local goItem = goutil.findChild(self._goCardParent, "run_group_lipai_item")

	self._lipaiItem = RogueRoleLiPaiItem.New(goItem)
	self._btnClose = self:getBtn("1&empty_mask_tips_29887572")
end

function M:bindEvents()
	self._btnClose:AddClickListener(self.checkClose, self)
	self._lipaiItem:bindEvents()
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._lipaiItem:unbindEvents()
end

function M:checkClose()
	if self._slotChanges and #self._slotChanges > 0 then
		local allRoles = RogueMgr.instance:getModel():getAllRoleMos()

		ViewMgr.instance:open(ViewName.RogueDiceUnlock, {
			-1,
			self._slotChanges,
			allRoles[self._selectIndex],
			function()
				self._slotChanges = nil

				self:checkClose()
			end
		})

		return
	end

	if self._closeCallback then
		self._closeCallback()
	end

	self:close()
end

function M:onEnter()
	local openParam = self:getFirstParam()
	local propCo = openParam[1]

	self._selectIndex = openParam[2]
	self._closeCallback = openParam[3]

	self:updateRoleInfo(propCo, self._selectIndex)
end

function M:onExit()
	return
end

function M:updateRoleInfo(propCo, selectIndex)
	self._propCo = propCo
	self._attrChangeList = {}

	for i, v in ipairs(propCo.effectIds) do
		local effectCo = RoguelikeConfig.instance:getEffectById(v)

		if effectCo.program == "AddAttribute" and selectIndex then
			local selectable = string.find(effectCo.params, "SELECTABLE")

			if selectable then
				local strList = string.split(effectCo.params, "#")
				local attrList = self:getEffectAttrList(strList[2])

				for k1, v1 in pairs(attrList) do
					self._attrChangeList[v1] = tonumber(strList[3])
				end
			end
		end
	end

	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()
	local slotChanges = {}
	local attrSlotChanges = {}
	local roleProp = allRoles[selectIndex].roleProp
	local actionIds = roleProp:getCardIds()

	for k, v in pairs(self._attrChangeList) do
		local curLevel = roleProp:getPropertyLevel(k)
		local curSlotCount = RoguelikeUtil.instance:getCardSlotCount(curLevel)
		local nexSlotCount = RoguelikeUtil.instance:getCardSlotCount(curLevel + v)

		if curSlotCount ~= nexSlotCount then
			table.insert(attrSlotChanges, {
				k,
				curLevel,
				curLevel + v,
				curSlotCount,
				nexSlotCount
			})
		end
	end

	for k, v in pairs(actionIds) do
		local actionCo = RoguelikeConfig.instance:getRoleActionById(v)

		for k1, v1 in pairs(attrSlotChanges) do
			if actionCo.attr == v1[1] then
				table.insert(slotChanges, {
					v,
					v1[2],
					v1[3],
					v1[4]
				})
			end
		end
	end

	self._slotChanges = slotChanges

	for i = 1, #allRoles do
		local item = self._lipaiItem

		if selectIndex == i then
			local data = {}
			local index = i

			data.roleId = allRoles[i].roleProp:getRoleId()
			data.isDeath = allRoles[i].roleProp:getIsDeath()

			local temp = data.roleId

			function data.callback()
				return
			end

			data.hp = allRoles[i].roleProp:getHp()
			data.card = allRoles[i].roleProp:getCard()
			data.attrChange = selectIndex == index and self._attrChangeList or nil

			item:updateData(data)
		end
	end
end

function M:getEffectAttrList(content)
	local iBegin = string.find(content, "%[")
	local iEnd = string.find(content, "%]")

	if not iBegin or not iEnd then
		return {
			tonumber(content) + 1
		}
	end

	local attrsStr = string.sub(content, iBegin + 1, iEnd - 1)
	local attrList = string.split(attrsStr, ",")
	local result = {}

	for k, v in pairs(attrList) do
		table.insert(result, tonumber(v) + 1)
	end

	return result
end

return M
