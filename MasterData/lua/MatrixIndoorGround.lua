-- data: MatrixData
function Awake()
    dormCameraMgr = ComUtil.GetCom(gameObject, "DormCameraMgr")

    cm1 = ComUtil.GetCom(cameraGo, "Camera")
    cm2 = ComUtil.GetCom(CameraUI, "Camera")
end

function Refresh(_data)
    if (data and data:GetID() == _data:GetID()) then
        return
    end

    data = _data
    local cfg = data:SetBaseCfg()

    -- initcamera
    dormCameraMgr:InitOffset(cfg.offsetPos[1], cfg.offsetPos[2], cfg.offsetPos[3], cfg.offsetRot[1], cfg.offsetRot[2],
        cfg.offsetRot[3])
    dormCameraMgr:InitCircle(cfg.minFov, cfg.radius, cfg.centerOffset[1], cfg.centerOffset[2], cfg.centerOffset[3],
        cfg.maxFov) -- 初始化
    dormCameraMgr:SetStartPos(cfg.startFov, cfg.startPos[1], cfg.startPos[2], cfg.startPos[3]) -- 初始视角

    --
    SetCols()
end

function SetCols()
    if (oldIndex) then
        CSAPI.SetGOActive(this["col" .. oldIndex], false)
    end
    local index = MatrixMgr:GetIDByBuildData(data)
    if (index) then
        CSAPI.SetGOActive(this["col" .. index], true)
    end
    oldIndex = index

    -- colUI
    if (index) then
        if (not enterItem) then
            CSAPI.CreateGOAsync("Scenes/Matrix/MatrixEnterItem", 0, 0, 0, gameObject, function(go)
                enterItem = ComUtil.GetLuaTable(go)
                enterItem.Init(cameraGo)
                enterItem.Refresh(data, index)
            end)
        else
            CSAPI.SetGOActive(enterItem.gameObject, true)
            enterItem.Refresh(data, index)
        end
    else
        if (enterItem) then
            CSAPI.SetGOActive(enterItem.gameObject, false)
        end
    end

end

-- 相机动画（进场动画）
function EnterAnim()
    -- 相机动画
    dormCameraMgr:SceneEnter()
end

function GetCamera()
    return dormCameraMgr.myCamera
end

function ActiveCamera(b)
    CSAPI.SetGOActive(cameraGo, b)
end

-- 移除
function Exit()

end


function Update()
    if (cm1 ~= nil and cm2 ~= nil) then
        if (cm1.fieldOfView ~= cm2.fieldOfView) then
            cm2.fieldOfView = cm1.fieldOfView
        end
    end
end