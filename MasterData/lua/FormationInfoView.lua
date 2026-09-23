--编队详情UI
local leaderClick=nil;
local descTxts={}
local data=nil;
function Awake()
    leaderClick=ComUtil.GetCom(btnLeader,"Image");
    if topRoot~=nil then
        upTween = ComUtil.GetCom(txtVal1, "ActionNumberRunner");
        centerTween = ComUtil.GetCom(txtVal2, "ActionNumberRunner");
        downTween = ComUtil.GetCom(txtVal3, "ActionNumberRunner");
        descTxts={{txtAttr1,txtVal1,upTween},{txtAttr2,txtVal2,centerTween},{txtAttr3,txtVal3,downTween}};
    end
end

--- func 刷新界面
---@param _data teamItemData
---@param isTop 是否只显示上方UI
function Refresh(_data, isTop)
    -- 读取光环信息
    data = _data
    SetHaloInfo();
    if isTop then
        CSAPI.SetGOActive(leftRoot, false);
    else
        CSAPI.SetGOActive(leftRoot, true);
    end
end

function SetHaloInfo()
    if data and topRoot ~= nil then
        local curHalo = data:GetHaloInfo();
        if (curHalo==nil) then -- 光环范围
            do return end;
        end
        curHalo:LoadIcon(icon)
        CSAPI.SetRTSize(icon, 60, 60);
        -- 读取光环加成
        local attrDatas = HaloUtil.CountHaloAddtion(curHalo, data:GetCard(), nil, nil, nil, nil);
        for k, v in ipairs(attrDatas) do
            if v.cfg then
                local addtive = 0;
                local endStr = "";
                if HaloUtil.fixedList[v.cfg.sFieldName]==nil then -- 除速度外所有加成以百分比显示
                    addtive = tonumber(string.match(v.addtive, "%d+"));
                    endStr = "%"
                else
                    addtive = v.addtiveNum or 0;
                end
                CSAPI.SetText(descTxts[k][1], v.cfg.sName2);
                descTxts[k][3].currentNum = 0;
                descTxts[k][3].fixedBStr = endStr;
                descTxts[k][3].targetNum = addtive;
                descTxts[k][3]:Play();
            end
        end
        CSAPI.SetGOActive(attr3Obj, #attrDatas >= 3);
        -- CSAPI.SetGOActive(topLine, index > 1);
    end
end


function SetLeaderEnable(enable)
    -- local color=enable and {255,255,255,255} or {122,122,122,255}
    -- CSAPI.SetImgColor(btnLeader,color[1],color[2],color[3],color[4]);
    -- CSAPI.SetTextColor(btnLeader,color[1],color[2],color[3],color[4]);
    leaderClick.raycastTarget=enable==true;
    CSAPI.SetGOActive(btnLeader,enable==true);
end

--设为队长
function OnClickLeader()
    local cid=nil;
    if data then
        cid=data.cid;
    end
    EventMgr.Dispatch(EventType.Team_FormationInfo_Click,{type=1,cid=cid});
end

--角色详情
function OnClickDetails()
    local cid=nil;
    if data then
        cid=data.cid;
    end
    EventMgr.Dispatch(EventType.Team_FormationInfo_Click,{type=2,cid=cid});
end

--移出队伍
function OnClickLeave()
    local cid=nil;
    if data then
        cid=data.cid;
    end
    EventMgr.Dispatch(EventType.Team_FormationInfo_Click,{type=3,cid=cid});
end

function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
data=nil;
gameObject=nil;
transform=nil;
this=nil;  
leftRoot=nil;
btnLeader=nil;
btnDetails=nil;
btnLeave=nil;
topRoot=nil;
icon=nil;
txtAttr1=nil;
txtVal1=nil;
txtAttr2=nil;
txtVal2=nil;
txtAttr3=nil;
txtVal3=nil;
upTween = nil;
centerTween = nil;
downTween = nil;
topLine=nil;
view=nil;
end
----#End#----