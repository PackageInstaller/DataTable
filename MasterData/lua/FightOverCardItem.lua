--2400的动效播放时间
local nextDelayTime = 200 --到下一个阶段的冷却时间
local index = 0
local teamIndex = 0

-- exp
local expBar = nil
local const_time = 0.4 -- 升级时间常量/秒
local curExp = 0
local maxExp = 0
local addExp = 0 -- 总增加量
local addExpNum = 0 -- 每帧增加的量
local addTime = 0 -- 每次增加进度条的时间
local isExpAnim = false -- 控制动效
local isStopAnim = false --关闭动效

--lv    
local oldLv = 0 --旧等级
local curLv = 0 --当前控制的等级
local upNum = 0 --升级次数

--anim
local anims = {}
local moveAnim = nil
local fadeAnim = nil
local currAnimStage = 0 --当前动画在第几阶段

--assit
local isAssit = false

--dirll
local isDirll = false

function Awake()
    expBar = ComUtil.GetCom(expSlider, "Slider")

    moveAnim = ComUtil.GetCom(node,"ActionMoveByCurve")
    fadeAnim = ComUtil.GetCom(node,"ActionFade")

    local actions = ComUtil.GetComsInChildren(gameObject, "ActionBase")
    for i = 0, actions.Length - 1 do
        table.insert(anims, actions[i])
    end
end

function Update()
    if isStopAnim then
        return
    end
    ExpBarUpdate()
end

function SetIndex(idx)
    index = idx
end

function Refresh(_teamItemData, elseData)
    data = _teamItemData;
    cardData = _teamItemData:GetCard();
    SetCard()

    addExp = elseData and elseData.exp or 0
    teamIndex = elseData and elseData.teamIndex or 0
    isDirll = elseData and elseData.isDirll

    oldLv, curExp, upNum = GetBeforCardInfo(addExp)
    if cardData:GetLv() >= cardData:GetMaxLv() and cardData:GetAssistData() == nil then
        upNum = 0
        CSAPI.SetText(txtLv, cardData:GetMaxLv() .. "")
    else
        CSAPI.SetText(txtLv, oldLv .. "")
    end

    CSAPI.SetGOActive(expObj, false)
    CSAPI.SetGOActive(favorObj, false)
    CSAPI.SetGOActive(stateObj,false)
    CSAPI.SetGOActive(assitObj,false)

    local favor = elseData and elseData.favor or 0    
    SetFavor(favor)

    isAssit = _teamItemData.index == 6
end

function SetCard()
    if grid == nil then
        ResUtil:CreateUIGOAsync("RoleLittleCard/RoleSmallCard", itemNode, function(go)
            local lua = ComUtil.GetLuaTable(go)
            lua.Refresh(cardData);
            lua.ActiveClick(false);
            CSAPI.SetGOActive(lua.txt_lv, false)
            grid = lua
        end)
    else
        grid.Refresh(cardData);
        CSAPI.SetGOActive(grid.txt_lv, false)
    end
end

-- 玩家好感度
function SetFavor(addFavor)
    local cardRoleInfo = cardData:GetCRoleData()
    if cardRoleInfo then
        local curLv, maxLv = cardRoleInfo:GetLv(), CRoleMgr:GetCRoleMaxLv()
        local str = "+" .. addFavor
        if curLv == maxLv then
            str = "MAX"
        else
            local cur, max = cardRoleInfo:GetExp()
            if cur - addFavor < 0 then
                str = LanguageMgr:GetByID(20008)
            end
        end 
        CSAPI.SetText(txtFavor, str)
    else
        CSAPI.SetText(txtFavor, "")
    end
end

-- 玩家升级动画效果
function SetExp()
    if cardData == nil then
        LogError("没有获取到卡牌数据！");
        return;
    end
    CSAPI.SetGOActive(expObj, true)
    CSAPI.SetGOActive(lvUpObj, false)

    local maxLv = cardData:GetMaxLv()
    if maxLv <= cardData:GetLv() then
        expBar.value = 1
        CSAPI.SetGOActive(txtExp, false)
        CSAPI.SetGOActive(txt_max, true)
        currAnimStage = 4
        EventMgr.Dispatch(EventType.Fight_Over_Reward, index)
    else
        CSAPI.SetGOActive(txt_max, false)
        maxExp = GetLvExp(oldLv)
        expBar.value = curExp / maxExp
        if addExp <= 0 then
            CSAPI.SetText(txtExp, "")
            currAnimStage = 4
            EventMgr.Dispatch(EventType.Fight_Over_Reward, index)
            return
        end

        curLv = oldLv
        addTime = upNum > 1 and const_time / upNum or const_time
        addExpNum = (maxExp - curExp) / addTime * Time.deltaTime
        isExpAnim = true
    end
end

function GetLvExp(lv)
    return cardData and RoleTool.GetExpByLv(lv) or 0
end

-- 返回升级前的卡牌等级和经验值
function GetBeforCardInfo(expAdd)
    local lv = cardData:GetLv();
    local exp = 0;
    local upNum = 0 -- 升级次数
    local currentExp = cardData:GetEXP();
    if currentExp >= expAdd then
        exp = currentExp - expAdd;
    else
        expAdd = expAdd - currentExp;
        while (lv > 1) do
            lv = lv - 1;
            upNum = upNum + 1
            local maxExp = RoleTool.GetExpByLv(lv)
            if expAdd > maxExp then
                expAdd = expAdd - maxExp;
            else
                exp = maxExp - expAdd;
                break
            end
        end
    end
    return lv, exp, upNum;
end

--每帧更新
function ExpBarUpdate()
    if not isExpAnim then
        return
    end
    
    if curExp >= maxExp then --升级
        RefreshExp()
        return
    end

    if addExp <= 0 then --结束
        isExpAnim = false
        FuncUtil:Call(function ()
            if gameObject and not isStopAnim then
                ExpComplete()
            end
        end, nil, nextDelayTime)
        return
    end

    addExpNum = addExp - addExpNum > 0 and addExpNum or addExp
    addExpNum = curExp + addExpNum > maxExp and maxExp - curExp or addExpNum
    addExp = addExp - addExpNum
    curExp = curExp + addExpNum
    CSAPI.SetText(txtExp, "+" .. math.floor(addExp))
    expBar.value = curExp / maxExp
end

--升级状态
function RefreshExp()
    isExpAnim = false
    curLv = curLv + 1
    CSAPI.SetText(txtLv, curLv .. "")
    local maxLv = cardData:GetMaxLv()
    if curLv >= maxLv then --满级不再变动
        CSAPI.SetGOActive(txtExp, false)
        CSAPI.SetGOActive(txt_max, true)
        return
    end

    curExp = 0
    expBar.value = 0
    maxExp = GetLvExp(curLv)
    addExpNum = (maxExp - curExp) / addTime * Time.deltaTime
    isExpAnim = true
end

--动画结束 200
function ExpComplete()
    currAnimStage = 4
    CSAPI.SetGOActive(expSlider, upNum <= 0)
    CSAPI.SetGOActive(lvUpObj, upNum > 0)
    local lvStr = LanguageMgr:GetByID(1033) or "LV."
    CSAPI.SetText(txtOldLv, lvStr.. oldLv .. "")
    CSAPI.SetText(txtNewLv, lvStr.. cardData:GetLv() .. "")
    CSAPI.SetText(txtExp, "")
    EventMgr.Dispatch(EventType.Fight_Over_Reward, index)
end

--跳过动效
function JumpToExpComplete()
    CSAPI.SetText(txtLv, cardData:GetLv() .. "")
    CSAPI.SetGOActive(expSlider, upNum <= 0)
    CSAPI.SetGOActive(lvUpObj, upNum > 0)
    if upNum <= 0 then --无升级次数
        if cardData:GetLv() >= cardData:GetMaxLv() then
            expBar.value = 1
            CSAPI.SetGOActive(txtExp, false)
            CSAPI.SetGOActive(txt_max, true)
            return
        end
        expBar.value = cardData:GetEXP() / GetLvExp(cardData:GetLv())
        CSAPI.SetText(txtExp, "")
        CSAPI.SetGOActive(txt_max, false)
    else
        local lvStr = LanguageMgr:GetByID(1033) or "LV."
        CSAPI.SetText(txtOldLv, lvStr .. oldLv .. "")
        CSAPI.SetText(txtNewLv, lvStr .. cardData:GetLv() .. "")
    end
end

---------------------------------state---------------------------------
function SetState()    
    CSAPI.SetGOActive(stateObj, true)
    local strs = StringUtil:split(data:GetID(), "_");
    local info = nil
    if strs and #strs>1 and strs[1]~="npc" then
        info=FormationUtil.GetTowerCardInfo(tonumber(strs[2]), tonumber(strs[1]),teamIndex);
    else
        info=FormationUtil.GetTowerCardInfo(data:GetID(),nil, teamIndex);
    end
    local hp,sp = 100,100
    if info then
        hp = info.tower_hp
        sp = info.tower_sp
    end
    CSAPI.SetGOActive(dead,hp <= 0)
    CSAPI.SetGOActive(stateImg,hp > 0)
    CSAPI.SetRTSize(hpObj,127 * hp / 100, 10)
    CSAPI.SetRTSize(spImg,127 * sp / 100, 4)
    EventMgr.Dispatch(EventType.Fight_Over_Reward, index)
end
---------------------------------total---------------------------------
function SetTotal()
    if isDirll then
        return
    end
    CSAPI.SetGOActive(stateObj, true)
    CSAPI.SetGOActive(stateImg,false)
    CSAPI.SetGOActive(dead,true)
    EventMgr.Dispatch(EventType.Fight_Over_Reward, index)
end

---------------------------------anim---------------------------------

--300
function PlayStartAnim(delay)
    currAnimStage = 1
    moveAnim.delay = delay
    moveAnim:Play()
    fadeAnim:Play(0,1,200,delay)
    FuncUtil:Call(function ()
        if gameObject and not isStopAnim then
            PlayFavorAnim()
        end
    end, nil, delay + 300  + nextDelayTime + 500) --多出500用于等待玩家经验条动画结束
end

--300
function PlayFavorAnim()
    local cfg = Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId())
    if cfg and cfg.type == eDuplicateType.StarPalace and isDirll then
        return
    end
    if (data == nil) or (data and data.bIsNpc) then -- NPC不加经验和好感
        EventMgr.Dispatch(EventType.Fight_Over_Reward, index)
        currAnimStage = 4
        return;
    end
    currAnimStage = 2
    CSAPI.SetGOActive(favorObj, true)
    CSAPI.SetGOActive(assitObj,isAssit)
    FuncUtil:Call(function ()
        if gameObject and not isStopAnim then
            CSAPI.SetGOActive(favorObj, false)
            PlayExpAnim()
        end
    end, nil, 300 + nextDelayTime)
end

function PlayExpAnim()
    currAnimStage = 3
    local cfg = Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId())
    if cfg and (cfg.type == eDuplicateType.NewTower or cfg.type == eDuplicateType.EternalBattle) then
        SetState()
    elseif cfg and cfg.type == eDuplicateType.StarPalace and TotalBattleMgr:IsFighting() then
        SetTotal()
    else
        SetExp()
    end
end

function JumpToComplete()
    isStopAnim = true

    if (data == nil) or (data and data.bIsNpc)  then -- NPC不加经验和好感
        currAnimStage = 4
        return;
    end
    
    if currAnimStage < 4 then
        local cfg = Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId())
        local isNewTower = cfg and (cfg.type == eDuplicateType.NewTower or cfg.type == eDuplicateType.EternalBattle)
        if isDirll then
        
        elseif isNewTower then
            SetState()
        elseif cfg and cfg.type == eDuplicateType.StarPalace and TotalBattleMgr:IsFighting() then
            SetTotal()
        else
            CSAPI.SetGOActive(expObj, true)
            JumpToExpComplete()
        end
    end

    if currAnimStage < 3 then
        CSAPI.SetGOActive(favorObj, false)
    end

    if #anims > 0 then
        for i, v in ipairs(anims) do
            if v.gameObject.activeSelf == true then
                v:SetComplete(true)
            end
        end
    end

    currAnimStage = 4
end

function IsAnimComplete()
    return currAnimStage == 4
end

function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    itemNode = nil;
    expObj = nil;
    txtAdd = nil;
    txtExp = nil;
    txtUp = nil;
    imgUp = nil;
    oldLvObj = nil;
    txtLv = nil;
    txtOldLv = nil;
    curLvObj = nil;
    txtLv = nil;
    txtCurLv = nil;
    view = nil;
end
----#End#----
