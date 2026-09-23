local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:InitData(_data, _typeIndex)
    self.data = _data
    self.typeIndex = _typeIndex
end

function this:GetData()
    return self.data
end

-- 唯一id
function this:GetID()
    return self.data.id
end

-- 跳转id
function this:GetSkipID()
    if (self.data.skip_id and self.data.skip_id ~= "0" and self.data.skip_id ~= 0 and self.data.skip_id ~= "") then
        return self.data.skip_id
    end
    return nil
end

-- 标题
function this:GetTitle()
    return self.data.title or ""
end

-- 副标题
function this:GetSubTitle()
    return self.data.sub_title or ""
end

-- 图片名称
function this:GetImageName()
    return self.data.file_name or ""
end
-- 图片地址
function this:GetImagePath()
    return self.data.path
end

-- 大图片名称
function this:GetImageName2()
    if (self.data.bg_file_names) then
        return self.data.bg_file_names[1] or ""
    else
        return ""
    end
end
-- -- 大图片地址
-- function this:GetImagePath2()
--     return self.data.bg_path
-- end

--公告图片路径
function this:GetBoardImgUrl()
    return ActivityMgr:GetBaseUrl()..self:GetImagePath()
end


function this:GetImgUrl()
    return ActivityMgr:GetActivityDownAddress(self.typeIndex)
end

-- 内容
function this:GetDesc()
    return self.data.content or ""
end

-- 开始时间
function this:GetBeginTime()
    if (self.data.beg_time and self.data.beg_time ~= "") then
        return TimeUtil:GetTimeStampBySplit(self.data.beg_time)
    end
    return nil
end

-- 结束时间
function this:GetEndTime()
    if (self.data.end_time and self.data.end_time ~= "") then
        return TimeUtil:GetTimeStampBySplit(self.data.end_time)
    end
    return nil
end

-- 显示用的时间
function this:GetShowTime()
    if (self.data.show_time and self.data.show_time ~= "") then
        return GCalHelp:GetTimeStampBySplit(self.data.show_time)
    end
    return nil
end

-- 在活动时间段内
function this:CheckIsInTime(time)
    local curTime = time or TimeUtil:GetTime()
    local beginTime = self:GetBeginTime()
    local endTime = self:GetEndTime()
    if (beginTime == nil or curTime > beginTime) then
        if (endTime == nil or endTime > curTime) then
            return true
        end
    end
    return false
end

-- 额外字段 
-- dcwj
function this:GetAddInfo()
    return self.data.add_info
end

function this:GetSortID()
    return self.data.sort_id and tonumber(self.data.sort_id) or 1
end

-- 关联的活动id
function this:PanelId()
    return self:GetData().panel_id
end

-- 描述数组 {{bool，desc,width, height},{bool，desc,width, height}..}  bool：true 是图片  desc：图片名称或者描述 
function this:GetDescTables()
    local content = self:GetDesc()
    if (content == "") then
        return {}
    end
    local parts = {}
    local _parts = StringUtil:split(content, "||")
    for k, v in ipairs(_parts) do
        local str, width, height = string.match(v, "<PNG=(%d+)><width=(%d+)><height=(%d+)>")
        if (str == nil) then
            table.insert(parts, {false, v})
        else
            table.insert(parts, {true, str, tonumber(width), tonumber(height)})
        end
    end
    return parts
end

-- 分页  1 2 3
function this:GetPage()
    return tonumber(self:GetData().page) or 1
end

-- 显示方式 0 1 2
function this:GetShowType()
    return tonumber(self:GetData().show_type) or 0
end

--是否显示 分享按钮
function this:can_share()
    return self:GetData().can_share
end
return this
