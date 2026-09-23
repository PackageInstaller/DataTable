
local state=JumpModuleState.Normal;
local data=nil;
local isDisable=false;
local jumpCfg=nil;
local textMove=nil;
function Awake()
    textMove=ComUtil.GetCom(text,"TextMove");
end

function Refresh(_data,_isDisable)
    data=_data;
    isDisable=_isDisable
    jumpCfg=nil;
    if data then
        state=data.state;
        if state==JumpModuleState.Lock then
            CSAPI.SetGOActive(lockImg,true);
            CSAPI.SetGOActive(jumpImg,false);
            CSAPI.SetGOActive(txt_state,false)
            -- CSAPI.SetGOActive(jumpImg2,false);
            CSAPI.SetGOActive(btn_jump,true);
        elseif state==JumpModuleState.Close or isDisable then
            -- CSAPI.SetGOActive(lockImg,false);
            -- CSAPI.SetGOActive(jumpImg,true);
            -- CSAPI.SetGOActive(jumpImg2,true);
            CSAPI.SetGOActive(btn_jump,false);
        else
            CSAPI.SetGOActive(lockImg,false);
            CSAPI.SetGOActive(jumpImg,true);
            CSAPI.SetGOActive(txt_state,true)
            CSAPI.SetGOActive(btn_jump,true);
        end
        local txt=data.outTips or "";
        local imgName="btn_1_01.png";
        local txtColor={255,255,255,255};
        CSAPI.LoadImg(jumpImg,"UIs/GetWayItem/"..imgName,false,nil,true);
        CSAPI.SetTextColor(txt_state,txtColor[1],txtColor[2],txtColor[3],txtColor[4]);
        -- CSAPI.SetText(tipsContent,txt);
        if not IsNil(textMove) then
            textMove:SetText(txt);
        end
        CSAPI.SetText(txt_state,LanguageMgr:GetByID(1034));
    end
end

function SetJumpCall(call)
    this.jumpCall=call;
end

function OnClickJump()
    if isDisable then
        return
    end
    if state==JumpModuleState.Normal then
        if this.jumpCall then
            this.jumpCall(data);
        end
    else
        Tips.ShowTips(data.lockStr);
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
layout=nil;
tipsContent=nil;
btn_jump=nil;
jumpImg=nil;
jumpImg2=nil;
lockImg=nil;
view=nil;
end
----#End#----