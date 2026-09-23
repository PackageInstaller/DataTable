--套装描述
local items={};
local width=702;
local height=192;
local lineHeight=33;
local offset=30;
local lineNum=0;
local currHeight=202;
local fontNum=17
local layout1=nil;
local selectIndex=nil;
local tween=nil;
function Awake()
    tween=ComUtil.GetCom(layout,"ActionFadeCurve");
end

function OnDestroy()
    ReleaseCSComRefs();
end

function Refresh(_data,_elseData)
    this.data=_data;
    ResUtil.EquipSkillIcon:Load(icon,this.data.cfg.icon);
    CSAPI.SetText(txt_name,this.data.cfg.name);
    CSAPI.SetText(txt_num,tostring(#this.data));
    CSAPI.SetText(txt_desc,this.data.cfg.dec);
    if tween then
        this.index=this.index or 1;
        tween.delay=(this.index-1)*60;
        tween:Play();
    end
end


function SetIndex(i)
    this.index=i;
end

function GetIndex()
    return this.index;
end

function SetClickCB(cb)
    this.clickCB=cb;
end

--点击了套装
function OnClickItem()
    EventMgr.Dispatch(EventType.Equip_Suit_Click,this);
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
sBg=nil;
txt_name=nil;
grids=nil;
view=nil;
end
----#End#----