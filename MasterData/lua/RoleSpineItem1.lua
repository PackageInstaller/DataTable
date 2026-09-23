local playCallBack = nil
local endCallBack = nil
local needClick = nil
local isMul = nil -- 是不是多人插图
local modelId = nil
local posType = nil
local callBack = nil
local isActive = true
local imgScale = 1
local oldModelId = nil
local clickRecords = {}
local isUseShopImg = nil
local faceLua = nil
local cfg = nil
local touchItems = nil
local touchDatas = {}
local img_imgObj = nil
local isInit = false
local isHX = false -- 小开关+配了遮挡预制体

function Awake()
    img_imgObj = ComUtil.GetCom(imgObj, "Image")
end

-- _needClick:是否可点触发语音，固定播放的情景（出击时、胜利时等是不需要的）
function Init(_playCB, _endCB, _needClick, _isMul)
    playCallBack = _playCB
    endCallBack = _endCB
    needClick = (_needClick ~= nil) and _needClick or false
    -- isMul = _isMul
    -- CSAPI.SetImgColor(imgObj, 255, 255, 255, isMul and 255 or 0)
    isInit = true

    SetClickActive(needClick)
end

-- _isUseShopImg:是否使用特殊宣传图
function Refresh(_modelId, _posType, _callBack, _isUseShopImg, _needClick)
    if (not isInit and _modelId == nil or _posType == nil) then
        return
    end
    isMul = _modelId < 10000
    CSAPI.SetImgColor(imgObj, 255, 255, 255, isMul and 255 or 0)
    --
    modelId = _modelId
    posType = _posType
    callBack = _callBack
    if isUseShopImg and isUseShopImg ~= _isUseShopImg then
        oldModelId = ""
    end
    isUseShopImg = _isUseShopImg
    if (_needClick ~= nil) then
        needClick = _needClick
    end
    -- 重置点击记录
    if (oldModelId ~= nil) then
        if (oldModelId ~= _modelId) then
            clickRecords = {}
        else
            if (callBack) then
                callBack()
            end
            return
        end
    end
    -- 
    ClearCache()
    --
    isHX = false
    local _cfg = isMul and Cfgs.CfgArchiveMultiPicture:GetByID(modelId) or Cfgs.character:GetByID(modelId)
    if (_cfg and _cfg.hxact and CSAPI.CheckFHX()~=nil and not CSAPI.CheckFHX()) then
        isHX = true
    end
    SetHX(_cfg.id)
    -- 
    oldModelId = _modelId
    CSAPI.SetGOActive(faceNode, not isMul)
    if (isMul) then
        SetBlack()
        SetTouch()
        SetImg()
    else
        SetTouch()
        SetFaceItem()
    end
    -- 移除spine状态记录
    RoleTool.SaveSpineState(nil)
end

-- isBlack 设置为黑色（剧情时可能）
function SetBlack(isBlack)
    if (isMul) then
        if imgObj then
            UIUtil:SetLiveBroadcast2(imgObj, isBlack)
        end
    else
        if faceLua then
            faceLua.SetBlack(isBlack)
        end
    end
    --
    SetHXBlack(isBlack)
end

-- 位置触摸
function SetTouch()
    touchItems = touchItems or {}
    touchDatas = {}
    if (needClick) then
        local cfg = isMul and Cfgs.CfgMultiImageAction:GetByID(modelId) or Cfgs.CfgImageAction:GetByID(modelId)
        if (cfg and #cfg.item > 0) then
            touchDatas = cfg.item
        end
    end
    ItemUtil.AddItems("Common/CardTouchItem", touchItems, touchDatas, imgObj, PlayAudio, 1, this)
end

function SetImg()
    local pos, scale, img, l2dName = RoleTool.GetMulImgPosScale(modelId, posType)
    cfg = Cfgs.CfgArchiveMultiPicture:GetByID(modelId)
    ResUtil.MultiImg:Load(imgObj, isUseShopImg and cfg.img_replace or cfg.img, nil, true)
    CSAPI.SetAnchor(imgObj, pos.x, pos.y, pos.z)
    CSAPI.SetScale(imgObj, scale, scale, 1)
    if (callBack) then
        callBack()
    end
    imgScale = scale
end

function SetFaceItem()
    if (not faceLua) then
        local go = ResUtil:CreateUIGO("Common/CharacterImgItem", faceNode.transform)
        faceLua = ComUtil.GetLuaTable(go)
    end
    faceLua.Init(modelId, CreateFaceCB, isUseShopImg)
    SetBlack()
end

-- 加载立绘后回调
function CreateFaceCB(_img)
    local pos, scale, img, l2dName = RoleTool.GetImgPosScale(modelId, posType)
    CSAPI.SetGOActive(faceNode, true)
    CSAPI.SetAnchor(imgObj, pos.x, pos.y, pos.z)
    CSAPI.SetScale(imgObj, scale, scale, 1)
    local size = CSAPI.GetRTSize(_img)
    CSAPI.SetRTSize(imgObj, size[0], size[1]) -- 设置碰撞体的大小
    if (callBack) then
        callBack()
    end
    imgScale = scale * posType[3]
end

function PlayAudio(cfgChild)
    MissionMgr:DoClickBoard()
    if (RoleAudioPlayMgr:GetIsPlaying()) then
        return
    end
    local audioIds = cfgChild.audioId
    if (audioIds) then
        local audioId, newIndex = nil, nil
        local oldIndex = clickRecords[cfgChild.index]
        local len = #audioIds
        if (len == 1 or oldIndex == nil) then
            audioId = audioIds[1]
            newIndex = 1
        else
            newIndex = oldIndex
            while audioId == nil do
                newIndex = (newIndex + 1) > len and 1 or (newIndex + 1)
                if (newIndex == oldIndex) then
                    audioId = audioIds[newIndex]
                    break
                end
                -- 是否可用 
                local _audioId = audioIds[newIndex]
                local isOpen = true
                if (not isMul) then
                    isOpen = RoleAudioPlayMgr:CheckAndioIsOpen(modelId, _audioId)
                end
                if (isOpen) then
                    audioId = _audioId
                    break
                end
            end
        end
        clickRecords[cfgChild.index] = newIndex
        local _modelId = modelId
        if (isMul) then
            _modelId = nil
        end
        RoleAudioPlayMgr:PlayById(_modelId, audioId, PlayCB, EndCB)
    end
end

function SetClickActive(b)
    isActive = b
    img_imgObj.raycastTarget = b
end

-- 点击
function OnClick()
    if (not needClick) then
        return
    end
    PlayVoice()
    MissionMgr:DoClickBoard()
end

-- 类型
function PlayVoice(type)
    if (isMul) then
        return -- 多人插图没有点触语音
    end
    type = type == nil and RoleAudioType.touch or type
    if (type == RoleAudioType.touch) then
        local cfg = Cfgs.character:GetByID(modelId)
        if (cfg and cfg.base_voiceID ~= nil) then
            return -- 如果是商城皮肤并且填了保底台词，则不需要普通触摸语音
        end
    end
    if (not RoleAudioPlayMgr:GetIsPlaying()) then
        RoleAudioPlayMgr:PlayByType(modelId, type, nil, PlayCB, EndCB)
    end
end

-- 声音id
function PlayVoiceByID(id)
    if (not RoleAudioPlayMgr:GetIsPlaying()) then
        local _modelId = modelId
        if (isMul) then
            _modelId = nil
        end
        RoleAudioPlayMgr:PlayById(_modelId, id, PlayCB, EndCB)
    end
end

function PlayCB(curCfg)
    if (not isMul) then
        faceLua.SetFaceByIndex(curCfg.faceIndex)
    end
    if (playCallBack) then
        playCallBack(curCfg)
    end
end

function EndCB()
    if (not isMul) then
        faceLua.HideFace()
    end
    if (endCallBack) then
        endCallBack()
    end
end

function GetImgScale()
    if (isMul) then
        return {
            [0] = 2240,
            [1] = 1080
        }
    else
        return imgScale or 1
    end
end

-- 拉扯
function PlayLC()
    if (not isMul) then
        faceLua.PlayLC()
    end
end

function GetIconName()
    return cfg.icon
end

function ClearCache()
    oldModelId = nil
    clickRecords = {}
end

-- 和谐预制体
function SetHX(_id)
    if (hxObj) then
        CSAPI.RemoveGO(hxObj)
        hxObj = nil
    end
    if (isHX) then
        local path = "SpineHX/" .. _id .. "/" .. _id
        CSAPI.CreateGOAsync(path, 0, 0, 0, gameObject, function(go)
            hxObj = go
            -- 
            local offset = posType or {0, 0, 1}
            CSAPI.SetAnchor(hxObj, offset[1], offset[2])
            CSAPI.SetScale(hxObj, offset[3], offset[3], 1)
        end)
    end
end

function SetHXBlack(isBlack)
    if (hxObj) then
        local childCount = hxObj.transform.childCount - 1
        for i = 0, childCount do
            local child = hxObj.transform:GetChild(i).gameObject
            UIUtil:SetLiveBroadcast2(child, isBlack)
        end
    end
end

function CheckHX()
    return isHX
end