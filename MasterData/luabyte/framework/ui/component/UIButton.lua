--[[
-- Lua侧UIButton
-- 注意：
-- 1、按钮一般会带有其他的组件，如带一个UIText、或者一个UIImange标识说明按钮功能，所以这里是一个容器类
-- 2、UIButton组件必须挂载在根节点，其下某个子节点有个Unity侧原生Button即可，如果有多个，需要指派相对路径
-- 使用方式：
-- self.xxx_btn = self:AddComponent(UIButton, var_arg)--添加孩子，各种重载方式查看UIBaseContainer
--]]

local UIButton = BaseClass("UIButton", UIBaseContainer)
local base = UIBaseContainer

-- 创建
local function OnCreate(self, unity_button)
    base.OnCreate(self)
    -- Unity侧原生组件
    self.unity_uibutton = unity_button
    -- 记录点击回调（非基类）
    self.__onClick = nil

    if not IsNull(self.unity_uibutton) and not IsNull(self.gameObject) then
        self.gameObject = self.unity_uibutton.gameObject
        self.transform = self.unity_uibutton.transform
        self.m_onClick = self.unity_uibutton.onClick
    end

    self.m_OnButtonClickHandle = Bind(self, self.OnVirtualClick)
    self.m_onClick:AddListener(self.m_OnButtonClickHandle)
end

-- 虚拟点击
local function OnVirtualClick(self)
    if self.__onClick then
        self.__onClick()
    end
end

-- 设置回调
local function SetOnClick(self, ...)
    self.__onClick = BindCallback(...)
end

-- 移除回调
local function RemoveOnClick(self)
    if self.__onClick ~= nil then
        self.__onClick = nil
    end
end

-- 移除所有回调
local function RemoveAllOnClicks(self)
    self.m_onClick:RemoveAllListeners()
end

local function GetInteractable(self)
    -- body
    return self.unity_uibutton.interactable
end

-- 资源释放
local function OnDestroy(self)
    if not IsNull(self.m_onClick) then
        self.m_onClick:RemoveListener(self.m_OnButtonClickHandle)
    end
    self.unity_uibutton.onClick = nil
    self.m_OnButtonClickHandle = nil
    self.unity_uibutton = nil
    self.__onClick = nil
    self.m_onClick = nil
    base.OnDestroy(self)
end

UIButton.OnCreate = OnCreate
UIButton.SetOnClick = SetOnClick
UIButton.RemoveOnClick = RemoveOnClick
UIButton.RemoveAllOnClicks = RemoveAllOnClicks
UIButton.OnVirtualClick = OnVirtualClick
UIButton.OnDestroy = OnDestroy
UIButton.GetInteractable = GetInteractable
return UIButton
