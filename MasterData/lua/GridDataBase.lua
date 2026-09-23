--格子视图数据基类
-- DataBase=oo.class();
local this=oo.class();

function this:Init(_d)
	self.data=_d;
end

function this:GetData()
	return self.data or nil;
end

function this:GetCfg()
	return nil
end

function this:GetName()
	return "";
end

function this:GetID()
	return nil;
end

function this:GetIcon()
	return nil;
end

function this:GetQuality()
	return 1;
end

--图标缩放大小
function this:GetIconScale()
    return 1;
end

--返回读取图标的工具类对象
function this:GetIconLoader()
    return ResUtil.IconGoods;
end

function this:GetLv()
	return nil;
end

function this:GetCount()
	return 0;
end

function this:GetDesc()
	return "";
end

function this:GetStars()
	return 0;
end

function this:IsNew()
	return false;
end

function this:IsLock()
	return false;
end

function this:IsEquipped()
	return false;
end

function this:GetClassType()
	return "DataBase"
end

--返回过期时间
function this:GetExpiry()
	return nil
end

--是否是限时物品
function this:IsExipiryType()
	return false
end

function this:GetExpiryTips()
	return nil
end

function this:GetObtainrateState()
	if self:GetCfg()~=nil then
		return self:GetCfg().is_obtainrate_showed;
	else
		return nil;
	end
end

function this:CanConverted()
	return false;
end


return this