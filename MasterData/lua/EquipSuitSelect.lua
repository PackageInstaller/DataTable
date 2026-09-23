--装备套装选择框
local layout=nil;
local condition=nil;
local currEquip=nil;--当前选中的装备
local selectIndex=nil;
function Awake()
    layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/Grid/EquipItem",LayoutCallBack,true);
end

function OnEnable()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Equip_Select_Change, OnSelectChange);
    eventMgr:AddListener(EventType.Equip_Change,OnEquipChange);
end

function OnDisable()
	eventMgr:ClearListener();
end

function Init(_data)
    data=_data;
    condition = EquipMgr:GetScreenData(EquipViewKey.SuitSelect);
    currEquip=data.selectEquip;
    SetTabData();
    RefreshList();
end

function RefreshList()
    local list=data.list;
    selectIndex=nil;
    list=EquipMgr:DoScreen(list, condition)
    if list then
        if orderType ==1 then --正序。倒序
            local source = {};
            for i = 1, #list do
                table.insert(source, list[#list]);
                table.remove(list, #list);
            end
            curDatas=source;
        else
            curDatas = list;
        end
    end
    if curDatas then
        layout:IEShowList(#curDatas);
    end
end

function OnSelectChange(eventData)
    if currEquip and eventData.equip:GetID()==currEquip:GetID() then
        currEquip=nil;
    else
        currEquip=eventData.equip;
    end
    RefreshList()
end

function OnEquipChange(eventData)
    currEquip=eventData;
    RefreshList()
end

function LayoutCallBack(index)
    local _data = curDatas[index]
	local isSelect = false;
	if _data and currEquip then
		isSelect =_data:GetID()==currEquip:GetID();
        selectIndex=index;
    end
    local grid=layout:GetItemLua(index);
	grid.SetIndex(index);
	grid.Refresh(_data,{isClick = true, isSelect = isSelect,selectType=1,showNew=true});
	grid.SetClickCB(OnClickEquip);
end

function OnClickEquip(tab)
    EventMgr.Dispatch(EventType.Equip_Select_Change,{equip=tab.data,slot=tab.data:GetSlot()});
end

function OnClickClose()
    Close();
end

function Close()
    CSAPI.SetGOActive(view.gameObject,false);
end

function Show()
    CSAPI.SetGOActive(view.gameObject,true);
end

------------------------筛选

--页签数据
function SetTabData()
    --升降
    orderType = EquipMgr:GetOrderType(EquipViewKey.Replace);
    local rota = orderType == 1 and 180 or 0
    CSAPI.SetRectAngle(objSort, 0, 0, rota)
    local id=condition.Sort[1];
    local str = Cfgs.CfgEquipSortEnum:GetByID(id).sName or ""
	CSAPI.SetText(txtSort, str)
end

function OnClickFiltrate()
    local mData = {}
	--需要单选
	mData.single = {["Sort"] = 1} --1无意义
    mData.list = {"Sort","Qualiy","Equipped","skill"}
    mData.titles = {LanguageMgr:GetByID(24004),LanguageMgr:GetByID(24005),LanguageMgr:GetByID(24007),LanguageMgr:GetByID(24019)}
	--当前数据
	mData.info = condition
	--源数据
	local _root = {}
	_root.Sort="CfgEquipSortEnum";
	_root.Qualiy = "CfgEquipQualityEnum"
    _root.Equipped={{id=1,sName=LanguageMgr:GetByID(24002)},{id=2,sName=LanguageMgr:GetByID(24003)}};
    _root.skill=EquipCommon.GetFilterSkillList();
    -- for k,v in pairs(Cfgs.CfgEquipSkillTypeEnum:GetAll()) do
    --     if v.group and v.show==1 then
    --         table.insert(_root.skill,{id=v.id,sName=v.sName});
    --     end
	-- end
	-- table.sort(_root.skill,function(a,b)
	-- 	return a.id<b.id;
	-- end)
	mData.root = _root
	--回调
	mData.cb = OnSort
	CSAPI.OpenView("SortView", mData)
end

function OnClickUD()
    orderType = orderType==1 and 2 or 1;
    local rota = orderType == 1 and 180 or 0
    CSAPI.SetRectAngle(objSort, 0, 0, rota)
    RefreshList();
end

--筛选完毕
function OnSort(newInfo)
    condition=newInfo;
    local id=condition.Sort[1];
    local str = Cfgs.CfgEquipSortEnum:GetByID(id).sName or ""
	CSAPI.SetText(txtSort, str)
    RefreshList();
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
btnTool=nil;
txtFiltrate=nil;
btnUD=nil;
objSort=nil;
txtSort=nil;
vsv=nil;
view=nil;
end
----#End#----