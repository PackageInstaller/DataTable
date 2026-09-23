--待机（不会主动退出该状态）
DormRoleActionAwait = oo.class(DormRoleActionBase)

local this = DormRoleActionAwait

function this:Enter()
	
	self.isEnter = true
	
	--播放休闲动画
	self.dormRole.dormRoleStateMachine:PlayByActionType("idle")
end


return this
