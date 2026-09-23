local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:Init(cfg,isTemp)
    self.cfg = cfg
    self.isTemp = isTemp
    if isTemp then
        self.isShow = true
    end
end

function this:GetCfg()
    return self.cfg
end

function this:GetID()
    return self.cfg and self.cfg.id
end

function this:GetType()
    return self.cfg and self.cfg.type
end

function this:GetGroup()
    return self.cfg and self.cfg.group
end

function this:GetIcon()
    return self.cfg and self.cfg.talkRoleEmblem or ""
end

function this:GetNextIDs()
    return self.cfg and self.cfg.nextChatID
end

function this:GetStoryID()
    return self.cfg and self.cfg.paragraphID
end

function this:GetDesc()
    local str = self.cfg and self.cfg.dateContent or ""
    local len = GLogicCheck:GetStringLen(str) or 0
    if len > 16 then
        local tab = StringUtil:SubStrByLength(str,16)
        local _str = ""
        for i, v in ipairs(tab) do
            if i == 1 then
                _str = v
            else
                _str = _str .. "\n"  .. v
            end
        end
        str = _str
    end
    return str,len
end

function this:GetTalkTime()
    local time = 0
    if self.cfg and self.cfg.chattingSpeed then
        local percent = self.cfg.chattingSpeed
        local timeUnit = g_LovePlusTalkTime or 0.1
        local len = self:GetDescLen()
        time = len * timeUnit * percent / 100    
    end
    return time / 10
end

function this:GetDescLen()
    local str = self.cfg and self.cfg.dateContent or ""
    return GLogicCheck:GetStringLen(str) or 0
end

function this:GetSize()
    local size = 20 + 77 --20是两个物体的间距 77是高度
    local height = 77
    if self.isTemp then
        local ids = self:GetNextIDs()
        if ids and #ids > 0 then
            size = 20 + 20 + 20 + (#ids - 1) * (76 + 13) + 76
            height = 20 + 20 + (#ids - 1) * (76 + 13) + 76
        end
    else
        local str = self:GetDesc() or ""
        if str ~= "" then
            local len = self:GetDescLen()
            local raw = math.ceil(len / 16)
            if raw > 1 then
                size = size + (raw - 1) * 43
                height = height + (raw - 1) * 43
            end
        end
    end
    return size,height
end

--已显示过
function this:IsShow()
    return self.isShow
end

function this:SetIsShow(b)
    self.isShow = b
end

--1.对方 2.我方 3.选项 4.跳转
function this:GetShowType()
    local type = 2
    if self.cfg  then
        if self.cfg.talkRoleEmblem then
            type = 1
        end
        if self.cfg.type then
            if self.cfg.type == 2 then --选项对话
                type = 3
            elseif self.cfg.type == 3 then --跳转对话
                type = 4
            end
        end
    end
    return type
end

--被选择
function this:IsOption()
    return self.cfg and self.cfg.isOption
end

--隐藏头像
function this:IsHideIcon()
    if self:GetShowType() == 2 or self.cfg.talkRoleEmblem == nil or self.isTemp or (self.cfg and self.cfg.isHideIcon) then
        return true
    end
    return false
end

--临时创建的数据
function this:IsTemp()
    return self.isTemp
end

return this