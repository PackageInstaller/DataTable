-- 家具模板
local baseScale -- j用于计算的基础大小（角度=0时）
local curScale = {} -- 当前用于计算的大小[长,高,宽]（根据旋转角度进行改变）
local offset -- 位置偏移
local limitXYZ = {}
local planeType = 1 -- 1:地板 2：左墙壁  3：右墙壁
local selfLayer = 19 -- 本身所在的层级
local layer -- 当前检测的layer
local isDrag
local isSelect = false
local pos, perPos
local colCount = 0 -- 当前碰撞到的物体
local isOverlay = false -- 是否放置在家具之上
local isReceive = false -- 上面是否放置有家具
local inteRole = nil -- 当前与这个家具交互的角色
local isFirst = false
local animators = nil
function Awake()
    Input, GetMouseButton, GetMouseButtonDown, GetMouseButtonUp, Physics = UIUtil:GetFuncs()

    -- 颜色控制 todo
    -- uiEffect = ComUtil.GetCom(gameObject, "UIEffectControl")
end

function Update()
    if (not isSelect) then
        return
    end
    if (GetMouseButtonDown(0) and not UIUtil.IsClickUI()) then
        local ray = DormMgr:GetSceneCamera():ScreenPointToRay(Input.mousePosition)
        local hits = Physics.RaycastAll(ray, 1000, 1 << DormLayer.furniture)
        if (hits and hits.Length > 0) then
            -- 重叠情况下优先选择当前选中的家具
            for k = 0, hits.Length - 1 do
                local hit = hits[k]
                if (hit.transform.parent == transform) then -- hit.transform 是box
                    pos = Input.mousePosition
                    perPos = pos -- 赋值是为了避免点击就立即发生位移
                    isDrag = true
                    break
                end
            end
        end
    end
    if (isDrag and GetMouseButton(0)) then
        pos = Input.mousePosition
        if (pos ~= perPos) then
            perPos = pos
            local ray = DormMgr:GetSceneCamera():ScreenPointToRay(pos)
            local hits = Physics.RaycastAll(ray, 1000, 1 << layer)
            if (hits and hits.Length > 0) then
                local hit = hits[0]
                if (not offsetPos) then
                    offsetPos = transform.position - hit.point -- 未点到中心时加上位置偏移
                end
                local isChangeWall = CheckChangeWall(hit)
                SetPos(hit.point + offsetPos, isChangeWall)
            end
        end
    end
    if (GetMouseButtonUp(0)) then
        isDrag = false
        offsetPos = nil
    end
end

function CheckChangeWall(hit)
    if (planeType ~= 1) then
        local z = hit.transform.localPosition.z
        if ((planeType == 2 and z ~= 0) or (planeType == 3 and z == 0)) then
            data:SetPlaneType(planeType == 2 and 3 or 2)
            return true
        end
    end
    return false
end

function Init(_tool)
    tool = _tool

    local curScale = DormMgr:GetDormScale()
    worldOrigin = {(-curScale.x * 0.5 + 0.5), 0, (-curScale.z * 0.5 + 0.5)}
    whildMax = curScale.x
    heightMax = curScale.z
    nodeSize = 1
end

function Refresh(_data)
    data = _data ~= nil and _data or data

    AddModel()

    -- 所在墙壁
    planeType = data:GetPlaneType()

    -- layer
    layer = DormMgr:GetDormLayer(data:GetCfg())

    -- 获得用于计算的大小(角度0)
    SetBaseScale()

    -- box大小
    SetBoxScale()

    -- inteBox 交互盒子
    AddInteBox()

    -- rot
    if (planeType == 1) then
        CSAPI.SetAngle(gameObject, 0, data:GetRotateY(), 0)
    else
        local y = planeType == 2 and 0 or 90
        CSAPI.SetAngle(gameObject, 0, y, 0)
    end
    -- pos
    SetOffset()
    ChangeGoPos(data:GetPoint())
end

function AddModel()
    local newModelName = data:GetModelPath()
    if (oldModelPath and oldModelPath == newModelName) then
        -- 已经生成
        return
    end
    oldModelPath = newModelName
    CSAPI.CreateGOAsync(newModelName, 0, 0, 0, model, function(go)
        modelGO = go
        local modelScale = data:GetCfg().modelScale
        CSAPI.SetScale(modelGO, modelScale, modelScale, modelScale)
        CSAPI.SetAngle(modelGO, 0, data:GetCfg().modelRot or 0, 0)
        local pos = data:GetCfg().modelPos
        CSAPI.SetLocalPos(modelGO, pos[1], pos[2], pos[3])
        -- 
        animators = ComUtil.GetComsInChildren(modelGO, "Animator")
    end)
end

function SetBaseScale()
    local scale = data:GetScale()
    if (data:GetPlaneType() == 3) then
        baseScale = UnityEngine.Vector3(scale.z, scale.y, scale.x)
    else
        baseScale = UnityEngine.Vector3(scale.x, scale.y, scale.z)
    end
end

function SetBoxScale()
    -- 生成更多或者移除多出的
    local boxNum = data:GetCfg().boxNum or 1
    boxNum = boxNum > 1 and boxNum + 1 or boxNum -- 如果是门这种，加多一个碰撞到绿色区域
    local childCount = transform.childCount - 2
    local max = boxNum >= childCount and boxNum or childCount

    for i = 0, max - 1 do
        local name = "box" .. i
        local tran = transform:Find(name)
        if (tran ~= nil) then
            if (i < boxNum) then
                CSAPI.SetGOActive(tran.gameObject, true)
            else
                CSAPI.SetGOActive(tran.gameObject, false)
            end
        else
            if (i < boxNum) then
                local go = CSAPI.CloneGO(box0, transform)
                local dormCol = ComUtil.GetCom(go, "DormCol")
                dormCol.enabled = true
                go.name = name
                this[name] = go
            end
        end
    end

    local scale = data:GetCfg().scale
    if (data:IsHangings()) then
        -- 如果是墙饰，则要调整model和box的位置，以免一半嵌入墙壁
        CSAPI.SetLocalPos(model, -scale[1] / 2, -scale[2] / 2, 0)
        CSAPI.SetLocalPos(box0, -scale[1] / 2, 0, 0)
        local x, y, z = GetCorrectScale(scale)
        CSAPI.SetScale(box0, x, y, z)
    else
        -- 不是墙饰
        if (boxNum == 1) then
            -- 一个整体
            local x, y, z = GetCorrectScale(scale)
            local posY = scale[2] / 2
            if (data:IsGround()) then
                -- 如果是地面，则要向下调半格
                posY = -posY
            end
            CSAPI.SetScale(box0, x, y, z)
            CSAPI.SetLocalPos(box0, 0, posY, 0)
        else
            -- 中空
            local max1 = boxNum - 1
            for i = 0, max1 do
                if (i == 0) then
                    -- 底部加一个仅用于拖动的box
                    local x, y, z = GetCorrectScale(scale)
                    CSAPI.SetScale(this["box" .. i], x, 0.2, z)
                    CSAPI.SetLocalPos(this["box" .. i], 0, 0.11, 0)
                    local dormCol = ComUtil.GetCom(this["box" .. i], "DormCol")
                    -- dormCol.enabled = false
                    dormCol:SetInteraction(false)
                else
                    local pos, childScale = data:GetChildBoxPosRot(i)
                    local x1, y1, z1 = GetCorrectScale(childScale)
                    CSAPI.SetScale(this["box" .. i], x1, y1, z1)
                    CSAPI.SetLocalPos(this["box" .. i], pos[1], pos[2], pos[3])
                end
            end
        end
        -- 是地面和墙壁，需要修改box的层级
        if (data:IsGround() or data:IsWall()) then
            local _boxNum = boxNum - 1
            for k = 0, _boxNum do
                this["box" .. k].layer = data:IsGround() and DormLayer.ground or DormLayer.wall
                local dormCol = ComUtil.GetCom(this["box" .. k], "DormCol")
                -- dormCol.enabled = false
                dormCol:SetInteraction(false)
            end
        end
        if (data:IsWall()) then
            CSAPI.SetGOActive(box0, false)
        end
    end
end

function GetCorrectScale(scale)
    local x, y, z = 0, 0, 0
    x = scale[1] - 0.01
    y = scale[2] - 0.01
    z = scale[3] - 0.01
    return x, y, z
end

-- --1个box
-- function SetBoxScale2(boxGO)
-- 	boxGO = boxGO == nil and box or boxGO
-- 	local x, y, z = CSAPI.GetScale(boxGO)	
-- 	if(planeType == 1) then
-- 		x = x - 0.01
-- 		y = y - 0.01 --
-- 		z = z - 0.01
-- 	else
-- 		x = x - 0.01--
-- 		y = y - 0.01
-- 		z = z - 0.01
-- 	end	
-- 	CSAPI.SetScale(boxGO, x, y, z)
-- end
-- function GetScale()
-- 	local x, y, z = 0, 0, 0
-- 	local scale = data:GetScale()
-- 	if(scale) then
-- 		x, y, z = scale[1], scale[2], scale[3]
-- 	else
-- 		x, y, z = CSAPI.GetScale(box)
-- 	end
-- 	return x, y, z
-- end
-- 添加或者更新交互盒子 (只对地面的家具)
function AddInteBox()
    if (not inteBoxParent) then
        return
    end
    -- 只有部分家具和装饰可触发交互,叠放时也不触发交互
    if (not data:CheckCanInte() or data:GetParentID() ~= nil) then
        CSAPI.SetGOActive(inteBoxParent, false)
        return
    end

    local x, y, z = baseScale.x, baseScale.y, baseScale.z -- 相对父亲的位置
    local intePoints = data:GetCfg().intePoints
    if (intePoints and #intePoints > 0) then
        CSAPI.SetGOActive(inteBoxParent, true)
        -- inteBox    
        local allPos = {}
        for i, v in ipairs(intePoints) do
            local posIndex = v + 1
            local pos = {
                y = 0
            }
            if (posIndex <= x) then
                pos.x = x * 0.5 - 0.5 - (posIndex - 1)
                pos.z = 0.5 + z * 0.5
                pos.angle = 180
            elseif (posIndex <= (x + z)) then
                pos.x = -(0.5 + x * 0.5)
                pos.z = z * 0.5 - 0.5 - ((posIndex - x) - 1)
                pos.angle = 90
            elseif (posIndex <= (x * 2 + z)) then
                pos.x = -x * 0.5 + 0.5 + ((posIndex - x - z) - 1)
                pos.z = -(0.5 + z * 0.5)
                pos.angle = 0
            else
                pos.x = (0.5 + x * 0.5)
                pos.z = -z * 0.5 + 0.5 + ((posIndex - x * 2 - z) - 1)
                pos.angle = -90
            end
            table.insert(allPos, pos)
        end
        -- add
        local childCount = inteBoxParent.transform.childCount
        for i, v in ipairs(allPos) do
            local go = nil
            if (childCount >= i) then
                go = inteBoxParent.transform:GetChild(i - 1).gameObject
                CSAPI.SetGOActive(go, true)
            else
                go = CSAPI.CloneGO(inteBox, inteBoxParent.transform)
            end
            CSAPI.SetLocalPos(go, v.x, v.y, v.z)
            CSAPI.SetScale(go, 0.5, 1, 0.5)
            CSAPI.SetAngle(go, 0, v.angle, 0)
            -- go.name = "inteBox"..i
        end
        -- 隐藏
        local len = #allPos
        for i = len + 1, childCount do
            local go = inteBoxParent.transform:GetChild(i - 1).gameObject
            CSAPI.SetGOActive(go, false)
        end
    else
        CSAPI.SetGOActive(inteBoxParent, false)
    end
end

-- 旋转
function SetRotate()
    local y = data:SetRotateY()
    CSAPI.SetAngle(gameObject, 0, y, 0)
    SetOffset()
    SetFixedPos()
end

-- 移动偏移、区间（用于规范化）
function SetOffset()
    -- 根据角度重设用于计算的大小
    curRotateY = data:GetRotateY()

    if (curRotateY == 90 or curRotateY == 270) then
        curScale.x = baseScale.z
        curScale.y = baseScale.y
        curScale.z = baseScale.x
    else
        curScale.x = baseScale.x
        curScale.y = baseScale.y
        curScale.z = baseScale.z
    end

    -- 偏移(物体的中心导致奇数大小的边长无法与格子重合，所以要向xz轴正向偏移0.5，偶数边不用)
    offset = {}
    local scale = DormMgr:GetDormScale()

    offset[1] = (scale.x + curScale.x) / 2 > math.floor((scale.x + curScale.x) / 2) and 0.5 or 0
    offset[2] = (curScale.y % 2) ~= 0 and 0.5 or 0
    offset[3] = (scale.z + curScale.z) / 2 > math.floor((scale.z + curScale.z) / 2) and 0.5 or 0

    -- 区间
    limitXYZ[1] = worldOrigin[1] + (curScale.x * 0.5 - 0.5)
    limitXYZ[2] = worldOrigin[1] + (whildMax - 1) * nodeSize - (curScale.x * 0.5 - 0.5)
    limitXYZ[3] = curScale.y * 0.5
    limitXYZ[4] = 5 - curScale.y * 0.5 -- 墙壁高度是5
    limitXYZ[5] = worldOrigin[3] + (curScale.z * 0.5 - 0.5)
    limitXYZ[6] = worldOrigin[3] + (heightMax - 1) * nodeSize - (curScale.z * 0.5 - 0.5)
    for i = 1, 6 do
        limitXYZ[i] = LimitNum(limitXYZ[i])
    end
end

-- 限制精度，否则会出现很长的浮点数
function LimitNum(num)
    if (num == math.floor(num)) then
        return num
    end
    return (num + 0.5) >= math.ceil(num) and math.floor(num) + 0.5 or math.floor(num)
end

-- 获取世界坐标（将当前传入的世界坐标规范化（按格子布局并限制范围））
function GetPos(point)
    -- 规范化,对坐标做四舍五入取整后加上偏移
    local x1, x2 = math.modf(point.x)
    point.x = math.abs(x2) == 0.5 and math.floor(point.x) + offset[1] or math.floor(point.x + 0.5) + offset[1]
    local y1, y2 = math.modf(point.y)
    point.y = math.abs(y2) == 0.5 and math.floor(point.y) + offset[2] or math.floor(point.y + 0.5) + offset[2]
    local z1, z2 = math.modf(point.z)
    point.z = math.abs(z2) == 0.5 and math.floor(point.z) + offset[3] or math.floor(point.z + 0.5) + offset[3]

    -- 限制范围
    if (point.x < limitXYZ[1]) then
        point.x = limitXYZ[1]
    elseif (point.x > limitXYZ[2]) then
        point.x = limitXYZ[2]
    end
    if (point.y < limitXYZ[3]) then
        point.y = limitXYZ[3]
    elseif (point.y > limitXYZ[4]) then
        point.y = limitXYZ[4]
    end
    if (point.z < limitXYZ[5]) then
        point.z = limitXYZ[5]
    elseif (point.z > limitXYZ[6]) then
        point.z = limitXYZ[6]
    end
    if (planeType == 1) then
        point.y = 0
    elseif (planeType == 2) then
        point.x = whildMax * 0.5
    else
        point.z = -heightMax * 0.5
    end
    return point
end

function SetPos(point, isChangeWall)
    local _pos = {
        x = point.x,
        y = point.y,
        z = point.z
    }
    if (isChangeWall) then
        data:SetPoint(_pos)
        Refresh()
    else
        ChangeGoPos(_pos)
    end
end

-- 在原地重新设置位置（用于旋转） 以下 curScale是转换后的值，要反过来计算
function SetFixedPos()
    local position = GetCurPos()
    local pos = {
        x = position[0],
        y = position[1],
        z = position[2]
    }
    if ((curScale.x + curScale.z) % 2 ~= 0) then
        -- 边长和不是偶数
        if (curScale.x > curScale.z) then
            -- 旋转前z大于x
            pos.x = pos.x + 0.5
            pos.z = pos.z - 0.5
        else
            -- 旋转前x大于z		
            pos.x = pos.x - 0.5
            pos.z = pos.z + 0.5
        end
    end
    ChangeGoPos(pos)
end

--
function ChangeGoPos(_pos)
    _pos = GetPos(_pos)
    -- 有父物体，则改变当前高度
    if (data:GetParentID() ~= nil) then
        local parentData = tool:GetFurnitureDataByID(data:GetParentID())
        -- local point = parentData:GetPoint()
        _pos.y = parentData:GetCfg().scale[2] - 0.05 -- 因为box做过缩放，所以这里要让碰撞不跑出范围
    end
    CSAPI.SetPos(gameObject, _pos.x, _pos.y, _pos.z)
    data:SetPoint(_pos)

    -- 如果有子物体，则同时保存子物体的位置
    local childIDs = data:GetChildID()
    if (childIDs) then
        for i, v in ipairs(childIDs) do
            local childLua = tool:GetFurnitureModelByID(v)
            if (childLua) then
                childLua.SaveCurePos()
            end
        end
    end
end

function SaveCurePos()
    local position = GetCurPos()
    local _pos = {
        x = position[0],
        y = position[1],
        z = position[2]
    }
    data:SetPoint(_pos)
end

-- 是添加的家具（未保存之前，不能选择其他家具）
function IsFirst()
    return isFirst
end

-- 选中
function InSelect(b, _isFirst)
    isFirst = _isFirst == nil and false or _isFirst
    if (isFirst) then
        pos = transform.position
        perPos = pos
        offsetPos = UnityEngine.Vector3.zero
    end

    if (b) then
        -- 进入时缓存位置，如果有碰撞则不缓存
        if (isFirst) then
            cachePos = nil
            cacheRotaY = nil
        else
            cachePos = data:GetPoint()
            cacheRotaY = CSAPI.csGetAngle(gameObject)[1]
        end
    else
        -- 退出时如果当前位置有冲突，则返回缓存的位置，如果无缓存的位置，则删除
        if (CheckIsInCol()) then
            if (cachePos ~= nil) then
                local _cacheRotaY = CSAPI.csGetAngle(gameObject)[1]
                if (_cacheRotaY ~= cacheRotaY) then
                    data:ResetRotaY(cacheRotaY)
                    CSAPI.SetAngle(gameObject, 0, cacheRotaY, 0)
                    SetOffset()
                end
                ChangeGoPos(cachePos)
            else
                tool:RemoveByID(data:GetID())
            end
        end
    end
    -- isDrag = isFirst
    isSelect = b
    SetToTop()
    SetShadow()
end

-- 让模型显示在上层
function SetToTop()
    tool:SetCamera2(isSelect)
    if (modelGO) then
        -- modelGO.layer = isSelect and 27 or 26
        local mrs = ComUtil.GetComsInChildren(modelGO, "MeshRenderer") or {}
        for k = 1, mrs.Length do
            mrs[k - 1].gameObject.layer = isSelect and 27 or 26
        end

        -- 如果有子物体，子物体的层级也要调整
        SetChildToTop()

        -- 提高以显示出底部的蓝色或者红色选择特效
        if (data:IsGroundFurnitrue()) then
            local pos = data:GetCfg().modelPos
            local y = isSelect and pos[2] + 0.2 or pos
            CSAPI.SetLocalPos(modelGO, pos[1], y, pos[3])
        end
    end
end

function SetChildToTop()
    local childIDs = data:GetChildID()
    if (childIDs) then
        for i, v in ipairs(childIDs) do
            local childLua = tool:GetFurnitureModelByID(v)
            childLua.modelGO.layer = isSelect and 27 or 26
            local mrs = ComUtil.GetComsInChildren(childLua.modelGO, "MeshRenderer") or {}
            for k = 1, mrs.Length do
                mrs[k - 1].gameObject.layer = isSelect and 27 or 26
            end
        end
    end
end

function SetShadow(cb)
    if (isSelect) then
        if (not dormRoleShadow) then
            CSAPI.CreateGOAsync("Scenes/Dorm/DormRoleShadow", 0, 0, 0, gameObject, function(go)
                CSAPI.SetGOActive(go, true)
                dormRoleShadow = ComUtil.GetLuaTable(go)
                dormRoleShadow.Init(data:GetCfg().id, not CheckIsInCol())
                if (cb) then
                    cb()
                end
            end)
        else
            CSAPI.SetGOActive(dormRoleShadow.gameObject, true)
            dormRoleShadow.Init(data:GetCfg().id, not CheckIsInCol())
            if (cb) then
                cb()
            end
        end
    else
        if (dormRoleShadow) then
            CSAPI.SetGOActive(dormRoleShadow.gameObject, false)
            -- CSAPI.RemoveGO(dormRoleShadow.gameObject)
            -- dormRoleShadow = nil
        end
    end
end

-- 闪烁的阴影
function SetShadow2()
    SetShadow(function()
        if (dormRoleShadow) then
            dormRoleShadow.SetFlicker()
        end
    end)
end

-- 是否处于碰撞中
function CheckIsInCol()
    if (isSelect and colCount > 0 and not isOverlay and not isReceive) then
        return true
    else
        return false
    end
end

-- 改变父亲
function SetIsReceive(b)
    isReceive = b
end

-- 实时位置 float[]
function GetCurPos()
    return CSAPI.csGetPos(gameObject)
end

-- 两物体是否无碰撞
function CheckIsNotTrigger(lua)
    if (not lua) then
        return true
    end
    -- 墙砖和地毯
    if ((lua.data:IsCarpet() and data:IsBrick()) or (lua.data:IsBrick() and data:IsCarpet())) then
        return true
    end
    -- 地毯和非地毯
    if (lua.data:IsCarpet() ~= data:IsCarpet()) then
        return true
    end
    -- 墙砖和非墙砖
    if (lua.data:IsBrick() ~= data:IsBrick()) then
        return true
    end
    return false
end

-- 与家具碰撞时才会进入到该方法（非家具已屏蔽）
function OnTriggerEnter(go)
    if (not gameObject.activeSelf or not go.activeSelf) then
        return
    end
    if (not ComUtil) then
        return
    end

    local lua = ComUtil.GetLuaTable(go.transform.parent.gameObject)
    -- 无碰撞
    if (CheckIsNotTrigger(lua)) then
        return
    end

    -- 砖
    if (data:IsCarpet() or data:IsBrick()) then
        colCount = colCount + 1
        SetShadow()
        return
    end

    -- 非砖
    colCount = colCount + 1 -- 存在碰撞
    if (isSelect and data:IsCanOverlay() and lua.data:IsCanReceive()) then
        -- 放置在上面的家具					
        data:SetParentID(lua.data:GetID())
        lua.data:SetChildID(data:GetID(), true)
        CSAPI.SetParent(gameObject, lua.gameObject)
        lua.SetIsReceive(true)
        isOverlay = true
        -- ChangeGoPos(transform.position)
    end
    SetShadow()
end

function OnTriggerExit(go)
    if (not gameObject.activeSelf or not go.activeSelf) then
        return
    end

    local lua = ComUtil.GetLuaTable(go.transform.parent.gameObject)
    -- 无碰撞
    if (CheckIsNotTrigger(lua)) then
        return
    end

    -- 砖
    if (data:IsCarpet() or data:IsBrick()) then
        colCount = colCount - 1
        SetShadow()
        return
    end

    -- 非砖
    colCount = colCount - 1
    if (isSelect and data:IsCanOverlay() and lua.data:IsCanReceive()) then
        -- 放置在上面的家具			
        data:SetParentID(nil)
        lua.data:SetChildID(data:GetID(), false)
        CSAPI.SetParent(gameObject, tool.main.furniturePoint)
        lua.SetIsReceive(false)
        isOverlay = false
        -- ChangeGoPos(transform.position)
    end
    SetShadow()
end

-- scan时反勾选box的isTrigger (常规状态下是勾选的)
function SetBoxToScan(isScaning)
    if (data:IsGround() or data:IsWall() or data:IsCarpet()) then
        return
    end
    local boxNum = data:GetCfg().boxNum or 1
    boxNum = boxNum > 1 and (boxNum + 1) or boxNum
    for i = 0, boxNum - 1 do
        if (boxNum == 1 or (boxNum > 1 and i ~= 0)) then -- 额外加的不用设置
            if (this["box" .. i]) then
                local box = ComUtil.GetCom(this["box" .. i], "BoxCollider")
                box.isTrigger = not isScaning
            end
        end
    end
end

-- --设置当前交互者 todo 
-- function SetInteData(num)
-- 	inteColData = num
-- end
-- function GetInteData()
-- 	return inteColData
-- end
-- --能否触发交互 （TODO 分两种，1触发位置只能触发1人，2触发家具可触发1人或多人,多人的话要改成列表）
-- function CheckCanInte()
-- 	if(inteColData) then
-- 		return false
-- 	end
-- 	return true
-- end

-- 播放动作
function PlayAnim(b)
    if (animators and animators.Length > 0) then
        local len = animators.Length
        for i = 0, len - 1 do
            if (b) then
                animators[i]:SetTrigger("furniture")
            else
                animators[i]:Play("idle")
            end
        end  
    end
end

function CreateEffect(b)
    if (effObj) then
        CSAPI.RemoveGO(effObj)
        effObj = nil
    end
    if (not b) then
        return
    end
    local eff = data:GetCfg().eff
    if (eff) then
        CSAPI.CreateGOAsync("Scenes/" ..eff, 0, 0, 0, model, function(go)
            effObj = go
            local modelScale = data:GetCfg().modelScale
            CSAPI.SetScale(effObj, modelScale, modelScale, modelScale)
            CSAPI.SetAngle(effObj, 0, data:GetCfg().modelRot or 0, 0)
            local pos = data:GetCfg().modelPos
            CSAPI.SetLocalPos(effObj, pos[1], pos[2], pos[3])
        end)
    end
end
