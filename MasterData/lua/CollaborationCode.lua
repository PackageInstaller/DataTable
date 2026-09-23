--回归绑定验证码阶段
local inp=nil;
function Awake()
    inp=ComUtil.GetCom(inpInvitation,"InputField")
    CSAPI.AddInputFieldChange(inpInvitation,OnCodeChange)
end

function OnDestroy()
    CSAPI.RemoveInputFieldChange(inpInvitation,OnCodeChange)
end

function OnCodeChange(str)
    local _str="";
    for s in string.gmatch(str,"[%d_]") do
        _str=_str..s;
    end
    inp.text=_str;

end

function OnClickOK()
    local code=inp.text;
    local activityData=CollaborationMgr:GetCurrInfo();
    if activityData==nil then
        do return end
    end
    if activityData:CheckCodeFormat(code)~=true then
        --邀请码格式错误
        inp.text="";
        Tips.ShowTips(LanguageMgr:GetTips(40005));
    else
        --检查格式是否正确
        if string.match(code,"%d+_%d+")~=nil then
            RegressionProto:PlrBindInvite(code,nil);
            Close();
        else
            inp.text="";
            --邀请码格式错误
            Tips.ShowTips(LanguageMgr:GetTips(40001));
        end 
    end
end

function OnClickCancel()
    Close();
end

function Close()
    if IsNil(gameObject) or IsNil(view) then
        do return end
    end
    view:Close();
end