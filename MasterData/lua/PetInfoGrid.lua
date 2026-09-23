--宠物信息格子
local cb=nil;
local index=nil;
function Refresh(_d,_isRed)
    this.data =_d
    if _d then
        CSAPI.SetText(txtNO,_d:GetNONumb());
        CSAPI.SetText(txtName,_d:GetName());
        if _d:IsLock() then
            SetLock();
        else
            CSAPI.SetGOActive(questionIcon,false)
            local cPet=PetActivityMgr:GetCurrPetInfo();
            if cPet then
                CSAPI.SetGOActive(hasObj,_d:GetID()==cPet:GetID())
                PetActivityMgr:AddUnLockPetList(_d:GetID());
                CSAPI.SetGOActive(redObj,false);
            else
                CSAPI.SetGOActive(hasObj,false)
                CSAPI.SetGOActive(redObj,_isRed);
            end
            --读取图标
            -- CSAPI.LoadImg(icon,"UIs/Pet/img_04_23.png",true,nil,true);
            ResUtil.PetIcon:Load(icon,_d:GetIcon());
        end
    end
end

function SetLock()
    CSAPI.SetGOActive(questionIcon,true)
    CSAPI.SetGOActive(hasObj,false)
    CSAPI.SetGOActive(redObj,false);
    CSAPI.LoadImg(icon,"UIs/Pet/img_04_24.png",true,nil,true);
end

function SetClickCB(_cb)
    cb=_cb
end

function OnClick()
    if cb then
        cb(this);
    end
end

function SetIndex(i)
    index=i;
end

function GetIndex()
    return index;
end