
---海外引导评分
AdvGuiDeScore={}
local this=AdvGuiDeScore;
---3010021001
this.googleecid="";
---3010011001
this.iosecid="";
---抽卡池id   1003 除外
this.poolId=0;
---满足评分
this.satisfyScore=false;
---唯一性Key
this.PlayerPrefsSetIntKey="AdvGuiDeScoreTime"
---上一次 打开弹窗时间
this.LastScoretime=0;
---当前时间
this.currentTime=0;

---设置ecid
function this.Setecid(ecid)
    this.googleecid=ecid;
    this.iosecid=ecid;
end

---数据初始化获取
function this.OnInitData()
    local key=PlayerClient:GetUid()..this.PlayerPrefsSetIntKey;
    this.LastScoretime=PlayerPrefs.GetInt(key);
    if  this.LastScoretime==nil then
        this.LastScoretime=0;
    end
    this.currentTime=TimeUtil.GetTime();
end

---设置卡池ID
function this.SetpoolId(poolid)
    this.poolId=poolid;
    this.satisfyScore=false;
end


function this.SetQuality(grade)
    if ShiryuSDK.CanShowRateUs() then
        ---等级小于6 都不满足
        if grade<6 then return; end
        ---评分已经为true 不用继续
        if  this.satisfyScore then return; end
        if  this.poolId~=0 and  this.poolId~=1003 then
            Log("满足评分"..grade)
            this.OnInitData();
            local Advscoretimer=  this.currentTime-this.LastScoretime;
            local dayTimer=Advscoretimer/86400;
            Log("dayTimer："..dayTimer)
            if this.LastScoretime==0 or dayTimer>=120 then
                if CSAPI.IsMobileplatform then
                    ---满足指定ID
                    --if this.googleecid=="3010021001" or this.iosecid=="3010011001" then
                    --end
                    this.satisfyScore=true;
                end
            end
        end
    end
end

---引导评分 一年最多3次  每次间隔120天
function this.GameAdvGuiDeScore()
    if this.satisfyScore then
        --local dialogData = {}
        --dialogData.title =LanguageMgr:GetTips(1039)
        --dialogData.content =LanguageMgr:GetTips(1040)
        --dialogData.okText =LanguageMgr:GetByID(6012)
        --dialogData.cancelText =LanguageMgr:GetByID(1002)
        --dialogData.okCallBack = function() ShiryuSDK.RateUs(); end
        --dialogData.cancelCallBack = function()  end
        --CSAPI.OpenView("Dialog", dialogData)
        print("打开引导评分")
        CSAPI.OpenView("AdvGuideSoreView")
        local key=PlayerClient:GetUid()..this.PlayerPrefsSetIntKey;
        PlayerPrefs.SetInt(key, this.currentTime);
    end
end