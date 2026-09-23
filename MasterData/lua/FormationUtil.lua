local this = {}

this.gridSize = {230, 230}; -- 格子大小2D
this.grid3DSize = {1.88, 1.88}; -- 格子大小3D
this.gridPadding = 5; -- 格子间隔
this.grid3DPadding = 0.02; -- 格子间隔3D
this.bgIcons = {"white", "green", "blue", "purple", "yellow"}

-- 卡牌类型站位点,一个类型的卡牌所有能用的格子坐标
this.CardPos = {};
-- 占用单个格子
this.CardPos[FormationType.Single] = {{1, 1}, {1, 2}, {1, 3}, {2, 1}, {2, 2}, {2, 3}, {3, 1}, {3, 2}, {3, 3}};
-- 横向占用两个格子，父物体为右上角的格子的对齐坐标
this.CardPos[FormationType.VDouble] = {{1, 1}, {1, 2}, {2, 1}, {2, 2}, {3, 1}, {3, 2}};
-- 纵向占用两个格子，父物体为右上角的格子的对齐坐标
this.CardPos[FormationType.HDouble] = {{1, 1}, {1, 2}, {1, 3}, {2, 1}, {2, 2}, {2, 3}};
-- 占用四格
this.CardPos[FormationType.Square] = {{1, 1}, {1, 2}, {2, 1}, {2, 2}};
-- 占用三格
this.CardPos[FormationType.VThree] = {{1, 1}, {2, 1}, {3, 1}};
-- 占用三格
this.CardPos[FormationType.HThree] = {{1, 1}, {1, 2}, {1, 3}};
-- 占用2*3
this.CardPos[FormationType.VDThree] = {{1, 1}, {2, 1}}
-- 占用9
this.CardPos[FormationType.Nine] = {{1, 1}}

-- FormationType排序索引
this.FormationTypeSort = {}
this.FormationTypeSort[FormationType.Single] = 0;
this.FormationTypeSort[FormationType.HDouble] = 1;
this.FormationTypeSort[FormationType.VDouble] = 2;
this.FormationTypeSort[FormationType.Square] = 3;
this.FormationTypeSort[FormationType.HThree] = 4;
this.FormationTypeSort[FormationType.VThree] = 5;
this.FormationTypeSort[FormationType.VDThree] = 6;
this.FormationTypeSort[FormationType.Nine] = 7;

this.SkillModuleKey = "PlayerAbility";
this.AIModuleKey = "special7";

this.RaisingType={
    Gift=1,
    Skill=2,
    ChipQuality=3,
    ChipLevel=4,
    CardLevel=5,
}

this.RaisingTypeTips={
    [this.RaisingType.Gift]=15141,
    [this.RaisingType.Skill]=15140,
    [this.RaisingType.ChipQuality]=15139,
    [this.RaisingType.ChipLevel]=15138,
    [this.RaisingType.CardLevel]=15137,
}

this.RaisingTypeTips2={
    [this.RaisingType.Gift]=15147,
    [this.RaisingType.Skill]=15146,
    [this.RaisingType.ChipQuality]=15145,
    [this.RaisingType.ChipLevel]=15144,
    [this.RaisingType.CardLevel]=15143,
}

this.RaisingDailyKey="RaisingDialog";
this.RaisingDailyKey2="RaisingJumpDialog";

this.orderList = { -- 编队类型对应的配置下标
    [eTeamType.DungeonFight] = 1, -- 副本队伍列表,队伍ID是1-8
    [eTeamType.Assistance] = 1, -- 助战队伍信息，自己分享的助战卡牌列表
    [eTeamType.PracticeAttack] = 2, -- 军演练习攻击队伍
    [eTeamType.PracticeDefine] = 3, -- 军演练习防御队伍
    [eTeamType.RealPracticeAttack] = 2, -- 实时军演攻击队伍
    [eTeamType.GuildFight] = 4, -- 公会战队伍
    [eTeamType.TeamBoss] = 5, -- 组队boss队伍
    [eTeamType.Preset] = 1, -- 队伍预设索引起始值，从30开始到36
    [eTeamType.ForceFight] = 1, -- 强制上阵索引起始值
    [eTeamType.Tower]=6,
    [eTeamType.TowerDifficulty]=6,
    [eTeamType.Rogue]=6,
    [eTeamType.TotalBattle]=6,
}

-- 返回占用类型
function this.GetFormationType(gridId)
    local type = FormationType.Single;
    for k, v in pairs(FormationType) do
        if gridId == v then
            type = v;
            break
        end
    end
    return type;
end

function this.GetGridWH(type)
    local size = {0, 0};
    if type == nil or type == FormationType.Single then
        size = {1, 1}
    elseif type == FormationType.VDouble then
        size = {1, 2}
    elseif type == FormationType.HDouble then
        size = {2, 1}
    elseif type == FormationType.Square then
        size = {2, 2}
    elseif type == FormationType.HThree then
        size = {3, 1}
    elseif type == FormationType.VThree or type == FormationType.Summon then
        size = {1, 3}
    elseif type == FormationType.Nine then
        size = {3, 3}
    elseif type == FormationType.VDThree then
        size = {2, 3}
    end
    return size;
end

-- 返回格子
function this.GetGridSize(type, is3D)
    local size = {0, 0};
    local wh = this.GetGridWH(type);
    if is3D then
        size[1] = wh[1] * this.grid3DSize[1] + this.grid3DPadding * (wh[1] - 1)
        size[2] = wh[2] * this.grid3DSize[2] + this.grid3DPadding * (wh[2] - 1)
    else
        size[1] = wh[1] * this.gridSize[1] + this.gridPadding * (wh[1] - 1)
        size[2] = wh[2] * this.gridSize[2] + this.gridPadding * (wh[2] - 1)
    end
    return size;
end

function this.GetBgSize(type)
    local size = {0, 0};
    local wh = this.GetGridWH(type);
    size[1] = wh[1] * 220 + 10 * (wh[1] - 1)
    size[2] = wh[2] * 220 + 10 * (wh[2] - 1)
    return size;
end

-- 返回当前类型的格子所有占位的点
function this.GetCardCanMovePos(type)
    return this.CardPos[type] or nil;
end

-- TeamData根据FormationType进行排序
function this.SortInfoByType(a, b)
    if a.grids and b.grids then
        return this.FormationTypeSort[a.grids] > this.FormationTypeSort[b.grids];
    else
        return a.grids == nil;
    end
end

function this.LoadTipsIcon(icon, type)
    if type == 1 then -- 队长
        CSAPI.LoadImg(icon, "UIs/Formation/img_02_01.png", true, nil, true);
    elseif type == 3 then -- npc
        CSAPI.LoadImg(icon, "UIs/Formation/img_02_02.png", true, nil, true);
    elseif type == 2 then -- 支援
        CSAPI.LoadImg(icon, "UIs/Formation/img_02_02.png", true, nil, true);
    elseif type==4 then --受限的支援
        CSAPI.LoadImg(icon, "UIs/Formation/img_02_04.png", true, nil, true);
    end
end

-- 格式化助战ID
function this.FormatAssitID(fuid, cid)
    if fuid and cid then
        return string.format("%s_%s", fuid, cid);
    end
end

function this.IsFirendCardID(cid)
    local strs = StringUtil:split(cid, "_");
    if strs ~= nil and tonumber(strs[1])~=nil and #strs > 1 then
        return true
    end
    return false;
end

-- 格式化NPCID
function this.FormatNPCID(cid)
    return "npc_" .. cid;
end

-- 返回助战卡牌的CID
function this.GetAssitCID(id)
    if id then
        local strs = StringUtil:split(id, "_");
        return strs[2];
    end
    return nil;
end

-- 读取2D的头像
function this.Load2DImg(go, cfg, gridType)
    if go and cfg then
        local type = FormationUtil.GetFormationType(gridType);
        local iconName = cfg.formation_icon;
        if type == nil or type == FormationType.Single then
            ResUtil.FormationIcon:Load(go, iconName .. "_N");
        else
            if cfg.ai_icon then
                ResUtil.RoleCardCustom:Load(go, cfg.ai_icon);
            else
                if type == FormationType.VDouble then
                    ResUtil.FormationIconV:Load(go, iconName .. "_V");
                elseif type == FormationType.HDouble then
                    ResUtil.FormationIconH:Load(go, iconName .. "_H");
                elseif type == FormationType.Square then
                    ResUtil.FormationIcon:Load(go, "Horizontal_10/" .. iconName .. "_H10");
                elseif type == FormationType.Nine then
                    ResUtil.RoleCardCustom:Load(go, "Horizontal_12/" .. iconName .. "_H12");
                elseif type == FormationType.HThree then
                    ResUtil.RoleCardCustom:Load(go, "Horizontal_9/" .. iconName .. "_H9");
                elseif type == FormationType.Summon or type == FormationType.VThree then
                    ResUtil.RoleCardCustom:Load(go, "Vertical_6/" .. iconName .. "_V6");
                elseif type == FormationType.VDThree then
                    ResUtil.RoleCardCustom:Load(go, "Vertical_13/" .. iconName .. "_V13");
                end
            end
        end
    end
end

---判断当前卡牌是否是NPC,并返回对应的key和id
---@param cid any
function this.CheckNPCID(cid)
    if cid then
        local strs = StringUtil:split(cid, "_");
        if strs and #strs>1 then
            if (tonumber(strs[1])~=nil) then
                return false,strs[1],strs[2];
            else
                return true,strs[1],strs[2];
            end
        end
    end
    return false,cid;
end

-- 查找队伍中的卡牌数据
function this.FindTeamCard(cid)
    if cid then
        local strs = StringUtil:split(cid, "_");
        if strs ~= nil and #strs > 1 then
            if strs[1] == "npc" then -- npc卡牌
                return this.FindNPC(tonumber(strs[2]));
            else
                local sectionId=TowerMgr:GetSectionId();
                -- 助战卡牌id
                return FriendMgr:GetAssistCardData(cid,sectionId);
            end
        else
            -- 正常的卡牌id
            return RoleMgr:GetData(cid);
        end
    end
    return nil;
end

function this.FindNPC(cid)
    if cid then
        local cardCfg = Cfgs.MonsterData:GetByID(cid)
        if cardCfg == nil then--or (cardCfg and cardCfg.numerical == nil) then
            return nil;
        end
        local newSkillDatas = {}
        local curSkillsID = cardCfg.jcSkills
        for i, v in ipairs(curSkillsID) do
            local cfg = Cfgs.skill:GetByID(v)
            table.insert(newSkillDatas, {
                id = curSkillsID[i],
                exp = 0,
                type = SkillMainType.CardNormal
            })
        end
        -- 被动技能
        local sSkillID = cardCfg.tfSkills and cardCfg.tfSkills[1] or nil
        table.insert(newSkillDatas, {
            id = sSkillID,
            exp = 0,
            type = SkillMainType.CardTalent
        })
        --特殊技能
        local tSkillID = cardCfg.tcSkills and cardCfg.tcSkills[1] or nil
        if(tSkillID)then 
            table.insert(newSkillDatas, {
                id = tSkillID,
                exp = 0,
                type = SkillMainType.CardSpecial
            })
        end 
        local newInfo = {};
        newInfo.cid = this.FormatNPCID(cid) -- 自定义NPC的id
        newInfo.cfgid = cid
        newInfo.break_level = cardCfg.break_level or 1
        newInfo.intensify_level = 1
        newInfo.level = cardCfg.level or 1;
        newInfo.skills = newSkillDatas;

        local monsterCardsData = require "MonsterCardsData"
        newData = MonsterCardsData(newInfo)
        return newData;
    end
    return nil;
end

function this.GetPlaceHolderInfo(grids)
    local placeHolderInfo = nil;
    if grids ~= nil then
        local cfgFormation = Cfgs.MonsterFormation:GetByID(grids);
        if (cfgFormation) then
            placeHolderInfo = {};
            for _, v in ipairs(cfgFormation.coordinate) do
                table.insert(placeHolderInfo, {v[1] + 1, v[2] + 1});
            end
        else
            LogError("MonsterFormation找不到占位数据" .. grids);
        end
    else
        placeHolderInfo = {{1, 1}};
    end
    return placeHolderInfo;
end

-- 计算卡牌受到的光环加成,teamData:TeamData,item:TeamItemData,队员数据,row,col:阵型坐标，不传的话读取item中的row和col
function this.CountHaloGet(teamData, item, row, col)
    -- 遍历当前队伍中的所有卡牌光环坐标，记录其中包含该坐标的信息
    local infos = {};
    if item then
        row = row == nil and item.row or row;
        col = col == nil and item.col or col;
        local coord = FormationUtil.GetPlaceHolderInfo(item:GetGrids());
        for k, v in ipairs(teamData.data) do
            local haloCfg = nil;
            local halo = v:GetHaloInfo();
            --当前光环的加成
            local attrDatas = nil;
            local coordinate = nil;
            if halo then
                haloCfg = halo:GetCfg();
                coordinate = halo:GetCurCoordPos()
                attrDatas =HaloUtil.CountHaloAddtion(halo, v:GetCard(), nil, nil, nil, nil);
            end
            if haloCfg and coordinate and v.cid ~= item:GetID() and attrDatas then
                local node = coordinate[1];
                for i = 2, #coordinate do
                    local r = coordinate[i][1] - node[1] + v.row;
                    local c = coordinate[i][2] - node[2] + v.col;
                    -- 屏蔽自身的光环效果
                    local isAdd = false;
                    for key, val in ipairs(coord) do
                        local isAddClass = false; -- 是否是生效的小队
                        for _, val1 in ipairs(haloCfg.nClass) do
                            if val1 == 0 or val1 == item:GetCfg().nClass then
                                isAddClass = true;
                                break
                            end
                        end
                        if r == row + val[1] - 1 and c == col + val[2] - 1 and isAddClass then
                            -- 受到加成
                            for k1, v1 in ipairs(attrDatas) do
                                local attrCfg = v1.cfg;
                                if attrCfg then
                                    local num = v1.addtiveNum or 0;
                                    infos[attrCfg.id] = infos[attrCfg.id] or {
                                        val1 = 0
                                    };
                                    infos[attrCfg.id].id = v1.cfg.id; -- 属性类型
                                    infos[attrCfg.id].val1 = infos[attrCfg.id].val1 + num;
                                end
                            end
                            isAdd = true;
                            break
                        end
                    end
                    if isAdd then
                        break
                    end
                end
            end
        end
    end
    local gets = {};
    for k, v in pairs(infos) do
        table.insert(gets, v);
    end
    table.sort(gets, function(a, b)
        return a.id < b.id;
    end);
    return gets;
end


function this.GetHaloGridColor(type)
    -- 设置当前格子颜色，1：空置，2：被占用，3：buff效果,4:非点击物效果,5：可以放置,6:无法放置，7：当前选中角色
    local color = {255, 255, 255, 0};
    if type == 1 or type == nil then
    elseif type == 2 or type == 4 then
        color = {255, 255, 255, 51};
    elseif type == 3 then
        color = {255, 170, 0, 51};
    elseif type == 5 then
        color = {19, 255, 46, 51}
    elseif type == 6 then
        color = {255, 20, 20, 51}
    elseif type == 7 then
        color = {255, 255, 255, 51}
    end
    return color;
end

function this.GetHalo2DGridColor(type)
    -- 设置当前格子颜色，1：空置，2：被占用，3：buff效果,4:非点击物效果,可以放置,6:无法放置7：当前选中角色
    local color = {255, 255, 255, 255};
    if type == 1 or type == nil then
    elseif type == 2 or type == 4 then
        color = {255, 255, 255, 255};
    elseif type == 3 then
        color = {255, 170, 0, 255};
    elseif type == 5 then
        color = {96, 255, 103, 255}
    elseif type == 6 then
        color = {255, 50, 50, 255}
    elseif type == 7 then
        color = {255, 255, 255, 255}
    end
    return color;
end

function this.GetHalo2DBorderColor(type)
    -- 设置当前格子边框颜色，1：空置，2：被占用，3：buff效果,4:非点击物效果,可以放置,6:无法放置7：当前选中角色
    local color = {255, 255, 255, 255};
    if type == 1 or type == nil then
    elseif type == 2 or type == 4 then
        color = {255, 255, 255, 0};
    elseif type == 3 then
        color = {255, 193, 70, 76};
    elseif type == 5 then
        color = {96, 255, 103, 76}
    elseif type == 6 then
        color = {255, 11, 11, 76}
    elseif type == 7 then
        color = {255, 255, 255, 0}
    end
    return color;
end

function this.GetHaloNumColor(type)
    -- 设置当前上的数字颜色，1：空置，2：被占用，3：buff效果,4:非点击物效果,5：位置上已存在卡牌,6:无法放置
    local color = {255, 255, 255, 0};
    if type == 1 or type == nil then
        color = {255, 255, 255, 128};
    elseif type == 2 or type == 4 or type == 6 then
        color = {0, 0, 0, 204};
    elseif type == 3 or type == 5 then
        color = {255, 255, 255, 204};
    end
    return color;
end

function this.LookCard(cid)
    if cid == nil then
        LogError("查看卡牌信息时传入的卡牌id为nil！");
        return
    end
    local cardData = this.FindTeamCard(cid);
    if cardData == nil then
        LogError("找不到对应的卡牌数据！");
        return
    end
    local assistInfo = cardData.data and cardData.data.assist or nil;
    if assistInfo then
        if assistInfo.isFull then -- 已经获取了card数据
            CSAPI.OpenView("RoleInfo", cardData)
        else
            local curId = cardData:GetID()
            local strs = StringUtil:split(curId, "_");
            if strs then
                FriendMgr:SetAssistInfos(tonumber(strs[1]), {tonumber(strs[2])}, function()
                    cardData = this.FindTeamCard(curId);
                    assistInfo.isFull = true;
                    CSAPI.OpenView("RoleInfo", cardData)
                end);
            end
        end
    else
        -- local openType=RoleInfoOpenType.Normal;
        -- if this.CheckNPCID(cid) then
        -- 	openType=RoleInfoOpenType.LookOther
        -- end
        -- CSAPI.OpenView("RoleInfo", cardData,openType)
        CSAPI.OpenView("RoleInfo", cardData)
    end
end

-- 创建属性的方法 list:数据,itemList:存储对象的数组,parent：父节点
function this.CreateAttrs(list, itemList, parent, showName)
    local num = 1;
    for k, v in ipairs(list) do
        local tab = nil;
        local data = {};
        data.id = v.id;
        if v.id ~= 4 then -- 除速度外所有加成以百分比显示
            data.val = string.match(v.val1 * 100, "%d+") .. "%";
        else
            data.val = v.val1;
        end
        data.hideName = not showName;
        if num > #itemList then
            -- 创建item
            ResUtil:CreateUIGOAsync("AttributeNew2/AttributeItemMini", parent, function(go)
                tab = ComUtil.GetLuaTable(go);
                tab.Refresh(data);
                table.insert(itemList, tab);
            end);
        else
            tab = itemList[num];
            CSAPI.SetGOActive(tab.gameObject, true);
            tab.Refresh(data);
        end
        num = num + 1;
    end
    for i = num, #itemList do
        CSAPI.SetGOActive(itemList[i].gameObject, false);
    end
end

-- 计算两个矩形相交形成的新矩形的宽，高，不相交则返回0 minOffset:矩形左下角的点坐标，maxOffset:矩形右上角的点坐标
function this.CountInterSize(minOffsetA, maxOffsetA, minOffsetB, maxOffsetB)
    -- 相交区域的宽高
    local minOffsetC = {math.max(minOffsetA[1], minOffsetB[1]), math.max(minOffsetA[2], minOffsetB[2])};
    local maxOffsetC = {math.min(maxOffsetA[1], maxOffsetB[1]), math.min(maxOffsetA[2], maxOffsetB[2])};
    if minOffsetC[1] > maxOffsetC[1] or minOffsetC[2] > maxOffsetC[2] then
        return 0, 0;
    else
        local width = maxOffsetC[1] - minOffsetC[1];
        local height = maxOffsetC[2] - minOffsetC[2];
        -- Log(minOffsetC[1].."\t"..minOffsetC[2].."\t"..maxOffsetC[1].."\t"..maxOffsetC[2]);
        -- Log(width.."\t"..height);
        return width, height;
    end
end

-- Debug查看判定范围
function this.DrawMatix2D(min, max, gameObject)
    local a = gameObject.transform:TransformPoint(UnityEngine.Vector3(min[1], max[2], 0));
    local b = gameObject.transform:TransformPoint(UnityEngine.Vector3(min[1], min[2], 0));
    local c = gameObject.transform:TransformPoint(UnityEngine.Vector3(max[1], max[2], 0));
    local d = gameObject.transform:TransformPoint(UnityEngine.Vector3(max[1], min[2], 0));
    DrawLine(a, b);
    DrawLine(a, c);
    DrawLine(b, d);
    DrawLine(c, d);
end

--- func 根据队伍ID返回配置方案下标
---@param index 队伍索引
function this.GetOrderByTeamIndex(index)
    local type = TeamMgr:GetTeamType(index)
    if this.orderList[type]~=nil then
        return this.orderList[type];
    elseif index==61 then
        return nil;
    else
        return 6;
    end
end

function this.GetTowerCardInfo(cid,uid,teamIndex)
    local sId=7001
    if teamIndex==eTeamType.TowerDifficulty then
        sId=7002;
    elseif teamIndex == eTeamType.EternalBattle  then
        sId = 23001
    end
    return TowerMgr:GetCardInfo(cid,uid,sId);
end

-- 删除耐久度为0的队员（爬塔用）
function this.CleanDeathTowerMember(teamData,sectionID)
    if teamData ~= nil then
        local removeIDs = {}
        for i = 1, 6 do
            local item = teamData:GetItemByIndex(i);
            if item ~= nil then
                local cardInfo = nil;
                local cardData = item:GetCard();
                if item:IsAssist() then
                    local assistData = cardData:GetAssistData()
                    cardInfo = this.GetTowerCardInfo(cardData:GetData().old_cid, assistData.uid,teamData:GetIndex());
                else
                    cardInfo = this.GetTowerCardInfo(cardData:GetID(),nil,teamData:GetIndex());
                end
                if cardInfo ~= nil and cardInfo.tower_hp <= 0 then
                    table.insert(removeIDs, item:GetID())
                end
            end
        end
        if removeIDs and #removeIDs > 0 then
            for k, v in ipairs(removeIDs) do
                teamData:RemoveCard(v);
            end
        end
    end
end

--删除无法使用的队员
function this.CleanTotalBattleMember(teamData)
    if teamData ~= nil then
        local removeIDs = {}
        for i = 1, 6 do
            local item = teamData:GetItemByIndex(i);
            if item ~= nil then
                local isRemove=TotalBattleMgr:IsShowCard(item:GetID());
                if isRemove~=true then
                    table.insert(removeIDs, item:GetID())
                end
            end
        end
        if removeIDs and #removeIDs > 0 then
            for k, v in ipairs(removeIDs) do
                teamData:RemoveCard(v);
            end
        end
    end
end

function this.GetDefaultName(teamIndex,name)
    local teamName = name;
    local teamType = TeamMgr:GetTeamType(teamIndex);
    if teamType == eTeamType.Rogue then
        teamName = LanguageMgr:GetByID(50028);
    elseif teamType==eTeamType.TotalBattle then
        teamName = LanguageMgr:GetByID(51007);
    elseif teamType == eTeamType.Tower or teamType==eTeamType.TowerDifficulty then
        teamName = LanguageMgr:GetByID(49021);
    elseif teamType==eTeamType.Colosseum or teamType==(eTeamType.Colosseum+1) then
        teamName = LanguageMgr:GetByID(64047)
    elseif teamType==eTeamType.RogueT then
        teamName = LanguageMgr:GetByID(54053)
    elseif teamType==eTeamType.MultBattle then
        teamName = LanguageMgr:GetByID(77038)
    elseif teamType==eTeamType.PVP then
        teamName = LanguageMgr:GetByID(90006+(teamIndex-62))
    elseif teamType==eTeamType.PVPFriend then
        teamName = LanguageMgr:GetByID(90006+(teamIndex-65))
    elseif teamType==eTeamType.EternalBattle then
        teamName = LanguageMgr:GetByID(312021)
    elseif teamType==eTeamType.CrossBoss then
        teamName = LanguageMgr:GetByID(380061, teamIndex - teamType + 1)
    elseif teamType==eTeamType.PeriodBoss then
        teamName = LanguageMgr:GetByID(76223)
    elseif teamName==nil or teamName=="" then
        teamName = string.format(LanguageMgr:GetTips(14017), teamIndex)
    end
    return teamName;
end

--返回强制上阵卡牌配置ID
function this.GetNForceID(forceCfg)
    local nForceID=nil;
    if forceCfg==nil then
        return nForceID;
    end
    local cfg=Cfgs.CardData:GetByID(forceCfg.nForceID);
	if cfg and cfg.role_tag=="lead" and forceCfg.bIsNpc~=true then --队长需要另外判断
		local nForceID=forceCfg.nForceID;
		if RoleMgr:IsSexInitCardIDs(nForceID) then--判断当前卡牌是否是主角卡，是的话替换为当前性别的对应卡牌ID
			nForceID=RoleMgr:GetCurrSexCardCfgId();
		end
    elseif forceCfg.bIsNpc==true then
        if #forceCfg.nForceID==1 then
            nForceID=forceCfg.nForceID[1]
        else
            local idx=PlayerClient:GetSex();
            nForceID=forceCfg.nForceID[idx];
        end
    end
    return nForceID;
end

--检查培养度并返回结果 teamList={TeamData,TeamData,...},cfg=养成值要求表
function this.CheckRaising(teamList,cfg)
    if teamList==nil or (teamList and next(teamList)==nil)or cfg==nil then
        return nil
    end
    local infos={};
    local lessGiftID,lessSkillID,lessChipQualityID,lessChipLevelID,lessCardLevelID,lessNumGift,lessNumSkill,lessNumChipQuality,lessNumChipLevel,lessNumCardLevel=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil;
    for k, v in ipairs(teamList) do
        if v:GetRealCount()<5 and infos.lessMemberID==nil then
            infos.lessMemberID=v:GetIndex();
        end
        local info=v:GetRaisingInfo();
        if info then
            infos.info=infos.info or {}
            infos.info.numGift=(infos.info.numGift or 0)+(info.numGift or 0)
			infos.info.numSkill=(infos.info.numSkill or 0)+(info.numSkill or 0)
			infos.info.numChipQuality=(infos.info.numChipQuality or 0)+(info.numChipQuality or 0)
			infos.info.numChipLevel=(infos.info.numChipLevel or 0)+(info.numChipLevel or 0)
			infos.info.numCardLevel=(infos.info.numCardLevel or 0)+(info.numCardLevel or 0)
            if lessNumGift==nil or (lessNumGift and lessNumGift>info.lessNumGift) then
				lessNumGift=info.lessNumGift;
				lessGiftID=info.lessGiftID
			end
			if lessNumSkill==nil or (lessNumSkill and lessNumSkill>info.lessNumSkill) then
				lessNumSkill=info.lessNumSkill;
				lessSkillID=info.lessSkillID;
			end
			if lessNumChipQuality==nil or (lessNumChipQuality and lessNumChipQuality>info.lessNumChipQuality) then
				lessNumChipQuality=info.lessNumChipQuality;
				lessChipQualityID=info.lessChipQualityID;
			end
			if lessNumChipLevel==nil or (lessNumChipLevel and lessNumChipLevel>info.lessNumChipLevel) then
				lessNumChipLevel=info.lessNumChipLevel;
				lessChipLevelID=info.lessChipLevelID;
			end
			if lessNumCardLevel==nil or (lessNumCardLevel and lessNumCardLevel>info.lessNumCardLevel) then
				lessNumCardLevel=info.lessNumCardLevel;
				lessCardLevelID=info.lessCardLevelID;
			end
        end
    end
    if infos.info==nil then
        return infos;
    end
    infos.info.lessNumGift=lessNumGift or 0;
    infos.info.lessGiftID=lessGiftID;
    infos.info.lessNumSkill=lessNumSkill or 0;
    infos.info.lessSkillID=lessSkillID;
    infos.info.lessNumChipQuality=lessNumChipQuality or 0;
    infos.info.lessChipQualityID=lessChipQualityID;
    infos.info.lessNumChipLevel=lessNumChipLevel or 0;
    infos.info.lessChipLevelID=lessChipLevelID;
    infos.info.lessNumCardLevel=lessNumCardLevel or 0;
    infos.info.lessCardLevelID=lessCardLevelID;
    --计算各项最低的养成值的百分比差值
    if cfg then
        --各项最低的能力值
        if cfg.numGift>infos.info.numGift then
            infos.numGift=cfg.numGift and math.floor((cfg.numGift-(lessNumGift or 0))/cfg.numGift*100) or 0;
        else
            infos.numGift=0;
        end
        if cfg.numSkill>infos.info.numSkill then
            infos.numSkill=cfg.numSkill and math.floor((cfg.numSkill-(lessNumSkill or 0))/cfg.numSkill*100) or 0;
        else
            infos.numSkill=0;
        end
        if cfg.numChipQuality>infos.info.numChipQuality then
            infos.numChipQuality=cfg.numChipQuality and math.floor((cfg.numChipQuality-(lessNumChipQuality or 0))/cfg.numChipQuality*100) or 0;
        else
            infos.numChipQuality=0;
        end
        if cfg.numChipLevel>infos.info.numChipLevel then
            infos.numChipLevel=cfg.numChipLevel and math.floor((cfg.numChipLevel-(lessNumChipLevel or 0))/cfg.numChipLevel*100) or 0;
        else
            infos.numChipLevel=0;
        end
        if cfg.numCardLevel>infos.info.numCardLevel then
            infos.numCardLevel=cfg.numCardLevel and math.floor((cfg.numCardLevel-(lessNumCardLevel or 0))/cfg.numCardLevel*100) or 0;
        else
            infos.numCardLevel=0;
        end
        -- 打开培养引导UI
        local jumpView = nil;
        local cardID = nil; -- 培育的卡牌ID
        --判断打开的UI类型
        if infos.numGift>0 or  infos.numSkill>0 or infos.numChipLevel>0 or infos.numChipQuality>0 or infos.numCardLevel>0 then
            local max=0;
            if infos.numGift>infos.numSkill then
                max=infos.numGift;
                jumpView=this.RaisingType.Gift;
                cardID=infos.info.lessGiftID
            elseif infos.numSkill>0 then
                max=infos.numSkill;
                jumpView=this.RaisingType.Skill;
                cardID=infos.info.lessSkillID
            end
            if infos.numChipQuality>max then
                max=infos.numChipQuality
                jumpView=this.RaisingType.ChipQuality;
                cardID=infos.info.lessChipQualityID
            end
            if infos.numChipLevel>max then
                max=infos.numChipLevel
                jumpView=this.RaisingType.ChipLevel;
                cardID=infos.info.lessChipLevelID
            end
            if infos.numCardLevel>max then
                max=infos.numCardLevel
                jumpView=this.RaisingType.CardLevel;
                cardID=infos.info.lessCardLevelID
            end
        end
        infos.raisingType=jumpView; --需要优先培养的类型
        infos.targetCardID=cardID;--培养的目标卡牌
    end
    return infos;
end

--打开跳转的培养引导界面 result:CheckRaising返回的数据结构 disMemberCond:是否不检测玩家人数
function this.OpenRaisingView(result,dungeonCfg,disMemberCond,openSetting)
    -- LogError(result)
    if result and next(result) ~= nil then
        if result.lessMemberID and disMemberCond~=true then
            -- 提示人数不足
            -- LogError("人数不足！")
            CSAPI.OpenView("RaisingDialog",{result,dungeonCfg},openSetting);
            -- local dialogdata = {}
            -- dialogdata.content = "当前编队人数不满5人，是否前往编队？";
            -- dialogdata.dailyKey="DungeonRaisingTeam"
            -- dialogdata.okCallBack = function()
            --         EventMgr.Dispatch(EventType.Team_Raising_GoTeamView,result.lessMemberID);
            -- end
            -- CSAPI.OpenView("Dialog", dialogdata)
            do return end;
        end
        if result.raisingType ~= nil then
            CSAPI.OpenView("RaisingJumpDialog",{result,dungeonCfg},openSetting);
            -- local dialogdata = {}
            -- dialogdata.content = string.format("当前%s较低，是否仍要继续挑战？",tostring(result.raisingType));
            -- dialogdata.dailyKey="DungeonRaising"
            -- dialogdata.okCallBack = function()
            --     EventMgr.Dispatch(EventType.Team_Raising_GoBattle,dungeonCfg.id);
            -- end
            -- dialogdata.cancelCallBack=function()
            --     -- LogError("跳转到："..tostring(result.raisingType))
            --     local cardData=RoleMgr:GetData(result.targetCardID);
            --     if cardData==nil then
            --         LogError("未找到对应卡牌数据："..tostring(result.targetCardID))
            --         do return end
            --     end
            --     result.raisingType=jumpId
            --     CSAPI.OpenView("RoleInfo",cardData);
            --     if result.raisingType==this.RaisingType.Gift then
            --         CSAPI.OpenView("RoleCenter",{cardData},"talent");
            --     elseif result.raisingType==this.RaisingType.Skill then
            --         local newSkillDatas = cardData:GetSkillsForShow()
            --         CSAPI.OpenView("RoleCenter",{cardData,newSkillDatas[1].id},"skill");
            --     elseif result.raisingType==this.RaisingType.ChipQuality or result.raisingType==this.RaisingType.ChipLevel then
            --         CSAPI.OpenView("RoleEquip",{
            --             card = cardData
            --         });
            --     elseif result.raisingType==this.RaisingType.CardLevel then  
            --         CSAPI.OpenView("RoleUpBreak",cardData);
            --     end
            -- end
            -- CSAPI.OpenView("Dialog", dialogdata)
        end
    end
end

--assistCard:TeamItemData  判定助战卡是否受到限制
function this.CheckAssitCardIsLimit(assistCard)
    local isLimit=false;
    local code=CSAPI.RegionalCode();
    if CSAPI.IsADV() and code==3 and assistCard:IsNPC()~=true then
    -- if assistCard:IsNPC()~=true then
        local teamIdx=TeamMgr:GetAssistTeamIndex(assistCard:GetID())
        if teamIdx then
            local team=TeamMgr:GetTeamData(teamIdx,true)
            if assistCard:GetLv()>team:GetMemberMaxLv() then
                isLimit=true;
            end
        end
    end
    return isLimit;
end

return this;
