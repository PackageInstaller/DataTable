--防沉迷面板
local idInput=nil;
local nameInput=nil;
local wi = { 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1 }; 
local vi= { '1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2' }; 
function Awake()
    nameInput=ComUtil.GetCom(inp_realName,"InputField");
    idInput=ComUtil.GetCom(inp_ID,"InputField");
    eventMgr = ViewEvent.New();
    
    eventMgr:AddListener(EventType.Authentication_Result, OnValidResult)
    eventMgr:AddListener(EventType.Authentication_Close, OnValidClose)
    BuryingPointMgr:BuryingPoint("before_login", "10020");
end

function OnDestroy()
    eventMgr:ClearListener();
    ReleaseCSComRefs();
end

function OnOpen()
    -- PlayTween(true)
    CSAPI.SetGOActive(gameObject,true);
end

function OnClickBack()--游客登录
    -- PlayTween(false)
    CSAPI.SetGOActive(gameObject,false);
    --发送进入游戏的事件
    if data.call then
        data.call();
    end
end

function OnClickValid()
    local id=idInput.text;
    local name=nameInput.text;
    local valid=true;
    local validNameResult=ValidName(name);
    local validIDResult=ValidID(id);
    CSAPI.SetText(nameTips,"");
    CSAPI.SetText(idTips,"");
    if validNameResult~=nil then
        LanguageMgr:SetText(nameTips,validNameResult);
        valid=false;
    end
    if validIDResult~=nil then
        LanguageMgr:SetText(idTips,validIDResult);
        valid=false;
    end
    if valid==true then
        local proto=LoginProto.vosQueryAccount;
        if LoginProto.account and proto then
             --进行验证
            local signData={
                account=LoginProto.account,
                uid=tostring(proto.uid),
                name=name,
                number=id,
                server_id=tostring(ChannelWebUtil.GetServerID()),
                channel=tostring(CSAPI.GetChannelType()),
            };  
            ChannelWebUtil.SendToServer2(signData,ChannelWebUtil.Extends.Authen,function(json)
                EventMgr.Dispatch(EventType.Net_Msg_Wait,{msg="user_authen",time=30000,timeOutCallBack=function()
                    --超时，回到登录界面
                    if gameObject~=nil and view~=nil then
                        view:Close();
                    end
                end});
                if json.isOk then
                    --发送协议给服务器
                    -- LogError(json.data);
                    -- LogError(json.data.result.pi)
                    local pi=json.data.result.pi;
                    LoginProto:SetPI(pi);
                    ClientProto:SetAntiAdiction(name,id,pi);
                else
                    EventMgr.Dispatch(EventType.Net_Msg_Getted,"user_authen");
                    CSAPI.OpenView("Prompt", 
                    {
                        content = json.err,
                    });
                end
            end);
        end
    end
end

function OnValidResult(proto)
    EventMgr.Dispatch(EventType.Net_Msg_Getted,"user_authen");
    --验证返回
    if data.call then
        CSAPI.SetGOActive(gameObject,false);
        data.call();
    end
    local content=nil;
    if proto.anti_addiction.accType==AccType.Adult then --成人

    elseif proto.anti_addiction.accType==AccType.Kid then --儿童
        LanguageMgr:ShowTips(9000);
    elseif proto.anti_addiction.accType==AccType.Youth then--青少年
        LanguageMgr:ShowTips(9000);
    elseif proto.anti_addiction.accType==AccType.Guest then--游客
        LanguageMgr:ShowTips(9001);
	end
    --数数SDK
    if CSAPI.IsADV()==false then
        BuryingPointMgr:TrackEvents("name_approve",{number=proto.number});
    end
    BuryingPointMgr:BuryingPoint("before_login", "10021");
    -- PlayTween(false)
end

-- function PlayTween(isShow)
-- 	local pos=isShow==true and {0,27.8,0} or {-1136,27.8,0};
-- 	UIUtil:DoLocalMove(bg,pos,function()
-- 		CSAPI.SetGOActive(childNode,isShow);
--     end);
--     if isShow~=true then
--         view:Close();
--         if data and data.call then
--             data.call();
--         end
--     end
-- end

--验证身份证号码
function ValidID(id)
    local tips=nil;
    if id==nil or id=="" then
        tips=16044;
    else
        --切割字符串，1-2位为省级行政区代码【11，65】，，7-10位为出生年份，11-12位为出生月份，13-14位为出生日期，15-18位偶尔会出现x）
        local isTrue=true;
        local nProvince = tonumber(id:sub(1, 2))
        if string.len(id) ~= 18 then
            
        end
        if nProvince==nil or ( nProvince < 11 or nProvince > 65 ) then --校验省级行政区代码
            isTrue=false;
        end
        --3-4位为地级行政区代码，5-6位为县级行政区代码（不做检查）
        if not IsBirthDate(id:sub(7,14)) then
            isTrue=false;
        end
        
        if not IsAllNumberOrWithXInEnd(id) then --校验结尾的字符段是否格式正确
            isTrue=false;
        end

        if isTrue and not CheckSum(id) then
            isTrue=false;
        end

        if isTrue~=true then
            tips=16043;
        end
    end
    return tips;
end

--校验生日日期
function IsBirthDate(date)
    local year = tonumber(date:sub(1,4))
    local month = tonumber(date:sub(5,6))
    local day = tonumber(date:sub(7,8))
    if year==nil or month==nil or day==nil then
        return false
    end
    if year < 1900 or year > 2100 or month >12 or month < 1 then
        return false
    end
    -- //月份天数表
    local month_days = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    local bLeapYear = (year % 4 == 0 and year % 100 ~= 0) or (year % 400 == 0)
    if bLeapYear  then
        month_days[2] = 29;
    end

    if day > month_days[month] or day < 1 then
        return false
    end
    
    return true
end

--校验结尾的数字
function IsAllNumberOrWithXInEnd( str )
    local ret = str:match("%d+X?") 
    return ret == str 
end

--检查最后一位的验证码
function CheckSum(idcard)
    local nums = {}
    local _idcard = idcard:sub(1,17)
    for ch in _idcard:gmatch"." do
        table.insert(nums,tonumber(ch))
    end
    local sum = 0
    for i,k in ipairs(nums) do
        sum = sum + k * wi[i]
    end
    return vi [sum % 11+1] == idcard:sub(18,18 )
end

--验证名字
function ValidName(name)
    if name==nil or name=="" then
        return 16040;
    else
        --验证名字长度是否超过15个中文字
        local length=GLogicCheck:GetStringLen(name);
        local hasOtherChar=ValidOtherChar(name);
        if hasOtherChar then
            return 16042;
        elseif length>15 then
            return 16041;
        end
    end
end

--验证是否含有数字和特殊符号
function ValidOtherChar(s)
    local k=1;
    while(k<=#s) do
        local c = string.byte(s, k)
        local byteCount=0;
        if c>0 and c<=127 then
            byteCount = 1
        elseif c>=192 and c<=223 then
            byteCount = 2
        elseif c>=224 and c<=239 then
            byteCount = 3
        elseif c>=240 and c<=247 then
            byteCount = 4
        end
        if (c >= 228 and c <= 233) or c==194 then--中文判定，无标点（·除外）
            
        else
            return true
        end
        k=k+byteCount;
    end
    return false;
end

function OnValidClose()
    if gameObject~=nil and view~=nil then
        EventMgr.Dispatch(EventType.Net_Msg_Getted,"user_authen");
        OnClickClose();
    end
end

function OnClickClose()
    NetMgr.net:Disconnect()
    view:Close();
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
bg=nil;
childNode=nil;
inp_ID=nil;
idTips=nil;
inp_realName=nil;
nameTips=nil;
txt_btn=nil;
view=nil;
end
----#End#----