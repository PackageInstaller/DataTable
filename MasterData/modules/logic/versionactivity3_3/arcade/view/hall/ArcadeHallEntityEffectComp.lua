-- chunkname: @modules/logic/versionactivity3_3/arcade/view/hall/ArcadeHallEntityEffectComp.lua

module("modules.logic.versionactivity3_3.arcade.view.hall.ArcadeHallEntityEffectComp", package.seeall)

local ArcadeHallEntityEffectComp = class("ArcadeHallEntityEffectComp", LuaCompBase)

function ArcadeHallEntityEffectComp:ctor(param)
	self._entity = param.entity
	self._compName = param.compName
	self._loader = param.loader
end

function ArcadeHallEntityEffectComp:init(go)
	self.go = go
	self.trans = go.transform
	self._initialized = true
	self._effectGODict = {}
end

function ArcadeHallEntityEffectComp:playEffect(effectId)
	local resName = ArcadeConfig.instance:getEffectResName(effectId)

	if not self._loader or string.nilorempty(resName) then
		return
	end

	local effectGO = self._effectGODict[resName]

	if not gohelper.isNil(effectGO) then
		gohelper.setActive(effectGO, false)
		gohelper.setActive(effectGO, true)
		transformhelper.setLocalPos(self.trans, 0, 0, 0)
	else
		local resAbPath
		local resPath = ResUrl.getArcadeGameEffect(resName)

		if not GameResMgr.IsFromEditorDir then
			resAbPath = FightHelper.getEffectAbPath(resPath)
		end

		self._loader:loadRes(resAbPath or resPath, self.onLoadEffectFinished, self, {
			resName = resName,
			resAbPath = resAbPath,
			resPath = resPath
		})
	end
end

function ArcadeHallEntityEffectComp:onLoadEffectFinished(param)
	if not self._initialized or not self._loader then
		return
	end

	local assetRes = self._loader:getResource(param.resPath, param.resAbPath)

	self._effectGODict[param.resName] = gohelper.clone(assetRes, self.go)
end

function ArcadeHallEntityEffectComp:getCompName()
	return self._compName
end

function ArcadeHallEntityEffectComp:clear()
	if not self._initialized then
		return
	end

	self._initialized = false
	self._entity = nil
	self._compName = nil
	self._effectGODict = {}
end

function ArcadeHallEntityEffectComp:onDestroy()
	self:clear()
end

return ArcadeHallEntityEffectComp
