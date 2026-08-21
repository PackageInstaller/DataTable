local UIScrollView = BaseClass("UIScrollView", UIBaseComponent)
local base = UIBaseComponent

-- 创建
local function OnCreate(self, unity_uiscrollview)
    base.OnCreate(self, unity_uiscrollview)
    -- Unity侧原生组件
    self.unity_uiscrollview = unity_uiscrollview

    if IsNull(self.unity_uiscrollview) and IsNull(self.gameObject) then
        self.gameObject = self.unity_uiscrollview.gameObject
        self.transform = self.unity_uiscrollview.transform
    end
    self._allChildern = {}
    self._contentTransform = self.unity_uiscrollview.content
end

local function SetItemType(self, ctrlType, viewType, prefabGo)
    self._ctrlType = ctrlType
    self._viewType = viewType
    self._prefabGo = prefabGo
    if not IsNull(self._prefabGo) then
        if self._prefabGo.activeSelf then
            self._prefabGo:SetActive(false)
        end
    end
end

local function AddChild(self)
    -- body
    if IsNull(self._prefabGo) then
        return nil
    end
    local go = CS.UnityEngine.GameObject.Instantiate(self._prefabGo, self._contentTransform)
    go:SetActive(true)
    local viewInstance = self._viewType.New(go)
    table.insert(self._allChildern, viewInstance)
    return self._ctrlType.New(viewInstance)
end

local function RemoveChild(self, itemCtrlInstance)
    -- body
    if itemCtrlInstance == nil then
        return
    end
    local idx = table.indexof(self._allChildern, itemCtrlInstance)
    if idx >= 1 and idx <= #self._allChildern then
        table.remove(self._allChildern, idx)
    end
    local GameObjectType = CS.UnityEngine.GameObject
    local go = GameObjectType.Instantiate(self._prefabGo, self._contentTransform)
    GameObjectType.Destroy(go)
    itemCtrlInstance:Delete()
end

local function Clear(self)
    self._contentTransform:ClearChildren(self._prefabGo)
    -- body
    for i, v in ipairs(self._allChildern) do
        v:Delete()
    end
    self._allChildern = {}
end

-- 资源释放
local function OnDestroy(self)
    self.unity_uiscrollview = nil
    base.OnDestroy(self)
end

local function SetVertical(self, value)
    self.unity_uiscrollview.vertical = value
end

local function SetHorizontal(self, value)
    self.unity_uiscrollview.horizontal = value
end

local function SetHorizontalValue(self, value)
    self.unity_uiscrollview.horizontalNormalizedPosition = value
end

local function StopMovement(self)
    self.unity_uiscrollview:StopMovement()
end

local function GetContent(self)
    return self.unity_uiscrollview.content
end

local function SetRectSizeDeltaX(self,x)
    return self.unity_uiscrollview:SetRectSizeDeltaX(x)
end

local function GetRectSizeDelta(self)
    return self.unity_uiscrollview:GetRectSizeDelta()
end

local function GetRectTransform(self)
    return self.unity_uiscrollview.gameObject:rectTransform()
end

local function SetEnable(self,b)
     self.unity_uiscrollview.enabled = b
end

UIScrollView.OnCreate = OnCreate
UIScrollView.OnDestroy = OnDestroy
UIScrollView.Clear = Clear
UIScrollView.RemoveChild = RemoveChild
UIScrollView.AddChild = AddChild
UIScrollView.SetItemType = SetItemType
UIScrollView.SetVertical = SetVertical
UIScrollView.SetHorizontal = SetHorizontal
UIScrollView.SetHorizontalValue = SetHorizontalValue
UIScrollView.StopMovement = StopMovement
UIScrollView.GetContent = GetContent
UIScrollView.SetRectSizeDeltaX = SetRectSizeDeltaX
UIScrollView.GetRectSizeDelta = GetRectSizeDelta
UIScrollView.GetRectTransform = GetRectTransform
UIScrollView.SetEnable = SetEnable

return UIScrollView
