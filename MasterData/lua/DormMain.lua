-- 房间 
function Awake()
    grid_sr = ComUtil.GetCom(grid, "Renderer")
    dormScreenshot = ComUtil.GetCom(screenshot, "Screenshot")
    CSAPI.SetGOActive(screenshot, false)
    OnInit1()

    tool = MatrixRoleTool.New()
    tool:Awake(this, true)
end

function OnInit1()
    eventMgr = ViewEvent.New()
    -- 拖入家具
    eventMgr:AddListener(EventType.Dorm_Furniture_Add, DormFurnitureADD)
    -- 更换主题	
    eventMgr:AddListener(EventType.Dorm_Theme_Change, function(_data)
        tool.furnitureDatas = DormMgr:GetCopyFurnitureDatas(_data)
        tool:RefreshFurniture()
    end)
    -- 房间更新 升级、 
    eventMgr:AddListener(EventType.Dorm_Update, RefreshPanel)
    -- 使用礼物回调
    eventMgr:AddListener(EventType.Dorm_UseGiftRet, function(proto)
        local roleId = proto.roleId
        tool:SetGiftCB(roleId)
    end)

    -- 截图保存
    eventMgr:AddListener(EventType.Dorm_Screenshot, ToScreenshot)
    -- 更换服装
    eventMgr:AddListener(EventType.Dorm_Change_Clothes, function(_data)
        tool:DormChangeClothes(_data)
    end)
    -- 切换房间
    eventMgr:AddListener(EventType.Dorm_Change, RefreshPanel)
    -- -- 文本
    -- eventMgr:AddListener(EventType.Dorm_Talk, function(_data)
    --     tool:AddBubble(_data[1], _data[2], _data[3])
    -- end)

    -- 点选已放满的家具图标
    eventMgr:AddListener(EventType.Dorm_UIFurnitrue_Click, function(cfgID)
        tool:SetShadowFlicker(cfgID)
    end)

    -- 点击换装
    eventMgr:AddListener(EventType.Dorm_Change_Clothes, function(cRoleID)
        tool:ChangeClothes(cRoleID)
    end)
end

-- 开始截图
function ToScreenshot(_data)
    local fileName = _data[1]
    local needSmall = _data[2] -- 需要截小图
    CSAPI.SetGOActive(screenshot, true)
    DormIconUtil.Screenshot_Do(dormScreenshot, screenshotcamera, fileName, needSmall)
end

function OnDestroy()
    eventMgr:ClearListener()

    -- tool = nil
end

function Update()
    if (tool) then
        tool:Update()
    end
end

-- 生成时调用一次
function Init(_dormView)
    dormView = _dormView
    tool:Init(dormView)

    RefreshPanel()
end

-- 房间更新，使用主题；房间升级时；房间切换
function RefreshPanel()
    InitMap()
    tool:Refresh()
end

-- 初始化格子地图
function InitMap()
    local scale = DormMgr:GetDormScale()
    if (curScale and curScale.x == scale.x and curScale.z == scale.z) then
        return
    end
    curScale = scale
    -- 初始化
    local bs = 4
    tool.aStar:SetDimensions(curScale.x * bs, curScale.z * bs, 1 / bs)

    -- 如果是不同的房间，则调整相机回到初始位置
    local curRoomID = DormMgr:GetCurRoomData():GetID()
    if (oldRoomID and oldRoomID ~= curRoomID) then
        dormView.GetDormGround().SetCameraPos()
    end
    oldRoomID = curRoomID

    -- 根据房间大小调整相机视野
    dormView.GetDormGround().SetRadiusOffset(g_DormCameraDrag or 3)

    -- grid 
    grid_sr.size = UnityEngine.Vector2(scale.x, scale.z)
end

-- 根据鼠标位置生成3d物体 
function DormFurnitureADD(_datas)
    local isAdd = _datas[2]
    if (isAdd) then
        -- 添加
        -- 如果是墙壁或者地面，移除旧地面或墙壁，再添加新的
        dormView.GetDormGround().SetCameraPos() -- 设置到初始位置
        tool:FurnitureAdd(_datas[1])
    else
        -- 移除
        -- 如果有多件相同的，则移出其中一键，如果是地板和墙，则移除后添加默认的
        tool:FurnitureRemove(_datas[1])
        dormView.RefreshCurUI()
    end
end

-- 退出
function Exit()
    if (tool) then
        tool:Exit()
    end
    tool = nil
end
