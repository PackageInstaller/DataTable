

--角色列表排序
RoleListOrderType = {Up = 1, Down = 2}

--角色排序筛选记录key（排序筛选在不同的入口有不同的表现）
RoleListType = {}
RoleListType.Normal = 1          --正常   界面：RoleListNormal     
RoleListType.Cool = 2           --选择冷却    
RoleListType.TalentUp = 3        --主天赋升级
RoleListType.Support = 4        --主天赋升级
RoleListType.Select = 5          --编队选择界面
RoleListType.Resolve = 6          --分解
RoleListType.Expedition = 7          --远征
RoleListType.Center = 8          --中心

--up成功类型
RoleUpSuccessType = {}
RoleUpSuccessType.Up = 1
RoleUpSuccessType.Restructure = 2
RoleUpSuccessType.Break = 3

--加载立绘\l2d的位置
LoadImgType = {}
LoadImgType.Main = {0, 0, 1} -- 主界面 
LoadImgType.RoleInfo = {0, 0, 1} -- 角色详情
LoadImgType.RoleApparel = {0, 0, 1} -- 换肤 
LoadImgType.RoleUpBreak = {-220, 0, 1} -- 升级/突破
LoadImgType.Archive = {-180, 0, 1} -- 图鉴
LoadImgType.ExerciseLView = {0, 0, 1} -- 模拟演习左
LoadImgType.Shop = {-300, 50, 0.85} -- 商店
LoadImgType.SkinFull={-100,0,1}--皮肤信息
LoadImgType.SkinReward={200,50,1}--皮肤展示
LoadImgType.CreateShowView = {322, 0, 1.06} -- 抽卡


--白，绿，蓝，紫，橙（黄），红
ImgColorCode = {"DCDCDC", "9BD518", "17B8D5", "A30CE0", "D2A017", "D02820"}
CardStarBgName =  {"7b7b7b7", "12f7b3", "12c4f7", "6b69f0", "ffc146"}

--卡牌更新类型
CardUpdateType = {}
CardUpdateType.CardRenameRet = 1    --改名
CardUpdateType.CardLockRet = 2      --上锁，解锁
CardUpdateType.CardUpgradeRet = 3   --升级
--CardUpdateType.CardIntensifyRet = 4 --强化
CardUpdateType.CardBreakRet = 5     --越升
CardUpdateType.CardSkillUpgradeRet = 6       --技能升级   (完成后有红点)
CardUpdateType.CardSkillUpgradeFinishRet = 7 --技能升级完成 
CardUpdateType.MainTalentUpgrade = 6         --主天赋升级 
CardUpdateType.MainTalentUpgradeRet = 7      --主天赋升级完成 
CardUpdateType.DataUpdate = 8                --某数据更新
CardUpdateType.CoreUpgrade = 9               --核心升级
CardUpdateType.Weapon = 10               --专武

--roleinfo 界面打开类型
RoleInfoOpenType = {}
RoleInfoOpenType.RoleListNormal = 1
-- RoleInfoOpenType.LookSelf = 1  --查看自己的卡（根据是否战斗中，对按钮进行显示或隐藏）
-- RoleInfoOpenType.LookOther = 2 --查看别人的卡 
RoleInfoOpenType.LookNoGet = 3 --查看未获得的卡 
--RoleInfoOpenType.Normal = 1    --常规的查看  角色列表进来的，可进行常规操作（非战斗时）