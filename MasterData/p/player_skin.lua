-- Desc: 玩家皮肤数据
---@class Player
local Player = require "Player"
local DataLogMgr
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
end


--获取图鉴总数据
---@return SkinInfo[]
function Player:getSkinAllData()
    return self.skinList
end

--刷新看板娘数据
---@param data PosterData
function Player:updatePosterData(data)
    self.posterData = data
end

--刷新皮肤数据
---@param data SkinInfo[]   皮肤数据
function Player:updateSkinData(data)
    for key, value in pairs(data) do
        self.skinList[key] = value
    end
end

--根据皮肤ID获取皮肤数据
---@param skinID integer 皮肤ID
---@return SkinInfo?    皮肤数据
function Player:getSkinData(skinID)
    local skinList = self:getSkinAllData()
    if skinList[skinID] then
        return skinList[skinID]
    end
    return nil
end

--初始化皮肤信息
---@param skinId integer 皮肤表id
---@return SkinInfo
function Player:initSkinInfo(skinId)
    --local skinConfig = Config.GetSkinInfo(skinId)
    --构建数据
    local newSkinData = {
        getTime = luautil.getGmtStamp(),
    }
    return newSkinData
end

--添加皮肤数据
---@param skinId integer
---@param proto UserInfo
---@param balance_channel_id integer 产出消耗渠道
---@param balance_channel_detail integer 产出消耗渠道详细内容
---@return ActionFailReason 错误码
function Player:addSkin(skinId, proto, balance_channel_id, balance_channel_detail)
    local skinConfig = Config.GetCharacterSkinInfo(skinId)
    if not skinConfig then
       LuaLogger.es("not skinConfig", skinId)
        return ActionFailReason.CfgNotFind
    end

    local skinList = self:getSkinAllData()
    if skinList[skinId] then
        -- LuaLogger.es("skinList[skinId]", skinId, tablex.dump(skinList[skinId]))
        return ActionFailReason.SkinAlreadyHas
    end

    skinList[skinId] = self:initSkinInfo(skinId)

    --添加日志
    if DataLogMgr then
        DataLogMgr.LogPokedexAdd({
            pokedexId = skinId,
            type = "skin",
            balance_channel_id = balance_channel_id,
            balance_channel_detail = balance_channel_detail,
        }, self)
    end

    --添加头像
    self:addhead(skinConfig.headId, proto, balance_channel_id, balance_channel_detail)

    if proto then
        if not proto.skinList then
            proto.skinList = {}
        end
        proto.skinList[skinId] = skinList[skinId]
    end

    return ActionFailReason.None
end

--穿戴皮肤
---@param roleID integer    角色ID
---@param skinId integer    皮肤ID
---@param proto UserInfo    用户信息
---@return ActionFailReason 错误码
function Player:equipSkin(roleID, skinId, proto)
    if roleID == nil or skinId == nil then
        return ActionFailReason.ParameterInvalid
    end

    local roleData = self:getPlayerHero(roleID)
    local skinData = self:getSkinData(skinId)

    --检测皮肤数据
    if not skinData then
        return ActionFailReason.SkinNotHas
    end

    --检测角色数据
    if not roleData then
        return ActionFailReason.HeroNoFind
    end

    --检测皮肤是否属于该角色
    local skinCfg = Config.GetCharacterSkinInfo(skinId)
    if not skinCfg then
        return ActionFailReason.CfgNotFind
    end
    if skinCfg.CharacterID ~= roleData.id then
        return ActionFailReason.ParameterInvalid
    end

    roleData.equipSkin = skinId
    if proto then
        if not proto.heroList then
            proto.heroList = {}
        end
        proto.heroList[roleData.id] = roleData
    end

    return ActionFailReason.None
end

--获取看板娘数据
---@return PosterData
function Player:getPosterData()
    return self.posterData
end

--更换看板娘
---@param posterId integer  看板娘ID
---@param proto UserInfo    用户信息
---@return ActionFailReason
function Player:changePoeterId(posterId, proto)
    local skinData = self:getSkinData(posterId)

    if not skinData then
        return ActionFailReason.SkinNotHas
    end
    local posterData = self:getPosterData()
    if posterData.SkinId == posterId then
        return ActionFailReason.None
    end

    posterData.SkinId = posterId
    if proto then
        if not proto.posterData then
            proto.posterData = {}
        end
        proto.posterData = posterData
    end
    return ActionFailReason.None
end

--更换看板娘位置
---@param posData PosterData
---@param proto UserInfo
---@return ActionFailReason
function Player:changePosterPos(posData, proto)
    if not posData or not posData.PosX or not posData.PosY or not posData.Size then
        return ActionFailReason.ParameterInvalid
    end

    local posterData = self:getPosterData()
    posterData.PosX = posData.PosX
    posterData.PosY = posData.PosY
    posterData.Size = posData.Size

    if proto then
        if not proto.posterData then
            proto.posterData = {}
        end
        proto.posterData = posterData
    end

    return ActionFailReason.None
end

return Player