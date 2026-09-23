-- 红点管理
RedPointType = {};
RedPointType.Dungeon = "Dungeon"; -- 副本
RedPointType.Mail = "Mail"; -- 邮件
RedPointType.Shop = "Shop"; -- 商店
RedPointType.Friend = "Friend";
RedPointType.Mission = "Mission";
RedPointType.MissionTower = "MissionTower"; -- 爬塔任务
RedPointType.MissionTaoFa = "MissionTaoFa"; -- 讨伐任务
RedPointType.RoleList = "RoleList";
RedPointType.PlayerAbility = "PlayerAbility";
RedPointType.Activity = "Activity" -- 活动
RedPointType.ActivityList1 = "ActivityList1" -- 活动列表1
RedPointType.ActivityList2 = "ActivityList2" -- 活动列表2
RedPointType.ActivityList3 = "ActivityList3" -- 特别活动
RedPointType.Exploration = "Exploration" -- 勘探
RedPointType.Attack = "Attack" -- 出击
RedPointType.Bag = "Bag" -- 背包
RedPointType.Matrix = "Matrix" -- 基地
RedPointType.Create = "Create" -- 构建
RedPointType.ExerciseL = "ExerciseL"  --演习 
RedPointType.CRoleSkin = "CRoleSkin"  --角色皮肤（看板） 
RedPointType.Archive = "Archive" --档案

RedPointType.ActiveEntry1 = "ActiveEntry1"  --活动入口  拂晓之战
RedPointType.ActiveEntry2 = "ActiveEntry2"  --电影惊魂
RedPointType.ActiveEntry3 = "ActiveEntry3"  --拟真演训
RedPointType.ActiveEntry4 = "ActiveEntry4"  --迷城蛛影
RedPointType.ActiveEntry16 = "ActiveEntry16"  --宠物活动

RedPointType.MaterialBag = "MaterialBag" -- 背包
RedPointType.HeadFrame = "HeadFrame" -- 头像框
RedPointType.Head = "Head" -- 头像
RedPointType.Title = "Title" -- 称号
RedPointType.Face = "Face" -- 对战表情
RedPointType.Achievement = "Achievement" --成就
RedPointType.Regression = "Regression" --回归
RedPointType.Badge = "Badge" --徽章
RedPointType.Rogue = "Rogue" --乱序演习
RedPointType.RogueS = "RogueS" --战斗派遣
RedPointType.AccuCharge = "AccuCharge" --累计充值
RedPointType.AccuCharge2 = "AccuCharge2" --累计充值2
RedPointType.AccuCharge3 = "AccuCharge3" --累计充值2
RedPointType.Collaboration="Collaboration" --回归绑定活动
RedPointType.SpecialExploration="SpecialExploration"--特殊勘探
RedPointType.Colosseum="Colosseum"--角斗场任务
RedPointType.ActiveEntry26 = "ActiveEntry26"  --角斗场随机模式通关奖励
RedPointType.ASMR="ASMR"--
RedPointType.ResRecovery = "ResRecovery" --遗落的补给
RedPointType.RogueT = "RogueT" --
RedPointType.SectionMain = "SectionMain" --章节主线
RedPointType.SectionDaily = "SectionDaily" --章节日常
RedPointType.SectionExercise = "SectionExercise" --章节演习
RedPointType.SectionActivity = "SectionActivity" --章节活动
RedPointType.CourseView = "CourseView" --教程
RedPointType.Questionnaire = "Questionnaire" --调查问卷
RedPointType.SignInDuanWu = "SignInDuanWu" --端午签到
RedPointType.Puzzle1="Puzzle1"--拼图红点1
RedPointType.Puzzle2="Puzzle2"--拼图红点2
RedPointType.PackageDownload = "PackageDownload"; -- 分包下载
RedPointType.BuffBattle = "BuffBattle"
RedPointType.Anniversary = "Anniversary" --周年红点
RedPointType.MultTeamBattle= "MultTeamBattle" --递归沙盒
RedPointType.Coffee = "Coffee" --女仆咖啡
RedPointType.PVP = "PVP" 
RedPointType.LovePlus = "LovePlus"
RedPointType.MerryChristmas = "MerryChristmas" --圣诞活动
RedPointType.Riddle="Riddle"--猜谜
RedPointType.Halloween = "Halloween" --万圣节小游戏
RedPointType.CumulativeSpending="CumulativeSpending" --小额付费
RedPointType.RichMan="RichMan"--大富翁
RedPointType.RegressionShop="RegressionShop"--回归商店
RedPointType.SkinDeals="SkinDeals" --皮肤折扣券
RedPointType.BreakfastCard = "BreakfastCard" --早餐卡
RedPointType.SkinPass = "SkinPass" --皮肤通行证
RedPointType.MenuTheme = "MenuTheme" 
RedPointType.SkinRebate2 = "SkinRebate2" --旧皮肤返利
RedPointType.CharacterRaising = "CharacterRaising" --培养引导
RedPointType.RogueMap = "RogueMap" --秘境探索
--每日固定显示一次红点的类型
RedPointDayOnceType={}
RedPointDayOnceType.GachaBall="GachaBall"--扭蛋机
RedPointDayOnceType.GloBalBoss = "GloBalBoss" --世界boss
RedPointDayOnceType.PuzzleActivity1="PuzzleActivity1" --拼图活动类型1
RedPointDayOnceType.PuzzleActivity2="PuzzleActivity2" --拼图活动类型2
RedPointDayOnceType.SkinRebate2 = "SkinRebate2" -- 旧皮肤返利
RedPointDayOnceType.RogueMap = "RogueMap"

local this = MgrRegister("RedPointMgr")

function this:Clear()
    self.rps = nil;
    self.dayRedList=nil;
end

function this:UpdateData(rpType, data)
    self.rps = self.rps or {};
    if (self.rps[rpType] and self.rps[rpType] == data) then
        return
    end
    self.rps[rpType] = data;
    self:ApplyRefresh()
end

function this:GetData(rpType)
    return self.rps and self.rps[rpType];
end

function this:ApplyRefresh()
    if (self.applyRefresh) then
        return;
    end
    self.applyRefresh = 1;

    FuncUtil:Call(self.Refresh, self, 10);
end

function this:Refresh()
    self.applyRefresh = nil;
    EventMgr.Dispatch(EventType.RedPoint_Refresh);
end

function this:SetDayRedToday(_dayOnceType)
    self.dayRedList=self.dayRedList or {};
    if _dayOnceType then
        local stamp=TimeUtil.GetTime();
        local time = nil
        local t=TimeUtil:GetTimeHMS(stamp,"*t");
        local time2=self.dayRedList[_dayOnceType];
        if (t and t.hour<3) then--往前退12小时拿日期比较
            time=TimeUtil:GetTimeHMS((stamp-43200), "%Y:%m:%d");
        else
            time=TimeUtil:GetTimeHMS(stamp, "%Y:%m:%d")
        end
        if ((time2 and time2~=time) or time2==nil)then --3点后才记录
            self.dayRedList[_dayOnceType]=time;
            FileUtil.SaveToFile("dayRedList.txt",self.dayRedList)
        end
    end
end

--是否需要显示红点的状态，true为要显示
function this:GetDayRedState(_dayOnceType)
    if self.dayRedList==nil then
        self.dayRedList=FileUtil.LoadByPath("dayRedList.txt");
    end
    self.dayRedList=self.dayRedList or {};
    local isRed=true;
    if _dayOnceType and self.dayRedList[_dayOnceType] then --判断记录日是否和今天相同
        local stamp=TimeUtil.GetTime();
        local time = nil
        local t=TimeUtil:GetTimeHMS(stamp,"*t");
        if (t and t.hour<3) then--往前退12小时拿日期比较
            time=TimeUtil:GetTimeHMS((stamp-43200), "%Y:%m:%d");
        else
            time=TimeUtil:GetTimeHMS(stamp, "%Y:%m:%d")
        end
        if time==self.dayRedList[_dayOnceType] then
            return false;
        end
    end
    return isRed;
end

return this;
