local DevelopHelper = {}


--顯示模型，可以指定武器，如果heroId = 0 ，則不處理英雄相關
local function ShowHeroModel(heroId, withWeapon, isEnter, isSkinId,istemplate)
    -- body
    local module = ModuleMgr:GetInstance():GetCurrentModule()
    if module.ShowHeroModel then
        module:ShowHeroModel(heroId, withWeapon, isEnter, isSkinId,istemplate)
    end
end

--重置英雄模型
local function ResetHeroModel()
    -- body
    local module = ModuleMgr:GetInstance():GetCurrentModule()
    if module.ResetModel then
        module:ResetModel()
    end
end

local function SetDrag(canDrag)
    -- body
    local module = ModuleMgr:GetInstance():GetCurrentModule()
    if module.SetDrag then
        module:SetDrag(canDrag)
    end
end

local function CameraMove(to, callback)
    if not to or to == 0 then return end
    local toPos = DevelopCameraConfig.CameraPos[to]
    EventMgr:Broadcast(UIMessageNames.ROLE_DEVELOP_CAMERA_MOVE, 0.5, SafeUnpack(toPos))
    --景深效果
    -- local blur = CS.UnityEngine.Camera.main:GetComponent(typeof(CS.GaussianBlurCameraControl))
    -- local curModule = ModuleMgr:GetInstance():GetCurrentModule()
    -- if not IsNull(blur) then
    --     if curModule.cameraDirector then
    --         curModule.cameraDirector:SetBlur(table.indexof( DevelopCameraConfig.Blur,to))
    --     end
    --     if table.indexof( DevelopCameraConfig.Blur,to) then
    --         blur:FadeIn(nil)
    --     else
    --         blur:FadeOut(nil)
    --     end
    -- end

    -- from 为0 ，表示直接跳到to
    -- if from == 0 or from == nil then
    -- local timeline = DevelopCameraConfig.CameraPos[to]
    -- if timeline == nil then return end

    -- if type(timeline) == "number" then -- timelineId
    --     GameHelper.PlayTimlineById(timeline, callback)
    -- elseif type(timeline) == "table" then -- 直接跳到镜头
    --     if isFirstTime == nil then isFirstTime = false end
    --     EventMgr:Broadcast(UIMessageNames.ROLE_DEVELOP_CAMERA_MOVE, 0.5, SafeUnpack(timeline))
    -- end
    -- return
    -- end
    -- local cameraConfig = DevelopCameraConfig.Timeline[from]
    -- if cameraConfig == nil then return end

    -- if cameraConfig[to] then
    --     local timeline = cameraConfig[to]
    --     if type(timeline) == "number" then -- timelineId
    --         GameHelper.PlayTimlineById(timeline, callback)
    --     elseif type(timeline) == "table" then -- 直接跳到镜头
    --         EventMgr:Broadcast(UIMessageNames.ROLE_DEVELOP_CAMERA_MOVE, 0.5, SafeUnpack(timeline))
    --         if callback then callback() end
    --     end
    -- end
end

DevelopHelper.ShowHeroModel = ShowHeroModel
DevelopHelper.ResetHeroModel = ResetHeroModel
DevelopHelper.SetDrag = SetDrag
DevelopHelper.CameraMove = CameraMove

return DevelopHelper
