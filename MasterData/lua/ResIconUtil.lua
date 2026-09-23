local this = {};

function this.New(groupName)
	this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins, this);	
	ins.groupName = groupName;
	return ins;
end


--分组目录
this.groupName = "";

function this:GenIconRes(res)
	if(StringUtil:IsEmpty(res)) then
		LogError("无效的图标资源！！！分类：" .. self.groupName);
        return "";
	end
	return ResUtil.ui .. "/Icons/" .. self.groupName .. "/" .. res .. ".png";
end
--载入图标
function this:Load(target, res, nativeSize, callBack)
	if(nativeSize == nil) then
		nativeSize = true
	end
	res = self:GenIconRes(res);
	CSAPI.LoadImg(target, res, nativeSize, callBack);
end

--载入图标(SpriteRenderer组件)
function this:LoadSR(target, res, callBack)
	res = self:GenIconRes(res);
	CSAPI.LoadSR(target, res, callBack);
end

return this; 