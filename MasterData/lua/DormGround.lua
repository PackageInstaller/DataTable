-- 宿舍 
local isL
local isDown
local maxAngle = 45
local angleSpeed = 30

local isLook = false
local deviceType = CSAPI.GetDeviceType()
local touchCachePos, pos = nil, nil

function Awake()
    Input, GetMouseButton, GetMouseButtonDown = UIUtil:GetFuncs()
    dormCameraMgr = ComUtil.GetCom(gameObject, "DormCameraMgr")

    cm1 = ComUtil.GetCom(cameraGo, "Camera")
    cm2 = ComUtil.GetCom(CameraUI, "Camera")
end

function Init(_dormView)
    dormView = _dormView

    InitCameraData()
end

function InitCameraData()
    cfg = Cfgs.CfgBuidingBase:GetByID(Dorm_CfgID)
    SetCameraPos()
end

function SetCameraPos()
    -- dormCameraMgr:InitOffset(-16.5, 16.5,16.5, cfg.offsetRot[1], cfg.offsetRot[2],
    -- cfg.offsetRot[3])
    -- dormCameraMgr:InitCircle(12, 6, cfg.centerOffset[1], cfg.centerOffset[2], cfg.centerOffset[3],
    -- 35) -- 初始化
    -- dormCameraMgr:SetStartPos(35, 0,0,0) -- 初始视角
    dormCameraMgr:InitOffset(cfg.offsetPos[1], cfg.offsetPos[2], cfg.offsetPos[3], cfg.offsetRot[1], cfg.offsetRot[2],
        cfg.offsetRot[3])
    dormCameraMgr:InitCircle(cfg.minFov, cfg.radius, cfg.centerOffset[1], cfg.centerOffset[2], cfg.centerOffset[3],
        cfg.maxFov) -- 初始化
    dormCameraMgr:SetStartPos(cfg.startFov, cfg.startPos[1], cfg.startPos[2], cfg.startPos[3]) -- 初始视角
end

-- function Update()
--     if (isL ~= nil) then
--         if (isL) then
--             y = y + Time.deltaTime * angleSpeed

--         else
--             y = y - Time.deltaTime * angleSpeed
--         end
--         y = y > maxAngle and maxAngle or y
--         y = y < -maxAngle and -maxAngle or y
--         CSAPI.SetAngle(rootNode, 0, y, 0)
--     end

--     if (cm1 ~= nil and cm2 ~= nil) then
--         LogError(cm1.fieldOfView)
--         if (cm1.fieldOfView ~= cm2.fieldOfView) then
--             cm2.fieldOfView = cm1.fieldOfView
--         end
--     end
-- end

function OnPress(_isL, _isDown)
    if (isL ~= nil and _isDown) then
        return
    end
    isDown = _isDown
    if (not isDown) then
        isL = nil
    else
        y = rootNode.transform.localEulerAngles.y
        if (y > 90) then
            y = y - 360
        end
        isL = _isL
    end
end

function ActiveCamera(b)
    CSAPI.SetGOActive(cameraGo, b)
end

function SetRadiusOffset(value)
    dormCameraMgr:SetRadiusOffset(value)
end

function GetCamera()
    return dormCameraMgr.myCamera
end

-- 相机动画（进场动画）
function EnterAnim()
    dormCameraMgr:SceneEnter()
end

function Exit()
    CSAPI.RemoveGO(gameObject)
end

function SetIsLook(b)
    isLook = b
end

-- 查看时的移动
function Update()
    -- if (isL ~= nil) then
    --     if (isL) then
    --         y = y + Time.deltaTime * angleSpeed

    --     else
    --         y = y - Time.deltaTime * angleSpeed
    --     end
    --     y = y > maxAngle and maxAngle or y
    --     y = y < -maxAngle and -maxAngle or y
    --     CSAPI.SetAngle(rootNode, 0, y, 0)
    -- end

    if (cm1 ~= nil and cm2 ~= nil) then
        if (cm1.fieldOfView ~= cm2.fieldOfView) then
            cm2.fieldOfView = cm1.fieldOfView
        end
    end

    if (isLook) then
        if (deviceType == 3) then
            if (GetMouseButtonDown(1)) then
                touchCachePos = Input.mousePosition
            end
            if (touchCachePos and GetMouseButton(1)) then
                local delta = Input.mousePosition - touchCachePos
                dormCameraMgr:UpdateMove(delta * Time.deltaTime)
                touchCachePos = Input.mousePosition
            end
        else
            if (Input.touchCount > 0) then
                local touch = Input.GetTouch(0)
                if (Input.touchCount > 1) then
                    touchCachePos = touch.position
                else
                    if (touch.phase == CS.UnityEngine.TouchPhase.Began) then
                        touchCachePos = touch.position
                    end
                    pos = touch.position
                    if (touchCachePos and pos and pos ~= touchCachePos) then
                        local delta = pos - touchCachePos
                        delta = delta * dormCameraMgr.moveCoeff * Time.deltaTime
                        if (delta.x ~= nil and delta.y ~= nil and delta.z ~= nil) then
                            dormCameraMgr:UpdateMove(delta)
                        end
                        touchCachePos = touch.position
                    end
                end
            end
        end
    end
end
