-- chunkname: @IQIGame\\UI\\Maze\\MazeBattle\\MazeBattleNpc.lua

local UISpineView = require("IQIGame/UI/Common/UISpine/UISpineView")
local Npc = Clone(UISpineView)

function Npc.New(entityID, eventLinkPOD, defaultAnimation, defaultEffect, parentTrans, targetTransform, callback)
	local obj = Clone(Npc)

	obj:__OnInit(entityID, eventLinkPOD, defaultAnimation, defaultEffect, parentTrans, targetTransform, callback)

	return obj
end

function Npc:__OnInit(entityID, eventLinkPOD, defaultAnimation, defaultEffect, parentTrans, targetTransform, callback)
	self.callback = callback
	self.defaultAnimation = defaultAnimation
	self.defaultEffect = defaultEffect
	self.eventLinkPOD = eventLinkPOD

	self:_OnCreate(entityID, parentTrans, targetTransform, function()
		self:__OnSpineViewReady()
	end)
end

function Npc:__OnSpineViewReady()
	self:EnableClick(function()
		self:__OnNpcClickHandler()
	end)

	if self.callback ~= nil then
		self.callback(self)
	end

	if LuaUtility.StrIsNullOrEmpty(self.defaultAnimation) then
		self:_PlayAnim("idle", true)
	else
		self:_PlayAnim(self.defaultAnimation, true)
	end

	self:__OnLoadDefaultEffect()
end

function Npc:__OnLoadDefaultEffect()
	if self:GetIsCanClearEffect() then
		self:ClearEffect()

		return
	end

	if self.defaultEffect == nil or table.len(self.defaultEffect) == 0 then
		return
	end

	self.effectSerialIds = {}

	for i = 1, #self.defaultEffect, 2 do
		local effectSerialId = GameEntry.Effect:PlayUIMountPointEffect(self.defaultEffect[i], self.defaultEffect[i + 1], 0, self.spineEntityGo, MazeBattleStepModule.uiSortOrder + 4)

		table.insert(self.effectSerialIds, effectSerialId)
	end
end

function Npc:SetStageEventPOD(eventLinkPOD)
	self.eventLinkPOD = eventLinkPOD
end

function Npc:PlayDieAnim()
	self:_PlayAnim("die", false)
end

function Npc:PlayBornAnim()
	self:_PlayAnim("born", false)
end

function Npc:PlayMoveAnim()
	self:_PlayAnim("S_move", true)
end

function Npc:PlayIdleAnim()
	self:_PlayAnim("S_stay", true)
end

function Npc:PlayerAnimByName(animationName, isLoop)
	self:_PlayAnim(animationName, isLoop)
end

function Npc:SetFlip(isUnitFlip)
	self.spineEntityGo.transform.localScale = isUnitFlip and Vector3(-1, 1, 1) or Vector3.one
	self.spineEntityGo.transform:FindChildByName("Effect").localScale = isUnitFlip and Vector3(-1, 1, 1) or Vector3.one
end

function Npc:SetSacle(isScale)
	if isScale then
		local scale = self.spineEntityGo.transform.localScale

		self.spineEntityGo.transform.localScale = Vector3.New(scale.x * -1, scale.y, scale.z)
	end
end

function Npc:TriggerEvent()
	self:__OnNpcClickHandler()
end

function Npc:__OnNpcClickHandler()
	EventDispatcher.Dispatch(EventID.TriggerMazeBattleNPC)
end

function Npc:GetIsCanClearEffect()
	if self.eventLinkPOD ~= nil and self.eventLinkPOD.eventLinkState == true and not MazeModule.GetIsShopEvent(self.eventLinkPOD) then
		return true
	end

	return false
end

function Npc:ClearEffect()
	if self.effectSerialIds == nil or table.len(self.effectSerialIds) == 0 then
		return
	end

	ForPairs(self.effectSerialIds, function(_, effectSerialId)
		GameEntry.Effect:StopEffect(effectSerialId)
	end)

	self.effectSerialIds = {}
end

function Npc:Dispose()
	self:ClearEffect()
	self:_Dispose()
end

return Npc
