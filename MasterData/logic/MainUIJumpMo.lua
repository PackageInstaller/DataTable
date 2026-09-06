-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/model/MainUIJumpMo.lua

module("logic.extensions.mainui.model.MainUIJumpMo", package.seeall)

local MainUIJumpMo = class("MainUIJumpMo")
local time = 1

function MainUIJumpMo:ctor(go)
	self.targetGo = go
end

function MainUIJumpMo:onInit()
	self:onReset()
end

function MainUIJumpMo:onReset()
	return
end

function MainUIJumpMo:setCfgData(cfg, parentPresentor, matType)
	self.cfg = cfg
	self.parentPresentor = parentPresentor
	self.firstShow = true
	self._matType = matType
end

function MainUIJumpMo:tryRmove(idx)
	if self.idx ~= idx then
		self:dispose()
	end
end

function MainUIJumpMo:setToX(x, idx)
	self.idx = idx

	self:clearTween()

	if self.firstShow then
		self.firstShow = false
		self.toX = x

		GameUtil.setAnchoredPos(self.targetGo, x, 0)
		GameUtil.setLocalScale(self.targetGo, 1, 1, 1)

		if string.nilorempty(self.cfg.viewName) then
			MaterialMgr.setCell(self._matType, self.cfg.id, self.targetGo)
		else
			ViewMgr.instance:openAt(self.targetGo, self.cfg.viewName, self.parentPresentor)
		end
	elseif math.abs(self.toX - x) > 1 then
		GameUtil.setAnchoredPos(self.targetGo, x, 0)
		GameUtil.setLocalScale(self.targetGo, 1, 1, 1)

		self.tween = TweenUtil.ValueTo(self.toX, x, time, function(val)
			self.toX = val

			GameUtil.setAnchoredPos(self.targetGo, val, 0)
		end, function()
			self.tween = nil
		end, self, DG.Tweening.Ease.OutBounce)
	else
		GameUtil.setAnchoredPos(self.targetGo, x, 0)
	end
end

function MainUIJumpMo:clearTween()
	if self.tween then
		self.tween:Kill(false)
	end

	self.tween = nil
end

function MainUIJumpMo:dispose()
	self:clearTween()

	if string.nilorempty(self.cfg.viewName) then
		MaterialMgr.resetAll(self.targetGo)
	else
		ViewMgr.instance:close(self.cfg.viewName)
	end

	self.firstShow = true
end

return MainUIJumpMo
