local isLive2D = true -- 是否使用spine
local isMul = nil -- 是不是多人插图 
local playCallBack = nil
local endCallBack = nil
local needClick = false
local modelId = nil
local posType = nil
local callBack = nil
local cfg = nil
local isUseShopImg = false
local itemLua1 = nil
local itemLua2 = nil
local isInit = false

function Awake()
    local arr = CSAPI.GetScreenSize()
    CSAPI.SetRTSize(gameObject, arr[0], arr[1])
end

function Init(_playCB, _endCB, _needClick, _isMul)
    playCallBack = _playCB
    endCallBack = _endCB
    needClick = (_needClick ~= nil) and _needClick or false
    --isMul = _isMul
    isInit = true
end

-- _force 强制l2d显示或者隐藏 _isUseShopImg:是否使用特殊宣传图（仅商店）
function Refresh(_modelId, _posType, _callBack, _force, _isUseShopImg, _needClick)
    if (not isInit and _modelId == nil or _posType == nil) then
        return
    end
    isMul = _modelId < 10000
    --
    modelId = _modelId
    posType = _posType
    callBack = _callBack
    cfg = isMul and Cfgs.CfgArchiveMultiPicture:GetByID(modelId) or Cfgs.character:GetByID(modelId)
    isUseShopImg = _isUseShopImg
    if (_needClick ~= nil) then
        needClick = _needClick
    end
    if (not cfg.l2dName) then
        isLive2D = false
    else
        if (_force ~= nil) then
            -- 强制处理，不记录
            isLive2D = _force
        else
            isLive2D = true -- 默认查看
        end
    end
    if (cfg) then
        SetItem(1, isLive2D)
        SetItem(2, not isLive2D)
    else
        SetItem(1, false)
        SetItem(2, false)
    end
end

function SetItem(index, isHide)
    local item = itemLua2
    if (index == 1) then
        item = itemLua1
    end
    if (isHide) then
        if (item) then
            CSAPI.SetGOActive(item.gameObject, false)
        end
        return
    end
    if (item == nil) then
        local path = "Common/RoleSpineItem" .. index
        local go = ResUtil:CreateUIGO(path, transform)
        item = ComUtil.GetLuaTable(go)
        item.Init(playCallBack, endCallBack, needClick, isMul)
        if (index == 1) then
            itemLua1 = item
        else
            itemLua2 = item
        end
    else
        CSAPI.SetGOActive(item.gameObject, true)
    end
    item.Refresh(modelId, posType, callBack, isUseShopImg, needClick)
end

function SetClickActive(b)
    if (isLive2D) then
        if (itemLua2) then
            itemLua2.SetClickActive(b)
        end
    else
        if (itemLua1) then
            itemLua1.SetClickActive(b)
        end
    end
end

function PlayVoice(_type)
    if (isLive2D) then
        if (itemLua2) then
            itemLua2.PlayVoice(_type)
        end
    else
        if (itemLua1) then
            itemLua1.PlayVoice(_type)
        end
    end
end

function PlayVoiceByID(id)
    if (isLive2D) then
        if (itemLua2) then
            itemLua2.PlayVoiceByID(id)
        end
    else
        if (itemLua1) then
            itemLua1.PlayVoiceByID(id)
        end
    end
end

-- 模型表上设置的大小（已加上偏移）
function GetCfgScale()
    local scale = 1
    if (isLive2D) then
        if (itemLua2) then
            scale = itemLua2.GetImgScale()
        end
    else
        if (itemLua1) then
            scale = itemLua1.GetImgScale()
        end
    end
    return scale
end

function IsLive2D()
    return isLive2D
end

-- 拉扯
function PlayLC()
    if (not isMul and not isLive2D) then
        itemLua1.PlayLC()
    end
end

-- 是否有进场动画 
function CheckIn()
    if (cfg.l2dName and itemLua2) then
        return itemLua2.CheckIn()
    end
    return false
end

-- 播放入场动画
function PlayIn(cb, movePoint)
    if (itemLua2) then
        itemLua2.PlayIn(cb, movePoint)
    end
end

-- 是否有开场动画语音
function HadInAudio()
    if (not isMul and isLive2D) then
        return itemLua2.HadInAudio()
    end
    return false
end

function EnNeedClick(b)
    needClick = b
    if (isLive2D) then
        if (itemLua2) then
            itemLua2.needClick = needClick
        end
    else
        if (itemLua1) then
            itemLua1.needClick = needClick
        end
    end
end

function ClearCache()
    local itemLua = isLive2D and itemLua2 or itemLua1
    if (itemLua and itemLua.ClearCache ~= nil) then
        itemLua.ClearCache()
    end
end

function SetLiveBroadcast()
    if (isLive2D) then
        if (itemLua2) then
            itemLua2.SetBlack()
            itemLua2.SetHXBlack()
        end
    else
        if (itemLua1) then
            itemLua1.SetBlack()
            itemLua1.SetHXBlack()
        end
    end
end

function GetModelID()
    return modelId
end
