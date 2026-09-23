local data = nil;
local isOn = false;
local isNew = false;
local setNew = false;
local eventMgr = nil;
local animator = nil; --默认不启用

function Awake()
    animator = ComUtil.GetComInChildren(gameObject, "Animator");
    animator.enabled=false;
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetRedInfo)
    eventMgr:AddListener(EventType.Shop_NewInfo_Refresh,SetNewInfo)
end

function OnDestroy()
    eventMgr:ClearListener();
end

function Refresh(_d, _elseData)
    data = _d;
    if data then
        CSAPI.SetGOActive(red, false);
        SetIcon(data:GetIcon());
        SetTitle(data:GetNameID())
        SetNewInfo(ShopMgr:GetPageNewInfos());
        if _elseData then
            -- ShopCommFunc.PlayAnimation(animator,"nativeDefault")
            if _elseData.isFirst~=true then
                CSAPI.SetGOAlpha(root,1)
            end
            animator.enabled=false;
            if this.index == _elseData.sIndex then
                SetState(true,false); -- 设置选中状态
            else
                SetState(false,false);
            end
        end
        SetRedInfo();
    end
end

function PlayEntry(delay)
    ShopCommFunc.PlayAnimation(animator, "tabsEntry", delay, 10, function()
        if not IsNil(gameObject) and not IsNil(transform) then
            SetState(isOn,isOn);
        end
    end);
end

function SetIcon(iconName)
    if iconName ~= "" and iconName ~= nil then
        CSAPI.LoadImg(icon, string.format("UIs/Shop/%s.png", iconName), true, nil, true)
        CSAPI.SetGOActive(icon, true)
    else
        CSAPI.SetGOActive(icon, false)
    end
end

function SetTitle(id)
    local str = "";
    local str2 = ""
    if id then
        str = LanguageMgr:GetByID(id)
    end
    CSAPI.SetText(txt_name, str);
    CSAPI.SetText(txt_name2, str);
end

-- 检测红点数据
function SetRedInfo()
    local isShowRed = false;
    if isNew then
        isShowRed=false;
    else
        local rd = RedPointMgr:GetData(RedPointType.Shop);
        local rd2 = RedPointMgr:GetData(RedPointType.RegressionShop);
        if rd and data and rd[data:GetID()] then
            isShowRed = true;
        end
        if isShowRed ~= true and rd2 and data and rd2[data:GetID()] then
            isShowRed = true;
        end
    end
    CSAPI.SetGOActive(red, isShowRed);
end

function SetNewInfo(infos)
    if infos and infos[data:GetID()] then
        CSAPI.SetGOActive(newObj, true);
        isNew = true;
    else
        CSAPI.SetGOActive(newObj, false);
        isNew = false;
    end
end

function SetIndex(_index)
    this.index = _index;
end

function GetIndex()
    return this.index;
end

function GetState()
    return isOn;
end

function SetState(_isOn, _isTween)
    isOn = _isOn;
    CSAPI.SetGOActive(onObj, _isOn == true);
    CSAPI.SetGOActive(txt_name, _isOn ~= true);
    CSAPI.SetGOActive(txt_name2, _isOn == true);
    CSAPI.SetGOAlpha(icon,_isOn == true and 1 or 0.7)
    CSAPI.SetImgColorByCode(icon,_isOn == true and "FFC146" or "ffffff")
    if _isTween then
        ShopCommFunc.PlayAnimation(animator, isOn and "tabsSel" or "tabsNsel",0);
    else
        CSAPI.SetGOAlpha(txt_name,_isOn == true and 0 or 1)
        CSAPI.SetGOAlpha(txt_name2,_isOn == true and 1 or 0)
    end
end

function OnClickItem()
    EventMgr.Dispatch(EventType.Shop_Tab_Change, this.index)
end
