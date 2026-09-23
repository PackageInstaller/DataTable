--宠物状态UI
local hp=nil;
local heath=nil;
local hunger=nil;
local hp2=nil;
local heath2=nil;
local hunger2=nil;
local eventMgr=nil;
local selectItem=nil;
local selectNum=0;
function Awake()
    hp=ComUtil.GetCom(hpSlider,"Image");
    heath=ComUtil.GetCom(heathSlider,"Image");
    hunger=ComUtil.GetCom(hungerSlider,"Image");
    hp2=ComUtil.GetCom(hpSlider2,"Image");
    heath2=ComUtil.GetCom(heathSlider2,"Image");
    hunger2=ComUtil.GetCom(hungerSlider2,"Image");
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.PetActivity_BagSelect_Change, OnSelectChange);
end

function OnDestroy()
    eventMgr:ClearListener();
end

function Refresh()
    local pet=PetActivityMgr:GetCurrPetInfo();
    local _happy=0;
    local _wash=0;
    local _food=0;
    local _happy2,_wash2,_food2=0,0,0;
    if pet then
        _happy=pet:GetHappyPercent();
        _wash=pet:GetWashPercent();
        _food=pet:GetFoodPercent();
        if selectItem~=nil and selectNum>0 then
            _happy2=(selectItem:GetHappyChange()*selectNum)/pet:GetFullHappy();
            _food2=(selectItem:GetFoodChange()*selectNum)/pet:GetFullFood();
            _wash2=(selectItem:GetWashChange()*selectNum)/pet:GetFullWash();
        end
    end
    SetBarPercent(hp,hp2,_happy,_happy+_happy2)
    SetBarPercent(heath,heath2,_wash,_wash+_wash2)
    SetBarPercent(hunger,hunger2,_food,_food+_food2)
    -- LogError(pet:GetHappy().."\t"..pet:GetFood().."\t"..pet:GetWash())
    -- LogError(_happy.."\t".._wash.."\t".._food)
    -- LogError(_happy2.."\t".._wash2.."\t".._food2)
    local hStr=GetStr(_happy,_happy2);
    local wStr=GetStr(_wash,_wash2);
    local fStr=GetStr(_food,_food2);
    CSAPI.SetText(txtHP,hStr);
    CSAPI.SetText(txtHeath,wStr);
    CSAPI.SetText(txtHunger,fStr);
end

function SetBarPercent(com,com2,val1,val2)
    if com and com2 and val1 and val2 then
        if val1~=0 and val2<val1 and val2~=0 then
            com.fillAmount=val2<val1==true and val2 or val1;
            com2.fillAmount=val2>val1==true and val2 or val1;
        else
            com.fillAmount=val1;
            com2.fillAmount=val2;
        end
    end
end

--eventData={item=宠物物品信息,num=数量}
function OnSelectChange(eventData)
    if eventData and eventData.item then
        selectItem=eventData.item;
        selectNum=eventData.num or 1;
    else
        selectItem=nil;
        selectNum=0;
    end
    -- LogError("OnSelectChange----------------------")
    -- LogError(eventData)
    Refresh();
end

function GetStr(num,num2)
    local n1=num and math.floor(100*num) or 0;
    local n2=num2 and math.floor(100*num2) or 0;
    if n2~=0 then
        local exStr=nil;
        if n1<=0 or (n1+n2)<=1 then
           exStr="<color=\'#ff7781\'>%s</color>";
        end
        local s1=""
        if n2>0  then
            s1=string.format("<color=\'#00eeb0\'>+%s</color>",(n2))
        elseif n2<0 then
            s1=string.format("<color=\'#ff7781\'>%s</color>",(n2))
        end
        local str=string.format("%s(%s)%%",n1,s1);
        if exStr~=nil then
            return string.format(exStr,str);
        else
            return str;
        end
    else
        return n1<=0 and string.format("<color=\'#ff7781\'>%s%%</color>",n1) or tostring(n1).."%"
        -- return "<color=\'#ff7781\'>0%</color>";
    end
end

function OnClickHunger()
   Tips.ShowTips(LanguageMgr:GetTips(42010)) 
end

function OnClickHeath()
    Tips.ShowTips(LanguageMgr:GetTips(42011)) 
end

function OnClickHp()
    Tips.ShowTips(LanguageMgr:GetTips(42012)) 
end