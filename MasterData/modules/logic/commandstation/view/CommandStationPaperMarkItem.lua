-- chunkname: @modules/logic/commandstation/view/CommandStationPaperMarkItem.lua

module("modules.logic.commandstation.view.CommandStationPaperMarkItem", package.seeall)

local CommandStationPaperMarkItem = class("CommandStationPaperMarkItem", LuaCompBase)

function CommandStationPaperMarkItem:ctor(param)
	self.isAfter = param.after
	self.style = param.style
end

function CommandStationPaperMarkItem:init(go)
	self.go = go
	self.transform = go.transform
	self._loader = PrefabInstantiate.Create(go)

	self._loader:startLoad(self:getResPath(), self._onLoadedFinish, self)
end

function CommandStationPaperMarkItem:getResPath()
	if self.isAfter then
		return string.format("ui/viewres/commandstation/stickeritem/aftermarkitem_stk%s.prefab", self.style)
	else
		return string.format("ui/viewres/commandstation/stickeritem/beforemarkitem_tuhei%s.prefab", self.style)
	end
end

function CommandStationPaperMarkItem:_onLoadedFinish()
	local go = self._loader:getInstGO()

	self._anim = gohelper.findChildAnim(go, "")
	self._anim.keepAnimatorStateOnDisable = true

	self:playAnim(self._animType)
end

function CommandStationPaperMarkItem:playAnim(type)
	if not type then
		return
	end

	self._animType = type

	local anim = self._anim

	if not anim then
		return
	end

	if self.isAfter then
		if self._animType == 1 then
			anim:Play("in", 0, 0)

			anim.speed = 0
		elseif self._animType == 2 then
			anim:Play("in", 0, 0)

			anim.speed = 1
		else
			anim:Play("idle", 0, 0)
		end
	elseif self._animType == 1 then
		anim:Play("idle", 0, 0)
	elseif self._animType == 2 then
		anim:Play("out", 0, 0)
	else
		anim:Play("out", 0, 1)
	end
end

function CommandStationPaperMarkItem:destroy()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return CommandStationPaperMarkItem
