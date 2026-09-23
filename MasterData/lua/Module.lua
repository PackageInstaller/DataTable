--��������Ϣ
_G.PlayerClient = require "PlayerClient";

_G.ChannelWebUtil=require "ChannelWebUtil";

_G.GridDataBase = require "GridDataBase";
_G.GridObjectData = require "GridObjectData";
_G.HaloData=require "HaloData"
_G.HaloEnum=require "HaloEnum"
_G.HaloCoordinate=require "HaloCoordinate"
_G.HaloLockCondition=require "HaloLockCondition"
_G.HaloUtil=require "HaloUtil"
_G.CharacterCardsData = require "CharacterCardsData"
_G.MonsterCardsData = require "MonsterCardsData"

--提示
_G.GShowTipor = require "GShowTipor";
_G.TipsData = require "TipsData";
_G.TipsMgr = require "TipsMgr";

--关卡数据
_G.SectionData = require "SectionData";--章节
_G.DungeonData = require "DungeonData";--副本
_G.DungeonGroupData = require "DungeonGroupData"; --副本
_G.DungeonBoxData = require "DungeonBoxData"; --副本星级
_G.DungeonOpenInfo = require "DungeonOpenInfo";--活动副本开启信息

--base64
_G.Base64=require "Base64"
--文件工具类
_G.FileUtil = require "FileUtil";

--Exp工具类
_G.ExpBar = require "ExpBar";
_G.SVCenterDrag=require "SVCenterDrag"

_G.FriendInfo = require "FriendInfo"

--排序类
_G.EquipSortUtil = require "EquipSortUtil";
_G.AssistSortUtil = require "AssistSortUtil";

--掉落物品
_G.RewardUtil = require "RewardUtil";

--����
-- _G.BagMgr = require "BagMgr";
--��Ʒ����
_G.GoodsData = require "GoodsData";
--��ɫ��Ʒ����
_G.CharacterGoodsData = require "CharacterGoodsData";

--关卡信息工具类
_G.DungeonUtil = require "DungeonUtil"
_G.DungeonInfoUtil = require "DungeonInfoUtil"
_G.DungeonInfoNameUtil = require "DungeonInfoNameUtil"


--战场信息工具类
_G.BattleFieldUtil = require "BattleFieldUtil"
--释放管理
require "ReleaseMgr"
require "ABMgr"
--战棋
require "MapTranslatorClient"
require "BattleMgr"

--require("GCalculatorHelp")
require("GComLogicCheck");

_G.TeamItemData = require "TeamItemData"
_G.TeamData = require "TeamData"
_G.FormationTable = require "FormationTable"
_G.TeamCondition=require "TeamCondition"
_G.TeamLimitCondition=require "TeamLimitCondition"
_G.TeamLimitGroup=require "TeamLimitGroup"
_G.TeamLimit=require "TeamLimit"

--��ɹ�����
_G.FormationUtil = require "FormationUtil";
--������ݹ�����
-- _G.TeamMgr = require "TeamMgr";
-- _G.AIStrategyMgr=require "AIStrategyMgr"
_G.CardAIPreset=require "CardAIPreset"
_G.CardSkillPreset=require "CardSkillPreset"
_G.TeamConfirmUtil = require "TeamConfirmUtil"
_G.GridUtil = require "GridUtil"
require "EquipCalculator"
--装备
_G.StuffArray = require "StuffArray";
_G.EquipCommon = require "EquipCommon";
-- _G.EquipInfoItem=require "EquipInfoItem";
_G.EquipData = require "EquipData";
-- _G.EquipMgr = require "EquipMgr";
--商城
_G.ShopPageData = require "ShopPageData"
_G.ShopCommFunc = require "ShopCommFunc"
_G.CommodityData = require "CommodityData"
_G.ShopSkinInfo=require "ShopSkinInfo"
_G.RandCommodityData = require "RandCommodityData"
_G.ShopPromote=require "ShopPromote"
-- _G.ShopMgr = require "ShopMgr"
_G.VoucherInfo=require "VoucherInfo"

--剧情
require "PlotMgr"

--公会战
_G.GuildFightData = require "GuildFightData"
_G.GuildRoomData = require "GuildRoomData"
--指挥官战术
_G.TacticsMgr = require "TacticsMgr"
_G.TacticsData = require "TacticsData"

--勘探
_G.ExplorationData=require "ExplorationData"
_G.ExplorationRewardInfo=require "ExplorationRewardInfo"

--通用属性计算
_G.CardCalculator = require "CardCalculator"	

--场景管理
_G.SceneMgr = require "SceneMgr";

----------------------------------------------------------------------
--管理器中心
_G.MgrCenter = require "MgrCenter"


--设置
-- _G.SettingMgr = require "SettingMgr"

--结算封装工具
_G.FightOverTool = require "FightOverTool"

--简易进度条工具
require "Bar"

--简易时间计算工具
require "TimeBase"

require "GuideMgr"
--require "RedPointMgr"

require "RecordMgr"

--剧情
_G.PlotData = require("PlotData")
_G.PlotOption = require("PlotOption");
_G.RoleImgInfo = require("RoleImgInfo");
_G.StoryData = require("StoryData");
_G.PlotTween = require("PlotTween")

--左侧栏动画工具
require "LItemAnimTools" 

--动画曲线枚举
_G.AnimaCurveEnum=CS.AnimCurveEnum;

--基地角色管理工具
require "MatrixRoleTool"

--头像框 
_G.HeadFrameData = require "HeadFrameData";
--头像
_G.HeadIconData = require "HeadIconData";
--成就
_G.AchievementData = require "AchievementData"
_G.AchievementListData = require "AchievementListData"
_G.AchievementChangeInfo = require "AchievementChangeInfo"

--爬塔
_G.TowerData = require "TowerData"

--徽章
_G.BadgeData = require "BadgeData"
_G.BadgeChangeInfo = require "BadgeChangeInfo"

--道具池
_G.ItemPoolInfo=require "ItemPoolInfo"
_G.ItemPoolGoodsInfo=require "ItemPoolGoodsInfo"
require "ItemPoolEnum"

--回归绑定
_G.CollaborationInfo=require "CollaborationInfo"

--宠物活动
_G.PetInfo=require "PetInfo"
_G.PetArchiveInfo=require "PetArchiveInfo"
_G.PetArchiveRewardInfo=require "PetArchiveRewardInfo"
_G.PetFeedRewardInfo=require "PetFeedRewardInfo"
_G.PetItemData=require "PetItemData"
_G.PetRandomRewardInfo=require "PetRandomRewardInfo"
_G.PetSportInfo=require "PetSportInfo"
require "PetEnum"
_G.PetStateBase=require "PetStateBase"
_G.PetEatState=require "PetEatState"
_G.PetSleepState=require "PetSleepState"
_G.PetIdelState=require "PetIdelState"
_G.PetWashState=require "PetWashState"
_G.PetCleanState=require "PetCleanState"
_G.PetPlayState=require "PetPlayState"
_G.PetWalkState=require "PetWalkState"
_G.PetSportState=require "PetSportState"
_G.PetMoveState=require "PetMoveState"
_G.PetFSMSystem=require "PetFSMSystem"

--特殊勘探活动
_G.SpecialExplorationData=require "SpecialExplorationData"

require "SpineTools"

--版本检测
require "VerChecker";

--爱相随
_G.LovePlusStoryData = require "LovePlusStoryData";

--拼图奖池
_G.PuzzleEnum=require "PuzzleEnum"
_G.PuzzleFragment=require "PuzzleFragment"
_G.PuzzleInfo=require "PuzzleInfo"
_G.PuzzleRowRewardInfo=require "PuzzleRowRewardInfo"
_G.PuzzleCommodity=require "PuzzleCommodity"

--text滚动工具
require "LuaTextMove"
--递归沙盒
require "MultTeamBattleEnum"
_G.MultTeamBattleInfo=require "MultTeamBattleInfo"

--秘境探索格子副本
require "RogueMapBattleMgr"
_G.RogueMapSupData=require "RogueMapSupData"
_G.RogueMapLogData=require "RogueMapLogData"

--猜谜活动
_G.RiddleActivityInfo=require "RiddleActivityInfo"
_G.RiddleInfo=require "RiddleInfo"

--大富翁活动
_G.RichManEnum=require "RichManEnum"
_G.RichManGridEvent=require "RichManGridEvent"
_G.RichManGridInfo=require "RichManGridInfo"
_G.RichManMapInfo=require "RichManMapInfo"
_G.RichManInfo=require "RichManInfo"
_G.RichManActionQueue=require "RichManActionQueue"
_G.RichManActionBase=require "RichManActionBase"
_G.RichManMoveAction=require "RichManMoveAction"
_G.RichManFullRoundAction=require "RichManFullRoundAction"
_G.RichManRandRewardAction=require "RichManRandRewardAction"
_G.RichManRandEventAction=require "RichManRandEventAction"
_G.RichManTpAction=require "RichManTpAction"
_G.RichManRandTweenAction=require "RichManRandTweenAction"
_G.RichManUtil=require "RichManUtil"

--小额付费
_G.CumulativeSpendingInfo=require "CumulativeSpendingInfo"

--皮肤通行证
_G.SkinPassData = require "SkinPassData"

-- UI计时管理器
_G.UITimer=require "UITimer"
_G.UITimerMgr=require "UITimerMgr"

--连续累充
_G.GoldenRebateInfo=require "GoldenRebateInfo"

--星辉回溯
_G.SkinRebate2Data = require "SkinRebate2Data"

--新角色培养引导
_G.CharacterRaisingInfo=require "CharacterRaisingInfo"

--虚数天灾
_G.VirCatNodeData = require "VirtualCataclysmNodeData" --节点数据
_G.VirCatSaveData = require "VirtualCataclysmSaveData" --存档数据
