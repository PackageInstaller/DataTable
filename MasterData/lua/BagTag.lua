--背包二级菜单页签
local t_enter=nil;
local t_out=nil;
local isOn=false;
local delayTime=120;
local index=0;
local count=0;
local isPlaying=false;
local func=nil;
local tagStartPos={1000,56};
local tagLineHegiht=108;
function Awake()
    t_enter=ComUtil.GetCom(eTabsOnAnima,"ActionMoveByCurve");
    t_out=ComUtil.GetCom(eTabsOutAnima,"ActionMoveByCurve");
    eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.RedPoint_Refresh,SetRedInfo)
end

function OnDestroy()
	eventMgr:ClearListener();
end


function Refresh(_d,_elseData)
    this.data=_d;
    if data then
        CSAPI.SetText(txt1,_d.txt1);
        CSAPI.SetText(txt2,_d.txt2);
        local urlStr="UIs/Bag/%s.png";
        CSAPI.LoadImg(onImg,string.format(urlStr,_d.icon1),true,nil,true);
        CSAPI.LoadImg(offImg,string.format(urlStr,_d.icon2),true,nil,true);
        if _elseData then
           SetState(_elseData.id==_d.id);
        end
        CSAPI.SetAnchor(gameObject,tagStartPos[1],tagStartPos[2]-(tagLineHegiht*(index-1)));
        SetRedInfo()
    end
end

function SetIndex(_index,_count)
    index=_index;
    count=_count;
end

function SetState(isOn)
    CSAPI.SetGOActive(on,isOn==true);
    CSAPI.SetGOActive(off,isOn~=true);
end

function SetClickCB(_f)
    func=_f;
end

function PlayTween(isEnter,addDelayTime)
    if isPlaying then
        do return end
    end
    addDelayTime=addDelayTime or 0;
    local x,y=CSAPI.GetAnchor(gameObject);
    if isEnter then
        local delay=delayTime*(index-1)+addDelayTime
        if t_enter then
            isPlaying=true;
            t_enter:SetStartPos(tagStartPos[1],y,0);
            t_enter:SetTargetPos(-20,y,0);
            t_enter.delay=delay;
            t_enter:ToPlay(function ()
                isPlaying=false;
            end);
        end
    else
        local delay=delayTime*(count-index)+addDelayTime
        if t_out then
            isPlaying=true;
            t_out:SetStartPos(-20,y,0);
            t_out:SetTargetPos(tagStartPos[1],y,0);
            t_out.delay=delay;
            t_out:ToPlay(function ()
                isPlaying=false;
            end);
        end
    end
    
end

function SetRedInfo()
	local redInfo2=RedPointMgr:GetData(RedPointType.MaterialBag);
    local isShow=false;
    if this.data and redInfo2~=nil and redInfo2.tagList~=nil then
        local isRed2=false;
        for k, v in ipairs(redInfo2.tagList) do
            if this.data.tag and this.data.tag==v then
                isRed2=true;
                break;
            end
        end
        UIUtil:SetRedPoint(gameObject,isRed2,110,20);
        if redInfo2.tagList.limitTags~=nil then
            isShow=redInfo2.tagList.limitTags[this.data.tag]==true;
        end
    else
        UIUtil:SetRedPoint(gameObject,false,110,20);
    end
    CSAPI.SetGOActive(limitObj,isShow);
end

function OnClick()
    if func then
        func(this);
    end
end