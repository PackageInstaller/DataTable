-- chunkname: @modules/logic/story/view/heropreview/StoryHeroNode.lua

module("modules.logic.story.view.heropreview.StoryHeroNode", package.seeall)

local StoryHeroNode = class("StoryHeroNode", LuaCompBase)

function StoryHeroNode:ctor()
	return
end

function StoryHeroNode:init(go)
	self._heroRoot = go
	self._heroGoRoot = gohelper.create2d(self._heroRoot, "rolespine")
	self._canvas = gohelper.onceAddComponent(self._heroGoRoot, typeof(UnityEngine.Canvas))
	self._canvas.overrideSorting = true
	self._siblingIndex = gohelper.getSibling(self._heroGoRoot)

	gohelper.setLayer(self._heroGoRoot, UnityLayer.UISecond, true)
end

function StoryHeroNode:load(heroCo, path, callback, callbackObj)
	self._loadCallback = callback
	self._loadCallbackObj = callbackObj
	self._heroCo = heroCo

	if heroCo.type == StoryHeroPreviewEnum.HeroType.Spine then
		self:loadSpine(path)
	elseif heroCo.type == StoryHeroPreviewEnum.HeroType.Live2D then
		self:loadLive2d(path)
	end
end

function StoryHeroNode:loadSpine(spinePath)
	self._spinePath = spinePath
	self._heroSpine = GuiSpine.Create(self._heroGoRoot, true)

	self._heroSpine:setResPath(self._spinePath, self._onSpineLoaded, self)
end

function StoryHeroNode:_onSpineLoaded()
	self._heroSkeletonGraphic = self._heroSpine:getSkeletonGraphic()
	self._heroSpineGo = self._heroSpine:getSpineGo()
	self._canvas.sortingOrder = (self._siblingIndex + 1) * 10

	if self._loadCallback then
		self._loadCallback(self._loadCallbackObj, self._heroSpineGo)

		self._loadCallback = nil
		self._loadCallbackObj = nil
	end
end

function StoryHeroNode:setDir(dir)
	local pos = {
		0,
		0
	}
	local scale = 1

	if self._heroCo.type == StoryHeroPreviewEnum.HeroType.Spine then
		local params = {}

		if dir == StoryHeroPreviewEnum.Direction.Left then
			params = string.splitToNumber(self._heroCo.leftParam, "#")
		elseif dir == StoryHeroPreviewEnum.Direction.Middle then
			params = string.splitToNumber(self._heroCo.midParam, "#")
		elseif dir == StoryHeroPreviewEnum.Direction.Right then
			params = string.splitToNumber(self._heroCo.rightParam, "#")
		end

		if params then
			pos[1] = params[1] or 0
		end

		if params then
			pos[2] = params[2] or 0
		end

		scale = params and params[3] or 1
	elseif self._heroCo.type == StoryHeroPreviewEnum.HeroType.Live2D then
		local params = {}

		if dir == StoryHeroPreviewEnum.Direction.Left then
			params = string.splitToNumber(self._heroCo.live2dLeftParam, "#")
		elseif dir == StoryHeroPreviewEnum.Direction.Middle then
			params = string.splitToNumber(self._heroCo.live2dMidParam, "#")
		elseif dir == StoryHeroPreviewEnum.Direction.Right then
			params = string.splitToNumber(self._heroCo.live2dRightParam, "#")
		end

		if params then
			pos[1] = params[1] or 0
		end

		if params then
			pos[2] = params[2] or 0
		end

		scale = params and params[3] or 1
	end

	transformhelper.setLocalPos(self._heroSpineGo.transform, pos[1], pos[2], 0)
	transformhelper.setLocalScale(self._heroSpineGo.transform, scale, scale, 1)
end

function StoryHeroNode:playAnim(param)
	local co = {}

	co.motion = param.motion
	co.face = param.face
	co.mouth = param.mouth

	self._heroSpine:playVoice(co)
end

function StoryHeroNode:getAnimations()
	local animations = {}

	if self._heroCo.type == StoryHeroPreviewEnum.HeroType.Spine then
		local animTable = {}
		local skd = self._heroSkeletonGraphic.skeletonDataAsset:GetSkeletonData(true)

		RoomHelper.cArrayToLuaTable(skd.Animations, animTable)

		for _, anim in pairs(animTable) do
			table.insert(animations, anim.Name)
		end
	elseif self._heroCo.type == StoryHeroPreviewEnum.HeroType.Live2D then
		local cubctrl = self._heroSpineGo:GetComponent(typeof(ZProj.CubismController))
		local animTable = {}
		local motions = cubctrl.clips

		RoomHelper.cArrayToLuaTable(motions, animTable)

		for _, anim in pairs(animTable) do
			table.insert(animations, anim.name)
		end

		local expressions = self:_getExpressionsViaReflection(cubctrl)

		for _, name in ipairs(expressions) do
			table.insert(animations, name)
		end
	end

	return animations
end

function StoryHeroNode:loadLive2d(live2dPath)
	self._live2dPath = live2dPath
	self._heroSpine = GuiLive2d.Create(self._heroGoRoot, true)

	self._heroSpine:cancelCamera()
	self._heroSpine:setResPath(live2dPath, self._onlive2dLoaded, self)
end

function StoryHeroNode:_onlive2dLoaded()
	self._heroSpineGo = self._heroSpine:getSpineGo()

	self._heroSpine:setSortingOrder(self._siblingIndex * 10)

	self._canvas.sortingOrder = (self._siblingIndex + 1) * 10

	gohelper.setLayer(self._heroSpineGo, UnityLayer.UISecond, true)

	if self._loadCallback then
		self._loadCallback(self._loadCallbackObj, self._heroSpineGo)

		self._loadCallback = nil
		self._loadCallbackObj = nil
	end
end

function StoryHeroNode:clearHero()
	if self._heroSpineGo then
		gohelper.destroy(self._heroSpineGo)

		self._heroSpineGo = nil
	end
end

function StoryHeroNode:_getExpressionsViaReflection(cubctrl)
	if not cubctrl then
		return {}
	end

	require("tolua.reflection")
	tolua.loadassembly("SL_AS")

	local type_CubismController = typeof(ZProj.CubismController)
	local method = tolua.getmethod(type_CubismController, "getExpressions")

	if not method then
		return {}
	end

	local dict = method:Call(cubctrl)

	if not dict then
		return {}
	end

	local result = {}
	local dictType = dict:GetType()
	local keysMethod = tolua.getmethod(dictType, "get_Keys")

	if keysMethod then
		local keys = keysMethod:Call(dict)

		if keys then
			local luaKeys = {}

			RoomHelper.cArrayToLuaTable(keys, luaKeys)

			for _, key in pairs(luaKeys) do
				table.insert(result, tostring(key))
			end
		end
	end

	return result
end

function StoryHeroNode:destroy()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._resList = nil
end

return StoryHeroNode
