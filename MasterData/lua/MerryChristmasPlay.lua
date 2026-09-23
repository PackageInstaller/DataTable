local mainCfg = nil
local endTime = nil
local isPlay = false
local len = nil
local len2 = nil
local isStop = false
local brustTime = nil -- 爆发
local timeCD = nil -- 点错冷却
local cacheState = nil
local stage = 1 -- 当前阶段
local baseDatas = nil
local num = 5
local FBItems = {}
local gameData = {}
local comboNum = 0
local score = 0
local slider
local startTime

function Awake()
    UIUtil:AddTop2("MerryChristmasPlay", top, Back, Home, {})
    CSAPI.SetGOActive(bg, false)
    CSAPI.SetGOActive(AdaptiveScreen, false)
    slider = ComUtil.GetCom(bar, "Image")

    anim_btnL = ComUtil.GetCom(btnL, "Animator")
    anim_btnR = ComUtil.GetCom(btnR, "Animator")
    anim_triggerL = ComUtil.GetCom(triggerL, "Animator")
    anim_triggerR = ComUtil.GetCom(triggerR, "Animator")

    gameData.begTime = TimeUtil:GetTime() -- 开始游戏时间
    gameData.score = 0
    gameData.gameTime = 0
    gameData.gameRet = 1
    gameData.gameBonus = 0
end

-- 中途退出
function BreakOut()
    gameData.score = score
    gameData.gameTime = math.ceil(mainCfg.len - len)
    gameData.gameRet = 2
    OperateActiveProto:GetChristmasGiftReward(gameData)
end

function Back()
    SetStop(true)
    local str = LanguageMgr:GetByID(78011)
    UIUtil:OpenDialog(str, function()
        BreakOut()
        view:Close()
    end, function()
        SetStop(false)
    end)
end

function Home()
    SetStop(true)
    local str = LanguageMgr:GetByID(78011)
    UIUtil:OpenDialog(str, function()
        BreakOut()
        UIUtil:ToHome()
    end, function()
        SetStop(false)
    end)
end

function Update()
    if (startTime ~= nil) then
        startTime = startTime - Time.deltaTime
        SetStart()
        if (startTime <= 0) then
            CSAPI.GetSound():Pause(false)
            startTime = nil
            CSAPI.SetGOActive(startBg, false)
            len = mainCfg.len or 60
        end
    elseif (not isStop and len ~= nil) then
        len = len - Time.deltaTime
        CSAPI.SetText(txtTime, math.ceil(len) .. "")
        if (len <= 10 and not effectTime.activeSelf) then
            CSAPI.SetGOActive(effectTime, true)
            -- 
            local _len = math.ceil(len)
            if (not len2 or _len ~= len2) then
                len2 = _len
                CSAPI.PlayTempSound("Merrychristmas_effects_07")
            end
        end
        if (len <= 0) then
            CSAPI.PlayTempSound("Merrychristmas_effects_05") -- 小游戏结束音效
            len = 0
            SetStop(true)
            --
            gameData.score = score
            gameData.gameTime = mainCfg.len
            gameData.gameRet = 1
            CSAPI.OpenView("MerryChristmasOverView", {gameData, function()
                view:Close()
            end})
        elseif (timeCD ~= nil) then -- 点错冷却
            timeCD = timeCD - Time.deltaTime
            if (timeCD <= 0) then
                timeCD = nil
            end
        elseif (brustTime ~= nil) then -- 爆发
            brustTime = brustTime - Time.deltaTime
            slider.fillAmount = brustTime / mainCfg.brusttime
            if (brustTime <= 0) then
                brustTime = nil
                CSAPI.SetGOActive(effectReward2, false)
                stage = stage >= 3 and 3 or (stage + 1)
            end
        end
    end
end

function OnOpen()
    mainCfg = MerryChristmasMgr:GetMainCfg()
    gameData.id = mainCfg.id
    local begTime, _endTime = MerryChristmasMgr:GetActivityTime()
    endTime = _endTime
    --
    RefreshPanel()
    --
    startTime = 3
    CSAPI.SetGOActive(startBg, true)
    CSAPI.GetSound():Pause(true)
    CSAPI.PlayTempSound("Merrychristmas_effects_06") -- 倒计时音效
end

-- 倒计时
function SetStart()
    local num = math.ceil(startTime)
    num = num <= 0 and 1 or num
    if (not oldNum or oldNum ~= num) then
        oldNum = num
        CSAPI.LoadImg(imgStart, "UIs/MerryChristmas/img_11_0" .. num .. ".png", true, nil, true)
    end
end

function RefreshPanel()
    SetItems()
    SetScore()
    SetComboNum()
end

function SetItems()
    local datas = {}
    for k = 1, num do
        table.insert(datas, CreateData())
    end
    items = items or {}
    ItemUtil.AddItems("MerryChristmas/MerryChristmasItem", items, datas, gd, nil, 1, nil, SetItemsScale)
end

function CreateData()
    if (not cacheState or cacheState ~= stage) then
        cacheState = stage
        baseDatas = {}
        for k, v in ipairs(CfgChristMainGift) do
            if (stage >= v.stage) then
                table.insert(baseDatas, v)
            end
        end
    end
    local count = #baseDatas
    local index = CSAPI.RandomInt(1, count)
    return baseDatas[index]
end

-- 设置暂停
function SetStop(b)
    isStop = b
end

function Click(isR)
    local curItem = items[num]
    local curData = curItem.GetData()
    if (brustTime == nil and curData.monster ~= isR) then
        comboNum = 0
        SetComboNum()
        timeCD = mainCfg.timecd
        curItem.SetCool(timeCD)
        CSAPI.PlayTempSound("Merrychristmas_effects_04") -- 分类失败
        return -- 点错
    end
    CSAPI.PlayTempSound("Merrychristmas_effects_03") -- 分类成功
    curItem.Refresh(CreateData())
    table.remove(items, num)
    table.insert(items, 1, curItem)
    curItem.transform:SetAsFirstSibling()
    SetItemsScale()
    -- 生成副本
    CreateFB(curData, isR)
    -- 
    score = score + mainCfg.stagescore[stage]
    SetScore()
    -- 
    if (not brustTime) then
        comboNum = comboNum + 1
        if (comboNum >= mainCfg.minComboNum) then
            comboNum = 0
            brustTime = mainCfg.brusttime
            CSAPI.SetGOActive(effectReward2, true)
            gameData.gameBonus = gameData.gameBonus + 1
            CSAPI.PlayTempSound("Merrychristmas_effects_01") -- 奖励时段进入时音效
        end
        SetComboNum()
    end
end

function SetItemsScale()
    for k, v in ipairs(items) do
        local s = 0.5 + (k - 1) * 0.125
        CSAPI.SetScale(v.gameObject, s, s, 1)
    end
end

function SetComboNum()
    slider.fillAmount = comboNum / mainCfg.minComboNum
end

function SetScore()
    CSAPI.SetText(txtScore, score .. "")
end

function CreateFB(curData, isR)
    if (#FBItems > 0) then
        local item = FBItems[1]
        table.remove(FBItems, 1)
        CSAPI.SetGOActive(item.gameObject, true)
        item.Refresh2(curData, isR)
    else
        ResUtil:CreateUIGOAsync("MerryChristmas/MerryChristmasItem", fbParent, function(go)
            local item = ComUtil.GetLuaTable(go)
            item.SetRecycle(function()
                CSAPI.SetGOActive(item.gameObject, false)
                table.insert(FBItems, item)
            end)
            item.Refresh2(curData, isR)
        end)
    end
end

function OnClickL()
    CSAPI.PlayTempSound("Merrychristmas_effects_02") -- 挡板运动音效
    anim_btnL:Play("Btn_anim", 0, 0)
    anim_triggerR:Play("Trigger_Anim", 0, 0)
    if (timeCD ~= nil) then
        return
    end
    Click(false)
end

function OnClickR()
    CSAPI.PlayTempSound("Merrychristmas_effects_02") -- 挡板运动音效
    anim_btnR:Play("Btn_anim", 0, 0)
    anim_triggerL:Play("Trigger_Anim", 0, 0)
    if (timeCD ~= nil) then
        return
    end
    Click(true)
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    if (not isStop) then
        Back()
    end
end
