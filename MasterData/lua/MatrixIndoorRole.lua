local allActions = {}
local curStateLua = nil
local startPos = nil
-- local colCount = 0 --拿起状态下，当前存在碰撞数量
local tookUpStartPos = nil
local curInteGos = {}
local curLayer = 0 -- 模型的层级（换装时会改变）
-- local checkPosEnough = false --计算与交互位置的距离
local curDis = 1
local timer = 0
-- 角色配置
local cfgModel = nil
local modelGOs = {}
local isPet = false 
-- 动画状态机
dormRoleStateMachine = nil
-- 动画控制器
animator = nil

local interpolationFramesCount = 30 -- 旋转完成需要的帧数
local elapsedFrames = 0
local isLoadSuccess = false

function Clear()
    if (modelGOs) then
        for i, v in pairs(modelGOs) do
            CSAPI.RemoveGO(v)
        end
    end
    modelGOs = {}
    curHighfiveID = nil
    CSAPI.SetGOActive(gameObject, false)
    isRobot = nil
    isPet = false 
    curStateLua = nil
    dormRoleStateMachine = nil
    animator = nil
    RemoveAllInte()
    CSAPI.RemoveGO(gameObject)
end

function Awake()
    dormRoleStateMachine = DormRoleStateMachine.New()

    -- 阴影颜色控制
    -- uiEffect = ComUtil.GetCom(gameObject, "UIEffectControl")
    dormCol = ComUtil.GetCom(box, "DormCol")
    roleAI = ComUtil.GetOrAddCom(gameObject, "AStarRole")
end

function Update()
    if (curStateLua == nil) then
        return
    end

    curStateLua:Update()

    dormRoleStateMachine:Update()

    -- if(checkPosEnough and dormColData and Time.time > timer) then
    -- 	timer = Time.time + 0.1
    -- 	curDis = dormColData:GetDis()
    -- 	if(curDis < DormColMinDis2) then
    -- 		checkPosEnough = false
    -- 		ChangeAction(DormRoleActionType.Interaction, dormColData) --进入交互状态
    -- 	end
    -- end
end

function Init(_index, _tool, _info, _isDorm)
    index = _index
    tool = _tool
    data = _info
    isDorm = _isDorm

    isPet = data:IsPet()
    roleAI.ai.maxSpeed = isPet and 0.5 or 1
    modelId = data:GetFirstSkinId()
    -- 回避等级
    roleAI:SetPriority(index)
    roleAI:Stop(true)
    -- startPos = _startPos
    InitRot()
    -- SetPos(_startPos)
    -- 状态机
    dormRoleStateMachine:Init(this)

    LoadModel()

    LoadUI()
end

-- 随机一个角度
function InitRot()
    local angle = CSAPI.RandomInt(0, 360)
    CSAPI.SetAngle(gameObject, 0, angle, 0)
end
function SetPos(pos)
    CSAPI.SetPos(gameObject, pos.x, pos.y, pos.z)
end

-- 换装触发
function ChangeModel()
    if (isCreate) then
        -- 移除之前的model
        if (modelGOs) then
            for i, v in pairs(modelGOs) do
                CSAPI.RemoveGO(v)
            end
        end
        modelGOs = {}
        -- 动画组件清空
        animators = {}
        -- 加载新的
        local modleNames = data:GetModelNames()
        for i, v in ipairs(modleNames) do
            CSAPI.CreateGOAsync("Dormitory/" .. v, 0, 0, 0, node, function(go)
                table.insert(modelGOs, go)
                SetAnimators()
            end)
        end
    end
end

function LoadModel()
    if (not isCreate) then
        isCreate = true
        local modleNames = data:GetModelNames()
        modelNum = #modleNames
        isLoadSuccess = modelNum > 0 and false or true
        for i, v in ipairs(modleNames) do
            if (node == nil) then
                isLoadSuccess = true
                return
            end
            CSAPI.CreateGOAsync("Dormitory/" .. v, 0, 0, 0, node, OnResLoadComplete)
        end
    else
        isLoadSuccess = true
    end
end

-- 角色资源加载完成
function OnResLoadComplete(go)
    if (node == nil) then
        CSAPI.RemoveGO(go)
        return
    end
    table.insert(modelGOs, go)
    modelNum = modelNum - 1
    if (modelNum > 0) then
        return -- 有多个部分
    end

    SetAnimators()

    -- 加载完进入休闲状态
    ChangeAction(DormRoleActionType.idle)

    isLoadSuccess = true
end

function CheckIsLoadSuccess()
    return isLoadSuccess
end

function SetAnimators()
    animators = ComUtil.GetComsInChildren(node, "Animator")
    if (isRobot == nil) then
        if(isPet)then 
            isRobot = false 
        else 
            isRobot = (animators == nil or animators.Length == 0) and true or false
        end 
    end
end

function ChangeAction(actionType, actionData)
    if (not dormRoleStateMachine) then
        return
    end
    if (curStateLua) then
        curStateLua:Exit()
    end
    if (allActions[actionType]) then
        curStateLua = allActions[actionType]
    else
        curStateLua = DormRoleActionMgr:Apply(actionType, this) -- 申请一个行为
        allActions[actionType] = curStateLua
    end
    if (curStateLua) then
        roleAI:Stop(true)
        curStateLua:Enter(actionData)
    end

    -- 如果是交互，记录当前触发碰撞的物体（家具触发点或区域），以免二次触发
    if (actionType == DormRoleActionType.Interaction) then
        tool:AddInteGos(data:GetID(), actionData.targetGO)
    else
        tool:AddInteGos(data:GetID(), nil)
    end
end

function IsRobot()
    return isRobot
end

function IsPet()
    return isPet
end

-- 是否是男
function IsMan()
    return data:GetGender() == 1
end

-- 状态变化
function OnStateEnter(stateHash)
    dormRoleStateMachine:OnStateEnter(stateHash)
end

-- 立即转向玩家
function RotateImme()
    local camera = tool:SceneCamera()
    local x, y, z = CSAPI.GetPos(camera.gameObject)
    transform:LookAt(UnityEngine.Vector3(x, 0, z))
end

-- 设置抓起状态（由状态那边调用过来）
function SetTookUp(b)
    if (b) then
        tookUpStartPos = GetCurPos()
        CSAPI.SetLocalPos(node, 0, 2, 0)
    else
        -- 放开时，设置位置
        local pos = {}
        if (CheckIsInCol()) then
            -- 用原始位置 
            -- 原始位置可能有其他角色了
            local isCan = not tool:CheckIsIntersect(tookUpStartPos, modelId)
            if (isCan) then
                pos = tookUpStartPos
            else
                -- 重索位置
                pos = tool:GetUsablePos(index) -- 忽视自身的位置
            end
        else
            -- 当前位置可用
            pos = GetCurPos()
        end
        SetPos(UnityEngine.Vector3(pos[0], pos[1], pos[2]))
    end
    -- 位置
    -- CSAPI.SetLocalPos(node, 0, b and 2 or 0, 0)
    -- 阴影
    isSelect = b
    SetToTop()
    SetShadow()
    tool:SetGridActive(b)
end

-- 拿起状态下设置位置
function SetTookUpPos(point)
    if (GetIsTookUp()) then
        SetPos(tool:GetRoleCorrectPoint(point))
    end
end

-- 跌落过程
function SetDrop(y)
    y = y < 0 and 0 or y
    CSAPI.SetLocalPos(node, 0, y, 0)
end

-- 拿起时让模型显示在上层
function SetToTop()
    tool:SetCamera2(isSelect)
    -- 人物会变小--todo 由于导航会让角色寻找最近可行走的点，故先不实现
    -- SetModelsLayer(isSelect,27)
end

-- 修改模型层级
function SetModelsLayer(b, num)
    curLayer = b and num or 0
    if (modelGOs) then
        for i, v in pairs(modelGOs) do
            local childs = ComUtil.GetComsInChildren(v, "Transform")
            local len = childs.Length - 1
            for K = 0, len do
                childs[K].gameObject.layer = curLayer
            end
        end
    end
end

-- 设置阴影的颜色  
function SetShadow()
    if (isSelect) then
        local x, y = CSAPI.GetAngle(gameObject)
        if (not dormRoleShadow) then
            CSAPI.CreateGOAsync("Scenes/Dorm/DormRoleShadow", 0, 0, 0, node, function(go)
                dormRoleShadow = ComUtil.GetLuaTable(go)
                dormRoleShadow.Init2(data:GetCfg().id, not CheckIsInCol())
                CSAPI.SetAngle(dormRoleShadow.gameObject, 0, 90 - y, 0)
            end)
        else
            CSAPI.SetGOActive(dormRoleShadow.gameObject, true)
            dormRoleShadow.SetRed(not CheckIsInCol())
            CSAPI.SetAngle(dormRoleShadow.gameObject, 0, 90 - y, 0)
        end
    else
        if (dormRoleShadow) then
            CSAPI.SetGOActive(dormRoleShadow.gameObject, false)
            -- CSAPI.RemoveGO(dormRoleShadow.gameObject)
            -- dormRoleShadow = nil
        end
    end
end

-- 如果放手时，碰撞集合不为0，则触发有效交互
function CheckIsIn()
    if (IsRobot()) then
        return false
    end
    for go, v in pairs(curInteGos) do
        if (go.layer == DormLayer.dorm_role) then
            local lua = ComUtil.GetLuaTable(GetRootObj(go))
            if (lua.IsRobot()) then
                return false
            end
            local _dormColData = DormMgr:CreateDormColData(this, lua, DormLayer.dorm_role, go, true)
            if (_dormColData:CheckColExist()) then
                ChangeAction(DormRoleActionType.Interaction, _dormColData)
                return true
            end
        elseif (go.layer == DormLayer.col_area) then
            return CheckColArea(go, true)
        end
    end
    return false
end

-- 是否处于碰撞中
function CheckIsInCol()
    if (isSelect) then
        for i, v in pairs(curInteGos) do
            if (v ~= DormLayer.col_area) then
                return true
            end
        end
        return false
    else
        return false
    end
end

function SetInCol(go, isAdd)
    if (isAdd) then
        curInteGos[go] = go.layer
    else
        curInteGos[go] = nil
    end
    SetShadow()
end

-- todo 
function RemoveAllInte()
    for go, v in pairs(curInteGos) do
        if (go ~= nil and go.layer == DormLayer.dorm_role) then
            local lua = ComUtil.GetLuaTable(GetRootObj(go))
            lua.RemoveInteGO(box)
        end
    end
    curInteGos = {}
    -- if(dormColData) then
    -- 	dormColData:ClearInte()
    -- end
    dormColData = nil
end

function RemoveInteGO(go)
    curInteGos[go] = nil
end

-- 实时位置 float[]
function GetCurPos()
    return CSAPI.csGetPos(gameObject)
end

function GetName()
    return data:GetName()
end

-- 当前状态
function GetCurState()
    return curStateLua
end

-- 能否与其他角色交互
function CheckCanInteraction(id)
    if (curStateLua) then 
        if (curStateLua:GetType() == DormRoleActionType.idle or curStateLua:GetType() == DormRoleActionType.walk) then 
            return true
        elseif(interactionID and interactionID==id)then 
            return true
        end
    end
    return false
end

-- 是否是点击状态
function GetIsClick()
    if (curStateLua and
        (curStateLua:GetType() == DormRoleActionType.click_lens or curStateLua:GetType() ==
            DormRoleActionType.click_lens_02 or curStateLua:GetType() == DormRoleActionType.furniture_Nod)) then
        return true
    end
    return false
end

-- 是否是拿起状态
function GetIsTookUp()
    if (curStateLua and curStateLua:GetType() == DormRoleActionType.click_grab) then
        return true
    end
    return false
end

-- 是否交互状态
function GetIsInte()
    if (curStateLua and curStateLua:GetType() == DormRoleActionType.Interaction) then
        return true
    end
    return false
end

-- 是否送货状态
function GetIsHanding()
    if (curStateLua and curStateLua:GetType() == DormRoleActionType.base_handlingData) then
        return true
    end
    return false
end

-- 是否送货状态
function GetIsLie()
    if (curStateLua and curStateLua:GetType() == DormRoleActionType.lie) then
        return true
    end
    return false
end


-- 是否隐藏模型
function GetIsHide()
    if (curStateLua and curStateLua:GetType() == DormRoleActionType.Hide) then
        return true
    end
    return false
end

-- 我与碰撞物中心的角度,碰撞物与我中心的角度
function GetColAngle()
    return dormCol:GetMyAngle(), dormCol:GetColAngle()
end

-- 不与砖发生碰撞
function IsBrick(go)
    local lua = ComUtil.GetLuaTable(GetRootObj(go))
    if (go.layer == DormLayer.furniture and lua.data:IsCarpet()) then
        return true
    end
    return false
end

function GetRootObj(go)
    if (go.name == "inteBox") then
        return go.transform.parent.parent.gameObject
    else
        return go.transform.parent.gameObject
    end
end

-- 砖没有inteBox不用考虑
-- 只与交互区域和角色发生碰撞
function OnTriggerEnter(go)
    if (not DormLayer or not GetCurState()) then
        return
    end
    if (IsBrick(go)) then
        return
    end
    SetInCol(go, true)
    local isTookUp = GetIsTookUp()

    -- 拿起或有交互时 不再产生交互
    if (isTookUp or GetIsInte() or GetIsHanding() or GetIsLie()) then
        return
    end
    -- 非拿起时不与家具碰撞(拿起时产生碰撞让底部格子变红)
    if (go.name ~= "inteBox") then
        if ((not isTookUp and go.layer == DormLayer.furniture)) then
            return
        end
    end
    -- 送礼时，不产生交互
    if (tool.CheckIsGift ~= nil and tool:CheckIsGift()) then
        return
    end
    if (IsRobot()) then
        return
    end
    local obj = GetRootObj(go)
    if (go.layer == DormLayer.dorm_role) then
        -- 与角色碰撞
        local lua = ComUtil.GetLuaTable(obj.gameObject)
        if (lua.IsRobot()) then
            return
        end
        local _dormColData = DormMgr:CreateDormColData(this, lua, DormGoType.dorm_role, go)
        if (_dormColData:CheckColExist()) then
            if (isDorm) then
                -- 进入交互状态 击掌
                ChangeAction(DormRoleActionType.Interaction, _dormColData)
            else
                -- 无交互，50%几率继续移动
                if (curStateLua:GetType() == DormRoleActionType.walk) then
                    local cnt = CSAPI.RandomInt(1, 10)
                    if (cnt > 5) then
                        ChangeAction(DormRoleActionType.idle)
                        ChangeAction(DormRoleActionType.walk)
                    else
                        ChangeAction(DormRoleActionType.idle)
                    end
                end
            end
        else
            -- 角度过大时，50%几率停止移动
            if (curStateLua:GetType() == DormRoleActionType.walk and math.abs(GetColAngle()) < DormRoleHitAngle) then
                local cnt = CSAPI.RandomInt(1, 10)
                if (cnt > 5) then
                    ChangeAction(DormRoleActionType.idle)
                end
            end
        end
    else
        -- 与交互区域碰撞
        local colType = nil
        CheckColArea(go, false)
    end
end

function CheckColArea(go, isTookDown)
    if (dormColData) then
        return false
    end
    -- 碰撞体是否触发中
    if (not tool:CheckCanCol(go)) then
        return
    end
    local colType = DormGoType.col_area
    if (string.match(go.name, "inteBox")) then
        colType = DormGoType.furniture
    end
    local obj = GetRootObj(go)
    local lua = ComUtil.GetLuaTable(obj.gameObject)
    dormColData = DormMgr:CreateDormColData(this, lua, colType, go, isTookDown)
    if (dormColData:CheckColExist()) then
        ChangeAction(DormRoleActionType.Interaction, dormColData)
        return true
        -- if(colType == DormGoType.furniture) then 
        --     --移动到触发点
        -- else
        --     --立即执行
        -- 	ChangeAction(DormRoleActionType.Interaction, dormColData) --进入交互状态	
        -- end 
        -- local dis = dormColData:GetDis()
        -- if(dis < DormColMinDis2) then
        -- 	checkPosEnough = false
        -- 	ChangeAction(DormRoleActionType.Interaction, dormColData) --进入交互状态	
        -- else
        -- 	timer = Time.time + 0.1
        -- 	curDis = dis
        -- 	checkPosEnough = true
        -- end	
    end
    return false
end

-- 离开
function OnTriggerExit(go)
    if (IsBrick(go)) then
        return
    end
    SetInCol(go, false)
    -- local isTookUp = GetIsTookUp()
    -- if(not isTookUp and go.layer ~= DormLayer.col_area) then
    -- 	colCount = colCount - 1
    -- 	SetShadow()
    -- end
    if (dormColData and dormColData:GetTargetGO() == go) then
        -- checkPosEnough = false
        dormColData = nil
    end
end

-- 随机找一点移动
function RandomToMove(point)
    if (not point) then
        local arr = tool:GetUsablePos(index)
        point = UnityEngine.Vector3(arr[0], arr[1], arr[2])
    end
    roleAI:SetTarget(point)
    return point
end

-- function AddBubble(desc, cRoleID, timer)
--     tool:AddBubble(desc, cRoleID, timer)
-- end

-- 子物体的动画的自动进入的，不用调用播放
function AddChilds(_type)
    childPrefabs = childPrefabs or {}
    if (_type) then
        local cfg = Cfgs.CfgCardRoleAction:GetByID(_type)
        if (not cfg) then
            LogError("找不到动作：" .. _type)
        end
        if (cfg.childs) then
            for i, v in ipairs(cfg.childs) do
                CSAPI.CreateGOAsync("Dormitory/" .. v, 0, 0, 0, node, function(go)
                    table.insert(childPrefabs, go)
                end)
            end
        end
    else
        for i, v in ipairs(childPrefabs) do
            CSAPI.RemoveGO(v)
        end
        childPrefabs = {}
    end
end

-- 朝向旋转
function Rotation(target)
    if (not startEuler) then
        startEuler = transform.eulerAngles
        if (math.abs(target.transform.eulerAngles.y - transform.eulerAngles.y) >= 180) then
            angleOffset = UnityEngine.Vector3(0, -360, 0)
        else
            angleOffset = UnityEngine.Vector3(0, 0, 0)
        end
    end
    local interpolationRatio = elapsedFrames / interpolationFramesCount
    elapsedFrames = elapsedFrames + 1
    transform.eulerAngles = UnityEngine.Vector3.Lerp(startEuler, target.transform.eulerAngles + angleOffset,
        interpolationRatio)
    if (interpolationRatio >= 1) then
        startEuler = nil
        angleOffset = nil
        return true
    end
end

-- -- 朝向旋转
-- function Rotation(dir)
--     local singleStep = 5 * Time.deltaTime
--     local newDirection = UnityEngine.Vector3.RotateTowards(transform.forward, dir, singleStep, 0)
--     transform.rotation = UnityEngine.Quaternion.LookRotation(newDirection)
--     if (UnityEngine.Vector3.Angle(dir, transform.forward) < 1) then
--         return true
--     end
--     return false
-- end

-- 动作调整：阴影，头顶UI（以面向z为准，其他方向则需要按角度调整）
function AdjustAction(dormAction2)
    local cfg = Cfgs.CfgCardRoleAction:GetByID(dormAction2)
    -- 阴影
    CSAPI.SetGOActive(shadow, cfg.shadow == nil)
    --[[ todo 
    -- UI偏移 修改局部坐标不适用，需要修改UISceneElement的offset
    local roleUI = tool:GetRoleUI(data:GetID())
    if (roleUI) then
        local offset = cfg.centerOffset
        if (offset ~= nil) then
            local x, y, z = CSAPI.GetWorldAngle(gameObject)
            y = y < 0 and 360 - y or y
            if (y > 45 and y < 135) then
                offset = {-offset[1], offset[2], offset[3]}
            elseif (y >= 135 and y < 225) then
                offset = {-offset[1], offset[2], -offset[3]}
                -- elseif(y >= 225 and y < 315) then	
                -- 	offset = {offset[3], offset[2], - offset[1]}
            end
        end
        roleUI.SetCenterOffset(offset ~= nil and offset or {0, 0, 0})
    end
    ]]
end

-- 当前是否是宿舍
function CheckIsDorm()
    return isDorm
end

-- 是否是咨询室
function CheckIsPhyRoom()
    if (not isDorm) then
        local build_id = data:GetRoomBuildID()
        local buildData = MatrixMgr:GetBuildingDataById(build_id)
        return data:IsInPhyRoom()
    end
    return false
end

-- 当前交互对象
function SetInteractionID(id)
    interactionID = id
end

-- -- 当前击掌对象
-- function SetHighfiveID(id)
--     curHighfiveID = id
-- end
-- function GetHighfiveID()
--     return curHighfiveID
-- end
-- 能否击掌
function CheckCanHighfive(id1)
    local curActionType = GetCurState() and GetCurState():GetType() or nil
    if (curActionType == DormRoleActionType.idle or curActionType == DormRoleActionType.walk) then
        return true
    end
    if (curHighfiveID == nil or curHighfiveID == id1) then
        return true
    end
    return false
end

function LoadUI()
    if (not dormUI) then
        CSAPI.CreateGOAsync("Scenes/Dorm/DormUI", 0, 1.5, 0, gameObject, function(go)
            dormUI = ComUtil.GetLuaTable(go)
            --dormUI.Init(tool:SceneCamera().gameObject)
            dormUI.Refresh(data:CheckIsRealCard() and data or nil)
        end)
    else
        dormUI.Refresh(data:CheckIsRealCard() and data or nil)
    end
end

-- 气泡
function AddBubble(desc, timer)
    if (dormUI) then
        dormUI.AddBubble(desc, timer)
    end
end

--清除家具动作
function ClearFurnitureAnim()
    if(dormColData) then 
        dormColData:FurnitureAction(false)
    end 
end