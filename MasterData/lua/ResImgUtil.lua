local this = {};

function this.New(groupName)
    this.__index = this.__index or this;
    local ins = {};
    setmetatable(ins, this);
    ins.groupName = groupName;
    return ins;
end

-- 分组名称
this.groupName = "";

function this:GenImgRes(res)
    return ResUtil.bigImg .. "/" .. self.groupName .. "/" .. res .. "/img.png";
end
-- 载入图片
function this:Load(target, res, callBack, nativeSize)
    if (nativeSize == nil) then
        nativeSize = true
    end
    if (res == nil) then
        LogError("加载图像资源失败！目标资源名无效");
        LogError(a.b);
    end
    res = self:GenImgRes(res);
    CSAPI.LoadImg(target, res, nativeSize, callBack);
end

-- 设置偏移
function this:SetPos(target, pos)
    CSAPI.SetLocalPos(target, pos.x, pos.y, pos.z)
end

-- 设置大小
function this:SetScale(target, scale)
    CSAPI.SetScale(target, scale, scale, scale)
end

return this;
