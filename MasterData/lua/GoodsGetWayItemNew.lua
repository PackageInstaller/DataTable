
local state=JumpModuleState.Normal;
local data=nil;
local isDisable=false;
local canSweep=false;
local jumpCfg=nil;
local textMove=nil;
function Awake()
    textMove=ComUtil.GetCom(text,"TextMove");
end

function Refresh(_data,_isDisable)
    data=_data;
    isDisable=_isDisable
    canSweep=false;
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
        jumpCfg=Cfgs.CfgJump:GetByID(data.jumpId)
        local txt="";
        local imgName="btn_1_01.png";
        local txtColor={255,255,255,255};
        if jumpCfg then
            txt=txt..jumpCfg.desc;
            -- CSAPI.SetText(name,jumpCfg.desc);
                --判定是否是关卡界面，关卡界面需要判定可以扫荡
            if jumpCfg.Sweep and jumpCfg.Sweep==1 and jumpCfg.val3 then
                local sweepData = SweepMgr:GetData(jumpCfg.val3)
                canSweep = sweepData and sweepData:IsOpen() or false
                if canSweep then
                    imgName="btn_1_02.png";
                    txtColor={0,0,0,255};
                end
            end
        end
        CSAPI.LoadImg(jumpImg,"UIs/GetWayItem/"..imgName,false,nil,true);
        CSAPI.SetTextColor(txt_state,txtColor[1],txtColor[2],txtColor[3],txtColor[4]);
        if data.outTips then 
            txt=txt.."    "..data.outTips;
        end
        if not IsNil(textMove) then
            textMove:SetText(txt);
        end
        -- CSAPI.SetText(tipsContent,txt);
        CSAPI.SetText(txt_state,LanguageMgr:GetByID(canSweep and 42001 or 1034));
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
        if canSweep and jumpCfg and jumpCfg.val3 then
            UIUtil:OpenSweepView(jumpCfg.val3)
            do return end;
        end
        if this.jumpCall then
            this.jumpCall(data);
        end
        FuncUtil:Call(function()
            JumpMgr:Jump(data.jumpId);
        end,nil,100)    
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