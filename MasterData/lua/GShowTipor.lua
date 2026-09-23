-- OPENDEBUG()
-- 错误提示的文本来行
TipAargType = {}

TipAargType.OnlyParm = 0 -- 0：只读参数
TipAargType.EmptyParm = 1 -- 1：代表参数为空
TipAargType.ItemId = 2 -- 2：代表物品id
TipAargType.CardId = 3 -- 3：代表卡牌id
TipAargType.EquipId = 4 -- 4：代表装备id
TipAargType.DupId = 5 -- 5：副本ID
TipAargType.Role = 6 -- 6：角色Id
TipAargType.SectionId = 7 -- 7：章节Id
TipAargType.Language = 8 -- 8: 多语言ID

-- 使用值对应key的名字
local tmpTb = {}
for k, v in pairs(TipAargType) do
    tmpTb[v] = k
end

for k, v in pairs(tmpTb) do
    TipAargType[k] = v
end

GCTipTool = {}

function GCTipTool:Init(tb, strId, opId, opName, obj)
    tb.strId = strId
    tb.opId = opId
    tb.opName = opName
    tb.args = {}
    tb.obj = obj
end

-- 使用方式
-- 参数：
-- plr： player
-- opId: 触发消息号
-- opName：触发的消息名称
-- strId： 客户端索引的字符id
-- ... : 变参，遵循 参数key, 参数类型， 参数值 的顺序传递, 也可以是一个 GCTipTool:OneCardArg() 这样已经格式好的table
-- 例如：
-- SendToPlr(plr, "cardIsLock", 100, "SellCard", "cardId", "CardId", 112)
function GCTipTool:SendToPlr(plr, opName, strId, ...)
    local msg = self:GetMsg(strId, opName, ...)
    plr:Send("SystemProto:Tips", msg)
    
    -- LogTrace("GCTipTool:SendToPlr")
    -- LogDebug("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
    -- LogDebug("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
    -- LogDebug("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
    plr:ShowPlrInfo("Send SystemProto:Tips " .. strId .. " from " .. (opName or ""), true)
    local tb = {...}
    LogTable(tb, "args")

-- LogDebug("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
-- LogDebug("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
-- LogDebug("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
-- LogDebug("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
end

function GCTipTool:SendToPlrEx(plr, strId, ...)
    local msg = self:GetMsg(strId, "", ...)
    plr:Send("SystemProto:Tips", msg)
end

function GCTipTool:SendToCon(conn, opName, strId, ...)
    local msg = self:GetMsg(strId, opName, ...)
    conn:send({"SystemProto:Tips", msg})
    LogDebug("Send SystemProto:Tips %s, %s to player", strId, opName)
end

-- 添加一个参数
function GCTipTool:AddArg(t, v, args)
    local key = TipAargType[t]
    if not key then
        LogError("GCTipTool:AddArg type %s error!", t)
        return
    end
    
    args = args or {}
    
    table.insert(args, {type = t, param = v})
    return args
end

-- 添加一个参数
function GCTipTool:AddKeyArg(t, k, v, args)
    local key = TipAargType[t]
    if not key then
        LogError("GCTipTool:AddArg type %s error!", t)
        return
    end
    
    args = args or {}
    
    args[k] = {type = t, param = v}
    return args
end

-- 添加一个卡牌id参数
function GCTipTool:OneCardArg(id, args)
    return self:AddArg(TipAargType.CardId, id, args)
end

-- 添加一个物品id参数
function GCTipTool:OneItemArg(id, args)
    return self:AddArg(TipAargType.ItemId, id, args)
end

-- 添加一个物品id与数量参数
function GCTipTool:OneItemNumArg(id, num, args)
    args = args or {}
    self:AddArg(TipAargType.ItemId, id, args)
    self:AddArg(TipAargType.OnlyParm, num, args)
    return args
end

-- 添加一个装备id参数
function GCTipTool:OneEquipArg(id, args)
    return self:AddArg(TipAargType.EquipId, id, args)
end

-- 角色id
function GCTipTool:OneRoleArg(id, args)
    return self:AddArg(TipAargType.Role, id, args)
end

-- 多语言id
function GCTipTool:OneLanguageArg(id, args)
    return self:AddArg(TipAargType.Language, id, args)
end

-- 添加一个配置表与索引参数
function GCTipTool:OneCfgArg(cfgName, index, args)
    args = args or {}
    self:AddArg(TipAargType.OnlyParm, cfgName, args)
    self:AddArg(TipAargType.OnlyParm, index or 0, args)
    return args
end

function GCTipTool:SendNotCfg(plr, opName, cfgName, index)
    local args = {}
    self:AddArg(TipAargType.OnlyParm, cfgName, args)
    self:AddArg(TipAargType.OnlyParm, index or 0, args)
    self:SendToPlr(plr, opName, "notCfg", args)
end

function GCTipTool:SendNotEquip(plr, opName, equipId)
    local args = self:OneEquipArg(equipId)
    self:SendToPlr(plr, opName, "equipNotFind", args)
end

function GCTipTool:SendLanguage(plr, opName, langId)
    local args = self:OneLanguageArg(langId)
    self:SendToPlr(plr, opName, "equipNotFind", args)
end

-- 添加一个副本id与数量参数
function GCTipTool:OneSectionNumArg(id, num, args)
    args = args or {}
    self:AddArg(TipAargType.SectionId, id, args)
    self:AddArg(TipAargType.OnlyParm, num, args)
    return args
end

-- 添加一个参数
function GCTipTool:OnlyParm(num, args)
    return self:AddArg(TipAargType.OnlyParm, num, args)
end

function GCTipTool:SendOnlyParms(plr, opName, strId, ...)
    local params = {...}
    self:SendOnlyParmsArr(plr, opName, strId, params)
end

function GCTipTool:SendOnlyParmsArr(plr, opName, strId, arr)
    -- LogTable(arr, " GCTipTool:SendOnlyParmsArr：" .. strId)
    arr = arr or {}
    
    local args = {}
    for _, v in ipairs(arr) do
        if v == "nil" then
            self:AddArg(TipAargType.EmptyParm, "", args)
        else
            self:OnlyParm(v, args)
        end
    end
    
    self:SendToPlr(plr, opName, strId, args)
end

-- 返回用于发送给客户端的msg消息
-- 参数类型1： 直接发送的 table
-- 参数类型2： type1, vale1, type2, value2 ....
function GCTipTool:GetMsg(strId, opName, ...)
    local msg = {
        strId = strId,
        opId = 0,
        opName = opName,
        args = nil
    }
    
    local params = {...}
    local paramLen = #params
    if paramLen > 0 then
        if "table" == type(params[1]) then
            msg.args = params[1]
        else
            if paramLen % 2 ~= 0 then
                LogError("GCTipTool:GetMsg param error!")
                LogTable(params, "params:")
                return
            end
            
            msg.args = {}
            for i = 1, paramLen, 2 do
                self:AddArg(params[i], params[i + 1], msg.args)
            end
        end
    end
    
    return msg
end

-- 游戏服使用（Use by game server)
function GCTipTool:SendTipToPlrById(plrId, strId, isTransfrom, ...)
    local msg = self:GetMsg(strId, "SendTipToPlrById", ...)
    SendToOtherPlrById(0, plrId, "SystemProto:Tips", msg)
end

function GCTipTool:SendCardTips(plr, opName, strId, cards)
    local args = {}
    for _, card in ipairs(cards) do
        GCTipTool:OneCardArg(card:Get("cid"), args)
    end
    GCTipTool:SendToPlr(plr, opName, strId, args)
end

function GCTipTool:SendCardIdTips(plr, opName, strId, cardIds)
    local args = {}
    for _, cardId in ipairs(cardIds) do
        GCTipTool:OneCardArg(cardId, args)
    end
    GCTipTool:SendToPlr(plr, opName, strId, args)
end
