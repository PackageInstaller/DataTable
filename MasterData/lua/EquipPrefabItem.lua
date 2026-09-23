local data=nil;
local elseData=nil;
local grids={};
local equips=nil;
function Awake()
    local items={grid1,grid2,grid3,grid4,grid5};
    for i=1,g_EquipSlotCnt do
		local _,item=ResUtil:CreateEquipItem(items[i].transform)
        item.transform:SetSiblingIndex(0);
        item.Clean();
		-- CSAPI.SetGOActive(item.gameObject,true);
		CSAPI.SetScale(item.gameObject,0.75,0.75,0.75);
		table.insert(grids,item);
	end
    local iconName = Cfgs.ItemInfo:GetByID(g_EquipPrefabCost[1]).icon.."_1";
	ResUtil.IconGoods:Load(mIcon,iconName);
	CSAPI.SetRTSize(mIcon,40,40);
end

function Refresh(_data,_elseData)
    data=_data;
    elseData=_elseData;
    if elseData then
        SetLock(not elseData.isOpen);
        CSAPI.SetGOActive(line,not _elseData.isLast);
    end
    local alpha=1;
    if data then
        equips={};
        if data.ids then
            for k,v in pairs(data.ids) do
                local equip=EquipMgr:GetEquip(v);
                if equip then
                    equips[equip:GetSlot()]=equip;
                end
            end
        else
            alpha=0.3;
        end
        --显示装备状态
        for i=1,g_EquipSlotCnt do
            if equips[i] then
                grids[i].Refresh(equips[i]);
                CSAPI.SetGOActive(this["gAdd_"..i],false);
            else
                grids[i].Clean();
                if elseData and elseData.isOpen then
                    CSAPI.SetGOActive(this["gAdd_"..i],true);
                end
            end
        end
    end
    CSAPI.SetGOAlpha(btn_change,alpha);
    CSAPI.SetText(txt_price,tostring(g_EquipPrefabCost[2]));
end

function SetLock(isLock)
    CSAPI.SetGOActive(root,not isLock);
    CSAPI.SetGOActive(lockObj,isLock);
end

function OnClickRecord()
    --记录当前角色身上的装备到当前位置
    EventMgr.Dispatch(EventType.EquipPrefab_Replace,data.index);
end

function OnClickChange()
    -- 将当前缓存的装备配置穿戴到当前角色身上
    if equips then
        for k, v in pairs(equips) do
            if v:GetDisClickState() then
                local dialogdata={};
                dialogdata.content = LanguageMgr:GetTips(76003)
                dialogdata.okText = LanguageMgr:GetByID(56008)
                dialogdata.okText2 = LanguageMgr:GetByType(56008,4)
                dialogdata.okCallBack = function()
                    JumpMgr:Jump(20002)
                end
                CSAPI.OpenView("Dialog", dialogdata)
                do return end
            end
        end
    end
    EventMgr.Dispatch(EventType.EquipPrefab_Ups, data);
end


function OnClickGrid(go)

end

function OnClickOpen()
    EventMgr.Dispatch(EventType.EquipPrefab_AddLogSlot,data.index);
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
root=nil;
grid1=nil;
glock_1=nil;
gAdd_1=nil;
grid2=nil;
glock_2=nil;
gAdd_2=nil;
grid3=nil;
glock_3=nil;
gAdd_3=nil;
grid4=nil;
glock_4=nil;
gAdd_4=nil;
grid5=nil;
glock_5=nil;
gAdd_5=nil;
btn_record=nil;
btn_change=nil;
btn_open=nil;
moneyObj=nil;
mIcon=nil;
txt_price=nil;
view=nil;
equips=nil;
end
----#End#----