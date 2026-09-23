--队伍人物信息格子
local sliderBar=nil;
local hpSlider=nil;
local clickFunc=nil;
local clickImg=nil;
local starList=nil;
function Awake()    
    sliderBar=ComUtil.GetCom(sliderObj,"Slider");
    hpSlider=ComUtil.GetCom(hp,"Slider");
    clickImg=ComUtil.GetCom(clickObj,"Image");
    CSAPI.SetText(lvdesc,LanguageMgr:GetTips(1009));
    starList=ComUtil.GetComsInChildren(stars,"Image");
    InitNull();
end

function OnDestroy()
    this.sourceData=nil;
    sliderBar=nil;
end

--data:CharacterCardsData
function InitData(data,isClick)
    InitNull();
    if  data==nil then
       do return end
    end
    this.sourceData=data;
    --初始化格子
    SetIcon(data:GetSmallImg());
    SetLv(data:GetLv());
    SetStar(data:GetBreakLevel());
    local hot=data:GetCurDataByKey("hot");
    SetSlider(data:GetHot()/hot);  
    SetClick(isClick);
end
  
--设置为空
function InitNull()
    SetIcon();
    CSAPI.SetGOActive(lvObj,false);
    SetStar();
    SetSlider();
    SetCooling();
    SetName();
    SetNum();
    SetHP();
    SetClickBg();
    SetDamage();
    SetDisable();
    CSAPI.SetGOActive(sliderObj,false);
    this.sourceData=nil;
end

function SetDamage(isDamage)
    isDamage=isDamage==true and true or false;
    CSAPI.SetGOActive(mask,isDamage);
    CSAPI.SetGOActive(damage,isDamage);
end

function SetCooling(isCooling)
    isCooling=isCooling==true and true or false;
    CSAPI.SetGOActive(mask,isCooling);
    CSAPI.SetGOActive(cool,isCooling);
end

function SetIcon(iconName)
    CSAPI.SetGOActive(icon,iconName ~= nil);
    local bgName="UIs/Common/profile_picture_plus.png";
    if(iconName)then
        ResUtil.RoleCard:Load(icon,iconName );
        bgName= "UIs/Common/profile_picture_black.png";
    end
    CSAPI.LoadImg(border,bgName,true,nil,true);
end

function SetHP(val)
    CSAPI.SetGOActive(hp,val~=nil);
    if val then
        hpSlider.value=val;
    end
end

function SetName(name,type)
    CSAPI.SetGOActive(text_name,name~=nil);
    if name then
        CSAPI.SetText(text_name,name);
        if type==nil or type ==1 then
            CSAPI.SetAnchor(text_name,55,-125);
        elseif type==2 then
            CSAPI.SetAnchor(text_name,55,-145);
        elseif type==3 then
            CSAPI.SetAnchor(text_name,55,-150);
        end
    end
end

function SetNum(num,type)
    CSAPI.SetGOActive(text_num,num~=nil);
    if num then
        CSAPI.SetText(text_num,tostring(num));
        if type==nil or type ==1 then
            CSAPI.SetAnchor(text_num,55,-125);
        elseif type==2 then
            CSAPI.SetAnchor(text_num,55,-145);
        elseif type==3 then
            CSAPI.SetAnchor(text_num,55,-150);
        end
    end
end

--根据下标设置Name和Num
function SetTeamTips(index,type)
    if index==1 then
        SetName(LanguageMgr:GetTips(14029),type);
        SetNum();
    elseif index==6 then
        SetName(LanguageMgr:GetTips(14030),type);
        SetNum();
    else
        SetName();
        SetNum(index,type);
    end
end

function SetLv(val)
    CSAPI.SetGOActive(lvObj,val ~= nil);
    val=val or "0";
    CSAPI.SetText(lv,tostring(val));
end

function SetSlider(percent)
    CSAPI.SetGOActive(sliderObj,percent~=nil);
    percent=percent or 0;
    -- print(percent);
    sliderBar.value=percent;
end

function SetDisable(isDisable)
    isDisable=isDisable==true;
    local bgName="UIs/Common/profile_picture_plus.png";
    if isDisable then
       bgName= "UIs/Common/profile_picture_none.png"; 
    end
    CSAPI.LoadImg(border,bgName,true,nil,true);
end

function SetStar(val)
    val=val or 0;
	if starList then
		for i=0,starList.Length-1 do
			CSAPI.SetGOActive(starList[i].gameObject,i<val);
		end
	end
end

function SetClick(enable)
    enable=enable==nil and true or enable;
    if clickImg then
        clickImg.raycastTarget=enable;
    end
end

function AddClick(func)
    clickFunc=func;
end

--点击格子
function OnClickThis()
    if clickFunc then
        clickFunc(this);
    end
end

function SetData(data)
    this.sourceData=data;
end

function SetClickBg(isShow)
    isShow=isShow==true and true or false;
    CSAPI.SetGOActive(img,isShow);
end