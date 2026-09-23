local isStop = true
local len = nil -- 每局时长
local score = 0
local combo = 0
local startTime = 3
local copys = {}
local gameData = {}
local isPlayEndAudio = false

function Awake()
    UIUtil:AddTop2("CoffeePlayView", top, Back, Home, {})
    --
    gameData.begTime = TimeUtil:GetTime() -- 开始游戏时间
    gameData.score = 0
    gameData.gameTime = 0
    gameData.rightNum = 0
    gameData.wrongNum = 0
    gameData.gameRet = 1

    --
    CrateACopy({})
end

-- 中途退出
function BreakOut()
    gameData.score = score
    gameData.gameTime = math.ceil(mainCfg.len - len)
    gameData.gameRet = 2
    OperateActiveProto:GetMaidCoffeeReward(mainCfg.id, gameData)
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

function OnOpen()
    mainCfg = CoffeeMgr:GetCurCfg()
    if (not mainCfg) then
        view:Close()
        return
    end
    LanguageMgr:SetText(txtTime, 78008, math.ceil(mainCfg.len or 60))
    -- 顾客 
    SetGuest()
    -- 菜品
    SetFood()
    -- 立绘(按天数轮换)
    SetRole()
    --
    SetScore()
end

-- 倒计时
function SetStart()
    local num = math.ceil(startTime)
    num = num <= 0 and 1 or num
    if (not oldNum or oldNum ~= num) then
        oldNum = num
        CSAPI.LoadImg(imgStart, "UIs/Coffee/img_17_0" .. num .. ".png", true, nil, true)
        CSAPI.SetGOActive(imgStart, false)
        CSAPI.SetGOActive(imgStart, true)
    end
end

function SetRole()
    local day = CoffeeMgr:GetDay()
    day = ((day - 1) % 7) + 1
    local imgName = "img_06_0" .. day
    ResUtil.Coffee:Load(role, imgName)
end

function Update()
    if (startTime ~= nil) then
        startTime = startTime - Time.deltaTime
        SetStart()
        if (startTime <= 0) then
            startTime = nil
            CSAPI.SetGOActive(startBg, false)
            len = mainCfg.len or 60
            LanguageMgr:SetText(txtTime, 78008, math.ceil(len))
            ToStart()
        end
    elseif (not isStop and len ~= nil) then
        len = len - Time.deltaTime
        LanguageMgr:SetText(txtTime, 78008, math.ceil(len))
        if (len <= 0) then
            len = 0
            CSAPI.PlayTempSound("cafe_effects_06")
            SetStop(true)
            if (CSAPI.IsViewOpen("CoffeeFoodDetail")) then
                CSAPI.CloseView("CoffeeFoodDetail")
            end
            --
            gameData.score = score
            gameData.gameTime = mainCfg.len
            gameData.gameRet = 1
            CSAPI.OpenView("CoffeeOverView", {gameData, ToClose, mainCfg.id})
            --
        end
    end
    SetSound05()
end

function SetSound05()
    -- 倒计时将尽的声音
    if (isPlayEndAudio and (isStop or (len ~= nil and len <= 0))) then
        isPlayEndAudio = false
        CSAPI.StopTempSound("cafe_effects_05")
    elseif (len ~= nil and len > 0 and len <= 3 and not isPlayEndAudio) then
        isPlayEndAudio = true
        CSAPI.PlayTempSound("cafe_effects_05")
    end
end

function ToClose()
    view:Close()
end

function SetGuest()
    guestItems = guestItems or {}
    ItemUtil.AddItems("Coffee/CoffeeGuestItem", guestItems, {1, 2, 3}, glg1, GuestOverCB, 1, mainCfg)
end

function GuestOverCB()
    if (len <= 0) then
        return
    end
    combo = 0
    local del = CoffeeMgr:GetMissPoints()
    score = score - del
    score = score <= 0 and 0 or score
    SetScore()
end

function SetFood()
    foodItems = foodItems or {}
    local _cfgs = Cfgs.CfgFood:GetAll()
    ItemUtil.AddItems("Coffee/CoffeeFoodItem", foodItems, _cfgs, glg2, CheckDistance)
end

function CheckDistance(child)
    for k, v in pairs(guestItems) do
        if (v.CheckCanEat()) then
            local dis = UnityEngine.Vector3.Distance(v.transform.position, child.node.transform.position)
            if (len > 0 and dis < 15) then
                -- 创建副本
                CrateACopy(child)
                --
                child.SetUse()
                --
                local isEat = v.Eat(child.foodCfg.id)
                if (isEat) then
                    -- 完成
                    if (v.CheckSuccess()) then
                        -- 计分
                        local add = 0
                        combo = combo + 1
                        if (combo > mainCfg.minComboNum) then
                            add = (combo - mainCfg.minComboNum) * mainCfg.comboScore
                        end
                        score = score + v.GetScore() + add
                        CSAPI.PlayTempSound("cafe_effects_04")
                        SetScore()
                    end
                    gameData.rightNum = gameData.rightNum + 1
                else
                    CSAPI.PlayTempSound("cafe_effects_03")
                    -- 吃失败,减耐心
                    combo = 0
                    gameData.wrongNum = gameData.wrongNum + 1
                end
                return
            end
        end
    end
end

-- 对象池复制本，用于展示动画
function CrateACopy(child)
    if (#copys > 0) then
        local item = copys[1]
        table.remove(copys, 1)
        local x, y, z = CSAPI.GetPos(child.node)
        CSAPI.SetPos(item.gameObject, x, y, z)
        item.Refresh(child.foodCfg, function(_item)
            table.insert(copys, _item)
        end)
    else
        ResUtil:CreateUIGOAsync("Coffee/CoffeeFoodItem3", gameObject, function(go)
            local item = ComUtil.GetLuaTable(go)
            item.Refresh(child.foodCfg, function(_item)
                table.insert(copys, _item)
            end)
        end)
    end
end

function SetScore()
    LanguageMgr:SetText(txtScore, 78009, score)
end

-- 设置暂停
function SetStop(b)
    isStop = b
    for k, v in pairs(guestItems) do
        v.SetStop(b)
    end
    for k, v in pairs(foodItems) do
        v.SetStop(b)
    end
    SetSound05()
end

function ToStart()
    isStop = false
    for k, v in pairs(guestItems) do
        v.ToStart()
    end
    for k, v in pairs(foodItems) do
        v.ToStart()
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    if (not isStop) then
        Back()
    end
end
