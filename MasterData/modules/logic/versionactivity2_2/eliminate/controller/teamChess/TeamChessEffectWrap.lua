-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/TeamChessEffectWrap.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.TeamChessEffectWrap", package.seeall)

local TeamChessEffectWrap = class("TeamChessEffectWrap", LuaCompBase)

function TeamChessEffectWrap:ctor()
	self._uniqueId = 0
	self.effectType = nil
	self.path = nil
	self.containerGO = nil
	self.containerTr = nil
	self.effectGO = nil
	self._scaleX = 1
	self._scaleY = 1
	self._scaleZ = 1
	self.callback = nil
	self.callbackObj = nil
end

function TeamChessEffectWrap:setUniqueId(id)
	self._uniqueId = id
end

function TeamChessEffectWrap:init(go)
	self.containerGO = go
	self.containerTr = go.transform
end

function TeamChessEffectWrap:play(time)
	if self.effectGO then
		self:_setWorldScale()
		self:setActive(true)

		if self.effectType == EliminateTeamChessEnum.VxEffectType.ZhanHou then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_pawn_warcry)
		end

		if self.effectType == EliminateTeamChessEnum.VxEffectType.WangYu then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_pawn_deadwords)
		end

		if self.effectType == EliminateTeamChessEnum.VxEffectType.PowerDown then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_adverse_buff)
		end

		if self.effectType == EliminateTeamChessEnum.VxEffectType.PowerUp then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_front_buff)
		end

		if self.effectType == EliminateTeamChessEnum.VxEffectType.StrongHoldBattle then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_clearing_fight)
		end

		if self.effectType == EliminateTeamChessEnum.VxEffectType.Move then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_pawn_shift)
		end

		TaskDispatcher.runDelay(self.returnPool, self, (time == nil or nil) and (self.effectType ~= nil and EliminateTeamChessEnum.VxEffectTypePlayTime[self.effectType] or 0.5))
	end
end

function TeamChessEffectWrap:returnPool()
	TaskDispatcher.cancelTask(self.returnPool, self)
	TeamChessEffectPool.returnEffect(self)
end

function TeamChessEffectWrap:setEffectType(effectType)
	self.effectType = effectType

	local path = EliminateTeamChessEnum.VxEffectTypeToPath[effectType]

	self:setPath(path)
end

function TeamChessEffectWrap:setPath(path)
	self.path = path

	self:loadAsset(self.path)
end

function TeamChessEffectWrap:loadAsset(path)
	if not string.nilorempty(path) and not self._loader then
		self._loader = PrefabInstantiate.Create(self.containerGO)

		self._loader:startLoad(path, self._onResLoaded, self)
	end
end

function TeamChessEffectWrap:_onResLoaded()
	self.effectGO = self._loader:getInstGO()

	self:setLayer(UnityLayer.Scene)
	self:_setWorldScale()

	if self.callback then
		self.callback(self.callbackObj)
	end
end

function TeamChessEffectWrap:setEffectGO(effectGO)
	self.effectGO = effectGO

	if self._effectScale then
		transformhelper.setLocalScale(self.effectGO.transform, self._effectScale, self._effectScale, self._effectScale)
	end

	if self._renderOrder then
		self:setRenderOrder(self._renderOrder, true)
	end
end

function TeamChessEffectWrap:setLayer(layer)
	self._layer = layer

	gohelper.setLayer(self.effectGO, self._layer, true)
end

function TeamChessEffectWrap:setWorldPos(x, y, z)
	if self.containerTr then
		transformhelper.setPos(self.containerTr, x, y, z)
		self:clearTrail()
	end
end

function TeamChessEffectWrap:setWorldScale(x, y, z)
	self._scaleX = x
	self._scaleY = y
	self._scaleZ = z
end

function TeamChessEffectWrap:_setWorldScale()
	if self.effectGO then
		transformhelper.setLocalScale(self.effectGO.transform, self._scaleX, self._scaleY, self._scaleZ)
	end
end

function TeamChessEffectWrap:clearTrail()
	if self.effectGO then
		local effectTimeScale = gohelper.onceAddComponent(self.effectGO, typeof(ZProj.EffectTimeScale))

		effectTimeScale:ClearTrail()
	end
end

function TeamChessEffectWrap:setCallback(callback, callbackObj)
	self.callback = callback
	self.callbackObj = callbackObj
end

function TeamChessEffectWrap:setActive(isActive)
	gohelper.setActive(self.containerGO, isActive)
end

function TeamChessEffectWrap:setRenderOrder(order, force)
	if not order then
		return
	end

	local oldOrder = self._renderOrder

	self._renderOrder = order

	if not force and order == oldOrder then
		return
	end

	if not gohelper.isNil(self.effectGO) then
		local effectOrderContainer = self.effectGO:GetComponent(typeof(ZProj.EffectOrderContainer))

		if effectOrderContainer then
			effectOrderContainer:SetBaseOrder(order)
		end
	end
end

function TeamChessEffectWrap:setEffectScale(scale)
	self._effectScale = scale

	if self.effectGO then
		transformhelper.setLocalScale(self.effectGO.transform, self._effectScale, self._effectScale, self._effectScale)
	end
end

function TeamChessEffectWrap:clear()
	self.callback = nil
	self.callbackObj = nil

	self:setActive(false)
end

function TeamChessEffectWrap:onDestroy()
	self.containerGO = nil
	self.effectGO = nil
	self.callback = nil
	self.callbackObj = nil
	self.effectType = nil

	TaskDispatcher.cancelTask(self.returnPool, self)

	if self._loader then
		self._loader:onDestroy()

		self._loader = nil
	end
end

return TeamChessEffectWrap
