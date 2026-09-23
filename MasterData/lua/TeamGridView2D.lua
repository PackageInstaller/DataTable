
local dragObj=nil;
local isDrag=false;
local canDrag=true;
local clickImg=nil;
local position=nil;
local dragTips=nil;
function Awake()
    clickImg=ComUtil.GetCom(gameObject,"Image");
    dragCom=ComUtil.GetCom(gameObject,"DragCallLua");
end
function OnEnable()
    eventMgr = ViewEvent.New();
    -- eventMgr:AddListener(EventType.Team_Grid_RefreshColor, OnSetColor);
    eventMgr:AddListener(EventType.Drag_Card_Begin, OnDragGrid);
    eventMgr:AddListener(EventType.Drag_Card_End,OnDragGridEnd)
    eventMgr:AddListener(EventType.Drag_Card_Ctrl_State,OnDragCtrlState)
end

function OnDisable()
    eventMgr:ClearListener();
end

function OnDragCtrlState(state)
    if not IsNil(dragCom) then
        dragCom.enabled = state;
    end
end

function OnDragGrid(eventData)--用于判断多点拖拽的时候做的处理
    if dragObj and eventData then
        SetDragActive(eventData.cid==dragObj.data.cid)
    else
        SetDragActive(false)
    end
end

function OnDragGridEnd() --拖拽完之后启用拖拽判定
    SetDragActive(true)
end

function OnDrop(cardObj)
    TeamMgr:SetDragFingerID();
    if cardObj then
        local lua=ComUtil.GetLuaTable(cardObj);
        if lua ==nil then
            do return end
        end
        local obj=lua.GetDragChild();
        if obj~=nil and obj.GetTag()=="TeamDrag" then
            EventMgr.Dispatch(EventType.Drop_Card_Item,gameObject.name);
        end
    end
end

function OnBeginDragXY(x,y)
    isDrag=true;
    if dragObj and canDrag then
        EventMgr.Dispatch(EventType.Drag_Card_Begin, {cid=dragObj.data.cid});
        dragObj.SetSibling();
    elseif dragTips then
        Tips.ShowTips(dragTips);
    end
end

--设置拖拽的物体
function SetDragChild(tab)
    dragObj=tab;
end

function GetDragChild()
    return dragObj;
end

--拖拽中
function OnDragXY(x,y)   
    if dragObj and canDrag then
        local pos=UnityEngine.Vector3(x,y,transform.position.z);
        dragObj.Move(pos);
        EventMgr.Dispatch(EventType.Drag_Card_Holding,pos);
    end
end

--停止拖拽
function OnEndDragXY(x,y)
    isDrag=false;
    if canDrag then
        EventMgr.Dispatch(EventType.Drag_Card_End);
    end
end

--设置当前格子颜色，1：空置，2：被占用，3：buff效果,4:非点击物效果,5：位置上已存在卡牌,6:无法放置
function SetColor(type)
    if dragObj then
        dragObj.SetGridColor(type);
    end
    -- local color=FormationUtil.GetHalo2DGridColor(type);
    -- CSAPI.SetImgColor(gameObject,color[1],color[2],color[3],color[4]);
    -- local color=FormationUtil.GetHalo2DGridColor(type);
    -- CSAPI.SetImgColor(gameObject,color[1],color[2],color[3],color[4]);
end
--[[
function OnSetColor(data)
    if data then
        local has=false;
        for k,v in ipairs(data) do
            if gameObject.name==v.key then
                SetColor(v.type);
                break;
            end
        end
    end
end
]]

function OnClickGO() --显示光环信息
    if dragObj and not isDrag then
        EventMgr.Dispatch(EventType.Team_FormationView_Select,{cid=dragObj.data.cid});
    end
end

function Clear()
    dragObj=nil;
    isDrag=false;
end

function SetDragActive(isActive,_dragTips)
    canDrag=isActive
    dragTips=_dragTips;
end

function SetClickActive(isActive)
    clickImg.raycastTarget=isActive
end

--判断点是否在当前的格子里
function IsPointInMatrix(p)
    local pos= transform:InverseTransformPoint(p);
    p1={x=FormationUtil.gridSize[1]/2,y=FormationUtil.gridSize[2]/2}
	p2={x=FormationUtil.gridSize[1]/2,y=FormationUtil.gridSize[2]/2*-1}
	p3={x=FormationUtil.gridSize[1]/2*-1,y=FormationUtil.gridSize[2]/2}
	p4={x=FormationUtil.gridSize[1]/2*-1,y=FormationUtil.gridSize[2]/2*-1}
    if pos.x>=p3.x and pos.x<=p1.x and pos.y>=p4.y and pos.y<=p1.y then
        return true;
    else
        return false;
    end
end

function GetPos()
    if position then
        return position;
    else
        position=transform.position;
        return position;
    end
end