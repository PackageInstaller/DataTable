local imgScale = 1
local hideTxt = false
local graphic = nil
local spineTools = nil
local oldModelId = nil
local records = {} -- 动作组播放进度记录+单动画播放到指定百分比 (key:index value:下标)
local dragObj = nil -- 当前拖放的物体
local dragStartPos = nil -- 当前拖放开始的位置
local dragTargetPos = nil -- 当前拖放目标位置
local isDrag = false
local isHeXie = false -- 和谐了 (旧版，物理层面，spine预制体上的脚本给移除了)
local inter = 0.5
local timer = 0
local curRoleNum = 1 -- 使用第几套人物
local changeCfg = nil -- 变幻到第二套人物的cfg
local interludeGO = nil -- 切换人物的过场go
local l2dName
local spineUI = nil
local img_imgObj
local isMul
local isInit = false
local changeIdleData = nil
local clickCount = {} -- 点击次数
local spineState = {}
local baseL2dName2 = nil
local baseIdleName = nil
local isHX = false -- 小开关+配了遮挡预制体 （新版，spine预制体不变）

function Awake()
    img_imgObj = ComUtil.GetCom(imgObj, "Image")
    spineTools = SpineTools.New()
end

function Init(_playCB, _endCB, _needClick, _isMul)
    playCallBack = _playCB
    endCallBack = _endCB
    needClick = (_needClick ~= nil) and _needClick or false
    -- isMul = _isMul
    -- CSAPI.SetGOActive(imgObj, not isMul)
    isInit = true
end
function Refresh(_modelId, _posType, _callBack, _isUseShopImg, _needClick)
    if (not isInit or _modelId == nil or _posType == nil) then
        return
    end
    isMul = _modelId < 10000
    CSAPI.SetGOActive(imgObj, not isMul)
    --
    modelId = _modelId
    posType = _posType
    callBack = _callBack
    if (_needClick ~= nil) then
        needClick = _needClick
    end
    -- 重置点击记录
    if (oldModelId and oldModelId == _modelId) then
        if (callBack) then
            callBack()
        end
        return -- 相同的话不往下
    end
    oldModelId = _modelId
    baseIdleName = nil
    -- 
    CrearData()
    -- 和谐
    isHX = false
    local _cfg = isMul and Cfgs.CfgArchiveMultiPicture:GetByID(modelId) or Cfgs.character:GetByID(modelId)
    if (_cfg and _cfg.hxact and CSAPI.CheckFHX()~=nil and not CSAPI.CheckFHX()) then
        isHX = true
    end
    SetHX(_cfg.id)
    -- 
    cfg = isMul and Cfgs.CfgSpineMultiImageAction:GetByID(modelId) or Cfgs.CfgSpineAction:GetByID(modelId)
    SetImg()
end

function SetImg(_l2dName, _b, _cb)
    local b = true
    if (_b ~= nil) then
        b = _b
    end
    local pos, scale, img, l2dName2
    if (isMul) then
        pos, scale, img, l2dName2 = RoleTool.GetMulImgPosScale(modelId, posType, true)
    else
        pos, scale, img, l2dName2 = RoleTool.GetImgPosScale(modelId, posType, true)
    end
    CSAPI.SetAnchor(prefabObj, pos.x, pos.y, pos.z)
    CSAPI.SetScale(prefabObj, scale, scale, 1)
    --
    baseL2dName2 = l2dName2
    l2dName = _l2dName or l2dName2
    if (l2dName) then
        if (l2dGo) then
            CSAPI.RemoveGO(l2dGo)
            l2dGo = nil
        end
        ResUtil:CreateSpine(l2dName .. "/" .. l2dName, 0, 0, 0, prefabObj, function(go)
            l2dGo = go
            local l2d = ComUtil.GetCom(l2dGo, "CSpine")
            graphic = ComUtil.GetComInChildren(l2dGo, "SkeletonGraphic")
            if (l2d) then
                spineTools:Init(l2d, SpineEvent)
            end
            isHeXie = false
            if (not l2d or not l2d.animationState) then
                isHeXie = true
            end
            -- 
            if (not baseIdleName and spineTools.anim ~= nil) then
                baseIdleName = spineTools:GetNameByTrackIndex(0)
            end
            SetBlack()
            SetTouch()
            -- 按保存的状态初始化 
            ChangeByOldState()
            -- 
            if (b and callBack) then
                callBack()
            end
            if (_cb) then
                _cb()
            end
            -- 切换spine
            if (_l2dName ~= nil) then
                RestoreClicks()
            end
        end)
    end

    imgScale = scale * posType[3]
    SetClickImg()
end

-- img 不显示，用于普通点击 
function SetClickImg()
    if (isMul) then
        return
    end
    local pos, scale, img, l2dName = RoleTool.GetImgPosScale(modelId, posType, false)
    CSAPI.SetAnchor(imgObj, pos.x, pos.y, pos.z)
    CSAPI.SetScale(imgObj, scale, scale, 1)
    ResUtil.ImgCharacter:Load(imgObj, img)
end

-- 位置触摸
function SetTouch()
    touchItems = touchItems or {}
    touchDatas = {}
    if (needClick) then
        if (cfg and #cfg.item > 0) then
            for k, v in ipairs(cfg.item) do
                if (v.sName ~= "in" and v.areas ~= nil) then
                    table.insert(touchDatas, v)
                end
            end
        end
    end
    ItemUtil.AddItems("Common/CardTouchItem", touchItems, touchDatas, prefabObj, TouchItemClickCB, 1, this)
end

-- 点击触发
-- _check 检查过场spine是否存在（存在时不让玩家点击），changerole时如果后接更换idle
function TouchItemClickCB(cfgChild, _cb, _check, _isCan)
    local check = true
    if (_check ~= nil) then
        check = _check
    end
    if (check and interludeGO ~= nil) then
        return
    end
    if (Time.time < timer) then
        return
    end
    timer = Time.time + inter

    if (isHeXie or isIn or isDrag) then -- or RoleAudioPlayMgr:GetIsPlaying()) then
        return
    end
    local content = cfgChild.content or {}
    -- 是否满足点击条件(另外一个的播放进度)
    if (content.conditions) then
        local _cfg = cfg.item[content.conditions[1]]
        local trackIndex = GetTrackIndex(_cfg)
        local b, cur = spineTools:GetTrackTimePercent(trackIndex)
        --2个数时，第二个数如果是0，表示该动作不能播，大于0时，表示该动作需要播放到指定百分比
        --3个数时，表示该动作的播放区域需要在第二到第三个数之间，包含第二第三个数
        if (#content.conditions == 2) then
            if (content.conditions[2] == 0) then
                if (b) then
                    return
                end
            else
                if (not b or cur < content.conditions[2]) then
                    return
                end
            end
        else
            local max = content.conditions[3] or 1
            if (cur < content.conditions[2] or cur > max) then
                return
            end
        end
    end
    -- 轨道
    local trackIndex = GetTrackIndex(cfgChild)
    local isCan = _isCan or false
    if (isCan) then
        -- 必定可执行
    elseif (trackIndex == 1) then
        -- 1轨道需要在idle状态下才能点击 或 前后都是同一多动作，并且不是最后一个动作
        if (not isCan and IsIdle() or content.actions ~= nil) then
            isCan = true
        end
        -- 如果某个多段点击进度处于非0状态，也不能点击 
        if (content.noClick) then
            for k, v in pairs(content.noClick) do
                local _trackIndex = GetTrackIndex(cfg.item[v])
                if (not spineTools:CheckTrackIsInStar(_trackIndex)) then -- 某多段点击还在激发状态
                    isCan = false
                    break
                end
            end
        end
    elseif (content and content.guochange) then -- 如果是过场动作，未播完不能再次点
        if (IsIdle() and spineTools:CheckCanPlay(trackIndex)) then
            isCan = true
        end
    else
        -- 需要idle才能播放
        if (content and content.needIdle) then
            isCan = IsIdle()
        else
            isCan = true
        end
    end
    -- 需要先点击其他动作
    if (isCan and content.needClicks) then
        for k, v in pairs(content.needClicks) do
            if (not clickCount[v]) then
                isCan = false
            end
        end
    end
    if (not isCan) then
        return
    end
    local sName = cfgChild.sName
    local mulData = {
        timeScale = 1,
        progress = 1,
        isClicksLast = false
    }
    -- content内容
    if (cfgChild.content) then
        sName, mulData = SetContent(cfgChild)
    end
    -- if (not sName) then
    --     return
    -- end
    if (isCan) then
        -- 重置某些下标对应的轨道
        if (content.reset7) then
            ResetByIndex(content.reset7)
        end
        -- 
        local b = false
        if (trackIndex ~= 1 and content.clicks ~= nil and sName ~= nil) then
            mulData.perCB = _cb
            b = spineTools:PlayByMulClick(sName, trackIndex, mulData)
        elseif (content.actions ~= nil and sName ~= nil) then
            -- 首次播放或者再次点击
            local _sName = spineTools:GetNameByTrackIndex(trackIndex)
            if (sName == _sName) then
                spineTools:ResetActionsClick(trackIndex, content.actions.stopPerc, content.actions.stopLimit)
            elseif (not _sName) then
                b = spineTools:PlayByActionsClick(sName, trackIndex, true, true, nil, content.actions.stopPerc,
                    content.actions.stopTime, content.actions.stopCount)
            end
        else
            -- 切换idle(移除除了自身动作轨道和忽略的动作轨道外的所有轨道)
            if (content.changeIdle) then
                local time = Time.time + content.changeIdle[2] / 1000
                changeIdleData = {time, cfgChild}
            end
            --
            SetInterlude(content)
            local cb, delay = nil, 0
            if (_cb) then
                cb = _cb
            else
                cb, delay = GetClickCB(cfgChild)
            end
            if (sName ~= nil) then
                local b1, b2 = true, true
                if (content.noFade) then
                    b1 = false
                elseif (trackIndex ~= 1 and content.guochange == nil) then -- 轨道为1或者有过场时需要渐出
                    b2 = false
                end
                b = spineTools:PlayByClick(sName, trackIndex, b1, b2, cb)
            else
                if (delay > 0) then
                    FuncUtil:Call(function()
                        timer = 0
                        if (cb) then
                            cb()
                        end
                    end, nil, delay)
                else
                    timer = 0
                    if (cb) then
                        cb()
                    end
                end
            end
        end
        if (b) then
            PlayAudio(cfgChild)
            MissionMgr:DoClickBoard()
            --SetMenuMask(cfgChild)
        end
    end
    -- 点击记录 
    local num = clickCount[cfgChild.index] or 0
    clickCount[cfgChild.index] = num + 1
    -- 
    CRoleDisplayMgr:TrackEvents(modelId, cfgChild.index)
end

-- 点击回调
function GetClickCB(cfgChild)
    local func, delay = nil, 0
    if (cfgChild.content) then
        if (cfgChild.content.changerole) then
            local _curRoleNum = cfgChild.role or 1
            curRoleNum = 3 - _curRoleNum
            if (cfgChild.content.changerole[6] and cfgChild.content.changerole[6] ~= "") then
                curRoleNum = cfgChild.content.changerole[6]
            end
            func = function()
                if (not cfgChild.content or not cfgChild.content.changerole[5] or cfgChild.content.changerole[5] == "") then
                    records = {}
                end
                local cb = nil
                if (cfgChild.content.changerole[4] and cfgChild.content.changerole[4] ~= "") then
                    cb = function()
                        PlayByIndex(cfgChild.content.changerole[4], nil, false)
                        if (cfgChild.content.changerole[5]) then
                            RecordsJC(cfgChild.content.changerole[5])
                        end
                    end
                elseif (cfgChild.content.changerole[5] and cfgChild.content.changerole[5] ~= "") then
                    cb = function()
                        RecordsJC(cfgChild.content.changerole[5])
                    end
                end
                SetImg(cfgChild.content.changerole[1], false, cb)
                -- 保存动作,换组
                if (not cfgChild.content.isSpineUI) then
                    spineState[1] = modelId
                    if (cfgChild.content.changerole[1] == baseL2dName2 and not spineState[2]) then
                        spineState = {}
                    else
                        spineState[2] = cfgChild.index
                        spineState[3] = nil -- 换组的情况下，idle记录要清除
                    end
                    RoleTool.SaveSpineState(spineState)
                end
            end
            delay = cfgChild.sName == nil and math.floor(cfgChild.content.changerole[3] / 2) or 0
        elseif (cfgChild.content.nextClick) then
            func = function()
                local nextCfgChild = cfg.item[cfgChild.content.nextClick]
                local trackIndex = GetTrackIndex(cfgChild)
                if (IsIdle()) then
                    TouchItemClickCB(nextCfgChild) -- 触发下一个动作
                else
                    FuncUtil:Call(function()
                        if (not IsIdle()) then
                            spineTools:ClearTrack2(trackIndex)
                        end
                        TouchItemClickCB(nextCfgChild) -- 触发下一个动作
                    end, nil, 501)
                end
            end
        end
    end
    return func, delay
end

-- 多spine多段点击操作的阶段继承
function RecordsJC(str)
    local tab = StringUtil:split(str, "_")
    local len = #tab
    for k = 1, len, 2 do
        local cfgChild = cfg.item[tonumber(tab[k])]
        local realIndex = GetRealIndex(cfgChild)
        local cfgChild2 = cfg.item[tonumber(tab[k + 1])]
        local realIndex2 = GetRealIndex(cfgChild2)
        records[realIndex2] = records[realIndex]
        if (not records[realIndex2]) then
            -- 移除
            spineTools:ClearMulClick(realIndex2)
        end
    end
end

-- 多段点击按记录恢复,设置动作百分比
function RestoreClicks()
    for k, v in ipairs(cfg.item) do
        if (v.role == curRoleNum and v.sType == 7 and v.content ~= nil and v.content.clicks ~= nil) then
            local realIndex = GetRealIndex(v)
            if (records[realIndex]) then
                local mulData = GetMulData(v.content, realIndex, records[realIndex])
                spineTools:PlayByMulClick(v.sName, realIndex, mulData, true)
            end
        end
    end
end

-- 过场spine
function SetInterlude(content)
    if (content.changerole and content.changerole[2] ~= nil) then
        local _l2dName = content.changerole[2]
        ResUtil:CreateSpine(_l2dName .. "/" .. _l2dName, 0, 0, 0, gameObject, function(go)
            interludeGO = go
            FuncUtil:Call(function()
                CSAPI.RemoveGO(interludeGO)
                interludeGO = nil
            end, nil, content.changerole[3] or 1)
        end)
    end
end

-- 当前是否在使用第二套角色
function GetCurRoleNum()
    return curRoleNum or 1
end

-- 拖拽开始
function ItemDragBeginCB(cfgChild, x, y)
    if (interludeGO ~= nil) then
        return
    end
    if (isHeXie or isIn or isDrag or not IsIdle()) then
        return
    end
    local content = cfgChild.content or {}
    if (CheckIsDrag(cfgChild)) then
        dragObj = l2dGo.transform:Find("pos/" .. content.drag.targetObjName).gameObject
        dragStartPos = CSAPI.csGetAnchor(dragObj)
        CSAPI.SetGOActive(dragObj, true)
        if (content.drag.slots) then
            for k, v in pairs(content.drag.slots) do
                local slot = graphic.Skeleton:FindSlot(v)
                if (slot) then
                    slot.A = 0
                end
            end
        end
        -- idle同步
        if (content.drag.targetObjName == "toushi") then
            local l2d = ComUtil.GetCom(l2dGo, "CSpine")
            local anim = l2d:GetSG("pos/" .. content.drag.hideSpine .. "/pos/main").AnimationState
            local trackEntry1 = graphic.AnimationState:GetCurrent(0)
            local trackEntry2 = anim:GetCurrent(0)
            trackEntry2.TrackTime = trackEntry1.TrackTime;
        end
    end
    PlayAudio(cfgChild)
    isDrag = true
    -- 
    local num = clickCount[cfgChild.index] or 0
    clickCount[cfgChild.index] = num + 1
end
-- 拖拽中
function ItemDragCB(cfgChild, x, y)
    if (isDrag == nil or not isDrag) then
        return
    end
    if (CheckIsDrag(cfgChild)) then
        -- 在 CardTouchItem中设置dragGO
        -- if (dragObj) then
        --     CSAPI.SetAnchor(dragObj, x, y, 0)
        -- end
    else
        local content = cfgChild.content or {}
        if (content.gestureDatas) then
            local limit = content.gestureDatas.limitPerc or 1
            spineTools:PlayByDrag(cfgChild.sName, GetTrackIndex(cfgChild), cfgChild.gesture, x, y, limit,
                content.gestureDatas.speed * 0.001)
        end
    end
end
-- 拖拽结束
function ItemDragEndCB(cfgChild, x, y, index)
    if (isDrag == nil or not isDrag) then
        return
    end
    isDrag = nil
    local content = cfgChild.content or {}
    if (CheckIsDrag(cfgChild)) then
        if (dragObj) then
            local isIn, sName = false, nil -- 在目标范围
            if (content.drag.targetPosObjNames) then
                for k, v in pairs(content.drag.targetPosObjNames) do
                    local strs = StringUtil:split(v, "_")
                    local _dragStartPos = CSAPI.csGetPos(dragObj)
                    local startPos = UnityEngine.Vector3(_dragStartPos[0], _dragStartPos[1], 0)
                    local targetObj = l2dGo.transform:Find("pos/" .. strs[1]).gameObject
                    local dragTargetPos = CSAPI.csGetPos(targetObj)
                    local targetPos = UnityEngine.Vector3(dragTargetPos[0], dragTargetPos[1], 0)
                    local dis = UnityEngine.Vector3.Distance(startPos, targetPos)
                    if (dis < 10) then
                        isIn = true
                        sName = strs[2]
                    end
                end
            end
            if (isIn and sName ~= nil) then
                -- 播放动作
                spineTools:PlayByClick(sName, GetTrackIndex(cfgChild), true, true)
                PlayAudio(cfgChild)
                -- 显示主体隐藏额外
                CSAPI.SetAnchor(dragObj, dragStartPos[0], dragStartPos[1], 0)
                CSAPI.SetGOActive(dragObj, false)
                if (content.drag.slots) then
                    for k, v in pairs(content.drag.slots) do
                        local slot = graphic.Skeleton:FindSlot(v)
                        if (slot) then
                            slot.A = 1
                        end
                    end
                end
            else
                -- 只是隐藏鞋子
                CSAPI.SetAnchor(dragObj, dragStartPos[0], dragStartPos[1], 0)
                CSAPI.SetGOActive(dragObj, false)
                --
                if (content.drag.slots) then
                    touchItems[index].SetHideShoe(function()
                        for k, v in pairs(content.drag.slots) do
                            local slot = graphic.Skeleton:FindSlot(v)
                            if (slot) then
                                slot.A = 1
                            end
                        end
                    end)
                end

            end
        end
    else
        if (content.gestureDatas and content.gestureDatas.stopTime ~= nil and content.gestureDatas.stopTime >= 0) then
            local forward = false
            local limit = content.gestureDatas.splitPerc or 1
            if (limit ~= 1) then
                local trackIndex = GetTrackIndex(cfgChild)
                local b, cur = spineTools:GetTrackTimePercent(trackIndex)
                if (limit - cur < 0.01) then
                    forward = true
                end
            end
            spineTools:Recover(cfgChild.sName, GetTrackIndex(cfgChild), content.gestureDatas.stopTime, forward)
        end
    end
    -- 
    CRoleDisplayMgr:TrackEvents(modelId, cfgChild.index)
end
function PlayAudio(cfgChild)
    if (not cfgChild.audioId) then
        return
    end
    if (RoleAudioPlayMgr:GetIsPlaying()) then
        RoleAudioPlayMgr:StopSound()
        -- return
    end

    hideTxt = false
    if (cfgChild.hideTxt and cfgChild.hideTxt == 1) then
        hideTxt = true
    end
    local audioId = nil
    local audioIds = cfgChild.audioId
    local content = cfgChild.content or {}
    if (audioIds and #audioIds > 0) then
        local index = 1
        if (#audioIds > 1) then
            if (content.actions or content.clicks or content.randomActions or content.orderActions) then
                -- 顺序
                local realIndex = GetRealIndex(cfgChild)
                if (records[realIndex]) then
                    index = records[realIndex]
                end
            else
                -- 随机 
                local len = #audioIds
                index = CSAPI.RandomInt(1, len)
            end
        end
        audioId = audioIds[index]
    end
    if (audioId) then
        RoleAudioPlayMgr:PlayById(modelId, audioId, PlayCB, EndCB)
    end
end

function IsIdle()
    if (spineTools) then
        return spineTools:IsIdle()
    end
    return false
end

-- 能否点击
function SetClickActive(b)
    if (isMul) then
        isActive = b
        CSAPI.SetGOActive(mask, b)
    else
        img_imgObj.raycastTarget = b
        CSAPI.SetGOActive(mask, b)
    end
end

function PlayVoiceByID(id)
    if (not voicePlaying) then
        RoleAudioPlayMgr:PlayById(modelId, id, PlayCB, EndCB)
    end
end

function PlayCB(curCfg)
    voicePlaying = true
    if (not hideTxt and playCallBack) then
        playCallBack(curCfg)
    end
end

function EndCB()
    voicePlaying = false
    if (not hideTxt and endCallBack) then
        endCallBack()
    end
end

-- 点击 (多人插图不会进入这里)
function OnClick()
    if (not isMul) then
        if (not needClick) then
            return
        end
        PlayVoice()
        MissionMgr:DoClickBoard()
    end
end

-- 类型
function PlayVoice(type)
    hideTxt = false
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

function GetImgScale()
    return imgScale or 1
end

function SetBlack(isBlack)
    if l2dGo then
        UIUtil:SetLiveBroadcast(l2dGo, isBlack)
    end
    --
    SetHXBlack(isBlack)
end
-------------进场------------------------

function CheckIn()
    if (not isHX and not isHeXie and spineTools and spineTools:CheckAnimExist("in") and curRoleNum == 1) then
        local _baseIdleName = spineTools:GetNameByTrackIndex(0)
        if (baseIdleName and baseIdleName == _baseIdleName) then
            return true
        end
    end
    return false
end

-- 进场动画 
function PlayIn(cb, _movePoint)
    -- 清除所有轨道（idle除外）
    local indexs, names = GetIndexs()
    spineTools:ImmClearTracks(indexs, names)
    graphic.Skeleton:SetToSetupPose()
    -- 
    CrearData()
    --
    isIn = true
    inCB = cb
    movePoint = _movePoint or transform.parent.parent.gameObject
    SetParentPos(true)
    spineTools:PlayIn(InExit)
    -- audio 
    for k, v in ipairs(cfg.item) do
        if (v.sName == "in") then
            PlayAudio(v)
            break
        end
    end
    HideBtns()
    PlayInEffect(cfg)
end

-- 特效1 
function InExit()
    isIn = false
    ResUtil:CreateEffect("pifuzhuanshi/fc_pifu_ToWhite", 0, 0, 0, gameObject, function(go)
        effect1 = go
        FuncUtil:Call(function()
            spineTools:ClearTrack(1)
        end, nil, 100)
        FuncUtil:Call(PlayInCB, nil, 350)
    end)
end

-- 播完时进场动画时回调，或者切换动画时立即回调
function PlayInCB()
    SetParentPos(false)

    -- 特效2
    if (effect1) then
        CSAPI.SetGOActive(effect1, false)
        CSAPI.RemoveGO(effect1)
    end
    UIUtil:SetObjScale(gameObject, 1.1, 1, 1.1, 1, 1.1, 1, nil, 300, 1)
    ResUtil:CreateEffect("pifuzhuanshi/fc_pifu_OutWhite", 0, 0, 0, gameObject, function(go)
        FuncUtil:Call(function()
            if (inCB) then
                inCB()
            end
            HideBtns()
            CSAPI.RemoveGO(go)
        end, nil, 300)
    end)
    RemoveInEffect()
end

function Update()
    -- 中断进场动画 
    if (isIn and CS.UnityEngine.Input.GetMouseButton(0)) then
        isIn = false
        spineTools:SetTrackEntryComplte(1)
    end

    if (spineTools ~= nil) then
        spineTools:Update()
    end
    if (changeIdleData and Time.time > changeIdleData[1]) then
        local cfgChild = changeIdleData[2]
        local trackIndexs, indexs, revoverNames = GetTrackIndexs(cfgChild)
        spineTools:ImmClearTracks(trackIndexs, revoverNames)
        ClearRecords(indexs)
        --
        if (spineTools ~= nil) then
            spineTools:ChangeIdle(cfgChild.content.changeIdle[1])
            -- 保存动作
            if (not cfgChild.content.isSpineUI) then
                spineState[1] = modelId
                if (cfgChild.content.changeIdle[1] == baseIdleName) then
                    spineState[3] = nil
                    if (spineState[2] == "") then
                        spineState = {}
                    end
                else
                    spineState[2] = spineState[2] or ""
                    spineState[3] = cfgChild.index
                end
                RoleTool.SaveSpineState(spineState)
            end
        end
        changeIdleData = nil
    end
end

function HideBtns()
    if (touchItems) then
        local scale = isIn and 0 or 1
        for k, v in pairs(touchItems) do
            -- CSAPI.SetGOActive(v.gameObject, not isIn)
            CSAPI.SetScale(v.gameObject, scale, scale, scale)
        end
    end
end

function SetParentPos(toZero)
    if (toZero) then
        cachePos = CSAPI.csGetAnchor(movePoint)
        cacheScale = CSAPI.csGetScale(movePoint)
        CSAPI.SetAnchor(movePoint, 0, 0, 0)
        CSAPI.SetScale(movePoint, 1, 1, 1)
    else
        cachePos = cachePos or {
            [0] = 0,
            [1] = 0,
            [2] = 0
        }
        cacheScale = cacheScale or {
            [0] = 1,
            [1] = 1,
            [2] = 1
        }
        CSAPI.SetAnchor(movePoint, cachePos[0], cachePos[1], cachePos[2])
        CSAPI.SetScale(movePoint, cacheScale[0], cacheScale[1], cacheScale[2])
    end
end

-- 入场特效（下次改版得删）
function PlayInEffect(cfg)
    for k, v in ipairs(cfg.item) do
        if (v.sName == "in") then
            if (v.effect) then
                local parent = l2dGo.transform:Find("pos").gameObject
                local low = CSAPI.GetGameLv() <= 2
                CSAPI.CreateGOAsync("Spine/" .. v.effect, 0, 0, 0, parent, function(go)
                    inEffectGo = go
                end, low)
            end
            break
        end
    end
end

function RemoveInEffect()
    if (inEffectGo) then
        CSAPI.RemoveGO(inEffectGo)
    end
end

------------------进场end----------------------------

------------------------------新内容-----------------------------

-- 点击 content内容
function SetContent(cfgChild)
    local content = cfgChild.content
    local sName = cfgChild.sName
    local mulData = {
        timeScale = 1,
        progress = 1,
        isClicksLast = false
    }
    -- 随机动作
    if (content.randomActions) then
        local num = CSAPI.RandomInt(0, 100)
        local _k = 1
        local count = 0
        for k, v in ipairs(content.randomActions) do
            count = count + v[2] * 100
            if (num <= count) then
                sName = v[1]
                _k = k
                break
            end
        end
        records[cfgChild.index] = _k
    end
    -- 顺序动作
    if (content.orderActions) then
        local index = records[cfgChild.index] or 0
        index = (index + 1) > #content.orderActions and 1 or (index + 1)
        sName = content.orderActions[index]
        records[cfgChild.index] = index
    end
    -- 播放到指定百分比 
    if (content.clicks) then
        if (spineTools:CheckMulClickIsPlay(GetTrackIndex(cfgChild))) then
            sName = nil
        else
            local realIndex = GetRealIndex(cfgChild)
            local num = 1
            if (records[realIndex] and records[realIndex] < #content.clicks) then
                num = records[realIndex] + 1
            end
            records[realIndex] = num
            mulData = GetMulData(content, realIndex, num)
        end
    end
    -- 激活与隐藏
    if (content.activation) then
        -- 有clicks会记录顺序，偶数会反转
        local isF = false
        if (content.clicks) then
            if (#content.clicks % 2 ~= 0) then
                LogError(
                    "activation字段下有clicks,那么clicks长度必须是偶数，否则不符合一正一反的规则")
            end
            local realIndex = GetRealIndex(cfgChild)
            if (records[realIndex] and records[realIndex] % 2 == 0) then
                isF = true
            end
        end
        --
        for k, v in pairs(touchItems) do
            local num = content.activation[v:GetIndex() .. ""]
            if (num) then
                local b = num == 1
                if (isF) then
                    b = not b
                end
                CSAPI.SetGOActive(v.gameObject, b)
            end
        end
    end
    if (content.isSpineUI) then
        EventMgr.Dispatch(EventType.Menu_SpineUI, true)
    end
    return sName, mulData
end

function GetMulData(content, realIndex, num)
    local mulData = {
        timeScale = 1,
        progress = 1,
        isClicksLast = false
    }
    mulData.progress = content.clicks[num]
    mulData.timeScale = mulData.progress == 0 and -1 or 1 -- 最后是1的，如果再填0，意思是点多一下就倒退，否则就是播完就移除
    mulData.isClicksLast = num >= #content.clicks
    mulData.clickTime = content.clickTime
    -- 最后一次点击则调用清除记录
    mulData.clickTimeCB = function()
        records[realIndex] = nil
        -- 隐藏
        if (content.activation and touchItems ~= nil) then
            for k, v in pairs(content.activation) do
                for p, q in pairs(touchItems) do
                    if (q.cfgChild.index == tonumber(k)) then
                        CSAPI.SetGOActive(q.gameObject, v ~= 1)
                        break
                    end
                end
            end
            -- 
            isDrag = nil -- todo 这种处理有问题的，需要优化
        end
    end
    return mulData
end

function GetRealIndex(cfgChild)
    if (cfgChild.content and cfgChild.content.trackIndex) then
        return cfgChild.content.trackIndex
    end
    return cfgChild.index
end

-- 轨道
function GetTrackIndex(cfgChild)
    if (cfgChild.sType < 6) then
        return 1
    end
    if (cfgChild.content and cfgChild.content.trackIndex) then
        return cfgChild.content.trackIndex
    end
    return cfgChild.index
end

-- 拖放
function CheckIsDrag(cfgChild)
    if (cfgChild.sType == SpineActionType.RoleDrag or cfgChild.sType == SpineActionType.ElseDrag) then
        return true
    end
    return false
end

-------------------------------------

function Reset()
    oldModelId = nil
    clickRecords = {}
end

-- 是否有开场动画语音
function HadInAudio()
    if (cfg) then
        for k, v in ipairs(cfg.item) do
            if (v.sName == "in") then
                return v.audioId ~= nil
            end
        end
    end
    return false
end

function ClearCache()
    if (l2dGo) then
        SetBlack(false)
        CSAPI.RemoveGO(l2dGo)
    end
    l2dGo = nil
    oldModelId = nil
    --
    CrearData()
end

function CrearData()
    curRoleNum = 1
    records = {}
    changeIdleData = nil
    clickCount = {}
    if (dragObj) then
        CSAPI.RemoveGO(dragObj)
    end
    dragObj = nil
end

--
function GetTrackIndexs(childCfg)
    local trackIndexs, indexs, revoverNames = {}, {}, {}
    local ignore1 = GetTrackIndex(childCfg) -- 当前的轨道
    local ignoreDic = {} -- 忽略的轨道

    if (childCfg.content.changeIdle and #childCfg.content.changeIdle > 2) then
        local tabs = childCfg.content.changeIdle
        local len = #tabs or 2
        for k = 3, len do
            local _trackIndex = GetTrackIndex(cfg.item[childCfg.content.changeIdle[k]])
            ignoreDic[_trackIndex] = 1
        end
    end
    for k, v in ipairs(cfg.item) do
        local trackIndex = GetTrackIndex(v)
        if (trackIndex ~= ignore1 and not ignoreDic[trackIndex]) then
            table.insert(trackIndexs, trackIndex)
            table.insert(indexs, v.index)
            table.insert(revoverNames, v.sName)
        end
    end
    -- 要清除的轨道，对应的条目序号，要清除的动画名称
    return trackIndexs, indexs, revoverNames
end

function ClearRecords(indexs)
    if (records) then
        for k, v in pairs(indexs) do
            if (records[v]) then
                records[v] = nil
            end
        end
    end
end

function GetIndexs()
    local indexs, names = {}, {}
    local dic = {}
    for k, v in pairs(cfg.item) do
        if (not v.content or not v.content.inIgnore) then
            local trackIndex = GetTrackIndex(v)
            if (not dic[trackIndex]) then
                table.insert(indexs, trackIndex)
                table.insert(names, v.sName)
                dic[trackIndex] = 1
            end
        end
    end
    return indexs, names
end

-- spine事件
function SpineEvent(trackEntry, e)
    local strs = StringUtil:split(e.Name, "_")
    if (strs[1] == "SpineUI") then
        if (not spineUI) then
            -- 进场
            local UI_Layer_Common = CSAPI.GetGlobalGO("UI_Layer_Common")
            ResUtil:CreateUIGOAsync("Spine/" .. l2dName .. "/" .. l2dName, UI_Layer_Common, function(go)
                spineUI = ComUtil.GetLuaTable(go)
                spineUI.Refresh(this)
                --
                SetParentPos(true)
            end)
            EventMgr.Dispatch(EventType.Menu_SpineUI, true)
        else
            -- 退场
            CSAPI.RemoveGO(spineUI.gameObject)
            spineUI = nil
            EventMgr.Dispatch(EventType.Menu_SpineUI, false)
            --
            SetParentPos(false)
        end
    elseif (strs[1] == "TriggerIndex") then
        PlayByIndex(tonumber(strs[2]), nil, nil, true)
    elseif (strs[1] == "SpineAudio") then
        if (strs[2] and strs[2] ~= "") then
            CSAPI.PlayTempSound(strs[2])
        end
    end
end

function PlayByIndex(index, cb, check, isCan)
    local cfgChild = cfg.item[index]
    timer = 0
    TouchItemClickCB(cfgChild, cb, check, isCan)
end

function GetAnimDuration(animName)
    if (spineTools) then
        return spineTools:GetAnimDuration(animName)
    end
    return 0
end

-- 重置指定index所在的轨道
function ResetByIndex(_indexs)
    local trackIndexs, indexs, revoverNames = {}, {}, {}
    for k, v in pairs(_indexs) do
        local childCfg = cfg.item[v]
        local trackIndex = GetTrackIndex(childCfg)
        table.insert(trackIndexs, trackIndex)
        table.insert(revoverNames, childCfg.sName)
    end
    spineTools:ImmClearTracks(trackIndexs, revoverNames, true)
    ClearRecords(_indexs)
    -- spineTools:SetToSetupPose()
end
-- 【 

function GetL2dGo()
    return l2dGo
end
-- 】

-- 【 多人插图
function GetImgSize()
    return {
        [0] = 2240,
        [1] = 1080
    }
end

function GetIconName()
    local _cfg = Cfgs.CfgArchiveMultiPicture:GetByID(modelId)
    return _cfg.icon
end

function OnClickMask()
    MissionMgr:DoClickBoard()
end
-- 】

-- function SetMenuMask(cfgChild)
--     if (cfgChild.content and cfgChild.content.isSpineUI) then
--         local go = CSAPI.GetView("Menu")
--         if (go) then
--             local lua = ComUtil.GetLuaTable(go)
--             lua.SpineUI_OpenMask()
--         end
--     end
-- end

--------------------------------------状态保存-------------------------------------------------

-- 按保存的状态初始化(每次创建主界面时仅判断一次) 无切换过程
function ChangeByOldState()
    spineState = RoleTool.GetSpineState(modelId)
    if (not MenuMgr:IsAddMenu()) then
        return
    end
    MenuMgr:AddMenu(nil)
    -- 
    if (spineState and spineState[1] == modelId) then

        local func3 = nil
        if (spineState[3]) then
            func3 = function()
                local cfgChild3 = cfg.item[spineState[3]]
                ChangeIdle_noProcess(cfgChild3)
            end
        end
        if (spineState[2] and spineState[2] ~= "") then -- ChangeRole
            local cfgChild2 = cfg.item[spineState[2]]
            ChangeRole_noProcess(cfgChild2, func3)
        elseif (func3 ~= nil) then -- ChangeIdle
            func3()
        end
    end
end

function ChangeRole_noProcess(cfgChild, _cb)
    SetContent(cfgChild)
    if (cfgChild.content.changerole) then
        local _curRoleNum = cfgChild.role or 1
        curRoleNum = 3 - _curRoleNum
        if (cfgChild.content.changerole[6] and cfgChild.content.changerole[6] ~= "") then
            curRoleNum = cfgChild.content.changerole[6]
        end
        local cb = nil
        if (cfgChild.content.changerole[4] and cfgChild.content.changerole[4] ~= "") then
            cb = function()
                PlayByIndex(cfgChild.content.changerole[4], nil, false)
                if (_cb) then
                    _cb()
                end
            end
        else
            cb = _cb
        end
        SetImg(cfgChild.content.changerole[1], false, cb)
    end
end

function ChangeIdle_noProcess(cfgChild)
    SetContent(cfgChild)
    if (spineTools ~= nil) then
        spineTools:ChangeIdle(cfgChild.content.changeIdle[1])
    end
end

-- 多段点击是否正在播放
function CheckMulIsPlay(index)
    local cfgChild = cfg.item[index]
    if (spineTools:CheckMulClickIsPlay(GetTrackIndex(cfgChild))) then
        return true
    end
end

function GetSpineTools()
    return spineTools
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
