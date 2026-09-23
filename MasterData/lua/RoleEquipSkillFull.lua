
local lastSkillItem=nil;
local selectSKId=nil; --当前高亮的详细技能信息
local lvItems={};--等级描述物体
local suitItems={};--套装物体
local allSuit=nil;--套装配置信息

--初始化特性详解面板
function OnOpen()
    --显示所有特性
    allSuit={};
    for _, cfg in pairs(Cfgs.CfgSuit:GetAll()) do
        if cfg.show == 1 then
            table.insert(allSuit, cfg);
        end
    end
    Refresh();
end

function Refresh()
    --生成所有套装列表
    RefreshSuitItems();
end

function RefreshSuitItems()
    ItemUtil.AddItems("RoleEquip/EquipSkillFullItem",suitItems,allSuit,Content,OnClickDetails,1,{sSKId=selectSKId});
end

--点击查看描述
function OnClickDetails(lua)
    local id=lua.data and lua.data.id or nil;
    if id==selectSKId then
        selectSKId=nil
    else
        selectSKId=id;
    end
    if selectSKId then
    --显示技能描述
        ShowChild({group=selectSKId,lv=data.skillPoints[selectSKId]});
        -- CSAPI.OpenView("RoleEquipSkillDesc",{group=currId,lv=data.skillPoints[currId]});
        RefreshSuitItems();
    else
        if skillDesc and child.activeSelf==true then
            RefreshSuitItems();
            CSAPI.SetGOActive(child,false);
        end
    end
end

function ShowChild(_d)
    if skillDesc==nil then
        ResUtil:CreateUIGOAsync("RoleEquip/RoleEquipSkillDesc",child,function(go)
            skillDesc=ComUtil.GetLuaTable(go)
            skillDesc.SetData(_d);
        end);
    else
        CSAPI.SetGOActive(child,true);
        skillDesc.SetData(_d);
    end
end

function OnClickAnyway()
    if skillDesc and child.activeSelf==true then
        selectSKId=nil;
        RefreshSuitItems();
        CSAPI.SetGOActive(child,false);
    else
        view:Close();
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
childNode=nil;
view=nil;
end
----#End#----