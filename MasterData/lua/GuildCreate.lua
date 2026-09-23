--创建工会界面
local lv=1;
local desc="";
local inpName;
local inpDesc;
local inpLv;
local iconId=nil;
local typeToggle;
local joinToggle;
local moneyId=nil;
local moneyNum=0;
local eventMgr=nil;
function Awake()
    UIUtil:AddTop2("GuildCreate", gameObject, OnClickReturn)
    --UIUtil:AddTop(gameObject, OnClickReturn)
    inpName=ComUtil.GetCom(inp_name,"InputField");
    inpDesc=ComUtil.GetCom(inp_desc,"InputField");
    inpLv=ComUtil.GetCom(inp_lv,"InputField");
    typeToggle=ComUtil.GetCom(typeToggle1,"Toggle");
    joinToggle=ComUtil.GetCom(joinToggle1,"Toggle");
    CSAPI.AddInputFieldChange(inp_lv,OnLvChange);
    CSAPI.AddInputFieldChange(inp_desc,OnDescChange);
    CSAPI.AddInputFieldChange(inp_name,OnNameChange);
    CSAPI.AddInputFieldCallBack(inp_name,OnNameEnd);
    CSAPI.AddInputFieldCallBack(inp_desc,OnDescEnd);
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Guild_Icon_Change, OnIconChange);
end

function OnDestroy()
    CSAPI.RemoveInputFieldChange(inp_name,OnNameChange);
    CSAPI.RemoveInputFieldChange(inp_desc,OnDescChange);
    CSAPI.RemoveInputFieldChange(inp_lv,OnLvChange);
    CSAPI.RemoveInputFieldCallBack(inp_name,OnNameEnd);
    CSAPI.RemoveInputFieldCallBack(inp_desc,OnDescEnd);
    eventMgr:ClearListener();
    ReleaseCSComRefs();
end

function OnOpen() --显示创建的价格
    moneyId=g_GuildCreateCost[1][1];
    moneyNum=g_GuildCreateCost[1][2];
    if moneyId == ITEM_ID.GOLD then --钻石
		ResUtil.IconGoods:Load(moneyIcon, tostring(ITEM_ID.GOLD));
	elseif moneyId == ITEM_ID.DIAMOND then --金币
		ResUtil.IconGoods:Load(moneyIcon, tostring(ITEM_ID.DIAMOND));
	elseif moneyId== -1 then --人民币
		CSAPI.LoadImg(moneyIcon,"UIs/Shop/yuan.png",true,nil,true)
	else
		local cfg = Cfgs.ItemInfo:GetByID(moneyId);
		if cfg and cfg.icon then
			ResUtil.IconGoods:Load(moneyIcon, cfg.icon);
		end
    end
    OnIconChange(g_GuildInitIconId);
    CSAPI.SetRectSize(moneyIcon, 40, 40);
    CSAPI.SetScale(moneyIcon,1,1,1);
	CSAPI.SetText(txt_money, "X"..tostring(moneyNum));
end

-----------------------------Root1的逻辑-------------------------

function OnNameChange(text)
    local name=StringUtil:FilterChar2(text);
    inpName.text=name;
end

--名字输入完毕时
function OnNameEnd(text)
    if MsgParser:CheckContain(text) then
        Tips.ShowTips(StringTips.common4)
        inpName.text="";
    end
end


function OnLvChange(text)   
    if text==nil or text=="" then
        lv=1;
        inpLv.text=tostring(lv);
        return
    end
    lv=tonumber(text);
    if lv>g_PlayerLvMax then
        lv=g_PlayerLvMax;
        inpLv.text=tostring(lv);
    elseif lv<=0 then
        lv=1;
        inpLv.text=tostring(lv);
    end
end

function OnClickLevel(go)
    local add=go==btnAdd and 1 or -1;
    lv=lv+add;
    if lv>g_PlayerLvMax then
        lv=g_PlayerLvMax;
    elseif lv<0 then
        lv=1;
    end
    inpLv.text=tostring(lv);
end

function OnDescChange(text)
    if GLogicCheck:GetStringLen(text)>100 then
        desc=StringUtil:SetStringByLen(text, 100, "");
        inpDesc.text=desc;
    end
end

function OnDescEnd(text)
    if MsgParser:CheckContain(text) then --不得含有屏蔽词
        Tips.ShowTips(LanguageMgr:GetTips(9003))
        inpDesc.text="";
    end
end

function OnClickCreate()
    local name=inpName.text
    if name==nil or name=="" then
        Tips.ShowTips(LanguageMgr:GetTips(17000));
        return;
    end
    if iconId==nil or iconId=="" then
        Tips.ShowTips(LanguageMgr:GetTips(17001));
        return;
    end
    local info={
        name=name, 
        icon=iconId,
        activity_type=typeToggle.isOn and GuildActivityType.Lazy or GuildActivityType.Active,
        apply_lv=lv,
        ratify_type=joinToggle.isOn and GuildRatifyType.Auto or GuildRatifyType.Apply,
        desc=inpDesc.text or "",
    };
    --判断货币是否足够
    local count=BagMgr:GetCount(moneyId);
    if moneyNum<=count then
        GuildProto:Create(info);
    else
        local goods=GoodsData();
        goods:InitCfg(moneyId);
		Tips.ShowTips(string.format(LanguageMgr:GetTips(15005),goods:GetName()));
    end
end

function OnClickJoin()
    CSAPI.OpenView("GuildSearch",nil,nil,function()
        Close();
    end);
end

function Close()
    view:Close();
end

function OnClickReturn()
    Close();
end

function OnClickIcon()
    CSAPI.OpenView("GuildIcon",{iconID=iconId});
end

function OnIconChange(id)
    iconId=id;
    if id then
        local cfg=Cfgs.character:GetByID(id)
        if cfg then
            ResUtil.RoleCard:Load(icon, cfg.icon)
        else
            CSAPI.SetRectSize(icon,0,0,0);
        end
    end
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
bg=nil;
root=nil;
btn_join=nil;
inp_name=nil;
txt_tips=nil;
iconObj=nil;
icon=nil;
typeToggle1=nil;
typeToggle2=nil;
inp_lv=nil;
btnAdd=nil;
btnRemove=nil;
joinToggle1=nil;
joinToggle2=nil;
inp_desc=nil;
btn_create=nil;
moneyIcon=nil;
txt_money=nil;
view=nil;
end
----#End#----