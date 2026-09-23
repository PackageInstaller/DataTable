--装备信息物体
local baseItems={};
local skillItems={};
local grid=nil;
local equip=nil;
local data=nil;
local elseData=nil;

function Refresh(_data,_elseData)
    data=_data;
    equip=data ==nil and nil or data.equip
    elseData=_elseData;
    CSAPI.SetText(txtTips,data==nil and "" or data.tips)
    if equip and equip:GetClassType()=="EquipData" then
        CSAPI.SetGOActive(node,true);
        CSAPI.SetGOActive(nullObj,false);
        CSAPI.SetText(txt_name,equip:GetName());
        if grid==nil then
            ResUtil:CreateUIGOAsync("Grid/EquipItem",gridNode,function(go)
                grid=ComUtil.GetLuaTable(go);
                grid.Refresh(equip);
            end)
        else
            grid.Refresh(equip);
        end
        ShowBase();
        ShowSkill();
    else
        CSAPI.SetGOActive(node,false);
        CSAPI.SetGOActive(nullObj,true);
        ItemUtil.AddItems("AttributeNew2/AttributeItemLock",baseItems,{},attrNode,nil,1,elseData);
        ItemUtil.AddItems("EquipInfo/EquipSkillAttributeLock",skillItems,{},skillNode,nil,1,elseData);
    end
end

function ShowBase()
    local list={};
    for i=1,g_EquipMaxAttrNum do
        local id,add,upAdd=equip:GetBaseAddInfo(i);
        if id and add and upAdd then
            local addition=add+upAdd*equip:GetLv();
            local text=EquipCommon.FormatAddtion(id,addition);
            table.insert(list,{id=id,val1="+"..text});
        end
    end
    ItemUtil.AddItems("AttributeNew2/AttributeItemLock",baseItems,list,baseRoot,nil,1,elseData);
end

function ShowSkill()
    local list={};
    if equip then
        local index=0;
        for i=1,g_EquipMaxSkillNum do
            local cfg=equip:GetSkillInfo(i);
            if cfg then
                if index<=g_EquipMaxSkillNum then
                    table.insert(list,cfg);
                    index=index+1;
                else
                    LogError("技能数量超过上限！！");
                end
            end       
        end
    end
    skillItems=skillItems or {};
    for i=1,g_EquipMaxSkillNum  do
        local isLock,desc=false,"";
        if list[i]~=nil and equip then
            isLock,desc=equip:GetSkillIsLock(list[i].id,i);
        end
        elseData.isLock=isLock;
        elseData.lockStr=desc;
        if skillItems and i <= #skillItems then
            skillItems[i].Refresh(list[i],elseData);
            skillItems[i].SetClickCB(OnClickSkillItem);
        else
            ResUtil:CreateUIGOAsync("EquipInfo/EquipSkillAttributeLock",skillRoot,function(go)
                local tab=ComUtil.GetLuaTable(go);
                tab.Refresh(list[i],elseData);
                tab.SetClickCB(OnClickSkillItem);
                table.insert(skillItems,tab);
            end);
        end
    end
end

function OnClickSkillItem(cfg)
    -- CloseChildWindow();
    --打开技能描述面板
    CSAPI.OpenView("RoleEquipSkillInfo",cfg);
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
gridNode=nil;
lockBtn=nil;
lockIcon=nil;
lockIcon2=nil;
txt_lock=nil;
txt_name=nil;
attrNode=nil;
skillNode=nil;
view=nil;
end
----#End#----