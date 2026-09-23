local restoreShoeCB = nil
local dragNum = 0
local hideSpine
-- local isMove = false
local x0, y0, z0 = 0, 0, 0
local mX0, mY0, mZ0 = 0, 0, 0
local isDragging = false
local isPress = false
local pressDownTime = nil

function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Awake()
    click_clickNode = ComUtil.GetCom(clickNode, "Button")
    drag_clickNode = ComUtil.GetCom(clickNode, "DragCallLua")
    polygon = ComUtil.GetCom(clickNode, "PolygonColliderImage")
end

function Update()
    if (isMove and hideSpine) then
        CSAPI.SetPos(hideSpine, x0, y0, z0)
    end
    if (cfgChild and cfgChild.gesture == 6) then
        if (pressDownTime ~= nil and Time.time > pressDownTime) then
            OnBeginDragXY(0, 0)
            --
            local pos = CS.UnityEngine.Input.mousePosition
            CSAPI.SetToMousePosition(drag_clickNode.dragGO.transform.parent, drag_clickNode.dragGO.transform, pos.x,
                pos.y, pos.z)
            isMove = true
        end
    end
end

function Refresh(_cfgChild, _parentLua)
    cfgChild = _cfgChild
    parentLua = _parentLua
    -- 和谐 
    if (parentLua.CheckHX() and not cfgChild.hxact) then
        CSAPI.SetGOActive(gameObject, false)
        return
    end
    -- area
    local area = cfgChild.areas[1]
    CSAPI.SetAnchor(clickNode, area[1], area[2])
    CSAPI.SetRTSize(clickNode, area[3], area[4])
    CSAPI.SetRectAngle(clickNode, 0, 0, area[5])
    -- btn
    local gesture = cfgChild.gesture or 0
    click_clickNode.enabled = gesture == 0
    drag_clickNode.enabled = gesture ~= 0
    -- hide (生成时默认一隐藏)
    local isHide = false
    local roleNum = cfgChild.role or 1
    if (parentLua.GetCurRoleNum ~= nil and parentLua.GetCurRoleNum() ~= roleNum) then
        isHide = true
    else
        if (cfgChild.content and cfgChild.content.isHide ~= nil) then
            isHide = true
        end
        -- 
        InitSore()
    end
    CSAPI.SetGOActive(gameObject, not isHide)
    polygon:AutoScale()
end

-- 设置鞋
function InitSore()
    drag_clickNode.dragGO = nil
    drag_clickNode.move = false
    hideSpine = nil
    if (cfgChild.sType == SpineActionType.RoleDrag or cfgChild.sType == SpineActionType.ElseDrag) then
        if (cfgChild.content.drag ~= nil and cfgChild.content.drag.targetObjName ~= nil and parentLua.l2dGo ~= nil) then
            local dragObj = parentLua.l2dGo.transform:Find("pos/" .. cfgChild.content.drag.targetObjName).gameObject
            drag_clickNode.dragGO = dragObj
            drag_clickNode.move = true
            -- 透视的高层spine 
            if (cfgChild.content.drag.hideSpine) then
                hideSpine = parentLua.l2dGo.transform:Find("pos/" .. cfgChild.content.drag.hideSpine).gameObject
                drag_clickNode.move = false
                mX0, mY0, mZ0 = CSAPI.GetAnchor(hideSpine)
            end
        end
    end
end

function OnClick()
    if (cfgChild.content and cfgChild.content.asmr) then
        JumpASMR()
        return
    end

    if (restoreShoeCB) then
        restoreShoeCB()
        click_clickNode.enabled = false
        drag_clickNode.enabled = true
        restoreShoeCB = nil
    end

    if (cb) then
        cb(cfgChild)
    end
end

function OnBeginDragXY(_x, _y)
    if (parentLua.IsIdle ~= nil and not parentLua.IsIdle()) then
        return
    end
    --
    if (isDragging) then
        return
    end
    isDragging = true
    pressDownTime = nil
    dragNum = 0
    x = _x
    y = _y
    parentLua.ItemDragBeginCB(cfgChild, _x, _y)
    --
    dragNum = 0
    if (hideSpine) then
        x0, y0, z0 = CSAPI.GetPos(hideSpine)
        SetMove(false)
    end
end

function OnDragXY(_x, _y)
    if (not isDragging) then
        return
    end
    if (x == nil or y == nil) then
        x = _x
        y = _y
    end
    parentLua.ItemDragCB(cfgChild, _x - x, _y - y)
    x = _x
    y = _y
    --
    if (hideSpine and dragNum == 1) then
        SetMove(true)
    end
    dragNum = dragNum + 1
end

function OnEndDragXY(_x, _y)
    if (not isDragging) then
        return
    end
    isDragging = false
    parentLua.ItemDragEndCB(cfgChild, _x, _y, index)
    if (hideSpine) then
        CSAPI.SetAnchor(hideSpine, mX0, mY0, mZ0)
        SetMove(false)
    end
end

function GetIndex()
    return cfgChild.index
end

-- 跳转相关
function JumpASMR()
    local asmr = cfgChild.content.asmr
    if (asmr) then
        local data = ASMRMgr:GetData(asmr.id)
        if (not data:IsBuy()) then
            if (asmr.jumpShop) then
                UIUtil:OpenDialog(LanguageMgr:GetTips(46001), function()
                    JumpMgr:Jump(asmr.jumpShop)
                end)
            end
        else
            UIUtil:OpenDialog(LanguageMgr:GetTips(46003), function()
                CSAPI.OpenView("ASMRShow", asmr.id)
            end)
        end
    end
end

-- 隐藏鞋相关逻辑
function SetHideShoe(_restoreShoeCB)
    restoreShoeCB = _restoreShoeCB
    click_clickNode.enabled = true
    drag_clickNode.enabled = false
end

-- 延迟赋值移动
function SetMove(b)
    drag_clickNode.move = b
    isMove = b
end

function OnPressDown(isDragging, clickTime)
    if (parentLua.IsIdle ~= nil and not parentLua.IsIdle()) then
        return
    end
    isPress = true
    --
    if (cfgChild and cfgChild.gesture == 6) then
        pressDownTime = Time.time + 0.3
    end
end

function OnPressUp()
    if (not isPress) then
        return
    end
    isPress = false
    --
    pressDownTime = nil
    if (cfgChild and cfgChild.gesture == 6) then
        if (isDragging and dragNum <= 0) then
            OnEndDragXY(0, 0)
        end
    end
end
