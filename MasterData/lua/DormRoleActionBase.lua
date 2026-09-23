DormRoleActionBase = oo.class()

local this = DormRoleActionBase

--获取类型
function this:GetType()
	return self.actionType;
end
--设置类型
function this:SetType(dormRoleActionType)
	self.actionType = dormRoleActionType
end

--设置数据
function this:SetData(dormRole)
	if(dormRole == nil) then
		LogError("dormRole数据为空")
	end
	self.dormRole = dormRole
	self.isEnter = false
end

--获取数据
function this:GetData()
	return self.dormRole
end


function this:Enter()
	
end

function this:Update()
	
end

--退出（强迫终止或完成行为后退出）
function this:Exit()
	self.isEnter = false
end

function this:OnComplete()
	
end



return this 