require "class"
---@class CoveSkillPerformence
local CoveSkillPerformence = class("CoveSkillPerformence")
local CoveShowMgr = require "CoveShowMgr"

function CoveSkillPerformence:ctor()
	LuaLogger.ds("SkillPerfHandler ctor")
	self:_initPerformanceEvent()
end

---实例化
---@return CoveSkillPerformence
function CoveSkillPerformence.instance()
	if (CoveSkillPerformence._instance == nil) then
		CoveSkillPerformence._instance = CoveSkillPerformence:new()
	end
	return CoveSkillPerformence._instance
end

---初始化表现事件
function CoveSkillPerformence:_initPerformanceEvent()
	self.performanceEvent = {
		[GE.SkillPerformanceType.ShootBullet] = self.shootBullet,
		[GE.SkillPerformanceType.JustHit] = self.justHit,
		-- [GE.SkillPerformanceType.AreaAttack] = self.areaAttack,
		-- [GE.SkillPerformanceType.JustEffect] = self.JustEffect,
		[GE.SkillPerformanceType.PlaneAttack] = self.PlaneAttack,
		[GE.SkillPerformanceType.TorpedoAttack] = self.TorpedoAttack,
		-- [GE.SkillPerformanceType.RailAttack] = self.RailAttack,
		-- [GE.SkillPerformanceType.PlaneBombing] = self.PlaneBombing,
		-- [GE.SkillPerformanceType.MissileAttack] = self.MissileAttack,
		-- [GE.SkillPerformanceType.ImpactAttack] = self.ImpactAttack,
		[GE.SkillPerformanceType.SideAttack] = self.SideAttack,
		-- [GE.SkillPerformanceType.DroneAttack] = self.DroneAttack,
	}
	--攻击类型转向Override 1为攻击者 2为受击者 没有k默认两者都为true
	self.faceToFaceOverride = {
		[GE.SkillPerformanceType.AreaAttack] = {false, true},	--范围攻击
		[GE.SkillPerformanceType.RailAttack] = {false, true},	--轨道攻击
	}
	self._isInit = true
end

function CoveSkillPerformence:_DoAfter(time, event)
	-- return LuaAsyncMgr:Delay(time, function()
	return DLuaTimer:DoAfter(time/Time.timeScale, function()
		if (event) then
			event()
		end
	end)
end

---执行技能表现 包含命中判定
---@param source CoveRole 执行技能方
---@param skinConfig table 执行技能方skin数据
---@param skillConfig table 技能数据
---@param target CoveRole 受击方
---@param hitRate number 命中率 0~1
---@param CB function 整轮技能表现结束回调
function CoveSkillPerformence:doSkill(source, skinConfig, skillConfig, target, hitRate, CB)
	---@type allHitDetailCove
	local allHitDetail = {}
	local temp = {
		target = target,
	}
	local bulletNum = self:GetBulletNum(skillConfig, skinConfig)
	-- 生成命中列表
	local hitList = {}
	for i = 1, bulletNum do
		local isHit = math.random() <= hitRate
		table.insert(hitList, {isHit = isHit})
	end
	-- 将命中列表添加到allHitDetail中
	temp.hitResult = hitList
	table.insert(allHitDetail, temp)
	local currentNum = 0
	local totalBullet = bulletNum
	LuaLogger.ds("CoveSkillPerformence:doSkill 攻击者", source._model.gameObject.name)
	LuaLogger.ds("CoveSkillPerformence:doSkill 受击者", target._model.gameObject.name)
	self:doPerformance(source, skinConfig, skillConfig, allHitDetail, function(isHit, originFunc, missFunc, obj, target)
		LuaLogger.ds("CoveSkillPerformence:doSkill 单发子弹回调 isHit", isHit)
		--若有投射物的情况下 判断原先逻辑是否命中 命中的情况下若目标角色不在原本位置上 执行missFunc
		local isMiss = false
		if isHit and obj and target then
			if target.destroyed then
				isMiss = true
			else
				-- 计算水平面距离（忽略Y轴）
				local pos1 = target._model.transform.position
				local pos2 = obj.transform.position
				
				-- 创建水平位置向量（Y轴设为0）
				local horizontalPos1 = Vector3(pos1.x, 0, pos1.z)
				local horizontalPos2 = Vector3(pos2.x, 0, pos2.z)
				
				-- 计算水平距离
				local horizontalDistance = Vector3.Distance(horizontalPos1, horizontalPos2)
				LuaLogger.ds("CoveSkillPerformence:doSkill 投射物命中后水平距离 horizontalDistance", horizontalDistance)
				if horizontalDistance > 0.5 then
					isMiss = true
				end
			end
			-- isMiss = true --测试代码 强制miss
		end
		if isMiss then
			if missFunc then
				LuaLogger.ds("CoveSkillPerformence:doSkill 投射物未命中 调用missFunc")
				missFunc()
			else
				originFunc()
			end
		else
			if originFunc then
				LuaLogger.ds("CoveSkillPerformence:doSkill 投射物命中 调用originFunc")
				originFunc()
			end
		end
		currentNum = currentNum + 1
		if currentNum == totalBullet then
			if CB then
				CB()
			end
		end
	end)
end

---@class allHitDetailCove
---@field target CoveRole 目标角色
---@field hitResult table 子弹数据
-- {
--  hitResult = {
-- 		{isHit = true},	...	--是否命中
-- },
-- }

---执行表现
---@param source CoveRole 执行技能方
---@param skinConfig table 执行技能方skin数据
---@param skillConfig table 技能数据
---@param allHitDetail allHitDetailCove 所有受击数据

---@return number, number, boolean, boolean (perfTime 表现时长, shootTime 表现射击时长,)
function CoveSkillPerformence:doPerformance(source, skinConfig, skillConfig, allHitDetail, CB)
	LuaLogger.ds("CoveSkillPerformence:doPerformance skillConfig", tablex.dump(skillConfig))
	LuaLogger.ds("CoveSkillPerformence:doPerformance skinConfig", tablex.dump(skinConfig))
	for k, v in pairs(allHitDetail) do
		LuaLogger.ds("CoveSkillPerformence:doPerformance allHitDetail.hitResult", tablex.dump(v.hitResult))
	end
	
	--去皮肤表里找对应表现
	local actid = skillConfig.skillActId --skill表与characterskill表对应字段  拼接skin表用 会修改
	local actid2 = skillConfig.skillActId	--skill表与characterskill表对应字段	常量 计算是否播放闪光特效用 不会修改
	local effPriority = skillConfig.effPriority
	local targetConfig = {}
	--effPriority 会否以skillConfig的配置为准 1:是 0:否
	if effPriority == 1 then
		targetConfig = skillConfig
		actid = ""
	else
		targetConfig = skinConfig
	end
	---@class PerfDataDetail table 表现数据
	---@field skillTimeline string 	特殊镜头表现
	---@field skillAtkAni string 	攻击动作
	---@field skillAtkEff number 	攻击特效
	---@field skillBulletType  SkillPerformanceType 表现类型 炮击、航母等
	---@field bulletList table 		表现具体参数 ({{bullet=1,speed = 1, height = 1, focus = 0.5}..)
	---@field bulletModel table 	子弹模型 {"bullet1","bullet2","bullet3","bullet4"}
	---@field hitEff number 		目标受击特效
	---@field dmgDelay number 		伤害延迟 3 aoe用
	---@field beeff number 			被击特效 3 aoe用
	---@field shooteff number 		射击特效 子弹射出时特效
	---@field smoke number 			烟雾特效 子弹射出后延迟播放
	---@field camera integer 		切换攻击镜头
	---@field area integer[] 		技能范围 8 地毯式轰炸用
	---@field shoot number 			射击位置 部分表现配在最外层 部分有子弹、飞机的表现配在子弹列表bulletList中
	---@type PerfDataDetail
	local perfData = {}
	local prefDelay = 0
	--走skin表需要skillActId>0 或者走skill表
	if (skillConfig.skillActId > 0) or actid == "" then
		local actIdIndex = "skillAct"..actid			--攻击动作
		if (targetConfig[actIdIndex] and targetConfig[actIdIndex] ~= "") then
			perfData.skillAtkAni = targetConfig[actIdIndex]
		end
		local actEffIndex = "skillActEff"..actid		--攻击特效
		if (targetConfig[actEffIndex] and targetConfig[actEffIndex] ~= "") then
			perfData.skillAtkEff = targetConfig[actEffIndex]
		end
		local bulletIndex = "bulletType"..actid			--表现类型 炮击、航母
		if (targetConfig[bulletIndex] and targetConfig[bulletIndex] ~= "") then
			perfData.skillBulletType = targetConfig[bulletIndex]
		end
		local bulletListIndex = "skillHitEff"..actid			
		if (targetConfig[bulletListIndex] and targetConfig[bulletListIndex] ~= "") then
			perfData.bulletList = targetConfig[bulletListIndex].bulletList	--表现具体参数({{bullet="bullet1",speed = 1, height = 1, focus = 0.5}..)
			perfData.hitEff = targetConfig[bulletListIndex].hiteff			--目标受击特效 aoe则为选中目标点特效 RailAttack为轨道攻击特效
			perfData.dmgDelay = targetConfig[bulletListIndex].dmgdelay		--伤害延迟
			perfData.beeff = targetConfig[bulletListIndex].beeff				--被击特效
			perfData.shooteff = targetConfig[bulletListIndex].shooteff		--射击特效
			perfData.smoke = targetConfig[bulletListIndex].smoke			--烟雾特效
			perfData.camera = targetConfig[bulletListIndex].camera				--切换攻击镜头
			prefDelay = targetConfig[bulletListIndex].delay or 0			--整体技能延迟
			perfData.effdelay = targetConfig[bulletListIndex].effdelay		--角色特效延迟
			perfData.shoot = targetConfig[bulletListIndex].shoot			--射击位置 部分表现配在最外层 部分有子弹、飞机的表现配在子弹列表bulletList中
			perfData.isfall = targetConfig[bulletListIndex].isfall			--是否需要下落	11
			perfData.hiteff2 = targetConfig[bulletListIndex].hiteff2		--命中特效2 11
		end
		perfData.bulletModel = skinConfig.bulletModel
		self:changeBulletModelByWeapon(perfData.bulletModel, source.id)
	end
	LuaLogger.ds("CoveSkillPerformence:doPerformance perfData", tablex.dump(perfData))
	--表现相关
	--子弹数量
	local bulletNum = self:GetBulletNum(skillConfig, skinConfig)
	perfData.bulletNum = bulletNum
	local perfTime = 0
	local shootTime = 0
	---@type playTimelineData
	local temp = {
		perfData = perfData,
		source = source,
		allHitDetail = allHitDetail,
	}
	--角色动作、特效 --todo
	self:checkRoleAnim(temp, source)
	--最后是弹道表现 炮击、雷击等 type = GE.SkillPerformanceType
	local type = perfData.skillBulletType
	if self.performanceEvent[type] then
		local allTargetList = nil
		if type == GE.SkillPerformanceType.PlaneBombing then
			allTargetList = {}
			for _, v in pairs(allHitDetail) do
				table.insert(allTargetList, {
					targetRoleId = v.target.id,
					targetRole = v.target,
				})
			end
		end
		local targetIndex = 0
		local totalNum = tablex.size(allHitDetail)
		local current = 0
		for k, v in pairs(allHitDetail) do
			targetIndex = targetIndex + 1
			---@type PerfData
			local data = {
				source = source,
				target = v.target,
				perfData = perfData,
				skillConfig = skillConfig,
				delay = prefDelay,
				hitData = v.hitResult,
				targetIndex = targetIndex,
				allTargetList = allTargetList,
			}
			self.performanceEvent[type](self, data, CB)
		end
	end
	return perfTime, shootTime
end

---@param skillData SkillTable
---@param skinData CharacterSkinTable
--获取子弹数量
function CoveSkillPerformence:GetBulletNum(skillData, skinData)
	local skillActId = skillData.skillActId
	local targetType
	local targetSkillHitEff
	if skillData.effPriority == 1 then
		targetType = skillData.bulletType
		targetSkillHitEff = skillData.skillHitEff
	else
		targetType = skinData["bulletType"..skillActId]
		targetSkillHitEff = skinData["skillHitEff"..skillActId]
	end
	--子弹数量 默认为1  AreaAttack JustEffect
	local num = 1
	local bulletNumType
	for k, v in pairs(GE.SkillPerformanceToBulletNumType) do
		if tablex.contains(v, targetType) then
			bulletNumType = k
			break
		end
	end
	if bulletNumType == GE.BulletNumType.one then
		num = 1
	elseif bulletNumType == GE.BulletNumType.bulletList then
		num = tablex.size(targetSkillHitEff.bulletList)
	elseif bulletNumType == GE.BulletNumType.plane then
		num = 0
		for _, plane in pairs(targetSkillHitEff.bulletList) do
			for _, Bomb in pairs(plane.boomList) do
				num = num + 1
			end
		end
	end
	return num
end

-- ---根据武器替换子弹模型
-- ---@param bulletModelOrigin table 原始子弹模型
-- ---@param battleRole BattleRole 角色
function CoveSkillPerformence:changeBulletModelByWeapon(bulletModelOrigin, id)
	-- local serverData = battleMgr:getHeroServeraDta(cid)
	local serverData = Me:getPlayerHero(id)
	if serverData then
		local carryWeapon = serverData and serverData.carryWeapon
		if carryWeapon and next(carryWeapon) then
			for i = #carryWeapon, 1, -1 do
				if carryWeapon[i] ~= 0 then
					local weaponInfo = Me:getWeaponDataById(carryWeapon[i])
					local weaponConfig = Config.GetWeaponInfo(weaponInfo.cid)
					if weaponConfig then
						local bulletModel = weaponConfig.bulletModel
						if bulletModel and next(bulletModel) then
							bulletModelOrigin[bulletModel[1]] = bulletModel[2]
						end
					end
				end
			end
		end
	end
end

--角色动作、特效
---@param data playTimelineData
function CoveSkillPerformence:checkRoleAnim(data, souece)
	local animName = data.perfData.skillAtkAni
	local effId = data.perfData.skillAtkEff
	local model = data.source._model
	if (model) then
		local animName = animName or "Attack"
		model:PlayAnim(RoleModelAnimEnum[animName], function()
			--LuaLogger.ds("CoveSkillPerformence:checkRoleAnim 动作播放完毕", animName)
			souece:SetAttackAnimState(false)
		end)
		model:SetDefaultState(RoleAnimStateType.IdleShip)
		souece:SetAttackAnimState(true)
	end
	if (data.effectId) then
		local pos = model.transform.position
		local rotation = model.transform.rotation
		CoveShowMgr.instance():playEffect(pos, data.effectId, rotation)
	end
end

---尝试获取上层参数
---@param value any 当前参数
---@param upperData table 上层数据
---@return any
function CoveSkillPerformence:tryGetUpperParam(value, upperData)
	local upperParam = upperData[value]
	if (upperParam) then
		return upperParam
	end
	return value
end

---PerformanceEvent--------------------------------------------------------------------------------------

---发射子弹
---@class PerfData table 表现数据
---@field source CoveRole 执行技能方
---@field target CoveRole 目标
---@field perfData PerfDataDetail 表现数据
---@field skillConfig table 技能数据
---@field delay number 表现延时
---@field hitData HitData 受击数据
---@field targetIndex number 单次技能目标索引 用于判断aoe类技能只在第一个角色地块受击时播放特效
---@field dmgDelay number 伤害延迟
---@field shoot number 射击位置

---@param data PerfData
---@return number, number 表现时长
function CoveSkillPerformence:shootBullet(data, CB)
	LuaLogger.ds("CoveSkillPerformence:shootBullet roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local index = 0
	local totalDelay = 0	--总延迟
	local hitResult = data.hitData
	--子弹列表
	for k, bullet in pairs(data.perfData.bulletList) do
		LuaLogger.ds("shootBullet子弹详情配置", tablex.dump(bullet))
		index = index + 1
		--子弹模型
		local bulletIndex = bullet.bullet
		local bulletName = data.perfData.bulletModel[bulletIndex]
		--受击特效
		local hitEffect = 1074 --默认受击特效
		local hitEffect = (data.perfData.hitEff ~= nil and data.perfData.hitEff ~= "") and data.perfData.hitEff or hitEffect
		--射击特效
		local shootEffect = data.perfData.shooteff
		local smoke = data.perfData.smoke
		---@type BulletData
		local reportData = {
			index = index,				--子弹索引
			bulletName = bulletName,	--子弹预制体名
			speed = bullet.speed,		--弹速
			delay = skillDelay + bullet.delay,		--技能延迟+单个子弹延迟
			curve = Vector3.New(0, bullet.height, 0),		--贝赛尔曲线高度
			focus = bullet.focus,		--贝塞尔曲线中间点
			role = data.source,
			target = data.target,
			hitEffect = hitEffect,		--受击特效
			shootEffect = shootEffect,	--射击特效
			smoke = smoke,				--烟雾特效
			hitResult = hitResult[index],
			shootPos = bullet.shoot		--射击位置
		}
		self:_DoAfter(reportData.delay, function()
			if reportData.role.destroyed or reportData.target.destroyed then
			else
				CoveShowMgr.instance():shootBullet(reportData, CB)
			end
		end)
	end
end

---发射子弹
---@class PerfData table 表现数据
---@field source BattleRole 执行技能方
---@field target BattleRole 目标
---@field perfData PerfDataDetail 表现数据
---@field skillConfig table 技能数据
---@field delay number 表现延时
---@field hitData HitData 受击数据
---@field targetIndex number 单次技能目标索引 用于判断aoe类技能只在第一个角色地块受击时播放特效
---@field dmgDelay number 伤害延迟
---@field shoot number 射击位置

---@param data PerfData
---@return number, number 表现时长
function CoveSkillPerformence:SideAttack(data, CB)
	LuaLogger.ds("CoveSkillPerformence:SideAttack roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local index = 0
	local totalDelay = 0	--总延迟
	local hitResult = data.hitData
	--子弹列表
	for k, bullet in pairs(data.perfData.bulletList) do
		LuaLogger.ds("SideAttack子弹详情配置", tablex.dump(bullet))
		index = index + 1
		local hitResult = hitResult[index]
		--子弹模型
		local bulletIndex = bullet.bullet
		local bulletName = data.perfData.bulletModel[bulletIndex]
		--受击特效
		local hitEffect = 1074 --默认受击特效
		local hitEffect = (data.perfData.hitEff ~= nil and data.perfData.hitEff ~= "") and data.perfData.hitEff or hitEffect
		--射击特效
		local shootEffect = data.perfData.shooteff
		local smoke = data.perfData.smoke
		---@type SideAttackBulletData
		local reportData = {
			index = index,						--子弹索引
			bulletName = bulletName,	--子弹预制体名
			speed = bullet.speed,		--弹速
			delay = skillDelay + bullet.delay,		--技能延迟+单个子弹延迟
			focus = bullet.focus,		--贝塞尔曲线中间点
			hitEffect = hitEffect,		--受击特效
			shootEffect = shootEffect,	--射击特效
			smoke = smoke,				--烟雾特效
			shootPos = bullet.shoot,		--射击位置
			partialEffect = data.perfData.hiteff2,--射击擦弹特效
			offsetx = bullet.offsetx,	--子弹左右偏移
			offsety = bullet.offsety,	--子弹上下偏移
			isfall = data.perfData.isfall,	--是否需要下落
			hitResult = hitResult,		--伤害详情
			role = data.source,
			target = data.target,
		}
		self:_DoAfter(reportData.delay, function()
			if reportData.role.destroyed or reportData.target.destroyed then
			else
				CoveShowMgr.instance():SideAttack(reportData, CB)
			end
		end)
	end
end

---直接受击
---@param data PerfData
---@return number, number 表现时长
function CoveSkillPerformence:justHit(data, CB)
	LuaLogger.ds("CoveSkillPerformence:justHit roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local index = 0
	local totalDelay = 0	--总延迟
	local hitResult = data.hitData
	--子弹列表
	for k, bullet in pairs(data.perfData.bulletList) do
		LuaLogger.ds("justHit shootBullet子弹详情配置", tablex.dump(bullet))
		index = index + 1
		local hitResult = hitResult[index]
		--受击特效
		local hitEffect = 1074 --默认受击特效
		local hitEffect = (data.perfData.hitEff ~= nil and data.perfData.hitEff ~= "") and data.perfData.hitEff or hitEffect
		--射击特效
		local shootEffect = 1077 --默认攻击特效
		local shootEffect = data.perfData.shooteff or shootEffect
		local smoke = data.perfData.smoke
		---@type BulletDataJustHitCove
		local reportData = {
			index = index,		--子弹索引
			role = data.source,
			hitEffect = hitEffect,		--受击特效
			shootEffect = shootEffect,	--射击特效
			smoke = smoke,				--烟雾特效
			delay = skillDelay + bullet.delay,		--技能延迟+单个子弹延迟
			dmgDelay = bullet.dmgDelay or 0.1,		--伤害延迟
			shootPos = bullet.shoot,		--射击位置
			hitResult = hitResult,		--伤害详情
			target = data.target,
		}
		self:_DoAfter(reportData.delay, function()
			if reportData.role.destroyed or reportData.target.destroyed then
			else
				CoveShowMgr.instance():justHit(reportData, CB)
			end
		end)
	end
end

---范围攻击
---@param data PerfData
---@return number, number 表现时长
function CoveSkillPerformence:areaAttack(data, CB)
	LuaLogger.ds("CoveSkillPerformence:areaAttack roleAttack", tablex.dump(data.perfData))
	LuaLogger.ds("CoveSkillPerformence:areaAttack hitData", tablex.dump(data.hitData))
	local skillDelay = data.delay or 0
	local totalDelay = 0	--总延迟
	--受击特效
	local hitEffect = data.perfData.hitEff
	--射击特效
	local shootEffect = data.perfData.shooteff
	local smoke = data.perfData.smoke
	local perfData = data.perfData
	--目标地块
	local skillTargetBlock = data.source:getSkillTargetBlock()
	if skillTargetBlock then
		---@type BulletDataAreaAttack
		local reportData = {
			index = 1,             --子弹索引
			targetIndex = data.targetIndex, --单次技能目标索引 用于判断aoe类技能只在第一个角色地块受击时播放特效
			roleId = data.source.id,
			blockId = data.source.block.id,
			targetBlockId = self:changeBlockIdIfProtected(data.target.id),
			targetRoleId = data.target.id,
			skillTargetBlockId = skillTargetBlock.id,
			hitEffect = hitEffect, --受击特效 aoe则为选中目标点特效
			shootEffect = shootEffect, --射击特效
			smoke = smoke, --烟雾特效
			delay = skillDelay,  --技能延迟+单个子弹延迟
			beeff = perfData.beeff, --角色被击特效
			dmgDelay = perfData.dmgDelay, --角色伤害延迟
			shootPos = data.shoot --射击位置
		}
		self:_DoAfter(reportData.delay, function()
			CoveShowMgr.instance():areaAttack(reportData, CB)
		end)
	end
end

---地毯式轰炸
---@param data PerfData
---@return number, number 表现时长
function CoveSkillPerformence:PlaneBombing(data, CB)
	LuaLogger.ds("CoveSkillPerformence:PlaneBombing roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local totalDelay = 0	--总延迟
	local planeIndex = 0
	local reportList = {}
	--受击特效
	local hitEffect = data.perfData.hitEff
	local perfData = data.perfData
	--目标地块
	local skillTargetBlock = data.source:getSkillTargetBlock()
	for k, plane in pairs(data.perfData.bulletList) do
		planeIndex = planeIndex + 1
		--飞机模型
		local planeName = data.perfData.bulletModel[plane.bullet]
		--投弹命中特效
		local hitEffect = data.perfData.hitEff
		---@type BulletDataPlaneBombing
		local reportData = {
			index = planeIndex,		--飞机索引
			planeName = planeName,	--子弹预制体名
			speed = plane.speed,		--弹速
			delay = skillDelay + plane.delay,		--技能延迟+单个子弹延迟
			height = plane.height, 	--飞机飞行高度
			roleId = data.source.id,
			blockId = data.source.block.id,
			targetBlockId = self:changeBlockIdIfProtected(data.target.id),
			targetRoleId = data.target.id,
			hitEffect = hitEffect,		--受击特效
			bombDetail = plane.boomList, --投弹详情
			area = perfData.area,		--技能范围
			skillTargetBlockId = skillTargetBlock.id,--目标选中地块
			targetIndex = data.targetIndex,	--单次技能目标索引 用于判断aoe类技能只在第一个角色地块受击时播放特效
			dmgDelay = perfData.dmgDelay,	--角色伤害延迟
			shootPos = plane.shoot,			--射击位置
			allTargetList = data.allTargetList,
		}
		table.insert(reportList, reportData)
	end
	for _, report in pairs(reportList) do
		report.allPlaneNum = planeIndex
		self:_DoAfter(report.delay, function()
			CoveShowMgr.instance():areaAttack(report, CB)
		end)
	end
end


---轨道攻击
---@param data PerfData
---@return number, number 表现时长
function CoveSkillPerformence:RailAttack(data)
	LuaLogger.ds("CoveSkillPerformence:RailAttack roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local totalDelay = 0	--总延迟
	--受击特效
	local hitEffect = data.perfData.hitEff
	--射击特效
	local shootEffect = data.perfData.shooteff
	local smoke = data.perfData.smoke
	local perfData = data.perfData
	--目标地块
	local skillTargetBlock = data.source:getSkillTargetBlock()
	---@type BulletDataRailAttack
	local reportData = {
		index = 1,		--子弹索引
		targetIndex = data.targetIndex,	--单次技能目标索引
		roleId = data.source.id,
		blockId = data.source.block.id,
		targetBlockId = self:changeBlockIdIfProtected(data.target.id),
		targetRoleId = data.target.id,
		skillTargetBlockId = skillTargetBlock.id,
		hitEffect = hitEffect,		--攻击特效 攻击进行中特效
		shootEffect = shootEffect,	--射击特效
		smoke = smoke,				--烟雾特效
		delay = skillDelay,		--技能延迟+单个子弹延迟
		beeff = perfData.beeff,		--角色被击特效
		dmgDelay = perfData.dmgDelay,	--角色伤害延迟
		shootPos = perfData.shoot		--射击位置
	}
	battleMgr:getReporter():addReport(GE.BattleReportType.RailAttack, reportData)
	return totalDelay, 0
end

---直接效果 没有战报
---@param data PerfData
---@return number, number 表现时长
function CoveSkillPerformence:JustEffect(data)
	LuaLogger.ds("CoveSkillPerformence:JustEffect roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local totalDelay = 0	--总延迟
	--受击特效
	local hitEffect = data.perfData.hitEff
	--射击特效
	local shootEffect = data.perfData.shooteff
	local smoke = data.perfData.smoke
	local perfData = data.perfData
	--目标地块
	local skillTargetBlock = data.source:getSkillTargetBlock()
	local targetBlocks = data.source:getCurSkillTarget()
	local targetBlockIdList = {}
	for _, block in pairs(targetBlocks) do
		table.insert(targetBlockIdList, block.id)
	end
	---@type BulletDataJustEffect
	local reportData = {
		index = 1,		--子弹索引
		targetIndex = data.targetIndex,	--单次技能目标索引 用于判断aoe类技能只在第一个角色地块受击时播放特效
		roleId = data.source.id,
		blockId = data.source.block.id,
		-- targetBlockId = self:changeBlockIdIfProtected(data.target.id),
		targetRoleId = data.target and data.target.id,
		skillTargetBlockId = skillTargetBlock.id,
		hitEffect = hitEffect,		--受击特效 aoe则为选中目标点特效
		shootEffect = shootEffect,	--射击特效
		smoke = smoke,				--烟雾特效
		delay = skillDelay,		--技能延迟+单个子弹延迟
		beeff = perfData.beeff,		--角色被击特效
		dmgDelay = perfData.dmgDelay,	--角色受击特效延迟
		shootPos = perfData.shoot,		--射击位置
		targetBlockIdList = targetBlockIdList	--目标地格
	}
	battleMgr:getReporter():addReport(GE.BattleReportType.JustEffect, reportData)
	return totalDelay, 0
end

---舰载机攻击
---@param data PerfData
---@return number, number 表现时长
function CoveSkillPerformence:PlaneAttack(data, CB)
	LuaLogger.ds("CoveSkillPerformence:PlaneAttack roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local planeIndex = 0
	local bombIndex = 0
	local totalDelay = 0	--总延迟
	local allHitResult = data.hitData
	LuaLogger.ds("CoveSkillPerformence:PlaneAttack allHitResult", tablex.dump(allHitResult))
	--子弹列表
	for k, plane in pairs(data.perfData.bulletList) do
		LuaLogger.ds("PlaneAttack飞机详情配置", tablex.dump(plane))
		planeIndex = planeIndex + 1
		local hitResult = {}
		for _, bomb in pairs(plane.boomList) do
			bombIndex = bombIndex + 1
			table.insert(hitResult, allHitResult[bombIndex])
		end
		--飞机模型
		local planeIndex = plane.bullet
		local planeName = data.perfData.bulletModel[planeIndex]
		--投弹命中特效
		local hitEffect = data.perfData.hitEff
		---@type BulletDataPlaneAttackCove
		local reportData = {
			index = planeIndex,		--飞机索引
			planeName = planeName,	--子弹预制体名
			speed = plane.speed,		--弹速
			delay = skillDelay + plane.delay,		--技能延迟+单个子弹延迟
			height = plane.height, 	--飞机飞行高度
			hitEffect = hitEffect,		--受击特效
			hitResult = hitResult,		--伤害详情
			bombDetail = plane.boomList, --投弹详情
			type = plane.type,			--飞机类型
			shootPos = plane.shoot,		--射击位置
			role = data.source,
			target = data.target,
		}
		self:_DoAfter(reportData.delay, function()
			if reportData.role.destroyed or reportData.target.destroyed then
			else
				CoveShowMgr.instance():PlaneAttack(reportData, CB)
			end
		end)
	end
end

---鱼雷攻击
---@param data PerfData
---@return number, number 表现时长
function CoveSkillPerformence:TorpedoAttack(data, CB)
	LuaLogger.ds("CoveSkillPerformence:TorpedoAttack roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local index = 0
	local totalDelay = 0	--总延迟
	local hitResult = data.hitData
	--鱼雷列表
	for k, bullet in pairs(data.perfData.bulletList) do
		LuaLogger.ds("TorpedoAttack子弹详情配置", tablex.dump(bullet))
		index = index + 1
		local hitResult = hitResult[index]
		--鱼雷模型
		local bulletIndex = bullet.bullet
		local bulletName = data.perfData.bulletModel[bulletIndex]
			--射击特效
		local shootEffect = data.perfData.shooteff
		local smoke = data.perfData.smoke
		--受击特效
		local hitEffect = 1074 --默认受击特效
		local hitEffect = (data.perfData.hitEff ~= nil and data.perfData.hitEff ~= "") and data.perfData.hitEff or hitEffect
		---@type BulletDataTorpedoAttack
		local reportData = {
			index = index,						--子弹索引
			bulletName = bulletName,	--子弹预制体名
			speed = bullet.speed,		--弹速
			delay = skillDelay + bullet.delay,		--技能延迟+单个子弹延迟
			hitEffect = hitEffect,		--受击特效
			hitResult = hitResult,		--伤害详情
			shootPos = bullet.shoot,		--射击位置
			role = data.source,
			target = data.target,
			shootEffect = shootEffect,	--射击特效
			smoke = smoke,				--烟雾特效
		}
		self:_DoAfter(reportData.delay, function()
			if reportData.role.destroyed or reportData.target.destroyed then
			else
				CoveShowMgr.instance():TorpedoAttack(reportData, CB)
			end
		end)
	end
end

---导弹攻击
---@param data PerfData
---@return number, number 表现时长
function CoveSkillPerformence:MissileAttack(data)
	LuaLogger.ds("CoveSkillPerformence:MissileAttack roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local index = 0
	local totalDelay = 0	--总延迟
	--导弹列表
	for k, bullet in pairs(data.perfData.bulletList) do
		LuaLogger.ds("MissileAttack导弹详情配置", tablex.dump(bullet))
		index = index + 1
		--导弹模型
		local bulletIndex = bullet.bullet
		local bulletName = data.perfData.bulletModel[bulletIndex]
		--受击特效
		local hitEffect = 1074 --默认受击特效
		local hitEffect = (data.perfData.hitEff ~= nil and data.perfData.hitEff ~= "") and data.perfData.hitEff or hitEffect
		---@type BulletDataMissileAttack
		local reportData = {
			index = index,				--子弹索引
			bulletName = bulletName,	--子弹预制体名
			speed = bullet.speed,		--导弹速度
			delay = skillDelay + bullet.delay,		--技能延迟+单个子弹延迟
			roleId = data.source.id,
			blockId = data.source.block.id,
			targetBlockId = self:changeBlockIdIfProtected(data.target.id),
			targetRoleId = data.target.id,
			hitEffect = hitEffect,		--受击特效
			shootPos = bullet.shoot,	--射击位置
			height = bullet.height,		--导弹高度
		}
		battleMgr:getReporter():addReport(GE.BattleReportType.MissileAttack, reportData)
	end
	--计算表现时间

	return totalDelay, 0
end

---导弹攻击
---@param data PerfData
---@return number, number 表现时长
function CoveSkillPerformence:DroneAttack(data)
	LuaLogger.ds("CoveSkillPerformence:DroneAttack roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local index = 0
	local totalDelay = 0	--总延迟
	--导弹列表
	for k, bullet in pairs(data.perfData.bulletList) do
		LuaLogger.ds("DroneAttack导弹详情配置", tablex.dump(bullet))
		index = index + 1
		--无人机模型
		local bulletIndex = bullet.bullet
		local bulletName = data.perfData.bulletModel[bulletIndex]
		--受击特效
		local hitEffect = 1074 --默认受击特效
		local hitEffect = (data.perfData.hitEff ~= nil and data.perfData.hitEff ~= "") and data.perfData.hitEff or hitEffect
		---@type BulletDataDroneAttack
		local reportData = {
			index = index,				--子弹索引
			bulletName = bulletName,	--子弹预制体名
			speed = bullet.speed,		--无人机二段冲刺速度
			delay = skillDelay + bullet.delay,		--技能延迟+单个子弹延迟
			roleId = data.source.id,
			blockId = data.source.block.id,
			targetBlockId = self:changeBlockIdIfProtected(data.target.id),
			targetRoleId = data.target.id,
			hitEffect = hitEffect,		--受击特效
			shootPos = bullet.shoot,	--射击位置
			waitPoint = bullet.waitpoint,		--无人机悬停点位
			wait = bullet.wait,		--无人机悬停时间
			offsetx = bullet.offsetx,		--无人机二段冲刺贝赛尔曲线偏移x
			offsety = bullet.offsety,		--无人机二段冲刺贝赛尔曲线偏移y
			focus = bullet.focus,		--无人机二段冲刺贝赛尔曲线中间点
			partialEffect = data.perfData.hiteff2,--射击擦弹特效
		}
		battleMgr:getReporter():addReport(GE.BattleReportType.DroneAttack, reportData)
	end
	--计算表现时间

	return totalDelay, 0
end

---撞击攻击
---@param data PerfData
---@return number, number 表现时长
function CoveSkillPerformence:ImpactAttack(data)
	LuaLogger.ds("CoveSkillPerformence:ImpactAttack roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local index = 1
	local totalDelay = 0	--总延迟
	---@type DataImpactAttack
	local reportData = {
		index = index,			--子弹索引
		delay = skillDelay,		--技能延迟
		roleId = data.source.id,
		blockId = data.source.block.id,
		targetBlockId = self:changeBlockIdIfProtected(data.target.id),
		targetRoleId = data.target.id,
	}
	battleMgr:getReporter():addReport(GE.BattleReportType.ImpactAttack, reportData)
	--计算表现时间

	return totalDelay, 0
end


return CoveSkillPerformence