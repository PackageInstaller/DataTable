local gridItems = nil
local buildings = nil
local isOver = false

--------
-- local offset
local startPos
local endPos
local moveSpeed = 3.5
-- local isMove = false  --移动中
local timer = 0
local isBack = false
local isLook = false

local isEnter = false
local animator_camera

-- 基地
function Awake()
    Input, GetMouseButton, GetMouseButtonDown, GetMouseButtonUp, Physics = UIUtil:GetFuncs()
    eventCurrent = UnityEngine.EventSystems.EventSystem.current
    sceneCamera = ComUtil.GetCom(cameraGo, "Camera")

    matrixCameraMgr = ComUtil.GetCom(gameObject, "MatrixCameraMgr")
    -- MoveInit()
    -- matrixCameraMgr:UpdateMove(UnityEngine.Vector3(0, - 5, 0)) --设置一次位置

    -- local deviceType = CSAPI.GetDeviceType()
    -- if(deviceType == 3) then
    -- 	matrixCameraMgr.moveCoeff = 0.02
    -- else
    -- 	matrixCameraMgr.moveCoeff = - 0.02
    -- end

    InitListener()

    animator_camera = ComUtil.GetCom(cameraGo, "Animator")
end

-- 非XLuaView，OnInit不会执行
function InitListener()
    if (eventMgr ~= nil) then
        eventMgr:ClearListener()
        eventMgr = nil
    end
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Input_Scene_Matrix_Building_Down, OnClickGrid) -- 在ios有问题(待检测)
    -- eventMgr:AddListener(EventType.Matrix_Grid_Click, OpenBuildingByID)
    -- eventMgr:AddListener(EventType.View_Message, OnViewClosed)
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    -- eventMgr:AddListener(EventType.Loading_Complete, function()
    -- 	isEnter = true
    -- 	matrixViewTab.ShowBuildingUI(false)
    -- 	matrixCameraMgr:SetEnterAnim(true, function()
    -- 		matrixViewTab.ShowBuildingUI(true)
    -- 		isEnter = false
    -- 	end)
    -- end)
    eventMgr:AddListener(EventType.Matrix_Building_Update, RefreshBuildingUI)
    eventMgr:AddListener(EventType.Dorm_Update, RefreshBuildingUI)
end

-- --相机进场动画
-- function LoadingComplete()
-- 	isEnter = true
-- 	matrixViewTab.ShowBuildingUI(false)
-- 	matrixCameraMgr:SetEnterAnim(true, function()
-- 		matrixViewTab.ShowBuildingUI(true)
-- 		isEnter = false
-- 	end)
-- end
function OnDestroy()
    eventMgr:ClearListener()
    eventMgr = nil
end

function Init(_matrixViewTab)
    matrixViewTab = _matrixViewTab
end

-- 正常可用
-- function Update()
-- 	if(GetMouseButtonDown(0)) then
-- 		if(eventCurrent:IsPointerOverGameObject()) then
-- 			--LogError("点到ui")
-- 			return
-- 		end
-- 		--点击
-- 		local ray = sceneCamera:ScreenPointToRay(Input.mousePosition)
-- 		local hits = Physics.RaycastAll(ray, 1000, 1 << 0)
-- 		if(hits and hits.Length > 0) then
-- 			--点中
-- 			local len = hits.Length - 1
-- 			for i = 0, len do
-- 				local hitP = hits[i].transform.parent
-- 				if(hitP.name == "cols" and hits[i].transform.name ~= "0") then
-- 					OnClickGrid(tonumber(hits[i].transform.name))
-- 					break
-- 				end
-- 			end
-- 		end
-- 	end
-- end

function OnClickGrid(cfgId)
    if (not cfgId or cfgId == 0) then
        return
    end
    if (cfgId == Dorm_CfgID) then
        CSAPI.OpenView("DormRoom")
    else
        local data = MatrixMgr:GetBuildingDataByCfgId(cfgId)
        if (data) then
            -- 已建造/建造中
            if (buildingState == nil or buildingState ~= MatrixBuildingType.Create) then
                EventMgr.Dispatch(EventType.Matrix_Indoor_Change, {"MatrixBuilding", data})
            end
        else
            -- 未建造
            local isOpen, str = MatrixMgr:CheckCreate(cfgId)
            if (isOpen) then
                CSAPI.OpenView("MatrixCreateInfo", cfgId)
            else
                if (str ~= "") then
                    Tips.ShowTips(str)
                end
            end
        end
    end
end

function Refresh()
    InitBuildingUI()
end

function InitBuildingUI()
    buildingUIItems = buildingUIItems or {}
    local cfgs = Cfgs.CfgBuidingBase:GetAll()
    for i, v in pairs(cfgs) do
        if (buildingUIItems[v.id]) then
            buildingUIItems[v.id].Refresh(v)
        else
            if (this["b" .. v.id]) then
                ResUtil:CreateUIGOAsync("Matrix/MatrixBuildingUI", matrixViewTab.buildingUIParent, function(go)
                    local item = ComUtil.GetLuaTable(go)
                    SetUIPos(go, this["b" .. v.id], v.id)
                    item.SetClickCB(ItemClickCB)
                    item.Refresh(v)
                    buildingUIItems[v.id] = item
                end)
            end
        end
    end
end

function ItemClickCB(cfgId,data,buildingState)
    if(clickTimer and Time.time<clickTimer)then 
       return
    end 
    clickTimer = Time.time+1 --防止同时点击
    if (cfgId == Dorm_CfgID) then
        CSAPI.OpenView("DormRoom") -- todo 需要后端加入建造
    else
        if (data) then
            -- 已建造/建造中
            if (buildingState == nil or buildingState ~= MatrixBuildingType.Create) then
                EventMgr.Dispatch(EventType.Matrix_Indoor_Change, {"MatrixBuilding", data})
            end
        else
            -- 未建造
            local isOpen, str = MatrixMgr:CheckCreate(cfgId)
            if (isOpen) then
                CSAPI.OpenView("MatrixCreateInfo", cfgId)
            else
                if (str) then
                    Tips.ShowTips(str)
                end
            end
        end
    end
end

-- function InitBuildingUI()
-- 	buildingUIItems = buildingUIItems or {}
-- 	local datas = MatrixMgr:GetBuildingDatas()
-- 	for i, v in pairs(datas) do
-- 		local cfgId = v:SetBaseCfg().id
-- 		local item = nil
-- 		if(this["b" .. cfgId]) then
-- 			if(buildingUIItems[cfgId]) then
-- 				item = buildingUIItems[cfgId]
-- 				item.Refresh(v)
-- 			else
-- 				ResUtil:CreateUIGOAsync("Matrix/MatrixBuildingUI", matrixViewTab.buildingUIParent, function(go)
-- 					item = ComUtil.GetLuaTable(go)
-- 					buildingUIItems[cfgId] = item
-- 					SetUIPos(go, this["b" .. cfgId], cfgId)
-- 					item.Refresh(v)
-- 				end)
-- 			end
-- 		else
-- 			print("无该建筑的碰撞体")
-- 		end
-- 	end
-- end
function RefreshBuildingUI()
    if (buildingUIItems) then
        for i, v in pairs(buildingUIItems) do
            v.Refresh()
        end
    end
end

function SetUIPos(go, sceneGO, cfgId)
    CSAPI.AddUISceneElement(go, sceneGO, cameraGo)
    local UISceneElement = ComUtil.GetCom(go, "UISceneElement")
    UISceneElement.offset = GetUIOffsetPos(cfgId)
end

function ResetUIPos()
    for i, v in pairs(buildingUIItems) do
        local UISceneElement = ComUtil.GetCom(v.gameObject, "UISceneElement")
        UISceneElement.offset = GetUIOffsetPos(i)
    end
end

-- 获取摄像机
function GetCamera()
    return goCamera
end

------------------------------------聚焦建筑-----------------------------------------------

function OnViewOpened(viewKey)
    SetCameraEnable(viewKey, false)
end

function OnViewClosed(viewKey)
    -- if(viewKey == "MatrixBuilding") then
    -- 	ResetToStart()
    -- end
    SetCameraEnable(viewKey, true)
end

-- 视角切换
function MoveToOver(cb)
    isOver = not isOver
    matrixCameraMgr:MoveToOver(0.5, cb)
end

-- 获取Ui偏移
function GetUIOffsetPos(cfgID)
    local cfg = Cfgs.CfgBuidingBase:GetByID(cfgID)
    local pos = isOver and cfg.overUIPos or cfg.frontUIPos
    return UnityEngine.Vector3(pos[1], pos[2], pos[3])
end

-- 移动激活已否
function SetCameraEnable(viewkey, b)
    if (not isLook and
        (viewkey == "ModuleInfoView" or viewKey == "RewardPanel" or viewKey == "MatrixAllBuilding" or viewKey ==
            "MatrixCreate")) then
        if (matrixCameraMgr) then
            matrixCameraMgr.enabled = b
        end
    end
end

-- 相机动画（进场动画）
function EnterAnim()
    -- 相机动画 从主界面进来才会播放
    -- matrixCameraMgr:SceneEnter()
    local enterAnim = MatrixMgr:GetEnterAnim()
    if (enterAnim) then
        animator_camera.enabled = enterAnim
    end
    MatrixMgr:SetEnterAnim(false)

    -- ui动画
    if (buildingUIItems) then
        for i, v in pairs(buildingUIItems) do
            v.EnterAnim()
        end
    end
end

-- 移除
function Exit()
    if (buildingUIItems) then
        for i, v in pairs(buildingUIItems) do
            CSAPI.RemoveGO(v.gameObject)
        end
    end
    buildingUIItems = nil
end

