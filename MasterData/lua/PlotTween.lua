-- 剧情面板动画类
local this = {};
local PlotTweenType = {
    Move = 1,
    Fade = 2,
    Apply = 3,
    Twinkle = 4,
    PingPong = 5
}
local actionLists = {}

function this.Init()
    actionLists = {}
end
-----------------------------------------------人物立绘入场/退场动画------------------------
-- 移动入场动画
function this.EntranceTweenMove(view, pos, _time, callBack, _delay)
    if view ~= nil and pos ~= nil then
        view.myLocalPosX = pos[1] >= 0 and 1200 or -1200; -- 动画移动起点
        view.myLocalPosY = pos[2];
        local time = _time and _time or 0.17
        local delay = _delay and _delay * 1000 or 0;
        local moveAction = CSAPI.MoveTo(view.gameObject, "UI_Local_Move", pos[1], pos[2], view.myLocalPosZ, callBack,
            time, delay);
        this.InsertActionToList(PlotTweenType.Move, moveAction)
    end
end

-- 移动离场动画
function this.LeaveTweenMove(view, pos, _time, callBack, _delay)
    if view ~= nil and pos ~= nil then
        view.myLocalPosX = pos[1]; -- 动画移动起点
        view.myLocalPosY = pos[2];
        local endPosX = pos[1] >= 0 and 1200 or -1200;
        local time = _time and _time or 0.17
        local delay = _delay and _delay * 1000 or 0;
        local moveAction = CSAPI.MoveTo(view.gameObject, "UI_Local_Move", endPosX, pos[2], view.myLocalPosZ, callBack,
            time, delay);
        this.InsertActionToList(PlotTweenType.Move, moveAction)
    end
end

-- 移动动画
function this.TweenMove(view, pos, _time, callBack, _delay)
    if view ~= nil and pos ~= nil then
        local time = _time and _time or 0.17
        local delay = _delay and _delay * 1000 or 0;
        local moveAction = CSAPI.MoveTo(view.gameObject, "UI_Local_Move", pos[1], pos[2], view.myLocalPosZ, callBack,
            time, delay);
        this.InsertActionToList(PlotTweenType.Move, moveAction)
    end
end

-- 来回移动
function this.TweenMoveByPingPong(view, pos, _time, callBack, _delay)
    if view ~= nil and pos ~= nil then
        local moveTo = ComUtil.GetCom(go, "ActionMoveTo");
        if moveTo == nil then
            moveTo = go:AddComponent(typeof(CS.ActionMoveTo));
        end
        moveTo.target = go;
        moveTo.ignoreTimeScale = true
        moveTo.isLocal = true

        local delay = _delay and _delay * 1000 or 0;
        local time = _time and _time or 0.17
        local _pos = {view.myLocalPosX, view.myLocalPosY}
        moveTo:PlayByTime(pos[1], pos[2], view.myLocalPosZ, time, function()
            moveTo:PlayByTime(_pos[1], _pos[2], view.myLocalPosZ, time)
            if (callBack) then
                callBack()
            end
        end, delay)
        this.InsertActionToList(PlotTweenType.PingPong, moveAction, function()
            CSAPI.SetLocalPos(view.gameObject, _pos[1], _pos[2])
        end)
    end
end

-- 来回移动
function this.TweenMoveByPingPong2(go, pos, _time, callBack, _delay)
    if view ~= nil and pos ~= nil then
        local moveTo = ComUtil.GetCom(go, "ActionMoveTo");
        if moveTo == nil then
            moveTo = go:AddComponent(typeof(CS.ActionMoveTo));
        end
        moveTo.target = go;
        moveTo.ignoreTimeScale = true
        moveTo.isLocal = true
        local delay = _delay and _delay * 1000 or 0;
        local time = _time and _time or 0.17
        local _pos = {go.transform.localPosition.x, go.transform.localPosition.y}
        local z = go.transform.localPosition.z

        moveTo:PlayByTime(pos[1], pos[2], z, time, function()
            moveTo:PlayByTime(_pos[1], _pos[2], z, time)
            if (callBack) then
                callBack()
            end
        end, delay)
        -- this.InsertActionToList(PlotTweenType.PingPong, moveTo, function()
        -- 	CSAPI.SetLocalPos(go, _pos[1], _pos[2])
        -- end)
    end
end

-- 人物切开的动画
function this.TweenSplit(go1, go2, callBack)
    if go1 and go2 then
        local x, y, z = CSAPI.GetAnchor(go1);
        local x2, y2, z2 = CSAPI.GetAnchor(go2);
        local moveAction1 = CSAPI.MoveTo(go1, "UI_Local_Move", x + 100, y, 0, nil, 0.5);
        local moveAction2 = CSAPI.MoveTo(go2, "UI_Local_Move", x2 - 100, y2, 0, nil, 0.5);
        this.InsertActionToList(this.moveList, moveAction1)
        this.InsertActionToList(this.moveList, moveAction2)
        this.FadeOut(go1, 0.7, nil)
        this.FadeOut(go2, 0.7, callBack)
    end
end

-----------------------------------------------人物立绘入场/退场动画结束------------------------
--------------------------------------------------------震动动画---------------------
function this.TweenShake(shakeInfos)
    this.shakeInfos = shakeInfos;
    if shakeInfos then
        for k, v in ipairs(shakeInfos) do
            v.shakeObj.enabled = true;
            if v.time then
                if v.time == -1 then -- 持续震动
                    v.shakeObj.time = 9999000;
                else
                    v.shakeObj.time = v.time * 1000;
                end
            end
            if v.force then
                v.shakeObj.range = UnityEngine.Vector3(v.force[1], v.force[2], 0);
            end
            if v.interval then
                v.shakeObj.intervalTime = v.interval;
            end
            v.shakeObj:Play(function()
                this.shakeInfos[k].shakeObj = nil;
            end);
        end
    end
end

-- 停止震动动画
function this.StopTweenShake()
    if this.shakeInfos and #this.shakeInfos > 0 then
        for k, v in ipairs(this.shakeInfos) do
            if (v.shakeObj) then
                v.shakeObj.enabled = false;
                CSAPI.SetLocalPos(v.shakeObj.target, 0, 0, 0);
            end
        end
        this.shakeInfos = nil
    end
end
--------------------------------------------------------震动动画结束---------------------
function this.FadeIn(go, _time, callBack, _delay, _isIgnoreTimeScale)
    if go == nil then
        if callBack then
            callBack()
        end
        return
    end
    local fade = ComUtil.GetCom(go, "ActionFade");
    if fade == nil then
        fade = go:AddComponent(typeof(CS.ActionFade));
    end
    fade.target = go;
    fade.ignoreTimeScale = _isIgnoreTimeScale or false
    local time = _time and _time * 1000 or 250;
    local delay = _delay and _delay * 1000 or 0;
    fade:Play(0, 1, time, delay, callBack);
    this.InsertActionToList(PlotTweenType.Fade, fade)
end

function this.FadeOut(go, _time, callBack, _delay, _isIgnoreTimeScale)
    if go == nil then
        if callBack then
            callBack()
        end
        return
    end
    local fade = ComUtil.GetCom(go, "ActionFade");
    if fade == nil then
        fade = go:AddComponent(typeof(CS.ActionFade));
    end
    fade.target = go;
    fade.ignoreTimeScale = _isIgnoreTimeScale or false
    local time = _time and _time * 1000 or 250;
    local delay = _delay and _delay * 1000 or 0;
    fade:Play(1, 0, time, delay, callBack);
    this.InsertActionToList(PlotTweenType.Fade, fade)
end

-- 闪烁
function this.Twinkle(go, _time, callBack, _delay)
    local fade = ComUtil.GetCom(go, "ActionFade");
    if fade == nil then
        fade = go:AddComponent(typeof(CS.ActionFade));
    end
    fade.target = go;
    local time = _time and _time * 1000 or 250;
    local delay = _delay and _delay * 1000 or 0;
    fade.enabled = true
    fade:Play(1, 0, time, delay, function()
        fade:Play(0, 1, time)
        if callBack then
            callBack()
        end
    end, _delay)
    this.InsertActionToList(PlotTweenType.Twinkle, fade)
end

function this.Twinkle2(go, _time1, _time2, callBack, _delay1, _delay2)
    local fade = ComUtil.GetOrAddCom(go, "ActionFade");
    fade.target = go;
    local time1 = _time1 and _time1 * 1000 or 250;
    local time2 = _time2 and _time2 * 1000 or 250;
    local delay1 = _delay1 and _delay1 * 1000 or 0;
    local delay2 = _delay2 and _delay2 * 1000 or 0;
    fade.enabled = true
    fade:Play(1, 0, _time1, _delay1, function()
        fade:Play(0, 1, _time2, nil, _delay2)
        if callBack then
            callBack()
        end
    end, _delay1)
    this.InsertActionToList(PlotTweenType.Twinkle, fade)
end

--------------------------------------添加动画---------------------------------------
function this.ApplyAction(go, actionName, callBack)
    local _action = CSAPI.ApplyAction(go, actionName, callBack)
    this.InsertActionToList(PlotTweenType.Apply, _action)
end

--------------------------------------动画管理---------------------------------------
-- 修复队列
function this.FixActionList(_type)
    if (not actionLists or not actionLists[_type] or #actionLists[_type] < 1) then
        return
    end
    local _list = {}
    for i, v in ipairs(actionLists[_type]) do
        if (v.action.isRunning) then
            table.insert(_list, v)
        end
    end
    actionLists[_type] = _list
end

-- 添加到队列
function this.InsertActionToList(_type, _action, _callback)
    actionLists = actionLists or {}
    actionLists[_type] = actionLists[_type] or {}
    table.insert(actionLists[_type], {
        action = _action,
        callback = _callback
    })
end

-- 停止物体动画
function this.StopAction(go, _type)
    if (not actionLists or not actionLists[_type] or #actionLists[_type] < 1) then
        return
    end
    for i, v in ipairs(actionLists[_type]) do
        if (v.gameObject == go) then
            v.action:SetComplete()
            if (v.callback) then
                v.callback()
            end
        end
    end
end

-- 停止队列里的动画
function this.StopListAction(_type)
    if (not actionLists or not actionLists[_type] or #actionLists[_type] < 1) then
        return
    end
    if (_type == PlotTweenType.Twinkle) then
        for i, v in ipairs(actionLists[_type]) do
            v.action:SetComplete()
            if (v.action) then
                local canvasGroup = ComUtil.GetOrAddCom(v.action.gameObject, "CanvasGroup");
                -- v.action.enabled = false
                canvasGroup.alpha = 1
            end
            -- if(v.action) then
            -- 	v.action:SetAlpha(1)
            -- end					
        end
    elseif (_type == PlotTweenType.PingPong) then
        for i, v in ipairs(actionLists[_type]) do
            if (v.action) then
                v.action:SetComplete()
                if (v.callback) then
                    v.callback()
                end
                -- ComUtil.GetCom(v.gameObject,"CanvasGroup").alpha = 1
                -- v:Play(0, 1)
                v.action.enabled = false
            end
        end
    else
        for i, v in ipairs(actionLists[_type]) do
            if (v.action) then
                v.action:SetComplete()
            end
        end
    end
    actionLists[_type] = nil
end

function this.StopAllAction()
    this.StopTweenShake()
    for i, v in pairs(PlotTweenType) do
        this.StopListAction(v)
    end
    this.ClearLists()
end

function this.IsTween()
    local isTween = false
    if (actionLists) then
        for i, v in pairs(PlotTweenType) do
            this.FixActionList(v)
            if (actionLists[v] and #actionLists[v] > 0) then
                isTween = true
                break
            end
        end
    end
    return isTween
end

function this.ClearLists()
    actionLists = nil
end

--------------------------------------镜头效果---------------------------------------
function this.Update()
    if this.playCameraTween then
        this.UpdateCameraTween();
    end
end

-- 播放模拟镜头聚焦移动的动画 cameraInfo:对应剧情对话表中的cameraInfo的格式
function this.PlayCameraTween(go, cameraInfo, callBack)
    if go == nil or cameraInfo == nil then
        LogError("播放动画时出错！");
        return;
    end
    this.cameraTrans = ComUtil.GetCom(go, "RectTransform");
    this.lookPos = UnityEngine.Vector3(cameraInfo.lookPos[1], cameraInfo.lookPos[2]);
    this.targetScale = UnityEngine.Vector3(cameraInfo.scale, cameraInfo.scale);
    this.CameraTweenCall = callBack;
    this.currPivot = this.cameraTrans.pivot;
    this.currPos = this.cameraTrans.localPosition;
    this.currScale = this.cameraTrans.localScale;
    this.cameraTimer = 0; -- 计时器
    this.movePos = UnityEngine.Vector3.zero;
    this.cameraSize = CSAPI.GetMainCanvasSize()
    local pos2 = UnityEngine.Vector3(this.currPivot.x * this.cameraSize.x, this.currPivot.y * this.cameraSize.y) +
                     this.lookPos;
    this.targetPivot = UnityEngine.Vector2(pos2.x / this.cameraSize.x, pos2.y / this.cameraSize.y); -- 计算当前轴心坐标
    this.cameraTrans.pivot = this.targetPivot; -- 设置当前轴心坐标
    -- 计算偏移量并设置本地坐标
    local x = (this.targetPivot.x - this.currPivot.x) * this.cameraSize.x;
    local y = (this.targetPivot.y - this.currPivot.y) * this.cameraSize.y;
    this.cameraTrans.localPosition = UnityEngine.Vector3(x, y);
    this.playingIndex = 1;
    this.cameraList = {{
        maxTime = cameraInfo.time1,
        upFunc = function(progess)
            this.cameraTrans.localScale = UnityEngine.Vector3.Lerp(this.currScale, this.targetScale, progess);
        end,
        overFunc = this.OnScaleOver
    }, {
        maxTime = cameraInfo.time1,
        upFunc = function(progess)
            this.cameraTrans.localPosition = UnityEngine.Vector3.Lerp(this.movePos, this.currPos, progess);
        end,
        overFunc = this.OnMoveOver
    }, {
        maxTime = cameraInfo.time1,
        upFunc = function(progess)
            this.cameraTrans.localScale = UnityEngine.Vector3.Lerp(this.targetScale, this.currScale, progess);
        end,
        overFunc = this.OnPlayOver
    }}
    this.playCameraTween = true;
end

function this.OnScaleOver()
    this.cameraTrans.localScale = this.targetScale;
    this.cameraTrans.pivot = this.currPivot;
    local x = (this.currPivot.x - this.targetPivot.x) * this.cameraSize.x * (this.targetScale.x - this.currScale.x);
    local y = (this.currPivot.y - this.targetPivot.y) * this.cameraSize.y * (this.targetScale.y - this.currScale.y);
    local pos = UnityEngine.Vector3(x, y);
    this.cameraTrans.localPosition = pos;
    this.movePos = pos;
end

function this.OnMoveOver()
    this.cameraTrans.localPosition = this.currPos;
end

function this.OnPlayOver()
    this.cameraTrans.localScale = this.currScale;
    if this.CameraTweenCall then
        this.CameraTweenCall();
    end
end

-- 模拟镜头聚焦动画
function this.UpdateCameraTween()
    this.cameraTimer = this.cameraTimer + Time.deltaTime;
    if this.cameraTimer < this.cameraList[this.playingIndex].maxTime then
        this.cameraList[this.playingIndex].upFunc(this.cameraTimer / this.cameraList[this.playingIndex].maxTime);
    else
        this.cameraList[this.playingIndex].overFunc();
        this.cameraTimer = 0;
        this.playingIndex = this.playingIndex + 1;
        if this.playingIndex > #this.cameraList then
            this.playCameraTween = false;
            this.ClearCameraParams();
        end
    end
end

function this.ClearCameraParams()
    this.cameraTrans = nil;
    this.lookPos = nil;
    this.targetScale = nil;
    this.scaleTime = nil;
    this.moveTime = nil;
    this.scaleTime2 = nil;
    this.CameraTweenCall = nil;
    this.currPivot = nil;
    this.currPos = nil;
    this.currScale = nil;
    this.cameraTimer = 0; -- 计时器
    this.cameraList = nil;
    this.targetPivot = nil;
    this.playingIndex = 1;
    this.movePos = nil;
    this.cameraSize = nil;
    this.playCameraTween = false;
end

return this;
