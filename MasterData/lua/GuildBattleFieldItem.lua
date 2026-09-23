local elseData=nil
local data=nil
local cfg=nil
local sliderBar=nil;
local isRun=false;
function Awake()
    sliderBar=ComUtil.GetCom(hpBar,"Image");
end

function Refresh(d,_elseData)
    data=d;
    elseData=_elseData;
    isRun=false;
    if data then
        CSAPI.SetText(txt_hard,data:GetDiffStr());
        CSAPI.SetText(txt_bossLv,string.format(LanguageMgr:GetTips(1009),data:GetLv()));
        CSAPI.SetText(txt_fightVal,tostring(data:GetFightVal()));
    end
    if elseData and elseData.fieldType==2 then
        --支援战场
        if data:GetRoomType()==GFRoomType.MultiPlr then
            CSAPI.SetGOActive(singleObj,false);
            CSAPI.SetGOActive(multObj,true);
        else
            CSAPI.SetGOActive(singleObj,true);
            CSAPI.SetGOActive(multObj,false);
        end
        CSAPI.SetGOActive(lockObj,false);
        CSAPI.SetGOActive(type1,false);
        CSAPI.SetGOActive(other,true);
        sliderBar.fillAmount=data:GetCurrHP()/data:GetHP();
        CSAPI.SetText(txt_hp,data:GetCurrHP().."/"..data:GetHP());
        CSAPI.SetText(txt_user,data:GetCreaterName());
        CSAPI.SetText(txt_timeVal,"00:00:00");
        isRun=data:IsOpen();
    else
        --开启战场
        CSAPI.SetGOActive(type1,true);
        CSAPI.SetGOActive(other,false);
        CSAPI.SetGOActive(lockObj,_elseData.isCreate);--正在攻略中的不能重复创建
        CSAPI.SetGOActive(multObj,data:MultJoin());
        CSAPI.SetGOActive(singleObj,data:SingleJoin());
        local costCfg=data:GetCreateCost();
        if costCfg then
            if costCfg[1] == ITEM_ID.GOLD then --钻石
                ResUtil.IconGoods:Load(priceIcon, tostring(ITEM_ID.GOLD));
            elseif costCfg[1] == ITEM_ID.DIAMOND then --金币
                ResUtil.IconGoods:Load(priceIcon, tostring(ITEM_ID.DIAMOND));
            elseif costCfg[1]== -1 then --人民币
                CSAPI.LoadImg(priceIcon,"UIs/Shop/yuan.png",true,nil,true)
            else
                local cfg = Cfgs.ItemInfo:GetByID(costCfg[1]);
                if cfg and cfg.icon then
                    ResUtil.IconGoods:Load(priceIcon, cfg.icon);
                end
            end
            CSAPI.SetRectSize(priceIcon, 25, 25);
            CSAPI.SetText(txt_price,tostring(costCfg[2]));
        end
    end
end

function Update()
    if isRun and data then
        local timer=data:GetEndTime()-CSAPI.GetServerTime();
        if timer>0 then
            CSAPI.SetText(txt_timeVal,TimeUtil:GetTimeHMS(timer,"%H:%M:%S"));
        else
            isRun=false;
            CSAPI.SetText(txt_timeVal,"00:00:00");
        end
    end
end

function SetClickCB(_cb)

end

--开启战场
function OnClickOpen()
    CSAPI.OpenView("GuildFieldConfirm",data);
end

--参战/进入编队界面
function OnClickJoin()
    if data then
        -- GuildProto:GFJoinRoom(data:GetID(),data:GetIndex());
        CSAPI.OpenView("GuildFightTeamEdit",data);
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
hardObj=nil;
txt_hard=nil;
singleObj=nil;
txt_single=nil;
multObj=nil;
txt_mult=nil;
txt_bossLv=nil;
txt_fightVal=nil;
type1=nil;
priceObj=nil;
priceIcon=nil;
txt_price=nil;
other=nil;
txt_timeVal=nil;
txt_user=nil;
hpBar=nil;
txt_hp=nil;
lockObj=nil;
txt_lock=nil;
view=nil;
end
----#End#----