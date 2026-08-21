--[[
-- Lua侧UIImage
--]]

local UIImage = BaseClass("UIImage", UIBaseComponent)
local base = UIBaseComponent

-- 创建
local function OnCreate(self, unity_uiimage)
    base.OnCreate(self, unity_uiimage)
    -- Unity侧原生组件
    self.unity_uiimage = unity_uiimage

    if not IsNull(self.unity_uiimage) and not IsNull(self.gameObject) then
        self.gameObject = self.unity_uiimage.gameObject
        self.transform = self.unity_uiimage.transform
    end
end

-- 虚拟点击
local function OnVirtualClick(self)
    if self.__onclick ~= nil then
        self.__onclick()
    end
end

-- 设置回调
local function SetOnClick(self, ...)
    local arr = { ... }
    if #arr == 0 then
        self.unity_uiimage:onClick(nil)
        return
    end
    self.__onclick = BindCallback(...)
    self.unity_uiimage:onClick(self.__onclick)
end

--用于兼容原生的
local function onClick(self, ...)
    SetOnClick(self, ...)
end

local function onPolygonClick(self, ...)
    local arr = { ... }
    if #arr == 0 then
        self.unity_uiimage:onPolygonClick(nil)
        return
    end
    self.__onclick = BindCallback(...)
    self.unity_uiimage:onPolygonClick(self.__onclick)
end

local function onLongPress(self, ...)
    local arr = { ... }
    if #arr == 0 then
        self.unity_uiimage:onLongPress(nil)
        return
    end
    self.__onLongPress = BindCallback(...)
    self.unity_uiimage:onLongPress(self.__onLongPress)

end

local function onUp(self, ...)
    local arr = { ... }
    if #arr == 0 then
        self.unity_uiimage:onUp(nil)
        return
    end
    self.__onUp = BindCallback(...)
    self.unity_uiimage:onUp(self.__onUp)
end

local function onDown(self, ...)
    local arr = { ... }
    if #arr == 0 then
        self.unity_uiimage:onDown(nil)
        return
    end
    self.__onDown = BindCallback(...)
    self.unity_uiimage:onDown(self.__onDown)
end

local function SetLongPressTimes(self, time)
    if time == nil or type(time) ~= "number" then
        return
    end
    self.unity_uiimage:SetLongPressTimes(time)
end

local function SetPic(self, path, isNative)
    if IsNull(self.unity_uiimage) then
        return
    end
    -- if self._path == path then
    -- 	return
    -- end
    if isNative == nil then
        isNative = false
    end
    self.unity_uiimage:SetPic(path, isNative)
    self._path = path
    --IResourceManager:SetImage( path, self.unity_uiimage, true)
end

--设置sprite ，pathAndName 其中路径和图集中的spriteName通过分隔分开，如
-- icon/common/ui_common_img/star01 其中icon/common/ui_common_img为图集图片
-- star01为spriteNAme
local function SetSprite(self, pathAndName)
    IResourceManager:SetSprite(pathAndName, self.unity_uiimage, true)
end

local function SetIcon(self, resCfg)
    self.unity_uiimage:SetIcon(resCfg)
end

-- 销毁
local function OnDestroy(self)
    if not IsNull(self.unity_uiimage) then
        self.unity_uiimage:onClick(nil)
    end
    self.unity_uiimage = nil
    self.__onclick = nil
    base.OnDestroy(self)
end

local function SetHeroHead(self, heroid)
    self.unity_uiimage:SetHeroHead(heroid)
end

UIImage.OnCreate = OnCreate
UIImage.SetOnClick = SetOnClick
UIImage.onClick = onClick
UIImage.onPolygonClick = onPolygonClick
UIImage.onLongPress = onLongPress
UIImage.onUp = onUp
UIImage.onDown = onDown
UIImage.SetLongPressTimes = SetLongPressTimes
UIImage.OnVirtualClick = OnVirtualClick
UIImage.SetPic = SetPic
UIImage.SetIcon = SetIcon
UIImage.SetSprite = SetSprite
UIImage.OnDestroy = OnDestroy


UIImage.SetHeroHead = SetHeroHead

return UIImage
