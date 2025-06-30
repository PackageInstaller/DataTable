-- chunkname: @IQIGame\\UI\\Activity\\PicturePuzzle\\PicturePuzzleCell.lua

local m = {}

function m.New(view, index)
	local obj = Clone(m)

	obj:Init(view, index)

	return obj
end

function m:Init(view, index)
	self.View = view
	self.index = index

	LuaCodeInterface.BindOutlet(self.View, self)
	self:SetDefaultEffect()
end

function m:SetDefaultEffect()
	self.EffectRandom:SetActive(false)
	self.EffectUnlock:SetActive(false)
	self.EffectRowUnlock:SetActive(false)
	self.EffectColumnUnlock:SetActive(false)
end

function m:UpdateState(isOpen)
	self.ImgBg:SetActive(not isOpen)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
