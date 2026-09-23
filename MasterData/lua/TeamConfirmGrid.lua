--战前编队格子
local clicker=nil
local isDisable=false;
local data=nil;
local cb=nil;
local hpBarImg=nil;
local spBarImg=nil;
local needToCheckMove = false
local timer = 0
function Awake()
    clicker=ComUtil.GetCom(clickImg,"Image");
    hpBarImg=ComUtil.GetCom(hpBar, "Image");
    spBarImg=ComUtil.GetCom(spBar, "Image");

    luaTextMove = LuaTextMove.New()
    luaTextMove:Init(txt_name)
end
function Update()
    if (needToCheckMove and Time.time > timer) then
        luaTextMove:CheckMove(txt_name)
        needToCheckMove = false
    end
end
--data: teamItemData:上阵的队员信息
function Refresh(d,index,openSetting)
    InitNull();
    data=d;
    if data then
        CSAPI.SetGOActive(gridNode,true);
        CSAPI.SetGOActive(nilObj,false);
        CSAPI.SetGOActive(disObj,false);
        CSAPI.SetGOActive(node,true);
        SetTagObj();
        SetName(data:GetName());
        if openSetting == TeamOpenSetting.PeriodicBoss and data:GetLv() < PeriodicBossMgr:GetFakeLevel() and index ~= 6 then
            SetLv(PeriodicBossMgr:GetFakeLevel(),"FF0040");        
        else
            SetLv(data:GetLv());
        end
        
        SetIcon(data:GetSmallImg());
        SetQuality(data:GetQuality());
        -- 
        local cardData=data:GetCard()
        RoleTool.SetWeapon(cardData,objWeapon,imgWeapon,txtWeaponLv)
        --
        if openSetting==TeamConfirmOpenType.Tower then
            local cardInfo=nil;
            local strs = StringUtil:split(data:GetID(), "_");
            if strs and #strs>1 and strs[1]~="npc" then
                cardInfo=FormationUtil.GetTowerCardInfo(tonumber(strs[2]),tonumber(strs[1]),TeamMgr.currentIndex);
            else
                cardInfo=FormationUtil.GetTowerCardInfo(data:GetID(),nil,TeamMgr.currentIndex);
            end
            local currHp,currSp=1,1;
            if cardInfo then
                currHp=cardInfo.tower_hp/100;
                currSp=cardInfo.tower_sp/100;
            end
            SetCardInfos(currHp,currSp);
        end
        -- SetAssist(data:IsAssist())
    -- elseif index==6 then
    --     SetAssist(true)
    end
    if index==6 then
        SetAssist(not isDisable)
    end
end

function SetName(name)
    needToCheckMove = false
    CSAPI.SetText(txt_name,name or "");
    timer = Time.time + 0.1
    needToCheckMove = true
end

-- function SetIndex(index)
--     CSAPI.LoadImg(indexImg,"UIs/TeamConfirm/img_9_0"..tostring(index)..".png",true,nil,true);
-- end

function SetLv(lv,code)
    CSAPI.SetText(txt_lv,tostring(lv) or "")
    code = code or "ffffff"
    CSAPI.SetTextColorByCode(txt_lv,code)
end

function SetIcon(iconName)
    if iconName then
        CSAPI.SetGOActive(icon,true);
        ResUtil.Card:Load(icon,iconName);
    else
        CSAPI.SetGOActive(icon,false);
    end
end

function SetCardInfos(hp,sp)
    if hp and sp then
        CSAPI.SetGOActive(infoObj,true);
        hpBarImg.fillAmount=hp;
        spBarImg.fillAmount=sp;
    else
        CSAPI.SetGOActive(infoObj,false);
    end
end

function SetQuality(_quality)
    local q1=_quality or 3
    local q2=_quality or 1;
    local name= "btn_1_0"..tostring(q1);
    local bName="btn_b_1_0"..tostring(q2)
    ResUtil.CardBorder:Load(tagObj,name);
    ResUtil.CardBorder:Load(border,bName);
end

function SetAssist(isShow)
    CSAPI.SetGOActive(txt_assist,isShow)
    CSAPI.SetGOActive(assistObj,isShow);
    local isLimitAssist = false
    if data~=nil then
        isLimitAssist=FormationUtil.CheckAssitCardIsLimit(data)
    end
    local iconName=isLimitAssist and "img_02_04" or "img_02_02"
    CSAPI.LoadImg(assistIcon,string.format("UIs/TeamConfirm/%s.png",iconName),true,nil,true);
end

function SetTagObj()
    if data then     
		CSAPI.SetGOActive(tagObj,true);
		if data:IsNPC() then
			CSAPI.SetText(txt_tag,LanguageMgr:GetByID(26005));
            CSAPI.SetGOActive(txt_tag,true)
		elseif data:IsLeader() then
			CSAPI.SetText(txt_tag,LanguageMgr:GetByID(26007));
            CSAPI.SetGOActive(txt_tag,true)
		else
			CSAPI.SetGOActive(txt_tag,false)
		end
	else
		CSAPI.SetGOActive(tagObj,false);
	end
end

function SetPos(pos)
    CSAPI.SetAnchor(gameObject,pos[1],pos[2]);
end

function OnClickSelf()
    if cb then
        cb(this);
    end
end

function SetClick(canClick)
    clicker.raycastTarget=canClick;
    local imgName=canClick==true and "btn_3_04" or "btn_1_061"
    ResUtil.CardBorder:Load(nilObj,imgName);
end

--设置禁用
function SetDisable(_isDisable)
    isDisable=_isDisable;
    InitNull();
end

function InitNull()
    data=nil;
    SetQuality();
    CSAPI.SetGOActive(nilObj,not isDisable);
    CSAPI.SetGOActive(disObj,isDisable);
    CSAPI.SetGOActive(node,false);
    CSAPI.SetGOActive(disObj,isDisable);
    SetCardInfos();
    SetClick(not isDisable);
end

function SetCB(_cb)
    cb=_cb
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
border=nil;
nilObj=nil;
disObj=nil;
node=nil;
icon=nil;
txt_lvTips=nil;
txt_lv=nil;
txt_name=nil;
tagObj=nil;
txt_tag=nil;
txt_hot=nil;
txt_tips=nil;
tipsIcon=nil;
clickImg=nil;
view=nil;
end
----#End#----