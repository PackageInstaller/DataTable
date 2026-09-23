--技能等级
local lvItems={};--等级描述物体
local scrollRect=nil;
function Awake()
    scrollRect=ComUtil.GetCom(sr,"ScrollRect");
end

--初始化特性详解面板
function SetData(_data)
    data=_data;
    --显示所有特性
    scrollRect.normalizedPosition=UnityEngine.Vector2(1,1);
    Refresh();
end

function Refresh()
    --生成所有套装列表
    local list = {};
    local cfgs=Cfgs.CfgEquipSkill:GetGroup(data.group)
    if cfgs then
        for _, cfg in ipairs(cfgs) do
            local isLight=data.lv and cfg.nLv<=data.lv or false;
            table.insert(list, {cfg=cfg,isLight=isLight});
        end
        CSAPI.SetText(txt_title,cfgs[1].sName);
    end
    ItemUtil.AddItems("RoleEquip/EquipSkillDescItem",lvItems,list,Content);
end

function OnClickAnyway()
    view:Close();
end