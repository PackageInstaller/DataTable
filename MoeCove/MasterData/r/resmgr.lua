

local ResMgr = class("ResMgr", function (...)
    return LoadManager.Instance
end)

function ResMgr:ctor(...)
    --self.Config = nil -- Table
    self._cache = {}
    self.spriteDefault = nil
    if EngineUtil.IsWebGL() then
        self:UseCache()
    end
    self.resCarrier = nil
    self.poolResCarrier = nil --PoolMgr专用资源owner
end

function ResMgr:Clear()
	--self:clear()
    self._cache = {}
end

function ResMgr:UseCache()
    self.use_cache = true
end


function ResMgr:SetCache(file, obj)
    if not self.use_cache then
        return
    end
    self._cache[file] = obj
end

function ResMgr:GetCache(file)
    if not self.use_cache then
        return
    end
    return self._cache[file]
end

function ResMgr:LoadLuaTable()
    require "CommonType"
    require "ClientType"
    --self.Config = require("Config").Load()
    require "CommonConstant"
    require "ClientConfig"
    require "ClientConstant"
end


function ResMgr:LoadConfig()
    local resCfg = self:ResourceLoadText("Origin/config", true)
    local cjson = require "cjson"
    self.config = cjson.decode(resCfg)
    self.config.resHost = EngineGlobal.resHost
    self.config.secretId = EngineGlobal.secretId
    self.config.secretKey = EngineGlobal.secretKey
end


function ResMgr:NewResourceVersion()
    if EngineGlobal.useNewResource then
        return true
    end
end

function ResMgr:GetSpriteDefault()
    return self.spriteDefault
end

function ResMgr:LoadSpriteAsyncLua(path, requestId, callback)
    if self:NewResourceVersion() then
        self:LoadSpriteAsync(path, requestId, callback)
    else
        self:LoadSpriteAsync(path, callback)
    end
end


function ResMgr:LoadSpriteSyncLua(path, requestId)
    if self:NewResourceVersion() then
        return self:LoadSpriteSync(path, requestId)
    else
        return self:LoadSpriteSync(path)
    end
end

function ResMgr:loadSpriteDefault()
    if not IsNull(self.spriteDefault) then
        return
    end
    self:LoadSpriteAsync(Config.SpritePath.LoadSpriteMask, self.gameObject, function (sprite)
        self.spriteDefault = sprite
    end)
end

-- WebGL环境下同步加载全局替换为异步
function ResMgr:LoadSprite(path, requestId, spriteComponent, callBack, useCache)
    requestId = requestId or -1
    if EngineUtil.IsWebGL() then
        if self.spriteDefault and spriteComponent then
            if tolua.getpeer(spriteComponent) == nil then
                tolua.setpeer(spriteComponent, {})
            end
            local spriteTable = tolua.getpeer(spriteComponent)
            if not spriteTable.defaultSpriteLoaded then
                spriteComponent.sprite = self.spriteDefault
                spriteTable.defaultSpriteLoaded = true
            end
        end
        if useCache then
            local sprite = self:GetCache(path)
            if sprite then
                if sprite and spriteComponent then
                    spriteComponent.sprite = sprite
                end
                if callBack then
                    callBack(sprite)
                end
                return
            end
        end
        self:LoadSpriteAsyncLua(path, requestId, function(sprite)
            if useCache then
                self:SetCache(path, sprite)
            end
            if sprite and spriteComponent then
                spriteComponent.sprite = sprite
            end
            if callBack then
                callBack(sprite)
            end
        end)
    else
        local sprite = self:LoadSpriteSyncLua(path, requestId)
        if sprite and spriteComponent then
            spriteComponent.sprite = sprite
        end
        if callBack then
            callBack(sprite)
        end
    end
end

function ResMgr:LoadSprite_Old(path, callback)
    LuaMain:LoadSprite(path, nil, callback)
end

-- WebGL环境下预制体加载改为异步
function ResMgr:LoadPrefab(path, callback)
    -- if EngineUtil.IsWebGL() then
        self:LoadAsync(path, callback)
    -- else
    --     local effect = self:LoadSync(path)
    --     callback(effect)
    -- end
end

---异步回调Prefab
---@param path string
---@param callback fun(obj:UnityEngine.GameObject)
function ResMgr:LoadPrefabAsync(path, callback)
    self:LoadPrefabAsyncInOwner(path, callback, self:GetResCarrier())
end

function ResMgr:LoadGameObjectAsync(path, callback, num)
    self:LoadGameObjectAsyncInOwner(path, callback, self:GetResCarrier(), num)
end

function ResMgr:LoadPrefabAsyncInOwner(path, callback, owner)
    self:LoadAsync(path, owner, callback)
end

function ResMgr:LoadGameObjectAsyncInOwner(path, callback, owner, num)
    self:LoadPrefabAsyncInOwner(path, function(asset)
        if asset == nil then
            if callback then
                callback(nil)
            end
            return
        end

        PoolMgr:InstantiateGameObjectAsync(owner, asset, function(go, index)
            if callback then
                callback(go, index)
            end
        end, num)

    end, owner)
end

function ResMgr:LoadMaterialAsyncInOwner(path, callback, owner)
	self:LoadMaterialAsync(path, owner, callback)
end

function ResMgr:LoadSpriteAsyncInOwner(path, callback, owner)
	self:LoadSpriteAsync(path, owner, callback)
end

function ResMgr:LoadCurveLibraryAsyncInOwner(path, callback, owner)
	self:LoadCurveLibraryAsync(path, owner, callback)
end
function ResMgr:LoadFontAsyncInOwner(path, callback, owner)
	self:LoadFontAsync(path, owner, callback)
end
function ResMgr:LoadSceneAsyncLua(path, additive, callback)
	LuaMain:LoadSceneAsync(path, additive, callback)
end

function ResMgr:GetResCarrier()
    if not self.resCarrier or IsNull(self.resCarrier.gameObject) then
        self.resCarrier = GameObject.New("ResCarrier")
    end
    -- LuaLogger.ds("ResMgr:GetResCarrier", self.resCarrier.gameObject)
    return self.resCarrier
end

function ResMgr:GetGlobalResCarrier()
    return LuaMain.gameObject
end

function ResMgr:GetPoolResCarrier()
    if not self.poolResCarrier or IsNull(self.poolResCarrier.gameObject) then
        self.poolResCarrier = GameObject.New("PoolResCarrier")
    end
    return self.poolResCarrier
end

-- function ResMgr:IsHeadExit(id)
-- 	return self:LoadSprite("UI/Head/head" .. id .. ".png") ~= nil
-- end

function ResMgr:GetHeadSpritePath(name)
    return "UI/Head/" .. name.. ".png"
end

-- function ResMgr:LoadHeadSprite(id, spriteComponent, callBack, requestId)
-- 	self:LoadSprite(self:GetHeadSpritePath(id), requestId, spriteComponent, callBack, true)
-- end

function ResMgr:GetSpineGraphicPath(name)
    return "Prefabs/Animation/Spine/" .. name.. ".prefab"
end

-- function ResMgr:LoadSpineGraphic(path, callBack)
--     self:LoadPrefab("Prefabs/Animation/Spine/".. path .. ".prefab", callBack)
-- end

function ResMgr:GetCharQImgSpritePath(path)
    return "UI/CharQ/" .. path.. ".png"
end

-- function ResMgr:LoadCharQImgSprite(path, spriteComponent, callBack)
-- 	self:LoadSprite("UI/CharQ/" .. path.. ".png", spriteComponent, callBack)
-- end

function ResMgr:GetCharImgSpritePath(id)
    return "UI/Char/" .. id.. ".png"
end

-- function ResMgr:LoadCharImgSprite(id, spriteComponent, callBack)
-- 	self:LoadSprite("UI/Char/" .. id.. ".png", spriteComponent, callBack)
-- end

function ResMgr:GetCharSmallImgSpritePath(id)
    return "UI/CharSmall/" .. id.. ".png"
end

-- function ResMgr:LoadCharSmallImgSprite(id, spriteComponent, callBack)
-- 	self:LoadSprite("UI/CharSmall/" .. id.. ".png", spriteComponent, callBack)
-- end

function ResMgr:GetLevelImageSpritePath(name)
    return "UI/LevelImage/" .. name.. ".jpg"
end

-- function ResMgr:LoadLevelImageSprite(id, spriteComponent, callBack, requestId)
--     self:LoadSprite(self:GetLevelImageSpritePath(id), requestId, spriteComponent, callBack)
-- end

function ResMgr:GetLianGongFangSpritePath(name)
    return "UI/LianGongFang/" .. name.. ".png"
end

-- function ResMgr:LoadLianGongFangSprite(id, spriteComponent, callBack, requestId)
--     self:LoadSprite(self:GetLianGongFangSpritePath(id), requestId, spriteComponent, callBack)
-- end

function ResMgr:GetEffectPath(id)
    return "Effect/" .. id.. ".prefab"
end

-- function ResMgr:LoadEffect(id, callback)
--     self:LoadPrefab("Effect/" .. id.. ".prefab", callback)
-- end

function ResMgr:GetBattleEffect(id)
    return "Effect/Battle/" .. id.. ".prefab"
end

-- function ResMgr:LoadBattleEffect(id, callback, requestId)
--     self:LoadPrefab(self:GetBattleEffect(id), requestId, callback)
-- end

function ResMgr:GetUniqueEquipSpritePath(name)
    return "UI/UniqueEquip/uniqueequip_" .. name.. ".png"
end

-- function ResMgr:LoadUniqueEquipSprite(id, spriteComponent, callBack, requestId)
--     self:LoadSprite(self:GetUniqueEquipSpritePath(id), requestId, spriteComponent, callBack)
-- end

function ResMgr:GetHunYuanWuXingSpritePath(name)
    return "UI/hunyuanwuxing/" .. name.. ".png"
end

-- function ResMgr:LoadHunYuanWuXingSprite(id, spriteComponent, callBack, requestId)
--     return self:LoadSprite(self:GetHunYuanWuXingSpritePath(id), requestId, spriteComponent, callBack)
-- end

function ResMgr:GetMoonIdentifySpritePath(name)
    return "UI/MoonIdentify/" .. name.. ".png"
end

-- function ResMgr:LoadMoonIdentifySprite(id, spriteComponent, callBack, requestId)
--     self:LoadSprite(self:GetMoonIdentifySpritePath(id), requestId, spriteComponent, callBack)
-- end

function ResMgr:GetTikTokSpritePath(name)
    return "UI/Tiktok/" .. name.. ".jpg"
end

-- function ResMgr:LoadTikTokSprite(name, spriteComponent, callBack, requestId)
--     self:LoadSprite(self:GetTikTokSpritePath(name), requestId, spriteComponent, callBack)
-- end


function ResMgr:GetTikTokPngSpritePath(name)
    return "UI/Tiktok/" .. name.. ".png"
end

-- function ResMgr:LoadTikTokPngSprite(name, spriteComponent, callBack, requestId)
--     self:LoadSprite(self:GetTikTokPngSpritePath(name), requestId, spriteComponent, callBack)
-- end

function ResMgr:GetGiftPreviewSpritePath(name)
    return "UI/GiftPreview/" .. name.. ".jpg"
end

-- function ResMgr:LoadGiftPreviewSprite(name, spriteComponent, callBack, requestId)
--     self:LoadSprite(self:GetGiftPreviewSpritePath(name), requestId, spriteComponent, callBack)
-- end

function ResMgr:GetEscortSpritePath(name, spriteComponent, callBack)
    return "UI/Escort/" .. name.. ".png"
end

--function ResMgr:LoadEscortSprite(name, spriteComponent, callBack)
--    self:LoadSprite("UI/Escort/" .. name.. ".png", spriteComponent, callBack)
--end
return ResMgr