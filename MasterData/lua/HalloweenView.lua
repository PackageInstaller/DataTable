local cfg = nil
local screenData = {1609, 1027}
local isContinue = false
local isTimeEnd = false
local isDeadEnd = false
local isQuitEnd = false
local openViewTime = 0
local stageDatas = nil
local currStage = nil
local nextStageTime = 0
local oldNum = nil
local startTime = 3
-- top
local hp, maxHp = 0, 0
local hpGos = {}
local timeTab = nil
local curEndTime, maxEndTime, curTime = 0, 0, 0
local triggerCount, triggerMaxCount = 0, 0
local rewardTime,rewardMaxTime = 0,0
local rewardSlider = nil
local score = 0
local isLittleTime = false
-- 玩家
local player = nil
local playerPosY = 0
local isLeftMove = false
local isRightMove = false
local posX = 0
local moveSpeed = 1000 * Time.deltaTime
-- 掉落物
local itemInfo = nil
local maxPercent = 0
local percents = nil
local itemPool = {}
local items = {}
local itemCreateTime = 0
local itemCreateTargetTime = 0
local itemCreateSpaceTime = 1
local itemCount,maxItemCount = 0,5
local getItemsInfo = {}
--panel
local scaleData = {
    2400,1080
}
local isHalloween = false

function Awake()
    table.insert(hpGos,hpItem.gameObject)
    rewardSlider = ComUtil.GetCom(sliderReward,"Slider")

    CSAPI.SetGOActive(clickMask,false)
    CSAPI.SetGOActive(overObj,false)

    isHalloween = gameObject.name == "HallwoeenView"

    InitAnim()
end

function OnInit()
    local viewName = isHalloween and "Halloween" or "SpringFestival"
    top=UIUtil:AddTop2(viewName, topParent, OnClickBack)
    CSAPI.SetGOActive(top.btn_home, false)
end

function Update()
    UpdateTest()
    if stageDatas == nil or not isContinue or CheckIsEnd() then
        return
    end
    UpdateGameTime()
    if startTime then
        return
    end
    if isTimeEnd then
        CSAPI.PlayTempSound(GetBGMName(6))
        PlayEnd()
        return
    end
    UpdateStage()
    UpdateRewardTime()
    UpdateItems()
    UpdateMove()
    UpdateItemMove()
end

function OnDestroy()
    CSAPI.SetGOActive(top.btn_home, true)
    -- CSAPI.PlayBGM("Halloween_music_01", 50)
end

function OnOpen()
    CSAPI.StopBGM()
    if isContinue then
        return
    end
    openViewTime = TimeUtil:GetTime()
    cfg = Cfgs.CfgHalloweenLevel:GetByID(data)
    if cfg then
        InitPanel()
        PlayStart()
    end
end

function InitPanel()
    ToLog("",true)
    ToLog("初始化界面")
    InitScale()
    InitTime()
    InitReward()
    InitStage()
    InitPlayer()
    InitTopPanel()
end

function PlayStart()
    ToLog("游戏开始")
    isContinue = true
end

function InitScale()
    local size = CSAPI.GetRealRTSize(node)
    local offset1 = size[0] / scaleData[1]
    local offset2 = size[1] / scaleData[2]
    local offset = offset1 < offset2 and offset1 or offset2
    CSAPI.SetScale(scaleRoot,offset,offset,1)
end

--游戏结束
function PlayEnd(isClose)
    CSAPI.StopTempSound(GetBGMName(5))
    ToLog(string.format("游戏结束,用时：%s,实际用时：%s",curTime,TimeUtil:GetTime() - openViewTime))
    local info = {
        score = score,
        begTime = openViewTime,
        gameTime = math.floor(curTime),
        rightNum = getItemsInfo[1] or 0,
        wrongNum = getItemsInfo[2] or 0,
        timeNum = getItemsInfo[3] or 0,
        gameRet = isDeadEnd and 2 or 1,
    }
    info.gameRet = isQuitEnd and 3 or info.gameRet
    OperateActiveProto:GetHalloweenGameReward(info)
    if isClose then
        CloseView()
    else
        -- CSAPI.StopBGM()
        ShowOverView()
    end
end

--显示结束界面
function ShowOverView()
    CSAPI.SetGOActive(overObj,true)
    CSAPI.SetGOActive(clickMask,true)
    CSAPI.SetText(txtOverScore,StringUtil:GetScoreNumStr(score,7))
    CSAPI.SetGOActive(newObj,score > HalloweenMgr:GetScore())
    ClearAnim()
end

function OnClickPause()
    isContinue = not isContinue
    SetPause()
end

function SetPause()
    CSAPI.SetText(txtPasue,isContinue and "暂停" or "继续")
end

function CheckIsEnd()
    return isTimeEnd or isDeadEnd or isQuitEnd
end

function OnClickBack()
    ToLog("游戏暂停")
    isContinue = false
    local dialogData= {}
    dialogData.content = LanguageMgr:GetByID(140012)
    dialogData.okCallBack = function()
        isQuitEnd = true
        PlayEnd(true)
    end
    dialogData.cancelCallBack = function()
        ToLog("游戏继续")
        isContinue = true
    end
    CSAPI.OpenView("Dialog",dialogData)
end

function OnClickClose()
    CloseView()
end

function CloseView()
    view:Close()
end

---------------------------------------------阶段---------------------------------------------
function InitStage()
    if cfg.infos then
        stageDatas = {}
        for i, v in ipairs(cfg.infos) do
            table.insert(stageDatas, v)
        end
    end
end

function UpdateStage()
    if nextStageTime <= curTime and nextStageTime >= 0 then
        for i, v in ipairs(stageDatas) do
            if v.startTime > curTime then -- 是否有下一阶段开始时间
                nextStageTime = v.startTime
                break
            else
                nextStageTime = -1
            end
            currStage = v
        end
        ToLog(string.format("当前阶段:%s,下一阶段时间点：%s秒",currStage.index,nextStageTime),true)
        SetItemInfo()
    end
end
---------------------------------------------上方状态---------------------------------------------
function InitTopPanel()
    hp, maxHp = cfg.hp,cfg.hp
    SetHP()
    CSAPI.SetText(txtMaxScore,"BEST SCORE " .. StringUtil:GetScoreNumStr(HalloweenMgr:GetScore(),7))
    SetScore()
end

function AddHP(num)
    hp = hp + num
    hp = hp < 0 and 0 or hp
    hp = hp > maxHp and maxHp or hp
    SetHP()
    if num < 0 and hp > 0 then --扣血动效
        CSAPI.PlayTempSound(GetBGMName(2))
        ShowHpAnim()
    end
    if hp <= 0 then
        CSAPI.PlayTempSound(GetBGMName(4))
        isDeadEnd = true
        PlayEnd()
    end
    ToLog(string.format("血量发生变化，当前血量为：%s",hp))
end

function SetHP()
    for i, v in ipairs(hpGos) do
        CSAPI.SetGOActive(v,false)
    end
    if hp > 0 then
        for i = 1, hp do
            if hpGos[i] then
                CSAPI.SetGOActive(hpGos[i], true)
            else
                local go = CSAPI.CloneGO(hpGos[1],hpObj.transform)
                table.insert(hpGos,go)
            end
        end
    end
end

function AddScore(num)
    score = score + num
    SetScore()
    ToLog(string.format("获得分数：%s，当前分数：%s",num,score))
    CSAPI.PlayTempSound(GetBGMName(1))
end

function SetScore()
    CSAPI.SetText(txtScore1,StringUtil:GetScoreNumStr(score,7))
    CSAPI.SetText(txtScore2,StringUtil:GetScoreNumStr(score,7))
end

function AddGameTime(num)
    curEndTime = curEndTime + num
    curEndTime = curEndTime > maxEndTime and maxEndTime or curEndTime
    ToLog(string.format("获得时间增加：%s秒，当前结束时间：%s秒",num,curEndTime))
    CSAPI.PlayTempSound(GetBGMName(7))
    if isLittleTime and curEndTime - curTime > 10 then
        isLittleTime = false
        CSAPI.StopTempSound(GetBGMName(5))
    end
end
---------------------------------------------时间---------------------------------------------
function InitTime()
    curEndTime = cfg.baseTime + startTime
    maxEndTime = cfg.maxTime + startTime
    curTime = 0
    CSAPI.PlayTempSound(GetBGMName(5))
end

function UpdateGameTime()
    curTime = curTime + Time.deltaTime
    if curTime > curEndTime then
        isTimeEnd = true
        isContinue = false
        CSAPI.SetText(txtTime,"00:0")
    elseif (startTime ~= nil) then
        SetStart()
        if (startTime - curTime <= 0) then
            CSAPI.StopTempSound(GetBGMName(5))
            CSAPI.PlayBGM(isHalloween and "Halloween_music_01" or "SpringFes_Music_01", 50)
            startTime = nil
            CSAPI.SetGOActive(startObj, false)
        end
    else
        local num = math.floor(curEndTime - curTime)
        CSAPI.SetText(txtTime,(num < 10 and "0" .. num or num) .. ":" ..  math.floor(((curEndTime - curTime) - num) * 10))
        if num <= 10 and not isLittleTime then
            isLittleTime = true
            CSAPI.PlayTempSound(GetBGMName(5))
        end
        ShowTimeAnim(isLittleTime)
    end
end

-- 倒计时
function SetStart()
    local num = math.ceil(startTime - curTime)
    num = num <= 0 and 1 or num
    if (not oldNum or oldNum ~= num) then
        oldNum = num
        CSAPI.LoadImg(imgStart, "UIs/Halloween/img_17_0" .. num .. ".png", true, nil, true)
        CSAPI.SetGOActive(imgStart, false)
        CSAPI.SetGOActive(imgStart, true)
    end
end
---------------------------------------------奖励---------------------------------------------
function InitReward()
    rewardMaxTime = cfg.rewardInfo.time
    triggerMaxCount = cfg.rewardInfo.trigger
    -- triggerMaxCount = 2
end

function UpdateRewardTime()
    if rewardTime > 0 then
        rewardTime = rewardTime - Time.deltaTime
        if rewardTime <= 0 then
            ShowRewardEffect(false)
            ToLog("奖励时间结束",true)
        end
        SetRewardTime()
    end
end

function SetRewardTime()
    SetRewardSlider(rewardTime,rewardMaxTime)
end

function CheckAddRewardCount(item, isGet)
    if isGet then --接到
        if item.GetType() == HalloweenItemType.Trap then --接到负面掉落物
            AddRewardCount(0)
        else
            AddRewardCount(1)
        end
    elseif item.GetType() ~= HalloweenItemType.Trap then --未接到除负面之外掉落物
        AddRewardCount(0)
    end
end

function AddRewardCount(num)
    if rewardTime > 0 then --触发奖励
        return
    end
    if num == 0 then --失去连击数
        triggerCount = 0
        ToLog("未接到掉落物或者接到负面效果掉落物，连击重置为0")
    else
        triggerCount = triggerCount + num
        ToLog(string.format("当前连击数：%s,触发奖励所需连击数：%s",triggerCount,triggerMaxCount))
        if triggerCount >= triggerMaxCount then
            CSAPI.PlayTempSound(GetBGMName(3))
            triggerCount = 0
            rewardTime = rewardMaxTime
            itemCreateTime = itemCreateTargetTime
            ShowRewardEffect(true)
            ToLog("触发奖励时间并将生成掉落时间调前，时间持续：" .. rewardTime .. "秒",true)
        end
    end
    SetRewardSlider(triggerCount,triggerMaxCount)
end

--获取奖励掉落物数据
function GetRewardItemData()
    local range = CSAPI.RandomInt(1,#cfg.rewardInfo.ids)
    local data = {
        id = 1,
        isReward = true,
        speed = cfg.rewardInfo.speed,
    }
    for i, v in ipairs(cfg.rewardInfo.ids) do
        if range == i then
            data.id = v
        end
    end
    return data
end

function SetRewardSlider(cur,max)
    rewardSlider.value = cur / max
end
---------------------------------------------玩家---------------------------------------------
function InitPlayer()
    moveSpeed = cfg.playerSpeed * Time.deltaTime
    if player == nil then
        local path = isHalloween and "Halloween/HalloweenPlayer" or "SpringFestival/SpringFestivalPlayer"
        local go = ResUtil:CreateUIGO(path, itemParent.transform)
        player = ComUtil.GetLuaTable(go)
    end
    playerPosY = -(screenData[2] / 2) + (player.GetHeight() / 2) + 58
    CSAPI.SetAnchor(player.gameObject, 0, playerPosY)
end
---------------------------------------------掉落物---------------------------------------------
--设置比例
function SetItemInfo()
    maxPercent = 0
    percents = {}
    for i, v in ipairs(currStage.itemInfo) do
        maxPercent = maxPercent + v[2]
        table.insert(percents, {
            id = v[1],
            num = maxPercent
        })
    end
    ToLog(string.format("当前阶段最大比例：%s，比例分布情况：",maxPercent) .. table.tostring(percents))
end

--更新掉落物
function UpdateItems()
    if itemCreateTime >= itemCreateTargetTime then
        itemCreateTargetTime = itemCreateTargetTime + GetSpaceTime()
        CreateItem()
    else
        itemCreateTime = itemCreateTime + Time.deltaTime
    end
end

-- 生成间隔
function GetSpaceTime()
    if rewardTime > 0 then
        return cfg.rewardInfo.interval
    end
    return currStage.interval
end

--生成掉落物
function CreateItem()
    local item = GetItem()
    item.Refresh(rewardTime > 0 and GetRewardItemData() or GetItemData())
    CSAPI.SetAnchor(item.gameObject, GetItemPosX(item), screenData[2] / 2 + item.GetHeight())
    table.insert(items, item)
    ToLog(string.format("生成掉落物id：%s,类型：%s,当前生成时间点：%s秒,下次生成时间点：%s秒",item.GetID(),item.GetType(),math.floor(itemCreateTime * 100) / 100,itemCreateTargetTime))
end

--获取掉落物位置
function GetItemPosX(item)
    local range = CSAPI.RandomInt(math.ceil(-(screenData[1] / 2) + item.GetWidth() / 2), math.floor(screenData[1] / 2 - item.GetWidth() / 2))
    return range
end

--获取掉落物物体
function GetItem()
    if #itemPool > 0 then
        local item = table.remove(itemPool, 1)
        CSAPI.SetGOActive(item.gameObject, true)
        item.transform:SetAsFirstSibling()
        return item
    end
    local path = isHalloween and  "Halloween/HalloweenItem" or "SpringFestival/SpringFestivalItem"
    local go = ResUtil:CreateUIGO(path, itemParent.transform)
    local item = ComUtil.GetLuaTable(go)
    go.transform:SetAsFirstSibling()
    return item
end

--获取掉落物数据
function GetItemData()
    local rangeIndex = CSAPI.RandomInt(1, maxPercent)
    local data = {
        id = 1,
        speed = currStage.speed
    }
    for i, v in ipairs(percents) do
        if rangeIndex <= v.num then
            data.id = v.id
            break
        end
    end
    return data
end

--移除掉落物
function RemoveItem(item)
    if not IsNil(item) then
        table.insert(itemPool, item)
        CSAPI.SetGOActive(item, false)
    end
end

--更新掉落物位置
function UpdateItemMove()
    if #items > 0 then
        for i, v in ipairs(items) do
            v.UpdateMove()
            if CheckIsGet(v) then
                ToLog(string.format("接到掉落物，id：%s，类型：%s",v.GetID(),v.GetType()))
                TriggerEffect(v)
                CheckAddRewardCount(v,true)
                RemoveItem(i)
            elseif CheckIsDown(v) then
                CheckAddRewardCount(v,false)
                RemoveItem(i)
            end
        end 
    end
end

--检测和玩家发送碰撞
function CheckIsGet(item)
    if math.abs(item.GetPosX() - player.GetBoxPosX()) < (item.GetWidth() / 2 + player.GetBoxWidth() /2) and --x轴
    math.abs(item.GetPosY() - player.GetBoxPosY()) < (item.GetHeight() / 2 + player.GetBoxHeight() /2) then --y轴
        return true
    end
    return false
end

--触发效果
function TriggerEffect(item)
    if item.GetType() == HalloweenItemType.Score then
        AddScore(item.GetEffectNum())
    elseif item.GetType() == HalloweenItemType.Time then
        AddGameTime(item.GetEffectNum())
    elseif item.GetType() == HalloweenItemType.Trap then
        AddHP(item.GetEffectNum())
    end
    getItemsInfo[item.GetType()] = getItemsInfo[item.GetType()] or 0
    getItemsInfo[item.GetType()] = getItemsInfo[item.GetType()] + 1

    --角色动效
    player.ShowScoreAnim()
    player.ShowTriggerAnim(item.GetType())
end

--检测超出底部
function CheckIsDown(item)
    return item.GetPosY() < - (screenData[2] / 2 + item.GetHeight())
end

--移除物体
function RemoveItem(i)
    local item = table.remove(items,i)
    CSAPI.SetGOActive(item.gameObject,false)
    table.insert(itemPool,item)
end

---------------------------------------------移动---------------------------------------------
--更新玩家移动
function UpdateMove()
    UpdatePCMove()
    player.UpdateState(isLeftMove ~= isRightMove) --角色状态
    if isLeftMove == isRightMove then
        return
    end
    posX = player.GetPosX()
    if isLeftMove then
        posX = posX - moveSpeed
        -- 超出边框回正
        posX = (posX - player.GetWidth() / 2) < -screenData[1] / 2 and -screenData[1] / 2 + player.GetWidth() / 2 or
                   posX
    elseif isRightMove then
        posX = posX + moveSpeed
        -- 超出边框回正
        posX = (posX + player.GetWidth() / 2) > screenData[1] / 2 and screenData[1] / 2 - player.GetWidth() / 2 or posX
    end
    CSAPI.SetAnchor(player.gameObject, posX, playerPosY)
    player.SetFront(isLeftMove) --设置角色朝向
end

--pc端移动
function UpdatePCMove()
    if (CS.UnityEngine.Input.GetKeyDown(CS.UnityEngine.KeyCode.A) or CS.UnityEngine.Input.GetKeyDown(CS.UnityEngine.KeyCode.LeftArrow)) then
        isLeftMove = true
    elseif (CS.UnityEngine.Input.GetKeyUp(CS.UnityEngine.KeyCode.A) or CS.UnityEngine.Input.GetKeyUp(CS.UnityEngine.KeyCode.LeftArrow)) then
        isLeftMove = false
    end

    if (CS.UnityEngine.Input.GetKeyDown(CS.UnityEngine.KeyCode.D) or CS.UnityEngine.Input.GetKeyDown(CS.UnityEngine.KeyCode.RightArrow)) then
        isRightMove = true
    elseif (CS.UnityEngine.Input.GetKeyUp(CS.UnityEngine.KeyCode.D) or CS.UnityEngine.Input.GetKeyUp(CS.UnityEngine.KeyCode.RightArrow)) then
        isRightMove = false
    end
end

function OnLeftUp()
    CSAPI.SetGOAlpha(btnLeft,1)
    isLeftMove = false
end

function OnLeftDown()
    CSAPI.SetGOAlpha(btnLeft,0.5)
    isLeftMove = true
end

function OnRightUp()
    CSAPI.SetGOAlpha(btnRight,1)
    isRightMove = false
end

function OnRightDown()
    CSAPI.SetGOAlpha(btnRight,0.5)
    isRightMove = true
end
---------------------------------------------BGM---------------------------------------------
function GetBGMName(type)
    local name1 = "Halloween_effects_0"
    local name2 = "SpringFes_Effects_0"
    name1 = name1 .. type
    if type == 7 then
        name2 = name2 .. 3
    elseif type >= 3 then
        name2 = name2 .. (type + 1)
    else
        name2 = name2 .. type
    end
    return isHalloween and name1 or name2
end

---------------------------------------------日志---------------------------------------------
local isLog = true
function ToLog(str,isSpace)
    if not isLog then
        return
    end
    if isSpace then
        Log("---=============================================---")
    end
    if str and str~="" then
        Log(str)
    end
end

function UpdateTest()
    if (CS.UnityEngine.Input.GetKeyDown(CS.UnityEngine.KeyCode.Space)) then
        -- isContinue = not isContinue
    end
end

function StopSound(cueName)
    CSAPI.StopTargetSound(cueName);
end
---------------------------------------------anim---------------------------------------------
local hpAnim = nil
local damageAnim = nil
function InitAnim()
    CSAPI.SetGOActive(effectDamage,false)
    CSAPI.SetGOActive(rewardEffect,false)
    CSAPI.SetGOActive(effectReward2 ,false)
    CSAPI.SetGOActive(effectTime,false)

    hpAnim = ComUtil.GetCom(hpObj, "Animator")
    damageAnim = ComUtil.GetCom(node, "Animator")
end

function ShowHpAnim()
    CSAPI.SetGOActive(effectDamage,false)
    CSAPI.SetGOActive(effectDamage,true)

    if not IsNil(hpAnim) then
        hpAnim:Play("Hp_anim")
    end
    if not IsNil(damageAnim) then
        damageAnim:Play("Damage_shake")
    end
end

function ShowRewardEffect(b)
    CSAPI.SetGOActive(rewardEffect,b)
    CSAPI.SetGOActive(effectReward2 ,b)
end

function ShowTimeAnim(b)
    CSAPI.SetGOActive(effectTime,b)
end

function ClearAnim()
    CSAPI.SetGOActive(rewardEffect,false)
    CSAPI.SetGOActive(effectReward2 ,false)
    CSAPI.SetGOActive(effectTime,false)
end