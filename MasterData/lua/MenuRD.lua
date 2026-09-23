-- 红点和new是同一个位置
local redPoss = {
    ["Section"] = {112, 71},
    ["Matrix"] = {33.8, 43.5},
    ["MissionView"] = {33.8, 43.5},
    ["RoleListNormal"] = {33.8, 43.5},
    ["TeamView"] = {33.8, 43.5},
    ["CreateView"] = {33.8, 43.5},
    ["ShopView"] = {33.8, 43.5}
}
-- 上锁位置，下面没有就用红点的位置
local lockPoss = {}
-- 入口拿取红点的key值，没有的特殊处理
local redsRef = {
    ["Matrix"] = RedPointType.Matrix,
    ["RoleListNormal"] = RedPointType.RoleList,
    ["CreateView"] = RedPointType.Create,
    ["ShopView"] = RedPointType.Shop
}
local views = {"Matrix", "MissionView", "RoleListNormal", "TeamView", "CreateView", "ShopView", "Section"} -- 统一处理（上锁，红点检查，点击）
local rdType = 1
local anim_rd
local rdLNR = {}
local fill_attack
local lockDatasDic = {}

function Awake()
    anim_rd = ComUtil.GetCom(gameObject, "Animator")
    if (fillAttack) then
        fill_attack = ComUtil.GetCom(fillAttack, "Image")
    end
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Role_Create_Finish, function()
        if (freeCreateRed.activeSelf) then
            SetFreeCreate(true)
        end
    end)
    -- 升级
    eventMgr:AddListener(EventType.Player_Update, function()
        SetLocks()
    end)
    -- 红点刷新
    eventMgr:AddListener(EventType.RedPoint_Refresh, function()
        SetReds()
    end)
    -- 刷新当前关卡
    eventMgr:AddListener(EventType.Dungeon_PlotPlay_Over, function()
        SetAttack()
    end)
    -- 副本数据设置完
    eventMgr:AddListener(EventType.Dungeon_Data_Setted, function()
        SetAttack()
    end)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Refresh(_menuView, isAnimSuccess)
    menuView = _menuView
    -- 
    if (isAnimSuccess) then
        SetLocks()
        SetReds()
    else
        FuncUtil:Call(function()
            SetLocks()
            SetReds()
        end, nil, 320)
    end
    -- 
    InitOnClick()
    SetAttack()
end

function InitOnClick()
    for k, key in pairs(views) do
        local _name = "OnClick" .. key
        if (key == "Matrix") then
            this[_name] = function()
                local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, key)
                if (not isOpen) then
                    Tips.ShowTips(str)
                else
                    MatrixMgr:SetEnterAnim(true)
                    SceneLoader:Load("Matrix") -- 基地的打开方式（要加载场景）
                end
            end
        elseif (key == "MissionView") then
            this[_name] = function()
                local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, key)
                if (not isOpen) then
                    Tips.ShowTips(str)
                else
                    local openSetting = nil
                    if (GuideMgr:IsGuiding()) then
                        openSetting = eTaskType.Daily
                    end
                    CSAPI.OpenView(key, nil, openSetting)
                end
            end
        elseif (key == "Section") then
            this[_name] = function()
                CSAPI.OpenView(key)
                menuView.ClickSection()
            end
        else
            -- 通用的打开方式
            this[_name] = function()
                local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, key)
                if (not isOpen) then
                    Tips.ShowTips(str)
                else
                    CSAPI.OpenView(key)
                end
            end
        end
    end
end

function SetLocks()
    lockDatasDic = {}
    for i, v in ipairs(views) do
        local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, v)
        if (not isOpen) then
            lockDatasDic[v] = 1
        end
        if (v ~= "PlayerView") then
            local obj = this["btn" .. v]
            local pos = lockPoss[v] or redPoss[v]
            local isShow = not isOpen
            local lockObj = UIUtil:SetLockPoint(obj, isShow, pos[1], pos[2])
            -- end
            CSAPI.SetGOAlpha(obj, isOpen and 1 or 0.5)
            --
            if (obj.transform.parent.name == "rdBtns") then
                rdLNR[v .. "_lock"] = {lockObj, isShow}
            end
        end
    end
    if (anim_shop ~= nil) then
        anim_shop.enabled = lockDatasDic["ShopView"] == nil
    end
    if (anim_create ~= nil) then
        anim_create.enabled = lockDatasDic["CreateView"] == nil
    end
end

function SetReds()
    for i, v in ipairs(views) do
        local isNew = false
        local isRed = false
        local isLimit = false -- 是否限时
        if (not lockDatasDic[v]) then
            if (redsRef[v]) then
                local _data = RedPointMgr:GetData(redsRef[v])
                isRed = _data ~= nil
            elseif (v == "MissionView") then
                local _data = RedPointMgr:GetData(RedPointType.Mission)
                if (_data and _data[1] == 1) then
                    isRed = true
                end
            elseif (v == "PlayerView") then
                local _pData = RedPointMgr:GetData(RedPointType.HeadFrame)
                local _pData2 = RedPointMgr:GetData(RedPointType.Head)
                local _pData3 = RedPointMgr:GetData(RedPointType.Badge)
                local _pData4 = RedPointMgr:GetData(RedPointType.Title)
                if (_pData ~= nil or _pData2 ~= nil or _pData3 ~= nil or _pData4 ~= nil) then
                    isRed = true
                end
            elseif (v == "MenuMore") then
                -- isRed = CheckMoreRed()
            elseif (v == "Section") then
                isNew = SectionNewUtil:IsSectionNew()
                if (not isNew) then
                    isRed = RedPointMgr:GetData(RedPointType.Attack) ~= nil
                end
            elseif (v == "Bag") then
                isLimit = BagMgr:IsShowLimit()
                if (not isLimit) then
                    isRed = RedPointMgr:GetData(RedPointType.Bag) ~= nil
                end
            end
        end
        local obj = this["btn" .. v]
        local pos = redPoss[v]
        local newObj = UIUtil:SetNewPoint(obj, isNew, pos[1], pos[2])
        local redObj = UIUtil:SetRedPoint(obj, isRed, pos[1], pos[2])
        local limitObj = UIUtil:SetLimitPoint(obj, isLimit, pos[1], pos[2])
        -- end
        if (obj.transform.parent.name == "rdBtns") then
            rdLNR[v .. "_new"] = {newObj, isNew}
            rdLNR[v .. "_red"] = {redObj, isRed}
            rdLNR[v .. "_limit"] = {limitObj, isLimit}
        end
    end
    -- 特殊
    SetFreeCreate(true)
end

-- b:展开 rdType:1 当前是隐藏状态
function Anim_RD(b)
    local animNam = b and "RD_folding_1" or "RD_folding_2"
    if ((rdType == 1 and b)) or ((rdType ~= 1 and not b)) then
        if (anim_rd ~= nil) then
            anim_rd.enabled = true
            anim_rd:Play(animNam)
        end
        if (b) then
            FuncUtil:Call(SetRDLockNexRed, nil, 300, b)
        else
            SetRDLockNexRed(b)
        end
    end
end

-- b:展开
function SetRDLockNexRed(zk)
    for key, v in pairs(rdLNR) do
        local isShow = false
        if (zk and v[2]) then
            isShow = true
        end
        CSAPI.SetGOActive(v[1], isShow)
    end
    -- 
    SetFreeCreate(zk)
end

function SetFreeCreate(zk)
    local n = 0
    if (zk and lockDatasDic and not lockDatasDic["CreateView"]) then
        n = CreateMgr:GetFreeCnt()
    end
    CSAPI.SetGOActive(freeCreateRed, n > 0)
end

function HideAnimRD()
    if (rdType == 2 and anim_rd ~= nil) then
        anim_rd.enabled = false
    end
end

function SetAttack()
    local cfg, prograss = DungeonMgr:GetCurrMainLineProgress()
    if cfg and prograss then
        CSAPI.SetText(txtAttackCur, cfg.type == 1 and cfg.chapterID or "h" .. cfg.chapterID)
        if (fill_attack) then
            fill_attack.fillAmount = prograss / 100
        end
    end
end

function OnClickRDBack()
    rdType = rdType == 1 and 2 or 1
    MenuMgr:SetMenuRDType(rdType)
    Anim_RD(rdType == 1)
end

function ZK()
    if (rdType == 2) then
        OnClickRDBack()
    end
end

function OnViewClosed(viewKey)
    local cfg = Cfgs.view:GetByKey(viewKey)
    if (cfg and not cfg.is_window and not cfg.top_mask) then
        CSAPI.SetGOActive(gameObject,false)
        CSAPI.SetGOActive(gameObject,true)
    end
end
