
--装备预设界面
local eventMgr=nil;
local cap=0;
local logs={};
local items=nil;
local layout=nil;
-- local data=nil;
function Awake()
    layout = ComUtil.GetCom(vsv, "UISV")
	layout:Init("UIs/RoleEquip/EquipPrefabItem",LayoutCallBack,true)
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.EquipPrefab_Ups, EquipUps);
    eventMgr:AddListener(EventType.EquipPrefab_Replace, RecordEquip);
    eventMgr:AddListener(EventType.EquipPrefab_AddLogSlot,AddLogSlot);
    eventMgr:AddListener(EventType.EquipPrefab_Refresh,Refresh);
    eventMgr:AddListener(EventType.Equip_UsePrefab_Ret,OnUseLogsRet);
    eventMgr:AddListener(EventType.Equip_AddPrefab_Ret,OnAddLogsRet);
    eventMgr:AddListener(EventType.Equip_SetPrefab_Ret,OnSetLogsRet);
    eventMgr:AddListener(EventType.Equip_GetPrefabs_Ret,OnGetLogsRet);
    -- --获取装备预设信息
    -- EquipProto:EquipLogs();
end 

function OnDestroy()
	eventMgr:ClearListener();
    ReleaseCSComRefs();
end

-- --data:卡牌对象
function OnOpen()
    --获取装备预设信息
    EquipProto:EquipLogs();
end

function OnGetLogsRet(proto)
    cap=proto.cap;
    logs=proto.logs;
    EventMgr.Dispatch(EventType.EquipPrefab_Refresh);
end

function Refresh(_data)
    --显示列表
    if _data then
        data=_data;
    end
    curDatas={};
    for i=1,g_EquipPrefabMax do
        local d={index=i};
        if logs and logs[i] then
            d={index=i,ids=logs[i]};
        end
        table.insert(curDatas,d);
    end
    layout:IEShowList(#curDatas)
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local item=layout:GetItemLua(index);
    local elseData={
		isOpen=_data.index<=cap,
        isLast=index>=#curDatas,
	}
    item.Refresh(_data,elseData);
end

--记录装备
function RecordEquip(eventData)
    local equips=data:GetEquips()
    if eventData and equips~=nil and #equips>0 then
        EquipProto:SetEquipLogs(data:GetID(),eventData);
    end
end

function OnSetLogsRet(proto)
    Tips.ShowTips(LanguageMgr:GetByID(23064))
    local equips=data:GetEquips()
    if proto and equips then
        local ids={};
        for k,v in ipairs(equips) do
            table.insert(ids,v:GetID());
        end
        logs[proto.index]=ids;
        EventMgr.Dispatch(EventType.EquipPrefab_Refresh);
    end
end

--穿戴装备
function EquipUps(eventData)
    --比较当前卡牌的装备ID
    if eventData and eventData.ids then
        local equips=data:GetEquips();
        local hasEquipped=false;
        for _,val in ipairs(eventData.ids) do--已经穿戴在当前卡牌的装备ID不需要发过去
            local equip=EquipMgr:GetEquip(val);
            local has=false;
            if equip then
                for k,v in ipairs(equips) do 
                    if v:GetID()==val then
                        has=true;
                        break;
                    end
                end
                if hasEquipped==false then
                    hasEquipped=equip:IsEquipped();
                end
            end
        end
        if hasEquipped then
            local dialogdata = {};
            dialogdata.content =LanguageMgr:GetTips(12002);
            dialogdata.okCallBack = function()
                EquipProto:UseEquipLogs(data:GetID(),eventData.index);
            end
            CSAPI.OpenView("Dialog", dialogdata)
        else
            EquipProto:UseEquipLogs(data:GetID(),eventData.index);
        end
    end
end

function OnUseLogsRet()
    EventMgr.Dispatch(EventType.Equip_Change);
    EventMgr.Dispatch(EventType.EquipPrefab_Refresh);
end

--添加槽位
function AddLogSlot(eventData)
    local dialogdata = {};
	dialogdata.content =LanguageMgr:GetTips(12001);
	dialogdata.okCallBack = function()
		EquipProto:AddEquipLogSlot();
	end
	CSAPI.OpenView("Dialog", dialogdata)
end

function OnAddLogsRet(proto)
    if proto then
        cap=proto.cap;
        EventMgr.Dispatch(EventType.EquipPrefab_Refresh);
    end
end

function OnClickAnyway()
    Close();
end

function Close()
    view:Close();
    -- CSAPI.SetGOActive(gameObject,false)
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
root=nil;
vsv=nil;
view=nil;
end
----#End#----