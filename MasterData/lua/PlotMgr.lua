--剧情管理
PlotMgr = {};

local this = PlotMgr;
--剧情数据键
this.plotDataKey = "plot_data";

local lineKey = "line_";

--尝试播放
function this:TryPlay(id,callBack,caller,forcePlay)

    --未登录
    if(not PlayerClient:GetUid())then
        return false;
    end

    --forcePlay = 1;
    --挂机战斗不播剧情
    if(_G.Fight_Auto)then
        self:TryCallBack(callBack,caller);
        return false;
    end

    local cfgStoryInfo = id and Cfgs.StoryInfo:GetByID(id);
    if(cfgStoryInfo == nil)then
        if(id)then
            LogError("不存在剧情配置数据" .. id);
        end
        self:TryCallBack(callBack,caller);
        return false;
    end

    self.forcePlayState = forcePlay;

    if(not self.forcePlayState)then--强制播放跳过检测
        if(self.data)then
            local storyType = cfgStoryInfo.storyType or 1
            local key = lineKey .. (cfgStoryInfo.line or storyType);
         
            local storyLineVal = self.data[key] or -1;
           
            if(id <= storyLineVal)then
                self:TryCallBack(callBack,caller);
                return false;
            end
        end
    end

    self.callBack = callBack;
    self.caller = caller;
    self:UpdateStoryData(id);
    
    local story=StoryData.New();
	story:InitCfg(id);
	if story~=nil  then
		if story:GetType()==PlotType.Normal then
			CSAPI.OpenView("Plot", {storyID = id,playCallBack = self.OnPlayCallBack,caller = self});
		else
			CSAPI.OpenView("PlotSimple",{storyID = id,playCallBack = self.OnPlayCallBack,caller = self});
		end
    else
        LogError("未找到剧情ID："..tostring(id));
    end
    return true;
end

function this:IsPlayed(id)
    --if(1)then return false; end

    local cfgStoryInfo = id and Cfgs.StoryInfo:GetByID(id);
    if(cfgStoryInfo)then
        local storyType = cfgStoryInfo.storyType or 1
        local key = lineKey .. (cfgStoryInfo.line or storyType);
        local storyLineVal = self.data and self.data[key] or -1;
           
        if(id <= storyLineVal)then                
            return true;
        end
    end
end

function this:OnPlayCallBack()
    if(not self.forcePlayState)then
        self:Save();
    end
    self:TryCallBack(self.callBack,self.caller);   
    self.callBack = nil;
    self.caller = nil;
end

function this:TryCallBack(callBack,caller)
    if(callBack)then
        callBack(caller);
    end
end


function this:Play()
    if self.playData then
        local story=StoryData.New();
        story:InitCfg(self.playData.storyID);
        if story~=nil  then
            if story:GetType()==PlotType.Normal then
                CSAPI.OpenView("Plot", self.playData);
            else
                CSAPI.OpenView("PlotSimple",self.playData);
            end
        else
            LogError("未找到剧情ID："..tostring(id));
        end
    end
end

function this:Init()
    PlayerProto:GetClientData(self.plotDataKey);
end
--设置数据
function this:SetData(data)
    self.data = data or {};   
end
function this:UpdateStoryData(id)
    self.data = self.data or {};
    local cfgStoryInfo = Cfgs.StoryInfo:GetByID(id);
    if (cfgStoryInfo) then
        local storyType = cfgStoryInfo.storyType or 1
        local key = lineKey .. (cfgStoryInfo.line or storyType);
        if (not self.data[key] or self.data[key] < id) then
            self.data[key] = id;
        end
    end
end

--保存
function this:Save()
    if(self.data)then
        PlayerProto:SetClientData(self.plotDataKey,self.data);
    end
end

return this;

