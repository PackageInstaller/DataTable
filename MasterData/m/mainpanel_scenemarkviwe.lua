---@class MainPanel_SceneMarkViwe : MainPanel_SceneMarkViwe_Generate
---##################### 【MainPanel_SceneMarkViwe Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【MainPanel_SceneMarkViwe Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local MainPanel_SceneMarkViwe = require "MainPanel_SceneMarkViwe_Generate"

---@class MarkData
---@field GetHeadPosition fun():Vector3
---@field GetHeadIconPath fun():string
---@field IsDestroy? fun():boolean
---@field showInScreen? boolean

---@class MarkInfo
---@field markData MarkData
---@field camera UnityEngine.Camera
---@field markType integer
---@field uiObj UnityEngine.GameObject
---@field dirImg UnityEngine.RectTransform

function MainPanel_SceneMarkViwe:InitLogic(data)
    self.markPrefab:SetActive(false)
    ---@type MarkInfo[]
    self.marks = {}

    self.uiCamera = UIMgr.uiCamera
    ---@type UnityEngine.RectTransform
    local rectTrs = self.transform
    self.viewSize = Vector2.New(rectTrs.rect.width / 2, rectTrs.rect.height / 2)
end

---@param ui UIBase
function MainPanel_SceneMarkViwe:SetParentUI(ui)
    self.parentUI = ui
    self.LoadSpriteAsync = function(self, path, callBack)
        self.parentUI:LoadSpriteAsync(path, callBack)
    end
    self.LoadGameObjectAsync = function(self, path, callBack)
        self.parentUI:LoadGameObjectAsync(path, callBack)
    end

    ---@type fun(self:MainPanel_SceneMarkViwe, gameMesType:GameMsgType, callback:function )
    self.regEvent = function (self, gameMesType, callback)
        local hander = self.parentUI.msgEventHandler
        if hander ~= nil then
           table.insert(hander, {gameMesType, callback, self}) 
        end
    end
end

function MainPanel_SceneMarkViwe:LateUpdate()

    local delTab = nil
    for i = 1, #self.marks do
        local mark = self.marks[i]
        local markData = mark.markData
        if markData.IsDestroy ~= nil and markData:IsDestroy() then
            delTab = delTab or {}
            table.insert(delTab, markData)
            goto continue
        end
        local uiPos, inView = self:WorldPosToUIPos(markData:GetHeadPosition(), mark.camera)

        local markActive = mark.uiObj.activeSelf
        local shouldActive = true
        if markData.showInScreen == false and inView == true then
            shouldActive = false
        end
        if markActive ~= shouldActive then
            mark.uiObj:SetActive(shouldActive)
        end
        if shouldActive then
            mark.dirImg.gameObject:SetActive(not inView)
            if not inView then
                mark.dirImg.up = uiPos:Normalize()
            end
            mark.uiObj.transform.localPosition = uiPos
        end
        ::continue::
    end
    if delTab ~= nil then
        for i = 1, #delTab do
            self:Remove3DMark(delTab[i])
        end
    end
end

---@param worldPos Vector3
---@param camera UnityEngine.Camera
function MainPanel_SceneMarkViwe:WorldPosToUIPos(worldPos, camera)

    local screenPoint = camera:WorldToScreenPoint(worldPos)
    if screenPoint.z < 0 then
        screenPoint = screenPoint * -1
    end
    
    local _,uiPos = RectTransformUtility.ScreenPointToLocalPointInRectangle(self.transform, screenPoint, self.uiCamera, nil)

    if math.abs(uiPos.x) <= self.viewSize.x and math.abs(uiPos.y) <= self.viewSize.y then
        return uiPos, true    
    end
    uiPos = Vector2.New(uiPos.x, uiPos.y)
    local dir = 1
    uiPos.x = uiPos.x / self.viewSize.x
    uiPos.y = uiPos.y / self.viewSize.y
    local scale = 0.0
    if math.abs(uiPos.x) > math.abs(uiPos.y) then
        scale = math.abs(uiPos.x)
    else
        scale = math.abs(uiPos.y)
    end
    uiPos.x = uiPos.x *( self.viewSize.x / scale)
    uiPos.y = uiPos.y *( self.viewSize.y / scale)
    return uiPos, false
end

function MainPanel_SceneMarkViwe:GetMarkInfo(markData)
    if self.marks == nil then
       return nil 
    end
    for i = 1, #self.marks do
        local m = self.marks[i]
        if m.markData == markData then
           return m, i
        end
    end
    return nil
end

---添加一个3D图标
---@param markData MarkData
---@param camera UnityEngine.Camera
---@param markType integer
function MainPanel_SceneMarkViwe:Add3DMark(markData, camera, markType)
    local mark = self:GetMarkInfo(markData)
    if mark ~= nil then
        LuaLogger.es("obj:" .. " 已经被添加")
        return
    end
    local markObj = EngineUtil.Instantiate(self.markPrefab.gameObject, self.transform)

    ---@type MarkInfo
    local mark = {
        markData = markData,
        camera = camera,
        markType = markType,
        uiObj = markObj,
        dirImg = markObj.transform:Find("dirImg")
    }
    markObj:SetActive(true)
    table.insert(self.marks, mark)
end

---@param markData MarkData
function MainPanel_SceneMarkViwe:Remove3DMark(markData)
    local mark, _index = self:GetMarkInfo(markData)
    if mark == nil then
        return
    end
    GameObject.Destroy(mark.uiObj)
    table.remove(self.marks, _index)
end

return MainPanel_SceneMarkViwe
