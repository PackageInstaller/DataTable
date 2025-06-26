-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_CreateTempActor.lua

local DialogueBase = require("IQIGame/UI/Dialog/DialogueAction/DialogueActionBase")
local m = classF(DialogueBase)

function m:ctor(args)
	self.args = args
	self.isComplete = false
	self.readyCreateList = nil
end

function m:OnStart()
	if self.isComplete then
		return
	end

	local room = HomeModule.GetCurrentHomeRoom()

	if not room then
		logError("【RPG】试图创建临时角色，但是当前没有房间")

		return
	end

	self.readyCreateList = {}

	local len = #self.args.roleIdList

	for i = 1, len do
		if room:CreateTempComponent(self.args.roleIdList[i]) then
			self.readyCreateList[self.args.roleIdList[i]] = 0
		end
	end

	EventDispatcher.AddEventListener(EventID.CommonDialogControl_Action_CreateRole, function(cid)
		if not self.readyCreateList[cid] then
			return
		end

		self.readyCreateList[cid] = 1
	end)
end

function m:OnUpdate()
	if not self.readyCreateList then
		return
	end

	for _, v in pairs(self.readyCreateList) do
		if v == 0 then
			return
		end
	end

	self.isComplete = true
end

function m:OnSkip()
	if not self.readyCreateList then
		return
	end

	for _, v in pairs(self.readyCreateList) do
		if v == 0 then
			return
		end
	end

	self.isComplete = true
end

function m:OnDestroy()
	EventDispatcher.RemoveEventListenerByType(EventID.CommonDialogControl_Action_CreateRole)
end

return m
