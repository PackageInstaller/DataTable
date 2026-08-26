-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/skill/MaLiAnNaActionUtils.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.skill.MaLiAnNaActionUtils", package.seeall)

local MaLiAnNaActionUtils = class("MaLiAnNaActionUtils")

function MaLiAnNaActionUtils:ctor()
	self._defineList = {
		[Activity201MaLiAnNaEnum.SkillAction.addSlotSolider] = MaLiAnNaActionUtils._addSlotSolider,
		[Activity201MaLiAnNaEnum.SkillAction.removeSlotSolider] = MaLiAnNaActionUtils._removeSlotSolider,
		[Activity201MaLiAnNaEnum.SkillAction.moveSlotSolider] = MaLiAnNaActionUtils._moveSlotSolider,
		[Activity201MaLiAnNaEnum.SkillAction.pauseSlotGenerateSolider] = MaLiAnNaActionUtils._pauseSlotGenerateSolider,
		[Activity201MaLiAnNaEnum.SkillAction.releaseBullet] = MaLiAnNaActionUtils._releaseBullet,
		[Activity201MaLiAnNaEnum.SkillAction.killSolider] = MaLiAnNaActionUtils._killSolider
	}
end

function MaLiAnNaActionUtils._addSlotSolider(param, effect)
	if param == nil or effect == nil then
		return
	end

	local slotId = param[1]

	if slotId == nil then
		return
	end

	local num = tonumber(effect[2]) or 1
	local slot = Activity201MaLiAnNaGameModel.instance:getSlotById(slotId)

	if slot then
		slot:skillToCreateSolider(num, Activity201MaLiAnNaEnum.CampType.Player)

		if isDebugBuild then
			logNormal("添加槽位士兵：" .. slot:getConfig().baseId .. " 数量：" .. num)
		end
	end
end

function MaLiAnNaActionUtils._removeSlotSolider(param, effect)
	if param == nil or effect == nil then
		return
	end

	local slotId = param[1]

	if slotId == nil then
		return
	end

	local num = tonumber(effect[2]) or 1
	local slot = Activity201MaLiAnNaGameModel.instance:getSlotById(slotId)

	if slot then
		slot:skillToRemoveSolider(num, Activity201MaLiAnNaEnum.CampType.Enemy)

		if isDebugBuild then
			logNormal("移除槽位士兵：" .. slot:getConfig().baseId .. " 数量：" .. num)
		end
	end
end

function MaLiAnNaActionUtils._moveSlotSolider(param, effect)
	if param == nil or effect == nil then
		return
	end

	local startSlotId = param[1]
	local endSlotId = param[2]

	if startSlotId == nil or endSlotId == nil then
		return
	end

	local num = tonumber(effect[2]) or 1
	local startSlot = Activity201MaLiAnNaGameModel.instance:getSlotById(startSlotId)
	local endSlot = Activity201MaLiAnNaGameModel.instance:getSlotById(endSlotId)
	local normalSoliderCount = startSlot:getSoliderCount()
	local moveNum = math.min(num, normalSoliderCount - 1)

	if startSlot and endSlot then
		for i = 1, moveNum do
			local soliderMo = startSlot:getAndRemoveNormalSolider()

			if soliderMo then
				endSlot:enterSoldier(soliderMo, true)
			end
		end

		if isDebugBuild then
			logNormal("转移士兵【1->2】：" .. startSlot:getConfig().baseId .. " -> " .. endSlot:getConfig().baseId)
		end
	end
end

function MaLiAnNaActionUtils._pauseSlotGenerateSolider(param, effect)
	if param == nil or effect == nil then
		return
	end

	local slotId = param[1]

	if slotId == nil then
		return
	end

	local time = tonumber(effect[2]) or 1
	local slot = Activity201MaLiAnNaGameModel.instance:getSlotById(slotId)

	if slot then
		slot:setSkillGenerateSoliderEffectTime(time)

		if isDebugBuild then
			logNormal("干扰生成和出兵：" .. slot:getConfig().baseId)
		end
	end
end

local tempSlot = {}

function MaLiAnNaActionUtils._releaseBullet(param, effect)
	if param == nil or effect == nil then
		return
	end

	if isDebugBuild then
		logNormal("触发狙杀：")
	end

	local useSoliderId = param[1]
	local range = effect[3]
	local effectPathId = effect[4]
	local speed = tonumber(effect[5]) or 1
	local soliderMo = MaLiAnNaLaSoliderMoUtil.instance:getSoliderMoById(useSoliderId)

	if soliderMo == nil then
		return
	end

	local camp = soliderMo:getCamp()
	local x, y = soliderMo:getLocalPos()
	local soliderId = MaLiAnNaActionUtils._findSolider(x, y, range, (camp == Activity201MaLiAnNaEnum.CampType.Enemy or nil) and Activity201MaLiAnNaEnum.CampType.Player)

	if soliderId ~= nil then
		local bullet = MaliAnNaBulletEntityMgr.instance:getBulletEffectEntity()

		if bullet ~= nil then
			local startX, startY = soliderMo:getBulletPos()

			if startX == nil or startY == nil then
				startX, startY = soliderMo:getLocalPos()
			end

			bullet:setInfo(startX, startY, soliderId, speed, effectPathId, true)

			if isDebugBuild then
				logNormal("实行狙杀：")
			end

			return
		end
	end
end

function MaLiAnNaActionUtils._killSolider(param, effect)
	if param == nil or effect == nil then
		return
	end

	local range = effect[2]

	if not effect[4] then
		local x = param[1]
		local y = param[2]
		local camp = param[3]
		local soliderId = MaLiAnNaActionUtils._findSolider(x, y, range, camp)

		if soliderId then
			Activity201MaLiAnNaGameController.instance:consumeSoliderHp(soliderId, -effect[4])

			if isDebugBuild then
				logNormal("杀死士兵：")
			end
		end
	end
end

function MaLiAnNaActionUtils._findSolider(x, y, range, findCamp)
	local soliderId

	if tempSlot ~= nil then
		tabletool.clear(tempSlot)
	end

	local allSolider = MaLiAnNaLaSoliderMoUtil.instance:getAllSoliderMoList()

	for _, solider in pairs(allSolider) do
		if solider then
			local posX, posY = solider:getLocalPos()

			if solider:getCamp() == findCamp and MathUtil.isPointInCircleRange(x, y, range, posX, posY) and not solider:isDead() then
				table.insert(tempSlot, solider)
			end
		end
	end

	if tempSlot ~= nil then
		table.sort(tempSlot, function(a, b)
			local ax, ay = a:getLocalPos()
			local bx, by = b:getLocalPos()

			return MathUtil.vec2_lengthSqr(x, y, ax, ay) < MathUtil.vec2_lengthSqr(x, y, bx, by)
		end)
	end

	return (#tempSlot > 0 or nil) and tempSlot[1]:getId()
end

function MaLiAnNaActionUtils:getHandleFunc(type)
	return self._defineList[type]
end

MaLiAnNaActionUtils.instance = MaLiAnNaActionUtils.New()

return MaLiAnNaActionUtils
