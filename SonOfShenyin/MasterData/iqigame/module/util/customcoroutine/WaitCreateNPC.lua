-- chunkname: @IQIGame\\Module\\Util\\CustomCoroutine\\WaitCreateNPC.lua

WaitCreateNPC = class({
	waitType = "WaitCreateNPC"
}, CustomWait)
WaitCreateNPC.IsLog = false

function WaitCreateNPC:ctor(npcID, npcName, entityConfigID, position, npcSetting, callback)
	EntityUtility.GetStoryEntity(entityConfigID, nil, Vector3.zero, function(entityComponent)
		local npc = StoryNPC(npcID, npcName)
		local characterInfo = {}

		characterInfo.gameObject = entityComponent.gameObject
		characterInfo.entityConfigID = entityConfigID

		npc:InitNPC(characterInfo, entityComponent.Id, npcSetting)
		npc.transform:SetParent(StoryModule.StoryNpcRoot.transform)

		if position then
			entityComponent.transform.position = position
		end

		if callback then
			callback(npc)
		end

		if WaitCreateNPC.IsLog then
			logDebug("创建实体" .. entityConfigID .. "完成")
		end

		self.result = npc
		self.isComplete = true
	end)
end

return WaitCreateNPC
