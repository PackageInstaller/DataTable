-- 图标工具
local ResIconUtil = require "ResIconUtil";
-- 大图工具
local ResImgUtil = require "ResImgUtil";

local this = {};

-- 加载角色相关资源包
function this:LoadCharacterAbs(data, callBack)
    local modelIds = nil;
    if (type(data) == "table") then
        modelIds = data;
    else
        modelIds = {data};
    end

    local addedList = {};
    local abNames = {};

    for _, modelId in pairs(modelIds) do
        if (modelId == nil) then
            LogError("加载角色资源失败，配置无效");
        else
            if (addedList[modelId] == nil) then
                addedList[modelId] = 1;
                self:GenCharacterFightAbs(abNames, modelId);
            end
        end
    end

    --	    LogError("开始加载资源包=======");
    --	    LogError(modelIds);
    --	    LogError(abNames);
    CSAPI.LoadABsByOrder(abNames, callBack, false, false);
end

function this:GenCharacterFightAbs(arr, modelId)
    if (modelId == nil) then
        LogError("模型配置Id无效");
        return;
    end
    local cfg = Cfgs.character:GetByID(modelId);
    if (cfg == nil) then
        LogError("找不到模型配置" .. modelId);
        return;
    end
    local name = cfg.name;
    local abName = cfg.ab_name or name;

    local abCharacter = string.lower(self.abPrefix .. self.prefab_character .. "_" .. abName);
    table.insert(arr, abCharacter);

    local stateDatas = StateMgr:GetDatas(name);
    local no_eff_ab = stateDatas and stateDatas["no_eff_ab"];
    if (not no_eff_ab) then
        local abEffect = string.lower(self.abPrefix .. self.prefab_effect .. "_" .. name);
        table.insert(arr, abEffect);
        --    else    
        --        LogError(name);
    end
end

function this:GenCharacterABName(modelName)
    return string.lower(self.abPrefix .. self.prefab_character .. "_" .. modelName);
end

this.abPrefix = "prefabs_";
-- 角色prefab目录
this.prefab_character = "Characters";

function this:GenCharacterRes(res)
    return self.prefab_character .. "/" .. res;
end
-- 加载角色资源
function this:LoadCharacterRes(res, x, y, z, resParent, callBack)
    res = self:GenCharacterRes(res);
    CSAPI.CreateGOAsync(res, x, y, z, resParent, callBack);
end

-- 特效目录
this.prefab_effect = "Effects";
function this:GenEffectRes(res)
    return self.prefab_effect .. "/" .. res;
end
-- 创建特效
function this:CreateEffect(res, x, y, z, resParent, callBack)
    local low = CSAPI.GetGameLv() <= 2;
    res = self:GenEffectRes(res);
    CSAPI.CreateGOAsync(res, x or 0, y or 0, z or 0, resParent, callBack, low);
end
-- 创建特效
function this:CreateEffectImmediately(res, x, y, z, resParent)
    res = self:GenEffectRes(res);
    return CSAPI.CreateGO(res, x or 0, y or 0, z or 0, resParent);
end

--创建背景特效
function this:CreateBGEffect(name, x, y, z, resParent, callBack)
    local res = "bg" .."/" .. name .."/" .. name
    res = self:GenEffectRes(res);
    CSAPI.CreateGOAsync(res, x or 0, y or 0, z or 0, resParent, callBack);
end

-- 创建Buff特效
function this:CreateBuffEff(res, resParent, callBack,postfix)
    if (not res) then
        return;
    end

    local pathPrefix = string.find(res, "/");

    if (self.buffPathPre == nil) then
        self.buffPathPre = self.prefab_effect .. "/buff/";
    end

    if (pathPrefix) then
        res = self.prefab_effect .. "/" .. res;
    else
        res = self.buffPathPre .. res;
    end

    if(not StringUtil:IsEmpty(postfix))then
        local tmpRes = res .. "_" .. postfix;
        local low = CSAPI.GetGameLv() <= 2;
        CSAPI.CreateGOAsync(tmpRes, 0, 0, 0, resParent, function (go)
            if(IsNil(go))then
            CSAPI.CreateGOAsync(res, 0, 0, 0, resParent, callBack, low,false); 
            end    
        end, low,false);  

        --[[ CSAPI.LoadPrefab(tmpRes,function (go)
            if(go)then
                res = tmpRes;
            end
            local low = CSAPI.GetGameLv() <= 2;
            CSAPI.CreateGOAsync(res, 0, 0, 0, resParent, callBack, low,false);            
        end,false); ]]
    else
        local low = CSAPI.GetGameLv() <= 2;
        CSAPI.CreateGOAsync(res, 0, 0, 0, resParent, callBack, low,false);        
    end
end

-- 角色动态立绘目录
this.prefab_spine = "Spine";
function this:GenSpineRes(res)
    return self.prefab_spine .. "/" .. res;
end
-- 创建Spine
function this:CreateSpine(res, x, y, z, resParent, callBack)
    res = self:GenSpineRes(res);
    CSAPI.CreateGOAsync(res, x or 0, y or 0, z or 0, resParent, callBack);
end

-- 关卡障碍物目录
this.prefab_blocks = "Blocks";
function this:GenBlockRes(res)
    return self.prefab_blocks .. "/" .. res;
end
-- 创建障碍物
function this:CreateBlock(res, x, y, z, resParent)
    res = self:GenBlockRes(res);
    CSAPI.CreateGOAsync(res, x or 0, y or 0, z or 0, resParent);
end

-- 关卡障碍物目录
this.prefab_doors = "Doors";
function this:GenDoorRes(res)
    return self.prefab_doors .. "/" .. res;
end
function this:CreateDoor(res, x, y, z, resParent)
    res = self:GenDoorRes(res);
    CSAPI.CreateGOAsync(res, x or 0, y or 0, z or 0, resParent);
end

-- 关卡道具目录
-- this.prefab_props = "GridProps";
function this:GenGridPropRes(res, resDir)
    resDir = resDir or res;
    return self.prefab_props .. "/" .. resDir .. "/" .. res;
end
-- 创建关卡道具
function this:CreateGridProp(res, x, y, z, resParent, resDir, callBack)
    -- res = self:GenGridPropRes(res, resDir);
    CSAPI.CreateGOAsync(res, x or 0, y or 0, z or 0, resParent, callBack);
end

-- 视频目录
this.prefab_vedio = "MVs";
function this:GenVedioRes(res)
    return self.prefab_vedio .. "/" .. res;
end
-- 播放视频
function this:PlayVideo(res, parent)
    -- LogError("播放" .. tostring(res) .. ",parent:" .. (parent and parent.name or "nil"));

    res = self:GenVedioRes(res);
    local go = CSAPI.CreateGO(res, 0, 0, 0, parent);
    if (go ~= nil) then
        local com = ComUtil.GetCom(go, "CriMovie");

        return com;
    end

end

-- UI目录
this.ui = "UIs";
-- 大图目录
this.bigImg = "Bigs";

-- 创建UI对象
function this:CreateUIGO(res, parent, x, y, z)

    res = self.ui .. "/" .. res;
    return CSAPI.CreateGOWithParent(res, x or 0, y or 0, z or 0, parent);
end

-- 创建UI对象 异步
function this:CreateUIGOAsync(res, parent, callBack)
    res = self.ui .. "/" .. res;
    CSAPI.CreateGOAsync(res, 0, 0, 0, parent, callBack)
end

-- 创建SkillItem
function this:CreateSkillItem(parent)
    self.resSkillItem = self.resSkillItem or ("Skill/SkillItem");
    return ResUtil:CreateUIGO(self.resSkillItem, parent);
end

-- 创建物品格子
function this:CreateGridItem(parent)
    local go = nil;
    local tab = nil;
    go = ResUtil:CreateUIGO("Grid/GridItem", parent);
    tab = ComUtil.GetLuaTable(go);
    CSAPI.SetGOActive(go, true);
    CSAPI.SetScale(go, 1, 1, 1);
    return go, tab;
end

-- 创建装备格子
function this:CreateEquipItem(parent)
    local go = nil;
    local tab = nil;
    go = ResUtil:CreateUIGO("Grid/EquipItem", parent);
    tab = ComUtil.GetLuaTable(go);
    CSAPI.SetGOActive(go, true);
    CSAPI.SetScale(go, 1, 1, 1);
    return go, tab;
end

-- 创建奖励格子
function this:CreateRewardGrid(parent)
    local go = ResUtil:CreateUIGO("Grid/RewardGrid", parent);
    local item = ComUtil.GetLuaTable(go);
    CSAPI.SetGOActive(go, true);
    CSAPI.SetScale(go, 1, 1, 1);
    return go, item;
end

-- 根据GridDataBase类创建格子
function this:CreateRewardByData(data, parent)
    local item = nil;
    if data:GetClassType() ~= nil then
        local go, it = ResUtil:CreateRewardGrid(parent);
        item = it;
        item.Refresh(data);
    else
        LogError("传入的类型必须是GridDataBase和其衍生类")
    end
    return item;
end

-- 使用掉落池数据结构创建对应格子 data={id,type,num}
function this:CreateRandRewardGrid(data, parent)
    local go = nil;
    local tab = nil;
    data.type = data.type ~= nil and data.type or RandRewardType.ITEM;
    local goodsData, clickCB = GridFakeData(data)
    if goodsData ~= nil then
        tab = ResUtil:CreateRewardByData(goodsData, parent);
        if tab then
            tab.SetClickCB(clickCB);
        end
    else
        LogError("创建格子时出错！")
        LogError(data)
    end
    return tab;
end

-- 根据表奖励数据来创建格子  （例 rewards = [[10001,2,2],[10002,2,2]]）
function this:CreateCfgRewardGrids(items, rewards, parent, cb, loadSuccess)
    local _datas = {}
    for k, v in ipairs(rewards) do
        table.insert(_datas, {
            id = v[1],
            num = v[2],
            type = v[3] or RandRewardType.ITEM
        })
    end
    local datas = {}
    for k, v in ipairs(_datas) do
        local goodsData = {}
        if (v.id) then
            goodsData = GridFakeData(v)
        end
        table.insert(datas, goodsData)
    end
    local func = cb == nil and GridRewardGridFunc or cb 
    ItemUtil.AddItems("Grid/RewardGrid", items, datas, parent, func, 1, nil, loadSuccess)
end

-- 单个 根据表奖励数据来创建格子  （例 reward = [10001,2,2]）  
function this:CreateCfgRewardGrid(items, reward, parent, cb, loadSuccess)
    local _data = {
        id = reward[1],
        num = reward[2],
        type = reward[3] or RandRewardType.ITEM
    }
    local data = _data.id ~= nil and GridFakeData(_data) or {}
    local func = cb == nil and GridRewardGridFunc or cb
    if (#items>0) then
        items[1].Refresh(data)
        if (loadSuccess) then
            loadSuccess()
        end
    else
        ResUtil:CreateUIGOAsync("Grid/RewardGrid", parent, function(go)
            local item = ComUtil.GetLuaTable(go)
            table.insert(items,item)
            item.SetClickCB(func)
            item.Refresh(data)
            if (loadSuccess) then
                loadSuccess()
            end
        end)
    end
end

-- function this:CreateRandRewardGrid(data, parent)
-- 	local goodsData, clickCB = GridFakeData(data)
-- 	local item=ResUtil:CreateRewardByData(goodsData,parent);
-- 	if item then
-- 		item.SetClickCB(clickCB);
-- 	end
-- 	return item;
-- end

-- 创建人物全身立绘
function this:CreateCharacterImg(parent, modelId, cb)
    local go = ResUtil:CreateUIGO("Common/CharacterImgItem", parent.transform);
    local lua = ComUtil.GetLuaTable(go);
    if modelId then
        lua.Init(modelId, cb);
    end
    return lua;
end

function this:PreloadBigImgs_Character(imgNameArr, callBack)
    local bigImgNameArr;
    if (imgNameArr) then
        for _, imgName in ipairs(imgNameArr) do
            bigImgNameArr = bigImgNameArr or {};
            local targetName = string.format("character_%s", imgName);
            table.insert(bigImgNameArr, targetName);
        end
    end
    self:PreloadBigImgs(bigImgNameArr, callBack);
end

function this:PreloadBigImgs(bigImgNameArr, callBack)
    local addedList = {};
    local abNames = {};
    if (bigImgNameArr and #bigImgNameArr > 0) then
        for _, bigImgName in ipairs(bigImgNameArr) do
            local abName = string.format("textures_bigs_%s", bigImgName);
            abName = string.lower(abName);
            if (not addedList[abName]) then
                table.insert(abNames, abName);
                addedList[abName] = 1;
            end
        end
        CSAPI.LoadABsByOrder(abNames, callBack, false, false);
    else
        if (callBack) then
            callBack();
        end
    end

end

-- 加载大图
function this:LoadBigImg(target, res, nativeSize, callBack)
    res = self.bigImg .. "/" .. res .. ".png";
    CSAPI.LoadImg(target, res, nativeSize, callBack);
end

-- 加载大图jpg
function this:LoadBigImg2(target, res, nativeSize, callBack)
    res = self.bigImg .. "/" .. res .. ".jpg";
    CSAPI.LoadImg(target, res, nativeSize, callBack);
end

-- 加载大图jpg
function this:LoadMenuBg(target, res, nativeSize, callBack)
    res = self.bigImg .. "/" .. res;
    CSAPI.LoadImg(target, res, nativeSize, callBack);
end

function this:LoadBigSR(target, res, nativeSize, callBack)
    res = self.bigImg .. "/" .. res .. ".png";
    CSAPI.LoadSR(target, res, nativeSize, callBack);
end

function this:LoadBigSR2(target, res, nativeSize, callBack)
    res = self.bigImg .. "/" .. res .. ".jpg";
    CSAPI.LoadSR(target, res) -- , nativeSize, callBack);
end

-- 加载精灵图，自带后缀名
function this:LoadBigSR2ByExtend(target, res, nativeSize, callBack)
    res = self.bigImg .. "/" .. res;
    CSAPI.LoadSR(target, res) -- , nativeSize, callBack);
end

-- 加载大图，自带后缀名
function this:LoadBigImgByExtend(target, res, nativeSize, callBack)
    res = self.bigImg .. "/" .. res;
    CSAPI.LoadImg(target, res, nativeSize, callBack);
end

-- -- UIs/common
-- function this:LoadCommonN(target, res, nativeSize, callBack)
-- 	res = self.ui .. "/CommonN/" .. res .. ".png";
-- 	nativeSize = nativeSize == nil and true or nativeSize
-- 	CSAPI.LoadImg(target, res, nativeSize, callBack);
-- end
-- UIs/common
function this:LoadCommonNew(target, res, nativeSize, callBack)
    res = self.ui .. "/CommonNew/" .. res .. ".png";
    nativeSize = nativeSize == nil and true or nativeSize
    CSAPI.LoadImg(target, res, nativeSize, callBack);
end

-- function this:LoadNewest(target, res, nativeSize, callBack)
-- 	res = self.ui .. "/Newest/" .. res .. ".png";
-- 	nativeSize = nativeSize == nil and true or nativeSize
-- 	CSAPI.LoadImg(target, res, nativeSize, callBack);
-- end
function this:RoleSmallImg(target, res, nativeSize, callBack)
    res = self.bigImg .. "/RoleSmallImg/" .. res .. ".png";
    nativeSize = nativeSize == nil and true or nativeSize
    CSAPI.LoadImg(target, res, nativeSize, callBack);
end

function this:LoadFaceImg(target, res, nativeSize, callBack)
    res = self.ui .. "/Face/" .. res .. ".png";
    nativeSize = nativeSize == nil and true or nativeSize
    CSAPI.LoadImg(target, res, nativeSize, callBack);
end

-- 初始化
function this:Init()
    -- 图标
    self.IconCommon = ResIconUtil.New("Common");
    self.IconGoods = ResIconUtil.New("Goods");
    self.IconHead = ResIconUtil.New("Head");
    self.IconBuff = ResIconUtil.New("Buff");
    -- self.Activity = ResIconUtil.New("Activity");
    self.Ability = ResIconUtil.New("Ability"); -- 玩家能力
    self.SectionImg = ResIconUtil.New("SectionImg"); -- 章节小图
    self.IconSkill = ResIconUtil.New("Skill");
    self.ExerciseGrade = ResIconUtil.New("ExerciseGrade"); -- 演习段位
    self.RoleAppare = ResIconUtil.New("RoleAppare"); -- 皮肤
    self.RoleMech = ResIconUtil.New("RoleMech"); -- 角色兵种
    -- self.RoleCore = ResIconUtil.New("RoleCore"); --角色核心
    self.RoleSkillGrid = ResIconUtil.New("RoleSkillGrid"); -- 角色技能范围
    --self.RoleTeam = ResIconUtil.New("RoleTeam"); -- 角色小队图标
    self.StoryIcon = ResIconUtil.New("StoryIcon"); -- 角色剧情
    self.CGIcon = ResIconUtil.New("CGIcon"); -- 角色剧情
    self.EquipSkillIcon = ResIconUtil.New("EquipSkill"); -- 装备技能描述图片
    self.TeamIcon = ResIconUtil.New("Team"); -- 队伍描述图片
    self.MatrixBuilding = ResIconUtil.New("MatrixBuilding"); -- 基地
    self.LifeBuff = ResIconUtil.New("LifeBuff"); -- 生活buff
    self.ShopImg = ResIconUtil.New("Shop"); -- 商店图片
    -- self.RoleCard = ResIconUtil.New("RoleCard"); -- 卡
    -- self.RoleCard_BG = ResIconUtil.New("RoleCard_BG"); -- 卡
    -- self.CardBorder = ResIconUtil.New("CardBorder"); -- 卡框
    -- self.RoleTag = ResIconUtil.New("RoleTag")   --标签
    self.RoleTalent = ResIconUtil.New("RoleTalent") -- 天赋
    -- self.SkillIcon = ResIconUtil.New("SkillIcon")   --技能图标 （临时用）
    self.MapIcon = ResIconUtil.New("Map"); -- 地图
    self.CheckIcon = ResIconUtil.New("CheckIcon"); -- 关卡封面人物

    --卡牌、角色
    self.CardBorder = ResIconUtil.New("CardBorder"); -- 矩形、正方形卡框
    self.CRoleItem_BG =ResIconUtil.New("CRoleItem_BG")  --角色框
    self.RoleCard_BG = ResIconUtil.New("RoleCard_BG")   --上半身框
    self.CardIcon = ResIconUtil.New("RoleHead/Card_head") --上半身
    self.Card = ResIconUtil.New("RoleHead/List_head")          --矩形
    self.RoleCard = ResIconUtil.New("RoleHead/Normal_head/Normal") --正方形
    self.RoleCard2 = ResIconUtil.New("RoleHead/Normal_head/Normal2") --正方形
    self.RoleCardCustom = ResIconUtil.New("RoleHead/Normal_head"); -- 多占位头像
    self.Cast2Card = ResIconUtil.New("RoleHead/Overload_head"); -- 技能2卡牌框
    self.FightCard = ResIconUtil.New("RoleHead/Fight_head"); -- 卡牌框

    --self.CardFight = ResIconUtil.New("RoleHead/Normal_head/Normal"); -- 卡牌
    self.CardBG = ResIconUtil.New("CardBG"); -- 卡牌框
    self.RoleClamp = ResIconUtil.New("RoleTeam"); -- 角色小队图标
    
    ---self.Boss = ResIconUtil.New("Boss"); -- 卡牌框
    self.SystemOpen = ResIconUtil.New("SystemOpen"); -- 系统解锁
    self.CRoleSkill = ResIconUtil.New("CRoleSkill"); -- 卡牌角色图标
    self.BGIcon = ResIconUtil.New("BGIcon"); -- 卡牌角色图标
    self.FormationIcon = ResIconUtil.New("RoleHead/Normal_head/Normal"); -- 2D编队头像
    self.FormationIconH = ResIconUtil.New("RoleHead/Normal_head/Horizontal"); -- 2D编队头像
    self.FormationIconV = ResIconUtil.New("RoleHead/Normal_head/Vertical"); -- 2D编队头像
    self.Create = ResIconUtil.New("Create");--抽卡界面元素文件
    self.RolePos = ResIconUtil.New("RolePos");
    self.Archive = ResIconUtil.New("Archive");
    self.RoleStar = ResIconUtil.New("RoleStar")
    self.Face = ResIconUtil.New("Face")
    self.MatrixIcon = ResIconUtil.New("MatrixIcon")
    self.Infrastructure = ResIconUtil.New("Infrastructure")
    self.Theme = ResIconUtil.New("Theme")
    self.Furniture = ResIconUtil.New("Furniture")
    self.FurnitureSeize = ResIconUtil.New("FurnitureSeize")
    self.Clothes = ResIconUtil.New("Clothes")
    self.Expedition = ResIconUtil.New("Expedition");
    self.SkillBg = ResIconUtil.New("SkillBg")

    self.MultiImg = ResImgUtil.New("UIs/MultiImg") --多人插图大图
    self.MultiIcon = ResIconUtil.New("MultiIcon")  --多人插入缩列图
    self.MultBoard=ResIconUtil.New("MultBoard") --多人插入缩列图 看板

    self.MenuEnter = ResIconUtil.New("MenuEnter")  
    self.HeadFrame = ResIconUtil.New("HeadFrame")  --头像框
    self.Head = ResIconUtil.New("Head")  --头像框
    self.HeadTitle = ResIconUtil.New("HeadTitle")  --称号
    
    -- img
    self.ImgCharacter = ResImgUtil.New("Character");
    self.ModuleInfo = ResImgUtil.New("ModuleInfo");
    -- shop
    self.Commodity = ResIconUtil.New("CommdityIcon");
    self.VCommodity = ResIconUtil.New("VCommdityIcon");
    self.StoreAd = ResImgUtil.New("StoreAd");
    self.SkinMall=ResIconUtil.New("RoleSkinMall")
    self.SkinSetIcon=ResIconUtil.New("SkinSetIcon")
    self.Tag=ResIconUtil.New("Tag")
    self.StorePromote = ResImgUtil.New("UIs/ShopPromote");--商店推荐页
    --badge
    self.BadgeBg = ResIconUtil.New("Badge/BG") --徽章组背景
    self.Badge = ResIconUtil.New("Badge/Icon") --徽章图片
    --Trials
    self.TrialsList = ResIconUtil.New("Trials/List")
    self.TrialsPage = ResIconUtil.New("Trials/Page")
    self.TrialsHead = ResIconUtil.New("Trials/Head")
    --Achievement
    self.AchievementQua = ResIconUtil.New("Achievement/Quality") --成就品质
    self.Achievement = ResIconUtil.New("Achievement/Icon") --成就图标
    self.AchievementType = ResIconUtil.New("Achievement/Type") --类型
    --feast
    self.Feast = ResIconUtil.New("Feast")

    self.RogueIcon = ResIconUtil.New("RogueIcon")
    self.RogueBuff = ResIconUtil.New("RogueBuff")

    self.DungeonSummer = ResIconUtil.New("DungeonActivity/Summer") --夏日选关
    self.DungeonTaoFa = ResIconUtil.New("DungeonActivity/TaoFa") --讨伐相关
    self.DungeonNight = ResIconUtil.New("DungeonActivity/Night") --奇妙之夜
    self.DungeonCloud = ResIconUtil.New("DungeonActivity/Cloud") --云端行迹
    self.DungeonBuild = ResIconUtil.New("DungeonActivity/Build") --筑梦热土

    self.MultBoardSmall = ResIconUtil.New("MultBoardSmall") --多人看板竖图

    --Pet 宠物气泡
    self.PetEmoji=ResIconUtil.New("PetEmoji");
    self.PetIcon=ResIconUtil.New("PetIcon");

    --loveplus 爱相随
    self.LovePlusImg = ResImgUtil.New("UIs/LovePlus"); --大图
    self.LovePlus = ResIconUtil.New("LovePlus"); 
    self.LovePlusShop = ResIconUtil.New("LovePlus/Shop"); 
    self.RogueSNum = ResIconUtil.New("RogueSNum") --战力派遣

    --扭蛋
    self.GachaBall=ResIconUtil.New("GachaBall");

    self.Bgm=ResIconUtil.New("Bgm");
    self.Colosseum = ResIconUtil.New("Colosseum") --角色场小队主题

    --剧情
    self.PlotTop = ResIconUtil.New("Plot/PlotTop");
    self.ASMR=ResIconUtil.New("ASMR")

    --新世界boss
    self.GlobalBoss = ResIconUtil.New("GlobalBoss")
    self.GlobalBossInfo = ResIconUtil.New("GlobalBossInfo")

    --商店用途
    self.ASMRShop=ResIconUtil.New("AsmrShop")
    --投资方晶
    self.Investment = ResImgUtil.New("UIs/ActivityList/Investment")

    --汇总
    self.Summary = ResIconUtil.New("Summary")
    self.SummaryImg = ResImgUtil.New("UIs/Summary")
    --积分战斗
    self.BuffBattle = ResIconUtil.New("BuffBattle")

    self.HeadFace = ResIconUtil.New("HeadFace")
    --秘境探索
    self.RogueMap = ResIconUtil.New("RogueMap")
    self.RogueMapBoss = ResIconUtil.New("RogueMap/BossIcon")
    self.RogueMapBuff = ResIconUtil.New("RogueBuff/RogueMapBuff")

    self.HalfBody = ResIconUtil.New("HalfBody")

    self.Coffee = ResIconUtil.New("Coffee")

    --章节军演
    self.SectionExercise = ResImgUtil.New("UIs/Exercise/1")

    self.FightOver=ResIconUtil.New("FightOver")
    --万圣节
    self.Halloween = ResIconUtil.New("Halloween")
    --圣诞活动
    self.PetHead = ResIconUtil.New("PetHead")
    --回归活动
    self.Regression = ResIconUtil.New("Regression")
    --大富翁
    self.RichManIcon = ResIconUtil.New("RichManIcon")
    --bossbuff图标
    self.BuffChain = ResIconUtil.New("BuffChain")
    --皮肤通行证
    self.SkinPass = ResIconUtil.New("SkinPass")

	self.HaloRange=ResIconUtil.New("HaloRange")
    self.GoodsBorder = ResIconUtil.New("GoodsBorderNew");
    self.AttributeIcon=ResIconUtil.New("AttributeIcon")
    self.FesIcons = ResIconUtil.New("FesIcons");
    self.FesPool = ResIconUtil.New("FesPool");
    --专武
    self.RoleWeapon = ResIconUtil.New("RoleWeapon")
    --专武大图
    self.RoleWeaponImg = ResImgUtil.New("UIs/RoleWeaponImg")
    --吧唧
    self.Bite = ResIconUtil.New("Archive/Bite");
    self.MenuL = ResIconUtil.New("MenuL")
    self.MenuR = ResIconUtil.New("MenuR")
    self.MenuTheme = ResIconUtil.New("MenuTheme")
    --故事集
    self.StoryCollectionImg = ResImgUtil.New("UIs/StoryCollection")
    --虚数天灾
    self.VirCat = ResIconUtil.New("VirtualCataclysm");
    --周期boss
    self.BuffPeridicBoss = ResIconUtil.New("BuffPeridicBoss");
    self.PeriodicBoss = ResIconUtil.New("PeriodicBoss");
    self.PeriodicBossImg = ResImgUtil.New("UIs/PeriodicBoss")
end

return this;
