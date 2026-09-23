--mini装备槽
local slotImgs=nil;

function Awake()
    slotImgs=ComUtil.GetComsInChildren(slot,"Image");
end

function InitNull()
    CSAPI.SetGOActive(nullObj,true)
    SetQuality(1)
    CSAPI.SetGOActive(icon,false)
    CSAPI.SetGOActive(lvObj,false)
end

function Refresh(equip)
    if equip==nil then
        InitNull();
    else
        CSAPI.SetGOActive(nullObj,false)
        SetQuality(equip:GetQuality());
        SetLv(equip:GetLv());
        SetIcon(equip:GetIcon());
    end
end

function SetSlot(slotType)
    if slotType then
        slotType=slotType;
        for i=0,slotImgs.Length-1 do
            local isActive=false;
            if slotType==EquipSlotType.Center then --中间的全部显示
                isActive=true;
            elseif slotType==EquipSlotType.Right or slotType==EquipSlotType.Bottom then
                isActive=slotType-2==i
            else
                isActive=slotType-1==i
            end
            CSAPI.SetGOActive(slotImgs[i].gameObject,isActive)
        end
    end
end

function SetIcon(iconName)
    CSAPI.SetGOActive(icon,iconName~=nil)
    if iconName then
        ResUtil.EquipSkillIcon:Load(icon,iconName,true);
    end
end

function SetQuality(_quality)
    _quality=_quality or 1;
    ResUtil.EquipSkillIcon:Load(quality,EquipQualityFrame[_quality],false);
end

function SetLv(lv)
    if lv~=nil and lv>0 then
        CSAPI.SetText(txt_lv,tostring(lv))
        CSAPI.SetGOActive(lvObj,true)
    else
        CSAPI.SetGOActive(lvObj,false)
    end
end