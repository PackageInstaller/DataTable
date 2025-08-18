-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\RedDot.lua

local RedDotMgr = require("UI/RedDotManager")
local strClassName = "RedDot"
local RedDot = Class(strClassName, UIControls.Panel)

function RedDot:ctor(parent, path, textPath)
	if textPath ~= nil then
		local p = textPath

		if path ~= "" then
			p = path .. "/" .. p
		end

		self.text = Label(parent, p)
	end

	self._rdKeys = {}
	self._rdID = RedDotMgr.registRedDot(self.mRoot.id, self)
end

function RedDot:addHint(rdKeys)
	for i, key in ipairs(rdKeys) do
		if self._rdKeys[key] == nil then
			self._rdKeys[key] = true

			RedDotMgr.addDotInfo(self._rdID, key)
		end
	end

	self:updateHintState()
end

function RedDot:delHint(key)
	if self._rdKeys[key] then
		self._rdKeys[key] = nil

		RedDotMgr.delDotInfo(self._rdID, key)
	end

	if next(self._rdKeys) then
		self:updateHintState()
	else
		self:setVisible(false)
	end
end

function RedDot:clearHint()
	for key, _ in pairs(self._rdKeys) do
		RedDotMgr.delDotInfo(self._rdID, key)
	end

	self._rdKeys = {}

	self:setVisible(false)
end

function RedDot:updateHintState()
	if self.text then
		local v = RedDotMgr.getStateCnt(self._rdKeys)

		self.text:setText(v)
		self:setVisible(v > 0)
	else
		local state = RedDotMgr.getState(self._rdKeys)

		self:setVisible(state)
	end
end

function RedDot:getHintState(...)
	return RedDotMgr.getState(self._rdKeys)
end

return RedDot
