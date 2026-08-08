require "class"
---@class BattleOrderManager
local BattleOrderManager = class("BattleOrderManager")
local BattleCore = require "BattleCore"

---@type BattleManager
local battleMgr = nil

---@type BattleVerifyReplayer
local verifyReplayer = nil

---@class SelectBlockOrderResultData
---@field skillId integer
---@field targetBlockId integer
---@field mainSkillTargetId integer

---@class SelectBlockOrderData
---@field blockId integer
---@field result SelectBlockOrderResultData

function BattleOrderManager:ctor()
	BattleCore.ds("BattleOrderManager:ctor")
	self._curIndex = 0
	self._totalCount = 0
	---@type table?
	self._curOrders = nil
	self._lastExecutedOrder = nil
	self._orderEvent = {}
	self._isInit = false
	self._stepMode = false
	self._autoStart = true
	self._isFinished = false
end

function BattleOrderManager:_initOrderEvent()
	self._orderEvent = {
		[GE.BattleOrderType.RoleMove] = self.roleMove,
		[GE.BattleOrderType.RoleDoSkill] = self.roleDoSkill,
		[GE.BattleOrderType.RoleStandby] = self.roleStandby,
		[GE.BattleOrderType.SelectRole] = self.selectRole,
		[GE.BattleOrderType.SelectBlock] = self.selectBlock,
		[GE.BattleOrderType.SelectSkill] = self.selectSkill,
	}
end

---@param initbattleMgr BattleManager
---@param options table?
function BattleOrderManager:initOrders(orders, initbattleMgr, options)
	self._curOrders = orders
	self._curIndex = 0
	self._totalCount = orders and #orders or 0
	self._lastExecutedOrder = nil
	self._stepMode = options and options.stepMode == true or false
	self._autoStart = not (options and options.autoStart == false)
	self._isFinished = false
	self:_initOrderEvent()
	self._isInit = true
	battleMgr = initbattleMgr
	local isReplayMode = options and options.replayMode == true
	if isReplayMode then
		verifyReplayer = require("BattleVerifyReplayer")
	end
end

function BattleOrderManager:nextOrder()
	-- LuaLogger.ds("BattleOrderManager:nextOrder",self._curIndex, #self._curOrders)
	if self._isFinished then
		return false
	end
	self._curIndex = self._curIndex + 1
	if (self._curIndex > #self._curOrders) then
		self:orderFinish()
		return false
	end
	if self._curOrders and tablex.next(self._curOrders) then
		self:executeOrder(self._curOrders[self._curIndex])
		return true
	end
	return false
end

function BattleOrderManager:orderFinish()
	BattleCore.ds("BattleOrderManager:orderFinish verify finsh~")
	self._isFinished = true
	if not self._stepMode then
		self._curOrders = {}
	end
end

function BattleOrderManager:OrderCheckFail()
	BattleCore.es("战斗验证未通过!当前验证节点为", self._curIndex)
	battleMgr:verifyBattleFail()
	self:orderFinish()
end

function BattleOrderManager:executeOrder(order)
	if not GV.IsServer then
		BattleCore.ds("BattleOrderManager:executeOrder type", order.type)
	end
	if (not self._isInit) then
		BattleCore.ds("BattleOrderManager:executeOrder never init!")
		return
	end

	local result = true
	local func = self._orderEvent[order.type]
	self._lastExecutedOrder = order
	if func then
		result = func(self, order.data)
		if order.data then
			local curRandomIndex = battleMgr:getRandomIndex()
			if order.data.curRandomIndex and curRandomIndex ~= order.data.curRandomIndex then
				BattleCore.es("战斗指令：随机数索引不匹配", curRandomIndex, order.data.curRandomIndex)
			end
		end
	else
		BattleCore.ds("BattleOrderManager:wrong order type!")
	end

	if result ~= false then
		if self._stepMode then
			if self._curIndex >= self._totalCount then
				self:orderFinish()
			end
		else
			self:nextOrder()
		end
	else
		self:OrderCheckFail()
	end
end

function BattleOrderManager:isStepMode()
	return self._stepMode
end

function BattleOrderManager:shouldAutoStart()
	return self._autoStart
end

function BattleOrderManager:getCurrentIndex()
	return self._curIndex or 0
end

function BattleOrderManager:getTotalCount()
	return self._totalCount or 0
end

function BattleOrderManager:getNextOrder()
	if not self._curOrders or self._isFinished then
		return nil
	end
	return self._curOrders[(self._curIndex or 0) + 1]
end

function BattleOrderManager:getCurrentOrder()
	if not self._curOrders then
		return nil
	end
	return self._curOrders[self._curIndex]
end

function BattleOrderManager:getLastExecutedOrder()
	return self._lastExecutedOrder
end

function BattleOrderManager:isFinished()
	return self._isFinished == true
end

function BattleOrderManager:roleMove(orderData)
	local role = battleMgr:getRoleManager():getRole(orderData.roleId)
	if role then
		local moveBlock = battleMgr:getBlockById(orderData.blockId)
		role:setChooseMoveBlock(moveBlock, orderData.path)
		role:preMove(moveBlock, orderData.path)
		---预移动后需要重新计算行动范围
		local roleMgr = battleMgr:getRoleManager()
		roleMgr:calculateAllRolesActionRange({ GE.BattleCampType.Enemy })
	end
end

function BattleOrderManager:selectBlock(orderData)
	-- print("战斗指令：点击格子", orderData.blockId)
	local orderResult = false
	local block = battleMgr:getBlockById(orderData.blockId)
	local role = battleMgr:getSelectedRole()
	---@type SelectBlockOrderResultData
	local result = orderData.result
	if block then
		orderResult = true
		battleMgr:clickBlock(block, true)
		-- if role.selectedSkill ~= result.skillId then
		-- 	orderResult = false
		-- 	self:OnReplayFail(string.format("战斗指令：技能ID不匹配,当前技能ID为%d,指令技能ID为%d", role.selectedSkill or 0, result.skillId or 0))
		-- end
		-- if role.skillTargetBlock == nil or role.skillTargetBlock.id ~= result.targetBlockId then
		-- 	local skillBlockId = role.skillTargetBlock and role.skillTargetBlock.id or 0
		-- 	orderResult = false
		-- 	self:OnReplayFail(string.format("战斗指令：目标格子ID不匹配,当前格子ID为%d,指令格子ID为%d", skillBlockId, result.targetBlockId))
		-- end
		---遇到护卫技能会报错，故删除此判定
		-- if role.skillTargetBlock then
		-- 	local mainSkillTargetId = role.skillTargetBlock:getTmpRoleId() or 0
		-- 	if mainSkillTargetId ~= result.mainSkillTargetId then
		-- 		orderResult = false
		-- 		LuaLogger.es("战斗指令：主要目标角色ID不匹配", mainSkillTargetId, result.mainSkillTargetId)
		-- 	end
		-- end
	end
	if orderResult == true then
		BattleCore.ds("战斗指令：点击格子验证通过, 当前角色", role.roleConfig.name, "使用技能id为",
			result.skillId, "目标格子ID为", result.targetBlockId,
			"技能目标id为", result.mainSkillTargetId)
	end
	return orderResult
end

function BattleOrderManager:selectRole(orderData)
	-- print("战斗指令：选中角色", orderData.roleId)
	local role = battleMgr:getRoleManager():getRole(orderData.roleId)
	if role then
		-- local roleMgr = battleMgr:getRoleManager()
		-- if not roleMgr:isActionCamp(role.camp) then
		-- 	self:OnReplayFail(string.format("战斗指令：选中角色阵营不匹配,当前阵营为%d", role.camp))
		-- 	return false
		-- end
		-- if not roleMgr:isCanAction(role) then
		-- 	self:OnReplayFail(string.format("战斗指令：选中角色无法行动,角色ID为%d", role.id))
		-- 	return false
		-- end
		battleMgr:refreshRoleActionState(role, true)
		if battleMgr:getSelectedRole().id ~= role.id then
			self:OnReplayFail(string.format("战斗指令：选中角色不匹配,当前选中角色ID为%d,指令角色ID为%d", battleMgr:getSelectedRole().id, role.id))
			return false
		end
	end
end

function BattleOrderManager:roleStandby(orderData)
	-- print("战斗指令：角色待机", orderData.roleId)
	local roleMgr = battleMgr:getRoleManager()
	local role = roleMgr:getRole(orderData.roleId)
	local orderResult = false
	if role then
		local selfBlockId = 0
		orderResult = true
		local result = orderData.result
		local allRoleBlockDic = {}
		local roleList = roleMgr:getRolesList()
		local dicSize = 0
		for id, value in pairs(result.allRoleBlockDic) do
			if type(value) == "number" then
				local roleId = tonumber(id)
				if roleId then
					allRoleBlockDic[roleId] = value
				end
				dicSize = dicSize + 1
			end
		end
		if dicSize ~= #roleList then
			self:OnReplayFail(string.format("战斗指令：待机格子不匹配,角色数量不匹配,字典大小为%d,角色数量为%d", dicSize, #roleList))
			orderResult = false
		end
		for _, activeRole in ipairs(roleList) do
			local key = activeRole.id
			if not allRoleBlockDic[key] then
				BattleCore.es("战斗指令：待机格子不匹配,缺少角色id为", key)
				orderResult = false
			else
				local value = allRoleBlockDic[key]
				if key ~= role.id then
					local rBlockId = 0
					local r = roleMgr:getRole(key)
					if r then
						rBlockId = r.block.id
					end
					if rBlockId ~= value then
						BattleCore.es("战斗指令：待机格子不匹配,不匹配角色id为", key, rBlockId, value)
						orderResult = false
					end
				else
					selfBlockId = value
				end
			end
		end
		role:doAction(GE.ActionType.Standby)
		if role.block.id ~= selfBlockId then
			BattleCore.es("战斗指令：待机格子不匹配,当前角色id为", role.id, role.block.id, selfBlockId)
			orderResult = false
		end
		if orderResult == false then
			self:OnReplayFail(string.format("战斗指令：角色待机验证未通过,当前角色id为%d", role.id))
		end
	end
	return orderResult
end

function BattleOrderManager:selectSkill(orderData)
	-- print("战斗指令：选中技能", orderData.roleId, orderData.skillId)
	local role = battleMgr:getRoleManager():getRole(orderData.roleId)
	if role then
		role:selectSkill(orderData.skillId)
		if role:getShowBlock().id ~= orderData.blockId then
			self:OnReplayFail(string.format("战斗指令：所处格子不匹配,当前格子ID为%d,指令格子ID为%d", role:getShowBlock().id, orderData.curBlockId))
			return false
		end
	else
		self:OnReplayFail(string.format("战斗指令：选中技能未找到角色,角色ID为%d", orderData.roleId))
		return false
	end
end

function BattleOrderManager:roleDoSkill(orderData)
	local role = battleMgr:getRoleManager():getRole(orderData.roleId)
	if role then
		role:doAction(GE.ActionType.DoSkill)
	end
end

function BattleOrderManager:OnReplayFail(failText)
	if verifyReplayer then
		verifyReplayer.OnReplayFail(failText)
	end
	BattleCore.es("战斗指令：战斗回放失败", failText)
end

return BattleOrderManager