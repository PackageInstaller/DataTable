--管理器中心
require "MgrBase"

--注册名称(必填)
local mgrNames = {
	"RoleABMgr",
	"MenuBuyMgr",  --充值弹窗
	"RedPointMgr",  --红点管理
	"DungeonMgr",	--副本
	"DungeonActivityMgr", --活动副本
	"SignInMgr",    --签到
	"ActivityMgr",  --活动
	"CRoleMgr",     --卡牌角色
	"RoleSkinMgr",  --皮肤
	"ExerciseMgr",  --演习
	"ExerciseRMgr", --PVP
	"FriendMgr",    --好友
	"PlayerMgr",    --玩家
	--"CoolMgr",      --热值冷却
	"CreateMgr",    --角色工厂
	"MailMgr",      --邮件
	--"MissionMgr",   --任务
	"JumpMgr",      --跳转
	"RoleMgr",      --卡牌
	"RoleSkillMgr", --卡牌技能
	"PlayerAbilityMgr", --玩家能力
	"MatrixMgr",   --基地
	"RoleAudioPlayMgr", --角色音效播放管理
	"BattleFieldMgr",     --世界boss
	"WorldBossMgr",
	"ChatMgr",
	"TeamMgr",		--编队
	"HeadFaceMgr",
	"BagMgr",		--背包
	"ShopMgr",		--商城
	"EquipMgr",		--装备
	"GuildMgr",		--公会
	"GuildFightMgr",--公会战
	--"TeamBossMgr",--组队boss
    "DormMgr",    --宿舍
	"DormPetMgr",
	"ArchiveMgr",   --图鉴
	"SweepMgr",  --扫荡
	"DungeonBoxMgr", --副本星级
	"SpecialGuideMgr", --特殊引导

	"MenuMgr", --主界面相关(需要先收到关卡数据)
	"AIStrategyMgr",--AI预设
	"FavourMgr",--好感度
	"MulPicMgr",--好感度
	"SortMgr",
	"SDKPayMgr",--SDK支付
	"HeadFrameMgr",
	"HeadIconMgr",
	
	"AchievementMgr", --成就
	"TowerMgr", --新爬塔
	"BadgeMgr", --徽章
	"RegressionMgr", --回归相关
	"ItemPoolActivityMgr",--道具池相关
	"RogueMgr",
	"TotalBattleMgr", --十二星宫
	"AccuChargeMgr", --累计充值
	"CollaborationMgr",--回归绑定
	"PetActivityMgr",--宠物管理类
	"CRoleDisplayMgr", --看板
	"LovePlusMgr", --爱相随
	"RogueSMgr",   --战力派遣
	"BGMMgr",
	"ColosseumMgr",
	"HeadTitleMgr",
	"ASMRMgr",
	"GlobalBossMgr", --新世界boss
	"RogueTMgr",
	"ExplorationMgr",--勘探
	"PuzzleMgr",--拼图
	"GoldenRebateMgr",--连续充值
	"OperationActivityMgr", --运营活动
	"QuestionnaireMgr", --问卷
	"ActivityPopUpMgr", --活动界面弹出
	"BuffBattleMgr", --积分战斗
	"RogueMapMgr", --秘境探索
	"AnniversaryMgr", --周年活动
	"MultTeamBattleMgr",--递归沙盒
	"CoffeeMgr",
	"RiddleMgr",
	"PopupPackMgr",
	"HalloweenMgr", --万圣节小游戏
	"MerryChristmasMgr", --圣诞活动
	"RichManMgr",--大富翁
    "PhysicalRewardMgr", --实物抽奖
	"DungeonTeamReplaceMgr", --推荐阵容
	"CumulativeSpendingMgr",--小额付费
	"SkinDealsMgr",--皮肤折扣券
	"TrialsMgr", --历战
	"MenuThemeMgr",
	"CharacterRaisingMgr", --角色养成引导
	"VirtualCataclysmMgr", --虚数天灾
	"PeriodicBossMgr", -- 周期boss
	"RankMgr", --排行榜
	"MissionMgr",   --任务  --------------------------------------必须放到最后}
	"SilentDownloadManager"
}

local this = {
	datas = {}  --管理类字典
}

--==============================--
--desc:注册管理类
--time:2019-09-03 02:22:40
--@_name:
--@return 
--==============================--
function MgrRegister(_name)
	if(StringUtil:IsEmpty(_name)) then
		LogError("name is nil")
		return {}
	end
	local result = oo.class(MgrBase)
	this.datas[_name] = result
	return result
end

--==============================--
--desc: 初始化所有管理类
--time:2019-09-03 11:31:00
--@args:
--@return 
--==============================--
function this:Init()
	-- for k, v in pairs(self.datas) do
	-- 	v:Init()
	-- end
	for i, v in ipairs(mgrNames) do
		if(self.datas[v]) then 
			self.datas[v]:Init()
		end 
	end
end

--清空管理器数据
function this:Clear()
	for k, v in pairs(self.datas) do
		v:Clear()
	end
end

--==============================--
--desc: 获取管理类
--time:2019-09-03 02:45:39
--@key:
--@return
--==============================--
function this:GetData(key)
	return self.datas[key]
end

--==============================--
--desc:获取所有管理类
--time:2019-09-03 11:30:06
--@return 
--==============================--
function this:GetDatas()
	return self.datas
end

--初始化脚本
function this:InitAll()
	for i, v in ipairs(mgrNames) do
		_G[v] = require(v)
	end
end
this:InitAll()

return this 