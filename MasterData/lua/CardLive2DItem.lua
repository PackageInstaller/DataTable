local isInit = false
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
local isHeXie = false -- 和谐了
-- local clickCounts = {} -- actions 某段点击次数
local inter = 0.5
local timer = 0

local curRoleNum = 1 -- 使用第几套人物
local changeCfg = nil -- 变幻到第二套人物的cfg
local interludeGO = nil -- 切换人物的过场go
local l2dName
local spineUI = nil

function Awake()
    img_imgObj = ComUtil.GetCom(imgObj, "Image")
    spineTools = SpineTools.New()
end

function Init(_playCB, _endCB, _needClick)
    playCallBack = _playCB
    endCallBack = _endCB
    needClick = (_needClick ~= nil) and _needClick or false
    isInit = true
end

function Refresh(_modelId, _posType, _callBack, _needClick)
    if (not isInit or _modelId == nil or _posType == nil) then
        return
    end
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
    curRoleNum = 1
    oldModelId = _modelId
    records = {}
    if (dragObj) then
        CSAPI.RemoveGO(dragObj)
    end
    dragObj = nil

    cfg = Cfgs.CfgSpineAction:GetByID(modelId)

    SetImg()

    -- SetTouch()
end

function SetImg(_l2dName, _b)
    local b = true
    if (_b ~= nil) then
        b = _b
    end
    local pos, scale, img, l2dName2 = RoleTool.GetImgPosScale(modelId, posType, true)
    CSAPI.SetAnchor(prefabObj, pos.x, pos.y, pos.z)
    CSAPI.SetScale(prefabObj, scale, scale, 1)
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
            SetBlack()
            SetTouch()
            if (b and callBack) then
                callBack()
            end
        end)
    end

    imgScale = scale * posType[3]

    SetClickImg()
end

-- img 不显示，用于普通点击 
function SetClickImg()
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
function TouchItemClickCB(cfgChild, _cb)
    if (interludeGO ~= nil) then
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

    -- 轨道
    local trackIndex = GetTrackIndex(cfgChild)
    local isCan = false
    if (trackIndex == 1) then
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
        isCan = true
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
                FuncUtil:Call(function()
                    --
                    local trackIndexs, indexs, revoverNames = GetTrackIndexs(cfgChild)
                    spineTools:ImmClearTracks(trackIndexs, revoverNames)
                    ClearRecords(indexs)
                    --
                    if (spineTools ~= nil) then
                        spineTools:ChangeIdle(content.changeIdle[1])
                    end
                end, nil, content.changeIdle[2])
            end
            --
            SetInterlude(content)
            local cb = _cb or GetClickCB(cfgChild)
            if (sName ~= nil) then
                local _b = false
                if (trackIndex == 1 or content.guochange ~= nil) then
                    _b = true
                end
                b = spineTools:PlayByClick(sName, trackIndex, true, _b, cb)
            else
                timer = 0
                if (cb) then
                    cb()
                end
            end
        end
        if (b) then
            PlayAudio(cfgChild)
            MissionMgr:DoClickBoard()
        end
    end
end

-- 点击回调
function GetClickCB(cfgChild)
    local func = nil
    if (cfgChild.content) then
        if (cfgChild.content.changerole) then
            local _curRoleNum = cfgChild.role or 1
            curRoleNum = 3 - _curRoleNum
            func = function()
                SetImg(cfgChild.content.changerole[1], false)
            end
        elseif (cfgChild.content.nextClick) then
            func = function()
                local nextCfgChild = cfg.item[cfgChild.content.nextClick]
                local trackIndex = GetTrackIndex(cfgChild)
                -- LogError(tostring(IsIdle()))
                spineTools:ClearTrack2(trackIndex)
                -- LogError(tostring(IsIdle()))
                TouchItemClickCB(nextCfgChild) -- 触发下一个动作
            end
        end
    end
    return func
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
            local isIn = false -- 在目标范围
            if (content.drag.targetPosObjName) then
                local _dragStartPos = CSAPI.csGetPos(dragObj)
                local startPos = UnityEngine.Vector3(_dragStartPos[0], _dragStartPos[1], 0)
                local targetObj = l2dGo.transform:Find("pos/" .. content.drag.targetPosObjName).gameObject
                local dragTargetPos = CSAPI.csGetPos(targetObj)
                local targetPos = UnityEngine.Vector3(dragTargetPos[0], dragTargetPos[1], 0)
                local dis = UnityEngine.Vector3.Distance(startPos, targetPos)
                isIn = dis < 10
            end
            if (isIn) then
                -- 播放动作
                spineTools:PlayByClick(cfgChild.sName, GetTrackIndex(cfgChild), true, true)
                PlayAudio(cfgChild)
                -- 显示主体隐藏额外
                CSAPI.SetAnchor(dragObj, dragStartPos[0], dragStartPos[1], 0)
                CSAPI.SetGOActive(dragObj, false)
                for k, v in pairs(content.drag.slots) do
                    local slot = graphic.Skeleton:FindSlot(v)
                    if (slot) then
                        slot.A = 1
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
                local cur = spineTools:GetTrackTimePercent(trackIndex)
                if (limit - cur < 0.01) then
                    forward = true
                end
            end
            spineTools:Recover(cfgChild.sName, GetTrackIndex(cfgChild), content.gestureDatas.stopTime, forward)
        end
    end
end
function PlayAudio(cfgChild)
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
    img_imgObj.raycastTarget = b
    CSAPI.SetGOActive(mask, b)
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
end
-------------进场------------------------

function CheckIn()
    if (not isHeXie and spineTools and spineTools:CheckAnimExist("in") and curRoleNum == 1) then
        return true
    end
    return false
end

-- 进场动画 
function PlayIn(cb, _movePoint)
    local indexs, names = GetIndexs()
    spineTools:ImmClearTracks(indexs, names)
    graphic.Skeleton:SetToSetupPose()
    records = {}
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
            mulData.progress = content.clicks[num]
            mulData.timeScale = mulData.progress == 0 and -1 or 1 -- 最后是1的，如果再填0，意思是点多一下就倒退，否则就是播完就移除
            mulData.isClicksLast = num >= #content.clicks
            mulData.clickTime = content.clickTime
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
    return sName, mulData
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
    if (dragObj) then
        CSAPI.RemoveGO(dragObj)
    end
    dragObj = nil
    oldModelId = nil
    records = {}
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
        local trackIndex = GetTrackIndex(v)
        if (not dic[trackIndex]) then
            table.insert(indexs, trackIndex)
            table.insert(names, v.sName)
            dic[trackIndex] = 1
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
            end)
            EventMgr.Dispatch(EventType.Menu_SpineUI, true)
        else
            -- 退场
            CSAPI.RemoveGO(spineUI.gameObject)
            spineUI = nil
            EventMgr.Dispatch(EventType.Menu_SpineUI, false)
        end
    else
        if (strs[1] == "TriggerIndex") then
            PlayByIndex(tonumber(strs[2]))
        end
    end
end

function PlayByIndex(index, cb)
    local cfgChild = cfg.item[index]
    timer = 0
    TouchItemClickCB(cfgChild, cb)
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
    spineTools:ImmClearTracks(trackIndexs, revoverNames,true)
    ClearRecords(_indexs)
    --spineTools:SetToSetupPose()
end


function GetL2dGo()
    return l2dGo
end