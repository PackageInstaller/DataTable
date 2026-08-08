require "class"
---@class ReportPlayer:BaseClass
local ReportPlayer = class("ReportPlayer")
local BattleCore = require "BattleCore"

function ReportPlayer:ctor()
	-- LuaLogger.ds("ReportPlayer ctor")
	self:init()
end

function ReportPlayer:init()
	self._stepCount = 0     -- 当前步骤计数
	self._maxStep = 0       -- 最大步骤数
	self._curStep = 0       -- 当前步骤
	self._finishCallback = nil -- 完成回调函数
	self._curReport = nil   -- 当前报告
	self._isPlaying = false -- 是否正在播放
	self._reportEvent = {}  -- 报告事件表
	self._isInit = false    -- 是否已初始化
	self._waitPlayList = {} -- 等待播放的列表
end

function ReportPlayer:initShowManger(showMgr)
	---@type BattleShowManager
	self._showMgr = showMgr
end

-- 初始化报告事件，将事件类型与显示管理器的方法关联
function ReportPlayer:initReportEvent()
	local showMgr = self._showMgr
	self._reportEvent = {
		[GE.BattleReportType.RoleCreate] = showMgr.roleCreate,         -- 角色创建事件
		[GE.BattleReportType.RoleRemove] = showMgr.roleRemove,         -- 角色移除事件
		[GE.BattleReportType.RoleMove] = showMgr.roleMove,             -- 角色移动事件
		[GE.BattleReportType.RoleAttack] = showMgr.roleAttack,         -- 角色攻击事件
		-- [GE.BattleReportType.RoleHit] = showMgr.roleHit,               -- 角色命中事件
		-- [GE.BattleReportType.BlockCreate] = showMgr.blockCreate,       -- 创建障碍物事件
		[GE.BattleReportType.RoleStandby] = showMgr.roleStandby,       -- 角色待命事件
		[GE.BattleReportType.AllRoleActive] = showMgr.allRoleActive,   -- 所有角色激活事件
		[GE.BattleReportType.ShowBattleStart] = showMgr.showBattleStart, -- 显示战斗开始事件
		[GE.BattleReportType.ShowBattleRound] = showMgr.showBattleRound, -- 显示战斗回合事件
		[GE.BattleReportType.ShowCurrCamp] = showMgr.showCurrCamp,     -- 显示当前阵营事件
		[GE.BattleReportType.ShowHitNumber] = showMgr.showHitNumber,   -- 显示命中数字事件
		[GE.BattleReportType.ShowEffectTip] = showMgr.showEffectTip,   -- 显示效果提示事件
		[GE.BattleReportType.RoleTurnDirection] = showMgr.roleTurnDirection, -- 角色转向事件
		[GE.BattleReportType.ShootBullet] = showMgr.shootBullet,       -- 射击子弹事件
		[GE.BattleReportType.ShowRoleHp] = showMgr.showRoleHp,         -- 显示角色血量事件
		[GE.BattleReportType.ShowTargetEffect] = showMgr.showTargetEffect, -- 显示目标效果事件
		[GE.BattleReportType.RoleTimeline] = showMgr.roleTimeline,     -- 角色时间轴事件
		[GE.BattleReportType.PlayAVG] = showMgr.playAVG,               -- 播放AVG事件
		[GE.BattleReportType.ShowDefeat] = showMgr.showDefeat,         -- 显示失败事件
		[GE.BattleReportType.RoleActive] = showMgr.roleActive,          -- 角色激活事件
		[GE.BattleReportType.RefreshHeroBuffState] = showMgr.refreshHeroBuffState,-- 刷新英雄buff状态
		[GE.BattleReportType.JustHit] = showMgr.justHit,				-- 直接命中战报
		[GE.BattleReportType.AreaAttack] = showMgr.areaAttack,			-- 范围技能直接命中战报
		[GE.BattleReportType.ChangeAttackVcam] = showMgr.changeAttackVcam,	-- 切换攻击镜头
		[GE.BattleReportType.JustEffect] = showMgr.justEffect,			-- 没有伤害的表现数据
		[GE.BattleReportType.PlaneAttack] = showMgr.PlaneAttack,			-- 舰载机攻击
		[GE.BattleReportType.TorpedoAttack] = showMgr.TorpedoAttack,			-- 鱼雷攻击
		[GE.BattleReportType.RailAttack] = showMgr.RailAttack,			-- 范围技能直接命中战报
		[GE.BattleReportType.PlaneBombing] = showMgr.PlaneBombing,			-- 地毯式轰炸
		[GE.BattleReportType.ProtectAction] = showMgr.ProtectAction,	-- 护卫
		[GE.BattleReportType.MissileAttack] = showMgr.MissileAttack,	-- 导弹
		[GE.BattleReportType.ImpactAttack] = showMgr.ImpactAttack,		-- 撞击
		[GE.BattleReportType.ShowPrepareSkillRange] = showMgr.showPrepareSkillRangeByReport, -- 显示准备技能范围
		[GE.BattleReportType.RemovePrepareSkillRange] = showMgr.removePrepareSkillRangeByReport, -- 移除准备技能范围
		[GE.BattleReportType.RoleFaceToface] = showMgr.RoleFaceToface, -- 角色释放技能时面对面表现
		[GE.BattleReportType.SmoothFollowTargetReport] = showMgr.SmoothFollowTargetReport,		-- 观察目标
		[GE.BattleReportType.LookAtBlockReport] = showMgr.LookAtBlockReport,	-- 显示技能范围
		[GE.BattleReportType.RemoveEventObjReport] = showMgr.RemoveEventObjReport,	-- 删除event对应的对象
		[GE.BattleReportType.SideAttack] = showMgr.SideAttack,			--侧翼攻击
		[GE.BattleReportType.DroneAttack] = showMgr.DroneAttack,	-- 无人机攻击
		[GE.BattleReportType.RoleOffsetMove] = showMgr.RoleOffsetMove,	-- 高度位移（下潜）
		[GE.BattleReportType.RoleMaxHpChange] = showMgr.RoleMaxHpChange, -- 角色最大血量变化
		[GE.BattleReportType.WeatherChange] = showMgr.WeatherChange, -- 天气变化
		[GE.BattleReportType.BossScoreChange] = showMgr.refreshBattleMainPanelBossScore, -- BOSS积分变化
	}
	self._isInit = true                                                -- 设置为已初始化
end

---播放报告
---@param reports table 报告列表
---@param callback function 播放完成后的回调函数
function ReportPlayer:play(reports, callback)
	BattleCore.ds("ReportPlayer:play step",tablex.dump(reports))
	local battleMgr = BattleCore:getBattleMgr()
	if (battleMgr:isVerifyMode() or not battleMgr:isBattleState() or battleMgr:IsLocalBattle()) then
		--LuaLogger.ds("ReportPlayer:play logicMode")
		if (callback) then
			callback()
		end
		return
	end
	if (not self._isInit) then
		self:initReportEvent()
	end

	-- LuaLogger.ds("ReportPlayer:play reports",#reports)
	if (self._isPlaying) then
		local reportData = {
			reports = reports,
			callback = callback
		}
		table.insert(self._waitPlayList, reportData)
		return
	end
	self._isPlaying = true
	self._curReport = reports
	self._curStep = 0
	self._finishCallback = callback
	self:nextStep()
end

function ReportPlayer:nextStep()
	-- LuaLogger.ds("ReportPlayer:nextStep",self._curStep,#self._curReport)
	self._curStep = self._curStep + 1
	if (self._curStep > #self._curReport) then
		self:playFinish()
		return
	end
	for i = self._curStep, #self._curReport do
		self:playStep(self._curReport[i])
		break
	end
end

---播放完成
function ReportPlayer:playFinish()
	self._stepCount = 0
	self._maxStep = 0

	if (self._finishCallback) then
		-- LuaLogger.ds("ReportPlayer:playFinish _finishCallback")
		self._finishCallback()
		self._finishCallback = nil
	end
	self._isPlaying = false
	self:checkWaitPlayList()
end

function ReportPlayer:insertCurrentReptor(reports)
	local index = self._curStep + 1
	table.insert(self._curReport, index, reports)
	-- self._maxStep = #self._curReport
end


---检查等待播放列表
function ReportPlayer:checkWaitPlayList()
	if (#self._waitPlayList > 0) then
		local reportData = self._waitPlayList[1]
		table.remove(self._waitPlayList, 1)
		self:play(reportData.reports, reportData.callback)
	end
end

---播放步骤
---@param stepReports table 步骤报告
function ReportPlayer:playStep(stepReports)
	BattleCore.ds("ReportPlayer:playStep allReports", tablex.dump(stepReports))
	local battleMgr = BattleCore:getBattleMgr()
	if (not battleMgr:isBattleState()) then
		return
	end
	if (not stepReports or #stepReports <= 0) then
		-- LuaLogger.ds("ReportPlayer:playStep nil")
		self:nextStep()
		return
	end

	self._stepCount = 0
	self._maxStep = #stepReports
	for i = 1, #stepReports do
		local report = stepReports[i]
		BattleCore.ds("ReportPlayer:playStep singleReport", tablex.dump(report))
		local func = self._reportEvent[report.type]
		if func then
			if (report.data.delay ~= nil and report.data.delay >= 0.001) then
				BattleCore.ds("ReportPlayer:playStep delay", report.data.delay)
				LuaAsyncMgr:Delay(report.data.delay, function()
					if (battleMgr:isBattleState()) then
						func(self._showMgr, report.data, self.stepCallback)
					end
				end)
			else
				func(self._showMgr, report.data, self.stepCallback)
			end
		else
			BattleCore.es("ReportPlayer:playStep wrong report type!")
		end
	end
end

---步骤回调
function ReportPlayer:stepCallback()
	local clientBattleMgr = ClientBattleManager.getInstance()
	local reportPlayer = clientBattleMgr:getReportPlayer()
	reportPlayer:stepContinue()
end

---步骤继续
function ReportPlayer:stepContinue()
	self._stepCount = self._stepCount + 1
	BattleCore.ds("ReportPlayer:stepContinue", self._stepCount, self._maxStep)
	if (self._stepCount >= self._maxStep) then
		self:nextStep()
	end
end

function ReportPlayer:isPlaying()
	return self._isPlaying
end

function ReportPlayer:clear()
	self:init()
end

return ReportPlayer
