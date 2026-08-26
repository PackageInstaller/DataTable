-- chunkname: @modules/logic/room/view/critter/train/RoomCritterTrainCritterItem.lua

module("modules.logic.room.view.critter.train.RoomCritterTrainCritterItem", package.seeall)

local RoomCritterTrainCritterItem = class("RoomCritterTrainCritterItem", LuaCompBase)

function RoomCritterTrainCritterItem:init(go)
	self._go = go
	self._goshadow = gohelper.create2d(go, "critter_shadow")

	gohelper.setAsFirstSibling(self._goshadow)
	gohelper.setActive(self._goshadow, false)

	self._roleSpine = GuiSpine.Create(go, false)
	self._canvasGroup = gohelper.onceAddComponent(go, typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(go, true)

	self._effs = {}
	self._tamingEffs = {}
	self._effLoader = MultiAbLoader.New()
	self._tamingEffLoader = MultiAbLoader.New()
	self._shadowLoader = MultiAbLoader.New()
end

local effTbs = {
	"roomcritteremoji1",
	"roomcritteremoji2",
	"roomcritteremoji3",
	"roomcritteremoji4",
	"roomcritteremoji5",
	"roomcritteremoji6"
}

function RoomCritterTrainCritterItem:showByEffectType(critterMo, pos, indialog)
	self._critterMo = critterMo
	self._critterPos = pos
	self._inDialog = indialog

	self:_refreshItem()
end

function RoomCritterTrainCritterItem:showByEffectName(critterMO, pos, indialog)
	self._critterMo = critterMO
	self._critterPos = pos
	self._inDialog = indialog

	self:_refreshItem()
end

local shadowPath = "ui/viewres/room/critter/roomcrittershadowitem.prefab"

function RoomCritterTrainCritterItem:showShadow(show)
	gohelper.setActive(self._goshadow, show)

	if show and not self._shadowGo then
		self._shadowLoader:addPath(shadowPath)
		self._shadowLoader:startLoad(self._loadShadowFinished, self)
	end
end

function RoomCritterTrainCritterItem:_loadShadowFinished()
	local assetItem = self._shadowLoader:getAssetItem(shadowPath)

	self._shadowGo = gohelper.clone(assetItem:GetResource(), self._goshadow)

	local circleBottomGo = gohelper.findChild(self._spineGo, "mountroot/mountbottom")
	local x, y, z = transformhelper.getPos(circleBottomGo.transform)

	transformhelper.setPos(self._shadowGo.transform, x, y, z)
end

function RoomCritterTrainCritterItem:showTamingEffects(show, index)
	if LuaUtil.tableNotEmpty(self._tamingEffs) then
		for _, eff in pairs(self._tamingEffs) do
			for _, go in pairs(eff.effGos) do
				gohelper.setActive(go, show)
			end
		end
	else
		local skinConfig = CritterConfig.instance:getCritterSkinCfg(self._critterMo:getSkinId())

		if LuaUtil.isEmptyStr(skinConfig.handEffects) then
			return
		end

		local tamingEff = string.split(skinConfig.handEffects, ";")

		if not tamingEff[index] or LuaUtil.isEmptyStr(tamingEff[index]) then
			return
		end

		local rootEffects = string.split(tamingEff[index], "&")

		for _, rootEff in pairs(rootEffects) do
			local paths = string.split(rootEff, "|")
			local eff = {}

			eff.root = string.format("mountroot/%s", paths[1])
			eff.effPaths = {}

			local pathEffs = string.split(paths[2], "#")

			for _, path in ipairs(pathEffs) do
				table.insert(eff.effPaths, path)
			end

			table.insert(self._tamingEffs, eff)
		end

		self:_loadTamingEffects()
	end
end

function RoomCritterTrainCritterItem:_loadTamingEffects()
	for _, eff in pairs(self._tamingEffs) do
		for _, path in pairs(eff.effPaths) do
			local effPath = string.format("effects/prefabs_ui/%s.prefab", path)

			self._tamingEffLoader:addPath(effPath)
		end
	end

	self._tamingEffLoader:startLoad(self._loadTamingEffsResFinish, self)
end

function RoomCritterTrainCritterItem:_loadTamingEffsResFinish()
	for i = 1, #self._tamingEffs do
		self._tamingEffs[i].effGos = {}

		for _, path in pairs(self._tamingEffs[i].effPaths) do
			local effPath = string.format("effects/prefabs_ui/%s.prefab", path)
			local assetItem = self._tamingEffLoader:getAssetItem(effPath)
			local parentGo = gohelper.findChild(self._spineGo, self._tamingEffs[i].root)
			local effGo = gohelper.clone(assetItem:GetResource(), parentGo)

			table.insert(self._tamingEffs[i].effGos, effGo)
		end
	end
end

function RoomCritterTrainCritterItem:setEffectByName(effName)
	self._critterEffType = 0

	for type, eff in ipairs(effTbs) do
		if string.find(effName, eff) then
			self._critterEffType = type
		end
	end
end

function RoomCritterTrainCritterItem:setEffectByType(effType)
	self._critterEffType = effType
end

function RoomCritterTrainCritterItem:hideEffects()
	for _, v in pairs(self._effs) do
		gohelper.setActive(v, false)
	end
end

function RoomCritterTrainCritterItem:setCritterPos(pos, indialog)
	self._critterPos = pos
	self._inDialog = indialog

	self:_refreshItem()
end

function RoomCritterTrainCritterItem:getCritterPos()
	return self._critterPos
end

function RoomCritterTrainCritterItem:setCritterEffectOffset(offsetX, offsetY)
	self._effOffsetX = offsetX
	self._effOffsetY = offsetY
end

function RoomCritterTrainCritterItem:setCritterEffectScale(scale)
	self._scale = scale
end

local dialogPosY = {
	[true] = -160,
	[false] = -140
}
local effPos = {
	-150,
	0,
	150
}
local critterScale = {
	2,
	1.5,
	2
}

function RoomCritterTrainCritterItem:_onSpineLoaded()
	self._spineGo = self._roleSpine:getSpineGo()

	self:_setSpine()
end

function RoomCritterTrainCritterItem:playBodyAnim(bodyName, isLoop)
	self._roleSpine:play(bodyName, isLoop)

	if self._critterMo then
		local critterId = self._critterMo:getDefineId()
		local audioIdList = CritterConfig.instance:getCritterInteractionAudioList(critterId, bodyName)

		if audioIdList then
			for _, audioId in ipairs(audioIdList) do
				AudioMgr.instance:trigger(audioId)
			end
		end
	end
end

function RoomCritterTrainCritterItem:fadeIn()
	UIBlockMgr.instance:startBlock("fadeShow")
	self:_clearTweens()
	self:_fadeUpdate(0)

	self._fadeInTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self._fadeUpdate, self._fadeInFinished, self, nil, EaseType.Linear)
end

function RoomCritterTrainCritterItem:_fadeUpdate(value)
	self._canvasGroup.alpha = value
end

function RoomCritterTrainCritterItem:_fadeInFinished()
	UIBlockMgr.instance:endBlock("fadeShow")
end

function RoomCritterTrainCritterItem:fadeOut()
	UIBlockMgr.instance:startBlock("fadeShow")
	self:_clearTweens()
	self:_fadeUpdate(1)

	self._fadeOutTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.35, self._fadeUpdate, self._fadeOutFinished, self, nil, EaseType.Linear)
end

function RoomCritterTrainCritterItem:_fadeOutFinished()
	UIBlockMgr.instance:endBlock("fadeShow")
end

function RoomCritterTrainCritterItem:_clearTweens()
	if self._fadeInTweenId then
		ZProj.TweenHelper.KillById(self._fadeInTweenId)

		self._fadeInTweenId = nil
	end

	if self._fadeOutTweenId then
		ZProj.TweenHelper.KillById(self._fadeOutTweenId)

		self._fadeOutTweenId = nil
	end
end

function RoomCritterTrainCritterItem:_setSpine()
	local posX = effPos[self._critterPos]
	local posY = dialogPosY[self._inDialog]
	local critterScale = critterScale[self._critterPos]

	if self._scale then
		if not (self._scale / critterScale) then
			local effScale = 1 / critterScale

			transformhelper.setLocalPos(self._spineGo.transform, posX, posY, 0)
			transformhelper.setLocalScale(self._go.transform, critterScale, critterScale, 1)

			for _, v in pairs(self._effs) do
				transformhelper.setLocalScale(v.transform, effScale, effScale, 1)
			end

			self:showShadow(self._critterPos == CritterEnum.PosType.Middle)
		end
	end
end

function RoomCritterTrainCritterItem:_refreshItem()
	if self._critterMo then
		if not self._spineGo then
			local skinCo = CritterConfig.instance:getCritterSkinCfg(self._critterMo:getSkinId())
			local path = ResUrl.getSpineUIPrefab(skinCo.spine)

			self._roleSpine:setResPath(path, self._onSpineLoaded, self, true)
		else
			self:_setSpine()
		end
	end

	self:hideEffects()

	if not self._critterEffType or self._critterEffType == 0 then
		return
	end

	if self._effs[self._critterEffType] then
		gohelper.setActive(self._effs[self._critterEffType], true)
		transformhelper.setLocalPos(self._effs[self._critterEffType].transform, self._effOffsetX or 0, self._effOffsetY or 0, 0)
	else
		local path = string.format("ui/viewres/story/%s.prefab", effTbs[self._critterEffType])

		self._effLoader:addPath(path)
		self._effLoader:startLoad(function()
			local prefab = self._effLoader:getAssetItem(path):GetResource(path)
			local go
			local effGo = gohelper.clone(prefab, (self._spineGo or nil) and gohelper.findChild(self._spineGo, "mountroot/mounthead") or self._go)

			self._effs[self._critterEffType] = effGo

			transformhelper.setLocalPos(effGo.transform, self._effOffsetX or 0, self._effOffsetY or 0, 0)
		end)
	end
end

function RoomCritterTrainCritterItem:onDestroy()
	self:_clearTweens()

	if self._effs then
		for _, v in pairs(self._effs) do
			gohelper.destroy(v)
		end

		self._effs = nil
	end

	if self._effLoader then
		self._effLoader:dispose()

		self._effLoader = nil
	end

	if self._tamingEffLoader then
		self._tamingEffLoader:dispose()

		self._tamingEffLoader = nil
	end

	if self._shadowLoader then
		self._shadowLoader:dispose()

		self._shadowLoader = nil
	end

	AudioMgr.instance:trigger(AudioEnum.Room.stop_mi_bus)
end

return RoomCritterTrainCritterItem
