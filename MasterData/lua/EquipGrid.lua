--装备槽（装备系统）
local slotImgs=nil;
local data=nil
local elseData=nil;
local slotType=-1;--当前格子的芯片位置
function Awake()
    slotImgs=ComUtil.GetComsInChildren(slot,"Image");
end

function InitNull()
    CSAPI.SetGOActive(img1,true)
    SetIcon();
    SetQuality(1);
    SetSelect();
    SetLv();
    SetLock();
    SetSlotColor(1);
end

--刷新界面 data=equip:装备数据,elseData={isFight:卡牌是否在战斗中,scale,isShowBtn:是否显示卸载按钮,selectSlot=当前选择的位置}
function Refresh(_data,_elseData)
    data=_data;
    elseData=_elseData;
    if data==nil then
        InitNull();
    else
        CSAPI.SetGOActive(img1,false)
        SetQuality(data:GetQuality());
        SetLv(data:GetLv());
        SetIcon(data:GetIcon());
        SetLock(data:IsLock())
        SetSlotColor(data:GetQuality());
    end
    if elseData then
        local isSelect=slotType==_elseData.selectSlot;
        SetSelect(isSelect);
    end
end

function SetScale(scale)
    CSAPI.SetScale(node,scale,scale,scale)
end

--设置当前格子的位置属性，放在Refresh前调用
function SetSlot(_slotType)
    if _slotType then
        slotType=_slotType;
        SetArrow(_slotType)
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

function SetArrow(_slotType)
    local anchor={0,0}
    local imgName="UIs/RoleEquip/btn_27_01.png"
    local angle={0,0,0}
    if _slotType then
        if slotType==EquipSlotType.Center then --中间的全部显示
            imgName="UIs/RoleEquip/btn_27_02.png"
        elseif slotType==EquipSlotType.Left then
            anchor={-29,0}
            angle={0,0,0}
        elseif slotType==EquipSlotType.Right then
            anchor={29,0}
            angle={0,180,0}
        elseif slotType==EquipSlotType.Bottom then
            anchor={0,-29}
            angle={0,0,90}
        elseif slotType==EquipSlotType.Top then
            anchor={0,29}
            angle={0,0,-90}
        end
    end
    CSAPI.LoadImg(arrow,imgName,true,nil,true)
    CSAPI.SetAnchor(arrow,anchor[1],anchor[2])
    CSAPI.SetAngle(arrow,angle[1],angle[2],angle[3])
end

function SetSlotColor(_quality)
    if _quality then
        --设置位置图片的颜色
        CSAPI.SetImgColorByCode(slot,EquipQualityColor[_quality],true);
    else
        CSAPI.SetImgColorByCode(slot,EquipQualityColor[1],true);
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
    ResUtil.EquipSkillIcon:Load(node,EquipQualityFrame[_quality],false);
end

function SetSelect(_isSelect)
    CSAPI.SetGOActive(select,_isSelect==true)
end


--卸载装备
function OnClickUnload()
    if data and data then
        EquipProto:EquipDown({data:GetID()}); 
    end
end

function SetLock(isLock)
    CSAPI.SetGOActive(lockObj,isLock==true)
end

function SetLv(lv)
    if lv~=nil and lv>0 then
        CSAPI.SetText(txt_lv,"+"..tostring(lv))
        CSAPI.SetGOActive(lvObj,true)
    else
        CSAPI.SetGOActive(lvObj,false)
    end
end

function OnClick()
    if data and data.isFight==true then
        return;
    end
    EventMgr.Dispatch(EventType.EquipCore_Slot_Change,{slot=slotType,equip=data,hasEquip=data~=nil});
end