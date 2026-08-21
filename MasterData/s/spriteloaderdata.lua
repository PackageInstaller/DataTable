---@class SpriteLoaderData 加载spirte对象
local SpriteLoaderData = class("SpriteLoaderData")

---@type SpriteLoaderData[]
local pool = {}
---@param image UnityEngine.UI.Image
---@param path string
---@param callback fun(sprite:UnityEngine.Sprite, image:UnityEngine.UI.Image, path:string)?
function SpriteLoaderData:ctor()
    ---@type number
    self.id = nil
    ---@type UnityEngine.UI.Image
    self.image = nil
    ---@type string
    self.loadPath = nil
    ---@type string
    self.loadingPath = nil
    ---@type string
    self.spriteName = nil
    ---@type fun(sprite:UnityEngine.Sprite, image:UnityEngine.UI.Image, path:string)?
    self.callback = nil
end
function SpriteLoaderData:Init()
    if IsNull(self.image) then
        return
    end
    self.image.sprite = ResMgr:GetSpriteDefault()
end

---@param sprite UnityEngine.Sprite
---@param path string
function SpriteLoaderData:Loader(sprite, path)
    if IsNull(self.image) then
        UIMgr:DeleteImageLoader(self.id)
        return 
    end
    if self.loadingPath ~= path then
        return
    end
    self.loadingPath = nil
    self.loadPath = path
    self.image.sprite = sprite
    if self.callback ~= nil then
        self.callback(sprite, self.image, path)
    end
    UIMgr:DeleteImageLoader(self.id)
end

function SpriteLoaderData:OnDestroy()
    self.image = nil
    self.callback = nil
end



function SpriteLoaderData:OnRelease()
    self:OnDestroy()
    table.insert(pool, self)
end

---获得对象池
function SpriteLoaderData.GetEmptyData()
    local c = #pool
    if c == 0  then
        return nil
    end
    local character = pool[c]
    table.remove(pool, c)
    return character
end

function SpriteLoaderData.ClearPool()
    for i = 1, #pool do
        local c = pool[i]
        pool[i]:Delete()
    end
    pool = {}
end

---@return SpriteLoaderData
function SpriteLoaderData:InitData()
    local playerData = self.GetEmptyData()
    if playerData ~= nil then
        playerData:ctor()
    else
        playerData = self:new()
    end
    return playerData
end

return SpriteLoaderData 