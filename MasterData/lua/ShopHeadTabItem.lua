--二级分页子物体
local data=nil;
local eventMgr=nil;
local pageID=nil;--一级页面ID
local isNew=false;
local setNew=false;
local animator=nil;

function Awake()
    animator=ComUtil.GetCom(gameObject,"Animator");
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRedInfo)
    eventMgr:AddListener(EventType.Shop_NewInfo_Refresh,SetNewInfo)
end

function OnDisable()
    this.isOn=false;
end

function OnDestroy()
    eventMgr:ClearListener();
    eventMgr=nil;
    animator=nil;
    data=nil;
    gameObject=nil;
end

function Refresh(cfg,elseData)
    local isRed=false;
    if cfg then
        this.cfg=cfg;
        CSAPI.SetText(txt_title,cfg.name);
        CSAPI.SetText(txt_title2,cfg.name);
        SetLimit(cfg.endTime~=nil);
    else
        this.cfg=nil;
    end
    if elseData then
        local isOn=elseData.sID==this.cfg.id
        local isTween=isOn;
        if isOn~=true then
            isTween=this.isOn==true
        elseif isOn==this.isOn then
            isTween=false
        end
        SetState(isOn,isTween)
        isRed=elseData.isRed==true;
        pageID=elseData.pageID;
        SetWidth(elseData.width)
        SetNewInfo(ShopMgr:GetPageNewInfos());
        CSAPI.SetGOActive(line,this.index~=elseData.len)
    else
        SetState(false)
        this.isOn=false;
    end
    CSAPI.SetGOActive(redPoint,isRed);
end

function SetState(_isOn,_isTween)
    CSAPI.SetGOActive(bg,_isOn);
    CSAPI.SetGOActive(txt_title,_isOn~=true);
    CSAPI.SetGOActive(txt_title2,_isOn);
    if _isTween then
        ShopCommFunc.PlayAnimation(animator,_isOn and "HeadTab_sel" or "HeadTab_Nsel");
    end
    this.isOn=_isOn;
end

function SetLimit(_isShow)
    CSAPI.SetGOActive(limit,_isShow);
end

function SetIndex(_i)
    this.index=_i;
end

--检测红点数据
function SetRedInfo()
    local isShowRed = false;
    if isNew ~= true then
        local rd = RedPointMgr:GetData(RedPointType.Shop);
        local rd2 = RedPointMgr:GetData(RedPointType.RegressionShop);
        if rd and this.cfg then
            if rd[this.cfg.id] then
                isShowRed = true
            elseif (this.cfg.group and rd[this.cfg.group] and this.cfg.isAll == 1) or (rd.cTab and rd.cTab[this.cfg.id]) then
                isShowRed = true
            end
        end
        if isShowRed ~= true and rd2 and this.cfg then
            if rd2 and this.cfg and this.cfg.group == 3001 then -- 判断是否是回归商店的子页签
                if (rd2[this.cfg.id]) then
                    isShowRed = true
                end
            end
        end
    end
    CSAPI.SetGOActive(redPoint, isShowRed);
end


function SetNewInfo(infos)
    if infos  and pageID and this.cfg and infos[pageID] and infos[pageID][this.cfg.id] then
        CSAPI.SetGOActive(newObj,true);
        isNew=true;
    else
        CSAPI.SetGOActive(newObj,false);
        isNew=false;
    end 
end

function RefreshRecord()
    if isNew and this.cfg and pageID then
        setNew=true;
        ShopMgr:SetCommResetInfo(pageID,this.cfg.id);
    end
end

function OnClickSelf()
    EventMgr.Dispatch(EventType.Shop_TopTab_Change,this);
end

function SetWidth(_width)
    local width=_width or 298
    CSAPI.SetRTSize(gameObject,width,66);
    CSAPI.SetRTSize(mask,width,66);
end