
function Awake()
    hpSlider=ComUtil.GetCom(slider1,"Slider");
    hotSlider=ComUtil.GetCom(slider2,"Slider");
    if grid==nil then
        local go=ResUtil:CreateUIGO("RoleCard/RoleLittleCard",girdNode.transform);
        grid=ComUtil.GetLuaTable(go);
        CSAPI.SetGOActive(go,true);
    end 
end

function Refresh(cardData,elseData)
    grid.Refresh(cardData);
    CSAPI.SetGOActive(sliders,cardData~=nil);
    grid.ActiveClick(cardData~=nil);
    if cardData==nil then
        SetDeath(false)
    end
end

function SetClick(isClick)
    if grid then
        grid.ActiveClick(isClick);
    end
end

function SetHP(percent)
    if percent then
        hpSlider.value=percent;
    end
end

function SetHot(percent)
    if percent then
        hotSlider.value=percent;
    end
end

function SetIndex(num)
    CSAPI.SetGOActive(txt_index,num~=nil);
    if num then
        CSAPI.SetText(txt_index,tostring(num));
        local isShow=num<6;
        CSAPI.SetGOActive(slider2,isShow);
        CSAPI.SetGOActive(hot,isShow);
        CSAPI.SetGOActive(supprotImg,not isShow);
    end
end

function SetClickCB(_cb)
    if grid then
        grid.SetClickCB(_cb);
    end
end

function SetDeath(isDeath)
    CSAPI.SetGOActive(deathGO,isDeath);
    if grid then
        grid.SetGray(isDeath);
    end
end