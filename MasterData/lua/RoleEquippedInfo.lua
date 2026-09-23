local layout=nil;
function Awake()
    layout=ComUtil.GetCom(sv,"UISV");
    layout:Init("UIs/EquipInfo/EquipSkillAttribute2",LayoutCallBack,true);
end

function OnOpen()
    if data then
        local skills=data:GetEquipSkillPoint();
        if skills then --读取装备技能信息
            skillArr={};
            for k,v in ipairs(skills.eskills) do
                local skillCfg = Cfgs.CfgEquipSkill:GetByID(v);
                if skillCfg then
                    table.insert(skillArr, skillCfg);
                end
            end
            if skillArr then
                table.sort(skillArr,function(a,b)
                    if a.nQuality~=b.nQuality then
                        return a.nQuality>b.nQuality
                    elseif a.nLv~=b.nLv then
                        return a.nLv>b.nLv;
                    else
                        return a.group>b.group;
                    end
                end)
            end
        end
        curDatas=skillArr or {};
        Log(curDatas)
        layout:IEShowList(#curDatas)
        CSAPI.SetGOActive(txt_none,#skillArr==0);
    end
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local item=layout:GetItemLua(index);
    item.Refresh(_data);
    item.SetClickCB(OnClickSkillItem);
end

function OnClickSkillItem(cfg)
    -- CloseChildWindow();
    --打开技能描述面板
    CSAPI.OpenView("RoleEquipSkillInfo",cfg);
end

function OnClickReturn()
    view:Close();
end
