--隐藏状态（编辑家具时隐藏）
DormRoleActionHide = oo.class(DormRoleActionBase)

local this = DormRoleActionHide

function this:Enter()
	self.isEnter = true
	CSAPI.SetGOActive(self.dormRole.gameObject, false)
end

function this:Exit()
	self.isEnter = false
	CSAPI.SetGOActive(self.dormRole.gameObject, true)
end


return this
