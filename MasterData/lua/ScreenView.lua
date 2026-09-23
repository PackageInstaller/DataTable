local starPos={-45.7,59.5};
local cellHeight=25;
local cellWidth=78;
local lineHeight=20;
local cellPadding=20;
local itemList={};
local tabList={};
local dataList=nil; --排序的数据
local realList=nil;--排序完成的数据
local onChange=nil; 
local onScreen=nil;
local currType=ScreenType.Role;
local currTab=nil;--当前选择的Tab按钮
local sortType=1;--排序类型，1：正序，2：倒序
local condition=nil;--已选择的条件
local isInit=nil;
local isShow=true;

--data:需要排序的数据,没有则不传,
--conds:缓存的筛选条件数据
--cb:当前筛选变更时的回调
--openType:筛选面板的类型参考GEumn中的ScreenType
function Init(data,conds,cb,openType)
    --初始化排序方式
    currType=openType==nil and ScreenType.Role or openType;
    currTab=nil;
    realList=nil
    condition=conds;
    dataList=data;
    onScreen=cb;
    isInit=true;
    Show(true);
    SetData();
	--初始化筛选方式
    if screenData then
        ItemUtil.AddSlopeItems(tabList, screenData, "Screen/SortTab", sortBtns, OnClickTab, 138, 59, 1, 0, 0, 31.5, 1)
	end
end

--创建筛选词条物体
function InitItems(data)
    if itemList then
        for k,v in ipairs(itemList) do
            CSAPI.SetGOActive(v.gameObject,false);
        end
    end
    if data==nil then
        LogError("初始化筛选词条失败！Data不能为nil！");
        return;
    end
    for k,v in ipairs(data.cfg) do
        local tab=nil;
        if k<=#itemList then
            tab=itemList[k];
            CSAPI.SetGOActive(itemList[k].gameObject,true);
        else
            local go=ResUtil:CreateUIGO("Screen/SortItem",content.transform);
            tab=ComUtil.GetLuaTable(go);
            --设置词条物体位置
            local x,y=0;
            if k<=3 then
                x=starPos[1]+cellWidth*(k-1)+cellPadding*(k-1);
                y=starPos[2];
            else
                local n=(k-3)%2==0 and 1 or 0;--列数
                local r=k%2==0 and (k-3+1)/2 or (k-3)/2 --行数
                x=starPos[1]+cellWidth*n+cellPadding*n;
                y=starPos[2]-cellHeight*r-lineHeight*r;
            end
            CSAPI.SetAnchor(go,x,y);
            table.insert(itemList,tab);
        end
        local isSelect=false;
        if condition and condition[data.key] then
            for _,id in ipairs(condition[data.key]) do
                if id==v.id then
                    isSelect=true;
                    break;
                end
            end
        end
        tab.Refresh({data=v,isSelect=isSelect},OnClickItem);
    end
end

function OnClickTab(tab)
    --初始化当前的Item
    if tab~=currTab then
        if currTab then
            currTab.SetSelect(false);
        end
        InitItems(tab.data);
    end
    currTab=tab;
    if onChange then
        onChange();
        if isInit and onScreen then
            isInit=false;
            onScreen(realList);
        end
    end
end

function OnClickItem(tab)
    if onChange then
        onChange();
    end
    if onScreen then
        onScreen(realList);
    end
end

function SetData()
    screenData = {};
    local list={};
    if currType==ScreenType.Role then--角色

    elseif currType==ScreenType.Equip or currType==ScreenType.EquipNoSlot then --装备
        table.insert(list, {
            key = "Qualiy",
            title = "品质",
            cfg = CfgEquipQualityEnum,
        });
        if currType~=ScreenType.EquipNoSlot then
            table.insert(list, {
                key = "Slot",
                title = "部位",
                cfg = CfgEquipSlotEnum,
            });  
            table.insert(list, {
                key = "Type",
                title = "类型",
                cfg = {{id=1,sName="普通装备"},{id=2,sName="素材装备"}},
            }); 
        end        
        local l={};
        for k,v in ipairs(CfgEquipSortEnum) do
            local cfgs=Cfgs.CfgEquipSkillTypeEnum:GetGroup(v.id);
            table.insert(list,{
                key="skill_"..v.eName,
                title=v.sName,
                cfg=cfgs,
            });
        end
        onChange=ScreenEquip;
    elseif currType==ScreenType.Material then--素材
        table.insert(list, {
            key = "Type",
            title = "类型",
            cfg = {{id=2,sName="突破素材"},{id=3,sName="普通素材"},},
        });
        onChange=ScreenMaterial;
    end
    local selectIndex=1;--默认选中的页签
    if condition then --获取默认选中的页签和排序类型
        selectIndex=condition["CIndex"][1];
        sortType=condition["Sort"][1];
        CSAPI.SetScale(sortIcon,1,sortType==1 and -1 or 1,1);
    end
    list[selectIndex].isSelect=true;
    screenData=list;
end

--统计当前选择的条件
function CountCondition()
    if condition ==nil then
        condition={};
    end
    if tabList then
        for k,v in ipairs(tabList) do
            if currTab and v==currTab then --只更改当前选择的tab的值
                condition[v.data.key]={};
                for _,item in ipairs(itemList) do
                    local sId=item.GetChoosieID();
                    if item.gameObject.activeSelf and sId~=nil then
                        table.insert(condition[v.data.key],sId);
                    end
                end
                if #condition[v.data.key]==0 then
                    condition[v.data.key]={-1};
                end
            end
        end
    end
    local cIndex=1;
    if screenData and currTab then
        for k,v in ipairs(screenData) do
            if v.key==currTab.data.key then
                cIndex=k;
                break;
            end
        end
    end
    condition["CIndex"]={cIndex} --当前选择的下标
    condition["Sort"]={sortType}; --当前的排序顺序
end

--返回当前选择的条件
function GetCondition()
    return condition;
end

--筛选装备
function ScreenEquip()
    local arr={};
    CountCondition();
    if dataList and condition then
        arr=EquipMgr:DoScreen(dataList, condition);
        if sortType==2 then
            arr=SortRealList(arr);
        end
    end
    realList=arr;
end

--筛选素材
function ScreenMaterial()
    local arr={};
    local tag=-1;
    CountCondition();
    if condition then
        for k,v in pairs(condition) do
            for _,val in ipairs(v) do
                if k=="Type" and tag==2 and val==3 then
                    tag=-1;
                elseif k=="Type" then
                    tag=val;
                end
            end
        end
    end
    if(dataList) then
		for _, data in pairs(dataList) do
			if(data) then
				local cfgGoods = data:GetCfg();
				if cfgGoods and cfgGoods.hide == nil then
					if(tag ~= -1 and cfgGoods.tag == tag) or(tag == -1 and(cfgGoods.tag == 2 or cfgGoods.tag == 3)) then	
						table.insert(arr, data);
					end
				end
			end
        end
        table.sort(arr,function(a,b)
			if a:GetQuality()==b:GetQuality() then
				return a:GetID() <b:GetID();
			else
				return a:GetQuality()>b:GetQuality()
			end
        end);
        if sortType==2 then
            arr=SortRealList(arr);
        end
    end
    realList=arr;
end

function OnClickSort()
    sortType=sortType==1 and 2 or 1;
    CSAPI.SetScale(sortIcon,1,sortType==1 and -1 or 1,1);
    realList=SortRealList(realList);
    if onScreen then
        onScreen(realList);
    end
end

--根据排序类型进行排列
function SortRealList(list)
    local arr={};
    if list then
        for i=1,#list do
            table.insert(arr, list[#list]);
			table.remove(list, #list);
        end
    end 
    return arr;
end

function GetCurrOpenType()
    return currType;
end

--设置显示/隐藏时的回调
function SetEnableCB(cb)
    this.eCb=cb;
end

function Hide(noTween)
    if noTween then
        isShow=false;
        CSAPI.SetGOActive(sortView,false);
        CSAPI.SetScale(showIcon,1,1,1);
        if this.eCb then
            eCb(false);
        end
    else
        UIUtil:DoLocalMove(sortView,{513,0,0},function()
            CSAPI.SetGOActive(sortView,false);
            CSAPI.SetScale(showIcon,1,1,1);
            isShow=false;
            if this.eCb then
                eCb(false);
            end
        end);
    end
end

function Show(noTween)
    if this.eCb then
        eCb(true);
    end
    CSAPI.SetGOActive(sortView,true);
    if noTween~=true  then
        UIUtil:DoLocalMove(sortView,{0,0,0},function()
            CSAPI.SetScale(showIcon,-1,1,1);
            isShow=true;
        end)
    else
        isShow=true;
    end
end

function OnClickShow()
    if isShow then
        Hide();
    else
        Show();
    end
end
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
showIcon=nil;
sortIcon=nil;
sortBtns=nil;
sortView=nil;
txt_title=nil;
content=nil;
view=nil;
end
----#End#----