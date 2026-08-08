require "class"
---@class SkillPerformancefHandler
local SkillPerformancefHandler = class("SkillPerformancefHandler")
local BattleCore = require "BattleCore"

function SkillPerformancefHandler:ctor()
	BattleCore.ds("SkillPerfHandler ctor")
	self:_initPerformanceEvent()
end

---实例化
---@return SkillPerformancefHandler
function SkillPerformancefHandler.instance()
	if (SkillPerformancefHandler._instance == nil) then
		SkillPerformancefHandler._instance = SkillPerformancefHandler:new()
	end
	return SkillPerformancefHandler._instance
end

---初始化表现事件
function SkillPerformancefHandler:_initPerformanceEvent()
	self.performanceEvent = {
		[GE.SkillPerformanceType.ShootBullet] = self.shootBullet,
		[GE.SkillPerformanceType.JustHit] = self.justHit,
		[GE.SkillPerformanceType.AreaAttack] = self.areaAttack,
		[GE.SkillPerformanceType.JustEffect] = self.JustEffect,
		[GE.SkillPerformanceType.PlaneAttack] = self.PlaneAttack,
		[GE.SkillPerformanceType.TorpedoAttack] = self.TorpedoAttack,
		[GE.SkillPerformanceType.RailAttack] = self.RailAttack,
		[GE.SkillPerformanceType.PlaneBombing] = self.PlaneBombing,
		[GE.SkillPerformanceType.MissileAttack] = self.MissileAttack,
		[GE.SkillPerformanceType.ImpactAttack] = self.ImpactAttack,
		[GE.SkillPerformanceType.SideAttack] = self.SideAttack,
		[GE.SkillPerformanceType.DroneAttack] = self.DroneAttack,
	}
	--攻击类型转向Override 1为攻击者 2为受击者 没有k默认两者都为true
	self.faceToFaceOverride = {
		[GE.SkillPerformanceType.AreaAttack] = {false, true},	--范围攻击
		[GE.SkillPerformanceType.RailAttack] = {false, true},	--轨道攻击
	}
	self._isInit = true
end

---执行表现
---@param source any 执行技能方
---@param skinConfig table 执行技能方skin数据
---@param skillConfig table 技能数据
---@param delay number 表现延时
---@param allHitDetail allHitDetail[] 所有受击数据
---@return number, number, boolean, boolean (perfTime 表现时长, shootTime 表现射击时长, hasPerf 是否有表现, needFinalHit 是否需要最终受击表现)
function SkillPerformancefHandler:doPerformance(source, skinConfig, skillConfig, delay, allHitDetail)
	local battleMgr = BattleCore:getBattleMgr()
	local showMgr = battleMgr:getShowManager()
	if (not showMgr) then
		return 0, 0, false, false
	end
	local delay = delay or 0
	BattleCore.ds("SkillPerformancefHandler:doPerformance", tablex.dump(skillConfig))
	--去皮肤表里找对应表现
	local hasPerf = false	--是否有表现 影响最终受击表现的hp变化处理
	local needFinalHit = true	--是否需要最终受击表现
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
	---@field isfall boolean 		是否需要下落	11
	---@field hiteff2 number 		命中特效2 11
	---@field shoottyp number 		是否跟随射击炮口 默认0跟随 1不跟随 1 2用

	---@type PerfDataDetail
	local perfData = {}
	local prefDelay = 0
	--走skin表需要skillActId>0 或者走skill表
	if (skillConfig.skillActId > 0) or actid == "" then
		local timelineIndex = "skillTimeline"..actid	--特殊镜头表现
		if (targetConfig[timelineIndex] and targetConfig[timelineIndex] ~= "") then
			perfData.skillTimeline = targetConfig[timelineIndex]
		end
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
			needFinalHit = targetConfig[bulletListIndex].dmgshow == 1			--是否需要最终受击表现
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
			perfData.shoottyp = targetConfig[bulletListIndex].shoottyp or 0		--特效是否不跟随炮口 默认0跟随 1不跟随
		end
		perfData.bulletModel = source:getBulletModel()	--子弹模型
		--LuaLogger.ds("SkillPerformancefHandler:doPerformance 配置角色模型bulletModel", tablex.dump(perfData.bulletModel))
		-- self:changeBulletModelByWeapon(perfData.bulletModel, source)	--用身上的装备替换子弹模型
		--LuaLogger.ds("SkillPerformancefHandler:doPerformance 根据角色装备替换后的模型bulletModel", tablex.dump(perfData.bulletModel))
		local skillManager = BattleCore:getSkillMgr()
		perfData.area = skillManager:GetSkillEffectRangeByRole(skillConfig, source)	--技能范围
	end
	BattleCore.ds("SkillPerformancefHandler:doPerformance perfData", tablex.dump(perfData))
	--表现相关
	local perfTime = 0
	local shootTime = 0
	---@type playTimelineData
	local temp = {
		perfData = perfData,
		delay = delay,
		source = source,
		allHitDetail = allHitDetail,
	}
	--先攻击特效 独立战报 需要重置delay
	if actid2 > 2 then
		source:showEffectTipReport(1059)
		battleMgr:getReporter():packStep()
		temp.delay = 0
		delay = 0
	end
	local TimeLineIsOn = MyPrefs:GetInt(GE.LocalCustomDataKey.TimeLineIsOn, 1) --判断是否需要大招timeline
	--再播放特殊镜头 独立战报 需要重置delay
	if TimeLineIsOn == 1 then
		if self:checkTimeLine(temp) then
			temp.delay = 0
			delay = 0
		end
	end
	--面对面
	local isFaceToFace
	--temp.perfData.camera = 1 --todo 测试
	local CameraIsOn = MyPrefs:GetInt(GE.LocalCustomDataKey.CameraIsOn, 1) --判断是否需要切镜
	if temp.perfData.camera == 1 and CameraIsOn == 1 then
		isFaceToFace = self:faceToFaceAction(temp, allHitDetail, true)
	end
	--切换攻击镜头 独立战报
	self:changeAttackVcam(temp, allHitDetail, true)
	--再判断角色动作、特效
	self:checkRoleAnim(temp)
	--最后是弹道表现 炮击、雷击等 type = GE.SkillPerformanceType
	local type = perfData.skillBulletType
	--type = 10
	if self.performanceEvent[type] then
		--没有战报 特殊处理
		if type == GE.SkillPerformanceType.JustEffect then
			hasPerf = false
			local data = {
				source = source,
				target = allHitDetail[1] and allHitDetail[1].target,
				perfData = perfData,
				skillConfig = skillConfig,
				delay = prefDelay + delay,
				targetIndex = 1
			}
			perfTime, shootTime = self.performanceEvent[type](self, data)
		else
			hasPerf = true
			-- battleMgr:getReporter():packStep()
			--有目标
			if tablex.size(allHitDetail) > 0 then
				local allTargetList = nil
				if type == GE.SkillPerformanceType.PlaneBombing then
					allTargetList = {}
					for _, v in pairs(allHitDetail) do
						table.insert(allTargetList, {
							targetRoleId = v.target.id,
							targetBlockId = self:changeBlockIdIfProtected(v.target.id),
						})
					end
				end
				local targetIndex = 0
				for k, v in pairs(allHitDetail) do
					targetIndex = targetIndex + 1
					---@type PerfData
					local data = {
						source = source,
						target = v.target,
						perfData = perfData,
						skillConfig = skillConfig,
						delay = prefDelay + delay,
						hitData = v.singleHitData,
						targetIndex = targetIndex,
						allTargetList = allTargetList,
					}
					perfTime, shootTime = self.performanceEvent[type](self, data)
				end	
			else
				--无目标
				if type == GE.SkillPerformanceType.AreaAttack or 
				type == GE.SkillPerformanceType.RailAttack or
				type == GE.SkillPerformanceType.PlaneBombing
				 then
					local data = {
						source = source,
						target = allHitDetail[1] and allHitDetail[1].target,
						perfData = perfData,
						skillConfig = skillConfig,
						delay = prefDelay + delay,
						targetIndex = 1
					}
					perfTime, shootTime = self.performanceEvent[type](self, data)
				end
			end
		end
		battleMgr:getReporter():packStep()
	end
	---切回默认镜头
	--护卫表现 独立战报 归位
	-- local hasProtection = self:checkProtectAction(temp, false)
	-- if hasProtection then
	-- 	battleMgr:getReporter():packStep()
	-- 	temp.delay = 0
	-- 	delay = 0
	-- end
	self:changeAttackVcam(temp, nil, false)
	if isFaceToFace then
		self:faceToFaceAction(temp, allHitDetail, false)
	end
	return perfTime, shootTime, hasPerf, needFinalHit
end

---根据武器替换子弹模型
---@param bulletModelOrigin table 原始子弹模型
---@param battleRole BattleRole 角色
function SkillPerformancefHandler:changeBulletModelByWeapon(bulletModelOrigin, battleRole)
	local cid = battleRole.cid
	local battleMgr = BattleCore:getBattleMgr()
	local serverData = battleMgr:getHeroServerData(cid)
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

--演出表现
---@param data playTimelineData
---@return boolean 是否有特殊镜头表现
function SkillPerformancefHandler:checkTimeLine(data)
	if (data.perfData.skillTimeline) then
		self:playTimeline(data)
		return true
	end
	return false
end

--角色动作、特效
---@param data playTimelineData
function SkillPerformancefHandler:checkRoleAnim(data)
	local animName = data.perfData.skillAtkAni
	local effId = data.perfData.skillAtkEff
	data.source:showAttackAnim(data.delay, animName, effId)
end

---切换攻击镜头
---@param data playTimelineData
---@param allHitDetail? allHitDetail 所有受击数据
---@param isChange boolean 是否切换
function SkillPerformancefHandler:changeAttackVcam(data, allHitDetail, isChange)
	local CameraIsOn = MyPrefs:GetInt(GE.LocalCustomDataKey.CameraIsOn, 1)
	if data.perfData.camera ~= 1 or CameraIsOn == 0 then
		return
	end
	local targets = {}
	if (allHitDetail) then
		table.insert(targets, data.source.id)
		for k, v in pairs(allHitDetail) do
			table.insert(targets, v.target.id)
		end
	end
	data.source:changeAttackVcam(isChange, targets, data.delay)
end

--攻击者受击者面对面 无极转向
---@param data playTimelineData
---@param allHitDetail? allHitDetail 所有受击数据
---@param isChange boolean 是否切换
---@return boolean 是否有表现
function SkillPerformancefHandler:faceToFaceAction(data, allHitDetail, isStart)
	local attackRoleId = data.source.id
	local targets = {}
	if (allHitDetail) then
		for k, v in pairs(allHitDetail) do
			table.insert(targets, v.target.id)
		end
	end
	--开始阶段 若目标为自己 或者没有目标（纯表现技能） 则跳过
	if isStart and (tablex.size(targets) < 1 or targets[1] == attackRoleId) then
		return false
	end
	--默认都需要转向
	local attackNeedTurn = true
	local targetNeedTurn = true	--受击者转向
	--获取override
	local override = self.faceToFaceOverride[data.perfData.skillBulletType]
	if override then
		attackNeedTurn = override[1]
		targetNeedTurn = override[2]
	end
	local reportData = {
		id = attackRoleId,
		targetIds = targets,
		isStart = isStart,
		attackNeedTurn = attackNeedTurn,
		targetNeedTurn = targetNeedTurn,
	}
	local battleMgr = BattleCore:getBattleMgr()
	battleMgr:getReporter():addReport(GE.BattleReportType.RoleFaceToface, reportData)
	return true
end

---护卫表现
---@param targetList BattleBlock[] 受击地块列表
---@param source BattleRole 执行技能方
---@param isStart boolean true为开始 false为返回
---@param lastProtectedId number 本次技能被护卫者id 用于判断当本次护卫行动导致护卫者死亡时 被护卫的人的显隐
function SkillPerformancefHandler:checkProtectAction(source, targetList, isStart, lastProtectedId)
	-- LuaLogger.ds("SkillPerformancefHandler:checkProtectAction")
	local roleMgr = BattleCore:getBattleRoleMgr()
	local isProtected = false
	local protectedRoleId = nil
	if targetList and type(targetList) == "table" then
		for _, target in pairs(targetList) do
			--获取格子上的角色
			local role = target:tryGetRole()
			--若护卫者存活
			if role and role:getGuardRoleId() then
				isProtected = true
				protectedRoleId = role:getGuardRoleId()
				local protectedRole = roleMgr:getRole(protectedRoleId)
				---@type DataProtectAction
				local reportData = {
					roleId = role.id,
					protectedRoleId = protectedRoleId,
					blockId = role.block.id,
					protectedBlockId = protectedRole.block.id,
					sourceBlockId = source.block.id,
					isStart = isStart
				}
				local battleMgr = BattleCore:getBattleMgr()
				battleMgr:getReporter():addReport(GE.BattleReportType.ProtectAction, reportData)
			elseif not isStart and lastProtectedId then
				--若护卫者死亡
				---@type DataProtectAction
				local reportData = {
					protectedRoleId = lastProtectedId,
					isStart = false,
					isDead = true
				}
				local battleMgr = BattleCore:getBattleMgr()
				battleMgr:getReporter():addReport(GE.BattleReportType.ProtectAction, reportData)
			end
		end
	end
	return protectedRoleId
end

---根据受击目标是否正处于护卫状态来改变目标blockid
---@param roleId number 受击角色id
function SkillPerformancefHandler:changeBlockIdIfProtected(roleId)
	local roleMgr = BattleCore:getBattleRoleMgr()
	local target = roleMgr:getRole(roleId)
	if target and target:getGuardRoleId() then
		local protectedRole = roleMgr:getRole(target:getGuardRoleId())
		if protectedRole then
			return protectedRole.block.id
		end
	end
	return target.block.id
end

---尝试获取上层参数
---@param value any 当前参数
---@param upperData table 上层数据
---@return any
function SkillPerformancefHandler:tryGetUpperParam(value, upperData)
	local upperParam = upperData[value]
	if (upperParam) then
		return upperParam
	end
	return value
end

---PerformanceEvent--------------------------------------------------------------------------------------

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
function SkillPerformancefHandler:shootBullet(data)
	BattleCore.ds("SkillPerformancefHandler:shootBullet roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local index = 0
	local totalDelay = 0	--总延迟
	local battleMgr = BattleCore:getBattleMgr()
	local showMgr = battleMgr:getShowManager()
	local hitResult = {}
	if (showMgr) then
		hitResult = showMgr:ProcessHitData(data.hitData)
	end
	--子弹列表
	for k, bullet in pairs(data.perfData.bulletList) do
		BattleCore.ds("shootBullet子弹详情配置", tablex.dump(bullet))
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
		---@type BulletData
		local reportData = {
			index = index,						--子弹索引
			bulletName = bulletName,	--子弹预制体名
			speed = bullet.speed,		--弹速
			delay = skillDelay + bullet.delay,		--技能延迟+单个子弹延迟
			curve = Vector3.New(0, bullet.height, 0),		--贝赛尔曲线高度
			focus = bullet.focus,		--贝塞尔曲线中间点
			roleId = data.source.id,
			blockId = data.source.block.id,
			targetBlockId = self:changeBlockIdIfProtected(data.target.id),	--受击角色blockid
			targetRoleId = data.target.id,
			hitEffect = hitEffect,		--受击特效
			shootEffect = shootEffect,	--射击特效
			smoke = smoke,				--烟雾特效
			hitResult = hitResult,		--伤害详情
			shootPos = bullet.shoot,		--射击位置
			shoottyp = bullet.shoottyp,		--特效是否固定位置
		}
		battleMgr:getReporter():addReport(GE.BattleReportType.ShootBullet, reportData)
	end
	--计算表现时间

	return totalDelay, 0
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
function SkillPerformancefHandler:SideAttack(data)
	BattleCore.ds("SkillPerformancefHandler:SideAttack roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local index = 0
	local totalDelay = 0	--总延迟
	local battleMgr = BattleCore:getBattleMgr()
	local showMgr = battleMgr:getShowManager()
	local hitResult = {}
	if (showMgr) then
		hitResult = showMgr:ProcessHitData(data.hitData)
	end
	--子弹列表
	for k, bullet in pairs(data.perfData.bulletList) do
		BattleCore.ds("SideAttack子弹详情配置", tablex.dump(bullet))
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
			roleId = data.source.id,
			blockId = data.source.block.id,
			targetBlockId = self:changeBlockIdIfProtected(data.target.id),	--受击角色blockid
			targetRoleId = data.target.id,
			hitEffect = hitEffect,		--受击特效
			shootEffect = shootEffect,	--射击特效
			smoke = smoke,				--烟雾特效
			hitResult = hitResult,		--伤害详情
			shootPos = bullet.shoot,		--射击位置
			partialEffect = data.perfData.hiteff2,--射击擦弹特效
			offsetx = bullet.offsetx,	--子弹左右偏移
			offsety = bullet.offsety,	--子弹上下偏移
			isfall = data.perfData.isfall,	--是否需要下落
		}
		battleMgr:getReporter():addReport(GE.BattleReportType.SideAttack, reportData)
	end
	--计算表现时间

	return totalDelay, 0
end

---直接受击
---@param data PerfData
---@return number, number 表现时长
function SkillPerformancefHandler:justHit(data)
	BattleCore.ds("SkillPerformancefHandler:justHit roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local index = 0
	local totalDelay = 0	--总延迟
	local battleMgr = BattleCore:getBattleMgr()
	local battleShowManager = require "BattleShowManager"
	local hitResult = battleShowManager:ProcessHitData(data.hitData)
	--子弹列表
	for k, bullet in pairs(data.perfData.bulletList) do
		BattleCore.ds("justHit shootBullet子弹详情配置", tablex.dump(bullet))
		index = index + 1
		local hitResult = hitResult[index]
		--受击特效
		local hitEffect = 1074 --默认受击特效
		local hitEffect = (data.perfData.hitEff ~= nil and data.perfData.hitEff ~= "") and data.perfData.hitEff or hitEffect
		--射击特效
		local shootEffect = 1077 --默认攻击特效
		-- shootEffect = data.perfData.shooteff or shootEffect
		shootEffect = data.perfData.shooteff
		local smoke = data.perfData.smoke
		---@type BulletDataJustHit
		local reportData = {
			index = index,		--子弹索引
			roleId = data.source.id,
			blockId = data.source.block.id,
			targetBlockId = self:changeBlockIdIfProtected(data.target.id),
			targetRoleId = data.target.id,
			hitEffect = hitEffect,		--受击特效
			shootEffect = shootEffect,	--射击特效
			smoke = smoke,				--烟雾特效
			hitResult = hitResult,		--伤害详情
			delay = skillDelay + bullet.delay,		--技能延迟+单个子弹延迟
			dmgDelay = bullet.dmgDelay or 0.1,		--伤害延迟
			shootPos = bullet.shoot,		--射击位置
			shoottyp = bullet.shoottyp,		--特效是否固定位置
		}
		battleMgr:getReporter():addReport(GE.BattleReportType.JustHit, reportData)
	end
	return totalDelay, 0
end

---范围攻击
---@param data PerfData
---@return number, number 表现时长
function SkillPerformancefHandler:areaAttack(data)
	BattleCore.ds("SkillPerformancefHandler:areaAttack roleAttack", tablex.dump(data.perfData))
	BattleCore.ds("SkillPerformancefHandler:areaAttack hitData", tablex.dump(data.hitData))
	local skillDelay = data.delay or 0
	local totalDelay = 0	--总延迟
	local battleMgr = BattleCore:getBattleMgr()
	local battleShowManager = require "BattleShowManager"
	local hitResult = nil
	if tablex.size(data.hitData) > 0 then
		hitResult = battleShowManager:ProcessHitData(data.hitData)[1]
	end
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
			targetBlockId = data.target and self:changeBlockIdIfProtected(data.target.id),
			targetRoleId = data.target and data.target.id,
			skillTargetBlockId = skillTargetBlock.id,
			hitEffect = hitEffect, --受击特效 aoe则为选中目标点特效
			shootEffect = shootEffect, --射击特效
			smoke = smoke, --烟雾特效
			hitResult = hitResult, --伤害详情
			delay = skillDelay,  --技能延迟+单个子弹延迟
			beeff = perfData.beeff, --角色被击特效
			dmgDelay = perfData.dmgDelay, --角色伤害延迟
			shootPos = data.shoot --射击位置
		}
		battleMgr:getReporter():addReport(GE.BattleReportType.AreaAttack, reportData)
	end
	return totalDelay, 0
end

---地毯式轰炸
---@param data PerfData
---@return number, number 表现时长
function SkillPerformancefHandler:PlaneBombing(data)
	BattleCore.ds("SkillPerformancefHandler:PlaneBombing roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local totalDelay = 0	--总延迟
	local battleMgr = BattleCore:getBattleMgr()
	local battleShowManager = require "BattleShowManager"
	local hitResult = nil
	local planeIndex = 0
	local reportList = {}
	if tablex.size(data.hitData) > 0 then
		hitResult = battleShowManager:ProcessHitData(data.hitData)[1]
	end
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
			targetBlockId = data.target and self:changeBlockIdIfProtected(data.target.id),
			targetRoleId = data.target and data.target.id,
			hitEffect = hitEffect,		--受击特效
			hitResult = hitResult,		--伤害详情
			bombDetail = plane.boomList, --投弹详情
			area = perfData.area,		--技能范围
			skillTargetBlockId = skillTargetBlock.id,--目标选中地块
			targetIndex = data.targetIndex,	--单次技能目标索引 用于判断aoe类技能只在第一个角色地块受击时播放特效
			dmgDelay = perfData.dmgDelay,	--角色伤害延迟
			shootPos = plane.shoot,			--射击位置
			allTargetList = data.allTargetList,	--本次技能全部受击目标，用于领机平飞时播放防空特效
		}
		table.insert(reportList, reportData)
	end
	for _, report in pairs(reportList) do
		report.allPlaneNum = planeIndex
		battleMgr:getReporter():addReport(GE.BattleReportType.PlaneBombing, report)
	end
	return totalDelay, 0
end


---轨道攻击
---@param data PerfData
---@return number, number 表现时长
function SkillPerformancefHandler:RailAttack(data)
	BattleCore.ds("SkillPerformancefHandler:RailAttack roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local totalDelay = 0	--总延迟
	local battleMgr = BattleCore:getBattleMgr()
	local battleShowManager = require "BattleShowManager"
	local hitResult = nil
	if tablex.size(data.hitData) > 0 then
		hitResult = battleShowManager:ProcessHitData(data.hitData)[1]
	end
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
		targetBlockId = data.target and self:changeBlockIdIfProtected(data.target.id),
		targetRoleId = data.target and data.target.id,
		skillTargetBlockId = skillTargetBlock.id,
		hitEffect = hitEffect,		--攻击特效 攻击进行中特效
		shootEffect = shootEffect,	--射击特效
		smoke = smoke,				--烟雾特效
		hitResult = hitResult,		--伤害详情
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
function SkillPerformancefHandler:JustEffect(data)
	BattleCore.ds("SkillPerformancefHandler:JustEffect roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local totalDelay = 0	--总延迟
	local battleMgr = BattleCore:getBattleMgr()
	local battleShowManager = require "BattleShowManager"
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
function SkillPerformancefHandler:PlaneAttack(data)
	BattleCore.ds("SkillPerformancefHandler:PlaneAttack roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local planeIndex = 0
	local bombIndex = 0
	local totalDelay = 0	--总延迟
	local battleMgr = BattleCore:getBattleMgr()
	local battleShowManager = require "BattleShowManager"
	local allHitResult = battleShowManager:ProcessHitData(data.hitData)
	--子弹列表
	for k, plane in pairs(data.perfData.bulletList) do
		BattleCore.ds("PlaneAttack飞机详情配置", tablex.dump(plane))
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
		---@type BulletDataPlaneAttack
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
			hitResult = hitResult,		--伤害详情
			bombDetail = plane.boomList, --投弹详情
			type = plane.type,			--飞机类型
			shootPos = plane.shoot		--射击位置
		}
		battleMgr:getReporter():addReport(GE.BattleReportType.PlaneAttack, reportData)
	end
	--计算表现时间

	return totalDelay, 0
end

---鱼雷攻击
---@param data PerfData
---@return number, number 表现时长
function SkillPerformancefHandler:TorpedoAttack(data)
	BattleCore.ds("SkillPerformancefHandler:TorpedoAttack roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local index = 0
	local totalDelay = 0	--总延迟
	local battleMgr = BattleCore:getBattleMgr()
	local battleShowManager = require "BattleShowManager"
	local hitResult = battleShowManager:ProcessHitData(data.hitData)
	local shootEffect = data.perfData.shooteff
	local smoke = data.perfData.smoke
	--鱼雷列表
	for k, bullet in pairs(data.perfData.bulletList) do
		BattleCore.ds("TorpedoAttack子弹详情配置", tablex.dump(bullet))
		index = index + 1
		local hitResult = hitResult[index]
		--鱼雷模型
		local bulletIndex = bullet.bullet
		local bulletName = data.perfData.bulletModel[bulletIndex]
		--受击特效
		local hitEffect = 1074 --默认受击特效
		local hitEffect = (data.perfData.hitEff ~= nil and data.perfData.hitEff ~= "") and data.perfData.hitEff or hitEffect
		---@type BulletDataTorpedoAttack
		local reportData = {
			index = index,						--子弹索引
			bulletName = bulletName,	--子弹预制体名
			speed = bullet.speed,		--弹速
			delay = skillDelay + bullet.delay,		--技能延迟+单个子弹延迟
			roleId = data.source.id,
			blockId = data.source.block.id,
			targetBlockId = self:changeBlockIdIfProtected(data.target.id),
			targetRoleId = data.target.id,
			hitEffect = hitEffect,		--受击特效
			hitResult = hitResult,		--伤害详情
			shootPos = bullet.shoot,		--射击位置,
			shootEffect = shootEffect,	--射击特效
			smoke = smoke,				--烟雾特效
		}
		battleMgr:getReporter():addReport(GE.BattleReportType.TorpedoAttack, reportData)
	end
	--计算表现时间

	return totalDelay, 0
end

---导弹攻击
---@param data PerfData
---@return number, number 表现时长
function SkillPerformancefHandler:MissileAttack(data)
	BattleCore.ds("SkillPerformancefHandler:MissileAttack roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local index = 0
	local totalDelay = 0	--总延迟
	local battleMgr = BattleCore:getBattleMgr()
	local battleShowManager = require "BattleShowManager"
	local hitResult = battleShowManager:ProcessHitData(data.hitData)
	--导弹列表
	for k, bullet in pairs(data.perfData.bulletList) do
		BattleCore.ds("MissileAttack导弹详情配置", tablex.dump(bullet))
		index = index + 1
		local hitResult = hitResult[index]
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
			hitResult = hitResult,		--伤害详情
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
function SkillPerformancefHandler:DroneAttack(data)
	BattleCore.ds("SkillPerformancefHandler:DroneAttack roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local index = 0
	local totalDelay = 0	--总延迟
	local battleMgr = BattleCore:getBattleMgr()
	local battleShowManager = require "BattleShowManager"
	local hitResult = battleShowManager:ProcessHitData(data.hitData)
	--导弹列表
	for k, bullet in pairs(data.perfData.bulletList) do
		BattleCore.ds("DroneAttack导弹详情配置", tablex.dump(bullet))
		index = index + 1
		local hitResult = hitResult[index]
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
			hitResult = hitResult,		--伤害详情
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
function SkillPerformancefHandler:ImpactAttack(data)
	BattleCore.ds("SkillPerformancefHandler:ImpactAttack roleAttack", tablex.dump(data.perfData))
	local skillDelay = data.delay or 0
	local index = 1
	local totalDelay = 0	--总延迟
	local battleMgr = BattleCore:getBattleMgr()
	local battleShowManager = require "BattleShowManager"
	local hitResult = battleShowManager:ProcessHitData(data.hitData)

	local hitResult = hitResult[index]
	---@type DataImpactAttack
	local reportData = {
		index = index,			--子弹索引
		delay = skillDelay,		--技能延迟
		roleId = data.source.id,
		blockId = data.source.block.id,
		targetBlockId = self:changeBlockIdIfProtected(data.target.id),
		targetRoleId = data.target.id,
		hitResult = hitResult,		--伤害详情
	}
	battleMgr:getReporter():addReport(GE.BattleReportType.ImpactAttack, reportData)
	--计算表现时间

	return totalDelay, 0
end


---播放特殊镜头表现
---@class playTimelineData
---@field source BattleRole 执行技能方
---@field perfData PerfDataDetail 表现数据
---@field delay number 表现延时
---@field allHitDetail allHitDetail 所有受击数据

---@param data playTimelineData
function SkillPerformancefHandler:playTimeline(data)
	BattleCore.ds("SkillPerformancefHandler:playTimeline")
	local timeline = nil
	if (data.perfData.skillTimeline and data.perfData.skillTimeline ~= "") then
		timeline = data.perfData.skillTimeline
	end
	data.source:showAttackTimeline(data.delay, timeline)
end


return SkillPerformancefHandler