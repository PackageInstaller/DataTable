local recordBeginTime = 0
local timer = nil
local cRoleInfo = nil
local time = 0
local time2 = 2
local setRoleTime = nil
local Top = nil;
function Awake()
    -- CSAPI.CreateGOAsync("Scenes/Dorm/DormAmbientSetting")

    -- 记录
    recordBeginTime = CSAPI.GetRealTime()

    CSAPI.PlayUISound("ui_infolineeject_out_2")

    outlineBar = ComUtil.GetCom(hp, "OutlineBar")

    CSAPI.SetGOActive(gameObject, false)
    time = Time.time
    
    textMove = ComUtil.GetCom(nameObj, "TextMove")
end

function OnInit()
    Top = UIUtil:AddTop2("MatrixBuilding", gameObject, Back1, Back2, {})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    eventMgr:AddListener(EventType.Matrix_Building_Update, function()
        if (gameObject.activeSelf) then
            RefreshPanel()
        end
    end)
    -- eventMgr:AddListener(EventType.Matrix_Indoor_Change, function(_data)
    -- 	data = _data
    -- 	OnOpen()
    -- end)
    -- eventMgr:AddListener(EventType.Matrix_Building_Upgrade, function(_name)
    --     LanguageMgr:ShowTips(2007, _name)
    -- end)

    -- 点击场景中的界面入口
    eventMgr:AddListener(EventType.Input_Scene_Matrix_Building_Down, OnClickGrid)

    -- 选中角色 
    eventMgr:AddListener(EventType.Dorm_Role_Select, OnClickRole)
    -- 移除角色 
    eventMgr:AddListener(EventType.Dorm_Roles_Remove, RemoveRoles)
    -- 
    eventMgr:AddListener(EventType.Dorm_SetRoleList, function()
        setRoleTime = Time.time + 1.5
    end)
end

function Back1()
    if (setRoleTime ~= nil and Time.time < setRoleTime) then
        return
    end
    if (Time.time - time < time2) then
        return
    end
    if (not model or not model.tool:IsLoadSuccess()) then
        return
    end
    EventMgr.Dispatch(EventType.Matrix_Indoor_Change, {"MatrixScene"})
end
function Back2()
    if (setRoleTime ~= nil and Time.time < setRoleTime) then
        return
    end
    if (Time.time - time < time2) then
        return
    end
    if (not model or not model.tool:IsLoadSuccess()) then
        return
    end
    UIUtil:ToHome()
end

-- 编辑时移除了当前角色 
function RemoveRoles(ids)
    if (cRoleInfo) then
        local id = cRoleInfo:GetID()
        for k, v in pairs(ids) do
            if (id == v) then
                timer = nil
                cRoleInfo = nil
                SetPHYBtns()
                break
            end
        end
    end
end
-- 好感度按钮 
function OnClickRole(_cRoleInfo)
    if (buildData:IsPhyRoom()) then
        cRoleInfo = _cRoleInfo
        SetPHYBtns()
        timer = cRoleInfo ~= nil and TimeUtil:GetTime() + 3 or nil
    end
end

function OnClickGrid(index)
    local viewName = Cfgs.CfgMatrixAttribute:GetByID(index).viewName
    if (viewName) then
        if (viewName == "MatrixRemould") then
            -- 改造界面需要保存数据，所以不能关闭
            if (not matrixRemould) then
                ResUtil:CreateUIGOAsync("Matrix/MatrixRemould", gameObject, function(go)
                    matrixRemould = ComUtil.GetLuaTable(go)
                    matrixRemould.Refresh(buildData)
                end)
            else
                CSAPI.SetGOActive(matrixRemould.gameObject, true)
                matrixRemould.Refresh(buildData)
            end
        elseif (viewName == "MatrixTrading" or viewName == "PlayerAbility") then
            CSAPI.OpenView(viewName)
        else
            CSAPI.OpenView(viewName, buildData)
        end
    end
end

function OnDestroy()
    eventMgr:ClearListener()

    -- 记录 某建筑的打开时长
    local id = buildData and buildData:SetBaseCfg().id or nil
    if (id) then
        RecordMgr:Save(RecordMode.View, recordBeginTime, "ui_id=" .. id)
    end

    Exit()
end

function OnViewClosed(view)
    if (view == "MatrixBuildingSelect") then
        CSAPI.SetAngle(imgBtn1, 0, 0, 0)
    end
end

function Update()
    if (timer and TimeUtil:GetTime() > timer) then
        cRoleInfo = nil
        timer = nil
        SetPHYBtns()
    end
end

function GetData()
    return buildData
end

function OnOpen()
    buildData = data[1]
    cfg = buildData:GetCfg()
    RefreshPanel()

    -- questionItem
    SetQuestionItem()
end

function RefreshPanel()
    -- ground
    InitGround()
    -- model
    -- InitModel() --Ground的加载可能比Model还要慢，所以要把Model放到Ground之后，因为相机需要Ground
    -- lv
    CSAPI.SetText(txtLv, "" .. buildData:GetLv())
    -- name
    CSAPI.SetText(txtName1, buildData:GetBuildingName() or "")
    CSAPI.SetText(txtName2, buildData:GetBuildingName(true) or "")
    -- hp
    -- local cfg = buildData:GetCfg()
    -- if (cfg.maxHp) then
    --     CSAPI.SetGOActive(hpBg, true)
    --     local cur, max = buildData:GetHP()
    --     outlineBar:SetProgress(max == 0 and 1 or cur / max)
    --     CSAPI.SetText(txtHp, cur .. "/" .. cur)
    -- else
    --     CSAPI.SetGOActive(hpBg, false)
    -- end
    -- 升级状态、按钮
    -- SetUpgrade()
    -- SetTime()
    -- 底部按钮
    SetItems()
    -- 修理
    -- CSAPI.SetGOActive(btnRepair, not buildData:IsMaxHP())

    -- role
    SerRole()
    -- power
    SetPower()
    -- state
    SetPowerState()
end

-- 好感度入口按钮
function SetPHYBtns()
    CSAPI.SetGOActive(btnJB, cRoleInfo ~= nil)
    CSAPI.SetGOActive(btnGame, cRoleInfo ~= nil)
end

function SerRole()
    local curRole1, curRole2 = MatrixMgr:GetRoleCnt()
    CSAPI.SetText(txtRole, curRole1 .. "/" .. curRole2 .. " P")
end

function SetPower()
    local curPower1, curPower2 = MatrixMgr:GetPower()
    curPower1 = math.abs(curPower1)
    curPower2 = math.floor(curPower2)
    CSAPI.SetText(txtPower, curPower1 .. "/" .. curPower2 .. " kW")

    local img = curPower1 > curPower2 and "img9_01_02.png" or "img9_01_01.png"
    CSAPI.LoadImg(powerState, "UIs/Matrix/" .. img, true, nil, true)
end

function SetPowerState()
    local runingLv = MatrixMgr:GetMatrixInfo().runTypeCfgId or 1
    local str = Cfgs.CfgBGobalPower:GetByID(runingLv).name or ""
    --CSAPI.SetText(txtPowerState, str)
    if not IsNil(textMove) then
        textMove:SetText(str)
    end
    CSAPI.SetGOActive(powerState, str ~= "")
end

function InitGround()
    if (not ground) then
        CSAPI.CreateGOAsync("Scenes/Matrix/MatrixIndoorGround", 0, 0, 0, nil, function(go)
            ground = ComUtil.GetLuaTable(go)
            ground.Refresh(buildData)
            CSAPI.SetGOActive(go, false)
            LoadSuccess()
            InitModel()
        end)
    else
        ground.Refresh(buildData)
        InitModel()
    end
end

function InitModel()
    -- 移除之前的
    if (oldID and oldID ~= buildData:GetID()) then
        if (model and model.gameObject) then
            CSAPI.RemoveGO(model.gameObject)
            model = nil
        end
    end
    oldID = buildData:GetID()
    if (model) then
        model.Refresh()
    else
        local modelFloderName = buildData:SetBaseCfg().sceneKey
        CSAPI.CreateGOAsync("Scenes/" .. modelFloderName .. "/Model", 0, 0, 0, nil, function(go)
            model = ComUtil.GetLuaTable(go)
            model.Init(this)
            model.Refresh()
            CSAPI.SetGOActive(go, false)
            LoadSuccess()
        end)
    end
end

-- -- 按钮
-- function SetUpgrade()
--     runTime = false
--     baseTime = 0
--     needTime = 0

--     curLv, maxLv = buildData:GetLv()
--     local id = 10036 -- 已满级
--     local alpha = 0.3
--     if (curLv < maxLv) then
--         local _buildingState, _baseTime = buildData:GetState()
--         if (_buildingState == MatrixBuildingType.Upgrage) then
--             baseTime = _baseTime
--             id = 10035 -- 升级中
--         else
--             id = 4012 -- 升级
--             alpha = 1
--         end
--     end
--     LanguageMgr:SetText(txtBtn2, id)
--     if (not btn2CanvasGroup) then
--         btn2CanvasGroup = ComUtil.GetCom(btn2, "CanvasGroup")
--     end
--     btn2CanvasGroup.alpha = alpha
-- end

-- function SetTime()
--     if (baseTime > 0) then
--         needTime = baseTime - TimeUtil:GetTime()
--         -- needTime = needTime > 0 and needTime or 0
--     else
--         needTime = -1
--     end
--     runTime = needTime > -0.1
--     if (runTime == false) then
--         SetUpgrade()
--     end
-- end

function SetItems()
    local indexs = {}

    -- 来袭战斗  --本次屏蔽/10月
    -- if(MatrixAssualtTool:CheckIsRun()) then
    -- 	local monSterIndexs = MatrixAssualtTool:GetMonSterIndexs(buildData:GetId())
    -- 	if(monSterIndexs and #monSterIndexs > 0) then
    -- 		table.insert(indexs, 6)
    -- 	end
    -- end

    -- 角色管理
    table.insert(indexs, 7)
    table.insert(indexs, 4)

    items1 = items1 or {}
    ItemUtil.AddItems("Matrix/MatrixBuildingItem", items1, indexs, downGrid, ItemClickCB1)
end

function ItemClickCB1(index)
    local viewName = nil

    if (index == 6) then
        -- 战斗
        if (MatrixAssualtTool:CheckIsRun()) then
            local monSterIndexs = MatrixAssualtTool:GetMonSterIndexs(buildData:GetId())
            if (monSterIndexs and #monSterIndexs > 0) then
                MatrixAssualtTool:Attack(buildData:GetId(), monSterIndexs[1])
            end
        end
    else
        viewName = Cfgs.CfgMatrixAttribute:GetByID(index).viewName
    end

    if (viewName) then
        if (viewName == "MatrixTrading") then
            CSAPI.OpenView(viewName)
        else
            CSAPI.OpenView(viewName, buildData)
        end
    end
end

-- --是否升级或者建造中
-- function IsCreateOrUpgrade()
-- 	local num, str = 0, ""
-- 	if(buildData) then
-- 		local buildingState, time = buildData:GetState()
-- 		if(buildingState == MatrixBuildingType.Upgrage) then
-- 			num = 1
-- 			str = 2004
-- 		elseif(buildingState == MatrixBuildingType.Create) then			
-- 			num = 2
-- 			str = 10037
-- 		end
-- 	end
-- 	return num, str
-- end

function GetDormGround()
    return ground
end

function GetChangeType()
    return 0
end

------------------------------------------------------------------------------
-- 修理
function OnClickRepair()
    MatrixMgr:Repair(buildData)
end

-- 基础设施
function OnClick1()
    if (Time.time - time < time2) then
        return
    end
    CSAPI.SetAngle(imgBtn1, 0, 180, 0)
    CSAPI.OpenView("MatrixBuildingSelect", buildData)
end

-- --升级
-- function OnClick2()
-- 	local num, str = IsCreateOrUpgrade()
-- 	if(num == 2) then
-- 		--LanguageMgr:ShowTips(str)  --建造中
-- 		return false
-- 	end
-- 	if(num == 1) then
-- 		LanguageMgr:ShowTips(str)  --升级中
-- 		return false
-- 	end

-- 	if(curLv >= maxLv) then
-- 		return
-- 	end
-- 	CSAPI.OpenView("MatrixUp", buildData)
-- end

-- 眼睛
function OnClickLook()
    CSAPI.SetGOActive(node, false)
    CSAPI.SetGOActive(mask, true)
    CSAPI.SetGOActive(Top.gameObject, false)
end

function OnClickMask()
    CSAPI.SetGOActive(node, true)
    CSAPI.SetGOActive(mask, false)
    CSAPI.SetGOActive(Top.gameObject, true)
end

-- function OnClickTitle()
--     CSAPI.OpenView("MatrixBuildingInfo", buildData)
-- end

-- 羁绊
function OnClickJB()
    local cfg = Cfgs.CfgCardRoleStory:GetByID(cRoleInfo:GetID())
    if (cfg) then
        CSAPI.OpenView("FavourPlotView", cRoleInfo)
    else
        LogError("角色无剧情,需要策划配置")
    end
end

-- 咨询室
function OnClickGame()
    CSAPI.OpenView("FavourView", cRoleInfo)
end
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
    CSAPI.SetGOActive(model.gameObject, true)
    CSAPI.SetGOActive(ground.gameObject, true)
    CSAPI.SetGOActive(gameObject, true)
    CSAPI.PlayUISound("ui_popup_open")
end

-- 进场动画 0.5s
function EnterAnim()
    ground.EnterAnim()
end

function Exit()
    if (model and model.tool) then
        CSAPI.SetGOActive(model.gameObject, false)
        model.tool:Exit()
        CSAPI.RemoveGO(model.gameObject)
    end

    model = nil
    if (ground) then
        CSAPI.SetGOActive(ground.gameObject, false)
        ground.Exit()
        CSAPI.RemoveGO(ground.gameObject)
    end
    ground = nil

    MatrixMgr:ClearDatas()

    view:Close()
end
---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if matrixRemould then
        if matrixRemould.gameObject.activeInHierarchy then
            CSAPI.SetGOActive(matrixRemould.gameObject, false)
            return;
        end
    end
    if Top.OnClickBack then
        Top.OnClickBack();
    end
end
------------------------------------------------------------------------------

function SetQuestionItem()
    local name = MatrixMgr:GetCfgModuleInfoName(buildData:GetType())
    CSAPI.SetGOActive(question, name ~= nil)
    if (name ~= nil and g_PopupCourseBuildsType ~= nil) then
        CheckQuestion()
    end
end

function OnClickQuestion()
    local name = MatrixMgr:GetCfgModuleInfoName(buildData:GetType())
    if (name) then
        local cfg = Cfgs.CfgModuleInfo:GetByID(name)
        CSAPI.OpenView("ModuleInfoView", cfg)
    end
end

function CheckQuestion()
    local isNeed = false
    for k, v in pairs(g_PopupCourseBuildsType) do
        if (buildData:GetType() == v) then
            local id = PlayerClient:GetID()
            local name = MatrixMgr:GetCfgModuleInfoName(v)
            local value = PlayerPrefs.GetInt(id .. "first_open_" .. name)
            if (value == nil or value == 0) then
                local cfg = Cfgs.CfgModuleInfo:GetByID(name)
                CSAPI.OpenView("ModuleInfoView", cfg)
                PlayerPrefs.SetInt(id .. "first_open_" .. name, 1)
            end
            break
        end
    end
end
