
function OnOpen()
    local currActivty=CollaborationMgr:GetCurrInfo();
    if currActivty==nil then
        LogError("显示绑定成功时未获取到活动信息！");
        Close()
        do return end;
    end
    CreateGridItem(PlayerClient:GetHeadFrameInfo(),bLNode)
    local plrs=currActivty:GetBindPlayers();
    if plrs==nil or next(plrs)==nil then
        do return end;
    end
    CreateGridItem(plrs[1],bRNode)
    CollaborationMgr:RecordInvitRet(false);
end

function CreateGridItem(data,parent,callBack)
    local go= ResUtil:CreateUIGO("Collaboration/CollaborationHeadGrid",parent.transform); 
    local grid=ComUtil.GetLuaTable(go);
    grid.Refresh(data,callBack);
    return grid;
 end

function OnClickOK()
    Close();
end

function Close()
    if IsNil(gameObject) or IsNil(view) then
        do return end
    end
    view:Close();
end