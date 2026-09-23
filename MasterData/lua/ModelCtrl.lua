function Awake()
    goParts = {};
    goParts[1] = foot;
    goParts[2] = body;
    goParts[3] = head;    

    if(not buffNode)then
        local targetParentNode = gameObject;
--        local myModelPos = GetModelPos();
--        if(myModelPos)then
--            targetParentNode = myModelPos;
--        end

        buffNode = CSAPI.CreateGO("BuffNode",0,0,0,targetParentNode);
    end

    if(faceNode)then
        matTexCtrl = ComUtil.GetCom(faceNode,"MaterialTexCtrl"); 
    end
end

function GetModelPos()
    return modelPos;
end

--
function GetBuffEffNode(buffEffNodeName)
    if(buffEffNodeName and this[buffEffNodeName])then  
        local targetBuffNode = this[buffEffNodeName]; 
        buffNodes = buffNodes or {};
        buffNodes[targetBuffNode] = 1;
        return targetBuffNode;
    end
    return buffNode;
end

function SetBuffNodesState(state)
    if(not buffNodes)then
        return;
    end
    for targetBuffNode,_ in pairs(buffNodes)do
        --CSAPI.SetGOActive(targetBuffNode,state);
        CSAPI.SetLocalPos(targetBuffNode,0,0,state and 0 or -1000);
    end
end

function GetPartGO(partIndex)
    local go = nil;
    if(partIndex)then
        go = goParts and partIndex and goParts[partIndex];
    end
    go = go or gameObject;
    return go;
end

function GetKeepState()
    if(keepState)then
        --LogError(keepState.name .. ":" .. tostring(keepState.activeInHierarchy));
        if(keepState.activeInHierarchy)then
            return keepState.name;
        end
    end
end

function IsActiveKeepState()
    local isActive = false;
    if(GetKeepState())then
        isActive = true;
    end

    return isActive;
end

function SetActiveKeepState(state)
    if(keepState)then
        CSAPI.SetGOActive(keepState,state);
    end
end


function SetFace(faceName,time)    
    if(matTexCtrl)then
        time = time or 0;
        matTexCtrl:SetTex(faceName,time);
    end
end

function GetHeadPos()
    local p={0,0,0};
    if head then
        local x,y,z=CSAPI.GetPos(head);
        p={x,y,z};
    end
    return p;
end