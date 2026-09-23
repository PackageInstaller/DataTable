--装备盘
local slotData={};--对应位置的装备数据
local data=nil;
local eventMgr=nil;
local slotNodes={}
local grids={};
function Awake()
    eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Equip_Down_Ret,OnDownRet);
    eventMgr:AddListener(EventType.Equip_Change,OnChange);
    slotNodes={tGO,lGO,cGO,rGO,bGO}
end

--data:{card=CharacterCardData} openSetting:EquipCoreSetting
function Init(_d,_openSetting)
    data=_d.card;
    openSetting=_openSetting==nil and EquipCoreSetting.Role or _openSetting
    slotData={};
    Refresh();
end

function OnChange()
    data=RoleMgr:GetData(data:GetID());
    Refresh();
end

--刷新界面
function Refresh()
    if #grids<=0 then
        for i = 1, 5, 1 do
            ResUtil:CreateUIGOAsync("EquipCore/EquipMiniGrid",slotNodes[i],function(go)
                local lua=ComUtil.GetLuaTable(go);
                lua.SetSlot(i);
                if data then
                    lua.Refresh(data:GetEquipBySlot(i));
                else
                    lua.InitNull();
                end
                table.insert(grids,lua)
            end)
        end
    else
        for k, v in ipairs(grids) do
            if data then
                v.Refresh(data:GetEquipBySlot(k));
            else
                v.InitNull();
            end
        end
    end
end

--初始化单个装备信息
-- function SetItemState(key,equip)
--     CSAPI.SetGOActive(this[key.."Root"],equip~=nil);
--     CSAPI.SetGOActive(this[key.."Point"],equip~=nil);
--     CSAPI.SetGOActive(this[key.."Slot"],equip~=nil);
--     CSAPI.SetGOActive(this[key.."Empty"],equip==nil);
--     CSAPI.SetGOActive(this[key.."CB"],key==currKey)
--     if equip~=nil then
--         ResUtil.IconGoods:Load(this[key.."Icon"],equip:GetIcon(),true);
--         local color=GetQualityColor(equip:GetQuality());
--         CSAPI.SetImgColor(this[key.."Point"],color[1],color[2],color[3],color[4]);
--         local lvStr=string.format(LanguageMgr:GetByID(23040),equip:GetLv());
--         CSAPI.SetText(this["txt_"..key.."Lv"],lvStr);
--     end
--     if openSetting==EquipCoreSetting.Role then
--         CSAPI.SetGOActive(this["txt_"..key.."Lv"],true);
--         CSAPI.SetGOActive(this["btn_"..key.."UnEquip"],true);
--         CSAPI.SetGOActive(this[key.."Border"],true);
--         CSAPI.SetGOActive(ltPoint,false);
--         CSAPI.SetGOActive(lbPoint,false);
--         CSAPI.SetGOActive(rbPoint,false);
--         CSAPI.SetGOActive(btnLT,true);
--         CSAPI.SetGOActive(btnLB,true);
--         CSAPI.SetGOActive(btnRB,true);
--     elseif openSetting==EquipCoreSetting.Search then
--         CSAPI.SetGOActive(this["txt_"..key.."Lv"],true);
--         CSAPI.SetGOActive(this["btn_"..key.."UnEquip"],false);
--         CSAPI.SetGOActive(this[key.."Border"],true);
--         CSAPI.SetGOActive(ltPoint,true);
--         CSAPI.SetGOActive(lbPoint,true);
--         CSAPI.SetGOActive(rbPoint,true);
--         CSAPI.SetGOActive(btnLT,false);
--         CSAPI.SetGOActive(btnLB,false);
--         CSAPI.SetGOActive(btnRB,false);
--     elseif openSetting==EquipCoreSetting.Select then
--         CSAPI.SetGOActive(this["txt_"..key.."Lv"],true);
--         CSAPI.SetGOActive(this["btn_"..key.."UnEquip"],false);
--         if currKey==key then
--             CSAPI.SetGOActive(this[key.."Border"],true);
--         else
--             CSAPI.SetGOActive(this[key.."Border"],true);
--         end
--         CSAPI.SetGOActive(ltPoint,false);
--         CSAPI.SetGOActive(lbPoint,false);
--         CSAPI.SetGOActive(rbPoint,false);
--         CSAPI.SetGOActive(btnLT,true);
--         CSAPI.SetGOActive(btnLB,true);
--         CSAPI.SetGOActive(btnRB,true);
--     end
-- end

--点击装备位
function OnClickItem(go)
    local slot=-1;
    for k,v in ipairs(slotNodes) do
        if v==go then
            slot=k;
            break;
        end
    end
    if slot~=-1 and data then
        local equip=data:GetEquipBySlot(slot);
        if equip then
            local os=3;
            if data and data:CheckIsRealCard()~=true then
                os=5;
            else
                os=openSetting==EquipCoreSetting.Search and 3 or 2;
            end
            CSAPI.OpenView("EquipFullInfo",equip,os);
        elseif openSetting~=EquipCoreSetting.Search and CanEdit() then
            CSAPI.OpenView("RoleEquip",{card=RoleMgr:GetData(data:GetID()),slot=slot},openSetting);
        end
    end
end

function CanEdit()
    local cid=data:GetID();
    if cid then
        local isFight=TeamMgr:GetCardIsDuplicate(cid);
        local isAssist=FriendMgr:IsAssist(cid);
        if isAssist==true then
            Tips.ShowTips(LanguageMgr:GetTips(12006));
            return false;
        elseif isFight then
            Tips.ShowTips(LanguageMgr:GetTips(12007))
            return false;
        end
    end
    return true;
end

--卸载装备
-- function OnClickUnEquip(go)
--     currKey=string.sub(go.name,5,5);
--     local equip=slotData[slotIndex[currKey]];
--     if IsInFight()==false and openSetting~=EquipCoreSetting.Search and equip~=nil then
-- 		local card=RoleMgr:GetData(data:GetID());
--         EquipProto:EquipDown({equip:GetID()}); 
-- 	end
-- end

function OnDownRet(ids)
    data=RoleMgr:GetData(data:GetID());
    Tips.ShowTips(LanguageMgr:GetByID(23059))
    Refresh();
    -- EventMgr.Dispatch(EventType.Equip_Change);
end

-- function IsInFight()
--     local cid=data:GetID();
--     if cid then
--         local isAssist=FriendMgr:IsAssist(cid);
--         if isAssist==true then
--             Tips.ShowTips(LanguageMgr:GetTips(12006));
--             return true;
--         end
--         local isFight=TeamMgr:GetCardIsDuplicate(cid);
--         if isFight then
--             Tips.ShowTips(LanguageMgr:GetTips(12007))
--             return true;
--         end
--     end
--     return false;
-- end

-- function GetQualityColor(quality)
--     local color={255,255,255,122};
--     if quality==2 then
--         color={0,255,191,122};
--     elseif quality==3 then
--         color={77,195,255,122};
--     elseif quality==4 then
--         color={147,38,255,122};
--     elseif quality==5 then
--         color={255,193,70,122};
--     end
--     return color;
-- end

-- --记录芯片
-- function OnClickLT()
--     EventMgr.Dispatch(EventType.Equip_Core_LT);
-- end

-- --一键卸载
-- function OnClickLB()
--     if IsInFight()==false and openSetting~=EquipCoreSetting.Search and slotData~=nil then
-- 		-- local card=RoleMgr:GetData(data:GetID());
--         local ids={};
--         for k,v in pairs(slotData) do
--             table.insert(ids,v:GetID());
--         end
--         EquipProto:EquipDown(ids); 
-- 	end
-- end

-- --快捷换芯
-- function OnClickRB()
--     EventMgr.Dispatch(EventType.Equip_Core_RB);
-- end
function OnDestroy()    
    eventMgr:ClearListener();
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
root=nil;
equipItems=nil;
tGO=nil;
tBorder=nil;
tEmpty=nil;
tPoint=nil;
tCB=nil;
tRoot=nil;
tIcon=nil;
btn_tUnEquip=nil;
txt_tLv=nil;
tSlot=nil;
lGO=nil;
lBorder=nil;
lEmpty=nil;
lPoint=nil;
lCB=nil;
lRoot=nil;
lIcon=nil;
btn_lUnEquip=nil;
txt_lLv=nil;
lSlot=nil;
cGO=nil;
cBorder=nil;
cEmpty=nil;
cPoint=nil;
cCB=nil;
cRoot=nil;
cIcon=nil;
btn_cUnEquip=nil;
txt_cLv=nil;
cSlot=nil;
rGO=nil;
rBorder=nil;
rEmpty=nil;
rPoint=nil;
rCB=nil;
rRoot=nil;
rIcon=nil;
btn_rUnEquip=nil;
txt_rLv=nil;
rSlot=nil;
bGO=nil;
bBorder=nil;
bEmpty=nil;
bPoint=nil;
bCB=nil;
bRoot=nil;
bIcon=nil;
btn_bUnEquip=nil;
txt_bLv=nil;
bSlot=nil;
ltPoint=nil;
lbPoint=nil;
rtPoint=nil;
rbPoint=nil;
btnLT=nil;
btnLB=nil;
btnRB=nil;
view=nil;
end
----#End#----