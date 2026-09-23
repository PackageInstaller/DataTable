

--版本检测
VerChecker = {};
local this = VerChecker;

function this:SetState(state)
    self.state = state;
end

--检测
function this:ApplyCheck()
    if(not self.state)then
        return;
    end
    local url;---访问URL
    local IncludeContent;---包含关键字
    if CSAPI.IsADV() then
        --url = CSAPI.HotFileUrl().."/ClientHotRes/fix.txt";
        url = CSAPI.PlatformURL().."/ClientHotRes/fix.txt";
        IncludeContent="_G.g_HotResVersion";
    else
        url = CSAPI.HotFileUrl().."/fix.txt";
        IncludeContent="g_svnVersion";
    end
    CSAPI.GetServerInfo(url,function (str)
        Log(str);
        if str~=nil and str~=" " then
            local matchResult = string.match(str, IncludeContent)
            if matchResult then local func = loadstring(str); func(); end
        end
    end);
end

function this:ApplyUpdate()
    local dialogData = {};
    dialogData.caller = self;
    dialogData.content = LanguageMgr:GetTips(1049);
    dialogData.okCallBack =  self.UpdateVer;
    --dialogData.cancelCallBack = self.UpdateVer;
    CSAPI.OpenView("Prompt",dialogData);
end

function this:UpdateVer()
    CSAPI.UnityQuit();
end

function this:EnableTest()
    self.test_url = "http://192.168.5.53/fix.txt";--内网测试
    self:SetState(true);
end

return this;