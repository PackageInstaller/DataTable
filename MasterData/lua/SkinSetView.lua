--时装图册界面
local layout=nil;
local layout2=nil;
local currState=1;--1:默认显示所有的皮肤系列 2：显示皮肤季度 3：显示皮肤系列详情
local flag=false;--是否显示未持有
local skinList={};--皮肤列表
local setList={}--合集列表
local allID=201;--时装合集ID，发售季度排序列表数据
local curSetID=nil;--当前选择的时装ID
local groupItems={};--分组子物体
local curDatas={};

function Awake()
    layout = ComUtil.GetCom(vsv, "UISV")
    layout:Init("UIs/ShopSkinPage/SkinSetItem",LayoutCallBack,true)
    layout2 = ComUtil.GetCom(vsv3, "UISV")
    layout2:Init("UIs/ShopSkinPage/SkinInfoItem",LayoutCallBack2,true)
    UIUtil:AddTop2("ShopView", gameObject, Close,nil,{});
end

function OnOpen()
    InitData();
    if data then
        curSetID=data;
        currState=3;  
    end
    Refresh();
end

function InitData()
    skinList={} --setID:List<ShopSkinInfo> 根据系列划分数组
    for k,v in pairs(Cfgs.CfgSkinInfo:GetAll()) do
        local skin=ShopSkinInfo.New();
        skin:InitCfg(v.id);
        skinList[v.setID]=skinList[v.setID] or {};
        local isShow=IsSkinCommShow(skin);
        if isShow and v.setID~=201 then --满足条件才显示
            table.insert(skinList[v.setID],skin);
        end
    end
    setList={};
    for k,v in pairs(Cfgs.CfgSkinSetInfo:GetAll()) do
        if (skinList and skinList[v.id] and #skinList[v.id]>0) and v.id~=201 then
            table.insert(setList,v);
        end
    end
    table.sort(setList,function(a,b)
        return a.sort<b.sort;
    end)
end

--未获得是否隐藏（读角色模型表的show字段）
function IsSkinCommShow(shopSkinInfo)
    local isShow=false;
    if shopSkinInfo==nil then
        return isShow
    end
    local hideType=shopSkinInfo:GetHideType();
    if hideType==nil or hideType==3 then --type==3表示一定隐藏
        isShow=false;
    elseif hideType==1 then--原始图
        --判断是否在商品上架期限
        local commodity=ShopCommFunc.GetSkinCommodity(shopSkinInfo:GetModelID());
        if commodity==nil then
            return isShow;
        end
        local rSkinInfo=RoleSkinMgr:GetRoleSkinInfo(shopSkinInfo:GetModelCfg().role_id, shopSkinInfo:GetModelCfg().id)
        if commodity:GetNowTimeCanBuy() then --是否可以购买
            isShow=true;
        elseif rSkinInfo~=nil and rSkinInfo:CheckCanUse() then
            isShow=true
        end
    elseif hideType==2 then--和谐图
        --判断是否在商品上架期限
        local commodity=ShopCommFunc.GetSkinCommodity(shopSkinInfo:GetModelID());
        if commodity==nil then
            return isShow;
        end
        local buyStartTime=commodity:GetBuyStartTime();
        if (buyStartTime>0 and buyStartTime<=TimeUtil:GetTime()) or (buyStartTime==0) then
            isShow=true;
        end
    end
    return isShow;
end

--切换集合与非集合
function SetToggleState(_isSet)
    CSAPI.SetAnchor(tagObj,_isSet and 78 or -110,-6);
    CSAPI.SetTextColorByCode(txt1,_isSet and "C3C3C8" or "131314");
    CSAPI.SetTextColorByCode(txt2,_isSet~=true and "C3C3C8" or "131314");
end

function Refresh()
    CSAPI.SetGOActive(vsv,currState==1);
    CSAPI.SetGOActive(toggleObj,flag)
    CSAPI.SetGOActive(btnToggle,currState==3);
    CSAPI.SetGOActive(btnToggle2,currState~=3);
    CSAPI.SetGOActive(vsv2,currState==2);
    CSAPI.SetGOActive(detailNode,currState==3);
    SetToggleState(currState==1);
    if currState==1 then
        layout:IEShowList(#setList);
    else
        local list={};
        local isAll=currState==2;
        if isAll then --季度详情
            local groupList={};
            for k, v in pairs(skinList) do
                for _, val in pairs(v) do
                    local season=val:GetSeasonID();
                    list[season]=list[season] or {}
                    table.insert(list[season],val);
                end
            end
            for k, v in pairs(list) do --合集只分期数
                table.insert(groupList,v);
            end
            ItemUtil.AddItems("ShopSkinPage/SkinSetPage", groupItems, groupList, Content,nil,1,{isAll=isAll,flag=flag})
        else
            list=skinList[curSetID] or {};
            SetDetails(list)
        end
    end
end

--合集详情
function SetDetails(list)
    if #list > 0 then
        -- 根据时装季度和序列进行分组排序
        table.sort(list, function(a, b)
            if a:GetSetID() == b:GetSetID() then
                if a:GetSeasonID() == b:GetSeasonID() then
                    return a:GetSort() < b:GetSort()
                else
                    return a:GetSeasonID() < b:GetSeasonID()
                end
            else
                return a:GetSetID() < b:GetSetID()
            end
        end);
        -- 创建子物体
        curDatas = list;
        local cfg=Cfgs.CfgSkinSetInfo:GetByID(list[1]:GetSetID());
        CSAPI.SetText(txtSetName,cfg.name)
        if cfg.icon then
            ResUtil.SkinSetIcon:Load(icon,cfg.icon.."_w",true);
        end
        layout2:IEShowList(#curDatas)
    else
        LogError("没有找到对应的时装信息")
    end
end

function LayoutCallBack(index)
    local _d=setList[index];
    local item=layout:GetItemLua(index);
    item.Refresh(_d)
    item.SetClickCB(OnClickSet);
end

--显示系列内容
function LayoutCallBack2(index)
    local _d=curDatas[index];
    local item=layout2:GetItemLua(index);
    item.Refresh(_d,{flag=flag})
    item.SetClickCB(OnClickItem)
end

function OnClickItem(tab)
    if tab then
        local modelCfg=tab.data:GetModelCfg();
        local commodity=ShopCommFunc.GetSkinCommodity(modelCfg.id);
        local isShowImg=false;
        if commodity~=nil then
            isShowImg=commodity:IsShowImg();
        end
        CSAPI.OpenView("RoleInfoAmplification", {modelCfg.id, false,isShowImg},LoadImgType.Main)
    end
end

function OnClickToggle()
    flag=not flag;
    Refresh();
end

function OnClickToggle2()
    currState= currState==1 and 2 or 1
    Refresh();
end

function OnClickSet(tab)
    curSetID=tab.data.id;
    currState=3;
    Refresh();
end

function Close()
    if currState==3 then
        currState=1;
        Refresh();
    else
        view:Close();
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if  Close then
        Close();
    end
end
