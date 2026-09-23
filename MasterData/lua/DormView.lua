-- 宿舍
-- 当前房间数据
curRoomData = nil

local changeType = 0 -- 0:正常 1:换人 2：家具布置 3:送礼
-- 模型
local modelNames = {"DormGround", "DormMain"}
local models = {}
-- ui
local uiNames = {"MatrixSetRole", "DormLayout", "DormGift"} -- MatrixSetRole todo 
local uiPrefabs = {}
local time = 0
local time2 = 2.5
-- 气泡
-- local talkPrefabs = {}
-- local talkEmptyPrefabs = {}
-- 等级
local comfortPrefabs = {}

local isLook = false
local setRoleTime = nil
local top = nil
function Awake()
    UIUtil:AddQuestionItem("Dorm", gameObject, node)
    CSAPI.CreateGOAsync("Scenes/Dorm/DormAmbientSetting")
    ac_count = ComUtil.GetCom(count, "ActionBase")
    time = Time.time

    AdaptiveConfiguration.SetLuaObjUIFit("DormView", gameObject)
end

function OnInit()
    top = UIUtil:AddTop2("DormView", topParent, Back1, Back2, {})

    eventMgr = ViewEvent.New()
    -- 添加说话文本
    -- eventMgr:AddListener(EventType.Dorm_Role_Speak, DormRoleSpeak)	
    -- 房间更新
    eventMgr:AddListener(EventType.Dorm_Update, RefreshPanel)
    -- 切换房间
    eventMgr:AddListener(EventType.Dorm_Change, function()
        OnOpen()
    end)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)

    eventMgr:AddListener(EventType.Dorm_Furnitrues_Update, function()
        SetComfort()
        SetCount()
    end)
    eventMgr:AddListener(EventType.Dorm_SetRoleList, function()
        setRoleTime = Time.time + 1.5
        SetComfort()
        SetCount()
    end)
end

function Back1()
    if (setRoleTime ~= nil and Time.time < setRoleTime) then
        return
    end
    if (Time.time - time < time2) then
        return
    end
    if (not GetDormMain() or not GetDormMain().tool:IsLoadSuccess()) then
        return
    end
    Back()
end
function Back2()
    if (setRoleTime ~= nil and Time.time < setRoleTime) then
        return
    end
    if (Time.time - time < time2) then
        return
    end
    if (not GetDormMain() or not GetDormMain().tool:IsLoadSuccess()) then
        return
    end
    UIUtil:ToHome()
end

function LoadingComplete()
    CSAPI.SetGOActive(gameObject, true)
end

function OnDestroy()
    AdaptiveConfiguration.LuaView_Lua_Closed("DormView")
    Exit1() -- 可能会删不干净  界面会因为场景跳转而关闭
    eventMgr:ClearListener()
end

function Back()
    -- 退出好友房间
    local fid = curRoomData:GetFid()
    local oldOpenData = DormMgr:GetOldOpenData()
    if (fid ~= nil and oldOpenData) then
        DormMgr:SetCurOpenData(oldOpenData)
        EventMgr.Dispatch(EventType.Dorm_Change)
        return
    end
    if (changeType ~= 0) then
        if (changeType == 1) then
            -- 编辑驻员
            GetDormMain().tool.RefreshRoles()
            ToMain()
        elseif (changeType == 2) then
            -- 编辑家具
            if (GetDormMain().tool:CheckCurIsInCol()) then
                -- 家具当前摆放位置不可用,请重新调整
                LanguageMgr:ShowTips(21023)
                return
            end
            -- --正在编辑
            if (GetDormMain().tool:CheckIsSelect()) then
                UIUtil:OpenDialog(LanguageMgr:GetTips(21028), function()
                    GetDormMain().tool:Save()
                    ToMain(true)
                end)
                return
            end
            -- 是否与布局前相同
            if (not GetDormMain().tool:CheckIsSame()) then
                -- 是否保存修改
                UIUtil:OpenDialog(LanguageMgr:GetTips(21024), function()
                    GetDormMain().tool:Save()
                    ToMain(true)
                end, function()
                    GetDormMain().tool:DontSave()
                    ToMain()
                end)
            else
                ToMain()
            end
        elseif (changeType == 3) then
            -- 隐藏驻员好感度
            ShowComfortUI(false)
            ToMain()
        end
        return
    end

    -- 是否退出宿舍
    UIUtil:OpenDialog(LanguageMgr:GetTips(21025), function()
        DormMgr:Quit()
    end)
end

function ToMain(isChange)
    changeType = 0

    -- 退出编辑 角色状态： hide-->idle
    InLayout(isChange)
    for i, v in pairs(uiPrefabs) do
        CSAPI.SetGOActive(v.gameObject, false)
    end
    SetInEditState(false)
end

function GetData()
    return curRoomData
end

function OnOpen()
    curRoomData = DormMgr:GetCurRoomData()

    -- 相机、灯光、滑动控制  DormGround
    AddGO(1, nil)
    -- 按类型划分 基地内部  宿舍  DormMain
    AddGO(2, nil)

    -- 设置界面状态：自己、好友、眼睛  
    SetLookState()
    SetInEditState(changeType ~= 0)
    RefreshPanel()

    --日服先不开启宠物
    --CSAPI.SetGOActive(btnPet,not CSAPI.IsADVRegional(3))
end

function RefreshPanel()
    -- cnt
    local curR, maxR = curRoomData:GetNum()
    CSAPI.SetText(txtRole, string.format("%s/%s", curR, maxR))
    -- comfort
    SetComfort()
    -- 编号
    CSAPI.SetText(txtSerial, curRoomData:GetName())
    -- cur 
    RefreshCurUI()
    -- btn
    -- SetBtnUp()
    -- 恢复速度
    -- local comfort = curRoomData:GetComfort()
    -- local num = GCalHelp:DormTiredAddPerent(comfort) / 100
    -- CSAPI.SetText(txtSpeed2, num .. "%")
    -- 数量(由DormMain实时推送)
    -- SetCount()
    -- red
    SetReds()
end

function SetReds()
    local isRed = DormMgr:CheckNewRoomRedNum()
    UIUtil:SetRedPoint(btnDorm, isRed, 110.8, 31.5, 0)
end

function SetComfort()
    local isOnlyShow = curRoomData:IsOnlyShow()
    CSAPI.SetGOActive(comfortObj, not isOnlyShow)
    if (not isOnlyShow) then
        local comfort = DormMgr:GetCopyDatasComfort()
        -- local maxComfort = curRoomData:GetLvCfg().maxComfort
        -- local _comfort = comfort>maxComfort and maxComfort or comfort
        -- CSAPI.SetText(txtComfort, maxComfort ~= nil and (_comfort .. "/" .. maxComfort) or (_comfort .. ""))
        --
        local petComforts = DormPetMgr:GetComforts(curRoomData:GetID())
        comfort = comfort + petComforts
        --
        CSAPI.SetText(txtComfort, comfort .. "")
        local num = GCalHelp:DormTiredAddPerent(comfort)
        CSAPI.SetText(txtSpeed2, num .. "%")
    end
end

function SetCount(isAnim)
    local curCount, maxCount = DormMgr:GetCurRoomCopyNum()
    CSAPI.SetText(txtCount, curCount .. "/" .. maxCount)
    if (isAnim) then
        ac_count:ToPlay()
    end
end

-- function SetBtnUp()
--     local canvasgroup = ComUtil.GetCom(btnUp, "CanvasGroup")
--     canvasgroup.alpha = cur >= max and 0.3 or 1
-- end

function AddGO(index, father)
    local name = modelNames[index]
    local path = "Scenes/Dorm/" .. name
    local lua = models[name]
    if (not lua) then
        CSAPI.CreateGOAsync(path, 0, 0, 0, father, function(go)
            local _lua = ComUtil.GetLuaTable(go)
            if (_lua.Init) then
                _lua.Init(this)
            end
            models[name] = _lua

            LoadSuccess()
        end)
    end
end

function AddUIGO(index)
    local name = uiNames[index]
    local lua = uiPrefabs[name]
    if (not lua) then
        local path = ""
        if (name == "MatrixSetRole") then
            path = "UIs/Matrix/" .. name
        elseif (name == "DormLayout") then
            path = "UIs/Dorm2/" .. name
        else
            path = "UIs/Dorm/" .. name
        end
        -- local path = name == "MatrixSetRole" and "UIs/Matrix/" .. name or "UIs/Dorm/" .. name
        CSAPI.CreateGOAsync(path, 0, 0, 0, childPanel, function(go)
            local _lua = ComUtil.GetLuaTable(go)
            if (_lua.Init) then
                _lua.Init(this)
            end
            if (_lua.Refresh) then
                _lua.Refresh()
            end
            uiPrefabs[name] = _lua
            InLayout()
        end)
    else
        if (lua.Refresh) then
            CSAPI.SetGOActive(lua.gameObject, true)
            lua.Refresh()
        end
        InLayout()
    end
    SetInEditState(true)
end

function RefreshCurUI()
    if (changeType ~= 0) then
        local name = uiNames[changeType]
        local lua = uiPrefabs[name]
        if (lua and lua.Refresh) then
            lua.RefreshPanel()
        end
    end
end

-- 非look状态下的界面 编辑状态/非编辑状态
function SetInEditState(isInEdit)
    local fid = curRoomData:GetFid()
    local isFriend = fid ~= nil
    if (isFriend) then
        CSAPI.SetGOActive(myPanel, false)
        CSAPI.SetGOActive(friendPanel, true)
    else
        CSAPI.SetGOActive(myPanel, not isInEdit)
        CSAPI.SetGOActive(friendPanel, false)
        -- CSAPI.SetGOActive(L, not isInEdit)
        -- CSAPI.SetGOActive(R, not isInEdit)
        CSAPI.SetGOActive(eye, not isInEdit)
    end
end

function GetChangeType()
    return changeType
end

-- 进退家具编辑状态
function InLayout(isChange)
    CSAPI.SetGOActive(speakPanel, changeType == 0 or changeType == 3)

    GetDormMain().tool:InLayout(isChange)
end

function CheckIsLayout()
    return changeType == 1 or changeType == 2
end

function SetLookState()
    -- node
    -- CSAPI.SetGOActive(myPanel, not isLook)
    -- CSAPI.SetGOActive(friendPanel, not isLook)
    -- CSAPI.SetGOActive(childPanel, not isLook)
    -- CSAPI.SetGOActive(top, not isLook)
    --
    CSAPI.SetGOActive(node, not isLook)
    CSAPI.SetGOActive(mask, isLook)

    local dormGround = GetDormGround();
    if (dormGround) then
        dormGround.SetIsLook(isLook)
    end
end

-- 点击送礼对象
function SetGiftRole(curRole)
    GetDormGift().Refresh(curRole)
end

-- 驻员好感度UI
function ShowComfortUI(isShow)
    GetDormMain().tool:SetInGift(isShow)
end

function GetDormGround()
    return models["DormGround"]
end

function GetDormLayout()
    return uiPrefabs["DormLayout"]
end

function GetDormGift()
    return uiPrefabs["DormGift"]
end

function GetDormMain()
    return models["DormMain"]
end

-- 基础建筑
function OnClickBuilding()
    if (Time.time - time < time2) then
        return
    end
    CSAPI.SetAngle(imgBtn1, 0, 0, 180)
    CSAPI.OpenView("MatrixBuildingSelect")
    CSAPI.SetGOActive(btnDorm, false)
end
function OnViewClosed(view)
    if (view == "MatrixBuildingSelect") then
        CSAPI.SetAngle(imgBtn1, 0, 0, 0)
        CSAPI.SetGOActive(btnDorm, true)
        SetReds()
    elseif (view == "MatrixDormSelect") then
        CSAPI.SetAngle(imgBtn2, 0, 0, 0)
        CSAPI.SetAngle(imgBtn3, 0, 0, 0)
    end
end

-- 换房
function OnClickChange()
    CSAPI.OpenView("DormRoom")
end

-- -- 升级
-- function OnClickUp()
--     if (cur < max) then
--         local costs = curRoomData:GetLvCfg().costs
--         if (costs) then
--             local cost = costs[1]
--             local cfg = Cfgs.ItemInfo:GetByID(cost[1])
--             local _c1 = Cfgs.CfgDormRoom:GetByID(cur)
--             local _c2 = Cfgs.CfgDormRoom:GetByID(cur + 1)
--             local desc = LanguageMgr:GetByID(32011, cost[2], cfg.name, _c1.scale[1] .. "x" .. _c1.scale[1],
--                 _c2.scale[2] .. "x" .. _c2.scale[2])
--             UIUtil:OpenPoputSpendView(32004, desc, cost[1], function()
--                 local upDatas = DormMgr:SetCorectDicByRoomScale(curRoomData:GetFurnitures(), curRoomData:GetNextScale())
--                 DormProto:Upgrade(curRoomData:GetID(), upDatas)
--             end)
--         end
--     end
-- end

-- 商城
function OnClickShop()
    CSAPI.OpenView("DormShop")
end

-- 编辑驻员
function OnClickRole()
    -- changeType = 1
    -- AddUIGO(1)
    CSAPI.OpenView("MatrixSetRole", curRoomData)
end

-- 编辑宠物
function OnClickPet()
    CSAPI.OpenView("DormSetPet", curRoomData)
end

-- 编辑家具
function OnClickLayout()
    changeType = 2
    AddUIGO(2)
end
-- 送礼
function OnClickGift()
    changeType = 3
    AddUIGO(3)
    -- 显示驻员好感度UI
    ShowComfortUI(true)
end

-- 好友拜访
function OnClickFriend()
    -- CSAPI.OpenView("MatrixTradingFriend", {"DormView"})
    OpenSelectFriend()
end
-- 模板分享（暂屏蔽） 
function OnClickShare()
    -- CSAPI.OpenView("DormThemeTemplate")
end

function OnClickComfort()
    CSAPI.OpenView("DormComfort")
end

-- 眼睛
function OnClickEye()
    isLook = true
    SetLookState()
end
function OnClickMask()
    isLook = false
    SetLookState()
end

-- 选择好友(此时在好友房间)
function OnClickSelectFriend()
    -- CSAPI.OpenView("MatrixTradingFriend", {"DormView", curRoomData:GetFid()})
    OpenSelectFriend(curRoomData:GetFid())
end

-- 更换房间（好友）
function OnClickChange2()
    local fid = curRoomData:GetFid()
    CSAPI.OpenView("DormRoom", fid)
end

-- function OnPressLDown()
--     GetDormGround().OnPress(true, true)
-- end
-- function OnPressLUp()
--     GetDormGround().OnPress(true, false)
-- end

-- function OnPressRDown()
--     GetDormGround().OnPress(false, true)
-- end
-- function OnPressRUp()
--     GetDormGround().OnPress(false, false)
-- end

------------------------------------------------------------------------------
-- 当前场景的资源加载完毕
function LoadSuccess()
    if (loadCount == nil) then
        loadCount = 2
    end
    loadCount = loadCount - 1
    if (loadCount <= 0 and data[2]) then
        data[2](this)
    end
end

-- 开始展示界面
function LoadingComplete()
    CSAPI.SetGOActive(gameObject, true)
    CSAPI.PlayUISound("ui_popup_open")
end

-- 进场动画 0.5s
function EnterAnim()
    local dormGround = GetDormGround();
    if (dormGround) then
        dormGround.EnterAnim()
    end

    -- 延迟一丢丢
    CSAPI.SetGOActive(node, false)
    CSAPI.SetGOActive(node, true)
end

-- 移除
function Exit()
    Exit1()
    view:Close()
end

function Exit1()
    -- 移除模型
    if (models) then
        for i, v in pairs(models) do
            v.Exit()
            CSAPI.RemoveGO(v.gameObject)
        end
    end
    models = nil

    DormMgr:ClearDatas()
end
---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if top.OnClickBack then
        top.OnClickBack();
    end
end
------------------------------------------------------------------------------

function OpenSelectFriend(fid)
    if (matrixTradingFriend) then
        CSAPI.SetGOActive(matrixTradingFriend.gameObject, true)
        matrixTradingFriend.Refresh({"DormView", fid})
    else
        ResUtil:CreateUIGOAsync("Matrix/MatrixTradingFriend", gameObject, function(go)
            matrixTradingFriend = ComUtil.GetLuaTable(go)
            matrixTradingFriend.Refresh({"DormView", fid})
        end)
    end
end

-- 宿舍列表
function OnClickDorm()
    if (Time.time - time < time2) then
        return
    end
    CSAPI.SetAngle(imgBtn2, 0, 0, 180)
    CSAPI.SetAngle(imgBtn3, 0, 0, 180)
    local fid = curRoomData:GetFid()
    CSAPI.OpenView("MatrixDormSelect", fid)
end
