-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_PlayEffect.lua

local DialogueBase = require("IQIGame/UI/Dialog/DialogueAction/DialogueActionBase")
local m = classF(DialogueBase)

function m:ctor(args)
	self.args = args
	self.isComplete = false
end

function m:OnStart()
	if self.isComplete then
		return
	end

	if self.args.effectType == CommonDialogueActionUtil.EffectType.Scene then
		local actor = HomeModule.GetRoomComponentWithId(self.args.roleId)

		if not actor then
			logError("【RPG】播放场景特效失败，没有找到 id = " .. self.args.roleId .. "的角色")

			return
		end

		local path = UIGlobalApi.GetFxEffectPathByEntityId(self.args.effectId)

		LuaUtility.LoadAsset(self, path, function(owner, assetName, asset, duration, userData)
			local effect = GameObject.Instantiate(asset, actor:GetTagMountPoint().transform)

			LuaUtility.SetLocalPositionWithGameObject(effect, self.args.offset.x, self.args.offset.y, self.args.offset.z)
			CommonDialogueActionUtil.AddEffect(actor:GetComponentId(), self.args.effectId, effect)

			self.isComplete = true
		end)
	elseif self.args.effectType == CommonDialogueActionUtil.EffectType.UI then
		EventDispatcher.Dispatch(EventID.MainUI_ShowUIEffectEvent, -1, self.args.effectId, self.args.offset)
	end
end

function m:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

return m
